output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "ALB zone ID"
  value       = aws_lb.main.zone_id
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb.id
}

output "wordpress_target_group_arn" {
  description = "WordPress target group ARN"
  value       = aws_lb_target_group.wordpress.arn
}

output "microservice_target_group_arn" {
  description = "Microservice target group ARN"
  value       = aws_lb_target_group.microservice.arn
}

output "certificate_arn" {
  description = "SSL certificate ARN"
  value       = aws_acm_certificate.main.arn
}