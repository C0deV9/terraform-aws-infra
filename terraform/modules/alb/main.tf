resource "aws_lb" "app_lb" {
  name               = "members-alb"
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.security_group_id]
}

output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
