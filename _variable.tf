# environment variables
variable "region" {}
variable "project_name" {}
variable "environment" {}

# vpc variables
variable "vpc_cidr" {}
variable "public_subnet_AZ1_cidr" {}
variable "public_subnet_AZ2_cidr" {}
variable "private_app_subnet_AZ1_cidr" {}
variable "private_app_subnet_AZ2_cidr" {}
variable "private_data_subnet_AZ1_cidr" {}
variable "private_data_subnet_AZ2_cidr" {}

# Security group variables
variable "ssh_location" {}

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
variable "rds_endpoint" {}

# ACM variables
variable "domain_name" {}
variable "alternative_names" {}

# S3 variables
variable "env_file_bucket_name" {}
variable "env_file_name" {}

# EC2 variables
variable "ami" {}
variable "ec2-instance-type" {}
variable "s3_nestapp_bucket" {}
variable "nestapp_sql" {}

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
variable "ecs_architecture" {}
# variable "ecs_container_image_uri" {}

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

