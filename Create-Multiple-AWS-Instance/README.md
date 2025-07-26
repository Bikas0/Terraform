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

<b>terraform:</b> Top-level block that configures settings for Terraform itself.

<b>required_providers:</b> Declares the provider plugins Terraform needs (in this case, AWS).

<b>aws:</b> A named provider configuration for AWS.

<b>source = "hashicorp/aws":</b> Specifies the source of the AWS provider — HashiCorp's official registry.

<b>version = "~> 4.16":</b> Allows compatible versions like 4.16.x, but not 5.0 or above.

<b>required_version = ">= 1.2.0":</b> Ensures Terraform CLI is version 1.2.0 or higher for compatibility with the configuration syntax and features used.

## provider Block

```bash
provider "aws" {
  region = "us-east-1"
}
```

<b>provider "aws":</b> Tells Terraform to use AWS as the cloud provider.

<b>region = "us-east-1":</b> Specifies that all resources will be created in the US East (N. Virginia) region.

## locals Block

```bash
locals {
  instance_names = ["bikas", "sunny", "sinthi", "sysnova"]
}
```

<b>locals:</b> A special block to define local variables for reuse throughout the configuration.

<b>instance_names:</b> A list variable holding names to be used as EC2 instance tags.

The names "bikas", "sunny", "sinthi", and "sysnova" will be used to identify different EC2 instances.

## resource Block (aws_instance)

```bash
resource "aws_instance" "bikas_ec2_instance" {
  count         = length(local.instance_names)
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t3.small"

  tags = {
    Name = local.instance_names[count.index]
  }
}
```

<b>resource "aws_instance" "bikas_ec2_instance":</b> Declares a resource of type aws_instance (for creating EC2 VMs) with a unique Terraform name bikas_ec2_instance.

<b>count = length(local.instance_names):</b>

This enables count-based resource iteration.

Terraform will create as many instances as the number of items in local.instance_names (4 instances in this case).

<b>ami = "ami-020cba7c55df1f615":</b>

Specifies the AMI ID to use for all instances.

This AMI must exist in the us-east-1 region.

It defines the operating system and preinstalled packages.

<b>instance_type = "t3.small":</b>

Defines the size of the EC2 instance.

t3.small = 2 vCPU, 2 GB RAM (cost-efficient for light workloads).

<b>tags:</b>

Adds metadata to each EC2 instance.

<b>Name = local.instance_names[count.index]:</b>

Dynamically assigns names from the list.

count.index is the loop index (0 to 3), so each instance gets a unique name.

## output Block – Public IPs

```bash
output "ec2_public_ips" {
  value = aws_instance.bikas_ec2_instance[*].public_ip
}
```

<b>output "ec2_public_ips":</b>

Declares an output variable called ec2_public_ips.

This will be shown after Terraform apply completes.

<b>value = aws_instance.bikas_ec2_instance[*].public_ip:</b>

Collects the public_ip from all created instances using a splat expression.

Returns a list of public IPs.

## output Block – Name and IP Pairs

```bash
output "ec2_name_and_ip" {
  value = [
    for i in aws_instance.bikas_ec2_instance :
    {
      name = i.tags["Name"]
      ip   = i.public_ip
    }
  ]
}
```

<b>output "ec2_name_and_ip":</b>

Declares another output variable that provides both names and IPs of instances.

<b>value = [for i in aws_instance.bikas_ec2_instance : {...}]:</b>

A for-expression that loops over each instance.

Extracts:

i.tags["Name"]: The name tag of the instance.

i.public_ip: The public IP of that instance.