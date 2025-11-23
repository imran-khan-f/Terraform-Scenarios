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

/*Scenario 2 — Map of AMI IDs per region
You want to deploy EC2 instances in different AWS regions using a map:
Logic:
us-west-1 = ami-0d902a8756c37e690
us-west-2 = ami-04f9aa2b7c7091927
us-east-2 = ami-0a627a85fdcfabbaa*/

variable "environment" {
  type = string
  default = "us-west-1"
}

variable "region" {
  default = {
    us-west-1 = "ami-0d902a8756c37e690"
    us-west-2 = "ami-04f9aa2b7c7091927"
    us-east-2 = "ami-0a627a85fdcfabbaa"
  }
}

resource "aws_instance" "my_ec2" {
  instance_type = "t2.small" 
  ami = var.region[var.environment]
}

output "reg" {
  value = aws_instance.my_ec2.region
}

#terraform plan -var="environment=us-west-2"