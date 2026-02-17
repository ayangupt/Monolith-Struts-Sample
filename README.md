# SkiShop Spring Boot Application

## Overview

This is a Spring Boot 2.7.x application migrated from Apache Struts 1.x. It's an e-commerce platform for skiing equipment.

## Technology Stack

- **Java**: 8
- **Framework**: Spring Boot 2.7.18
- **View**: Thymeleaf 3.x
- **Database**: PostgreSQL (H2 for testing)
- **ORM**: Spring Data JPA + Hibernate
- **Security**: Spring Security 5.x

## Features

- User registration and authentication
- Product catalog with search and filtering
- Shopping cart management
- Order processing
- Coupon system
- Admin panel for product management

## Requirements

- JDK 8 or higher
- Maven 3.6+
- PostgreSQL 12+ (for production)

## Getting Started

### Build the application

```bash
mvn clean install
```

### Run locally with H2

```bash
mvn spring-boot:run -Dspring-boot.run.profiles=test
```

### Run with PostgreSQL

1. Create a PostgreSQL database named `skishop`
2. Set environment variables:
   ```bash
   export DB_USERNAME=your_username
   export DB_PASSWORD=your_password
   ```
3. Run:
   ```bash
   mvn spring-boot:run
   ```

### Access the application

- Application: http://localhost:8080
- Health check: http://localhost:8080/actuator/health

## Project Structure

```
src/main/java/com/skishop/
├── SkiShopApplication.java    # Main entry point
├── config/                    # Configuration classes
├── controller/                # Spring MVC Controllers
├── dto/                       # Data Transfer Objects
├── exception/                 # Exception handling
├── model/entity/              # JPA Entities
├── repository/                # Spring Data JPA Repositories
└── service/                   # Business logic

src/main/resources/
├── application.yml            # Application configuration
├── templates/                 # Thymeleaf templates
└── static/                    # Static resources (CSS, JS)
```

## Migration from Struts 1.x

This application was migrated from a legacy Struts 1.x application. Key changes:

| Struts 1.x | Spring Boot 2.7.x |
|------------|-------------------|
| Action classes | @Controller classes |
| ActionForm | @ModelAttribute + DTOs |
| struts-config.xml | Java Config + annotations |
| JSP + Struts Taglib | Thymeleaf templates |
| Manual JDBC | Spring Data JPA |
| commons-dbcp | HikariCP |

## Next Steps: Upgrade to Java 21

This Spring Boot 2.7.x project is ready for upgrade to:
- **Spring Boot 3.x**
- **Java 21 LTS**

Use the GitHub Copilot Application Modernization tool:
```
#generate_upgrade_plan
```

## License

MIT License
