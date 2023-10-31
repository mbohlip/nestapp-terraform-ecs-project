# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "mpn20-terraform-statefiles"
    key            = "rentzone-ecs/terraform.tfstate"
    region         = "us-east-1"
    profile        = "terraform-user"
    dynamodb_table = "terrafoiorm-state-lock"
  }
}