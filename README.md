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

### Phase 2: Use the App Modernization Tool

1. **Open this project as a separate workspace:**
   ```bash
   code /path/to/skishop-springboot27
   ```

2. **Run the upgrade plan tool:**
   - Open GitHub Copilot Chat
   - Type: `#generate_upgrade_plan`

3. **The tool will:**
   - Analyze the project's dependencies
   - Generate an upgrade plan (saved to `.github/java-upgrade/`)
   - Prompt you to confirm the plan
   - Create a new branch with the upgraded code

4. **Key changes in the upgrade:**
   - `pom.xml`: Spring Boot 2.7.18 → 3.x, Java 8 → 21
   - Imports: `javax.*` → `jakarta.*`
   - Spring Security: Configuration API updates
   - Deprecated API replacements

### Manual Upgrade (Alternative)

If you prefer to upgrade manually, update `pom.xml`:

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.2.2</version>  <!-- Changed from 2.7.18 -->
</parent>

<properties>
    <java.version>21</java.version>  <!-- Changed from 8 -->
</properties>
```

Then run:
```bash
# Fix javax → jakarta imports
find src -name "*.java" -exec sed -i 's/javax\.persistence/jakarta.persistence/g' {} \;
find src -name "*.java" -exec sed -i 's/javax\.validation/jakarta.validation/g' {} \;
find src -name "*.java" -exec sed -i 's/javax\.servlet/jakarta.servlet/g' {} \;

# Rebuild
mvn clean compile
```

## License

MIT License
