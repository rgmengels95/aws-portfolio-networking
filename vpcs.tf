resource "aws_vpc" "networking_vpc" {
  provider             = aws.networking
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "NetworkingVPC"
  }
}

resource "aws_subnet" "networking_subnet_a" {
  provider          = aws.networking
  vpc_id            = aws_vpc.networking_vpc.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "NetworkingSubnetA"
  }
}

resource "aws_vpc" "workload_vpc" {
  provider             = aws.workload
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "WorkloadVPC"
  }
}

resource "aws_subnet" "workload_subnet_a" {
  provider          = aws.workload
  vpc_id            = aws_vpc.workload_vpc.id
  cidr_block        = "10.2.0.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "WorkloadSubnetA"
  }
}