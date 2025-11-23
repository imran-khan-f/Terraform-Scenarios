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

/*Scenario 2 — Create IAM users from a set of names
Input set:
["imran", "siva", "arun"]
Requirement:
Use for_each
Username = each.value
Home directory tag = each.key (index-like)*/

variable "users" {
  type = set(string)
  default = ["imran", "siva", "arun"]
}

resource "aws_iam_user" "iam_name" {
  for_each = var.users
  name = each.value
  tags = {
    "homedir" = "user${each.value}"
  }
}