# ECR repository to store docker image
resource "aws_ecr_repository" "nestapp_ecr_repository" {
  name = "${var.environment}-${var.project_name}-ecr-repository"

  tags = {
    Name = "${var.environment}-${var.project_name}-ecr-repository"
  }

}