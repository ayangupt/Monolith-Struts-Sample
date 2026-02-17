package com.skishop.service;

import com.skishop.model.entity.Coupon;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface CouponService {

    List<Coupon> getAvailableCoupons();

    Optional<Coupon> findByCode(String code);

    BigDecimal calculateDiscount(Coupon coupon, BigDecimal subtotal);

    boolean validateCoupon(String code, BigDecimal subtotal);

    void useCoupon(String couponId, String userId, String orderId, BigDecimal discountApplied);

    // Admin operations
    Coupon save(Coupon coupon);

    void deactivate(String couponId);
}
