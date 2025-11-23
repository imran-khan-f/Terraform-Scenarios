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

#ami = "ami-0d902a8756c37e690"
/*Scenario 1: Run a Local Shell Script After Creating EC2
Use case:
You want Terraform to run a script on your local machine after EC2 is created.
Provisioner type:
local-exec

Supporting App File (local script)
Create a script scripts/notify.sh:
#!/bin/bash
echo "EC2 instance created successfully!" >> logs/provision.log

Your Task (Terraform)
Create an EC2 instance
Use local-exec to run notify.sh
Pass instance ID to the script as argument*/

resource "aws_instance" "myec2" {
  ami = "ami-0d902a8756c37e690"
  instance_type = "t2.small"

  provisioner "local-exec" {
    command = "bash scripts/notify.sh ${self.id}"
  }
}

#terraform plan