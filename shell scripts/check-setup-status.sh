#!/bin/bash

# CI/CD Setup Status Checker
# This script checks the current status of your CI/CD setup

echo "🔍 Checking CI/CD Setup Status..."
echo "=================================="

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

echo ""
echo "📁 Repository Structure:"

# Check for required files
files=(
    ".github/workflows/terraform-dev.yml"
    ".github/workflows/terraform-prod.yml"
    ".github/workflows/switch-backend.yml"
    "backend-dev.tf"
    "backend-prod.tf"
    "dev.tfvars"
    "prod.tfvars"
    "README.md"
    "SETUP_CHECKLIST.md"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file (missing)"
    fi
done

echo ""
echo "🌿 Branch Status:"

# Check branches
branches=("main" "dev" "prod")
for branch in "${branches[@]}"; do
    if git show-ref --verify --quiet refs/heads/$branch 2>/dev/null; then
        echo "✅ $branch branch exists locally"
    else
        echo "❌ $branch branch missing locally"
    fi
done

echo ""
echo "🔗 Remote Branch Status:"

# Check remote branches
for branch in "${branches[@]}"; do
    if git ls-remote --heads origin $branch | grep -q $branch; then
        echo "✅ $branch branch exists on remote"
    else
        echo "❌ $branch branch missing on remote"
    fi
done

echo ""
echo "📋 Current Branch: $(git rev-parse --abbrev-ref HEAD)"

echo ""
echo "🎯 Setup Status Summary:"
echo "========================"

# Count existing files
existing_files=0
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        ((existing_files++))
    fi
done

echo "Files: $existing_files/${#files[@]} created"
echo ""

if [ $existing_files -eq ${#files[@]} ]; then
    echo "✅ All CI/CD files are present!"
    echo ""
    echo "📋 Remaining tasks:"
    echo "1. Configure GitHub Secrets"
    echo "2. Set up branch protection rules"
    echo "3. Test the workflows"
else
    echo "⚠️  Some files are missing. Run the setup again."
fi

echo ""
echo "📖 For detailed setup instructions, see SETUP_CHECKLIST.md" 