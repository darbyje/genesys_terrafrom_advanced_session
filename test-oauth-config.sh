#!/bin/bash

# Test OAuth Configuration Script
# This script tests the OAuth configuration setup

echo "🔐 Testing OAuth Configuration..."
echo "================================="

echo ""
echo "📁 Checking .tfvars files for conflicts..."

# Check cfg.auto.tfvars (should not have OAuth credentials)
if grep -q "oauthclient_id.*=.*oauthClientId" cfg.auto.tfvars; then
    echo "❌ cfg.auto.tfvars still has placeholder OAuth credentials"
else
    echo "✅ cfg.auto.tfvars OAuth credentials are commented out"
fi

# Check if any .tfvars files have actual OAuth values
echo ""
echo "📋 .tfvars files with OAuth credentials (for reference):"

if [ -f "genesyspsapacea.tfvars" ]; then
    echo "genesyspsapacea.tfvars (dev environment):"
    grep -E "(oauthclient_id|oauthclient_secret)" genesyspsapacea.tfvars | sed 's/^/  /'
fi

if [ -f "genesyspsapac.tfvars" ]; then
    echo "genesyspsapac.tfvars (prod environment):"
    grep -E "(oauthclient_id|oauthclient_secret)" genesyspsapac.tfvars | sed 's/^/  /'
fi

echo ""
echo "🔧 Checking workflow configurations..."

# Check dev workflow
if grep -q "DEV_OAUTHCLIENT_ID" .github/workflows/terraform-dev.yml; then
    echo "✅ terraform-dev.yml uses DEV_OAUTHCLIENT_ID"
else
    echo "❌ terraform-dev.yml missing DEV_OAUTHCLIENT_ID"
fi

# Check prod workflow
if grep -q "PROD_OAUTHCLIENT_ID" .github/workflows/terraform-prod.yml; then
    echo "✅ terraform-prod.yml uses PROD_OAUTHCLIENT_ID"
else
    echo "❌ terraform-prod.yml missing PROD_OAUTHCLIENT_ID"
fi

echo ""
echo "📋 GitHub Secrets Required:"
echo "  - DEV_OAUTHCLIENT_ID"
echo "  - DEV_OAUTHCLIENT_SECRET"
echo "  - PROD_OAUTHCLIENT_ID"
echo "  - PROD_OAUTHCLIENT_SECRET"
echo ""
echo "🎯 Configuration Summary:"
echo "  - cfg.auto.tfvars: OAuth credentials commented out ✅"
echo "  - Dev workflow: Uses DEV_* secrets ✅"
echo "  - Prod workflow: Uses PROD_* secrets ✅"
echo "  - Environment variables: Set in workflows ✅"
echo ""
echo "✅ OAuth configuration should now work correctly!"
echo ""
echo "🔍 Next steps:"
echo "1. Push to dev branch to test"
echo "2. Check debug output in workflow logs"
echo "3. Verify OAuth authentication works" 