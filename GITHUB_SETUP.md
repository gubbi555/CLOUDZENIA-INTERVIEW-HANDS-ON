# GitHub Actions Setup Guide

## 📋 **GitHub Requirements**

### **1. GitHub Account & Repository**
- Create GitHub account at https://github.com
- Create new repository for this project
- Push all code to the repository

### **2. GitHub Secrets Configuration**
Navigate to: **Repository → Settings → Secrets and variables → Actions**

Add these secrets:
```
AWS_ACCESS_KEY_ID = your-aws-access-key
AWS_SECRET_ACCESS_KEY = your-aws-secret-key
```

### **3. Repository Structure**
```
your-repo/
├── .github/workflows/deploy.yml    # CI/CD pipeline
├── microservice/                   # Node.js app
├── modules/                        # Terraform modules
└── main.tf                        # Infrastructure code
```

## 🚀 **GitHub Actions Workflow**

### **Triggers:**
- Push to `main` branch
- Changes in `microservice/` folder
- Pull requests to `main`

### **What it does:**
1. **Checkout code** from repository
2. **Configure AWS credentials** from secrets
3. **Login to ECR** automatically
4. **Build Docker image** from microservice code
5. **Push to ECR** with commit SHA tag
6. **Update ECS service** with new image
7. **Wait for deployment** to complete

### **Workflow File:** `.github/workflows/deploy.yml`
```yaml
name: Deploy Microservice to ECS
on:
  push:
    branches: [ main ]
    paths: [ 'microservice/**' ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v4
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    # ... rest of workflow
```

## 🔧 **Setup Steps**

### **Step 1: Create Repository**
```bash
# Initialize git in project folder
git init
git add .
git commit -m "Initial commit"

# Add GitHub remote
git remote add origin https://github.com/yourusername/your-repo.git
git push -u origin main
```

### **Step 2: Configure Secrets**
1. Go to GitHub repository
2. Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

### **Step 3: Deploy Infrastructure First**
```bash
# Deploy infrastructure manually first
./deploy.sh
```

### **Step 4: Test CI/CD**
```bash
# Make changes to microservice
echo "console.log('Updated!');" >> microservice/app.js

# Commit and push
git add .
git commit -m "Update microservice"
git push origin main

# GitHub Actions will automatically:
# - Build new Docker image
# - Push to ECR
# - Deploy to ECS
```

## 📊 **Monitoring GitHub Actions**

### **View Workflow Runs:**
- Repository → Actions tab
- See build logs and deployment status
- Monitor ECR pushes and ECS deployments

### **Troubleshooting:**
- Check AWS credentials in secrets
- Verify ECR repository exists
- Ensure ECS service is running

## 🔒 **Security Best Practices**

### **IAM User for GitHub Actions:**
Create dedicated IAM user with minimal permissions:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage",
        "ecs:UpdateService",
        "ecs:DescribeServices"
      ],
      "Resource": "*"
    }
  ]
}
```

## ✅ **Verification**

After setup, verify:
1. ✅ Repository created and code pushed
2. ✅ AWS secrets configured
3. ✅ Infrastructure deployed
4. ✅ GitHub Actions workflow runs successfully
5. ✅ Microservice updates automatically deploy