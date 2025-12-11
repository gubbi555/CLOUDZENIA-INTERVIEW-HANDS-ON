terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  project_name = var.project_name
  environment  = var.environment
}

# Secrets Module
module "secrets" {
  source = "./modules/secrets"
  
  project_name = var.project_name
  environment  = var.environment
  db_username  = var.db_username
  db_password  = var.db_password
  rds_password = module.rds.db_password
  
  depends_on = [module.rds]
}

# RDS Module
module "rds" {
  source = "./modules/rds"
  
  project_name           = var.project_name
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  ecs_security_group_id  = module.ecs.ecs_security_group_id
  db_username            = var.db_username
  db_password            = var.db_password
  
  depends_on = [module.ecs]
}

# ALB Module
module "alb" {
  source = "./modules/alb"
  
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  domain_name        = var.domain_name
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"
  
  project_name                      = var.project_name
  environment                       = var.environment
  vpc_id                           = module.vpc.vpc_id
  private_subnet_ids               = module.vpc.private_subnet_ids
  alb_security_group_id            = module.alb.alb_security_group_id
  alb_target_group_wordpress_arn   = module.alb.wordpress_target_group_arn
  alb_target_group_microservice_arn = module.alb.microservice_target_group_arn
  rds_endpoint                     = module.rds.rds_endpoint
  db_secret_arn                    = module.secrets.db_secret_arn
  db_username                      = var.db_username
}