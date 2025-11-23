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

/*Scenario 1 — Map of instance types per environment
You have dev, stage, prod environments.
Each environment should use a different instance type from a map.
Example (logic, not code):
dev   → t3.micro
stage → t3.small
prod  → t3.large*/

variable "environment" {
  type = string
  default = "prod"
  
}
variable "instance_type" {
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "stage" = "t3.small"
    "prod" = "t3.large"
  }
}

resource "aws_instance" "my_ec2" {
  ami = "ami-0d902a8756c37e690"
  instance_type = var.instance_type[var.environment]
  
  tags = {
    "Name" = "web${var.environment}"
  }
}

output "env" {
  value = aws_instance.my_ec2.tags
}

#terraform plan -var="environment=prod"