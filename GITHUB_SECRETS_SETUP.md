# 🔐 GitHub Secrets Setup Guide

This guide will help you set up the required GitHub secrets for your Terraform CI/CD pipeline.

## 📋 Required Secrets

You need to set up these secrets in your GitHub repository:

### **1. Genesys Cloud OAuth Credentials**

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `DEV_OAUTHCLIENT_ID` | Development OAuth Client ID | `bdd13f8f-2f7a-4a92-b27e-296ce7d72df7` |
| `DEV_OAUTHCLIENT_SECRET` | Development OAuth Client Secret | `MNZ2ODX7k1RuqSO5rYwpWruOm0doDF4fqe0hYF-uAv0` |
| `PROD_OAUTHCLIENT_ID` | Production OAuth Client ID | `3bc069e2-e53f-401a-af26-d6b7e1be6e54` |
| `PROD_OAUTHCLIENT_SECRET` | Production OAuth Client Secret | `JHtEgUXZU0ARTN5kYgMGsUWJ-DfamzSGI2adujchyJY` |

### **2. AWS Credentials**

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `AWS_ACCESS_KEY_ID` | AWS Access Key for S3 backend | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Key for S3 backend | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |

### **3. GitHub Personal Access Token**

| Secret Name   | Description                                                      | Example Value                |
|--------------|------------------------------------------------------------------|------------------------------|
| `PAT_TOKEN`  | GitHub Personal Access Token for CI/CD or automation workflows.  | `ghp_XXXXXXXXXXXXXXXXXXXXXX` |

**How to create:**  
1. Go to [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens).
2. Click "Generate new token" (classic) or "Fine-grained token".
3. Select the required scopes (usually `repo`, and `workflow` if your automation triggers workflows).
4. Copy the token and add it as a secret named `PAT_TOKEN` in your repository’s GitHub Secrets.

## 🚀 How to Set Up Secrets

### **Step 1: Go to Repository Settings**
1. Navigate to your GitHub repository
2. Click **Settings** tab
3. Click **Secrets and variables** → **Actions**

### **Step 2: Add Each Secret**
1. Click **New repository secret**
2. Enter the **Name** (e.g., `DEV_OAUTHCLIENT_ID`)
3. Enter the **Value** (your actual OAuth client ID)
4. Click **Add secret**

### **Step 3: Repeat for All Secrets**
Add all 6 secrets listed above.

## 🔍 Troubleshooting

### **"invalid_client (client not found)" Error**
This means the OAuth credentials are not set correctly:

1. **Check secret names** - Must match exactly (case-sensitive)
2. **Verify secret values** - Copy from Genesys Cloud exactly
3. **Check workflow logs** - Look for debug output

### **Debug Steps**
The workflow now includes debug output that will show:
- Whether secrets are set
- Length of secret values (to verify they're not empty)

### **Common Issues**
- ❌ **Wrong secret names** - Must be exact match
- ❌ **Empty values** - Secrets must have actual values
- ❌ **Extra spaces** - Copy values exactly, no extra spaces
- ❌ **Wrong environment** - Dev vs Prod credentials mixed up

## ✅ Verification

After setting up secrets:
1. **Push to dev branch** to trigger workflow
2. **Check debug output** in workflow logs
3. **Verify OAuth authentication** works
4. **Test with small change** to confirm setup

## 📞 Support

If you continue to have issues:
1. Check the debug output in workflow logs
2. Verify secret names match exactly
3. Ensure OAuth credentials are valid in Genesys Cloud
4. Contact your Genesys Cloud administrator 