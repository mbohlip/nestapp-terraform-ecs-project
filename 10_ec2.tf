# launch the ec2 instance and install website
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami
  instance_type          = var.ec2-instance-type
  subnet_id              = aws_subnet.private_app_subnet_az1.id
  vpc_security_group_ids = [aws_security_group.server_security_group.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
#   key_name               = 
# user_data = base64encode(templatefile("./m/migrate-nestapp-sql.sh.tpl", {
#     RDS_ENDPOINT = var.rds_endpoint
#     RDS_DB_NAME  = var.database_name
#     USERNAME     = var.database_username
#     PASSWORD     = var.database_password
#   }

  tags = {
    Name = "MPN-NestApp-ec2"
  }
}