variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "ecs-wordpress"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "example.local"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "wordpress_user"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}