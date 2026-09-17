resource "aws_ec2_transit_gateway" "project_tgw" {
  provider    = aws.networking
  description = "Central hub for Networking and Workload VPCs"

  tags = {
    Name = "ProjectTGW"
  }
}