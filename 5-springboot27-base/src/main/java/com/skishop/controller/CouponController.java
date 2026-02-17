package com.skishop.controller;

import com.skishop.model.entity.Coupon;
import com.skishop.repository.CouponRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class CouponController {

    private final CouponRepository couponRepository;

    public CouponController(CouponRepository couponRepository) {
        this.couponRepository = couponRepository;
    }

    @GetMapping("/coupons/available")
    public String availableCoupons(Model model) {
        List<Coupon> coupons = couponRepository.findActiveCoupons(LocalDateTime.now());
        model.addAttribute("coupons", coupons);
        return "coupons/available";
    }
}
