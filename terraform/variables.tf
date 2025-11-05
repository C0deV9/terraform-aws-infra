variable "aws_region" { default = "us-east-1" }
variable "state_bucket_name" {}
variable "state_lock_table" {}
variable "project_name" { default = "members-crud-app" }
variable "key_name" {
  description = "EC2 key pair name"
  default     = "ec2keypair"
} 