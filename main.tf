terraform {
  required_version = "~>1.2.1"

  required_providers {
    aws = {
      version = ">= 3.50.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name  

  vpc_security_group_ids = ["${aws_security_group.vm.id}"]
  
  associate_public_ip_address = true

  tags = {
    "Name" = "web-terraform"
  }
}
resource "aws_security_group" "vm" {
  name        = "vm"
  description = "vm"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidrs_acesso_remoto
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidrs_acesso_remoto
  }

  ingress {
    description = "HTTPS to EC2"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.cidrs_acesso_remoto
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "vm"
  }
}
