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

/*Scenario 3 — Create EC2 instances with different instance types
Input map:
{
  web  = "t3.micro"
  app  = "t3.small"
  db   = "t3.medium"
}
Requirement:
Create one EC2 per key
Name tag = each.key (web/app/db)
instance_type = each.value*/

variable "ec2_type" {
  type = map(string)
  default = {
    web  = "t3.micro"
    app  = "t3.small"
    db   = "t3.medium"
  } 
}

resource "aws_instance" "instance" {
  for_each = var.ec2_type
  instance_type = each.value
  ami = "ami-0d902a8756c37e690"
  tags = {
    "Name" = "${each.key}-01"
  }
}

#terraform plan
