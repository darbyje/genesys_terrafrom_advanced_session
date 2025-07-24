# Branch Protection Setup Guide

## Current Issue
Your branch protection rule is correctly configured to require PRs for the `prod` branch, but our CI/CD workflow was trying to push directly to `prod`. This creates a conflict.

## ✅ Solution: Updated Workflow

I've updated the production workflow to work **with** your branch protection rules:

### New Workflow Behavior:
1. **Create PR manually** from `dev` to `prod`
2. **Workflow triggers** when PR is created/updated
3. **Terraform plan** runs and posts results as PR comment
4. **Manual approval** required (via branch protection)
5. **Merge PR** triggers automatic deployment

## 🔧 Branch Protection Settings

### For `prod` branch:
- ✅ **Require a pull request before merging**
- ✅ **Require approvals** (1 or more reviewers)
- ✅ **Dismiss stale PR approvals when new commits are pushed**
- ✅ **Require status checks to pass before merging**
- ✅ **Require branches to be up to date before merging**
- ❌ **Allow force pushes** (disabled)
- ❌ **Allow deletions** (disabled)

### For `dev` branch:
- ❌ **Require a pull request before merging** (disabled - allow direct pushes)
- ❌ **Require approvals** (disabled)
- ✅ **Require status checks to pass before merging**
- ❌ **Allow force pushes** (disabled)
- ❌ **Allow deletions** (disabled)

## 📋 How to Deploy to Production

### Option 1: Use the Helper Script
```bash
chmod +x create-prod-pr.sh
./create-prod-pr.sh
```

### Option 2: Manual Steps
1. **Ensure you're on dev branch:**
   ```bash
   git checkout dev
   git push origin dev
   ```

2. **Create PR on GitHub:**
   - Go to: https://github.com/darbyje/genesys_terrafrom_advanced_session/compare/prod...dev
   - Title: "🚀 Production Deployment - Terraform Changes"
   - Base: `prod`
   - Compare: `dev`

3. **Review and Approve:**
   - Check the Terraform plan in PR comments
   - Get required approvals
   - Merge the PR

## 🎯 Workflow Summary

| Branch | Trigger | Action | Approval Required |
|--------|---------|--------|-------------------|
| `dev` | Push | Direct deployment | ❌ No |
| `prod` | PR created | Plan + comment | ✅ Yes (PR approval) |
| `prod` | PR merged | Apply deployment | ✅ Yes (PR approval) |

## 🔍 Verification

To verify your setup is working:

1. **Check branch protection:**
   - Go to Settings → Branches
   - Verify `prod` requires PRs and approvals
   - Verify `dev` allows direct pushes

2. **Test the workflow:**
   - Make a change on `dev`
   - Push to `dev` (should deploy automatically)
   - Create PR from `dev` to `prod`
   - Check that workflow runs and posts plan
   - Approve and merge PR (should deploy to prod)

## 🚨 Important Notes

- **Never push directly to `prod`** - always use PRs
- **Always review the Terraform plan** before merging
- **Use the helper script** for consistent PR creation
- **Monitor GitHub Actions** for workflow status

This setup provides the security you want while maintaining automated deployment capabilities! 