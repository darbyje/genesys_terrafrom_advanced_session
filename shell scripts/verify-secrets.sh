#!/bin/bash

# Verify GitHub Secrets Setup
# This script helps verify that required secrets are configured

echo "🔐 Verifying GitHub Secrets Setup..."
echo "===================================="

echo ""
echo "📋 Required GitHub Secrets:"
echo ""

# List required secrets
secrets=(
    "DEV_OAUTHCLIENT_ID"
    "DEV_OAUTHCLIENT_SECRET"
    "PROD_OAUTHCLIENT_ID"
    "PROD_OAUTHCLIENT_SECRET"
    "AWS_ACCESS_KEY_ID"
    "AWS_SECRET_ACCESS_KEY"
)

echo "Required secrets:"
for secret in "${secrets[@]}"; do
    echo "  - $secret"
done

echo ""
echo "📋 Current .tfvars files (for reference):"
echo ""

# Check existing .tfvars files for reference values
if [ -f "genesyspsapacea.tfvars" ]; then
    echo "genesyspsapacea.tfvars:"
    grep -E "(oauthclient_id|oauthclient_secret)" genesyspsapacea.tfvars | sed 's/^/  /'
fi

if [ -f "genesyspsapac.tfvars" ]; then
    echo "genesyspsapac.tfvars:"
    grep -E "(oauthclient_id|oauthclient_secret)" genesyspsapac.tfvars | sed 's/^/  /'
fi

echo ""
echo "🎯 Setup Instructions:"
echo "1. Go to your GitHub repository"
echo "2. Click Settings → Secrets and variables → Actions"
echo "3. Add each required secret with the correct values"
echo "4. Push to dev branch to test the workflow"
echo ""
echo "🔍 Debug Information:"
echo "- The workflow now includes debug output"
echo "- Check workflow logs for environment variable status"
echo "- Look for 'Debug Environment Variables' step output"
echo ""
echo "✅ Once secrets are configured, the OAuth authentication should work!" 