#!/bin/bash

# Fix Terraform Formatting Script
# This script will format all Terraform files to fix formatting issues

echo "🔧 Fixing Terraform formatting..."

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Error: Terraform is not installed"
    exit 1
fi

# Format all Terraform files
echo "📝 Formatting Terraform files..."
terraform fmt -recursive

# Check if formatting was successful
if [ $? -eq 0 ]; then
    echo "✅ Terraform formatting completed successfully!"
    echo ""
    echo "📋 Files that were formatted:"
    terraform fmt -check -recursive -write=false
else
    echo "❌ Error: Terraform formatting failed"
    exit 1
fi

echo ""
echo "🎯 Next steps:"
echo "1. Commit the formatted files"
echo "2. Push to dev branch to test the workflow"
echo "3. The terraform fmt -check step should now pass" 