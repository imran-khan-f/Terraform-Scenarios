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

/*Scenario 3 — Enable S3 versioning only in prod
If prod → versioning = "Enabled"
Else → versioning = "Suspended"*/

variable "s3_versioning" {
  type = string
  default = "prod"  
}

resource "aws_s3_bucket" "my_s3" {
  bucket = "my-flick-398398"

  tags = {
    "Build" = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_s3.id
  versioning_configuration {
    status = var.s3_versioning == "prod" ? "Enabled" : "Disabled"
  }  
}

output "s3_arn" {
  value = aws_s3_bucket.my_s3.arn
}

#terraform plan -var="s3_versioning=prod"
