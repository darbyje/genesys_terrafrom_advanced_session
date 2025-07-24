#!/bin/bash

# Fix Backend Configuration Issue
# This script helps resolve the backend configuration error

echo "🔧 Fixing Backend Configuration Issue..."
echo "========================================"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

echo ""
echo "📋 The Issue:"
echo "   Terraform detected a change in backend configuration"
echo "   This happens when the workflow runs in different contexts"
echo ""

echo "✅ Solution Applied:"
echo "   Added '-reconfigure' flag to terraform init commands"
echo "   This tells Terraform to use the new backend configuration"
echo ""

echo "📝 Updated Files:"
echo "   - .github/workflows/terraform-dev.yml"
echo "   - .github/workflows/terraform-prod.yml"
echo ""

echo "🚀 Next Steps:"
echo "1. Commit the updated workflows"
echo "2. Push to dev to test"
echo "3. Then push to prod"
echo ""

echo "📋 Commands to run:"
echo "   git add .github/workflows/"
echo "   git commit -m 'Fix backend configuration with -reconfigure flag'"
echo "   git push origin dev"
echo ""

echo "🎯 What -reconfigure does:"
echo "   - Forces Terraform to use the new backend configuration"
echo "   - Ignores any existing backend state"
echo "   - Safe to use when you know the backend config is correct"
echo ""

echo "⚠️  Important:"
echo "   This fix ensures the workflow works in all contexts"
echo "   Both dev and prod workflows now use -reconfigure"
echo "   This prevents the backend configuration error" 