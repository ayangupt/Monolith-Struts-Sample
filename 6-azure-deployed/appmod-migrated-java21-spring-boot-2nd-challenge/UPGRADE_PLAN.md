# Spring Boot Migration Plan

## Migration Plan from Apache Struts 1.x to Spring Boot 3.x + Thymeleaf + Spring Data JPA

## Overview

### Progress (2026-01-22)

- [x] Phase0: Current state analysis (Action/JSP/DB pattern inventory)
- [x] Maven Wrapper introduction (3.9.6) / Java 21 support (`pom.xml` update)
- [x] Dockerfile: Temurin 21 + Tomcat 9.0 / Postgres 15
- [x] CI: GitHub Actions (Java 21 + ./mvnw)
- [x] Phase1: Spring Boot prototype added (`spring-boot-app/`)
    - Spring Boot 3.2.2 / Java 21 prototype created
- [x] Phase2: JPA implementation (all table entities/repositories/services, H2 tests green)
- [x] Phase3: REST controller/DTO complete, WebMvcTest setup, Thymeleaf template skeleton added
- [x] Phase4: Thymeleaf full implementation (JSP→Thymeleaf complete screen migration)
- [x] Phase5: Modern Java refactoring (`.toList()`/`Map.of`/`var` etc.)
- [x] Phase6: Configuration & exception handling (REST/UI exception handler separation, error pages added)
- [x] Phase7: Test expansion (UI/REST exception tests & integration tests added, all tests green)
- [x] Phase8: Monitoring/caching (Actuator+Prometheus, Spring Cache, HTTP cache performance verification)
- [x] Phase9: Documentation & operations preparation (operations/architecture docs, OpenAPI, monitoring procedures)
- [x] Phase10: Legacy cleanup (Boot Struts reference zero verification, docs/legacy.md, verification scripts, README/Docs update)

## Java 21 LTS Runtime Upgrade Plan (#generate_upgrade_plan)

### Progress Summary (Phase 0 / Phase 1 / Phase 2 / Phase 3 / Phase 4 / Phase 5 / Phase 6 / Phase 7 / Phase 8 / Phase 9 / Phase 10)

- Phase 0: ✅ Complete (Action/JSP/DAO inventory, JDK21/Maven/CI policy formulation, Docker/Tomcat9 plan formulation)
- Phase 1: ✅ Complete (Spring Boot 3.2.2 Java21 prototype `spring-boot-app/` created, package skeleton prepared)
- Phase 2: ✅ Complete (All table JPA entities/repositories/services implementation, H2 (PostgreSQL mode) tests green)
    - Note: JPA entities not using Record (due to lifecycle callbacks and mutable fields)
- Phase 3: ✅ Complete (REST controllers/DTOs/exception handlers, WebMvcTest setup, Thymeleaf layout & page skeleton created)
- Phase 4: ✅ Complete (Thymeleaf full implementation: UI controllers, templates, header/footer, styles, message resources, view tests added)
    - Results: `ViewController`, `AdminViewController`, `templates/**/*.html` fully implemented, `messages.properties`, `static/css/main.css`
    - Tests: `ViewControllerTest`, `AdminViewControllerTest` added, `CartControllerTest` updated
- Phase 5: ✅ Complete (Modern Java refactoring: `.toList()` applied, `Map.of`/`var` introduced, patterns checked)
- Phase 6: ✅ Complete (REST/UI exception handler separation, `error/404.html`/`error/500.html` added, error view/JSON support)
- Phase 7: ✅ Complete (UI/REST exception tests added, integration test `ProductIntegrationTest` added, all tests green)
- Phase 8: ✅ Complete (Actuator/Prometheus published, Spring Cache introduced, HTTP cache integration test & simple performance test added)
- Phase 9: ✅ Complete (Operations/architecture documentation added, OpenAPI introduced, monitoring procedures/endpoints organized)
- Phase 10: ✅ Complete (Boot Struts reference zero verified, docs/legacy.md archive guidelines, README/Docs updated)

### Deliverable Artifacts

- `docs/inventory/actions.txt` — Struts Action list
- `docs/inventory/jsp.txt` — JSP list
- `docs/inventory/dao.txt` — JDBC PreparedStatement usage locations
- `spring-boot-app/` — Spring Boot project (Java 21, Boot 3.2.2)
    - `model/entity/*` — **All tables** (roles, users, security_logs, categories, products, prices, inventory, carts, cart_items, payments, orders, order_items, shipments, returns, order_shipping, point_accounts, point_transactions, campaigns, coupons, coupon_usage, user_addresses, password_reset_tokens, shipping_methods, email_queue)
    - `repository/*Repository.java` — Spring Data JPA repositories for each entity
    - `service/*Service.java` — Service implementations for each entity
    - `controller/*Controller.java` — REST controllers (product/cart/order/point/user/address/coupon/return/Admin)
    - `dto/*Request|*Response.java` — API DTO groups
    - `exception/GlobalExceptionHandler.java` — Exception handler
    - `src/test/java/com/skishop/repository/ProductRepositoryTest.java`
    - `src/test/java/com/skishop/service/ProductServiceTest.java`
    - `src/test/java/com/skishop/integration/ActuatorIntegrationTest.java`
    - `src/test/java/com/skishop/integration/ProductCachingHttpTest.java`
    - `src/test/java/com/skishop/integration/OpenApiIntegrationTest.java`
    - `src/test/java/com/skishop/SpringContextLoadsTest.java`
    - `src/test/java/com/skishop/controller/ProductControllerTest.java`
    - `src/test/java/com/skishop/controller/CartControllerTest.java`
    - `application-test.yml` — H2 (PostgreSQL mode) configuration
    - `src/main/java/com/skishop/config/OpenApiConfig.java`
    - `docs/operations.md`
    - `docs/architecture.md`
    - `docs/legacy.md`
    - `scripts/verify-no-struts.sh`
    - No Lombok dependency (explicit getter/setter, public no-arg ctor in all entities)
    - `Product` `@PrePersist` sets `createdAt`/`updatedAt` to handle NOT NULL constraints

### ✅ Tests

```bash
./mvnw -f spring-boot-app/pom.xml -B test
```

- Success: 2026-01-22 17:06 JST (`TESTS_OK`)

### Background

- Current: **JDK 5 + Maven 2.2.1 + Tomcat 6** (using JDK1.5/Tomcat6 in Dockerfile)
- Goal: **JDK 21 + Maven 3.9.x + Tomcat 9(javax)** operation, facilitating subsequent Spring Boot 3 migration

### Policy

1. **Build tool modernization**: Introduce Maven Wrapper, standardize Maven 3.9.x+, JDK 21
2. **Compile compatibility**: Update `maven-compiler-plugin` to 3.11+ and raise `source/target` to **8+** (recommended 17/21)
3. **App server**: Adopt **Tomcat 9.0.x (javax version)** (avoid Tomcat 10+ due to jakarta.* incompatibility)
4. **Container**: Replace with multi-stage build based on `eclipse-temurin:21`
5. **CI**: Setup JDK 21 in GitHub Actions etc. and run tests

### Steps

1. **Introduce JDK 21 / Maven 3.9.x**
     - Set `JAVA_HOME` to JDK 21 locally / in CI
     - Add Maven Wrapper: `mvn -N io.takari:maven:0.7.7:wrapper -Dmaven=3.9.6`
2. **Update pom.xml**
     - Change `maven.compiler.source` / `target` to **8** (or **21**)
     - Plugin update example: (see above XML)
     - Test: Run `mvn -DskipTests=false test` with JDK 21
3. **Minimum dependency updates** (compatibility improvement)
     - PostgreSQL JDBC: `42.7.4`
     - commons-fileupload: `1.5`
     - junit: `4.13.2` (JUnit5 migration follows)
     - log4j: 1.x is EOL. Consider short-term migration to SLF4J + Logback
4. **Update Dockerfile**
     - Base: `eclipse-temurin:21-jdk` (build) / `eclipse-temurin:21-jre` (runtime)
     - Tomcat: Use javax-compatible tag like `tomcat:9.0-jre17-temurin` (adopt JRE21 version if available)
     - `COPY target/*.war /usr/local/tomcat/webapps/ROOT.war`
5. **Local operation verification**
     - `mvn clean package`
     - `docker build -t skishop:java21 .`
     - `docker run -p 8080:8080 skishop:java21`
     - Manual verification of main screens / functions
6. **CI/CD setup** (GitHub Actions example) - (see above YAML)

### Verification Checklist

- [ ] `mvn clean verify` succeeds with JDK 21
- [ ] `docker run` starts Tomcat 9 + WAR
- [ ] Main screens, forms, DB access, mail sending work
- [ ] No dependency library warnings (illegal access etc.)
- [ ] No reflection access warnings in logs, or suppressed with `--add-opens`

### Risks and Mitigation

| Risk | Description | Mitigation |
| --- | --- | --- |
| jakarta migration issue | Tomcat 10+ uses jakarta.* incompatible with Struts1 | Use **Tomcat 9** |
| Old JDBC driver | Unverified with Java 21 | Update PostgreSQL JDBC to 42.7.4 |
| log4j 1.x vulnerabilities | EOL, many CVEs | Phased migration to SLF4J + Logback |
| Build compatibility | `--release` 5 not possible | Raise `source/target` to 8+ |

### Reference Commands

```bash
# Add Maven Wrapper
mvn -N io.takari:maven:0.7.7:wrapper -Dmaven=3.9.6

# Build
./mvnw -B clean package

# Docker build/start
docker build -t skishop:java21 .
docker run --rm -p 8080:8080 skishop:java21
```

This project uses the legacy Apache Struts 1.3.10 Java application targeting Java 1.5. This document outlines a complete migration plan to **Java 21 + Spring Boot 3.2.x + Thymeleaf + Spring Data JPA**.

## Current State

### Java Version

- **Current**: Java 1.5 (Released 2004, End of Support)
- **Target**: Java 21 LTS (Released September 2023, LTS support until September 2031)

### Framework

- **Current**: Apache Struts 1.3.10 (Released 2008, EOL, multiple known vulnerabilities)
- **Target**: Spring Boot 3.2.x (Latest stable version, long-term support)

### Current Dependency Versions

| Category | Library | Current Version | Latest LTS Version | Notes |
| --- | --- | --- | --- | --- |
| **Framework** | | | | |
| | Apache Struts Core | 1.3.10 | N/A | EOL, migration recommended |
| | Apache Struts Taglib | 1.3.10 | N/A | EOL, migration recommended |
| | Apache Struts Tiles | 1.3.10 | N/A | EOL, migration recommended |
| | Apache Struts Extras | 1.3.10 | N/A | EOL, migration recommended |
| **Database Connection** | | | | |
| | commons-dbcp | 1.2.2 | 2.12.0 | Migration to DBCP2 recommended |
| | commons-pool | 1.2 | 2.12.0 | Migration to Pool2 recommended |
| | commons-dbutils | 1.1 | 1.8.1 | Upgrade possible |
| | PostgreSQL JDBC | 9.2-1004-jdbc3 | 42.7.4 | Major upgrade |
| **File Upload** | | | | |
| | commons-fileupload | 1.3.3 | 1.5 | Security fixes available |
| **Logging** | | | | |
| | log4j | 1.2.17 | N/A | Migration to Log4j2 2.23.1 recommended |
| **Mail** | | | | |
| | javax.mail | 1.4.7 | Jakarta Mail 2.1.3 | Migrate to Jakarta EE |
| **View Template/Web** | | | | |
| | jsp-api | 2.1 | Thymeleaf 3.1.x | Migrate from JSP to Thymeleaf |
| | servlet-api | 2.5 | Spring Boot embedded (Tomcat 10.1.x) | Included in Spring Boot Starter |
| | - | - | Spring Web MVC 6.1.x | RESTful Web Service support |
| **Testing** | | | | |
| | JUnit | 4.12 | JUnit 5.10.2 | Migrate to JUnit Jupiter |
| | H2 Database | 1.3.176 | 2.2.224 | For testing |
| | StrutsTestCase | 2.1.4-1.2-2.4 | N/A | Struts dependent, consider removal |

### Current Status Assessment (Issue Summary)

| Item | Current Status | Issues |
| --- | --- | --- |
| Java | 1.5 | EOL, incompatible with latest libraries |
| Framework | Struts 1.3.10 | EOL, multiple vulnerabilities |
| Template | JSP + Struts Taglib | Outdated, low maintainability |
| Data Access | JDBC + Commons DBUtils | Much boilerplate, manual Tx management |
| Connection Pool | Commons DBCP 1.x | No DBCP2/HikariCP support, performance/stability issues |
| Logging | Log4j 1.2.17 | EOL, migration to Logback/SLF4J required |
| Testing | JUnit 4 + StrutsTestCase | Migration to JUnit 5/Spring Test required |

## Migration Strategy

### Reasons to Choose Spring Boot

**Apache Struts 1.x reached EOL in 2013 and has numerous known vulnerabilities.** Partial dependency upgrades will not solve fundamental problems.

#### Reasons to Recommend Complete Migration to Spring Boot 3.2.x

1. **Security**: Continuous security updates and support
2. **Community**: Largest Java community with abundant documentation
3. **Modern Technology**: Ability to leverage all Java 21 features
4. **Productivity**: Fast development with auto-configuration, embedded servers, and development tools
5. **Future-proofing**: Clear migration path to microservices and cloud-native
6. **Ecosystem**: Rich Spring Boot starters and integration support

### Target Technology Stack

| Component | Struts 1.x | Spring Boot 3.2.x |
| --- | --- | --- |
| **Framework** | Apache Struts 1.3.10 | Spring Boot 3.2.x + Spring MVC 6.1.x |
| **Java Version** | Java 1.5 | Java 21 LTS |
| **View Template** | JSP + Struts Taglib | Thymeleaf 3.1.x |
| **Data Access** | JDBC + Commons DBUtils | Spring Data JPA 3.2.x + Hibernate 6.4.x |
| **Connection Pool** | Commons DBCP 1.x | HikariCP (Spring Boot default) |
| **Validation** | Commons Validator | Bean Validation 3.0 (Hibernate Validator) |
| **Logging** | Log4j 1.2.17 | Logback (Spring Boot default) + SLF4J |
| **Dependency Injection** | None | Spring IoC Container |
| **Testing** | JUnit 4 + StrutsTestCase | JUnit 5 + Spring Boot Test |
| **Build Tool** | Maven 2.x series | Maven 3.9.x |
| **Application Server** | Tomcat 6/7 (external) | Embedded Tomcat 10.1.x |

## Struts 1.x and Spring Boot Correspondence

### Architecture Correspondence

| Struts 1.x Component | Spring Boot Equivalent | Description |
| --- | --- | --- |
| **Action** | `@Controller` + `@RequestMapping` | Request processing |
| **ActionForm** | `@ModelAttribute` + Bean Validation | Form data binding |
| **struts-config.xml** | Java Config (`@Configuration`) | Application configuration |
| **ActionForward** | `ModelAndView` / `return "viewName"` | View navigation |
| **ActionMapping** | `@RequestMapping` / `@GetMapping` / `@PostMapping` | URL mapping |
| **ActionServlet** | `DispatcherServlet` (auto-configured) | Front controller |
| **JSP + Struts Tags** | Thymeleaf templates | View rendering |
| **Validator Framework** | Bean Validation + `@Valid` | Input validation |
| **MessageResources** | `MessageSource` + `messages.properties` | Internationalization |
| **DAO (Manual JDBC)** | Spring Data JPA Repository | Data Access |
| **DataSource (DBCP)** | HikariCP (Auto-configured) | Connection Pool |

## Step-by-step Migration Plan

### Phase 0: Preparation Phase (1 week) Now it is doing this Phase 0

#### Task Details

1. **Current State Analysis**
   - Create list of all Action classes
   - Create list of all JSP pages
   - Investigate database access patterns
   - Verify external library dependencies

2. **Environment Setup**
   - Install JDK 21
   - Prepare IDE (IntelliJ IDEA / Eclipse)
   - Determine Git branch strategy (e.g., `feature/spring-boot-migration`)

3. **Create Spring Boot Project**
   - Generate basic project with Spring Initializr
   - Add necessary dependencies

#### Spring Initializr Configuration

```text
Project: Maven
Language: Java
Spring Boot: 3.2.x (latest stable version)
Java: 21
Packaging: War (for compatibility with existing WAR deployment, can be changed to Jar later)

Dependencies:
- Spring Web
- Thymeleaf
- Spring Data JPA
- PostgreSQL Driver
- Validation
- Spring Boot DevTools
- Lombok (optional, reduces boilerplate code)
- Spring Boot Actuator (optional, for monitoring)
```

#### Example Generated pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.2</version>
        <relativePath/>
    </parent>
    
    <groupId>com.skishop</groupId>
    <artifactId>skishop-app</artifactId>
    <version>2.0.0</version>
    <packaging>war</packaging>
    <name>SkiShop Application</name>
    
    <properties>
        <java.version>21</java.version>
    </properties>
    
    <dependencies>
        <!-- Spring Boot Web (includes Spring MVC) -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        
        <!-- Thymeleaf Template Engine -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
        
        <!-- Spring Data JPA -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        
        <!-- Bean Validation -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        
        <!-- PostgreSQL Driver -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        
        <!-- Development Tools (hot reload, etc.) -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>
        
        <!-- Lombok (optional) -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        
        <!-- Mail Sending -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-mail</artifactId>
        </dependency>
        
        <!-- Testing -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        
        <!-- H2 Database (for testing) -->
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

### Phase 1: Project Structure and Application Entry Point Creation (1 week)

#### Create Spring Boot Main Class

```java
package com.skishop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class SkiShopApplication extends SpringBootServletInitializer {
    
    public static void main(String[] args) {
        SpringApplication.run(SkiShopApplication.class, args);
    }
}
```

#### application.yml Configuration

```yaml
spring:
  application:
    name: skishop-app
  
  # DataSource Configuration
  datasource:
    url: jdbc:postgresql://localhost:5432/skishop
    username: ${DB_USERNAME:postgres}
    password: ${DB_PASSWORD:password}
    driver-class-name: org.postgresql.Driver
    hikari:
      maximum-pool-size: 10
      minimum-idle: 5
      connection-timeout: 30000
  
  # JPA Configuration
  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: true
    properties:
      hibernate:
        format_sql: true
        dialect: org.hibernate.dialect.PostgreSQLDialect
  
  # Thymeleaf Configuration
  thymeleaf:
    cache: false  # false for development
    prefix: classpath:/templates/
    suffix: .html
    mode: HTML
  
  # Mail Configuration
  mail:
    host: ${MAIL_HOST:smtp.example.com}
    port: ${MAIL_PORT:587}
    username: ${MAIL_USERNAME}
    password: ${MAIL_PASSWORD}
    properties:
      mail:
        smtp:
          auth: true
          starttls:
            enable: true

# Logging Configuration
logging:
  level:
    com.skishop: DEBUG
    org.springframework: INFO
    org.hibernate.SQL: DEBUG
```

#### Package Structure Creation

```text
src/main/java/com/skishop/
├── SkiShopApplication.java
├── config/              # Configuration classes
│   ├── WebConfig.java
│   └── SecurityConfig.java (as needed)
├── controller/          # Struts Action → Controller
├── model/              # Entity classes
│   └── entity/
├── repository/         # Spring Data JPA repositories
├── service/            # Business logic
│   └── impl/
├── dto/                # Data Transfer Objects
└── exception/          # Exception handling

src/main/resources/
├── application.yml
├── messages.properties
├── templates/          # Thymeleaf templates
│   ├── fragments/      # Common components
│   ├── layout/         # Layouts
│   └── pages/          # Pages
└── static/
    ├── css/
    ├── js/
    └── images/
```

### Phase 2: Data Access Layer Migration (2 weeks)

#### Example JPA Entity Class Creation

```java
package com.skishop.model.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "products")
@Data
public class Product {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Product name is required")
    @Column(nullable = false, length = 100)
    private String name;
    
    @Column(length = 500)
    private String description;
    
    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;
    
    @Min(value = 0, message = "Stock quantity must be 0 or greater")
    @Column(nullable = false)
    private Integer stockQuantity;
    
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
```

#### Create Spring Data JPA Repository

```java
package com.skishop.repository;

import com.skishop.model.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    
    // Auto-generate query from method name
    List<Product> findByNameContaining(String keyword);
    
    List<Product> findByPriceBetween(BigDecimal minPrice, BigDecimal maxPrice);
    
    Optional<Product> findByName(String name);
    
    // Custom query
    @Query("SELECT p FROM Product p WHERE p.stockQuantity > 0 ORDER BY p.createdAt DESC")
    List<Product> findAvailableProducts();
    
    @Query("SELECT p FROM Product p WHERE p.name LIKE %:keyword% OR p.description LIKE %:keyword%")
    List<Product> searchProducts(@Param("keyword") String keyword);
}
```

#### Create Service Layer

```java
package com.skishop.service.impl;

import com.skishop.model.entity.Product;
import com.skishop.repository.ProductRepository;
import com.skishop.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class ProductServiceImpl implements ProductService {
    
    private final ProductRepository productRepository;
    
    @Override
    public List<Product> getAllProducts() {
        log.debug("Fetching all products");
        return productRepository.findAll();
    }
    
    @Override
    public Optional<Product> getProductById(Long id) {
        log.debug("Fetching product by id: {}", id);
        return productRepository.findById(id);
    }
    
    @Override
    @Transactional
    public Product saveProduct(Product product) {
        log.info("Saving product: {}", product.getName());
        return productRepository.save(product);
    }
    
    @Override
    @Transactional
    public void deleteProduct(Long id) {
        log.info("Deleting product with id: {}", id);
        productRepository.deleteById(id);
    }
}
```

### Phase 3: Controller Layer Migration (3 weeks)

#### Migration from Struts Action to Spring MVC Controller

**Spring Boot Controller Example:**

```java
package com.skishop.controller;

import com.skishop.dto.ProductFormDTO;
import com.skishop.model.entity.Product;
import com.skishop.service.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/products")
@RequiredArgsConstructor
@Slf4j
public class ProductController {
    
    private final ProductService productService;
    
    @GetMapping
    public String listProducts(Model model) {
        log.debug("Displaying product list");
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "products/list";
    }
    
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("productForm", new ProductFormDTO());
        return "products/form";
    }
    
    @PostMapping
    public String createProduct(@Valid @ModelAttribute("productForm") ProductFormDTO form,
                               BindingResult bindingResult,
                               RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "products/form";
        }
        
        Product product = new Product();
        product.setName(form.getName());
        product.setDescription(form.getDescription());
        product.setPrice(form.getPrice());
        product.setStockQuantity(form.getStockQuantity());
        
        productService.saveProduct(product);
        
        redirectAttributes.addFlashAttribute("message", "Product has been registered");
        return "redirect:/products";
    }
}
```

#### Create DTO

```java
package com.skishop.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class ProductFormDTO {
    
    private Long id;
    
    @NotBlank(message = "Product name is required")
    @Size(max = 100, message = "Product name must be 100 characters or less")
    private String name;
    
    @Size(max = 500, message = "Description must be 500 characters or less")
    private String description;
    
    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.01", message = "Price must be greater than 0")
    private BigDecimal price;
    
    @NotNull(message = "Stock quantity is required")
    @Min(value = 0, message = "Stock quantity must be 0 or greater")
    private Integer stockQuantity;
}
```

### Phase 4: View Layer Migration (JSP → Thymeleaf) (3 weeks)

#### Thymeleaf Template Example (Product List)

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" th:replace="~{layout/main :: layout(~{::title}, ~{::content})}">
<head>
    <title th:text="#{products.list.title}">Product List</title>
</head>
<body>
    <div th:fragment="content">
        <h1 th:text="#{products.list.header}">Product List</h1>
        
        <div class="alert alert-success" th:if="${message}" th:text="${message}"></div>
        
        <table class="table">
            <thead>
                <tr>
                    <th th:text="#{product.name}">Product Name</th>
                    <th th:text="#{product.price}">Price</th>
                    <th th:text="#{product.stock}">Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr th:each="product : ${products}">
                    <td th:text="${product.name}">Product Name</td>
                    <td th:text="${#numbers.formatCurrency(product.price)}">$1,000</td>
                    <td th:text="${product.stockQuantity}">10</td>
                    <td>
                        <a th:href="@{/products/{id}/edit(id=${product.id})}" class="btn btn-sm btn-primary">Edit</a>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <a th:href="@{/products/new}" class="btn btn-primary">New Registration</a>
    </div>
</body>
</html>
```

#### Struts Taglib and Thymeleaf Correspondence Table

| Struts 1.x Tag | Thymeleaf Equivalent | Description |
| --- | --- | --- |
| `<bean:write name="var"/>` | `th:text="${var}"` | Variable output |
| `<bean:message key="key"/>` | `th:text="#{key}"` | Message resources |
| `<html:link action="/path">` | `th:href="@{/path}"` | Link |
| `<html:form action="/submit">` | `th:action="@{/submit}" method="post"` | Form |
| `<html:text property="name"/>` | `th:field="*{name}"` | Text input |
| `<html:errors property="name"/>` | `th:errors="*{name}"` | Validation errors |
| `<logic:iterate id="item" name="list">` | `th:each="item : ${list}"` | Loop |
| `<logic:present name="var">` | `th:if="${var != null}"` | Existence check |
| `<logic:notPresent name="var">` | `th:if="${var == null}"` | Non-existence check |
| `<logic:equal name="var" value="val">` | `th:if="${var == 'val'}"` | Value comparison |

### Phase 5: Modern Java Refactoring (1 week)

#### Purpose

- Modernize Java 5-era code styles and APIs to Java 21 modern practices, improving readability, safety, and performance.

#### Checkpoints

| Item | Before Example | After Example | Notes |
| --- | --- | --- | --- |
| Resource release | `try { ... } finally { close(); }` | `try (var in = ...) { ... }` | try-with-resources |
| Type inference | `Map<String, List<String>> map = new HashMap<String, List<String>>();` | `var map = new HashMap<String, List<String>>();` | diamond + var |
| instanceof | `if (obj instanceof Foo) { Foo f = (Foo) obj; }` | `if (obj instanceof Foo f) { ... }` | pattern matching |
| Strings | `"line1\nline2"` | `"""line1\nline2"""` | text blocks |
| Date/Time | `Date/Calendar` | `LocalDateTime/Instant` | java.time |
| Collections | `new ArrayList<>()` then add | `List.of(...)` | Immutable list |
| Collection factory | `new HashSet<>(); add...` | `Set.of(...) / Map.of(...)` | Immutable Set/Map |
| Map initialization | `if (!map.containsKey(k)) map.put(k, ...)` | `map.computeIfAbsent(k, ...)` | Java 8 |
| Loops | `for (String s : list) { ... }` | `list.stream().map(...).toList()` | Streams (as appropriate) |
| DTO | `class Foo { ... }` | `record Foo(...) {}` | DTO/Value Objects only |
| HTTP | `HttpURLConnection` | `HttpClient` | Java 11 |
| Concurrency | `ExecutorService` | `virtual threads (Threads.ofVirtual().factory())` | Consider |
| Lambda/Method references | `new Runnable(){ public void run(){...}}` | `Runnable r = () -> {...}` / `System.out::println` | Java 8 |
| Functional IF | Many custom IFs | `java.util.function.*` | Reuse and unify |
| switch syntax | `switch(x){case A: ... break;}` | `switch (x) { case A -> ...; default -> ...; }` | switch expressions |
| switch patterns | Type branching with `if/else` | `switch (obj) { case String s -> ... }` | Java 21 |
| Multi-catch | Multiple duplicate catches | `catch (IOException\|SQLException e)` | Java 7 |
| Numeric literals | `1000000` | `1_000_000` | Readability |
| Optional | `if (obj == null) ...` | `Optional.ofNullable(obj).ifPresent(...)` | Null safety |
| Stream extensions | `collect(Collectors.toList())` | `.toList()` | Java 16 |
| Stream extensions 2 | Procedural for loops | `stream().takeWhile(...).dropWhile(...)` | Java 9 |
| Optional extensions | `if (obj == null) ...` | `opt.ifPresentOrElse(...); opt.orElseThrow(); opt.stream()` | Java 9/10 |
| NIO.2 | `new File(...)` | `Path/Files.walk(...)` | Java 7 |
| CompletableFuture | `Future` + `get()` | `CompletableFuture.supplyAsync(...)` | Async processing |
| Sealed | Control with `abstract class` | `sealed interface Shape permits Circle, Square {}` | Java 17 |
| String utilities | `trim().isEmpty()` | `isBlank()/strip()/lines()/repeat()` | Java 11 |
| Random | `new Random()` | `ThreadLocalRandom.current()` / `RandomGenerator` | Thread-safe/reproducibility |
| finalize | `protected void finalize()` | `Cleaner` / try-with-resources | Java 9+ deprecated |
| Record patterns | `if (obj instanceof Point) { ... }` | `if (obj instanceof Point(int x, int y)) { ... }` | Java 21 |
| String templates | `"Hello " + name` | `STR."Hello ${name}"` | Java 21 (Preview) |

#### Implementation Steps

1. Detect candidates with static analysis (IDE inspections, SpotBugs, Checkstyle, SonarLint)
2. Apply IDE refactoring + auto-fixes (try-with-resources, diamond, var, pattern matching, text blocks)
3. Manual review (design decisions for java.time/Streams/Optional/records application)
4. Run all tests and verify performance

### Phase 6: Configuration and Other Migrations (1 week)

#### Exception Handling

```java
package com.skishop.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleResourceNotFound(ResourceNotFoundException ex, Model model) {
        log.error("Resource not found: {}", ex.getMessage());
        model.addAttribute("error", ex.getMessage());
        return "error/404";
    }
    
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleGeneralError(Exception ex, Model model) {
        log.error("Unexpected error occurred", ex);
        model.addAttribute("error", "An unexpected error occurred");
        return "error/500";
    }
}
```

### Phase 7: Test Creation (2 weeks)

#### Repository Test

```java
package com.skishop.repository;

import com.skishop.model.entity.Product;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.math.BigDecimal;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
class ProductRepositoryTest {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Test
    void testFindByNameContaining() {
        // Given
        Product product = new Product();
        product.setName("Ski Boots");
        product.setPrice(BigDecimal.valueOf(200.00));
        product.setStockQuantity(10);
        productRepository.save(product);
        
        // When
        List<Product> found = productRepository.findByNameContaining("Ski");
        
        // Then
        assertThat(found).hasSize(1);
        assertThat(found.get(0).getName()).isEqualTo("Ski Boots");
    }
}
```

#### Service Test

```java
package com.skishop.service;

import com.skishop.model.entity.Product;
import com.skishop.repository.ProductRepository;
import com.skishop.service.impl.ProductServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ProductServiceImplTest {
    
    @Mock
    private ProductRepository productRepository;
    
    @InjectMocks
    private ProductServiceImpl productService;
    
    private Product testProduct;
    
    @BeforeEach
    void setUp() {
        testProduct = new Product();
        testProduct.setId(1L);
        testProduct.setName("Test Product");
        testProduct.setPrice(BigDecimal.valueOf(100.00));
        testProduct.setStockQuantity(5);
    }
    
    @Test
    void getAllProducts_ShouldReturnAllProducts() {
        // Given
        when(productRepository.findAll()).thenReturn(Arrays.asList(testProduct));
        
        // When
        List<Product> products = productService.getAllProducts();
        
        // Then
        assertThat(products).hasSize(1);
        verify(productRepository, times(1)).findAll();
    }
    
    @Test
    void saveProduct_ShouldSaveAndReturnProduct() {
        // Given
        when(productRepository.save(any(Product.class))).thenReturn(testProduct);
        
        // When
        Product saved = productService.saveProduct(testProduct);
        
        // Then
        assertThat(saved).isNotNull();
        assertThat(saved.getName()).isEqualTo("Test Product");
        verify(productRepository, times(1)).save(testProduct);
    }
}
```

#### Controller Test

```java
package com.skishop.controller;

import com.skishop.model.entity.Product;
import com.skishop.service.ProductService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.util.Arrays;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(ProductController.class)
class ProductControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @MockBean
    private ProductService productService;
    
    @Test
    void listProducts_ShouldReturnProductListView() throws Exception {
        // Given
        Product product = new Product();
        product.setId(1L);
        product.setName("Test Product");
        product.setPrice(BigDecimal.valueOf(100.00));
        product.setStockQuantity(10);
        
        when(productService.getAllProducts()).thenReturn(Arrays.asList(product));
        
        // When & Then
        mockMvc.perform(get("/products"))
                .andExpect(status().isOk())
                .andExpect(view().name("products/list"))
                .andExpect(model().attributeExists("products"));
    }
}
```

#### Integration Test

```java
package com.skishop;

import com.skishop.model.entity.Product;
import com.skishop.repository.ProductRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ActiveProfiles;

import java.math.BigDecimal;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
class ProductIntegrationTest {
    
    @LocalServerPort
    private int port;
    
    @Autowired
    private TestRestTemplate restTemplate;
    
    @Autowired
    private ProductRepository productRepository;
    
    @Test
    void testProductCreationAndRetrieval() {
        // Given
        Product product = new Product();
        product.setName("Integration Test Product");
        product.setPrice(BigDecimal.valueOf(150.00));
        product.setStockQuantity(20);
        productRepository.save(product);
        
        // When
        ResponseEntity<String> response = restTemplate.getForEntity(
            "http://localhost:" + port + "/products",
            String.class
        );
        
        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).contains("Integration Test Product");
    }
}
```

### Phase 8: Performance Testing and Tuning (1 week)

#### Performance Testing Execution

##### Load Testing with JMeter

```xml
<!-- pom.xmlに追加 -->
<dependency>
    <groupId>org.apache.jmeter</groupId>
    <artifactId>ApacheJMeter_core</artifactId>
    <version>5.6.3</version>
    <scope>test</scope>
</dependency>
```

##### Application Metrics Monitoring

```yaml
# Add to application.yml
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  metrics:
    export:
      prometheus:
        enabled: true
```

##### Performance Test Scenarios

1. **Concurrent Connection Test**
   - 100 users concurrent access
   - Response time < 500ms
   - Error rate < 1%

2. **Database Query Optimization**
   - Detect and fix N+1 problems
   - Index optimization
   - Query plan analysis

3. **Caching Strategy**

```java
@Configuration
@EnableCaching
public class CacheConfig {
    
    @Bean
    public CacheManager cacheManager() {
        SimpleCacheManager cacheManager = new SimpleCacheManager();
        cacheManager.setCaches(Arrays.asList(
            new ConcurrentMapCache("products"),
            new ConcurrentMapCache("categories")
        ));
        return cacheManager;
    }
}
```

```java
@Service
public class ProductServiceImpl implements ProductService {
    
    @Cacheable(value = "products", key = "#id")
    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }
    
    @CacheEvict(value = "products", key = "#product.id")
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }
}
```

#### Performance Tuning Checklist

- [ ] Optimize database connection pool configuration (HikariCP)
- [ ] Optimize JPA/Hibernate queries (Lazy Loading, Eager Loading)
- [ ] Create appropriate indexes
- [ ] Implement caching strategy
- [ ] Reduce unnecessary log output
- [ ] Compress and cache static resources
- [ ] Adjust JVM heap size
- [ ] Optimize garbage collection

### Phase 9: Documentation and Operations Preparation (1 week)

#### Documents to Create

##### 1. Architecture Documentation

**Contents:**

- Overall system architecture diagram
- Dependencies between components
- Data flow diagram
- Deployment architecture

##### 2. API Specification

```java
// API automatic documentation using SpringDoc
@Configuration
public class OpenApiConfig {
    
    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
            .info(new Info()
                .title("SkiShop API")
                .version("2.0.0")
                .description("SkiShop Application API after Spring Boot migration"));
    }
}
```

```xml
<!-- pom.xmlに追加 -->
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.3.0</version>
</dependency>
```

##### 3. Operations Manual

**Contents:**

- Application start/stop procedures
- Log checking methods
- Troubleshooting guide
- Backup/restore procedures
- Deployment procedures

**Startup Command Examples:**

```bash
# Development environment
mvn spring-boot:run

# Production environment (JAR file)
java -jar -Xmx2g -Xms1g \
  -Dspring.profiles.active=production \
  skishop-app-2.0.0.jar

# Production environment (Docker container)
docker run -d \
  -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=production \
  -e DB_USERNAME=prod_user \
  -e DB_PASSWORD=prod_pass \
  skishop-app:2.0.0
```

##### 4. 開発者ガイド

**内容:**

- プロジェクト構成の説明
- コーディング規約
- テストの書き方
- ローカル開発環境のセットアップ
- よくある問題と解決方法

##### 5. 移行レポート

**内容:**

- 移行前後の比較
- 遭遇した問題と解決策
- 残存する技術的負債
- 今後の改善提案

#### 運用監視の設定

```yaml
# application-production.yml
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus,loggers
  endpoint:
    health:
      show-details: always
  health:
    db:
      enabled: true
    diskspace:
      enabled: true

logging:
  level:
    root: WARN
    com.skishop: INFO
  file:
    name: /var/log/skishop/application.log
  pattern:
    file: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
```

#### Deployment Dockerfile

```dockerfile
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY target/skishop-app-2.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

#### CI/CD Pipeline (GitHub Actions Example)

```yaml
name: Build and Deploy

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up JDK 21
      uses: actions/setup-java@v4
      with:
        java-version: '21'
        distribution: 'temurin'
    
    - name: Build with Maven
      run: mvn clean package -DskipTests
    
    - name: Run tests
      run: mvn test
    
    - name: Build Docker image
      run: docker build -t skishop-app:${{ github.sha }} .
    
    - name: Push to registry
      run: |
        echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
        docker push skishop-app:${{ github.sha }}
```

### Phase 10: Legacy Code Cleanup and Final Verification (1 week)

#### Purpose of Cleanup

After completing migration through Phase 8 and verifying that the Spring Boot application functions correctly, remove unused old Struts-related code, configuration files, and JSP-related code. This will organize the codebase and improve maintainability.

#### Files and Code to Delete

##### 1. Struts-Related Configuration Files

```text
To Delete:
- WEB-INF/struts-config.xml
- WEB-INF/validation.xml
- WEB-INF/validator-rules.xml
- WEB-INF/tiles-defs.xml
- src/main/resources/struts.properties
- src/main/resources/validation.properties
```

##### 2. Struts Action Classes

```text
Directories to Delete:
- src/main/java/com/*/action/
- src/main/java/com/*/struts/

Verification Items:
- All Action classes have been migrated to Spring MVC Controllers
- Business logic has been extracted to Service layer
```

##### 3. ActionForm Classes

```text
To Delete:
- src/main/java/com/*/form/
- *ActionForm.java

Verification Items:
- All form classes have been migrated to DTOs
- Bean Validation annotations are applied
```

##### 4. JSP Files and Struts Taglib

```text
To Delete:
- src/main/webapp/**/*.jsp
- src/main/webapp/WEB-INF/tags/
- WEB-INF/tld/*.tld (Struts Tag Library definitions)

Verification Items:
- All JSPs have been migrated to Thymeleaf templates
- Screen display functionality verification is complete
```

##### 5. Struts-Related Dependencies (pom.xml)

```xml
Dependencies to Delete:
<dependencies>
    <!-- Delete: Apache Struts -->
    <dependency>
        <groupId>struts</groupId>
        <artifactId>struts</artifactId>
        <version>1.3.10</version>
    </dependency>
    
    <!-- Delete: Commons Validator -->
    <dependency>
        <groupId>commons-validator</groupId>
        <artifactId>commons-validator</artifactId>
        <version>1.3.1</version>
    </dependency>
    
    <!-- Delete: Commons Digester -->
    <dependency>
        <groupId>commons-digester</groupId>
        <artifactId>commons-digester</artifactId>
        <version>1.8</version>
    </dependency>
    
    <!-- Delete: Commons BeanUtils -->
    <dependency>
        <groupId>commons-beanutils</groupId>
        <artifactId>commons-beanutils</artifactId>
        <version>1.8.0</version>
    </dependency>
    
    <!-- Delete: Commons Chain -->
    <dependency>
        <groupId>commons-chain</groupId>
        <artifactId>commons-chain</artifactId>
        <version>1.2</version>
    </dependency>
    
    <!-- Delete: Servlet API (included in Spring Boot) -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>servlet-api</artifactId>
        <version>2.5</version>
    </dependency>
    
    <!-- Delete: JSP API (migrated to Thymeleaf) -->
    <dependency>
        <groupId>javax.servlet.jsp</groupId>
        <artifactId>jsp-api</artifactId>
        <version>2.1</version>
    </dependency>
    
    <!-- Delete: JSTL (migrated to Thymeleaf) -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>
    
    <!-- Delete: StrutsTestCase -->
    <dependency>
        <groupId>strutstestcase</groupId>
        <artifactId>strutstestcase</artifactId>
        <version>2.1.4-1.2-2.4</version>
    </dependency>
</dependencies>
```

##### 6. web.xml Update

```xml
Contents to Delete in web.xml:
<!-- Delete: Struts ActionServlet configuration -->
<servlet>
    <servlet-name>action</servlet-name>
    <servlet-class>org.apache.struts.action.ActionServlet</servlet-class>
    <init-param>
        <param-name>config</param-name>
        <param-value>/WEB-INF/struts-config.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
    <servlet-name>action</servlet-name>
    <url-pattern>*.do</url-pattern>
</servlet-mapping>

<!-- Delete: Struts TagLib configuration -->
<jsp-config>
    <taglib>
        <taglib-uri>/tags/struts-bean</taglib-uri>
        <taglib-location>/WEB-INF/struts-bean.tld</taglib-location>
    </taglib>
    <!-- Other Struts tag library definitions -->
</jsp-config>

Note: Spring Boot typically doesn't require web.xml,
      but if you need to keep existing configuration,
      delete only the Struts-related configuration.
```

##### 7. Other Configuration Files

```text
To Delete:
- src/main/resources/ApplicationResources.properties (migrated to messages.properties)
- src/main/webapp/WEB-INF/classes/ (unnecessary class files)
```

#### Cleanup Procedures

##### Step 1: Preparation (1 day)

```bash
# 1. Create complete backup
git checkout -b backup/before-cleanup
git add .
git commit -m "Backup before legacy code cleanup"
git push origin backup/before-cleanup

# 2. Create cleanup branch
git checkout main
git checkout -b feature/cleanup-legacy-code

# 3. Verify current operation
mvn clean test
mvn spring-boot:run
# Verify all functionality
```

##### Step 2: Delete Struts-Related Files (2 days)

```bash
# Delete Struts configuration files
rm -f src/main/webapp/WEB-INF/struts-config.xml
rm -f src/main/webapp/WEB-INF/validation.xml
rm -f src/main/webapp/WEB-INF/validator-rules.xml
rm -f src/main/webapp/WEB-INF/tiles-defs.xml
rm -rf src/main/webapp/WEB-INF/tld/

# Delete Struts Java code
find src/main/java -type d -name "action" -exec rm -rf {} +
find src/main/java -type d -name "form" -exec rm -rf {} +
find src/main/java -name "*Action.java" -delete
find src/main/java -name "*ActionForm.java" -delete

# After each deletion, run build and tests
mvn clean compile
mvn test
```

##### Step 3: Delete JSP-Related Files (2 days)

```bash
# Verify Thymeleaf template existence before deleting all JSP files
find src/main/resources/templates -name "*.html" | wc -l

# Delete JSP files
rm -rf src/main/webapp/*.jsp
rm -rf src/main/webapp/WEB-INF/jsp/
rm -rf src/main/webapp/WEB-INF/pages/

# Delete tag files
rm -rf src/main/webapp/WEB-INF/tags/

# Verify operation after each deletion
mvn spring-boot:run
# Verify all screens in browser
```

##### Step 4: Clean up pom.xml (1 day)

```bash
# Remove unnecessary dependencies from pom.xml
# Edit manually, or verify with following command

# Detect unused dependencies
mvn dependency:analyze

# Verify build and tests are problem-free
mvn clean install
mvn test

# Verify dependency tree
mvn dependency:tree
```

##### Step 5: Update or Delete web.xml (1 day)

```bash
# Spring Boot basically doesn't need web.xml
# If web.xml becomes empty after deleting Struts configuration, delete it
rm -f src/main/webapp/WEB-INF/web.xml

# Or update keeping only necessary configuration
# (When there are configurations still needed after Spring Boot migration, like Filter settings)
```

#### Post-Cleanup Verification Checklist

##### 1. Build and Test Verification

- [ ] `mvn clean compile` succeeds
- [ ] `mvn test` passes all tests
- [ ] `mvn package` generates WAR/JAR file correctly
- [ ] No compilation errors
- [ ] Verify and address warning messages

##### 2. Application Startup Verification

- [ ] Application starts correctly with `mvn spring-boot:run`
- [ ] No errors in startup logs
- [ ] Spring Boot banner is displayed
- [ ] All Beans are loaded correctly
- [ ] Database connection is established

##### 3. Functional Test Verification

- [ ] All screens display correctly (Thymeleaf templates)
- [ ] All form submissions work correctly
- [ ] Database registration/update/deletion works correctly
- [ ] File upload functionality works (if applicable)
- [ ] Mail sending functionality works (if applicable)
- [ ] Session management functions correctly
- [ ] Error handling works correctly

##### 4. Performance Test Verification

- [ ] Response time has not degraded
- [ ] Memory usage is appropriate
- [ ] CPU usage is within normal range
- [ ] Database connection pool functions correctly

##### 5. Security Test Verification

- [ ] Authentication/authorization works correctly
- [ ] XSS protection is functioning (Thymeleaf auto-escaping)
- [ ] CSRF protection is functioning (if needed)
- [ ] SQL injection protection is functioning (using JPA)

##### 6. Codebase Verification

- [ ] No Struts-related import statements remaining
- [ ] No unused classes
- [ ] Verify and address TODO/FIXME comments
- [ ] Code static analysis (SonarQube, etc.)

```bash
# Verify no Struts references remain
grep -r "import org.apache.struts" src/
grep -r "struts" pom.xml

# Verify no JSP-related references remain
grep -r "import javax.servlet.jsp" src/
grep -r "jsp-api" pom.xml

# Verify search results are empty
```

#### Post-Cleanup Final Processing

##### 1. Documentation Updates

```markdown
Documents to Update:
- README.md (Startup method, technology stack update)
- CHANGELOG.md (Migration history record)
- API specification (OpenAPI/Swagger)
- Operations manual (Deployment procedure update)
```

##### 2. Commit Changes and Pull Request

```bash
# Stage changes
git add .

# Commit
git commit -m "chore: Remove legacy Struts and JSP code after Spring Boot migration

- Remove all Struts Action classes and ActionForm classes
- Remove all JSP files and Struts TagLib configurations
- Remove Struts dependencies from pom.xml
- Clean up web.xml (remove Struts servlet configuration)
- Verify all functionality works with Spring Boot and Thymeleaf

Closes #XXX"

# Push to remote
git push origin feature/cleanup-legacy-code

# Create pull request and request review
```

##### 3. Pre-Production Deployment Final Verification

- [ ] Execute full testing in staging environment
- [ ] Execute load testing
- [ ] Execute security scan
- [ ] Demo to stakeholders
- [ ] Final verification of deployment plan
- [ ] Prepare rollback procedures

##### 4. Production Environment Deployment

```bash
# タグの作成
git tag -a v2.0.0 -m "Spring Boot migration completed - Legacy code removed"
git push origin v2.0.0

# 本番デプロイ（CI/CDパイプライン経由）
# または手動デプロイ
```

#### クリーンアップによる効果

##### 定量的効果

| 項目 | 削減量（推定） | 備考 |
| --- | --- | --- |
| コード行数 | 30-50%削減 | Action、ActionForm、JSPの削除 |
| 依存ライブラリ数 | 10-15個削減 | Struts関連ライブラリの削除 |
| WARファイルサイズ | 20-30%削減 | 不要なライブラリとJSPの削除 |
| ビルド時間 | 10-20%短縮 | 依存関係の削減 |
| 起動時間 | 改善 | Spring Bootの最適化 |

##### 定性的効果

1. **保守性の向上**
   - 二重管理の解消
   - コードベースの一貫性
   - 新規開発者の理解容易化

2. **セキュリティの向上**
   - 脆弱性のあるライブラリの削除
   - 攻撃対象の削減

3. **開発効率の向上**
   - 明確なアーキテクチャ
   - モダンな開発環境
   - テスト容易性の向上

4. **技術的負債の解消**
   - EOLフレームワークの削除
   - レガシーコードの削除
   - 将来への投資

#### トラブルシューティング

##### 問題1: 削除後にビルドエラーが発生

**原因**: 一部のコードが削除したクラスに依存している

**対処**:

```bash
# エラーログから依存しているクラスを特定
mvn clean compile 2>&1 | grep "cannot find symbol"

# 該当箇所を修正
# - Spring Bootの同等機能に置き換え
# - 不要なコードの場合は削除
```

##### 問題2: テストが失敗する

**原因**: テストコードがStrutsTestCaseに依存している

**対処**:

```java
// 削除: StrutsTestCaseベースのテスト
// 追加: Spring Boot Testベースのテスト
@SpringBootTest
@AutoConfigureMockMvc
class MyControllerTest {
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    void testSomething() throws Exception {
        mockMvc.perform(get("/path"))
            .andExpect(status().isOk());
    }
}
```

##### 問題3: 画面が表示されない

**原因**: JSP削除後、Thymeleafテンプレートのパスが正しくない

**対処**:

```yaml
# application.yml で確認
spring:
  thymeleaf:
    prefix: classpath:/templates/  # 正しいパス
    suffix: .html
```

```java
// Controllerで正しいビュー名を返す
@GetMapping("/products")
public String listProducts() {
    return "products/list";  // templates/products/list.html
}
```

## 主要な移行課題と対策

### 1. ビジネスロジックの抽出

**課題**: Struts Actionにビジネスロジックが直接記述されている場合が多い

**対策**:

- Actionから段階的にServiceレイヤーへロジックを抽出
- トランザクション境界を適切に設定（`@Transactional`）
- 依存性注入を活用してテスタビリティを向上

### 2. セッション管理

**課題**: Struts 1.xでは直接HttpSessionを操作

**対策**:

- Spring Sessionを利用（オプション）
- セッションスコープBeanの活用
- ステートレスな設計を推奨（RESTful）

### 3. データベーススキーマ

**課題**: 既存のデータベーススキーマとの整合性

**対策**:

- JPA エンティティを既存テーブル構造に合わせる
- `@Table(name="existing_table")` で既存テーブル名を指定
- 必要に応じてFlywayやLiquibaseでマイグレーション管理

## リスク評価と緩和策

| リスク | 深刻度 | 確率 | 影響 | 緩和策 |
| --- | --- | --- | --- | --- |
| ビジネスロジックの理解不足 | 高 | 中 | 機能の誤実装 | ドキュメント化、元の開発者へのヒアリング |
| データベーススキーマの不整合 | 高 | 低 | データ破損 | 移行前の完全バックアップ、段階的リリース |
| パフォーマンス劣化 | 中 | 低 | ユーザー体験低下 | 性能テスト実施、プロファイリング |
| 未検出のバグ | 中 | 中 | 本番障害 | 十分なテストカバレッジ、段階的リリース |
| 学習コスト | 中 | 高 | スケジュール遅延 | トレーニング実施、ペアプログラミング |
| 外部ライブラリの互換性 | 低 | 低 | ビルドエラー | 事前調査、代替ライブラリ検討 |

## タイムラインと工数見積もり

| フェーズ | 期間 | 必要リソース | 成果物 |
| --- | --- | --- | --- |
| フェーズ0: 準備 | 1週間 | 1-2名 | 環境構築、現状分析ドキュメント |
| フェーズ1: プロジェクト構造 | 1週間 | 2名 | Spring Bootプロジェクト、基本設定 |
| フェーズ2: データアクセス層 | 2週間 | 2-3名 | エンティティ、リポジトリ、サービス |
| フェーズ3: コントローラー層 | 3週間 | 3-4名 | 全Controller、DTO、バリデーション |
| フェーズ4: ビュー層 | 3週間 | 2-3名 | 全Thymeleafテンプレート |
| フェーズ5: モダンJavaリファクタリング | 1週間 | 2名 | Java 21モダンコード適用 |
| フェーズ6: 設定・その他 | 1週間 | 2名 | 例外処理、ファイルアップロード等 |
| フェーズ7: テスト | 2週間 | 3-4名 | 単体・統合テスト |
| フェーズ8: パフォーマンステスト | 1週間 | 2名 | 性能測定、チューニング |
| フェーズ9: ドキュメント化 | 1週間 | 1-2名 | 技術ドキュメント、運用手順書 |
| フェーズ10: レガシーコードクリーンアップ | 1週間 | 2-3名 | クリーンなコードベース、最終検証 |
| **合計** | **約17週間（4.25ヶ月）** | **2-4名** | |

### 並行作業の可能性

- フェーズ3とフェーズ4は一部並行実施可能
- テストは各フェーズで並行して作成
- フェーズ10は全機能移行完了後に実施（並行作業不可）

## 段階的リリース戦略

### ストラングラーパターン（推奨）

既存のStruts 1.xアプリケーションとSpring Bootアプリケーションを並行稼働:

1. **フェーズ1**: 新機能はSpring Bootで開発
2. **フェーズ2**: 使用頻度の低い画面から移行
3. **フェーズ3**: 主要機能の移行
4. **フェーズ4**: 全機能移行完了後、Struts 1.x版を廃止

**メリット**:

- リスク分散
- 段階的な検証
- ロールバックが容易

**実装方法**:

- リバースプロキシ（Nginx等）でURLパスベースでルーティング
- `/api/*` → Spring Boot
- その他 → Struts 1.x

### ビッグバン移行

全機能を一度に移行:

**メリット**:

- 二重管理不要
- 移行期間が短い

**デメリット**:

- リスクが高い
- ロールバックが困難

**推奨**: 小規模アプリケーションの場合のみ

## 移行チェックリスト

### 準備フェーズ

- [ ] プロジェクトチームの編成
- [ ] ステークホルダーの承認取得
- [ ] JDK 21のインストールと環境設定
- [ ] Spring Initializrでプロジェクト生成
- [ ] Git リポジトリのブランチ戦略決定
- [ ] CI/CD パイプラインの準備

### データアクセス層

- [ ] データベーススキーマの分析
- [ ] JPA エンティティクラスの作成
- [ ] Spring Data JPA リポジトリの作成
- [ ] サービスレイヤーの作成
- [ ] トランザクション境界の設定
- [ ] リポジトリとサービスの単体テスト

### コントローラー層

- [ ] Struts Actionの棚卸し
- [ ] Spring MVC Controllerへの変換
- [ ] DTOクラスの作成
- [ ] Bean Validationの実装
- [ ] 例外ハンドリングの実装
- [ ] Controller の単体テスト

### ビュー層

- [ ] JSPページの棚卸し
- [ ] Thymeleafテンプレートへの変換
- [ ] レイアウトテンプレートの作成
- [ ] CSS/JavaScriptの移行
- [ ] メッセージリソースの確認
- [ ] 画面表示の動作確認

### その他機能

- [ ] ファイルアップロード機能の移行
- [ ] メール送信機能の移行
- [ ] セッション管理の実装
- [ ] セキュリティ設定（必要に応じて）
- [ ] ログ設定の確認

### モダンJavaリファクタリング

- [ ] try-with-resourcesの適用
- [ ] diamond演算子・`var`の適用
- [ ] `instanceof`/`switch`のパターンマッチ適用
- [ ] text blocks適用（SQL/JSON/HTML）
- [ ] `java.time`への移行
- [ ] Stream/Optionalへの移行（適材適所）
- [ ] `record`/DTOの適用（JPAエンティティは除外）
- [ ] `HttpClient`/virtual threadsの検討

### テストとデプロイ

- [ ] 単体テストの完了
- [ ] 統合テストの完了
- [ ] パフォーマンステスト
- [ ] セキュリティテスト
- [ ] ステージング環境へのデプロイ
- [ ] 本番環境へのデプロイ

### レガシーコードのクリーンアップ

- [ ] 全機能のSpring Boot移行完了確認
- [ ] Struts関連設定ファイルの削除
- [ ] Struts ActionクラスとActionFormクラスの削除
- [ ] 全JSPファイルの削除
- [ ] pom.xmlから不要な依存関係の削除
- [ ] web.xmlのクリーンアップ
- [ ] クリーンアップ後のビルド確認
- [ ] クリーンアップ後の全機能テスト
- [ ] クリーンアップ後のパフォーマンステスト
- [ ] 最終的なコードレビュー

## 次のステップ

### 即座に実施すべきこと

1. **ステークホルダーミーティング**
   - 移行計画の説明と承認
   - リソース配分の決定
   - リリーススケジュールの合意

2. **技術評価**
   - POC（概念実証）の実施
   - 主要機能の1つをSpring Bootで実装してみる
   - パフォーマンスとの検証

3. **チーム準備**
   - Spring Boot研修の実施
   - Thymeleaf、Spring Data JPAの学習
   - ペアプログラミング体制の構築

### 1ヶ月以内

1. **環境構築**
   - 開発環境の整備
   - CI/CDパイプラインの構築
   - テスト環境の準備

2. **フェーズ0-1の完了**
   - 現状分析ドキュメント作成
   - Spring Bootプロジェクトの作成
   - 基本設定の完了

### 3ヶ月以内

1. **コア機能の移行**
   - データアクセス層の完全移行
   - 主要画面のコントローラーとビューの移行
   - 基本テストの完了

2. **ステージング環境デプロイ**
   - 移行済み機能のステージング環境テスト
   - フィードバックの収集と改善

### 6ヶ月以内

1. **全機能の移行完了**
   - すべてのStruts機能のSpring Boot化
   - 総合テスト完了
   - ドキュメント整備

2. **本番環境デプロイ**
   - 段階的リリースまたは一括切り替え
   - 監視体制の確立
   - 旧システムの段階的廃止

## 成功の鍵

### 技術面

1. **段階的な移行**: 一度にすべてを変更しない
2. **十分なテスト**: 各フェーズで徹底的にテスト
3. **継続的インテグレーション**: 自動テストとビルド
4. **パフォーマンス監視**: 移行前後での性能測定
5. **モダンJavaの適用**: try-with-resources, `java.time`, Streams, pattern matching, records

### 組織面

1. **経営陣のコミットメント**: リソースとスケジュールの確保
2. **チームのスキルアップ**: 継続的な学習と研修
3. **明確なコミュニケーション**: 進捗の透明性
4. **適切なリスク管理**: 問題の早期発見と対応

## 期待される効果

### 短期的効果（6ヶ月以内）

- セキュリティリスクの大幅な低減
- 開発生産性の向上（自動設定、ホットリロード等）
- メンテナンス性の向上

### 中長期的効果（6ヶ月以降）

- Java 21の最新機能活用によるコード品質向上
- マイクロサービス化への道筋
- クラウドネイティブアーキテクチャへの移行可能性
- 新規開発者のオンボーディング容易化
- コミュニティサポートの充実

## まとめ

このプロジェクトはApache Struts 1.3.10という2008年のフレームワークを使用しており、セキュリティリスクが極めて高い状態です。本移行計画では、**Java 21 + Spring Boot 3.2.x + Thymeleaf + Spring Data JPA** への完全移行を提案します。

### 移行のメリット

1. **セキュリティ**: EOLのStruts 1.xから、継続的にサポートされるSpring Bootへ
2. **生産性**: 自動設定、開発ツール、豊富なエコシステム
3. **保守性**: モダンなアーキテクチャ、明確な責務分離
4. **将来性**: マイクロサービス、クラウドネイティブへの移行パス
5. **人材**: Spring開発者の豊富さ、学習リソースの充実

### 推奨実装アプローチ

**期間**: 約6ヶ月（17週間の開発 + テスト・デプロイ・クリーンアップ）

**リソース**: 2-4名の開発者

**リリース戦略**: ストラングラーパターンによる段階的移行（推奨）

**最終フェーズ**: フェーズ5でモダンJava適用、フェーズ10でレガシーコードを完全削除

### 投資対効果

| 項目 | 短期（6ヶ月） | 中期（1-2年） | 長期（2年以上） |
| --- | --- | --- | --- |
| 開発コスト | 高（移行作業） | 低（生産性向上） | 低（保守容易） |
| セキュリティリスク | 大幅低減 | 最小化 | 最小化 |
| 開発速度 | 一時的低下 | 向上 | 大幅向上 |
| システム品質 | 向上 | 大幅向上 | 大幅向上 |

### 最終的な推奨事項

このApache Struts 1.xアプリケーションは**今すぐに移行を開始すべき**状態です。セキュリティリスクと技術的負債を考慮すると、**Spring Boot 3.2.x への完全移行が最適な選択**です。

- ✅ **Java 21**: 2031年までのLTSサポート
- ✅ **Spring Boot 3.2.x**: 業界標準、豊富なエコシステム
- ✅ **Thymeleaf**: モダンで保守しやすいテンプレートエンジン
- ✅ **Spring Data JPA**: 宣言的で生産性の高いデータアクセス

**今すぐ始めるべき3つのアクション:**

1. ステークホルダーへの説明と承認取得
2. 技術POCの実施（1-2週間）
3. 移行チームの編成と研修の開始

### 移行完了後の最終作業

移行が完了し、Spring Bootアプリケーションが正常に動作することを確認した後、**フェーズ10でレガシーコードのクリーンアップ**を実施します。これにより：

- 古いStrutsコードとJSPファイルを完全に削除
- 不要な依存関係を削除してアプリケーションサイズを削減
- コードベースをクリーンに保ち、保守性を大幅に向上
- 技術的負債を完全に解消

この移行により、セキュアで保守しやすく、将来にわたって拡張可能なアプリケーションを構築できます。
### Phase 1: Project Structure and Application Entry Point (1 week)

Create the Spring Boot main class and basic configuration structure.

### Phase 2: Data Access Layer Migration (2 weeks)

Migrate from manual JDBC to Spring Data JPA with entity classes, repositories, and services.

### Phase 3: Controller Layer Migration (3 weeks)

Convert Struts Actions to Spring MVC Controllers with DTOs and validation.

### Phase 4: View Layer Migration (JSP → Thymeleaf) (3 weeks)

Convert all JSP pages to Thymeleaf templates.

### Phase 5: Modern Java Refactoring (1 week)

Update code to use modern Java 21 features.

### Phase 6: Configuration and Other Migrations (1 week)

Implement exception handling, file upload, and other features.

### Phase 7: Testing (2 weeks)

Create unit tests, integration tests, and end-to-end tests.

### Phase 8: Performance Testing and Tuning (1 week)

Conduct load testing and optimize performance.

### Phase 9: Documentation and Operations Preparation (1 week)

Create architecture documentation, API specifications, and operations manuals.

### Phase 10: Legacy Code Cleanup and Final Verification (1 week)

Remove all Struts-related code and files after migration is complete.

## Major Migration Challenges and Solutions

### 1. Business Logic Extraction

**Challenge**: Business logic often directly written in Struts Actions

**Solution**:
- Gradually extract logic from Actions to Service layer
- Set appropriate transaction boundaries (`@Transactional`)
- Improve testability using dependency injection

### 2. Session Management

**Challenge**: Struts 1.x directly manipulates HttpSession

**Solution**:
- Use Spring Session (optional)
- Utilize session-scoped Beans
- Recommend stateless design (RESTful)

### 3. Database Schema

**Challenge**: Maintaining consistency with existing database schema

**Solution**:
- Adapt JPA entities to existing table structure
- Specify existing table names with `@Table(name="existing_table")`
- Use Flyway or Liquibase for migration management as needed

## Risk Assessment and Mitigation

| Risk | Severity | Probability | Impact | Mitigation |
| --- | --- | --- | --- | --- |
| Insufficient understanding of business logic | High | Medium | Incorrect functionality implementation | Documentation, interviews with original developers |
| Database schema inconsistencies | High | Low | Data corruption | Complete backup before migration, phased release |
| Performance degradation | Medium | Low | Reduced user experience | Conduct performance testing, profiling |
| Undetected bugs | Medium | Medium | Production failures | Adequate test coverage, phased release |
| Learning costs | Medium | High | Schedule delays | Training, pair programming |
| External library compatibility | Low | Low | Build errors | Prior investigation, consider alternative libraries |

## Timeline and Effort Estimation

| Phase | Duration | Required Resources | Deliverables |
| --- | --- | --- | --- |
| Phase 0: Preparation | 1 week | 1-2 people | Environment setup, current state analysis document |
| Phase 1: Project Structure | 1 week | 2 people | Spring Boot project, basic configuration |
| Phase 2: Data Access Layer | 2 weeks | 2-3 people | Entities, repositories, services |
| Phase 3: Controller Layer | 3 weeks | 3-4 people | All Controllers, DTOs, validation |
| Phase 4: View Layer | 3 weeks | 2-3 people | All Thymeleaf templates |
| Phase 5: Modern Java Refactoring | 1 week | 2 people | Java 21 modern code applied |
| Phase 6: Configuration & Others | 1 week | 2 people | Exception handling, file upload, etc. |
| Phase 7: Testing | 2 weeks | 3-4 people | Unit & integration tests |
| Phase 8: Performance Testing | 1 week | 2 people | Performance measurement, tuning |
| Phase 9: Documentation | 1 week | 1-2 people | Technical documentation, operations manual |
| Phase 10: Legacy Code Cleanup | 1 week | 2-3 people | Clean codebase, final verification |
| **Total** | **Approx. 17 weeks (4.25 months)** | **2-4 people** | |

### Parallel Work Possibilities

- Phases 3 and 4 can be partially executed in parallel
- Tests can be created in parallel with each phase
- Phase 10 must be executed after all functionality migration is complete (no parallel work)

## Phased Release Strategy

### Strangler Pattern (Recommended)

Run existing Struts 1.x application and Spring Boot application in parallel:

1. **Phase 1**: Develop new features in Spring Boot
2. **Phase 2**: Migrate low-frequency screens first
3. **Phase 3**: Migrate main functionality
4. **Phase 4**: Deprecate Struts 1.x version after complete migration

**Benefits**:
- Risk distribution
- Phased verification
- Easy rollback

**Implementation Method**:
- URL path-based routing with reverse proxy (Nginx, etc.)
- `/api/*` → Spring Boot
- Others → Struts 1.x

## Migration Checklist

### Preparation Phase

- [ ] Form project team
- [ ] Obtain stakeholder approval
- [ ] Install and configure JDK 21
- [ ] Generate project with Spring Initializr
- [ ] Determine Git repository branch strategy
- [ ] Prepare CI/CD pipeline

### Data Access Layer

- [ ] Analyze database schema
- [ ] Create JPA entity classes
- [ ] Create Spring Data JPA repositories
- [ ] Create service layer
- [ ] Set transaction boundaries
- [ ] Unit test repositories and services

### Controller Layer

- [ ] Inventory Struts Actions
- [ ] Convert to Spring MVC Controllers
- [ ] Create DTO classes
- [ ] Implement Bean Validation
- [ ] Implement exception handling
- [ ] Unit test Controllers

### View Layer

- [ ] Inventory JSP pages
- [ ] Convert to Thymeleaf templates
- [ ] Create layout templates
- [ ] Migrate CSS/JavaScript
- [ ] Verify message resources
- [ ] Verify screen display functionality

### Other Features

- [ ] Migrate file upload functionality
- [ ] Migrate mail sending functionality
- [ ] Implement session management
- [ ] Configure security (as needed)
- [ ] Verify log configuration

### Modern Java Refactoring

- [ ] Apply try-with-resources
- [ ] Apply diamond operator and `var`
- [ ] Apply `instanceof`/`switch` pattern matching
- [ ] Apply text blocks (SQL/JSON/HTML)
- [ ] Migrate to `java.time`
- [ ] Migrate to Stream/Optional (as appropriate)
- [ ] Apply `record` for DTOs (exclude JPA entities)
- [ ] Consider `HttpClient`/virtual threads

### Testing and Deployment

- [ ] Complete unit testing
- [ ] Complete integration testing
- [ ] Performance testing
- [ ] Security testing
- [ ] Deploy to staging environment
- [ ] Deploy to production environment

### Legacy Code Cleanup

- [ ] Verify all Spring Boot migration complete
- [ ] Remove Struts-related configuration files
- [ ] Remove Struts Action and ActionForm classes
- [ ] Remove all JSP files
- [ ] Remove unnecessary dependencies from pom.xml
- [ ] Clean up web.xml
- [ ] Verify build after cleanup
- [ ] Test all functionality after cleanup
- [ ] Performance test after cleanup
- [ ] Final code review

## Next Steps

### Immediate Actions

1. **Stakeholder Meeting**
   - Explain migration plan and obtain approval
   - Determine resource allocation
   - Agree on release schedule

2. **Technical Evaluation**
   - Conduct POC (Proof of Concept)
   - Implement one major feature with Spring Boot
   - Verify performance

3. **Team Preparation**
   - Conduct Spring Boot training
   - Learn Thymeleaf and Spring Data JPA
   - Establish pair programming structure

### Within 1 Month

1. **Environment Setup**
   - Prepare development environment
   - Build CI/CD pipeline
   - Prepare test environment

2. **Complete Phases 0-1**
   - Create current state analysis document
   - Create Spring Boot project
   - Complete basic configuration

### Within 3 Months

1. **Core Feature Migration**
   - Complete data access layer migration
   - Migrate main screen controllers and views
   - Complete basic tests

2. **Staging Environment Deployment**
   - Test migrated features in staging environment
   - Collect feedback and improve

### Within 6 Months

1. **Complete All Feature Migration**
   - Complete Spring Boot conversion of all Struts features
   - Complete comprehensive testing
   - Prepare documentation

2. **Production Environment Deployment**
   - Phased release or complete switchover
   - Establish monitoring system
   - Gradually deprecate old system

## Keys to Success

### Technical Aspects

1. **Phased Migration**: Don't change everything at once
2. **Thorough Testing**: Test thoroughly in each phase
3. **Continuous Integration**: Automated testing and builds
4. **Performance Monitoring**: Measure performance before and after migration
5. **Apply Modern Java**: try-with-resources, `java.time`, Streams, pattern matching, records

### Organizational Aspects

1. **Management Commitment**: Secure resources and schedule
2. **Team Skill Development**: Continuous learning and training
3. **Clear Communication**: Transparency of progress
4. **Appropriate Risk Management**: Early problem detection and response

## Expected Benefits

### Short-term Benefits (within 6 months)

- Significant reduction in security risks
- Improved development productivity (auto-configuration, hot reload, etc.)
- Improved maintainability

### Medium to Long-term Benefits (after 6 months)

- Improved code quality utilizing Java 21 latest features
- Path to microservices
- Possibility of migration to cloud-native architecture
- Easier onboarding for new developers
- Abundant community support

## Summary

This project uses the Apache Struts 1.3.10 framework from 2008 and has extremely high security risks. This migration plan proposes complete migration to **Java 21 + Spring Boot 3.2.x + Thymeleaf + Spring Data JPA**.

### Migration Benefits

1. **Security**: From EOL Struts 1.x to continuously supported Spring Boot
2. **Productivity**: Auto-configuration, development tools, rich ecosystem
3. **Maintainability**: Modern architecture, clear separation of concerns
4. **Future-proof**: Clear migration path to microservices and cloud-native
5. **Talent**: Abundance of Spring developers, rich learning resources

### Recommended Implementation Approach

**Duration**: Approximately 6 months (17 weeks development + testing, deployment, cleanup)

**Resources**: 2-4 developers

**Release Strategy**: Phased migration with Strangler Pattern (recommended)

**Final Phase**: Apply modern Java in Phase 5, completely remove legacy code in Phase 10

### Return on Investment

| Item | Short Term (6 months) | Medium Term (1-2 years) | Long Term (2+ years) |
| --- | --- | --- | --- |
| Development Cost | High (migration work) | Low (improved productivity) | Low (easy maintenance) |
| Security Risk | Significantly reduced | Minimized | Minimized |
| Development Speed | Temporary decrease | Improved | Significantly improved |
| System Quality | Improved | Significantly improved | Significantly improved |

### Final Recommendation

This Apache Struts 1.x application **should start migration immediately**. Considering security risks and technical debt, **complete migration to Spring Boot 3.2.x is the optimal choice**.

- ✅ **Java 21**: LTS support until 2031
- ✅ **Spring Boot 3.2.x**: Industry standard, rich ecosystem
- ✅ **Thymeleaf**: Modern, maintainable template engine
- ✅ **Spring Data JPA**: Declarative, highly productive data access

**Three Actions to Start Immediately:**

1. Explain to stakeholders and obtain approval
2. Conduct technical POC (1-2 weeks)
3. Form migration team and start training

### Post-Migration Final Work

After migration is complete and the Spring Boot application is verified to function properly, **implement legacy code cleanup in Phase 10**. This will:

- Completely remove old Struts code and JSP files
- Remove unnecessary dependencies to reduce application size
- Keep codebase clean and significantly improve maintainability
- Completely eliminate technical debt

This migration will build a secure, maintainable, and future-proof extensible application.
