resource "aws_ec2_transit_gateway_vpc_attachment" "networking_attachment" {
  provider           = aws.networking
  transit_gateway_id = aws_ec2_transit_gateway.project_tgw.id
  vpc_id             = aws_vpc.networking_vpc.id
  subnet_ids         = [aws_subnet.networking_subnet_a.id]

  tags = {
    Name = "NetworkingVPC-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "workload_attachment" {
  provider = aws.workload

  depends_on = [aws_ram_principal_association.tgw_share_principal]

  transit_gateway_id = aws_ec2_transit_gateway.project_tgw.id
  vpc_id             = aws_vpc.workload_vpc.id
  subnet_ids         = [aws_subnet.workload_subnet_a.id]

  tags = {
    Name = "WorkloadVPC-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "workload_attachment_accepter" {
  provider                  = aws.networking
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.workload_attachment.id

  tags = {
    Name = "WorkloadVPC-Attachment"
  }
}