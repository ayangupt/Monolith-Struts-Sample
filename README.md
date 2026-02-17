# SkiShop Monolith (Struts 1.2.9)

Struts 1.2.9 monolithic EC sample packaged as a WAR (Java 5-era syntax with a
Maven compiler target of 1.5 in `pom.xml`).

## Requirements
- Java 5 runtime (Tomcat 6.0.53 + JDK 5.0u22)
- Maven (for build/test)
- PostgreSQL 9.2 (schema in `src/main/resources/db/schema.sql`)

Docker builds download the JDK 5.0u22 archive; when building manually, pass
`--build-arg JDK_LICENSE=accept` (and optionally override `JDK_URL` or
`JDK_SHA256` if you use a different archive) to acknowledge the license terms.

## Build & Test
```sh
mvn -B test
mvn -B package
```

The WAR is generated at `target/skishop-monolith.war`.

## Configuration
`app.properties` is bundled in `src/main/resources` and copied to `WEB-INF/classes`.
It supports `${TOKEN}` placeholders resolved from system properties or environment variables
(for example `DB_PASSWORD`). JNDI configuration example lives in
`src/main/webapp/META-INF/context.xml` (Tomcat 6-style pool attributes).

## Operations / Release
See [docs/ops.md](docs/ops.md) for Tomcat 6 deployment steps, environment variables/context
settings, backup/restore notes, and WAR versioning/release notes.

---

## 🎯 Migration & Upgrade Demo Strategy

This section documents a **two-phase approach** for demonstrating a complete application modernization journey using GitHub Copilot and the Application Modernization tool.

### Why Two Phases?

The `#generate_upgrade_plan` tool is designed for **Java runtime version upgrades** within compatible frameworks (e.g., Java 8 → Java 21 with Spring Boot). It cannot process Struts 1.x applications because:

1. **Struts 1.x is EOL** - No valid upgrade path exists without full framework migration
2. **Framework incompatibility** - Struts cannot run on modern Java without rewriting

### Demo Flow

```
┌─────────────────────────┐
│  Struts 1.x + Java 1.5  │  ← Current state (EOL, unsupported)
└───────────┬─────────────┘
            │ Phase 1: GitHub Copilot migration
            ▼
┌─────────────────────────┐
│ Spring Boot 2.7 + Java 8│  ← Intermediate state (branch: springboot27-migration)
└───────────┬─────────────┘
            │ Phase 2: #generate_upgrade_plan tool
            ▼
┌─────────────────────────┐
│Spring Boot 3.x + Java 21│  ← Final state (modern, supported)
└─────────────────────────┘
```

---

## Phase 1: Framework Migration (Copilot-assisted)

**Goal:** Migrate Struts 1.x + Java 1.5 → Spring Boot 2.7.x + Java 8

The migrated code is available on the **`springboot27-migration`** branch.

**Why Phase 1?** The App Modernization tool (`#generate_upgrade_plan`) requires a modern framework base. Since Struts 1.x is EOL and incompatible with modern Java, Phase 1 uses GitHub Copilot to migrate to Spring Boot 2.7 + Java 8, creating a foundation that Phase 2 can then upgrade to Java 21 + Spring Boot 3.x.

**After Phase 1:** Follow [PHASE2_UPGRADE_PROMPT.md](PHASE2_UPGRADE_PROMPT.md) to complete the modernization journey.

### What Phase 1 Creates

| Component | Description |
|-----------|-------------|
| **JPA Entities** | User, Product, Category, Cart, CartItem, Order, OrderItem, Coupon |
| **Repositories** | Spring Data JPA repositories for all entities |
| **Services** | UserService, ProductService, CartService, OrderService, CouponService |
| **Controllers** | Spring MVC controllers replacing Struts Actions |
| **Templates** | Thymeleaf templates replacing JSPs |
| **Security** | Spring Security with form-based login |

### Phase 1 Migration Steps

#### Step 1: Create Project Structure

```bash
mkdir -p skishop-springboot27/src/main/java/com/skishop/{config,controller,dto,exception,model/entity,repository,service/impl}
mkdir -p skishop-springboot27/src/main/resources/{templates/{auth,products,cart,orders,admin,account,fragments,layout},static/{css,js,images},db}
mkdir -p skishop-springboot27/src/test/java/com/skishop
mkdir -p skishop-springboot27/src/test/resources
```

#### Step 2: Create pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.18</version>
        <relativePath/>
    </parent>

    <groupId>com.skishop</groupId>
    <artifactId>skishop-app</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <properties>
        <java.version>8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.thymeleaf.extras</groupId>
            <artifactId>thymeleaf-extras-springsecurity5</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
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
            </plugin>
        </plugins>
    </build>
</project>
```

#### Step 3: Create Spring Boot Application Class

```java
package com.skishop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SkiShopApplication {
    public static void main(String[] args) {
        SpringApplication.run(SkiShopApplication.class, args);
    }
}
```

#### Step 4: Migration Mappings

| Struts 1.x Component | Spring Boot Equivalent |
|---------------------|------------------------|
| `Action` class | `@Controller` + `@RequestMapping` |
| `ActionForm` | `@ModelAttribute` + DTO with `@Valid` |
| `struts-config.xml` | Java Config (`@Configuration`) |
| `ActionForward` | `return "viewName"` or `redirect:/path` |
| JSP + Struts Tags | Thymeleaf templates |
| `*DaoImpl` (manual JDBC) | `*Repository` interface (Spring Data JPA) |
| `DataSourceLocator` | Auto-configured `DataSource` |
| `commons-dbcp` | HikariCP (default) |

#### Step 5: Convert Struts Actions to Controllers

**Before (Struts Action):**
```java
public class LoginAction extends Action {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response) {
        LoginForm loginForm = (LoginForm) form;
        // ... authentication logic
        return mapping.findForward("success");
    }
}
```

**After (Spring Controller):**
```java
@Controller
public class AuthController {
    
    @GetMapping("/login")
    public String loginPage() {
        return "auth/login";
    }
    
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("registerRequest") RegisterRequest request,
                          BindingResult bindingResult,
                          RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "auth/register";
        }
        userService.register(request.getEmail(), request.getUsername(), request.getPassword());
        return "redirect:/login";
    }
}
```

#### Step 6: Convert JSP to Thymeleaf

**Before (JSP with Struts Tags):**
```jsp
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<html:form action="/login.do" method="post">
    <html:text property="email" size="30"/>
    <html:password property="password" size="30"/>
    <html:submit value="Login"/>
</html:form>
```

**After (Thymeleaf):**
```html
<form th:action="@{/login}" method="post">
    <input type="email" name="username" required>
    <input type="password" name="password" required>
    <button type="submit">Login</button>
</form>
```

#### Step 7: Initialize Git and Push

```bash
cd skishop-springboot27
git init
git add .
git commit -m "Initial commit: Spring Boot 2.7.18 + Java 8 migration from Struts 1.x"
git remote add origin https://github.com/ayangupt/Monolith-Struts-Sample.git
git checkout -b springboot27-migration
git push -u origin springboot27-migration
```

### Verification

```bash
cd skishop-springboot27
mvn clean test

# Expected output:
# Tests run: 4, Failures: 0, Errors: 0
# BUILD SUCCESS
```

### ✅ Phase 1 Complete - Ready for App Modernization Tool

Once Phase 1 is complete and verified, your application is ready for the App Modernization tool upgrade!

**→ Next: See [PHASE2_UPGRADE_PROMPT.md](PHASE2_UPGRADE_PROMPT.md) for copy-paste ready instructions** to upgrade to Spring Boot 3.x + Java 21 using the GitHub Copilot App Modernization tool.

---

## Phase 2: Java Runtime Upgrade (App Mod Tool)

**Goal:** Upgrade Spring Boot 2.7 + Java 8 → Spring Boot 3.x + Java 21

### 📋 Quick Start with Copy-Paste Prompts

**→ See [PHASE2_UPGRADE_PROMPT.md](PHASE2_UPGRADE_PROMPT.md) for detailed, copy-paste ready instructions** to use with the GitHub Copilot App Modernization tool.

The prompt instructions file includes:
- ✅ Complete setup steps
- ✅ Ready-to-use Copilot prompts
- ✅ Expected changes and verification steps
- ✅ Troubleshooting guide
- ✅ Follow-up prompts for common scenarios

### Quick Steps Summary

1. **Clone the migration branch:**
   ```bash
   git clone -b springboot27-migration https://github.com/ayangupt/Monolith-Struts-Sample.git skishop-upgrade
   cd skishop-upgrade/skishop-springboot27
   ```

2. **Open in VS Code as a new workspace:**
   ```bash
   code .
   ```

3. **Use the App Modernization tool:**
   - Open GitHub Copilot Chat
   - Copy the prompt from [PHASE2_UPGRADE_PROMPT.md](PHASE2_UPGRADE_PROMPT.md)
   - Paste into Copilot Chat and press Enter
   - The tool will analyze, plan, and execute the upgrade

4. **What the tool does automatically:**
   - ✅ Generates comprehensive upgrade plan
   - ✅ Updates `pom.xml` with Spring Boot 3.x and Java 21
   - ✅ Migrates `javax.*` imports to `jakarta.*`
   - ✅ Updates Spring Security configuration
   - ✅ Replaces deprecated APIs
   - ✅ Fixes build errors (up to 10 attempts)
   - ✅ Fixes test failures
   - ✅ Creates new branch with all changes
   - ✅ Commits changes automatically

---

## Branches

| Branch | Description | Java | Framework |
|--------|-------------|------|-----------|
| `main` | Original Struts 1.x application | 1.5 | Struts 1.2.9 |
| `springboot27-migration` | Phase 1 migration result | 8 | Spring Boot 2.7.18 |

---

## Technology Stack Comparison

| Aspect | Original (main) | Phase 1 (springboot27-migration) | Phase 2 (after upgrade) |
|--------|-----------------|----------------------------------|-------------------------|
| **Java** | 1.5 | 8 | 21 |
| **Framework** | Struts 1.2.9 | Spring Boot 2.7.18 | Spring Boot 3.x |
| **View** | JSP + Struts Tags | Thymeleaf | Thymeleaf |
| **Data Access** | Manual JDBC | Spring Data JPA | Spring Data JPA |
| **Connection Pool** | commons-dbcp | HikariCP | HikariCP |
| **Security** | Custom filter | Spring Security 5 | Spring Security 6 |
| **Servlet API** | javax.servlet | javax.servlet | jakarta.servlet |
