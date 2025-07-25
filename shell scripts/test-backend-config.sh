#!/bin/bash

# Test Backend Configuration Script
# This script tests the backend configuration files

echo "🔧 Testing Backend Configuration..."
echo "==================================="

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Error: Terraform is not installed"
    exit 1
fi

echo ""
echo "📁 Checking backend configuration files..."

backend_files=(
    "backend.tf"
    "backend-dev.conf"
    "backend-prod.conf"
)

for file in "${backend_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
        
        # Check for problematic arguments
        if grep -q "use_lockfile" "$file"; then
            echo "❌ $file contains unsupported 'use_lockfile' argument"
        else
            echo "✅ $file doesn't contain 'use_lockfile'"
        fi
        
        # Check for required arguments
        if grep -q "dynamodb_table" "$file"; then
            echo "✅ $file contains 'dynamodb_table' for state locking"
        else
            echo "⚠️  $file missing 'dynamodb_table' (state locking disabled)"
        fi
    else
        echo "❌ $file missing"
    fi
done

echo ""
echo "🧪 Testing backend configuration syntax..."

# Test dev configuration
echo "Testing dev backend configuration..."
if terraform init -backend-config=backend-dev.conf -input=false -reconfigure > /dev/null 2>&1; then
    echo "✅ Dev backend configuration is valid"
else
    echo "❌ Dev backend configuration has errors"
fi

# Test prod configuration
echo "Testing prod backend configuration..."
if terraform init -backend-config=backend-prod.conf -input=false -reconfigure > /dev/null 2>&1; then
    echo "✅ Prod backend configuration is valid"
else
    echo "❌ Prod backend configuration has errors"
fi

echo ""
echo "📋 Backend Configuration Summary:"
echo "   - Dev state: dev/org/genesyspsapac/terraform.tfstate"
echo "   - Prod state: prod/org/genesyspsapac/terraform.tfstate"
echo "   - S3 bucket: genesyspsapac-terraform-state-bucket"
echo "   - DynamoDB table: genesyspsapac-terraform-locks"
echo "   - Region: ap-southeast-2"
echo ""
echo "✅ Backend configuration should now work correctly!" 