package com.skishop.service;

import com.skishop.dto.CheckoutRequest;
import com.skishop.model.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface OrderService {

    Order createOrder(String userId, String cartId, CheckoutRequest request);

    Optional<Order> findById(String id);

    Optional<Order> findByIdAndUserId(String id, String userId);

    Page<Order> getOrderHistory(String userId, Pageable pageable);

    Order cancelOrder(String orderId, String userId);

    Order updateStatus(String orderId, String status);

    // Admin operations
    Page<Order> getAllOrders(String status, Pageable pageable);
}
