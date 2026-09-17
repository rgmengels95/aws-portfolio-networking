resource "aws_route53_zone" "internal_zone" {
  provider = aws.workload
  name     = "internal.project.local"

  vpc {
    vpc_id = aws_vpc.workload_vpc.id
  }
}

resource "aws_route53_record" "home_primary" {
  provider       = aws.workload
  zone_id        = aws_route53_zone.internal_zone.zone_id
  name           = "home.internal.project.local"
  type           = "A"
  ttl            = 300
  records        = ["10.2.0.100"]
  set_identifier = "home-primary"

  weighted_routing_policy {
    weight = 50
  }
}

resource "aws_route53_record" "home_secondary" {
  provider       = aws.workload
  zone_id        = aws_route53_zone.internal_zone.zone_id
  name           = "home.internal.project.local"
  type           = "A"
  ttl            = 300
  records        = ["10.2.0.201"]
  set_identifier = "home-secondary"

  weighted_routing_policy {
    weight = 50
  }
}