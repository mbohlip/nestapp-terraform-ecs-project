# environment variables
variable "region" {
  description   = "Region to create resources"
  type          = string
}

variable "project_name" {
  description   = "Project Name"
  type          = string
}

variable "environment" {
  description   = "Environment"
  type          = string
}

# vpc variables
variable "vpc_cidr" {
  description   = "VPC CIDR Block"
  type          = string
}

variable "public_subnet_AZ1_cidr" {
  description   = "Public Subnet AZ1 cidr block"
  type          = string
}

variable "public_subnet_AZ2_cidr" {
  description   = "Public Subnet AZ2 cidr block"
  type          = string
}

variable "private_app_subnet_AZ1_cidr" {
  description   = "Private App Subnet AZ1 cidr block"
  type          = string
}

variable "private_app_subnet_AZ2_cidr" {
  description   = "Private App Subnet AZ2 cidr block"
  type          = string
}

variable "private_data_subnet_AZ1_cidr" {
  description   = "Private Data Subnet AZ1 cidr block"
  type          = string
}

variable "private_data_subnet_AZ2_cidr" {
  description   = "Private Data Subnet AZ2 cidr block"
  type          = string
}

# Security group variables
variable "ssh_location" {
  description   = "the ip address that can ssh into the server"
  type          = string
}

# RDS variables
variable "db_engine" {}
variable "db_engine_version" {}
variable "multi-az-deployment" {}
variable "db_instance_identifier" {}
variable "db_master_username" {}
variable "db_master_password" {}
variable "db_instance_class" {}
variable "db_storage" {}
variable "rds_db_name" {}
variable "final_snapshot" {}
variable "public_access" {}

# ACM variables
variable "domain_name" {}
variable "alternative_names" {}

# S3 variables
variable "env_file_bucket_name" {}
variable "env_file_name" {}

# EC2 variables
variable "ami" {}
variable "ec2-instance-type" {}

# IAM variables
variable "s3-policy-arn" {}
variable "ecs-policy-arn" {}

# ALB variables
variable "alb_target_type" {}
variable "alb_matcher" {}
variable "alb_default_action_type" {}
variable "alb_redirect_host" {}
variable "alb_redirect_path" {}
variable "alb_redirect_status_code" {}
variable "ssl_certificate_arn" {}

# ECS variables
# variable "alb_target_type" {}
# variable "alb_matcher" {}

################################################



# # SNS topic variables
# variable "operator_email" {
#   default       = "mbohlip@aol.com"
#   description   = "a valid email address"
#   type          = string
# }

# # ASG variables
# variable "launch_template_name" {
#   default       = "Dev-launch-template"
#   description   = "name of the launch template"
#   type          = string
# }

# variable "ec2_image_id" {
#   default       = "ami-06888834bc43fe382"
#   description   = "id of the ami"
#   type          = string
# }

# variable "ec2_instance_type" {
#   default       = "t2.micro"
#   description   = "ec2 instance type"
#   type          = string
# }

# variable "ec2_keypair_name" {
#   default       = "myec2key"
#   description   = "ec2 Keypair name"
#   type          = string
# }

# # Route 53 variables
# # variable "domain_name" {
# #   default       = "mpndevops.com"
# #   description   = "Domain name"
# #   type          = string
# # }

