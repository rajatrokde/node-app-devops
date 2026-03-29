provider "aws" {
  region = "ap-south-1"
}

data "aws_ssm_parameter" "ubuntu" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_instance" "devops_server" {
  ami           = data.aws_ssm_parameter.ubuntu.value
  instance_type = "t2.micro"

  tags = {
    Name = "DevOps-Server"
  }
}
