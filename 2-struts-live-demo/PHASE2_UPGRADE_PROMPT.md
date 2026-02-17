# Phase 2: App Modernization Tool Upgrade Instructions

This document provides **copy-paste ready prompts** for upgrading the Spring Boot 2.7 + Java 8 application to Spring Boot 3.x + Java 21 using the GitHub Copilot App Modernization tool.

## Prerequisites

Before starting Phase 2, ensure you have:

1. ✅ Completed Phase 1 migration (Struts → Spring Boot 2.7)
2. ✅ The `springboot27-migration` branch is available and tested
3. ✅ GitHub Copilot extension installed in VS Code
4. ✅ App Modernization tool enabled in your Copilot settings

---

## Setup Instructions

### Step 1: Clone and Open the Spring Boot Project

```bash
# Clone the repository (if not already done)
git clone https://github.com/ayangupt/Monolith-Struts-Sample.git

# Navigate to the Spring Boot project
cd Monolith-Struts-Sample/skishop-springboot27

# Checkout the migration branch
git checkout springboot27-migration

# Open this specific folder as a workspace in VS Code
code .
```

**Important:** Open `skishop-springboot27` as the **root workspace folder**, not the entire repository.

---

## Phase 2: Upgrade Prompt for Copilot

### Option 1: Comprehensive Prompt (Recommended)

This detailed prompt guides the tool through the entire upgrade workflow, including build fixing, testing, and validation.

### Copy-Paste Prompt #1: Generate Upgrade Plan

Once you have the project open in VS Code, open GitHub Copilot Chat and paste the following prompt:

```
@workspace #generate_upgrade_plan

I need to upgrade this Spring Boot application from Java 8 to Java 21 and Spring Boot 2.7.x to Spring Boot 3.x.

Current state:
- Java: 8
- Spring Boot: 2.7.18
- Build tool: Maven
- Servlet API: javax.servlet
- JPA: javax.persistence
- Validation: javax.validation

Target state:
- Java: 21 (LTS)
- Spring Boot: 3.2.x (latest stable)
- Servlet API: jakarta.servlet
- JPA: jakarta.persistence
- Validation: jakarta.validation

Please perform a complete upgrade workflow:

1. **Analysis & Planning:**
   - Analyze the project structure and dependencies
   - Generate a comprehensive upgrade plan
   - Identify all files requiring changes

2. **Code Migration:**
   - Update pom.xml with Spring Boot 3.x and Java 21
   - Migrate all javax.* imports to jakarta.*
   - Update Spring Security configuration (WebSecurityConfigurerAdapter → SecurityFilterChain)
   - Replace deprecated APIs and update for breaking changes

3. **Build & Fix Iteration:**
   - Build the project with the updated configuration
   - Fix any compilation errors iteratively
   - Ensure the project compiles successfully

4. **Validation:**
   - Check for introduced CVEs in upgraded dependencies
   - Fix any security vulnerabilities found
   - Run all unit tests and fix failures
   - Verify test mocks work with new Spring Boot version

5. **Quality Checks:**
   - Validate code consistency (ensure behavior is preserved)
   - Check migration completeness (no leftover javax.* references)
   - Final build validation

6. **Version Control:**
   - Create a new branch for the upgrade (e.g., "java21-upgrade")
   - Commit changes with descriptive messages
   - Document all changes made

Please proceed with the upgrade automatically, fixing any issues encountered during build and test phases. Only stop if critical blockers are found that require manual intervention.
```

---

### Option 2: Simplified Prompt (Quick Start)

If you prefer a shorter prompt and let the tool handle details automatically:

```
@workspace #generate_upgrade_plan

Upgrade this Spring Boot 2.7.18 + Java 8 application to Spring Boot 3.2.x + Java 21.

Please:
- Generate and execute the upgrade plan
- Migrate javax.* to jakarta.*
- Update Spring Security configuration
- Fix build errors and test failures automatically
- Run CVE checks
- Create a new branch with all changes

Proceed automatically through the entire upgrade workflow.
```

---

### Which Prompt Should You Use?

| Aspect | Comprehensive Prompt | Simplified Prompt |
|--------|---------------------|-------------------|
| **Detail Level** | Explicit workflow steps | High-level instructions |
| **Control** | More guidance to the tool | Lets tool decide approach |
| **Best For** | Complex projects, specific requirements | Standard upgrades, trust automation |
| **Learning** | Helps understand the process | Faster to execute |

**Recommendation:** Use the **Comprehensive Prompt** for this demo to see the full capabilities of the App Modernization tool, including build fixing, test fixing, CVE checking, and validation stages.

---

### What Happens Next

After you submit the prompt above, the App Modernization tool will:

1. **Analyze the project:**
   - Scan `pom.xml` for dependencies
   - Identify Java source files
   - Detect Spring Boot version and Java version
   - Map all required migrations

2. **Generate an upgrade plan:**
   - Create a detailed plan in `.github/java-upgrade/`
   - List all files that need changes
   - Show dependency version updates
   - Highlight breaking changes

3. **Ask for confirmation:**
   - Review the generated plan carefully
   - Confirm to proceed with the upgrade

4. **Execute the upgrade:**
   - Create a new branch (e.g., `java21-upgrade`)
   - Update `pom.xml` with new versions
   - Replace all `javax.*` imports with `jakarta.*`
   - Update Spring Security configurations
   - Fix deprecated API usage
   - Run build and tests

5. **Commit changes:**
   - All changes are automatically committed
   - Each logical change gets its own commit

---

## Expected Changes

### 1. pom.xml Updates

```xml
<!-- Before -->
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.7.18</version>
</parent>
<properties>
    <java.version>8</java.version>
</properties>

<!-- After -->
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.2.2</version>
</parent>
<properties>
    <java.version>21</java.version>
</properties>
```

### 2. Package Migrations

| Before (Java 8, Spring Boot 2.7) | After (Java 21, Spring Boot 3.x) |
|----------------------------------|-----------------------------------|
| `import javax.servlet.*` | `import jakarta.servlet.*` |
| `import javax.persistence.*` | `import jakarta.persistence.*` |
| `import javax.validation.*` | `import jakarta.validation.*` |
| `import javax.annotation.*` | `import jakarta.annotation.*` |

### 3. Spring Security Configuration

```java
// Before (Spring Security 5.x)
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // Configuration
    }
}

// After (Spring Security 6.x)
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // Configuration
        return http.build();
    }
}
```

---

## Verification Steps

After the upgrade completes, verify the changes:

### 1. Check the Build

```bash
# Clean build
mvn clean install

# Expected: BUILD SUCCESS
```

### 2. Run Tests

```bash
mvn test

# Expected: All tests pass
```

### 3. Run the Application

```bash
mvn spring-boot:run

# Expected: Application starts on http://localhost:8080
```

### 4. Verify Endpoints

```bash
# Health check
curl http://localhost:8080/actuator/health

# Expected: {"status":"UP"}
```

---

## Troubleshooting

### Issue: Build Fails After Upgrade

**Solution:** The App Modernization tool includes automatic build fixing. If builds fail:

1. The tool will analyze errors
2. Apply fixes automatically
3. Retry the build (up to 10 attempts)

If issues persist after 10 attempts, review the error messages and consult the upgrade plan.

### Issue: Tests Fail After Upgrade

**Solution:** The tool includes test fixing capabilities:

1. Failing tests are analyzed
2. Common issues (mocks, assertions) are fixed
3. Tests are re-run

For integration tests requiring external resources, the tool may skip them with appropriate annotations.

### Issue: Import Errors for jakarta.*

**Cause:** Not all dependencies have been updated to Jakarta EE 9+.

**Solution:** Update any remaining dependencies in `pom.xml` to Jakarta-compatible versions:

```xml
<!-- Example: If using older Hibernate Validator -->
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.0.Final</version>
</dependency>
```

---

## Additional Prompts

If you need to make adjustments after the initial upgrade, use these follow-up prompts:

### Fix Remaining Build Errors

```
@workspace The build is failing with [describe error]. Please analyze the error and fix it.
```

### Fix Test Failures

```
@workspace Tests are failing in [TestClass]. Please analyze and fix the test failures while keeping the original business logic intact.
```

### Update Deprecated APIs

```
@workspace I'm seeing deprecation warnings for [specific API]. Please update to the recommended replacement API.
```

### Add Missing Dependencies

```
@workspace The application requires [dependency name] but it's missing from pom.xml. Please add the Jakarta-compatible version.
```

---

## Success Criteria

Your Phase 2 upgrade is complete when:

- ✅ `pom.xml` shows Spring Boot 3.x and Java 21
- ✅ All `javax.*` imports replaced with `jakarta.*`
- ✅ Build completes successfully: `mvn clean install`
- ✅ All unit tests pass: `mvn test`
- ✅ Application starts: `mvn spring-boot:run`
- ✅ Health endpoint responds: `/actuator/health`
- ✅ No CVE vulnerabilities introduced

---

## Next Steps After Upgrade

Once the upgrade is complete:

1. **Merge the upgrade branch:**
   ```bash
   git checkout springboot27-migration
   git merge java21-upgrade
   git push origin springboot27-migration
   ```

2. **Performance testing:** Verify application performance with Java 21

3. **Production deployment:** Update deployment configurations for Java 21

4. **Documentation:** Update README and deployment docs with new requirements

---

## Resources

- [Spring Boot 3.0 Migration Guide](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.0-Migration-Guide)
- [Jakarta EE 9 Release](https://jakarta.ee/specifications/platform/9/)
- [Java 21 Features](https://openjdk.org/projects/jdk/21/)
- [Spring Security 6.0 Migration](https://docs.spring.io/spring-security/reference/migration/index.html)
