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

/*Scenario 4 — Map for number of servers per environment
Logic:
dev   → 1 server  
stage → 2 servers  
prod  → 4 servers  
Use a map and read count from it.*/
#ami = "ami-0d902a8756c37e690"

variable "server_count" {
  type = map(number)
  default = {
    "dev" = 0
    "stage" = 2
    "prod" = 4
  }
}

variable "environment" {
  type = string
  default = "prod"
  
}

#extra lab method
variable "ec2_type" {
  type = map(string)
  default = {
    "dev" = "t2.small"
    "stage" = "t2.medium"
    "prod" = "t2.large"
  }
}

resource "aws_instance" "myec2" {
  ami = "ami-0d902a8756c37e690"
  instance_type = var.ec2_type[var.environment]
  count = var.server_count[var.environment]
  tags = {
    "Name" = "web${var.environment}-${count.index + 1}"
  }
}

#terraform plan -var="environment=stage"
