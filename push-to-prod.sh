#!/bin/bash

# Push Dev to Prod Script
# This script pushes dev to prod and triggers automatic PR creation

echo "🚀 Pushing Dev to Prod..."
echo "=========================="

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Get current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $current_branch"

echo ""
echo "📋 Steps to push dev to prod:"

echo ""
echo "1. Switch to prod branch:"
echo "   git checkout prod"

echo ""
echo "2. Merge dev into prod:"
echo "   git merge dev"

echo ""
echo "3. Push to prod (this triggers the workflow):"
echo "   git push origin prod"

echo ""
echo "🎯 What will happen:"
echo "   ✅ GitHub Actions will trigger the prod workflow"
echo "   ✅ Terraform plan will run with production credentials"
echo "   ✅ An approval PR will be created automatically"
echo "   ✅ You'll need to review and approve the PR"
echo "   ✅ Merging the approval PR will deploy to production"

echo ""
echo "🔍 After pushing, check:"
echo "   - GitHub Actions tab for workflow status"
echo "   - Pull requests tab for the approval PR"
echo "   - Look for '🚀 Production Deployment - Terraform Changes' PR"

echo ""
echo "⚠️  IMPORTANT: Branch Protection Settings"
echo "   Make sure your prod branch protection is configured as follows:"
echo "   ❌ 'Require a pull request before merging' = DISABLED"
echo "   ✅ 'Require approvals' = ENABLED (1+ reviewers)"
echo "   ✅ 'Dismiss stale PR approvals when new commits are pushed' = ENABLED"
echo "   ✅ 'Require status checks to pass before merging' = ENABLED"

echo ""
echo "📋 Ready to proceed? Run these commands:"
echo "   git checkout prod"
echo "   git merge dev"
echo "   git push origin prod" 