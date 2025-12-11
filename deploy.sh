#!/bin/bash

# Deployment script for ECS Infrastructure

set -e

echo "🚀 Starting ECS Infrastructure Deployment..."

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "❌ terraform.tfvars not found. Please create it from terraform.tfvars.example"
    exit 1
fi

# Initialize Terraform
echo "📦 Initializing Terraform..."
terraform init

# Plan deployment
echo "📋 Planning deployment..."
terraform plan

# Apply deployment
echo "🔨 Applying deployment..."
terraform apply -auto-approve

# Get outputs
echo "📊 Getting deployment outputs..."
ALB_DNS=$(terraform output -raw alb_dns_name)
ECR_URL=$(terraform output -raw ecr_repository_url)

echo ""
echo "✅ Deployment completed successfully!"
echo ""
echo "📋 Next Steps:"
echo "1. WITHOUT DOMAIN - Access via ALB directly:"
echo "   - ALB DNS: $ALB_DNS"
echo "   - Note: SSL certificate will show warning (use HTTP for testing)"
echo ""
echo "2. Configure DNS records:"
echo "   - Point your domain to ALB: yourdomain.com → $ALB_DNS"
echo "   - Use CNAME or A record in your DNS provider"
echo ""
echo "3. Build and push microservice to ECR:"
echo "   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL"
echo "   cd microservice"
echo "   docker build -t microservice ."
echo "   docker tag microservice:latest $ECR_URL:latest"
echo "   docker push $ECR_URL:latest"
echo ""
echo "🌐 URLs (after DNS configuration):"
echo "   - WordPress: https://yourdomain.com/"
echo "   - Microservice: https://yourdomain.com/api/"
echo "   - Direct ALB (testing): http://$ALB_DNS"