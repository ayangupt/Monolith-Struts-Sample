#!/bin/bash

# App Modernization Demo - Quick Launch Script
# This script opens all demo folders in separate VS Code windows

echo "🚀 Launching App Modernization Demo..."
echo ""

# Check if we're in the right directory
if [ ! -d "1-struts-original" ]; then
    echo "❌ Error: Please run this script from the App-Modernization-Demo folder"
    exit 1
fi

echo "Opening VS Code windows for each demo state..."
echo ""

# Open each folder in a separate VS Code window
echo "📁 Opening 1-struts-original (Container Assist & Assessment)"
code 1-struts-original &
sleep 2

echo "📁 Opening 2-struts-live-demo (Live Phase 1 Migration)"
code 2-struts-live-demo &
sleep 2

echo "📁 Opening 3-springboot-live-upgrade (Live Phase 2 Upgrade)"
code 3-springboot-live-upgrade &
sleep 2

echo "📁 Opening 4-java21-upgraded (Results & Deployment)"
code 4-java21-upgraded &
sleep 2

echo ""
echo "✅ All demo folders opened!"
echo ""
echo "📋 Quick Reference:"
echo "   Folder 1: Use for Container Assist & Assessment"
echo "   Folder 2: Use for Phase 1 (Struts → Spring Boot) live demo"
echo "   Folder 3: Use for Phase 2 (Java 8 → 21) live demo"
echo "   Folder 4: Use for final results & Azure deployment"
echo ""
echo "📖 See README.md for detailed instructions"
echo ""
echo "Good luck with your demo! 🎉"
