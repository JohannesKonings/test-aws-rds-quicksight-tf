resource "aws_db_subnet_group" "rds_aws_db_subnet_group" {
  name       = local.name_lowercase
  subnet_ids = [aws_subnet.rds_aws_subnet_private.id]

  tags       = local.tags
}

resource "aws_db_instance" "rds_aws_db_instance" {
  identifier             = "test-rds-postgresql"
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "12.5"
  instance_class         = "db.t3.micro"
  name                   = local.name
  username               = var.rds_username
  password               = var.rds_password
  parameter_group_name   = "default.postgres12"
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  skip_final_snapshot    = true
  publicly_accessible    = true

  tags = local.tags
}
