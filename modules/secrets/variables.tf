variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "wordpress_user"
}

variable "db_password" {
  description = "Database password (leave empty to auto-generate)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "rds_password" {
  description = "Actual RDS password from RDS module"
  type        = string
  sensitive   = true
}