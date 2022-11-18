# get hosted zone details
data "aws_route53_zone" "hosted_zone" {
    name = var.domain_name
}

# create a record set in route 53 targeting ELB
resource "aws_route53_record" "site_domain" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.record_name
  type    = "CNAME"

  alias {
    name                   = aws_elb.demo-lb.dns_name
    zone_id                = aws_elb.demo-lb.zone_id
    evaluate_target_health = true
  }
}