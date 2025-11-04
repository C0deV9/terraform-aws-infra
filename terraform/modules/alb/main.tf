resource "aws_lb" "frontend" {
  name               = "frontend-lb"
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.security_group_id]
}

resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontend-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

output "alb_dns_name" { value = aws_lb.frontend.dns_name }
