
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

/*Scenario 1 — Create EC2 only if environment is “prod”
You have a variable environment.
If prod → launch 2 EC2 instances
If dev → launch 0 EC2 instances
Requirement: Use an if condition to control count.*/

variable "use_environment" {
  type = string
  default = "dev"
}

resource "aws_instance" "EC2" {
  count = var.use_environment == "prod" ? 2 : 0
  ami = "ami-0d902a8756c37e690"
  instance_type = var.use_environment == "prod" ? "t2.large" : "t2.small"

  tags = {
    "Name" = "web-${var.use_environment}"
  }
}

# terraform plan -var"use_environment=prod"