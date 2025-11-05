resource "aws_instance" "app" {
  ami           = "ami-0bdd88bd06d16ba03"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name = var.key_name
  user_data = <<-EOF
    #!/bin/bash
    sudo yum install -y docker
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker ec2-user
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
      -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  EOF
}

output "ec2_id" { value = aws_instance.app.id }
