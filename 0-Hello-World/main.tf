terraform {
  required_providers {
    ct = {
      source  = "poseidon/ct"
      version = "0.7.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "ct" {}

data "ct_config" "config" {
  content = file("config.yaml")
  strict  = true
}

resource "aws_instance" "server" {
  ami           = "ami-0699a4456969d8650"
  instance_type = "t3.micro"
  user_data     = data.ct_config.config.rendered

  tags = {
    Name = "Hello Fedora CoreOS"
  }
}

output "instance_ip_addr" {
  value = aws_instance.server.public_ip
}
