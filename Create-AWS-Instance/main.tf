terraform {
  required_providers {
    aws = {                               # Define the AWS provider
      source  = "hashicorp/aws"           # Source of the provider plugin (official AWS provider)
      version = "~> 4.16"                 # Use version 4.16 and compatible newer minor versions (but not 5.0+)
    }
  }

  required_version = ">= 1.2.0"           # Minimum required Terraform CLI version is 1.2.0
}

provider "aws" {
  region = "us-east-1"                    # Set AWS region where resources will be created (N. Virginia)
}

resource "aws_instance" "bikas_ec2_instance" {  # Create an EC2 instance named "bikas_ec2_instance"
  count = 4
  ami           = "ami-020cba7c55df1f615"       # AMI ID to use for the instance (OS image)
  instance_type = "t3.small"                    # Instance type: 2 vCPUs, 2 GiB memory (small workload)

  tags = {
    Name = "TerraformBatch-instance"            # Tag to name the instance in the AWS console
  }
}

output "ec2_public_ips" {
  value = aws_instance.bikas_ec2_instance[*].public_ip  # Output the public IP of the created EC2 instance. If Multiple instance is created that time have to use [*] for showing all the Public ip
}
