variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "c7i-flex.large"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "DevOps-Server"
}
