resource "aws_ram_resource_share" "tgw_share" {
  provider                  = aws.networking
  name                      = "TGW-Share"
  allow_external_principals = false

  tags = {
    Name = "TGW-Share"
  }
}

resource "aws_ram_resource_association" "tgw_share_resource" {
  provider           = aws.networking
  resource_arn       = aws_ec2_transit_gateway.project_tgw.arn
  resource_share_arn = aws_ram_resource_share.tgw_share.arn
}

resource "aws_ram_principal_association" "tgw_share_principal" {
  provider           = aws.networking
  principal          = "223532248543"
  resource_share_arn = aws_ram_resource_share.tgw_share.arn
}