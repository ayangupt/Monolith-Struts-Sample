package com.skishop.service;

import com.skishop.model.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface ProductService {

    List<Product> getAllActiveProducts();

    Optional<Product> findById(String id);

    Page<Product> searchProducts(String categoryId, String keyword, String sort, Pageable pageable);

    Product save(Product product);

    void delete(String id);
}
