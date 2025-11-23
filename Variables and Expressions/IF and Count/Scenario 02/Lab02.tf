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

/*Scenario 2 — Choose instance type based on environment
If environment = "prod" → use t3.large
Else → use t3.micro
Use an if expression inside a variable or resource.*/
#ami = "ami-0d902a8756c37e690"

variable "environment" {
  type = string
  default = "prod"
}

resource "aws_instance" "my_ec2" {
  ami = "ami-0d902a8756c37e690"
  instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"
  tags = {
    "Name" = "${var.environment}web"
  }
}

output "ec2_type" {
  value = aws_instance.my_ec2.instance_type
}

#terraform plan -var="environment=prod"