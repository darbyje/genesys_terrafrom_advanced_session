# 🚀 CI/CD Setup Checklist

This checklist will help you complete the setup of your Genesys Terraform CI/CD pipeline.

## ✅ Pre-Setup (Already Done)

- [x] Repository cloned and initialized
- [x] GitHub Actions workflows created
- [x] Environment-specific backend configurations created
- [x] Variable files created for dev and prod environments
- [x] README documentation updated
- [x] Setup script created

## 🔧 Required Setup Steps

### 1. Create Environment Branches

Run the setup script to create the required branches:

```bash
chmod +x setup-branches.sh
./setup-branches.sh
```

This will create:
- `dev` branch for development environment
- `prod` branch for production environment

### 2. Configure GitHub Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions

Add the following secrets:

| Secret Name | Value | Description |
|-------------|-------|-------------|
| `DEV_OAUTHCLIENT_ID` | Your dev OAuth client ID | Development Genesys OAuth Client ID |
| `DEV_OAUTHCLIENT_SECRET` | Your dev OAuth client secret | Development Genesys OAuth Client Secret |
| `PROD_OAUTHCLIENT_ID` | Your prod OAuth client ID | Production Genesys OAuth Client ID |
| `PROD_OAUTHCLIENT_SECRET` | Your prod OAuth client secret | Production Genesys OAuth Client Secret |
| `AWS_ACCESS_KEY_ID` | Your AWS access key | AWS Access Key for S3 backend |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret key | AWS Secret Key for S3 backend |

### 3. Configure Branch Protection Rules

#### Dev Branch Protection
1. Go to Settings → Branches
2. Add rule for `dev` branch
3. Enable:
   - [x] Require a pull request before merging
   - [x] Require status checks to pass before merging
   - [x] Include administrators

#### Prod Branch Protection
1. Add rule for `prod` branch
2. Enable:
   - [x] Require a pull request before merging
   - [x] Require approvals (minimum 2 reviewers)
   - [x] Require status checks to pass before merging
   - [x] Require branches to be up to date before merging
   - [x] Include administrators
   - [x] Restrict pushes that create files

### 4. Verify S3 Backend Configuration

Ensure your S3 bucket exists and has the correct permissions:

```bash
# Test AWS credentials
aws s3 ls s3://genesyspsapac-terraform-state-bucket

# Verify bucket permissions
aws s3api get-bucket-encryption --bucket genesyspsapac-terraform-state-bucket
```

### 5. Test the Setup

#### Test Dev Environment
1. Create a feature branch from `dev`
2. Make a small change to any `.tf` file
3. Commit and push to `dev` branch
4. Verify the workflow runs successfully
5. Check that the deployment completes

#### Test Prod Environment
1. Create a feature branch from `prod`
2. Make a small change to any `.tf` file
3. Commit and push to `prod` branch
4. Verify the workflow creates an approval PR
5. Review the PR and merge to test deployment

## 🔍 Verification Steps

### Check Workflow Files
- [ ] `.github/workflows/terraform-dev.yml` exists
- [ ] `.github/workflows/terraform-prod.yml` exists
- [ ] `.github/workflows/switch-backend.yml` exists

### Check Configuration Files
- [ ] `backend-dev.tf` exists with dev state path
- [ ] `backend-prod.tf` exists with prod state path
- [ ] `dev.tfvars` exists with dev variables
- [ ] `prod.tfvars` exists with prod variables

### Check Documentation
- [ ] `README.md` updated with CI/CD documentation
- [ ] `SETUP_CHECKLIST.md` (this file) created

## 🚨 Troubleshooting

### Common Issues

1. **Workflow fails on backend initialization**
   - Verify AWS credentials are correct
   - Check S3 bucket exists and is accessible
   - Ensure IAM permissions include S3 access

2. **Terraform plan fails**
   - Verify Genesys OAuth credentials are valid
   - Check Genesys Cloud API access
   - Ensure environment variables are set correctly

3. **Branch protection prevents workflow**
   - Check branch protection rules are configured correctly
   - Ensure workflows have necessary permissions
   - Verify status checks are passing

### Getting Help

If you encounter issues:
1. Check GitHub Actions logs for detailed error messages
2. Review the troubleshooting section in README.md
3. Verify all secrets and configurations are correct
4. Contact the infrastructure team for assistance

## 🎯 Success Criteria

Your CI/CD pipeline is fully set up when:

- [ ] Dev branch automatically deploys on commits
- [ ] Prod branch creates approval PRs on commits
- [ ] Separate state files are used for dev and prod
- [ ] All secrets are properly configured
- [ ] Branch protection rules are active
- [ ] Workflows run without errors

## 📞 Support

For additional help or questions:
- Review the README.md file
- Check GitHub Actions documentation
- Contact the infrastructure team

---

**🎉 Congratulations!** Once you've completed this checklist, your Genesys Terraform CI/CD pipeline will be fully operational. 