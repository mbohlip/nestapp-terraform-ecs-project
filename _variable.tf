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
variable "db_snapshots_identifier" {
  description   = "database snapshot name"
  type          = string
}

variable "db_instance_class" {
  description   = "the database instance type"
  type          = string
}

variable "db_instance_identifier" {
  description   = "the database instance identifier"
  type          = string
}

variable "multi-az-deployment" {
  description   = "create a standby db instance"
  type          = bool
}

# ACM variables
variable "domain_name" {
  description   = "Domain name"
  type          = string
}

variable "alternative_names" {
  default       = "www"
  description   = "Sub domain name"
  type          = string
}

################################################

# ALB variables
variable "ssl_certificate_arn" {
  default       = "arn:aws:acm:us-east-1:821363534163:certificate/2ee1cea5-f503-4ba5-bb9b-a099310f1a8d"
  description   = "SSL certificate ARN"
  type          = string
}

# SNS topic variables
variable "operator_email" {
  default       = "mbohlip@aol.com"
  description   = "a valid email address"
  type          = string
}

# ASG variables
variable "launch_template_name" {
  default       = "Dev-launch-template"
  description   = "name of the launch template"
  type          = string
}

variable "ec2_image_id" {
  default       = "ami-06888834bc43fe382"
  description   = "id of the ami"
  type          = string
}

variable "ec2_instance_type" {
  default       = "t2.micro"
  description   = "ec2 instance type"
  type          = string
}

variable "ec2_keypair_name" {
  default       = "myec2key"
  description   = "ec2 Keypair name"
  type          = string
}

# Route 53 variables
# variable "domain_name" {
#   default       = "mpndevops.com"
#   description   = "Domain name"
#   type          = string
# }

