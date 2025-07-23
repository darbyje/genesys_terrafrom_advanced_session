#!/bin/bash

# Genesys Terraform CI/CD Setup Script
# This script helps set up the initial branch structure for the CI/CD pipeline

set -e

echo "🚀 Setting up Genesys Terraform CI/CD branches..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Create dev branch
echo "📝 Creating dev branch..."
git checkout -b dev
git push -u origin dev

# Create prod branch
echo "📝 Creating prod branch..."
git checkout -b prod
git push -u origin prod

# Switch back to main
git checkout main

echo "✅ Branch setup complete!"
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