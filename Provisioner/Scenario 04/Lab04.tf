
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

/*Deploy a Python App Using file + remote-exec
Use case:
Upload and run a Python app on EC2.
Supporting App File 1: Python program
Create app/app.py:
from http.server import SimpleHTTPRequestHandler, HTTPServer
PORT = 8080

class Handler(SimpleHTTPRequestHandler):
    pass

with HTTPServer(("", PORT), Handler) as httpd:
    print(f"Server running on port {PORT}")
    httpd.serve_forever()

Supporting App File 2: Requirements
Create app/requirements.txt:
flask
requests

Your Task (Terraform)
Upload both files using file provisioner
Install python3 and pip using remote-exec
Run the python server in background using nohup*/

resource "aws_instance" "ec2" {
  ami = "ami-0d902a8756c37e690"
  instance_type = "t2.small"

  provisioner "file" {
    source = "app/"
    destination = "/tmp/app"
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("key.pem")
      host = self.public_ip
    }
  }
  provisioner "remote-exec" {
    inline = [ 
        "sudo yum install -y python3",
        "sudo yum install -y python3-pip"
        "pip3 install -r /tmp/app/requirements.txt",
        "nohup python3 /tmp/app/app.py > /tmp/app.log 2>&1 &"
    ]
        connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("key.pem")
      host = self.public_ip
    }
  }
}