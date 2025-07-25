#!/bin/bash

# Debug PR Creation Issues
# This script helps identify why automatic PR creation might be failing

echo "🔍 Debugging PR Creation Issues..."
echo "=================================="

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

echo ""
echo "📋 Common PR Creation Errors and Solutions:"
echo ""

echo "1. 🔐 Permission Issues:"
echo "   Error: 'Resource not accessible by integration'"
echo "   Solution: Check repository permissions for GITHUB_TOKEN"
echo "   - Go to Settings → Actions → General"
echo "   - Ensure 'Workflow permissions' is set to 'Read and write permissions'"
echo ""

echo "2. 🌿 Branch Conflicts:"
echo "   Error: 'Branch prod-deployment already exists'"
echo "   Solution: The workflow tries to create 'prod-deployment' branch"
echo "   - Check if this branch exists locally or remotely"
echo "   - Delete it if it exists: git push origin --delete prod-deployment"
echo ""

echo "3. 📝 No Changes Detected:"
echo "   Error: 'No changes to commit'"
echo "   Solution: Terraform plan shows no changes"
echo "   - This is normal if no infrastructure changes are needed"
echo "   - The workflow won't create a PR if there are no changes"
echo ""

echo "4. 🔄 Workflow Token Issues:"
echo "   Error: 'Not Found' or 'Bad credentials'"
echo "   Solution: GITHUB_TOKEN might not have sufficient permissions"
echo "   - Check repository settings"
echo "   - Ensure the token has write access to pull requests"
echo ""

echo "🔍 Current Status Check:"
echo "========================"

# Check current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $current_branch"

# Check if prod-deployment branch exists
if git show-ref --verify --quiet refs/remotes/origin/prod-deployment; then
    echo "⚠️  prod-deployment branch exists remotely"
    echo "   This might cause conflicts. Consider deleting it:"
    echo "   git push origin --delete prod-deployment"
else
    echo "✅ prod-deployment branch doesn't exist remotely"
fi

# Check if prod-deployment branch exists locally
if git show-ref --verify --quiet refs/heads/prod-deployment; then
    echo "⚠️  prod-deployment branch exists locally"
    echo "   Consider deleting it: git branch -D prod-deployment"
else
    echo "✅ prod-deployment branch doesn't exist locally"
fi

# Check recent commits
echo ""
echo "📝 Recent commits on current branch:"
git log --oneline -5

# Check if there are differences between branches
if [ "$current_branch" = "prod" ]; then
    echo ""
    echo "🔍 Checking differences between prod and dev:"
    git diff dev..prod --name-only
fi

echo ""
echo "📋 Next Steps:"
echo "1. Check GitHub Actions logs for specific error messages"
echo "2. Verify repository permissions for GITHUB_TOKEN"
echo "3. Check if prod-deployment branch exists and delete if needed"
echo "4. Ensure there are actual changes to deploy"
echo ""
echo "🔗 Useful Links:"
echo "- Actions: https://github.com/darbyje/genesys_terrafrom_advanced_session/actions"
echo "- Settings: https://github.com/darbyje/genesys_terrafrom_advanced_session/settings/actions"
echo "- Branches: https://github.com/darbyje/genesys_terrafrom_advanced_session/branches" 