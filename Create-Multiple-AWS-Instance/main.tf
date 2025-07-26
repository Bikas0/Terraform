terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

# Define the list of instance names
locals {
  instance_names = ["bikas", "sunny", "sinthi", "sysnova"]
}

resource "aws_instance" "bikas_ec2_instance" {
  count         = length(local.instance_names)               # Create as many instances as names in the list
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t3.small"

  tags = {
    Name = local.instance_names[count.index]                 # Assign custom name from the list
  }
}

output "ec2_public_ips" {
  value = aws_instance.bikas_ec2_instance[*].public_ip       # Show all public IPs
}

output "ec2_name_and_ip" {
  value = [
    for i in aws_instance.bikas_ec2_instance :
    {
      name = i.tags["Name"]
      ip   = i.public_ip
    }
  ]
}