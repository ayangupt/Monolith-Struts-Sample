<!-- markdownlint-disable MD013 -->

# SkiShop Monolith (Struts 1.x → Spring Boot) — Docker Compose Quickstart

> Spring Boot 3.2 + PostgreSQL 15 (Java 21). Legacy Struts 1.x roots kept for reference (see `answer.md`).

## ✅ Prerequisites

- Docker (Compose plugin)
- Docker Desktop (Apple Silicon supported)

## 🚀 Quickstart

```bash
docker compose up -d --build
```

- `app`: Spring Boot (JDK 21, embedded Tomcat 10.1), port `8080`
- `db`: PostgreSQL 15, init SQL: `src/main/resources/db`

## 🔍 Verify

```bash
docker compose ps
docker compose logs -f app
open http://localhost:8080/
# or: curl -I http://localhost:8080/
```

Endpoints:

- `GET /` (Thymeleaf)
- `GET /products`
- `GET /swagger-ui.html`
- `GET /actuator/health`

## 🛑 Stop & Cleanup

```bash
docker compose down
```

Remove volumes:

```bash
docker compose down -v
```

## 🔧 Troubleshooting

- **8080 port conflict**: run app container manually on 18080

```bash
docker compose up -d db
docker run --rm --name skishop-app-tomcat6-alt \
  --network struts-with-issue-test_default -p 18080:8080 \
  -e DB_HOST=db -e DB_PORT=5432 -e DB_NAME=skishop \
  -e DB_USERNAME=skishop -e DB_PASSWORD=skishop \
  struts-with-issue-test-app
```

- **Apple Silicon**: `export DOCKER_DEFAULT_PLATFORM=linux/amd64` or `docker compose build --platform linux/amd64`.
- **Slow first start**: wait for Postgres initialization (schema/data).

## 🧱 Project Structure

```text
.
├── docker-compose.yml       # docker compose settings
├── Dockerfile               # multi-stage (build + runtime)
├── src/main/java            # Legacy Struts 1.x Java sources
├── src/main/webapp          # Legacy JSP/WEB-INF/struts-config.xml
├── src/main/resources/db    # Postgres init SQL (01-schema.sql, 02-data.sql)
├── spring-boot-app/         # Spring Boot app (jar)
├── answer.md                # Embedded challenge list and ideal solutions
└── docs/operations.md       # Spring Boot ops notes
```

## 🧪 Local Maven Build (optional)

> JDK 21 / Maven Wrapper included (`./mvnw`).

```bash
./mvnw -B package -DskipTests
```

WAR: `target/skishop-monolith.war`

## 📌 Notes

- Docker image uses Temurin 21 + Spring Boot (embedded Tomcat 10.1).
- Intentional bugs/vulnerabilities are present for workshops. Do not fix with Code Review/CodeQL.

## 🌱 Spring Boot Prototype

Experimentally added Spring Boot 3.2.x (Java 21) project to `spring-boot-app/`:

```bash
./mvnw -f spring-boot-app/pom.xml spring-boot:run
```

Template: `src/main/resources/templates/index.html`

### Monitoring / Docs

- Actuator: `http://localhost:8080/actuator`
  - Health: `/actuator/health`
  - Metrics: `/actuator/metrics`
  - Prometheus: `/actuator/prometheus`
- OpenAPI: `/v3/api-docs`, `/swagger-ui.html`
- Docs: [`docs/operations.md`](docs/operations.md), [`docs/architecture.md`](docs/architecture.md)

### Phase 2 (JPA Full Coverage)

- **All tables** entities/repositories/services implemented
- No Lombok (explicit getter/setter, public no-arg constructor)
- Tests: `./mvnw -f spring-boot-app/pom.xml -B test` ✅ (2026-01-22 02:28 JST)
- Note: JPA entities don't use Records (due to lifecycle/mutable fields)

### Phase 3 (REST API & DTO & Thymeleaf scaffold)

### Phase 3 (REST API & DTO & Thymeleaf scaffold)

- REST controllers/DTOs/exception handlers implemented (products/cart/orders/points/users/addresses/coupons/returns/Admin)
- WebMvcTest: repository mocked, service implementation injected, tests passing
- Thymeleaf: added scaffold for `layout/main`, `fragments/header|footer`, `products/list`, `cart/detail`, `orders/detail`, `admin/*`
- Tests: `./mvnw -f spring-boot-app/pom.xml -B test` ✅ (2026-01-22 02:28 JST)

### Phase 4 (Thymeleaf Full Implementation: JSP→Thymeleaf)

### Phase 4 (Thymeleaf Full Implementation: JSP→Thymeleaf)

- **Complete**: UI controllers (`ViewController`, `AdminViewController`), all screen templates implemented, header/footer/styles, message resources organized, view tests added
- Tests: `./mvnw -f spring-boot-app/pom.xml -B test` ✅ (2026-01-22 03:04 JST)

### Phase 5-8 Complete

### Phase 5-8 Complete

- Phase5: Modern Java refactoring complete
- Phase6: REST/UI exception handlers & error pages
- Phase7: Test expansion (UI/REST exceptions & integration)
- Phase8: Monitoring/caching (Actuator+Prometheus, Spring Cache, HTTP cache performance verification)

#### Tests

```bash
./mvnw -f spring-boot-app/pom.xml -B test
```
- Success: 2026-01-22 15:19 JST

### Phase 9-10
- Phase9: Docs/operations (OpenAPI, operations/architecture)
- **Phase10: Legacy Struts cleanup** — No Struts references in Boot, archived guidelines documented in `docs/legacy.md`. Root Struts app maintained (for workshop use).

