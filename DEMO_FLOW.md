# Demo Flow: Application Modernization with GitHub Copilot
## 1-Hour Demo Plan

### Pre-Demo Setup (Do Before Demo Starts)

1. **Clone repository into 4 separate folders:**
   ```bash
   # Folder 1: Original Struts Application
   git clone https://github.com/ayangupt/Monolith-Struts-Sample.git struts-original
   cd struts-original
   git checkout main
   
   # Folder 2: Spring Boot 2.7 + Java 8 (Phase 1 Complete)
   git clone https://github.com/ayangupt/Monolith-Struts-Sample.git springboot27-base
   cd springboot27-base
   git checkout springboot27-migration
   
   # Folder 3: Java 21 Upgraded (Phase 2 Complete)
   git clone https://github.com/ayangupt/Monolith-Struts-Sample.git java21-upgraded
   cd java21-upgraded
   git checkout java21-upgraded
   
   # Folder 4: For Live Demo of Phase 1 Migration
   git clone https://github.com/ayangupt/Monolith-Struts-Sample.git struts-live-demo
   cd struts-live-demo
   git checkout main
   
   # Folder 5: For Live Demo of Phase 2 Upgrade
   git clone https://github.com/ayangupt/Monolith-Struts-Sample.git springboot-live-upgrade
   cd springboot-live-upgrade
   git checkout springboot27-migration
   ```

2. **Open VS Code windows/tabs:**
   - Tab 1: `struts-original` (for Container Assist & Assessment)
   - Tab 2: `struts-live-demo` (for live Phase 1 migration)
   - Tab 3: `springboot-live-upgrade` (for live Phase 2 upgrade)
   - Tab 4: `java21-upgraded` (final result showcase)

3. **Have Azure CLI logged in:**
   ```bash
   az login
   az account set --subscription <your-subscription-id>
   ```

---

## Demo Flow (60 Minutes)

### **[0-5 min] Part 1: Introduction & Slides**
- Quick intro to the SkiShop legacy application
- Pain points: Struts 1.x (EOL), Java 1.5, security issues
- Show the two-phase modernization strategy

---

### **[5-15 min] Part 2: Understanding the Legacy App**

**🎯 Goal:** Show AI-powered analysis tools

**In Tab 1 (`struts-original`):**

1. **Container Assist** (2-3 min)
   ```
   @workspace I need to containerize and run this Struts application. 
   Help me understand the application requirements and create a Dockerfile.
   ```
   - Show: Auto-detection of Java 1.5, Tomcat 6, PostgreSQL
   - Show: Generated Dockerfile
   - (Optional) Run: `docker-compose up` to show app running

2. **Code Understanding via Copilot Chat** (2-3 min)
   ```
   @workspace Analyze this codebase:
   - What frameworks and libraries are being used?
   - What are the main application components?
   - What design patterns are used?
   - What are the security concerns?
   ```
   - Show: Copilot's understanding of Struts Actions, JSPs, JDBC patterns

3. **Assessment Tool** (3-5 min)
   ```
   Run a full technical assessment of this Java application including:
   - Framework versions and EOL status
   - Security vulnerabilities
   - Code quality issues
   - Migration complexity analysis
   ```
   - Show: Generated assessment report
   - Highlight: Struts 1.x EOL, Java 1.5 security issues, migration recommendations

---

### **[15-35 min] Part 3: Live Migration Demo (Phase 1)**

**🎯 Goal:** Show automated Struts → Spring Boot migration

**In Tab 2 (`struts-live-demo`):**

⚠️ **CRITICAL: This is Phase 1 - Use Migration Task, NOT Java Upgrade**

1. **Check available migration tasks** (1 min)
   ```
   @workspace What migration tasks are available for this legacy Struts application?
   ```

2. **Start Migration Task** (1-2 min to start)
   ```
   I need to migrate this Struts 1.x application to Spring Boot 2.7 with Java 8.
   
   Please use the app modernization migration task to:
   - Convert Struts Actions to Spring Controllers
   - Convert JSPs to Thymeleaf templates
   - Migrate JDBC to Spring Data JPA
   - Update security to Spring Security
   - Modernize the build configuration
   
   Create a new branch and execute the full migration workflow.
   ```
   
3. **While Task 1 Runs (15-20 min), Switch to Tab 3 for Phase 2** ⏰

**In Tab 3 (`springboot-live-upgrade`):**

4. **Start Java Upgrade** (1-2 min to start)
   
   Copy the comprehensive prompt from `PHASE2_UPGRADE_PROMPT.md`:
   ```
   @workspace #generate_upgrade_plan
   
   I need to upgrade this Spring Boot application from Java 8 to Java 21 
   and Spring Boot 2.7.x to Spring Boot 3.x.
   
   [... full prompt from PHASE2_UPGRADE_PROMPT.md ...]
   ```

5. **Monitor Both Tasks** (remaining time)
   - Toggle between Tab 2 and Tab 3
   - Show progress of both migrations in parallel
   - Highlight: Code changes, build fixing, test fixing
   - Show: Automatic commit messages

---

### **[35-45 min] Part 4: Results Review**

**🎯 Goal:** Show what was accomplished

**Switch to Tab 4 (`java21-upgraded`):**

1. **Show Final Modernized Code** (3-4 min)
   - Compare side-by-side:
     - `struts-original/` (Struts Action) 
     - `java21-upgraded/` (Spring Boot Controller)
   - Highlight: javax → jakarta, Spring Security updates
   - Show: Modern test patterns

2. **Verify Build & Tests** (2-3 min)
   ```bash
   cd java21-upgraded/skishop-springboot27
   mvn clean test
   # Show: All tests passing
   ```

3. **Run Modernized Application** (2-3 min)
   ```bash
   mvn spring-boot:run
   ```
   - Access: http://localhost:8080
   - Show: Same functionality, modern stack

---

### **[45-55 min] Part 5: Deploy to Azure**

**🎯 Goal:** Show cloud deployment

**In Tab 4 (`java21-upgraded`):**

1. **Container Assist for Deployment** (2-3 min)
   ```
   @workspace I need to deploy this Spring Boot application to Azure.
   Create a Dockerfile optimized for production and help me deploy 
   to Azure Container Apps.
   ```

2. **Execute Deployment** (5-7 min)
   - Follow Copilot's suggested commands
   - OR use pre-defined task:
     ```
     @workspace Use the Azure deployment task to deploy this 
     Spring Boot application to Azure Container Apps
     ```
   - Show: Container building, pushing to ACR, deploying

3. **Access Deployed Application** (1 min)
   - Open: https://[your-app].azurecontainerapps.io
   - Show: Fully migrated and modernized app running in Azure

---

### **[55-60 min] Part 6: Wrap-up & Q&A**

**Key Takeaways:**
- ✅ Automated migration from EOL framework (Struts) to modern (Spring Boot)
- ✅ Automated Java upgrade (8 → 21)
- ✅ Automated build & test fixing
- ✅ Security improvements (CVE checking)
- ✅ Cloud deployment readiness
- ✅ All with AI assistance - minimal manual coding

**Success Metrics:**
- 🕐 Time saved: Weeks of manual work → 1 hour automated
- 📊 Code coverage: Maintained (tests auto-fixed)
- 🔒 Security: Vulnerabilities addressed
- ☁️ Cloud-ready: Deployed to Azure

---

## Required States / Folders

| Folder Name | Branch | Purpose | When Used |
|------------|--------|---------|-----------|
| `struts-original` | main | Show original Struts app | Part 2: Container Assist, Assessment |
| `struts-live-demo` | main | Live Phase 1 migration | Part 3: Migration task demo |
| `springboot-live-upgrade` | springboot27-migration | Live Phase 2 upgrade | Part 3: Upgrade task demo |
| `java21-upgraded` | java21-upgraded | Show final result | Part 4-5: Review & Deploy |
| `springboot27-base` | springboot27-migration | (Backup/Reference) | Optional fallback |

---

## Parallel Execution Strategy

### ⏰ Timeline Optimization

```
Minute 0-15:  Folder 1 (Container + Assessment)
Minute 15:    Start Task in Folder 2 (Phase 1 Migration) ⏳ Runs 15-20 min
Minute 17:    Start Task in Folder 3 (Phase 2 Upgrade)   ⏳ Runs 10-15 min
Minute 17-35: Monitor both tasks, show progress points
Minute 35:    Review completed tasks
Minute 45:    Deploy to Azure
```

### What Runs in Parallel:

1. **Phase 1 Migration** (Folder 2: Struts → Spring Boot) - 15-20 min
2. **Phase 2 Upgrade** (Folder 3: Java 8 → Java 21) - 10-15 min

These are **independent** and can run simultaneously in different VS Code windows.

---

## Pre-Demo Checklist

### Code Repositories
- [ ] All 5 folders cloned and on correct branches
- [ ] Each folder opens in separate VS Code window
- [ ] Git is clean (no uncommitted changes)

### Tools & Extensions
- [ ] GitHub Copilot extension installed and active
- [ ] App Modernization extension enabled
- [ ] Docker Desktop running
- [ ] Azure CLI logged in
- [ ] Maven/Java tools available

### Azure Resources (Pre-created or Ready to Create)
- [ ] Azure subscription selected
- [ ] Resource group ready (or will create)
- [ ] Azure Container Registry (or will create)
- [ ] Azure Container Apps environment (or will create)

### Demo Materials
- [ ] Presentation slides ready
- [ ] PHASE2_UPGRADE_PROMPT.md open for copy-paste
- [ ] Browser tabs ready for deployed app
- [ ] Terminal windows arranged

### Backup Plans
- [ ] Pre-recorded video of successful migration (if live demo fails)
- [ ] Screenshots of key steps
- [ ] Alternative: Show pre-completed states if time runs short

---

## Risk Mitigation

### If Tasks Take Too Long:

**Option A:** Show Progress, Then Switch to Completed State
- Show the task running for 5 minutes
- Explain what's happening
- Switch to pre-completed folder to show results

**Option B:** Speed Through to Deployment
- Skip detailed code review
- Go straight to deployment from `java21-upgraded` folder

### If Network Issues:

**Option C:** Local Docker Demo
- Skip Azure deployment
- Run `docker-compose up` on final state
- Show app running locally

---

## Key Demo Talking Points

### During Container Assist:
- "AI understands legacy requirements automatically"
- "No manual Dockerfile writing needed"

### During Assessment:
- "AI identifies technical debt and risks"
- "Prioritizes migration based on EOL status"

### During Migration (Phase 1):
- "AI migrates framework patterns automatically"
- "Preserves business logic, modernizes infrastructure"

### During Upgrade (Phase 2):
- "AI handles breaking changes (javax → jakarta)"
- "Iterative build fixing - up to 10 attempts"
- "Test fixing - maintains code coverage"

### During Deployment:
- "Cloud-ready from day one"
- "AI generates optimal production Dockerfile"
- "Azure deployment fully automated"

---

## Questions to Anticipate

**Q: How accurate is the migration?**
A: Tool includes validation stages - consistency, completeness, CVE checks

**Q: What if our app is more complex?**
A: Tool handles dependencies, tests, configurations - show the comprehensive prompt

**Q: Can this work with other frameworks?**
A: Yes - show the available migration tasks (Struts, JSF, etc.)

**Q: What about our custom business logic?**
A: Migration preserves logic, only updates framework patterns - show consistency validation

**Q: Integration with CI/CD?**
A: All changes committed to Git, ready for your pipeline - show the branch structure

---

## Post-Demo Resources to Share

- Link to main README: https://github.com/ayangupt/Monolith-Struts-Sample
- Link to PHASE2_UPGRADE_PROMPT.md for detailed instructions
- Migration branches: springboot27-migration, java21-upgraded
- Documentation on app modernization tools
