# Genesys Terraform Advanced Session

This repository contains Terraform configurations for managing Genesys Cloud infrastructure with automated CI/CD pipelines.

## 🏗️ Infrastructure Overview

This project manages Genesys Cloud resources including:
- Architect flows and IVRs
- Routing queues and skills
- User groups and roles
- Telephony configurations
- Schedules and emergency groups

## 🚀 CI/CD Pipeline

### Branch Strategy

- **`dev` branch**: Development environment with automatic deployments
- **`prod` branch**: Production environment with manual approval workflow

### Workflow Overview

#### Development Environment (`dev` branch)
- **Automatic deployment** on commits to `dev` branch
- **Plan only** on pull requests to `dev` branch
- Uses development credentials and state file

#### Production Environment (`prod` branch)
- **Manual approval required** via pull request workflow
- Creates approval PR when changes are pushed to `prod`
- Requires multiple approvals before deployment
- Uses production credentials and separate state file

## 🔧 Setup Instructions

### 1. GitHub Secrets Configuration

Set the following secrets in your GitHub repository settings:

| Secret Name | Description |
|-------------|-------------|
| `DEV_OAUTHCLIENT_ID` | Development Genesys OAuth Client ID |
| `DEV_OAUTHCLIENT_SECRET` | Development Genesys OAuth Client Secret |
| `PROD_OAUTHCLIENT_ID` | Production Genesys OAuth Client ID |
| `PROD_OAUTHCLIENT_SECRET` | Production Genesys OAuth Client Secret |
| `AWS_ACCESS_KEY_ID` | AWS Access Key for S3 backend |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Key for S3 backend |

### 2. Branch Protection Rules

#### Dev Branch Protection
- Require pull request reviews before merging
- Require status checks to pass before merging
- Include administrators

#### Prod Branch Protection
- Require pull request reviews before merging (minimum 2 reviewers)
- Require status checks to pass before merging
- Require branches to be up to date before merging
- Include administrators
- Restrict pushes that create files

### 3. Environment State Files

The project uses separate state files for each environment:
- **Dev**: `dev/org/genesyspsapac/terraform.tfstate`
- **Prod**: `prod/org/genesyspsapac/terraform.tfstate`

## 📋 Deployment Process

### Development Deployment
1. Create feature branch from `dev`
2. Make changes and commit
3. Create PR to `dev` branch
4. Review plan output in PR comments
5. Merge to `dev` for automatic deployment

### Production Deployment
1. Create feature branch from `prod`
2. Make changes and commit
3. Push to `prod` branch
4. CI/CD creates approval PR automatically
5. Review changes and get approvals
6. Merge approval PR to deploy to production

## 🛠️ Local Development

### Prerequisites
- Terraform >= 1.6.0
- AWS CLI configured
- Genesys Cloud OAuth credentials

### Local Setup
```bash
# Initialize Terraform
terraform init

# Plan changes
terraform plan -var-file="dev.tfvars"

# Apply changes (dev environment)
terraform apply -var-file="dev.tfvars"
```

## 📁 Project Structure

```
├── .github/workflows/     # GitHub Actions workflows
│   ├── terraform-dev.yml  # Development environment workflow
│   └── terraform-prod.yml # Production environment workflow
├── modules/               # Terraform modules
├── backend-dev.tf         # Dev environment backend config
├── backend-prod.tf        # Prod environment backend config
├── dev.tfvars            # Dev environment variables
├── prod.tfvars           # Prod environment variables
├── main.tf               # Main Terraform configuration
├── variables.tf          # Variable definitions
└── README.md             # This file
```

## 🔒 Security Considerations

- All sensitive data is stored in GitHub Secrets
- Separate credentials for dev and prod environments
- State files are encrypted in S3
- Branch protection prevents unauthorized deployments
- Production deployments require manual approval

## 🚨 Troubleshooting

### Common Issues

1. **Backend initialization fails**
   - Verify AWS credentials are correct
   - Ensure S3 bucket exists and is accessible

2. **Terraform plan fails**
   - Check OAuth credentials are valid
   - Verify Genesys Cloud API access

3. **Workflow fails**
   - Check GitHub secrets are properly configured
   - Verify branch protection rules are set correctly

## 📞 Support

For issues or questions about this setup, please:
1. Check the troubleshooting section above
2. Review GitHub Actions logs for detailed error messages
3. Contact the infrastructure team

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.