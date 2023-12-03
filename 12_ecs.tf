# create ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name      = "${var.environment}-${var.project_name}-ecs-cluster"

  setting {
    name    = "containerInsights"
    value   = "disabled"
  }
}

# create cloudwatch log group
resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${var.environment}-${var.project_name}-ecs-td"

  lifecycle {
    create_before_destroy = true // when we update the resource, terraform should destroy before creating a new one
  }
}
 
# create task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                    = "${var.environment}-${var.project_name}-ecs-td"
  execution_role_arn        = aws_iam_role.ecs_task_execution_role.arn
  network_mode              = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                       = 2048
  memory                    = 4096

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.ecs_architecture
  }

  # create container definition
  container_definitions     = jsonencode([
    {
      name                  = "${var.environment}-${var.project_name}-ecs-container"
      image                 = "${var.ecs_container_image_uri}"
      essential             = true

      portMappings          = [
        {
          containerPort     = 80
          hostPort          = 80
        }
      ]

      environmentFiles = [
        {
          value = "arn:aws:s3:::${var.environment}-${var.project_name}-${var.env_file_bucket_name}/${var.env_file_name}"
          type  = "s3"
        }
      ]

      logConfiguration = {
        logDriver      = "awslogs",
        options        = {
          "awslogs-group"          = "${aws_cloudwatch_log_group.log_group.name}",
          "awslogs-region"         = "${var.region}",
          "awslogs-stream-prefix"  = "ecs"
        }
      }
    }
  ])
}

# create ecs service
resource "aws_ecs_service" "ecs_service" {
  name                               = "${var.environment}-${var.project_name}-ecs-service"
  launch_type                        = "FARGATE"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  platform_version                   = "LATEST"
  desired_count                      = 2 // means we want 2 containers
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  # task tagging configuration
  enable_ecs_managed_tags            = false
  propagate_tags                     = "SERVICE"

  # vpc and security groups
  network_configuration {
    subnets = [aws_subnet.private_app_subnet_az1.id,aws_subnet.private_app_subnet_az2.id]
    security_groups         =  [aws_security_group.container_sg.id]
    assign_public_ip        = false
  }

  # load balancing
  load_balancer {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    container_name   = "${var.environment}-${var.project_name}-ecs-container"
    container_port   = 80
  }
}