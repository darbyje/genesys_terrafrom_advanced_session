#!/bin/bash

# Genesys Terraform CI/CD Setup Script (Updated)
# This script helps set up the initial branch structure for the CI/CD pipeline
# Handles existing branches gracefully

set -e

echo "🚀 Setting up Genesys Terraform CI/CD branches..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Function to check if branch exists
branch_exists() {
    git show-ref --verify --quiet refs/heads/$1
}

# Function to check if branch exists on remote
remote_branch_exists() {
    git ls-remote --heads origin $1 | grep -q $1
}

# Create dev branch if it doesn't exist
if branch_exists "dev"; then
    echo "✅ Dev branch already exists locally"
    if ! remote_branch_exists "dev"; then
        echo "📝 Pushing dev branch to remote..."
        git push -u origin dev
    else
        echo "✅ Dev branch already exists on remote"
    fi
else
    echo "📝 Creating dev branch..."
    git checkout -b dev
    git push -u origin dev
fi

# Create prod branch if it doesn't exist
if branch_exists "prod"; then
    echo "✅ Prod branch already exists locally"
    if ! remote_branch_exists "prod"; then
        echo "📝 Pushing prod branch to remote..."
        git push -u origin prod
    else
        echo "✅ Prod branch already exists on remote"
    fi
else
    echo "📝 Creating prod branch..."
    git checkout -b prod
    git push -u origin prod
fi

# Switch back to main
git checkout main

echo "✅ Branch setup complete!"
echo ""
echo "📋 Current branch status:"
echo "   - main: $(git rev-parse --abbrev-ref HEAD)"
echo "   - dev: $(git show-ref --hash=7 dev 2>/dev/null || echo 'not found')"
echo "   - prod: $(git show-ref --hash=7 prod 2>/dev/null || echo 'not found')"
echo ""
echo "📋 Next steps:"
echo "1. Set up GitHub Secrets in your repository settings:"
echo "   - DEV_OAUTHCLIENT_ID"
echo "   - DEV_OAUTHCLIENT_SECRET"
echo "   - PROD_OAUTHCLIENT_ID"
echo "   - PROD_OAUTHCLIENT_SECRET"
echo "   - AWS_ACCESS_KEY_ID"
echo "   - AWS_SECRET_ACCESS_KEY"
echo ""
echo "2. Configure branch protection rules:"
echo "   - Dev branch: Require PR reviews and status checks"
echo "   - Prod branch: Require 2+ PR reviews and status checks"
echo ""
echo "3. Test the dev workflow by pushing changes to the dev branch"
echo ""
echo "🎯 Your CI/CD pipeline is now ready!" 