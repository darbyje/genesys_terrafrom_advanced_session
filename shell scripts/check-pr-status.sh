#!/bin/bash

# Check PR Status Script
# This script helps check if a PR was created and guides the process

echo "🔍 Checking PR Status..."
echo "========================"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

echo ""
echo "📋 Current branch status:"

# Get current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $current_branch"

# Check if we're on a feature branch
if [[ "$current_branch" == "dev" || "$current_branch" == "prod" || "$current_branch" == "main" ]]; then
    echo "✅ You're on a main branch"
else
    echo "✅ You're on a feature branch: $current_branch"
fi

echo ""
echo "🌿 Branch comparison:"

# Check what commits are ahead/behind
echo "Commits in current branch not in prod:"
git log prod..HEAD --oneline 2>/dev/null || echo "  (No commits ahead of prod)"

echo ""
echo "Commits in prod not in current branch:"
git log HEAD..prod --oneline 2>/dev/null || echo "  (No commits behind prod)"

echo ""
echo "🔗 Remote branches:"
git branch -r | grep -E "(dev|prod)" | sed 's/^/  /'

echo ""
echo "📋 Next steps to create PR:"
echo ""
echo "1. If you want to create a PR from dev to prod:"
echo "   git checkout dev"
echo "   git checkout -b dev-to-prod-$(date +%Y%m%d)"
echo "   git push -u origin dev-to-prod-$(date +%Y%m%d)"
echo ""
echo "2. Then go to GitHub and:"
echo "   - Click 'Compare & pull request'"
echo "   - Set base branch to 'prod'"
echo "   - Set compare branch to your new branch"
echo "   - Create the PR"
echo ""
echo "3. Or if you want to push directly to prod:"
echo "   git checkout prod"
echo "   git merge dev"
echo "   git push origin prod"
echo ""
echo "🔍 To check existing PRs:"
echo "   - Go to your GitHub repository"
echo "   - Click 'Pull requests' tab"
echo "   - Look for any open PRs" 