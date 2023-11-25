# create security group for the application load balancer
resource "aws_security_group" "alb_security_group" {
  name        = "mpn-nestapp-alb-sg"
  description = "enable http/https access on port 80/443"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Source IP
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Source IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mpn-nestapp-alb-sg"
  }
}

# create security group for eic endpoint
resource "aws_security_group" "eice_security_group" {
  name        = "mpn-nestapp-eice-sg"
  description = "Used to SSH into EC2 in the private subnet" # It initiates traffic from within our VPC
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = {
    Name = "mpn-nestapp-eice-sg"
  }
}

# create security group for the server
resource "aws_security_group" "server_security_group" {
  name        = "mpn-nestapp-server-sg"
  description = "enable ssh access on port 22"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "http access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description     = "https access"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description     = "ssh access" // To ssh to server using ec2 instance connect endpoint
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.eice_security_group.id] // Source
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mpn-nestapp-server-sg"
  }
}

# create security group for the container
resource "aws_security_group" "container_sg" {
  name        = "mpn-nestapp-container-sg"
  description = "mpn-nestapp-container-sg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description     = "https"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mpn-nestapp-container-sg"
  }
}

# create security group for the Database
resource "aws_security_group" "database_sg" {
  name        = "mpn-nestapp-database-sg"
  description = "mpn-nestapp-database-sg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "MySQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.container_sg.id]
  }

  ingress {
    description     = "MySQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.server_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mpn-nestapp-database-sg"
  }
}