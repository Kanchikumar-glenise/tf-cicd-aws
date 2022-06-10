provider "aws" {
    region = "us-east-2"  
}


terraform {
  backend "s3" {
      encrypt = false
      bucket = "tf-state-dynamo-springboot"
      dynamodb_table = "tf-state-file-springboot"
      key = "path/path/terraform-tfstate"
      region = "us-east-2"
  }
}


resource "aws_vpc" "tf-state" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = {
        Name = "tf-state-vpc"
    }
}

resource "aws_subnet" "tf-state-subnet-public" {
    vpc_id = aws_vpc.tf-state.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-2a"
    tags = {
      "Name" = "tf-state-subnet-public"
    } 
}

resource "aws_subnet" "tf-state-subnet-private" {
    vpc_id = aws_vpc.tf-state.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-2b"
    tags = {
      "Name" = "tf-state-subnet-private"
    } 
}