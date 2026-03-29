provider "aws" {
  region = "ap-southeast-2"
}

data "aws_ssm_parameter" "ubuntu" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_instance" "devops_server" {
  ami           = data.aws_ssm_parameter.ubuntu.value
  instance_type = "c7i-flex.large"

  tags = {
    Name = "DevOps-Server"
  }
}
