# AWS VPC Terraform module

Terraform module which creates VPC resources on AWS.

## Usage
```hcl
module "vpc" {
  source               = "../../"
  aws_region           = "ap-south-1"
  region_azs           = ["a","b","c"]
  vpc_cidr             = "10.10.0.0/16"
  num_public_subnets   = 3
  num_private_subnets  = 3
  project_name         = "demo-vpc"
  multiple_nat_gateway = true
}
```

## Authors

Module is maintained by [Aman Maharjan](https://github.com/mhrznamn068)