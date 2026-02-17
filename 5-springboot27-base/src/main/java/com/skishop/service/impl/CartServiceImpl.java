package com.skishop.service.impl;

import com.skishop.model.entity.Cart;
import com.skishop.model.entity.CartItem;
import com.skishop.model.entity.Product;
import com.skishop.repository.CartRepository;
import com.skishop.repository.ProductRepository;
import com.skishop.service.CartService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class CartServiceImpl implements CartService {

    private static final Logger logger = LoggerFactory.getLogger(CartServiceImpl.class);

    private final CartRepository cartRepository;
    private final ProductRepository productRepository;

    public CartServiceImpl(CartRepository cartRepository, ProductRepository productRepository) {
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
    }

    @Override
    public Cart getOrCreateCart(String userId, String sessionId) {
        Optional<Cart> existingCart;

        if (userId != null) {
            existingCart = cartRepository.findActiveCartByUserId(userId);
        } else {
            existingCart = cartRepository.findActiveCartBySessionId(sessionId);
        }

        if (existingCart.isPresent()) {
            return existingCart.get();
        }

        Cart cart = new Cart();
        cart.setId(UUID.randomUUID().toString());
        cart.setUserId(userId);
        cart.setSessionId(sessionId);
        cart.setStatus("ACTIVE");

        return cartRepository.save(cart);
    }

    @Override
    public Cart addItem(String cartId, String productId, int quantity) {
        Cart cart = cartRepository.findById(cartId)
            .orElseThrow(() -> new IllegalArgumentException("Cart not found"));

        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new IllegalArgumentException("Product not found"));

        // Check if item already exists in cart
        Optional<CartItem> existingItem = cart.getItems().stream()
            .filter(item -> item.getProductId().equals(productId))
            .findFirst();

        if (existingItem.isPresent()) {
            CartItem item = existingItem.get();
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            CartItem newItem = new CartItem();
            newItem.setId(UUID.randomUUID().toString());
            newItem.setProductId(productId);
            newItem.setQuantity(quantity);
            newItem.setUnitPrice(product.getEffectivePrice());
            cart.addItem(newItem);
        }

        logger.info("Added {} x {} to cart {}", quantity, productId, cartId);
        return cartRepository.save(cart);
    }

    @Override
    public Cart updateItemQuantity(String cartId, String productId, int quantity) {
        Cart cart = cartRepository.findById(cartId)
            .orElseThrow(() -> new IllegalArgumentException("Cart not found"));

        cart.getItems().stream()
            .filter(item -> item.getProductId().equals(productId))
            .findFirst()
            .ifPresent(item -> {
                if (quantity <= 0) {
                    cart.removeItem(item);
                } else {
                    item.setQuantity(quantity);
                }
            });

        return cartRepository.save(cart);
    }

    @Override
    public Cart removeItem(String cartId, String productId) {
        Cart cart = cartRepository.findById(cartId)
            .orElseThrow(() -> new IllegalArgumentException("Cart not found"));

        cart.getItems().removeIf(item -> item.getProductId().equals(productId));
        logger.info("Removed {} from cart {}", productId, cartId);

        return cartRepository.save(cart);
    }

    @Override
    public void clearCart(String cartId) {
        Cart cart = cartRepository.findById(cartId)
            .orElseThrow(() -> new IllegalArgumentException("Cart not found"));

        cart.getItems().clear();
        cart.setStatus("COMPLETED");
        cartRepository.save(cart);
        logger.info("Cart {} cleared", cartId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal calculateTotal(Cart cart) {
        return cart.getItems().stream()
            .map(CartItem::getSubtotal)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public Cart mergeGuestCartToUserCart(String sessionId, String userId) {
        Optional<Cart> guestCart = cartRepository.findActiveCartBySessionId(sessionId);
        Optional<Cart> userCart = cartRepository.findActiveCartByUserId(userId);

        if (!guestCart.isPresent()) {
            return userCart.orElse(null);
        }

        Cart guest = guestCart.get();

        if (!userCart.isPresent()) {
            guest.setUserId(userId);
            guest.setSessionId(null);
            return cartRepository.save(guest);
        }

        Cart user = userCart.get();
        for (CartItem guestItem : guest.getItems()) {
            Optional<CartItem> existingItem = user.getItems().stream()
                .filter(item -> item.getProductId().equals(guestItem.getProductId()))
                .findFirst();

            if (existingItem.isPresent()) {
                existingItem.get().setQuantity(
                    existingItem.get().getQuantity() + guestItem.getQuantity()
                );
            } else {
                CartItem newItem = new CartItem();
                newItem.setId(UUID.randomUUID().toString());
                newItem.setProductId(guestItem.getProductId());
                newItem.setQuantity(guestItem.getQuantity());
                newItem.setUnitPrice(guestItem.getUnitPrice());
                user.addItem(newItem);
            }
        }

        guest.setStatus("MERGED");
        cartRepository.save(guest);

        logger.info("Merged guest cart {} into user cart {}", guest.getId(), user.getId());
        return cartRepository.save(user);
    }
}
