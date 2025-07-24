# 🔍 PR Status Check Guide

This guide will help you check if a PR was created and understand the deployment process.

## 🔍 **How to Check if a PR Was Created**

### **1. Check GitHub Repository**
1. Go to your GitHub repository: `https://github.com/darbyje/genesys_terrafrom_advanced_session`
2. Click the **"Pull requests"** tab
3. Look for any **open pull requests**

### **2. Check Recent Activity**
1. Go to your repository
2. Look at the **"Recent activity"** section
3. Check if there are any recent PR creations

### **3. Check Branch Status**
Run the check script:
```bash
chmod +x check-pr-status.sh
./check-pr-status.sh
```

## 🚀 **How to Create a PR from Dev to Prod**

### **Option 1: Create PR via GitHub (Recommended)**

1. **Go to your repository**
2. **Click "Compare & pull request"** (if you see a banner)
3. **Or manually create PR:**
   - Click **"Pull requests"** tab
   - Click **"New pull request"**
   - Set **base branch** to `prod`
   - Set **compare branch** to `dev`
   - Click **"Create pull request"**

### **Option 2: Create PR via Command Line**

```bash
# Make sure you're on dev branch
git checkout dev

# Create a new branch for the PR
git checkout -b dev-to-prod-$(date +%Y%m%d)

# Push the branch
git push -u origin dev-to-prod-$(date +%Y%m%d)
```

Then go to GitHub and create the PR.

## 🎯 **What Happens When You Push to Prod**

### **Direct Push to Prod**
```bash
git checkout prod
git merge dev
git push origin prod
```

This will:
1. ✅ **Trigger the prod workflow** automatically
2. ✅ **Create an approval PR** for production deployment
3. ✅ **Require manual approval** before deploying

### **PR from Dev to Prod**
This will:
1. ✅ **Run the prod workflow** when PR is created
2. ✅ **Create an approval PR** for production deployment
3. ✅ **Require manual approval** before deploying

## 🔍 **Checking Workflow Status**

1. **Go to your repository**
2. **Click "Actions"** tab
3. **Look for recent workflow runs**
4. **Check if any workflows are running**

## 📋 **Common Scenarios**

### **Scenario 1: No PR Created**
- **Cause**: You haven't pushed to prod or created a PR yet
- **Solution**: Follow the steps above to create a PR

### **Scenario 2: Workflow Running**
- **Cause**: A workflow is currently executing
- **Solution**: Wait for it to complete and check the logs

### **Scenario 3: Approval PR Created**
- **Cause**: The prod workflow created an approval PR
- **Solution**: Review and merge the approval PR to deploy

## 🚨 **Troubleshooting**

### **If you can't find the PR:**
1. Check the **"Pull requests"** tab
2. Look for **closed PRs** (might have been auto-merged)
3. Check **"Actions"** tab for workflow status

### **If the workflow failed:**
1. Check the **workflow logs**
2. Look for **error messages**
3. Fix the issues and **push again**

## ✅ **Success Indicators**

- ✅ **PR created** in GitHub
- ✅ **Workflow running** in Actions tab
- ✅ **Approval PR created** for production deployment
- ✅ **No error messages** in workflow logs 