variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "region_azs" {
  description = "AWS Region Suffix"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "num_public_subnets" {
  description = "Number of required public subnets"
  type        = number
  default     = 3
}

variable "num_private_subnets" {
  description = "Number of required public subnets"
  type        = number
  default     = 3
}

variable "vpc_cidr" {
  description = "VPC subnet CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "common_tags" {
  description = "Common tags for provisioned resource"
  default = {
    "Managed-By" = "Terraform"
  }
}

variable "project_name" {
  description = "Project Name or the prefix name for provisioned resource"
  type        = string
  default     = "demo-vpc"
}

variable "env" {
  description = "Environment to be deployed on"
  type        = string
  default     = "test"
}

variable "multiple_nat_gateway" {
  description = "Vairable to enable multiplt nat gateways"
  type        = bool
  default     = false
}