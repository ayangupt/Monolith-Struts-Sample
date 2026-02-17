package com.skishop.service.impl;

import com.skishop.model.entity.Product;
import com.skishop.repository.ProductRepository;
import com.skishop.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    private static final Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);

    private final ProductRepository productRepository;

    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> getAllActiveProducts() {
        return productRepository.findByStatus("ACTIVE");
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Product> findById(String id) {
        return productRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Product> searchProducts(String categoryId, String keyword, String sort, Pageable pageable) {
        Sort sorting = Sort.unsorted();
        if (sort != null) {
            switch (sort) {
                case "priceAsc":
                    sorting = Sort.by("regularPrice").ascending();
                    break;
                case "priceDesc":
                    sorting = Sort.by("regularPrice").descending();
                    break;
                case "newest":
                    sorting = Sort.by("createdAt").descending();
                    break;
            }
        }

        Pageable sortedPageable = PageRequest.of(
            pageable.getPageNumber(),
            pageable.getPageSize(),
            sorting
        );

        return productRepository.searchProducts(
            categoryId != null && !categoryId.isEmpty() ? categoryId : null,
            keyword != null && !keyword.isEmpty() ? keyword : null,
            sortedPageable
        );
    }

    @Override
    public Product save(Product product) {
        logger.info("Saving product: {}", product.getName());
        return productRepository.save(product);
    }

    @Override
    public void delete(String id) {
        logger.info("Deleting product: {}", id);
        productRepository.findById(id).ifPresent(product -> {
            product.setStatus("DELETED");
            productRepository.save(product);
        });
    }
}
