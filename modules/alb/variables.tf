variable "vpc_id" {
  description = "VPC ID where ALB will be created"
  type        = string
}

variable "subnets" {
  description = "List of public subnets for ALB"
  type        = list(string)
}
