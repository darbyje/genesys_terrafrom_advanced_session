# Personal Access Token (PAT) Setup Guide

## 🚨 Issue: GitHub Actions Permission Error

The error "GitHub Actions is not permitted to create or approve pull requests" occurs because the default `GITHUB_TOKEN` has restrictions on creating PRs from workflows triggered by pushes.

## ✅ Solution: Use Personal Access Token

We need to create a Personal Access Token (PAT) with the necessary permissions to create pull requests.

## 🔧 Step-by-Step Setup

### 1. Create Personal Access Token

1. **Go to GitHub Settings:**
   - Click your profile picture → **Settings**
   - Or go to: https://github.com/settings/tokens

2. **Create New Token:**
   - Click **"Generate new token (classic)"**
   - Give it a descriptive name: `Terraform CI/CD PAT`

3. **Set Expiration:**
   - Choose an appropriate expiration (e.g., 90 days)
   - You can renew it before it expires

4. **Select Permissions:**
   - ✅ **repo** (Full control of private repositories)
   - ✅ **workflow** (Update GitHub Action workflows)
   - ✅ **write:packages** (Upload packages to GitHub Package Registry)
   - ✅ **delete:packages** (Delete packages from GitHub Package Registry)

5. **Generate Token:**
   - Click **"Generate token"**
   - **IMPORTANT**: Copy the token immediately - you won't see it again!

### 2. Add Token to Repository Secrets

1. **Go to Repository Settings:**
   - Navigate to your repository
   - Go to **Settings** → **Secrets and variables** → **Actions**

2. **Add New Secret:**
   - Click **"New repository secret"**
   - **Name**: `PAT_TOKEN`
   - **Value**: Paste the token you copied in step 1
   - Click **"Add secret"**

### 3. Verify Setup

The workflow will now use `${{ secrets.PAT_TOKEN }}` instead of `${{ secrets.GITHUB_TOKEN }}` for creating pull requests.

## 🔒 Security Considerations

- **Token Scope**: The PAT has broader permissions than `GITHUB_TOKEN`
- **Expiration**: Set a reasonable expiration and renew before expiry
- **Repository Access**: The token will have access to all repositories you have access to
- **Audit Trail**: All actions performed with the PAT will be logged

## 🎯 Alternative Solutions

If you prefer not to use a PAT, you can:

### Option 1: Manual PR Creation
- Create PRs manually from `dev` to `prod`
- Use the workflow that triggers on PR creation

### Option 2: Use GitHub App
- Create a GitHub App with specific permissions
- More complex but more secure

### Option 3: Repository Admin Token
- Use a repository-specific token with limited scope
- Requires repository admin access

## 📋 Next Steps

1. **Create the PAT** following the steps above
2. **Add it to repository secrets** as `PAT_TOKEN`
3. **Commit the updated workflow:**
   ```bash
   git add .github/workflows/terraform-prod.yml
   git commit -m "Use PAT for PR creation"
   git push origin dev
   ```
4. **Test the workflow** by pushing to `prod`

## 🔍 Verification

After setup, when you push to `prod`:
- ✅ Workflow should run without permission errors
- ✅ PR should be created automatically
- ✅ You can approve and merge the PR
- ✅ Deployment should proceed automatically

The PAT approach is the most reliable solution for this specific GitHub Actions limitation! 