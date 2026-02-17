package com.skishop.controller;

import com.skishop.model.entity.Category;
import com.skishop.model.entity.Product;
import com.skishop.repository.CategoryRepository;
import com.skishop.service.ProductService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProductController {

    private final ProductService productService;
    private final CategoryRepository categoryRepository;

    public ProductController(ProductService productService, CategoryRepository categoryRepository) {
        this.productService = productService;
        this.categoryRepository = categoryRepository;
    }

    @GetMapping("/products")
    public String listProducts(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String categoryId,
            @RequestParam(required = false) String sort,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Model model) {

        Page<Product> productPage = productService.searchProducts(
            categoryId, keyword, sort, PageRequest.of(page, size)
        );

        List<Category> categories = categoryRepository.findAll();

        model.addAttribute("productList", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("categoryOptions", categories);
        model.addAttribute("keyword", keyword);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("sort", sort);

        return "products/list";
    }

    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable String id, Model model) {
        return productService.findById(id)
            .map(product -> {
                model.addAttribute("product", product);
                return "products/detail";
            })
            .orElse("products/notfound");
    }
}
