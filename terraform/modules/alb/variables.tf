variable "vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for ALB"
  type        = string
}
