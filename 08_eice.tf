resource "aws_ec2_instance_connect_endpoint" "eice" {
  subnet_id          = aws_subnet.private_app_subnet_az1.id
  security_group_ids = [aws_security_group.eice_security_group.id]

  tags = {
    Name = "${var.environment}-${var.project_name}-eice"
  }
}