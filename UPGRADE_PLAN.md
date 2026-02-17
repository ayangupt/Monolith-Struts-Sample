# Spring Boot Migration Plan

## Migration Plan from Apache Struts 1.x to Spring Boot 3.x + Thymeleaf + Spring Data JPA

## Overview

This project uses the legacy Apache Struts 1.3.10 Java application targeting Java 1.5. This document outlines a complete migration plan to **Java 21 + Spring Boot 3.2.x + Thymeleaf + Spring Data JPA**.

## Current State

### Java Version

- **Current**: Java 1.5 (Released 2004, End of Support)
- **Target**: Java 21 LTS (Released September 2023, LTS Support until September 2031)

### Framework

- **Current**: Apache Struts 1.3.10 (Released 2008, EOL, numerous known vulnerabilities)
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
| | commons-dbutils | 1.1 | 1.8.1 | Upgrade available |
| | PostgreSQL JDBC | 9.2-1004-jdbc3 | 42.7.4 | Major upgrade |
| **File Upload** | | | | |
| | commons-fileupload | 1.3.3 | 1.5 | Security fixes available |
| **Logging** | | | | |
| | log4j | 1.2.17 | N/A | Migration to Log4j2 2.23.1 recommended |
| **Mail** | | | | |
| | javax.mail | 1.4.7 | Jakarta Mail 2.1.3 | Migration to Jakarta EE |
| **View Template/Web** | | | | |
| | jsp-api | 2.1 | Thymeleaf 3.1.x | Migration from JSP to Thymeleaf |
| | servlet-api | 2.5 | Spring Boot embedded (Tomcat 10.1.x) | Included in Spring Boot Starter |
| | - | - | Spring Web MVC 6.1.x | RESTful Web Service support |
| **Testing** | | | | |
| | JUnit | 4.12 | JUnit 5.10.2 | Migration to JUnit Jupiter |
| | H2 Database | 1.3.176 | 2.2.224 | For testing |
| | StrutsTestCase | 2.1.4-1.2-2.4 | N/A | Struts-dependent, consider removal |

## Migration Strategy

### Why Choose Spring Boot

**Apache Struts 1.x reached EOL in 2013 and has numerous known vulnerabilities.** Partial dependency upgrades won't solve the fundamental problems.

#### Reasons for Complete Migration to Spring Boot 3.2.x

1. **Security**: Continuous security updates and support
2. **Community**: Largest Java community with abundant documentation
3. **Modern Technology**: Full utilization of Java 21 features
4. **Productivity**: Fast development with auto-configuration, embedded server, and development tools
5. **Future-proof**: Clear migration path to microservices and cloud-native
6. **Ecosystem**: Rich Spring Boot starters and integration support

### Target Technology Stack

| Component | Struts 1.x | Spring Boot 3.2.x |
| --- | --- | --- |
| **Framework** | Apache Struts 1.3.10 | Spring Boot 3.2.x + Spring MVC 6.1.x |
| **Java Version** | Java 1.5 | Java 21 LTS |
| **View Template** | JSP + Struts Taglib | Thymeleaf 3.1.x |
| **Data Access** | JDBC + Commons DBUtils | Spring Data JPA 3.2.x + Hibernate 6.4.x |
| **Connection Pool** | Commons DBCP 1.x | HikariCP (Spring Boot standard) |
| **Validation** | Commons Validator | Bean Validation 3.0 (Hibernate Validator) |
| **Logging** | Log4j 1.2.17 | Logback (Spring Boot standard) + SLF4J |
| **Dependency Injection** | None | Spring IoC Container |
| **Testing** | JUnit 4 + StrutsTestCase | JUnit 5 + Spring Boot Test |
| **Build Tool** | Maven 2.x series | Maven 3.9.x |
| **Application Server** | Tomcat 6/7 (external) | Embedded Tomcat 10.1.x |

## Mapping Between Struts 1.x and Spring Boot

### Architecture Mapping

| Struts 1.x Component | Spring Boot Equivalent | Description |
| --- | --- | --- |
| **Action** | `@Controller` + `@RequestMapping` | Request handling |
| **ActionForm** | `@ModelAttribute` + Bean Validation | Form data binding |
| **struts-config.xml** | Java Config (`@Configuration`) | Application configuration |
| **ActionForward** | `ModelAndView` / `return "viewName"` | View navigation |
| **ActionMapping** | `@RequestMapping` / `@GetMapping` / `@PostMapping` | URL mapping |
| **ActionServlet** | `DispatcherServlet` (auto-configured) | Front controller |
| **JSP + Struts Tags** | Thymeleaf templates | View rendering |
| **Validator Framework** | Bean Validation + `@Valid` | Input validation |
| **MessageResources** | `MessageSource` + `messages.properties` | Internationalization |
| **DAO (manual JDBC)** | Spring Data JPA Repository | Data access |
| **DataSource (DBCP)** | HikariCP (auto-configured) | Connection pooling |

## Phased Migration Plan

### Phase 0: Preparation Phase (1 week)

#### Tasks

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
Spring Boot: 3.2.x (latest stable)
Java: 21
Packaging: War (for compatibility with existing WAR deployment, can change to Jar later)

Dependencies:
- Spring Web
- Thymeleaf
- Spring Data JPA
- PostgreSQL Driver
- Validation
- Spring Boot DevTools
- Lombok (Optional, reduces boilerplate code)
- Spring Boot Actuator (Optional, for monitoring)
```

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
