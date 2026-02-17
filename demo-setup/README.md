# App Modernization Demo - Internal Cheat Sheet 🎯

**Quick Reference Guide for Demo Day**

---

## 🚀 SETUP (Run This First)

```bash
# One command to set up everything:
git clone -b demo-setup https://github.com/ayangupt/Monolith-Struts-Sample.git demo-temp
cd demo-temp/demo-setup
./setup-demo-environment.sh

# After setup completes:
cd ~/App-Modernization-Demo
./launch-demo.sh
```

**Setup Time:** 3-5 minutes  
**Creates:** `~/App-Modernization-Demo/` with 5 folders

---

## 📁 FOLDER CHEAT SHEET

| # | Folder Name | Branch | Stack | When to Use |
|---|-------------|--------|-------|-------------|
| 1 | `1-struts-original` | main | Struts 1.x + Java 1.5 | **Min 5-15:** Container Assist & Assessment |
| 2 | `2-struts-live-demo` | main | Struts 1.x + Java 1.5 | **Min 15:** START Phase 1 Migration |
| 3 | `3-springboot-live-upgrade` | springboot27-migration | Spring Boot 2.7 + Java 8 | **Min 17:** START Phase 2 Upgrade |
| 4 | `4-java21-upgraded` | java21-upgraded | Spring Boot 3.x + Java 21 | **Min 35-55:** Results & Azure Deploy |
| 5 | `5-springboot27-base` | springboot27-migration | Spring Boot 2.7 + Java 8 | **Backup** (if demos fail) |

---

## ⏱️ 60-MINUTE DEMO TIMELINE

### Part 1: Introduction (0-5 min)
- **Activity:** Presentation slides
- **Folder:** None needed
- **Key Points:** EOL frameworks, security risks, modernization benefits

### Part 2: Container Assist & Assessment (5-15 min)
- **Folder:** Open `1-struts-original` in VS Code
- **Activities:**
  1. **Container Assist** (2-3 min)
     ```
     Prompt: I need to containerize and run this Struts application.
     ```
  2. **Code Understanding** (2-3 min)
     ```
     Prompt: Analyze this codebase - frameworks, components, patterns, security concerns
     ```
  3. **Assessment Tool** (3-5 min)
     ```
     Prompt: Run full technical assessment - EOL status, vulnerabilities, migration complexity
     ```

### Part 3: Live Migrations (15-35 min) ⏰ PARALLEL EXECUTION

#### Minute 15: Start Phase 1 Migration
- **Folder:** Open `2-struts-live-demo` in VS Code
- **Tool:** Migration Task (appmod-run-task)
- **Prompt:**
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
- **Expected Duration:** 15-20 minutes
- **Shows:** Auto framework migration, code conversion, build fixing

#### Minute 17: Start Phase 2 Upgrade
- **Folder:** Open `3-springboot-live-upgrade` in VS Code
- **Tool:** Java Upgrade (#generate_upgrade_plan)
- **Prompt:** Use comprehensive prompt from `PHASE2_UPGRADE_PROMPT.md`
  ```
  @workspace #generate_upgrade_plan
  
  I need to upgrade this Spring Boot application from Java 8 to Java 21 
  and Spring Boot 2.7.x to Spring Boot 3.x.
  
  [Full prompt - see PHASE2_UPGRADE_PROMPT.md]
  ```
- **Expected Duration:** 10-15 minutes
- **Shows:** Auto Java upgrade, javax→jakarta, build/test fixing

#### Minutes 17-35: Monitor Both
- Toggle between folders 2 and 3
- Show progress bars, code changes, commit messages
- Highlight: Parallel execution, automated fixing

### Part 4: Results Review (35-45 min)
- **Folder:** Open `4-java21-upgraded` in VS Code
- **Activities:**
  1. **Code Comparison** (3 min) - Show before/after side-by-side
  2. **Build & Test** (3 min)
     ```bash
     cd ~/App-Modernization-Demo/4-java21-upgraded/skishop-springboot27
     mvn clean test
     ```
  3. **Run Application** (3 min)
     ```bash
     mvn spring-boot:run
     # Access: http://localhost:8080
     ```

### Part 5: Azure Deployment (45-55 min)
- **Folder:** Continue in `4-java21-upgraded`
- **Activities:**
  1. **Container Assist for Deployment** (2-3 min)
     ```
     Prompt: Deploy this Spring Boot application to Azure Container Apps
     ```
  2. **Execute Deployment** (5-7 min) - Follow Copilot's commands
  3. **Show Deployed App** (1 min) - Open Azure URL

### Part 6: Wrap-up & Q&A (55-60 min)
- Summary of what was accomplished
- Time savings, automation benefits
- Q&A

---

## 🎤 KEY TALKING POINTS

### During Container Assist:
- "AI understands legacy requirements automatically"
- "No manual Dockerfile writing needed"
- "Works with decades-old technology"

### During Phase 1 Migration:
- "AI migrates framework patterns automatically"
- "Preserves business logic, modernizes infrastructure"
- "Handles Struts→Spring, JSP→Thymeleaf, JDBC→JPA"

### During Phase 2 Upgrade:
- "AI handles breaking changes (javax → jakarta)"
- "Iterative build fixing - up to 10 attempts"
- "Test fixing maintains code coverage"
- "CVE checking ensures security"

### During Deployment:
- "Cloud-ready from day one"
- "AI generates optimal production Dockerfile"
- "Azure deployment fully automated"

---

## 📋 IMPORTANT PROMPTS (Quick Reference)

### Phase 1: Migration Task
```
I need to migrate this Struts 1.x application to Spring Boot 2.7 with Java 8.
Please use the app modernization migration task to convert framework patterns
and execute the full migration workflow.
```

### Phase 2: Java Upgrade
**Location:** Full prompt in `PHASE2_UPGRADE_PROMPT.md`
**Key:** Use the "Comprehensive Prompt (Option 1)" for demo

### Container Assist
```
I need to containerize and run this [Struts/Spring Boot] application.
Help me understand requirements and create a Dockerfile.
```

### Assessment
```
Run a full technical assessment including framework versions, EOL status,
security vulnerabilities, and migration complexity.
```

### Azure Deployment
```
Deploy this Spring Boot application to Azure Container Apps.
Create production Dockerfile and deployment configuration.
```

---

---

## 🔧 PRE-DEMO CHECKLIST

**Run these the morning of your demo:**

```bash
cd ~/App-Modernization-Demo

# ✅ Verify all branches
for dir in */; do 
    echo "Checking $dir: $(cd $dir && git branch --show-current)"
done

# ✅ Verify Docker
docker ps

# ✅ Verify Azure CLI
az account show
az account list --output table

# ✅ Pre-cache Maven dependencies (IMPORTANT - saves 5-10 min during demo)
cd 3-springboot-live-upgrade/skishop-springboot27
mvn dependency:go-offline
cd ../../4-java21-upgraded/skishop-springboot27
mvn dependency:go-offline
cd ../..

# ✅ Test database connection (if using PostgreSQL)
# psql -h localhost -U postgres -d skishop -c "SELECT 1;"
```

---

## 🆘 BACKUP PLANS (If Things Go Wrong)

### If Migration/Upgrade Takes Too Long:
1. Show it running for 5 minutes
2. Explain what's happening
3. **Switch to folder 4 or 5** (pre-completed states)
4. Say: "This is what the tool produces"

### If Network Fails:
1. Skip Azure deployment
2. Run `docker-compose up` locally from folder 4
3. Show app running on localhost:8080

### If Live Demo Completely Fails:
1. Have pre-recorded video ready (record one during practice)
2. Show screenshots of key steps
3. Walk through folder 4 code to show results

---

## 🎯 TOOLS & TERMINOLOGY CHEAT SHEET

### Phase 1 (Struts → Spring Boot)
- **Tool:** Migration Task (`appmod-run-task`)
- **NOT:** Java Upgrade tool (won't work on Struts)
- **Duration:** 15-20 minutes
- **Creates:** New Branch with Spring Boot code

### Phase 2 (Java 8 → 21)
- **Tool:** Java Upgrade (`#generate_upgrade_plan`)
- **Requires:** Modern Spring Boot base (Phase 1 complete)
- **Duration:** 10-15 minutes
- **Handles:** javax→jakarta, Spring Security updates, build/test fixing

### Container Assist
- **Purpose:** Containerization, deployment
- **Works with:** Any application (legacy or modern)
- **Generates:** Dockerfiles, docker-compose.yml

### Assessment Tool
- **Purpose:** Technical analysis
- **Identifies:** EOL frameworks, CVEs, migration complexity
- **Output:** Detailed report with recommendations

---

## 📊 EXPECTED RESULTS

By end of demo, show:
- ✅ Migrated from Struts 1.x → Spring Boot 3.x
- ✅ Upgraded from Java 1.5 → Java 21
- ✅ All tests passing
- ✅ Application running (locally or Azure)
- ✅ No manual coding required
- ✅ Time: ~30 minutes of actual AI work (vs weeks manual)

---

## 💡 DEMO TIPS

### Audience Questions to Anticipate:
**Q:** How accurate is the migration?  
**A:** Tool includes validation - consistency checks, completeness scans, CVE checks

**Q:** What about our custom business logic?  
**A:** Migration preserves logic, only updates framework patterns. Show consistency validation.

**Q:** Can this work with [other framework]?  
**A:** Yes - tool supports multiple migration paths. Show available tasks.

**Q:** Integration with CI/CD?  
**A:** All changes committed to git, ready for your pipeline. Show branch structure.

**Q:** What if we have complex dependencies?  
**A:** Tool handles dependencies, tests, configurations. Show the upgrade plan generation.

### What to Emphasize:
- ⭐ **Automation** - Not code generation, actual full workflow automation
- ⭐ **Intelligence** - AI understands legacy patterns, not just find/replace
- ⭐ **Validation** - Built-in checks ensure quality
- ⭐ **Productivity** - Weeks→Hours, parallel execution
- ⭐ **Safety** - Version control, iterative fixing, rollback capability

### What NOT to Say:
- ❌ "This always works perfectly" (be honest about complexity)
- ❌ "No manual work needed" (some edge cases may need manual fixes)
- ❌ "Replaces developers" (it's a productivity tool, not replacement)

---

## 📂 FILE LOCATIONS (Quick Reference)

```
~/App-Modernization-Demo/
├── 1-struts-original/           ← Min 5-15: Container & Assessment
├── 2-struts-live-demo/          ← Min 15: START Phase 1
├── 3-springboot-live-upgrade/   ← Min 17: START Phase 2
├── 4-java21-upgraded/           ← Min 35-55: Results & Deploy
├── 5-springboot27-base/         ← Backup
├── README.md                    ← This file
├── launch-demo.sh              ← Opens all VS Code windows
└── QUICK-START.txt             ← One-page reference
```

### GitHub Documentation:
- **Main README:** https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/README.md
- **Demo Flow:** https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/DEMO_FLOW.md
- **Phase 2 Prompts:** https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/PHASE2_UPGRADE_PROMPT.md

---

## 🚀 LAUNCH COMMANDS

```bash
# Open all folders at once
cd ~/App-Modernization-Demo
./launch-demo.sh

# Or open individually
code 1-struts-original
code 2-struts-live-demo
code 3-springboot-live-upgrade
code 4-java21-upgraded
```

---

## ✅ SUCCESS METRICS TO HIGHLIGHT

- **Time Saved:** Weeks of manual work → 30 minutes automated
- **Risk Reduced:** Automated validation & testing
- **Quality Maintained:** Tests pass, behavior preserved
- **Security Improved:** CVE checking, modern frameworks
- **Cloud Ready:** Deployed to Azure in minutes

---

**🎯 You're ready! Good luck with your demo!**

# Verify Docker is running
docker ps

# Verify Azure CLI is logged in
az account show

```
