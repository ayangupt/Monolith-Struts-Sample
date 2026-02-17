# Demo Setup - App Modernization Demo

This branch contains automated setup scripts to prepare all 5 project states needed for the App Modernization demo.

## 🚀 Quick Setup (Recommended)

**One command to set up everything:**

```bash
# Clone this branch and run the setup script
git clone -b demo-setup https://github.com/ayangupt/Monolith-Struts-Sample.git demo-setup-temp
cd demo-setup-temp/demo-setup
./setup-demo-environment.sh
```

**What this does:**
1. Creates `~/App-Modernization-Demo` directory
2. Clones all 5 project states from GitHub:
   - `1-struts-original/` (main branch)
   - `2-struts-live-demo/` (main branch)
   - `3-springboot-live-upgrade/` (springboot27-migration branch)
   - `4-java21-upgraded/` (java21-upgraded branch)
   - `5-springboot27-base/` (springboot27-migration branch)
3. Sets up helper files (README, launch script, quick start guide)

**Time:** 3-5 minutes (depending on internet speed)  
**Disk Space:** ~751MB

---

## 📋 What You Get

After running the setup script, you'll have:

```
~/App-Modernization-Demo/
├── 1-struts-original/          (224M) - For Container Assist & Assessment
├── 2-struts-live-demo/         (224M) - For live Phase 1 migration
├── 3-springboot-live-upgrade/  (101M) - For live Phase 2 upgrade
├── 4-java21-upgraded/          (101M) - For results & Azure deployment
├── 5-springboot27-base/        (101M) - For backup/reference
├── README.md                   - Detailed instructions
├── launch-demo.sh             - Quick launch script
└── QUICK-START.txt            - Quick reference guide
```

---

## 🎯 Demo Usage

Once setup is complete:

### Option 1: Launch All Folders
```bash
cd ~/App-Modernization-Demo
./launch-demo.sh
```

### Option 2: Open Individual Folders
```bash
cd ~/App-Modernization-Demo
code 1-struts-original           # Part 2: Container Assist
code 2-struts-live-demo          # Part 3: Phase 1 Migration
code 3-springboot-live-upgrade   # Part 3: Phase 2 Upgrade
code 4-java21-upgraded           # Part 4-5: Results & Deploy
```

### Option 3: View Quick Reference
```bash
cd ~/App-Modernization-Demo
cat QUICK-START.txt
```

---

## 📖 Documentation

Comprehensive documentation is available in the main repository:

- **Demo Flow Guide:** [DEMO_FLOW.md](https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/DEMO_FLOW.md)
- **Phase 2 Prompts:** [PHASE2_UPGRADE_PROMPT.md](https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/PHASE2_UPGRADE_PROMPT.md)
- **Main README:** [README.md](https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/README.md)

---

## 🔧 Manual Setup (Alternative)

If you prefer to set up manually without the automated script:

```bash
# Create demo directory
mkdir -p ~/App-Modernization-Demo
cd ~/App-Modernization-Demo

# Clone each state manually
git clone -b main https://github.com/ayangupt/Monolith-Struts-Sample.git 1-struts-original
git clone -b main https://github.com/ayangupt/Monolith-Struts-Sample.git 2-struts-live-demo
git clone -b springboot27-migration https://github.com/ayangupt/Monolith-Struts-Sample.git 3-springboot-live-upgrade
git clone -b java21-upgraded https://github.com/ayangupt/Monolith-Struts-Sample.git 4-java21-upgraded
git clone -b springboot27-migration https://github.com/ayangupt/Monolith-Struts-Sample.git 5-springboot27-base

# Download helper files from demo-setup branch
curl -O https://raw.githubusercontent.com/ayangupt/Monolith-Struts-Sample/demo-setup/demo-setup/README.md
curl -O https://raw.githubusercontent.com/ayangupt/Monolith-Struts-Sample/demo-setup/demo-setup/launch-demo.sh
curl -O https://raw.githubusercontent.com/ayangupt/Monolith-Struts-Sample/demo-setup/demo-setup/QUICK-START.txt
chmod +x launch-demo.sh
```

---

## ✨ Files in This Branch

| File | Description |
|------|-------------|
| `setup-demo-environment.sh` | Automated setup script (clones all 5 states) |
| `README.md` | Instructions for demo folder usage |
| `launch-demo.sh` | Quick launcher for all VS Code windows |
| `QUICK-START.txt` | Quick reference guide for demo day |
| `SETUP.md` | This file - setup instructions |

---

## 🎬 Demo Timeline (60 Minutes)

| Time | Folder | Activity |
|------|--------|----------|
| 0-5 min | (Slides) | Introduction |
| 5-15 min | 1-struts-original | Container Assist & Assessment |
| 15 min | 2-struts-live-demo | START Phase 1 Migration ⏰ |
| 17 min | 3-springboot-live-upgrade | START Phase 2 Upgrade ⏰ |
| 17-35 min | Toggle between 2 & 3 | Monitor both migrations |
| 35-45 min | 4-java21-upgraded | Review results, run tests |
| 45-55 min | 4-java21-upgraded | Deploy to Azure |
| 55-60 min | - | Wrap-up & Q&A |

---

## 🆘 Troubleshooting

### "Demo directory already exists"
The setup script will ask if you want to remove and recreate it. Choose yes if starting fresh.

### Git clone is slow
This is normal - cloning 5 repositories with full history takes time. The script shows progress for each clone.

### Permission denied on scripts
Run: `chmod +x setup-demo-environment.sh launch-demo.sh`

### Need to re-setup
```bash
rm -rf ~/App-Modernization-Demo
cd /path/to/demo-setup-temp/demo-setup
./setup-demo-environment.sh
```

---

## 📊 Comparison: Automated vs Manual

| Aspect | Automated Setup | Manual Setup |
|--------|----------------|--------------|
| **Time** | 3-5 minutes | 10-15 minutes |
| **Commands** | 3 commands | 12+ commands |
| **Error-prone** | Low | Medium |
| **Helper files** | Auto-included | Manual download |

---

## ✅ Pre-Demo Checklist

After setup, run these on demo day:

```bash
cd ~/App-Modernization-Demo

# Verify all branches
for dir in */; do 
    echo "Checking $dir: $(cd $dir && git branch --show-current)"
done

# Verify tools
docker ps              # Docker running?
az account show        # Azure logged in?

# Pre-cache Maven dependencies (saves time)
cd 3-springboot-live-upgrade/skishop-springboot27 && mvn dependency:go-offline
cd ../../4-java21-upgraded/skishop-springboot27 && mvn dependency:go-offline
cd ../..
```

---

**Ready to set up your demo? Run the setup script above! 🚀**
