# create security group for the application load balancer
resource "aws_security_group" "alb_security_group" {
  name        = "MPN-NestApp-alb-sg"
  description = "enable http/https access on port 80/443"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "https access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "MPN-NestApp-alb-sg"
  }
}

# create security group for the server
resource "aws_security_group" "server_security_group" {
  name        = "MPN-NestApp-server-sg"
  description = "enable ssh access on port 22"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description      = "https access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.eice_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "MPN-NestApp-server-sg"
  }
}

# # create security group for the web server
# resource "aws_security_group" "app_server_security_group" {
#   name        = "MPN-NestApp-app-server-sg"
#   description = "enable http/https access on port 80/443 via alb sg"
#   vpc_id      = aws_vpc.vpc.id

  

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = -1
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags   = {
#     Name = "MPN-NestApp-app-server-sg"
#   }
# }

# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "MPN-NestApp-database-sg"
  description = "enable mysql/aurora access on port 3306"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "mysql/aurora access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.server_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "MPN-NestApp-database-sg"
  }
}

# create security group for eic endpoint
resource "aws_security_group" "eice_security_group" {
  name        = "MPN-NestApp-eice-sg"
  description = "Used to SSH into EC2 in the private subnet" # It initiates traffic from within our VPC
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
  }

  tags   = {
    Name = "MPN-NestApp-eice-sg"
  }
}