provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "devops_server" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "DevOps-Server"
  }
}
