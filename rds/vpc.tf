
resource "aws_vpc" "rds_vpc" {
  cidr_block           = "172.32.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}

resource "aws_internet_gateway" "rds_aws_internet_gateway" {
  vpc_id = aws_vpc.rds_vpc.id

  tags = local.tags
}

resource "aws_eip" "rds_aws_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.rds_aws_internet_gateway]

  tags = local.tags
}


resource "aws_subnet" "rds_aws_subnet_private_a" {
  vpc_id                  = aws_vpc.rds_vpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "172.32.0.0/24"
  map_public_ip_on_launch = false

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_private_b" {
  vpc_id                  = aws_vpc.rds_vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "172.32.1.0/24"
  map_public_ip_on_launch = false

  tags = local.tags
}

resource "aws_route_table" "rds_aws_route_table_private" {
  vpc_id = aws_vpc.rds_vpc.id

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_public_a" {
  vpc_id                  = aws_vpc.rds_vpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "172.32.2.0/24"
  map_public_ip_on_launch = true

  tags = local.tags
}

resource "aws_subnet" "rds_aws_subnet_public_b" {
  vpc_id                  = aws_vpc.rds_vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "172.32.3.0/24"
  map_public_ip_on_launch = true

  tags = local.tags
}

resource "aws_route_table" "rds_aws_route_table_public" {
  vpc_id = aws_vpc.rds_vpc.id

  tags = local.tags
}

resource "aws_route" "rds_aws_route_public" {
  route_table_id         = aws_route_table.rds_aws_route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.rds_aws_internet_gateway.id
}

resource "aws_route_table_association" "rds_aws_route_table_association_public_a" {
  subnet_id      = aws_subnet.rds_aws_subnet_public_a.id
  route_table_id = aws_route_table.rds_aws_route_table_public.id
}

resource "aws_route_table_association" "rds_aws_route_table_association_public_b" {
  subnet_id      = aws_subnet.rds_aws_subnet_public_b.id
  route_table_id = aws_route_table.rds_aws_route_table_public.id
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
