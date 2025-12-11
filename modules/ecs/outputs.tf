output "ecs_cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.main.id
}

output "ecs_security_group_id" {
  description = "ECS security group ID"
  value       = aws_security_group.ecs_tasks.id
}

output "ecr_repository_url" {
  description = "ECR repository URL for microservice"
  value       = aws_ecr_repository.microservice.repository_url
}

output "wordpress_service_name" {
  description = "WordPress service name"
  value       = aws_ecs_service.wordpress.name
}

output "microservice_service_name" {
  description = "Microservice service name"
  value       = aws_ecs_service.microservice.name
}