# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name         = "${var.project_name}-${var.environment}-database-subnets"
  subnet_ids   = [aws_subnet.private_data_subnet_az1.id, aws_subnet.private_data_subnet_az2.id]
  description  = "subnets for database instance"

  tags   = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

# get the latest db snapshot
data "aws_db_snapshot" "latest_db_snapshot" {
  db_snapshot_identifier = var.db_snapshots_identifier
  most_recent            = true
  snapshot_type          = "manual"
}

# create database instance restored from db snapshots
resource "aws_db_instance" "database_instance" {
  instance_class          = var.db_instance_class
  skip_final_snapshot     = true
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  identifier              = var.db_instance_identifier
  snapshot_identifier     = data.aws_db_snapshot.latest_db_snapshot.id
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  multi_az                = var.multi-az-deployment
  vpc_security_group_ids  = [aws_security_group.database_security_group.id]
}