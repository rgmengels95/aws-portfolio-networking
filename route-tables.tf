resource "aws_route" "networking_to_workload" {
  provider               = aws.networking
  route_table_id         = aws_vpc.networking_vpc.default_route_table_id
  destination_cidr_block = "10.2.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.project_tgw.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment_accepter.workload_attachment_accepter]
}

resource "aws_route" "workload_to_networking" {
  provider               = aws.workload
  route_table_id         = aws_vpc.workload_vpc.default_route_table_id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.project_tgw.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment_accepter.workload_attachment_accepter]
}