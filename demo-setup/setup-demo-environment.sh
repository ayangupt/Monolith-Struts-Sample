#!/bin/bash

# App Modernization Demo - Automated Setup Script
# This script clones all 5 project states needed for the demo

set -e  # Exit on any error

DEMO_DIR="$HOME/App-Modernization-Demo"
REPO_URL="https://github.com/ayangupt/Monolith-Struts-Sample.git"

echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║         APP MODERNIZATION DEMO - AUTOMATED SETUP                             ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Check if demo directory already exists
if [ -d "$DEMO_DIR" ]; then
    echo "⚠️  Demo directory already exists: $DEMO_DIR"
    echo ""
    read -p "Do you want to remove it and start fresh? (y/N): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🗑️  Removing existing demo directory..."
        rm -rf "$DEMO_DIR"
    else
        echo "❌ Setup cancelled. Please remove or rename the existing directory first."
        exit 1
    fi
fi

echo "📁 Creating demo directory: $DEMO_DIR"
mkdir -p "$DEMO_DIR"
cd "$DEMO_DIR"
echo ""

echo "🚀 Cloning 5 project states (this may take a few minutes)..."
echo ""

# Clone Folder 1: Struts Original (for Container Assist & Assessment)
echo "📦 [1/5] Cloning 1-struts-original (main branch)..."
git clone --quiet --branch main --single-branch "$REPO_URL" 1-struts-original
echo "   ✅ Complete: 1-struts-original/ (main branch)"
echo ""

# Clone Folder 2: Struts Live Demo (for Phase 1 migration demo)
echo "📦 [2/5] Cloning 2-struts-live-demo (main branch)..."
git clone --quiet --branch main --single-branch "$REPO_URL" 2-struts-live-demo
echo "   ✅ Complete: 2-struts-live-demo/ (main branch)"
echo ""

# Clone Folder 3: Spring Boot Live Upgrade (for Phase 2 upgrade demo)
echo "📦 [3/5] Cloning 3-springboot-live-upgrade (springboot27-migration branch)..."
git clone --quiet --branch springboot27-migration --single-branch "$REPO_URL" 3-springboot-live-upgrade
echo "   ✅ Complete: 3-springboot-live-upgrade/ (springboot27-migration branch)"
echo ""

# Clone Folder 4: Java 21 Upgraded (for results & deployment)
echo "📦 [4/5] Cloning 4-java21-upgraded (java21-upgraded branch)..."
git clone --quiet --branch java21-upgraded --single-branch "$REPO_URL" 4-java21-upgraded
echo "   ✅ Complete: 4-java21-upgraded/ (java21-upgraded branch)"
echo ""

# Clone Folder 5: Spring Boot Base (for backup/reference)
echo "📦 [5/5] Cloning 5-springboot27-base (springboot27-migration branch)..."
git clone --quiet --branch springboot27-migration --single-branch "$REPO_URL" 5-springboot27-base
echo "   ✅ Complete: 5-springboot27-base/ (springboot27-migration branch)"
echo ""

# Copy demo helper files
echo "📄 Setting up demo helper files..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "$SCRIPT_DIR/README.md" "$DEMO_DIR/" 2>/dev/null || echo "No README.md to copy"
cp "$SCRIPT_DIR/launch-demo.sh" "$DEMO_DIR/" 2>/dev/null || echo "No launch-demo.sh to copy"
cp "$SCRIPT_DIR/QUICK-START.txt" "$DEMO_DIR/" 2>/dev/null || echo "No QUICK-START.txt to copy"
chmod +x "$DEMO_DIR/launch-demo.sh" 2>/dev/null || true
echo ""

# Display summary
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                    SETUP COMPLETE ✅                                          ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "📁 Location: $DEMO_DIR"
echo "🪟 Windows:  \\\\wsl.localhost\\Ubuntu$DEMO_DIR"
echo ""
echo "📋 Created 5 project states:"
echo "   ✅ 1-struts-original/          (main)"
echo "   ✅ 2-struts-live-demo/         (main)"
echo "   ✅ 3-springboot-live-upgrade/  (springboot27-migration)"
echo "   ✅ 4-java21-upgraded/          (java21-upgraded)"
echo "   ✅ 5-springboot27-base/        (springboot27-migration)"
echo ""
echo "🚀 Next Steps:"
echo "   1. cd $DEMO_DIR"
echo "   2. cat QUICK-START.txt"
echo "   3. ./launch-demo.sh"
echo ""
echo "📖 For detailed instructions, see:"
echo "   - README.md in the demo folder"
echo "   - https://github.com/ayangupt/Monolith-Struts-Sample/blob/main/DEMO_FLOW.md"
echo ""
echo "✨ You're ready for your demo! Good luck! 🎉"
