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
/*Upload an App File to EC2 Using file Provisioner
Use case:
Upload a web page to the EC2 server.
#ami = "ami-0d902a8756c37e690"
Supporting App File
Create app/index.html:
<html>
  <body>
    <h1>Hello from Terraform provisioner!</h1>
  </body>
</html>

Your Task (Terraform)
Create an EC2 instance
Connect using SSH with remote-exec
Upload app/index.html to /var/www/html/index.html
Restart Apache*/

resource "aws_instance" "ec2" {
  ami = "ami-0d902a8756c37e690"
  instance_type = "t2.small"

  provisioner "file" {
    source = "app/index.html"
    destination = "/var/www/html/"

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("key.pem")
      host = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo yum install -y httpd",
      "sudo mv app/index.html /var/www/html/index.html",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd"
     ]
    
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("key.pem")
      host = self.public_ip
    }
  }
}