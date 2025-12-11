output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
}

output "wordpress_url" {
  description = "WordPress URL"
  value       = "https://wordpress.${var.domain_name}"
}

output "microservice_url" {
  description = "Microservice URL"
  value       = "https://microservice.${var.domain_name}"
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.rds_endpoint
  sensitive   = true
}

output "ecr_repository_url" {
  description = "ECR repository URL for microservice"
  value       = module.ecs.ecr_repository_url
}