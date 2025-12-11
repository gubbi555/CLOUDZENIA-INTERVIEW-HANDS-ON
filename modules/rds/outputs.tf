output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.wordpress.endpoint
}

output "rds_security_group_id" {
  description = "RDS security group ID"
  value       = aws_security_group.rds.id
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.wordpress.db_name
}

output "db_username" {
  description = "Database username"
  value       = aws_db_instance.wordpress.username
}

output "db_password" {
  description = "Database password"
  value       = var.db_password != "" ? var.db_password : random_password.db_password.result
  sensitive   = true
}