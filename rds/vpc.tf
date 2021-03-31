
resource "aws_vpc" "rds_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_private" {
  vpc_id = aws_vpc.rds_vpc.id

  cidr_block = "10.0.0.0/24"

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_public" {
  vpc_id = aws_vpc.rds_vpc.id

  cidr_block = "10.0.1.0/24"

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
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}
