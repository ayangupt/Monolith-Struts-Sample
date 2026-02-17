# App Modernization Demo - Ready to Go! 🚀

This folder contains **6 project states** ready for your demo tomorrow.

## 📁 Folder Structure

| Folder | Branch | Technology Stack | Use In Demo |
|--------|--------|------------------|-------------|
| **1-struts-original** | `main` | Struts 1.x + Java 1.5 | Part 2: Container Assist & Assessment |
| **2-struts-live-demo** | `main` | Struts 1.x + Java 1.5 | Part 3: Live Phase 1 Migration |
| **3-springboot-live-upgrade** | `springboot27-migration` | Spring Boot 2.7 + Java 8 | Part 3: Live Phase 2 Upgrade |
| **4-java21-upgraded** | `java21-upgraded` | Spring Boot 3.x + Java 21 | Part 4: Review Results |
| **5-springboot27-base** | `springboot27-migration` | Spring Boot 2.7 + Java 8 | Backup/Reference |
| **6-azure-deployed** | `azure-deployed-production` | Spring Boot 3.x + Java 21 + Azure | **Part 5-7: Container Assist & Azure Deploy** |

## 📍 Location

- **Linux Path:** `/home/ayangupta/App-Modernization-Demo`
- **Windows Path:** `\\wsl.localhost\Ubuntu\home\ayangupta\App-Modernization-Demo`

## 🎬 Quick Start Commands

### Open All Folders in VS Code

```bash
# Navigate to demo folder
cd ~/App-Modernization-Demo

# Open separate VS Code windows for each folder
code 1-struts-original &
code 2-struts-live-demo &
code 3-springboot-live-upgrade &
code 4-java21-upgraded &
code 6-azure-deployed &
```

### Or Open All as Multi-Root Workspace

```bash
cd ~/App-Modernization-Demo
code --add 1-struts-original --add 2-struts-live-demo --add 3-springboot-live-upgrade --add 4-java21-upgraded --add 6-azure-deployed
```

## 📋 Pre-Demo Checklist

Run these commands to verify everything is ready:

```bash
# Navigate to demo folder
cd ~/App-Modernization-Demo

# Check all branches are correct
cd 1-struts-original && git branch --show-current  # Should show: main
cd ../2-struts-live-demo && git branch --show-current  # Should show: main
cd ../3-springboot-live-upgrade && git branch --show-current  # Should show: springboot27-migration
cd ../4-java21-upgraded && git branch --show-current  # Should show: java21-upgraded
cd ../5-springboot27-base && git branch --show-current  # Should show: springboot27-migration
cd ../6-azure-deployed && git branch --show-current  # Should show: azure-deployed-production
cd ..

# Verify Docker is running
docker ps

# Verify Azure CLI is logged in
az account show

# Pre-cache Maven dependencies (optional but recommended)
cd 3-springboot-live-upgrade/skishop-springboot27 && mvn dependency:go-offline
cd ../../4-java21-upgraded/skishop-springboot27 && mvn dependency:go-offline
cd ../../6-azure-deployed/appmod-migrated-java21-spring-boot && mvn dependency:go-offline
cd ../..
```

## ⏱️ Demo Timeline (60 Minutes)

### **[0-5 min] Slides**
- No folder needed

### **[5-15 min] Container Assist & Assessment**
- **Use:** `1-struts-original`
- Open in VS Code, run Container Assist and Assessment tools

### **[15-35 min] Live Migrations (Parallel)**
- **Minute 15:** Start Phase 1 Migration in `2-struts-live-demo`
  - Prompt: Migrate Struts → Spring Boot 2.7
  - Tool: Migration Task
- **Minute 17:** Start Phase 2 Upgrade in `3-springboot-live-upgrade`
  - Prompt: Copy from PHASE2_UPGRADE_PROMPT.md
  - Tool: Java Upgrade
- **Minute 17-35:** Toggle between both, show progress

### **[35-45 min] Results Review**
- **Use:** `4-java21-upgraded`
- Show final code, run tests, discuss changes made

### **[45-50 min] Container Assist**
- **Use:** `6-azure-deployed/appmod-migrated-java21-spring-boot`
- Show containerization with Dockerfile and docker-compose.yml

### **[50-55 min] Azure Deployment**
- **Use:** `6-azure-deployed/appmod-migrated-java21-spring-boot`
- Deploy using `azd up` or show pre-deployed infrastructure

### **[55-60 min] Wrap-up & Q&A**

## 🔧 Troubleshooting

### If a folder has uncommitted changes:
```bash
cd <folder-name>
git status
git stash  # Save changes for later
# or
git reset --hard origin/<branch-name>  # Discard all changes
```

### If you need to refresh a folder:
```bash
cd <folder-name>
git fetch --all
git reset --hard origin/<branch-name>
```

### If git conflicts occur during demo:
- **Don't panic!** Switch to pre-completed state (folder 4 or 5)
- Show that folder as "what the tool would have produced"

## 📚 Reference Documents

- **Full Demo Flow:** See [DEMO_FLOW.md](https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/DEMO_FLOW.md) in the main repository
- **Phase 2 Prompts:** See [PHASE2_UPGRADE_PROMPT.md](https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/PHASE2_UPGRADE_PROMPT.md) in the main repository
- **Main README:** See [README.md](https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/README.md) in the main repository

## 🎯 Key Talking Points

### During Container Assist:
- "AI understands legacy requirements automatically"
- "No manual Dockerfile writing needed"

### During Phase 1 Migration:
- "AI migrates framework patterns automatically"
- "Preserves business logic, modernizes infrastructure"

### During Phase 2 Upgrade:
- "AI handles breaking changes (javax → jakarta)"
- "Iterative build fixing - up to 10 attempts"

### During Deployment:
- "Cloud-ready from day one"
- "Azure deployment fully automated"

## ✅ Success Criteria

After demo, audience should understand:
- ✅ App modernization is now AI-assisted
- ✅ Complex migrations can run in parallel
- ✅ Build/test fixing is automatic
- ✅ Security (CVE) checks are built-in
- ✅ Cloud deployment is streamlined

---

**You're all set! Good luck with your demo tomorrow! 🎉**
