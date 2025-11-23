terraform {
  required_version = "~>1.11.4"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.21.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

/*Scenario 1 Create multiple S3 buckets using a map
Input map:
{
  bucket1 = "dev-project"
  bucket2 = "prod-project"
}
Requirement:
Use for_each
Bucket name = each.value
Tag "Name" = each.key*/

variable "s3_name" {
  type = map(string)
  default = {
    "bucket1" = "dev-project"
    "bucket2" = "prod-project"
  }
}

resource "aws_s3_bucket" "s3_env" {
  for_each = var.s3_name
  bucket = each.value
  tags = {
    "Name" = eack.key
    "Env" = each.value
  }
}

#terraform plan