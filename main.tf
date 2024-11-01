terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = "terraform"   
}

# Security Group for Ubuntu servers
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
  ami           = ami-00498a47f0a5d4232                       # Using variable for AMI ID
  instance_type = t2.medium             # Using variable for instance type
  security_groups = sg-042a101c86521fdbb

  tags = {
    Name = "Ubuntu-Server-${count.index + 1}"
  }
}

# Variables
variable "ami" {
  description = "AMI ID for Ubuntu"
  type        = string
  default     = "ami-0279c3b3186e54acd"        # Default to the Ubuntu AMI for us-west-2
}

variable "instance_type" {
  description = "Instance type for Ubuntu servers"
  type        = string
  default     = "t2.micro"                     # Set a default instance type
}
