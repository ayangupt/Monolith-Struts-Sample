package com.skishop.service;

import com.skishop.model.entity.Cart;

import java.math.BigDecimal;

public interface CartService {

    Cart getOrCreateCart(String userId, String sessionId);

    Cart addItem(String cartId, String productId, int quantity);

    Cart updateItemQuantity(String cartId, String productId, int quantity);

    Cart removeItem(String cartId, String productId);

    void clearCart(String cartId);

    BigDecimal calculateTotal(Cart cart);

    Cart mergeGuestCartToUserCart(String sessionId, String userId);
}
