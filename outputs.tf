output "instance_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = [for instance in aws_instance.ubuntu_instance : instance.public_ip]
}