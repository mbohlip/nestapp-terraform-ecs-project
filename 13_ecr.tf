# ECR repository to store docker image
resource "aws_ecr_repository" "nestapp_ecr_repository" {
  name = "mpn-nestapp-ecr-repository"

  tags = {
    Name = "mpn-nestapp-ecr-repository"
  }

}