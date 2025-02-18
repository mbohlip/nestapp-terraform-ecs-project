# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.environment}-${var.project_name}-database-subnets"
  subnet_ids  = [aws_subnet.private_data_subnet_az1.id, aws_subnet.private_data_subnet_az2.id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.environment}-${var.project_name}-database-subnets"
  }
}

# create database instance restored from db snapshots
resource "aws_db_instance" "database_instance" {
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  multi_az               = var.multi-az-deployment
  identifier             = var.db_instance_identifier
  username               = var.db_master_username
  password               = var.db_master_password
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_storage
  db_name                = var.rds_db_name
  availability_zone      = data.aws_availability_zones.available_zones.names[1]
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  skip_final_snapshot    = var.final_snapshot
  publicly_accessible    = var.public_access
}
