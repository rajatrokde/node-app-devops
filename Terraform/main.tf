provider "aws" {
  region = "ap-southeast-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["459798871689"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


resource "aws_instance" "devops_server" {
  ami           = data.aws_ami.ubuntu.id   
  instance_type = "c7i-flex.large"

  tags = {
    Name = "DevOps-Server"
  }
}
