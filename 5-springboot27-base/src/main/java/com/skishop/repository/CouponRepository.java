package com.skishop.repository;

import com.skishop.model.entity.Coupon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface CouponRepository extends JpaRepository<Coupon, String> {

    Optional<Coupon> findByCode(String code);

    @Query("SELECT c FROM Coupon c WHERE c.isActive = true AND " +
           "(c.expiresAt IS NULL OR c.expiresAt > :now)")
    List<Coupon> findActiveCoupons(@Param("now") LocalDateTime now);

    List<Coupon> findByIsActiveTrue();
}
