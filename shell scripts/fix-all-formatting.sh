#!/bin/bash

# Comprehensive Terraform Formatting Fix Script
# This script will fix all formatting issues in Terraform files

echo "🔧 Fixing ALL Terraform formatting issues..."
echo "============================================="

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Error: Terraform is not installed"
    echo "💡 You can install it with: brew install terraform (macOS) or download from terraform.io"
    exit 1
fi

echo ""
echo "📝 Current formatting issues:"
terraform fmt -check -recursive -write=false

echo ""
echo "🔧 Applying formatting fixes..."
terraform fmt -recursive

echo ""
echo "✅ Formatting completed!"
echo ""
echo "📋 Files that were formatted:"
terraform fmt -check -recursive -write=false

echo ""
echo "🎯 Next steps:"
echo "1. Commit the formatted files"
echo "2. Push to dev branch to test the workflow"
echo "3. The terraform fmt -check step should now pass"
echo ""
echo "📁 Files that should now be properly formatted:"
echo "   - backend-original.tf"
echo "   - backend-dev.tf"
echo "   - backend-prod.tf"
echo "   - dev.tfvars"
echo "   - prod.tfvars"
echo "   - All .tf files in modules/" 