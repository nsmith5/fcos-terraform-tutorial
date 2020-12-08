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

locals {
  webservers = 3
}

data "ct_config" "web" {
  count   = local.webservers
  content = templatefile("web.yaml", { count = count.index })
  strict  = true
}

resource "aws_instance" "web" {
  count         = local.webservers
  ami           = "ami-0699a4456969d8650"
  instance_type = "t3.micro"
  user_data     = data.ct_config.web[count.index].rendered

  tags = {
    Name = "Web Server ${count.index}"
  }
}

data "ct_config" "lb" {
  content = templatefile(
    "lb.yaml",
    {
      servers = zipmap(aws_instance.web.*.id, aws_instance.web.*.public_ip)
    }
  )
  strict = true
}

resource "aws_instance" "lb" {
  ami           = "ami-0699a4456969d8650"
  instance_type = "t3.micro"
  user_data     = data.ct_config.lb.rendered

  tags = {
    Name = "Hello Fedora CoreOS"
  }
}

output "instance_ip_addr" {
  value = aws_instance.lb.public_ip
}
