# Route 53 DNS Record
resource "aws_route53_record" "strapi" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"
  
  alias {
    name                   = aws_lb.strapi.dns_name
    zone_id                = aws_lb.strapi.zone_id
    evaluate_target_health = false
  }

}