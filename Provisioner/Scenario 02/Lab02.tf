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

/*Trigger a Local Python Program After S3 Bucket Creation
Purpose:
Run a local Python script to log the bucket name into an internal system.

Supporting Script:
scripts/log_bucket.py

import sys

bucket = sys.argv[1]
with open("output/buckets.log", "a") as f:
    f.write(f"New bucket created: {bucket}\n")

print("Bucket logged successfully.")

What local-exec should do:
Call Python with the bucket name.*/

resource "aws_s3_bucket" "bucker_s3" {
  bucket = "flick-dev-bucket"
  provisioner "local-exec" {
    command = "python3 scripts/log_bucket.py ${self.bucket}"
  }

  tags = {
    "Bulid" = "Terraform"
  }
}