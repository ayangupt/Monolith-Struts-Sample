package com.skishop.controller;

import com.skishop.dto.AddToCartRequest;
import com.skishop.model.entity.Cart;
import com.skishop.service.CartService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.math.BigDecimal;

@Controller
public class CartController {

    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping("/cart")
    public String viewCart(Authentication auth, HttpSession session, Model model) {
        String userId = auth != null ? auth.getName() : null;
        String sessionId = session.getId();

        Cart cart = cartService.getOrCreateCart(userId, sessionId);
        BigDecimal total = cartService.calculateTotal(cart);

        model.addAttribute("cart", cart);
        model.addAttribute("cartTotal", total);
        model.addAttribute("addCartForm", new AddToCartRequest());

        return "cart/view";
    }

    @PostMapping("/cart/add")
    public String addToCart(@Valid AddToCartRequest request,
                           Authentication auth,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        String userId = auth != null ? auth.getName() : null;
        String sessionId = session.getId();

        Cart cart = cartService.getOrCreateCart(userId, sessionId);
        cartService.addItem(cart.getId(), request.getProductId(), request.getQuantity());

        redirectAttributes.addFlashAttribute("message", "Item added to cart");
        return "redirect:/cart";
    }

    @PostMapping("/cart/update")
    public String updateCartItem(@RequestParam String productId,
                                @RequestParam int quantity,
                                Authentication auth,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        String userId = auth != null ? auth.getName() : null;
        String sessionId = session.getId();

        Cart cart = cartService.getOrCreateCart(userId, sessionId);
        cartService.updateItemQuantity(cart.getId(), productId, quantity);

        redirectAttributes.addFlashAttribute("message", "Cart updated");
        return "redirect:/cart";
    }

    @PostMapping("/cart/remove")
    public String removeFromCart(@RequestParam String productId,
                                Authentication auth,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        String userId = auth != null ? auth.getName() : null;
        String sessionId = session.getId();

        Cart cart = cartService.getOrCreateCart(userId, sessionId);
        cartService.removeItem(cart.getId(), productId);

        redirectAttributes.addFlashAttribute("message", "Item removed from cart");
        return "redirect:/cart";
    }
}
