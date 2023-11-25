#Create a role for S3 access
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "s3_FullAccess" {
  name = "nestapp-S3FullAccessRole"

  # Terraform's "jsonencode" function converts a
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "nestapp-S3FullAccessRole"
  }
}

#Create a role for ECS task execution access
resource "aws_iam_role" "ecs_task_execution" {
  name = "nestapp-ecs-task-role"

  # Terraform's "jsonencode" function converts a
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "nestapp-ecs-task-role"
  }
}


#Attach policy to S3 role
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "s3_role_policy" {
  role       = aws_iam_role.s3_FullAccess.name
  policy_arn = var.s3-policy-arn
}

#Attach policy to ECS role
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = var.ecs-policy-arn
}

# Create an S3 iam instance profile
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "nestapp-s3-profile"
  role = aws_iam_role.s3_FullAccess.name
}

# Create an ECS iam instance profile
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ecs_profile" {
  name = "nestapp-ecs-execution-profile"
  role = aws_iam_role.ecs_task_execution.name
}