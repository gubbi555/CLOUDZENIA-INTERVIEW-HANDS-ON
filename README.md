# ECS Infrastructure with Terraform - Task 1

## 🏗️ Architecture Overview

```
Internet → ALB (Public Subnets) → ECS Services (Private Subnets) → RDS (Private Subnets)
           ↓                      ↓                               ↓
    SSL Termination        WordPress + Node.js              MySQL Database
    Domain Routing         Auto-scaling                     Secrets Manager
```

## 📁 Project Structure

```
terraform-ecs-infrastructure/
├── main.tf                    # Main Terraform configuration
├── variables.tf               # Input variables
├── outputs.tf                 # Output values
├── terraform.tfvars.example   # Example variables file
├── deploy.sh                  # Deployment script
├── modules/
│   ├── vpc/                   # VPC (subnets, NAT, IGW)
│   ├── ecs/                   # ECS cluster, services, auto-scaling
│   ├── rds/                   # RDS MySQL database
│   ├── alb/                   # Application Load Balancer + SSL
│   └── secrets/               # AWS Secrets Manager
├── microservice/              # Node.js microservice
│   ├── app.js                 # Express.js application
│   ├── package.json           # Dependencies
│   └── Dockerfile             # Container definition
└── .github/workflows/         # CI/CD pipeline
    ├── deploy.yml             # GitHub Actions workflow
    └── task-definition.json   # ECS task template
```

## 🚀 Quick Start

### 1. Prerequisites
- AWS CLI configured
- Terraform installed
- Docker installed
- Domain name (or use free DNS service)
- **GitHub account** for CI/CD pipeline
- **GitHub repository** to store code

### 2. Setup
```bash
# Clone and configure
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your domain and settings

# Deploy infrastructure
chmod +x deploy.sh
./deploy.sh
```

### 3. Configure DNS
Point these subdomains to ALB DNS name:
- `wordpress.yourdomain.com`
- `microservice.yourdomain.com`

### 4. Deploy Microservice
```bash
# Get ECR login
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <ECR_URL>

# Build and push
cd microservice
docker build -t microservice .
docker tag microservice:latest <ECR_URL>:latest
docker push <ECR_URL>:latest
```

## 🔧 Components

### VPC Module
- 2 public + 2 private subnets (multi-AZ)
- Internet Gateway + NAT Gateways
- Route tables and security groups

### ECS Module
- **Fargate cluster** with Container Insights
- **WordPress service** (port 80)
- **Node.js microservice** (port 3000)
- **Auto-scaling** based on CPU (70%) and Memory (80%)
- **ECR repository** for microservice
- **CloudWatch logs** (7-day retention)

### RDS Module
- **MySQL 8.0** on `db.t3.micro` (free tier)
- **20GB storage** with auto-scaling
- **7-day backups** with enhanced monitoring
- **Private subnets** only
- **Auto-generated secure passwords**

### ALB Module
- **SSL certificate** with wildcard (`*.domain.com`)
- **HTTP → HTTPS redirect**
- **Host-based routing** to services
- **Health checks** configured

### Secrets Manager
- **Database credentials** stored securely
- **Auto-generated passwords**
- **IAM integration** for ECS access

## 🔒 Security Features

- ✅ **Private subnets** for all services
- ✅ **SSL/TLS encryption** for all traffic
- ✅ **Secrets Manager** for credentials
- ✅ **Least privilege** security groups
- ✅ **Auto-generated passwords**
- ✅ **Container scanning** enabled

## 📊 Monitoring & Scaling

- **Container Insights** enabled
- **CloudWatch logs** for all services
- **Auto-scaling** on CPU/Memory thresholds
- **RDS Enhanced Monitoring**
- **ALB health checks**

## 🌐 Domain Mapping

| Subdomain | Target | Port |
|-----------|--------|------|
| `wordpress.domain.com` | WordPress ECS Service | 80 |
| `microservice.domain.com` | Node.js ECS Service | 3000 |

## 💰 Cost Optimization

- **Free tier eligible** resources used
- **Fargate** for serverless containers
- **db.t3.micro** RDS instance
- **7-day log retention**
- **Auto-scaling** to minimize costs

## 🔄 CI/CD Pipeline

- **GitHub Actions** workflow
- **Automatic builds** on code changes
- **ECR integration** for container registry
- **ECS deployment** with zero downtime