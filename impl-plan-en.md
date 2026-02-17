# Implementation Plan (SkiShop Monolith - Struts 1.2.9 / Java 5)

<!-- markdownlint-disable MD013 MD029 -->

## Phase Structure

0. Environment & Framework
1. Domain/DAO/DDL
2. Service/Business Logic
3. Web Layer (Action/Form/Validation)
4. View (JSP/Tiles)
5. Security/RequestProcessor
6. Admin Features
7. Notification/Email
8. Non-functional/Operations/Docker
9. Testing/QA
10. Release

---

## Phase 0: Environment & Framework

**Content**

- Create Ant 1.8 project skeleton (`source/target=1.5`, Maven 2 also acceptable).
- Prepare `build.xml` / `build.properties` / `lib/` (JAR dependencies or Ivy).
- Create package structure/folder layout (`src/main/java`, `src/main/resources`, `src/main/webapp`).
- Skeleton `web.xml` / `struts-config.xml`, `context.xml` (Tomcat DataSource), `log4j.properties` template.
- Place dependencies (Struts 1.2.9, log4j, dbcp, dbutils, javax.mail, servlet/jsp-api, junit/strutstestcase).
- `.editorconfig` / coding standards memo.

**Exit Criteria**

- `ant war` / `ant test` succeeds and generates empty WAR (Maven use: `mvn -B -DskipTests package`).
- ActionServlet starts on Tomcat (6 or 8) with no errors except 404, startup logs appear.
- All required dependencies in `lib/`, no unresolved classes at compile time.

---

## Phase 1: Domain/DAO/DDL

**Content**

- Domain/DTO definitions: User, Role, UserSession, Product, ProductImage, Category, Price, Inventory, Cart, Order, OrderItem, OrderShipping, Shipment, Return, Payment, PointAccount, PointTransaction, Coupon, CouponUsage, Campaign, Address, PasswordResetToken, ShippingMethod, SecurityLog, EmailQueue, OAuthAccount (optional).
- Implement `AbstractDao`, `DaoException`, `DataSourceLocator`.
- Create DAO interfaces and implementations: UserDao, RoleDao, UserSessionDao, ProductDao, ProductImageDao, InventoryDao, CouponDao, CouponUsageDao, CartDao, OrderDao, OrderShippingDao, ShipmentDao, ReturnDao, PaymentDao, PointAccountDao, PointTransactionDao, UserAddressDao, PasswordResetTokenDao, ShippingMethodDao, SecurityLogDao, EmailQueueDao, OAuthAccountDao (optional).
- Create DDL scripts (all tables, indexes, constraints, foreign keys, unique constraints, including `coupon_usage`/`security_logs`/`payments`).
- Initial data insertion SQL (sample products, users, addresses, inventory).

**Exit Criteria**

- DDL executes successfully on H2/PG, DAO CRUD tests pass with JUnit + H2/DBUnit.
- Main DAO methods return expected data (findByEmail, findPaged, reserve, findActiveCouponUsage, lockInventory, recordPayment, etc.).
- DDL contains required indexes, foreign key constraint violations are detected.

---

## Phase 2: Service/Business Logic

**Content**

- Service implementations: AuthService, UserService, ProductService, InventoryService, CouponService, CartService, PaymentService (mock), OrderService, PointService, ShippingService, TaxService, MailService, SecurityLogService, SessionService.
- Implement `OrderFacade` (placeOrder, cancelOrder, returnOrder).
- Business rules:
  - Coupon validation (usage_limit, minimum_amount, period, is_active).
  - Point award/usage (1% · 365 days).
  - Tax calculation 10%, shipping $8/free over $100.
  - Pessimistic inventory lock `SELECT ... FOR UPDATE`, exception on insufficient stock.
  - Payment authorization success/failure handling, point/coupon adjustment on cancel/return.
  - Idempotency (`order_number` unique, prevent double charges, prevent duplicate email sends).
  - Transaction boundary definition (service method level, rollback on exception).

**Exit Criteria**

- JUnit service tests (H2 + DBUnit) pass:
  - Success: checkout (coupon+points) → order/point/coupon_usage/stock/payments update.
  - Cancel: restore inventory, deduct points, deduct coupon usage count.
  - Return: refund record, point adjustment.
- Concurrency test: pessimistic lock effective in simultaneous checkout, no double charge.
- Rollback test: DB consistency maintained on mid-process failure.

---

## Phase 3: Web Layer (Action/Form/Validation)

**Content**

- Action implementations: Login, Register, PasswordForgot, PasswordReset, ProductList, ProductDetail, Cart, Checkout, CouponApply, OrderHistory, OrderCancel, OrderReturn, PointBalance, AddressList, AddressSave, Logout.
- ActionForm implementations: LoginForm, RegisterForm, PasswordResetRequestForm, PasswordResetForm, ProductSearchForm, AddCartForm, CheckoutForm, CouponForm, AddressForm, AdminProductForm.
- Organize `validation.xml` rules (email, password, quantity, postal code, phone, card info).
- Organize `messages.properties` keys.

**Exit Criteria**

- StrutsTestCase shows expected forwards/validation for main Actions (success/failure).
- Input error display based on `validation.xml` can be confirmed in JSP.
- Forms with CSRF token have tests for passing/failing token validation.

---

## Phase 4: View (JSP/Tiles)

**Content**

- Tiles layout `base.jsp`, common `header.jsp`, `footer.jsp`, `messages.jsp`.
- Create JSPs: auth/login, auth/register, auth/password/forgot/reset, products/list/detail, cart/view/checkout/confirmation, orders/history/detail, points/balance, account/addresses/address_edit, admin/products/list/edit, admin/orders/list/detail.
- Apply Struts tags (html/bean/logic), default `<bean:write filter="true"/>`.
- Embed CSRF token (`<html:hidden property="org.apache.struts.taglib.html.TOKEN"/>`).

**Exit Criteria**

- Manual verification: Pages render on Tomcat, no tag resolution errors.
- UI flow from add to cart through checkout completes.
- XSS protection: default `<bean:write filter="true"/>`, no escape leaks confirmed visually.

---

## Phase 5: Security / RequestProcessor

**Content**

- Extend `AuthRequestProcessor`: authorization (roles), unauthenticated redirect, CSRF validation, session fixation protection (invalidate→new on login).
- Login attempt limit (5 times, record in `security_logs`, set `users.status=LOCKED`).
- Password hash (SHA-256 + salt + 1000 iterations).
- Cookie settings `CART_ID` HttpOnly/Secure.

**Exit Criteria**

- Unauthenticated access to protected resources → redirect to `/login.do`.
- Invalid CSRF results in 403-equivalent response.
- After 5 wrong attempts, lock, confirm `security_logs` record, confirm unlock procedure.

---

## Phase 6: Admin Features

**Content**

- Admin Actions/Forms/JSP: Product CRUD, inventory update, order status update/refund, coupon management (optional), shipping method management (optional).
- Admin role check.

**Exit Criteria**

- Admin user can login, product list/edit, inventory update, order update possible.
- Non-admins cannot access `/admin/*`.

---

## Phase 7: Notification / Email

**Content**

- Implement `MailService` (JavaMail 1.4.7), load SMTP settings.
- `email_queue` DAO and send job (simple thread or Timer).
- Templates (order confirmation, password reset) prepared as simple strings without JSP/Velocity.

**Exit Criteria**

- Email sending confirmed on local SMTP (MailHog, etc.).
- Retry on failure, update `status/retry_count/last_error`.
- Prevent duplicate sending (same `email_queue` record sent only once).

---

## Phase 8: Non-functional / Operations / Docker

**Content**

- log4j MDC (`reqId`), RollingFileAppender configuration.
- Load `app.properties` and integrate with ServiceLocator/Factory.
- DBCP tuning (maxActive/maxIdle/maxWait).
- `Dockerfile` (Tomcat8/JDK8), `Dockerfile.tomcat6`, `docker-compose.yml` (PG) configuration.
- Organize `.dockerignore`.

**Exit Criteria**

- `docker-compose up` starts app+DB, basic flow succeeds.
- WAR size and log rotation as expected.
- `ant war` succeeds within Docker (build reproducibility).

---

## Phase 9: Testing / QA

**Content**

- StrutsTestCase: Actions coverage.
- JUnit + DBUnit: DAO/Service coverage.
- Scenario testing: register→login→search→cart→checkout→cancel→return.
- Load testing (optional) simple check with JMeter/Locust.

**Exit Criteria**

- Test suite green, coverage target 80% (Actions/Services/DAO).
- Regression test checklist completed.
- SQL injection/input validation negative case tests exist.

---

## Phase 10: Release

**Content**

- WAR versioning, release notes creation.
- Deployment procedure document (Tomcat 6/8), organize environment variables and context settings.
- Backup/restore procedure (DB) memo.

**Exit Criteria**

- Deployment to Tomcat6/Tomcat8 executed and verified.
- Documentation updated (README/implementation plan/operations procedures).

---

## Additional Notes (Cross-cutting)

- Comply with coding standards (Java 1.5 syntax, generics optional, no annotations).
- Review checklist (SQL injection, null check, logging, exception conversion, transaction boundaries, Idempotency).
- Lint/Checkstyle (Java 5 configuration) optional introduction.
- i18n: `messages.properties` / `messages_ja.properties`.
- Runbook: Thread dump acquisition, log rotation check procedures.
- Transaction policy: Start/commit in service layer, DAO layer transaction-agnostic.
- Idempotency: Prevent duplicates with `order_number` and `email_queue` send flag/unique constraints.
