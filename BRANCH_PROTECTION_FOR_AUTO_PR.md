# Branch Protection for Auto-PR Workflow

## 🎯 Your Desired Workflow
1. **Push to `prod`** → Triggers workflow
2. **Workflow creates approval PR** automatically  
3. **Manual approval** of the PR
4. **Merge PR** → Deploys to production

## 🔧 Required Branch Protection Settings

### For `prod` branch:
- ❌ **Require a pull request before merging** (DISABLE this)
- ✅ **Require approvals** (ENABLE this - 1 or more reviewers)
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

## 🚨 Key Point: Disable "Require PR before merging"

The critical setting is to **disable** "Require a pull request before merging" on the `prod` branch. This allows:

1. ✅ **Direct pushes to `prod`** (which trigger the workflow)
2. ✅ **Workflow creates approval PR** automatically
3. ✅ **Manual approval still required** (via "Require approvals")
4. ✅ **Security maintained** through approval requirements

## 📋 How to Update Your Settings

### In GitHub:
1. Go to **Settings** → **Branches**
2. Find the `prod` branch protection rule
3. **Uncheck** "Require a pull request before merging"
4. **Check** "Require approvals" (set to 1 or more)
5. **Check** "Dismiss stale PR approvals when new commits are pushed"
6. **Check** "Require status checks to pass before merging"
7. **Check** "Require branches to be up to date before merging"
8. Click **Save changes**

## 🔄 Restore Original Workflow

Once you update the branch protection, I'll restore the original workflow that:

1. **Triggers on push to `prod`**
2. **Creates approval PR automatically**
3. **Requires manual approval**
4. **Deploys on PR merge**

## 🎯 Benefits of This Approach

- ✅ **Automated PR creation** - no manual PR creation needed
- ✅ **Security maintained** - still requires approvals
- ✅ **Audit trail** - all changes go through PRs
- ✅ **Flexible** - can push directly when needed
- ✅ **Consistent** - same approval process every time

## 📝 Summary

**Disable**: "Require a pull request before merging"
**Enable**: "Require approvals" (1+ reviewers)

This gives you the best of both worlds: automated PR creation with manual approval requirements! 