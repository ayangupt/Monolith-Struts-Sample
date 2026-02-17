# Demo Setup Branch - Quick Reference

## ✅ What Was Created

A new git branch **`demo-setup`** has been created and pushed to GitHub with automated setup scripts!

**Branch URL:** https://github.com/ayangupt/Monolith-Struts-Sample/tree/demo-setup

---

## 🚀 How to Use (One Command Setup!)

Instead of manually cloning 5 different branches, you can now do this:

```bash
# Clone the demo-setup branch
git clone -b demo-setup https://github.com/ayangupt/Monolith-Struts-Sample.git demo-temp

# Run the automated setup script
cd demo-temp/demo-setup
./setup-demo-environment.sh
```

**That's it!** The script will automatically:
1. Create `~/App-Modernization-Demo` directory
2. Clone all 5 project states with correct branches:
   - `1-struts-original/` (main)
   - `2-struts-live-demo/` (main)
   - `3-springboot-live-upgrade/` (springboot27-migration)
   - `4-java21-upgraded/` (java21-upgraded)
   - `5-springboot27-base/` (springboot27-migration)
3. Copy all helper files (README, launch script, quick start guide)
4. Set up executable permissions

**Time:** 3-5 minutes  
**Disk Space:** ~751MB

---

## 📋 What's in the demo-setup Branch

```
demo-setup/
├── setup-demo-environment.sh   ⭐ Main setup script (automated cloning)
├── SETUP.md                   📖 Detailed setup instructions
├── README.md                  📖 Demo folder usage guide
├── launch-demo.sh            🚀 Quick launcher for VS Code
└── QUICK-START.txt           📝 Quick reference for demo day
```

---

## 🎯 Use Cases

### Use Case 1: Setting up on a new machine
```bash
git clone -b demo-setup https://github.com/ayangupt/Monolith-Struts-Sample.git demo-temp
cd demo-temp/demo-setup
./setup-demo-environment.sh
```

### Use Case 2: Sharing with colleagues
Send them this command:
```bash
git clone -b demo-setup https://github.com/ayangupt/Monolith-Struts-Sample.git demo-temp && cd demo-temp/demo-setup && ./setup-demo-environment.sh
```

### Use Case 3: Resetting your demo environment
```bash
rm -rf ~/App-Modernization-Demo
cd /path/to/demo-temp/demo-setup
./setup-demo-environment.sh
```

---

## 📊 Comparison: Before vs After

### ❌ Before (Manual - 12+ commands)
```bash
mkdir -p ~/App-Modernization-Demo
cd ~/App-Modernization-Demo
git clone -b main https://github.com/ayangupt/Monolith-Struts-Sample.git 1-struts-original
git clone -b main https://github.com/ayangupt/Monolith-Struts-Sample.git 2-struts-live-demo
git clone -b springboot27-migration https://github.com/ayangupt/Monolith-Struts-Sample.git 3-springboot-live-upgrade
git clone -b java21-upgraded https://github.com/ayangupt/Monolith-Struts-Sample.git 4-java21-upgraded
git clone -b springboot27-migration https://github.com/ayangupt/Monolith-Struts-Sample.git 5-springboot27-base
# ... plus copying helper files manually
```
**Time:** 10-15 minutes  
**Complexity:** High (easy to make mistakes)

### ✅ After (Automated - 3 commands)
```bash
git clone -b demo-setup https://github.com/ayangupt/Monolith-Struts-Sample.git demo-temp
cd demo-temp/demo-setup
./setup-demo-environment.sh
```
**Time:** 3-5 minutes  
**Complexity:** Low (one script does everything)

---

## 🔍 What the Setup Script Does (Behind the Scenes)

1. **Checks for existing demo directory**
   - Prompts to remove if it exists
   
2. **Creates demo directory**
   - Location: `~/App-Modernization-Demo`
   
3. **Clones 5 repositories** (with progress indicators)
   - Uses `--single-branch` for faster cloning
   - Uses `--quiet` to reduce output noise
   
4. **Copies helper files**
   - README.md, launch-demo.sh, QUICK-START.txt
   
5. **Sets permissions**
   - Makes scripts executable
   
6. **Displays summary**
   - Shows what was created
   - Provides next steps

---

## 📖 Documentation

After setup, you'll have access to:

- **Demo folder README:** `~/App-Modernization-Demo/README.md`
- **Quick start guide:** `~/App-Modernization-Demo/QUICK-START.txt`
- **Setup instructions:** In the demo-setup branch at `demo-setup/SETUP.md`
- **Full demo flow:** https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/DEMO_FLOW.md
- **Phase 2 prompts:** https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/PHASE2_UPGRADE_PROMPT.md

---

## 🎬 After Setup - Launch Your Demo

Once the setup is complete:

```bash
cd ~/App-Modernization-Demo

# Option 1: Launch all folders
./launch-demo.sh

# Option 2: View quick reference
cat QUICK-START.txt

# Option 3: Open specific folders
code 1-struts-original
code 2-struts-live-demo
code 3-springboot-live-upgrade
code 4-java21-upgraded
```

---

## ✨ Benefits of the demo-setup Branch

✅ **Single command setup** - No manual cloning of 5 branches  
✅ **Repeatable** - Use on any machine, same result  
✅ **Shareable** - Easy for colleagues to set up  
✅ **Error-proof** - Script handles everything  
✅ **Fast** - Automated = 3-5 min vs 10-15 min manual  
✅ **Documentation included** - All helper files bundled  

---

## 🆘 Troubleshooting

### Issue: "Demo directory already exists"
**Solution:** The script will prompt you. Choose 'y' to remove and recreate.

### Issue: Git clone is slow
**Solution:** This is normal. The script clones 5 full repositories (~751MB total).

### Issue: Permission denied
**Solution:** 
```bash
chmod +x setup-demo-environment.sh
./setup-demo-environment.sh
```

### Issue: Script not found
**Solution:** Make sure you're in the `demo-setup` directory:
```bash
cd demo-temp/demo-setup
ls -la  # Should see setup-demo-environment.sh
```

---

## 🎉 You're All Set!

Your demo-setup branch is live on GitHub. You or anyone else can now set up the entire demo environment with just 3 commands!

**Branch:** https://github.com/ayangupt/Monolith-Struts-Sample/tree/demo-setup

**Quick Setup Command:**
```bash
git clone -b demo-setup https://github.com/ayangupt/Monolith-Struts-Sample.git demo-temp && cd demo-temp/demo-setup && ./setup-demo-environment.sh
```
