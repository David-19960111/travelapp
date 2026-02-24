output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "public_security_group_id" {
  value = module.public_sg.security_group_id
}

output "rds_security_group_id" {
  value = module.rds_public_sg.security_group_id
}

output "alb_dns" {
  value = module.alb.alb_dns
}

output "alb_zone_id" {
  value = module.alb.alb_zone_id
}

output "alb_tg_arn" {
  value = module.alb.alb_tg_arn
}

output "rds_db_hostname" {
  value = module.rds.rds_db_hostname
}

output "ecs_taskdef_arn" {
  value = module.ecs.ecs_taskdef_arn
}

output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}