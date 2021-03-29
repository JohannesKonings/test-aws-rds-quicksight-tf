terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.34.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "rds_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "testRds"
  }
}
