resource "aws_db_instance" "postgres" {
  identifier        = "membersdb"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  username          = "postgres"
  password          = "postgres123"
  allocated_storage = 20
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids
}

output "db_endpoint" { value = aws_db_instance.postgres.endpoint }
