<!-- markdownlint-disable MD013 -->

# SkiShop Monolith (Struts 1.x → Spring Boot) — Docker Compose Quickstart

> Spring Boot 3.2 + PostgreSQL 15 (Java 21). Legacy Struts 1.x roots kept for reference (see `answer.md`).

## ✅ Prerequisites

- Docker (Compose plugin)
- Docker Desktop（Apple Silicon 対応済み）

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
├── docker-compose.yml       # docker compose 設定
├── Dockerfile               # multi-stage (build + runtime)
├── src/main/java            # Legacy Struts 1.x Java sources
├── src/main/webapp          # Legacy JSP/WEB-INF/struts-config.xml
├── src/main/resources/db    # Postgres init SQL (01-schema.sql, 02-data.sql)
├── spring-boot-app/         # Spring Boot app (jar)
├── answer.md                # 埋め込んだ課題一覧と理想解
└── docs/operations.md       # Spring Boot ops notes
```

## 🧪 Local Maven Build (optional)

> JDK 21 / Maven Wrapper 同梱 (`./mvnw`).

```bash
./mvnw -B package -DskipTests
```

WAR: `target/skishop-monolith.war`

## 📌 Notes

- Docker image uses Temurin 21 + Spring Boot (embedded Tomcat 10.1).
- Intentional bugs/vulnerabilities are present for workshops. Do not fix with Code Review/CodeQL.

## 🌱 Spring Boot Prototype

試験的に `spring-boot-app/` に Spring Boot 3.2.x (Java 21) プロジェクトを追加済み:

```bash
./mvnw -f spring-boot-app/pom.xml spring-boot:run
```

テンプレート: `src/main/resources/templates/index.html`

### Monitoring / Docs

- Actuator: `http://localhost:8080/actuator`
  - Health: `/actuator/health`
  - Metrics: `/actuator/metrics`
  - Prometheus: `/actuator/prometheus`
- OpenAPI: `/v3/api-docs`, `/swagger-ui.html`
- Docs: [`docs/operations.md`](docs/operations.md), [`docs/architecture.md`](docs/architecture.md)

### Phase 2 (JPA フルカバレッジ)

- **全テーブル**のエンティティ/リポジトリ/サービス実装済み
- Lombok非使用（明示的 getter/setter, public no-arg ctor）
- テスト: `./mvnw -f spring-boot-app/pom.xml -B test` ✅ (2026-01-22 02:28 JST)
- 備考: JPAエンティティはRecord未採用（ライフサイクル/可変フィールドのため）

### Phase 3 (REST API & DTO & Thymeleaf素体)

- RESTコントローラ/DTO/例外ハンドラ実装（商品/カート/注文/ポイント/ユーザ/住所/クーポン/返品/Admin系）
- WebMvcTest: リポジトリをMockしサービス実装を注入する構成で緑
- Thymeleaf: `layout/main`, `fragments/header|footer`, `products/list`, `cart/detail`, `orders/detail`, `admin/*` の素体追加
- テスト: `./mvnw -f spring-boot-app/pom.xml -B test` ✅ (2026-01-22 02:28 JST)

### Phase 4 (Thymeleaf本実装: JSP→Thymeleaf)

- **完了**: UIコントローラ（`ViewController`, `AdminViewController`）、テンプレート全画面実装、ヘッダ/フッタ/スタイル、メッセージリソース整備、ビュー系テスト追加
- テスト: `./mvnw -f spring-boot-app/pom.xml -B test` ✅ (2026-01-22 03:04 JST)

### Phase 5-8 完了

- Phase5: モダンJavaリファクタリング済
- Phase6: REST/UI例外ハンドラ・エラーページ
- Phase7: テスト拡充 (UI/REST例外 & 統合)
- Phase8: 監視/キャッシュ (Actuator+Prometheus, Spring Cache, HTTPキャッシュ性能確認)

#### テスト

```bash
./mvnw -f spring-boot-app/pom.xml -B test
```
- 成功: 2026-01-22 15:19 JST

### Phase 9-10
- Phase9: Docs/運用(OpenAPI, operations/architecture)
- **Phase10: レガシーStruts整理** — Boot内にStruts参照なし、`docs/legacy.md` にアーカイブ指針を記載。RootのStrutsアプリは現状保持（ワークショップ用途）。

