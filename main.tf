terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "sops" {}

module "network" {
  source = "./terraform/modules/network"

  vpc_tag              = "travel-app"
  vpc_cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  public_subnets_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
  public_subnets_tag   = "travelapp-public-subnet"

  create_igw       = true
  igw_tag          = "travelapp-igw"
  create_igw_route = true
  route_table_tag  = "travelapp-routetable"
}

module "public_sg" {
  source = "./terraform/modules/sg"

  vpc_id  = module.network.vpc_id
  sg_name = "travelapp-public-sg"

  sg_ingress = {
    rule-1 = {
      description = "Allow HTTP requests"
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    rule-2 = {
      description = "Allow all outbound traffic"
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_egress = {
    rule-1 = {
      description = "Allow HTTPS requests"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

module "rds_public_sg" {
  source = "./terraform/modules/sg"

  vpc_id  = module.network.vpc_id
  sg_name = "travelapp-rds-public-sg"

  sg_ingress = {
    rule-1 = {
      description = "Allow all inbound traffic to RDS"
      from_port   = 3306
      to_port     = 3306
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_egress = {
    rule-1 = {
      description = ""
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

module "ecr" {
  source = "./terraform/modules/ecr"

  ecr_repo_name = "travelapp-ecr"
  mutability    = true
}

module "ecs_cluster" {
  source = "./terraform/modules/ecs/cluster"

  ecs_cluster_name = "travelapp-cluster"
}

module "ecs_taskdef_travelapp" {
  source = "./terraform/modules/ecs/task_definition"

  task_name                = "travelapp-tasdefinition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  image_version            = "1"

  container_name    = "travelapp-container"
  image             = module.ecr.ecr_repo_url
  container_port    = 80
  host_port         = 80
  cpu               = 512
  memory            = 1024
  task_definitions  = ""
  db_hostname_value = module.ecs_ssm_sops.DB_HOSTNAME_ARN
  db_username_value = module.ecs_ssm_sops.DB_USERNAME_ARN
  db_password_value = module.ecs_ssm_sops.DB_PASSWORD_ARN
  db_name_value     = module.ecs_ssm_sops.DB_NAME_ARN
}

module "ecs_service" {
  source = "./terraform/modules/ecs/service"

  service_name        = "travelapp-service"
  cluster_id          = module.ecs_cluster.ecs_cluster_id
  task_definition_arn = module.ecs_taskdef_travelapp.ecs_taskdef_arn
  launch_type         = "FARGATE"
  desired_count       = "1"

  subnets_id         = module.network.public_subnets_id
  security_groups_id = [module.public_sg.security_group_id]

  target_group_arn = module.ecs_alb.alb_tg_arn
  container_name   = "travelapp-container"
  container_port   = 80
}

module "ecc_ssm_sops" {
  source = "./terraform/modules/ssm_sops"
}

module "rds" {
  source = "./terraform/modules/rds"

  db_name             = "travelapprds"
  identifier          = "travelapp-identifier"
  db_username         = module.ecc_ssm_sops.DB_USERNAME_SOPS
  db_password         = module.ecc_ssm_sops.DB_PASSWORD_SOPS
  engine              = "mysql"
  engine_ver          = "8.0.33"
  instance_class      = "db.t3.micro"
  apply_immediately   = true
  skip_final_snapshot = false
  publicly_accessible = false
  allocated_storage   = 20

  subnet_ids             = module.network.public_subnet_id
  vpc_security_group_ids = module.rds_public_sg.security_group_id

  db_subnet_group_name = "travelapp-group"
}

module "ecs_alb" {
  source = "./terraform/modules/alb"

  alb_name    = "travelapp-alb"
  alb_type    = "application"
  alb_subnets = module.network.public_subnet_id
  alb_sgs     = [module.public_sg.security_group_id]

  enable_https_listener      = true
  https_listener_tag         = "travelapp-https-listener"
  https_listener_port        = 443
  https_listener_protocol    = "HTTPS"
  https_ssl_policy           = "ELBSecurityPolicy-2016-08"
  https_listener_action_type = "forward"
  https_certificate_arn      = module.ecs_acm.acm_arn
  https_target_group_arn     = module.ecs_alb.alb_tg_arn

  enable_http_listener      = true
  http_listener_tag         = "travelapp-https-listener"
  http_listener_port        = 80
  http_listener_protocol    = "HTTP"
  http_listener_action_type = "redirect"
  redirect_port             = 443
  redirect_protocol         = "HTTPS"
  redirect_status_code      = "HTTP_301"

  tg_name      = "travelapp-tg"
  tg_port      = "80"
  tg_protocol  = "HTTP"
  tg_targetype = "ip"
  vpc_id       = module.network.vpc_id
}

module "ecs_r53" {
  source = "./terraform/modules/r53"

  record_name            = "travelapp.davidrojas.com"
  record_type            = "A"
  alias_name             = module.ecs_alb.alb_dns
  alias_zoneid           = module.ecs_alb.alb_zone_id
  zone_id                = ""
  evaluate_target_health = false 
}

module "ecs_acm" {
  source = "./terraform/modules/acm"

  domain_name       = "travelapp.davidrojas.com"
  validation_method = "DNS"
  acm_tag_name      = "travelapp-acm"
}
