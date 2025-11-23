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


/*Scenario 3 — Map of tags applied to a resource
You want to maintain all tags in a single map variable like:
{
  Environment = "dev"
  Owner       = "Imran"
  Project     = "Terraform-Learning"
}*/

variable "map_of_tags" {
    type = map(string)
    default = {
      Environment = "dev"
      Owner       = "Imran"
      Project     = "Terraform-Learning"
    }
}

resource "aws_instance" "myec2" {
  ami = "ami-0d902a8756c37e690"
  instance_type = "t2.small"  
  tags = var.map_of_tags
}

#terraform plan
