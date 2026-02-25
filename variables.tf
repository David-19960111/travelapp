#Virtual Private Cloud
variable "vpc_cidr_block" {
  description = "The VPC IPv4 CIDR block"
  type        = string
  default     = null
}

variable "vpc_tag" {
  description = "Resource tag name"
  type        = string
  default     = null
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = string
  default     = false
}

#Subnets
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDR values"
  default     = []
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDR values"
  default     = []
}

variable "azs" {
  type        = list(string)
  description = "Subnets AZ's"
  default     = []
}

variable "public_subnets_tag" {
  description = "Resource tag name"
  type        = string
  default     = null
}

#Internet Gateway
variable "create_igw" {
  type        = bool
  description = "Enables IGW resource creation."
  default     = false
}

variable "igw_tag" {
  type        = string
  description = "IGW tag name."
  default     = false
}


variable "route_table_tag" {
  type        = string
  description = "Route table tag name."
  default     = false
}

variable "create_igw_route" {
  type        = bool
  description = "Enables IGW route resource creation."
  default     = false
}

#Security Groups
variable "sg_name" {
  type        = string
  description = "Security group name"
  default     = null
}

variable "sg_ingress" {
  type        = any
  description = "Map containing SG's ingress rules"
  default     = {}
}

variable "sg_egress" {
  type        = any
  description = "Map containing SG's egress rules"
  default     = {}
}

#Load Balancer
variable "vpc_id" {
  type        = string
  description = "vpc id"
  default     = null
}

variable "alb_name" {
  type        = string
  description = "ALB name"
  default     = null
}

variable "alb_type" {
  type        = string
  description = "ALB type (application, gateway, networking)"
  default     = null
}

variable "alb_subnets" {
  type        = any
  description = "A list of subnet IDs to attach to the LB."
  default     = []
}

variable "alb_sgs" {
  type        = any
  description = "A list of security group IDs to assign to the LB."
  default     = []
}

variable "enable_https_listener" {
  type        = bool
  description = "Enables https listener"
  default     = false
}

variable "https_listener_tag" {
  type        = string
  description = "HTTPS listener tag"
  default     = null
}
variable "https_listener_port" {
  type        = number
  description = " (Optional) Port on which the load balancer is listening. Not valid for Gateway Load Balancers."
  default     = null
}

variable "https_listener_protocol" {
  type        = string
  description = "(Optional) Protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are HTTP and HTTPS, with a default of HTTP."
  default     = null
}

variable "https_ssl_policy" {
  type        = string
  description = "(Optional) Name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS."
  default     = null
}

variable "https_certificate_arn" {
  type        = string
  description = "(Optional) ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS."
  default     = null
}

variable "https_listener_action_type" {
  type        = string
  description = "(Required) Type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc."
  default     = null
}

variable "https_target_group_arn" {
  type        = string
  description = "ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead."
  default     = null
}


variable "enable_http_listener" {
  type        = bool
  description = "Enables https listener"
  default     = false
}

variable "http_listener_port" {
  type        = number
  description = "(Optional) Port on which the load balancer is listening. Not valid for Gateway Load Balancers."
  default     = null
}

variable "http_listener_protocol" {
  type        = string
  description = "(Optional) Protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are HTTP and HTTPS, with a default of HTTP."
  default     = null
}

variable "http_listener_action_type" {
  type        = string
  description = "(Required) Type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc."
  default     = null
}

variable "http_listener_tag" {
  type        = string
  description = "HTTP listener tag"
  default     = null
}

variable "redirect_port" {
  type        = number
  description = "(Optional) Port. Specify a value from 1 to 65535."
  default     = null
}

variable "redirect_protocol" {
  type        = string
  description = "(Optional) Protocol. Valid values are HTTP, HTTPS"
  default     = null
}

variable "redirect_status_code" {
  type        = string
  description = "(Required) HTTP redirect code. The redirect is either permanent (HTTP_301) or temporary (HTTP_302)."
  default     = null
}

#Target Group
variable "tg_name" {
  type        = string
  description = "Target group name"
  default     = null
}

variable "tg_port" {
  type        = number
  description = "Port on which targets receive traffic, unless overridden when registering a specific target. Required when target_type is instance, ip or alb. Does not apply when target_type is lambda."
  default     = null
}

variable "tg_protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP_UDP, TLS, or UDP."
  default     = null
}

variable "tg_targetype" {
  type        = string
  description = "Type of target which alb will redirect the requests. Can be an EC2, IP Addresses, Lambda, another ALB."
  default     = null
}


#Database variable
variable "db_name" {
  type        = string
  description = "Database name"
  default     = null
}

variable "identifier" {
  type        = string
  description = "Database identifier"
  default     = null
}

variable "engine" {
  type        = string
  description = "Engine name"
  default     = null
}

variable "engine_ver" {
  type        = string
  description = "Engine version"
  default     = null
}

variable "db_username" {
  type        = string
  description = "Database username"
  default     = null
}

variable "db_password" {
  type        = string
  description = "Database password"
  default     = null
}

variable "instance_class" {
  type        = string
  description = "Instance class"
  default     = null
}

variable "allocated_storage" {
  type        = number
  description = "The allocated storage in gibibytes"
  default     = null
}

variable "apply_immediately" {
  type        = string
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  default     = null
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  default     = true
}

variable "publicly_accessible" {
  type    = bool
  default = true
}

#Database subnets
variable "db_subnet_group_name" {
  type        = string
  description = "DB Subnet group name"
  default     = null
}

variable "subnet_ids" {
  type        = any
  description = "A list of VPC subnet IDs."
  default     = []
}

variable "vpc_security_group_ids" {
  type        = any
  description = "List of VPC SG's."
  default     = []
}

#Elastic Container Service
variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster name"
  default     = null
}

variable "service_name" {
  type        = string
  description = "ECS Service name"
  default     = null
}

variable "cluster_id" {
  type        = string
  description = "ECS Cluster id retrieved from ecs cluster module."
  default     = null
}

variable "task_definition_arn" {
  type        = string
  description = "ECS Task definition arn retrieved from ecs task def module."
  default     = null
}

variable "launch_type" {
  type        = string
  description = "FARGATE, FARGATE_SPOT, EC2"
  default     = null
}

variable "desired_count" {
  type        = number
  description = "Amount of containers you want to run"
  default     = null
}

variable "subnets_id" {
  type        = any
  description = "Subnets id's where the ecs container will live."
  default     = []
}

variable "security_groups_id" {
  type        = any
  description = "SG's id's which ecs container will utilize."
  default     = []
}

variable "target_group_arn" {
  type        = string
  description = "(Required for ALB/NLB) ARN of the Load Balancer target group to associate with the service."
  default     = null
}

variable "container_port" {
  type        = string
  description = "(Required) Port on the container to associate with the load balancer."
  default     = null
}

variable "container_name" {
  type        = string
  description = "(Required) Name of the container to associate with the load balancer (as it appears in a container definition)."
  default     = null
}

variable "task_definitions" {
  type        = any
  description = "List of string containing the task definitions to create."
  default     = {}
}

variable "task_name" {
  type        = string
  description = "Task definition name"
  default     = null
}

variable "requires_compatibilities" {
  type        = any
  description = "Fargate, Fargate Spot, EC2"
  default     = []
}

variable "network_mode" {
  type        = string
  description = "none, bridge, awsvpc, and host"
  default     = null
}

variable "container_name" {
  description = "ECS container name"
  type        = string
  default     = null
}

variable "image" {
  description = "ECS Task container image"
  type        = string
  default     = null
}

variable "image_version" {
  description = "ECS Task container image version"
  type        = string
  default     = null
}

variable "cpu" {
  type        = number
  description = "CPU to allocate"
  default     = null
}

variable "memory" {
  type        = number
  description = "Memory to allocate"
  default     = null
}

variable "container_port" {
  type        = number
  description = "Container Port, the one which will be open for connections."
  default     = 0
}

variable "host_port" {
  type        = number
  description = "Host Port"
  default     = 0
}

#ENV Variables
variable "db_hostname_value" {
  type        = any
  description = "DB Hostname value."
  default     = null
}

variable "db_username_value" {
  type        = any
  description = "DB Username value."
  default     = null
}

variable "db_password_value" {
  type        = any
  description = "DB Password value."
  default     = null
}

variable "db_name_value" {
  type        = any
  description = "DB Name value."
  default     = null
}

#Elastic Container Registry
variable "ecr_repo_name" {
  type        = string
  description = "ECR Repository name"
}

variable "mutability" {
  type        = bool
  description = "Enables/Disable mutability"
  default     = false
}

#ACM
variable "domain_name" {
  type        = string
  description = "(Required) Domain name for which the certificate should be issued"
  default     = null
}

variable "validation_method" {
  type        = string
  description = "(Optional) Which method to use for validation. DNS or EMAIL are valid. This parameter must not be set for certificates that were imported into ACM and then into Terraform."
  default     = null
}

variable "acm_tag_name" {
  type        = string
  description = "ACM Resource tag name"
}

#Route 53
variable "zone_id" {
  type = string
  description = "(Required) Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone"
  default = null
}

variable "record_name" {
  type = string
  description = "(Required) DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone"
  default = null
}

variable "record_type" {
  type = string
  description = "(Required) The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT."
  default = null
}

variable "alias_name" {
  type = string
  description = "(Required) DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone."
  default = null
}

variable "alias_zoneid" {
  type = string
  description = "(Required) Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone."
  default = null
}

variable "evaluate_target_health" {
  type = bool
  description = "Required) Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set."
  default = false
}

#SSM 
variable "ssm_parameters" {
  type        = any
  description = "List of ssm parameters"
  default     = {}
}

