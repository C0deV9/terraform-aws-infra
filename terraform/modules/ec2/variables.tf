variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}
