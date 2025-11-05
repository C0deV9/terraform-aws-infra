output "vpc_id" { value = module.vpc.vpc_id }
output "alb_dns" { value = module.alb.alb_dns_name }
output "rds_endpoint" { value = module.rds.db_endpoint }
output "ec2_host" { value = aws_instance.app.public_ip }