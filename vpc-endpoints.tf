resource "aws_vpc_endpoint" "workload_s3_endpoint" {
  provider          = aws.workload
  vpc_id            = aws_vpc.workload_vpc.id
  service_name      = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_vpc.workload_vpc.default_route_table_id]

  tags = {
    Name = "WorkloadS3Endpoint"
  }
}

resource "aws_security_group" "secrets_manager_endpoint_sg" {
  provider    = aws.workload
  name        = "SecretsManagerEndpointSG"
  description = "Allows HTTPS from within WorkloadVPC to reach Secrets Manager endpoint"
  vpc_id      = aws_vpc.workload_vpc.id

  ingress {
    description = "HTTPS from WorkloadVPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.2.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SecretsManagerEndpointSG"
  }
}

resource "aws_vpc_endpoint" "workload_secretsmanager_endpoint" {
  provider            = aws.workload
  vpc_id              = aws_vpc.workload_vpc.id
  service_name        = "com.amazonaws.us-east-2.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.workload_subnet_a.id]
  security_group_ids  = [aws_security_group.secrets_manager_endpoint_sg.id]
  private_dns_enabled = true
}