# Terraform

## terraform Block

```bash
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
```

required_providers: Specifies which provider plugins Terraform should use.

aws: Defines the AWS provider.

source = "hashicorp/aws": This tells Terraform to use the AWS provider published by HashiCorp.

version = "~> 4.16"`: Allows Terraform to use version 4.16 and any newer patch releases (e.g., 4.16.1, 4.17.0), but not major version 5.x.

required_version = ">= 1.2.0": This ensures that Terraform version 1.2.0 or higher is used to run this configuration.

## provider Block

```bash
provider "aws" {
  region = "us-east-1"
}
```

provider "aws": Declares that you're using the AWS provider for all AWS-related resources.

region = "us-east-1": All AWS resources will be created in the US East (N. Virginia) region.

## resource Block (EC2 Instance)

```bash
resource "aws_instance" "bikas_ec2_instance" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t3.small"

  tags = {
    Name = "TerraformBatch-instance"
  }
}
```

resource "aws_instance" "bikas_ec2_instance": This declares a resource of type aws_instance (EC2 virtual machine), with the name/identifier bikas_ec2_instance.

Inside this block:

ami = "ami-020cba7c55df1f615"`:

This is the Amazon Machine Image (AMI) ID that will be used to launch the instance.

This particular AMI must be available in the us-east-1 region.

instance_type = "t3.small"`:

Specifies the type/size of the EC2 instance.

t3.small offers 2 vCPUs and 2 GiB of RAM—good for light workloads.

tags:

Adds metadata to the EC2 instance in key-value form.

Name = "TerraformBatch-instance": This will be visible in the AWS EC2 dashboard to identify the instance by name.

## output Block

```bash
output "ec2_public_ips" {
	value = aws_instance.bikas_ec2_instance.public_ip
}
```

output "ec2_public_ips": Defines an output variable named ec2_public_ips.

value = aws_instance.bikas_ec2_instance.public_ip:

Fetches and displays the public IP address of the created EC2 instance.

This is useful to SSH into the instance or access any services running on it.

## Summary
  Block           ----------------            Purpose <br>
terraform --------------> Sets required providers and Terraform version <br>
provider ---------------> Configures AWS region <br>
resource ---------------> Provisions an EC2 instance <br>
output	----------------> Displays the EC2 instance's public IP after creation
