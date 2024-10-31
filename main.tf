terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile   # Or use "default" if AWS profile is default
}

# Security group allowing inbound SSH (port 22)
resource "aws_security_group" "ubuntu_sg" {
  name        = "ubuntu-security-group"
  description = "Security group for Ubuntu servers"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Loop to create 3 Ubuntu EC2 instances
resource "aws_instance" "ubuntu_instance" {
  count         = 3
  ami           = "ami-0279c3b3186e54acd"    # Ubuntu 22.04 AMI for us-west-2 (use an updated one for your region)
  instance_type = var.instance_type
  security_groups = [aws_security_group.ubuntu_sg.name]

  tags = {
    Name = "Ubuntu-Server-${count.index + 1}"
  }
}

