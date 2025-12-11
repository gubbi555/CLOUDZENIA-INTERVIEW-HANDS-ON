resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.project_name}-${var.environment}-db-credentials"
  description = "Database credentials for WordPress"

  tags = {
    Name = "${var.project_name}-${var.environment}-db-secret"
  }
}

