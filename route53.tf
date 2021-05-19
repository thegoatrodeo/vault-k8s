locals {
  dns_name = "" # Local Domain Name to access Vault from outside k8s
  r53_zone_id  = "Z0xxxx"
  lb_name = "dualstack.internal-xxxx.<region>.eu-west-1.elb.amazonaws.com" # Example
  lb_zone = "Z3xxxxx" # Load balancer zone
}

resource "aws_route53_record" "ldap" {
  name    = local.dns_name
  zone_id = local.r53_zone_id
  type    = "A"

  alias {
    name                   = local.lb_name
    zone_id                = local.lb_zone
    evaluate_target_health = true
  }
}
