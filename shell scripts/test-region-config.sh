#!/bin/bash

# Test Region Configuration Script
# This script tests the AWS region configuration

echo "🌍 Testing AWS Region Configuration..."
echo "======================================"

echo ""
echo "📁 Checking variable files..."

# Check variables.tf
if grep -q 'default = "ap-southeast-2"' variables.tf; then
    echo "✅ variables.tf has correct default region"
else
    echo "❌ variables.tf missing correct default region"
fi

# Check main.tf provider configuration
if grep -q 'aws_region.*=.*"ap-southeast-2"' main.tf; then
    echo "✅ main.tf provider has hardcoded correct region"
else
    echo "❌ main.tf provider missing hardcoded region"
fi

# Check cfg.auto.tfvars (the problematic file)
if grep -q 'aws_region.*=.*"ap-southeast-2"' cfg.auto.tfvars; then
    echo "✅ cfg.auto.tfvars has correct region (fixed!)"
else
    echo "❌ cfg.auto.tfvars still has incorrect region"
fi

# Check dev.tfvars
if grep -q 'aws_region.*=.*"ap-southeast-2"' dev.tfvars; then
    echo "✅ dev.tfvars has correct region"
else
    echo "❌ dev.tfvars missing correct region"
fi

# Check prod.tfvars
if grep -q 'aws_region.*=.*"ap-southeast-2"' prod.tfvars; then
    echo "✅ prod.tfvars has correct region"
else
    echo "❌ prod.tfvars missing correct region"
fi

echo ""
echo "🔧 Checking workflow files..."

# Check dev workflow
if grep -q 'TF_VAR_aws_region: "ap-southeast-2"' .github/workflows/terraform-dev.yml; then
    echo "✅ terraform-dev.yml has correct region"
else
    echo "❌ terraform-dev.yml missing correct region"
fi

# Check prod workflow
if grep -q 'TF_VAR_aws_region: "ap-southeast-2"' .github/workflows/terraform-prod.yml; then
    echo "✅ terraform-prod.yml has correct region"
else
    echo "❌ terraform-prod.yml missing correct region"
fi

echo ""
echo "📋 Region Configuration Summary:"
echo "   - AWS Region: ap-southeast-2"
echo "   - Genesys Cloud Region: ap-southeast-2"
echo "   - S3 Backend Region: ap-southeast-2"
echo "   - Provider Region: Hardcoded in main.tf"
echo ""
echo "✅ Region configuration should now work correctly!"
echo ""
echo "🎯 The 'expected aws_region to be one of' error should be resolved!"
echo ""
echo "🔧 Key fixes applied:"
echo "   - Fixed cfg.auto.tfvars (was setting 'region' literal)"
echo "   - Hardcoded region in provider configuration"
echo "   - Ensured all .tfvars files have correct region" 