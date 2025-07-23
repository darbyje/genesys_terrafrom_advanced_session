#!/bin/bash

# Test Workflow Script
# This script helps test the fixed CI/CD workflows

echo "🧪 Testing CI/CD Workflow Fixes..."
echo "=================================="

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

echo ""
echo "📁 Checking workflow files..."

# Check if workflow files exist and are properly formatted
workflow_files=(
    ".github/workflows/terraform-dev.yml"
    ".github/workflows/terraform-prod.yml"
)

for file in "${workflow_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
        
        # Check for the old switch-backend reference
        if grep -q "switch-backend.yml" "$file"; then
            echo "❌ $file still contains old switch-backend reference"
        else
            echo "✅ $file has been updated correctly"
        fi
        
        # Check for the rm -f backend.tf command
        if grep -q "rm -f backend.tf" "$file"; then
            echo "✅ $file includes backend conflict fix"
        else
            echo "❌ $file missing backend conflict fix"
        fi
    else
        echo "❌ $file missing"
    fi
done

echo ""
echo "🔧 Checking backend configuration files..."

backend_files=(
    "backend-dev.tf"
    "backend-prod.tf"
    "backend-original.tf"
)

for file in "${backend_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
    fi
done

# Check that the original backend.tf is gone
if [ -f "backend.tf" ]; then
    echo "❌ backend.tf still exists (should be removed)"
else
    echo "✅ backend.tf removed (conflict resolved)"
fi

echo ""
echo "🎯 Current branch: $(git rev-parse --abbrev-ref HEAD)"

echo ""
echo "📋 Next steps to test:"
echo "1. Commit these workflow changes"
echo "2. Push to dev branch to test the workflow"
echo "3. Check GitHub Actions to see if the backend conflict is resolved"
echo ""
echo "✅ The 'Duplicate backend configuration' error should now be fixed!" 