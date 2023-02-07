terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2" {
  count                  = 2
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = "t2.micro"
  user_data              = file("${path.module}/httpd-install.sh")
  vpc_security_group_ids = [aws_security_group.web.id]
}

resource "aws_security_group" "web" {
  name        = "web"
  description = "Dev vpc web"
  ingress {
    description = "inbound port 80"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "outbound port all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "myl" {
  name = "myl"
  subnets = [ aws_instance.myec2[0].subnet_id, aws_instance.myec2[1].subnet_id]

  listener {
    lb_protocol = "http"
    lb_port = "80"
    instance_port = "80"
    instance_protocol= "http"
  }
  instances = [aws_instance.myec2[0].id, aws_instance.myec2[1].id]

}

