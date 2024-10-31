variable "aws_region" {
  description = "AWS region to deploy the instances"
  type        = string
  default     = "us-west-2"                  # Set your preferred AWS region
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"                    # Use "default" or your specific profile name
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"                   # Change instance type as needed
}
