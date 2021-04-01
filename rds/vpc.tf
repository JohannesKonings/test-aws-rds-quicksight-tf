
resource "aws_vpc" "rds_vpc" {
  cidr_block = "172.32.0.0/16"

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_private_a" {
  vpc_id = aws_vpc.rds_vpc.id

  availability_zone = "us-east-1a"

  cidr_block = "172.32.0.0/24"

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_private_b" {
  vpc_id = aws_vpc.rds_vpc.id

  availability_zone = "us-east-1b"

  cidr_block = "172.32.1.0/24"

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_public_a" {
  vpc_id = aws_vpc.rds_vpc.id

  availability_zone = "us-east-1a"

  cidr_block = "172.32.2.0/24"

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_public_b" {
  vpc_id = aws_vpc.rds_vpc.id

  availability_zone = "us-east-1b"

  cidr_block = "172.32.3.0/24"

  tags = local.tags
}

resource "aws_security_group" "rds_security_group" {

  name        = local.name
  description = "Complete PostgreSQL example security group"
  vpc_id      = aws_vpc.rds_vpc.id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  tags = local.tags
}
