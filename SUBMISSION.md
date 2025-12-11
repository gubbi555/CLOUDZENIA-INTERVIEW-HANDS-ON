# ECS Infrastructure - Task 1 Submission

## 📋 **Task Requirements Completed**

✅ **ECS Cluster** with WordPress and Node.js microservice in private subnets  
✅ **Auto-scaling** based on CPU (70%) and Memory (80%)  
✅ **RDS MySQL** with custom credentials and automated backups  
✅ **Secrets Manager** for secure credential storage  
✅ **ALB with SSL** and HTTP→HTTPS redirect  
✅ **Domain mapping** with path-based routing  
✅ **IAM roles** with least privilege access  
✅ **GitHub Actions** CI/CD pipeline (requires GitHub account & repository)  

## 🚀 **Quick Deployment**

### Prerequisites:
- AWS CLI configured
- Terraform installed
- Docker installed
- Domain name
- **GitHub account** (for CI/CD pipeline)
- **GitHub repository** (to store code and run actions)

### Deploy:
```bash
# 1. Setup GitHub (see GITHUB_SETUP.md)
# - Create GitHub repository
# - Configure AWS secrets
# - Push code to repository

# 2. Configure
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your domain

# 3. Deploy Infrastructure
chmod +x deploy.sh
./deploy.sh

# 4. Configure DNS
# Point your domain to the ALB DNS name provided

# 5. Deploy Microservice
# Push changes to GitHub - Actions will auto-deploy
# OR manually: follow ECR push instructions from deploy output
```

## 🏗️ **Architecture**

```
Internet → ALB (SSL) → ECS Services → RDS MySQL
           ↓            ↓              ↓
    Domain Routing   WordPress +   Secrets Manager
    HTTPS Only      Microservice   Auto-backups
```

## 🔒 **Security Features**

- Private subnets for all services
- Auto-generated secure passwords
- SSL/TLS encryption
- Secrets Manager integration
- Least privilege IAM roles
- Security groups with minimal access

## 💰 **Cost Optimized**

- Free tier eligible resources
- Fargate serverless containers
- Auto-scaling to minimize costs
- 7-day log retention

## 📊 **Monitoring**

- Container Insights enabled
- CloudWatch logs for all services
- RDS Enhanced Monitoring
- ALB health checks

## 🌐 **Endpoints**

- **WordPress**: `https://yourdomain.com/`
- **Microservice**: `https://yourdomain.com/api/`

## 📁 **Project Structure**

All Terraform modules are reusable and follow AWS best practices:
- `modules/vpc/` - Network infrastructure
- `modules/ecs/` - Container services
- `modules/rds/` - Database
- `modules/alb/` - Load balancer
- `modules/secrets/` - Credential management