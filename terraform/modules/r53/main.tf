data "aws_route53_zone" "public" {
   name = "davidro.com"
   private_zone = false 
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.public.id 
  name = var.record_name 
  type = var.record_type 

  alias {
    name = var.alias_name 
    zone_id = var.alias_zoneid
    evaluate_target_health = var.evaluate_target_health
  }
}