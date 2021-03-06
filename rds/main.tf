terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.34.0"
    }
  }
}

locals {
  name           = "testRdsQuicksight"
  name_lowercase = "test_rds_quicksight"
  region         = "us-east-1"
  tags = {
    Name = "testRdsQuicksight"
  }
}

provider "aws" {
  region = var.region
}
