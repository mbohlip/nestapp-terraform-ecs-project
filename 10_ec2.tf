# launch the ec2 instance and install website
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami
  instance_type          = var.ec2-instance-type
  subnet_id              = aws_subnet.private_app_subnet_az1.id
  vpc_security_group_ids = [aws_security_group.server_security_group.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = base64encode(templatefile("${path.module}/migrate-nestapp.sql.sh.tpl", {
    S3_BUCKET_NAME = var.s3_nestapp_bucket
    SQL_FILE       = var.nestapp_sql
    RDS_ENDPOINT   = var.rds_endpoint
    RDS_DB_NAME    = var.rds_db_name
    USERNAME       = var.db_master_username
    PASSWORD       = var.db_master_password
  }))

  depends_on = [aws_db_instance.database_instance]

  tags = {
    Name = "mpn-nestapp-ec2"
  }
}