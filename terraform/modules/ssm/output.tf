output "ssm_param_arns" {
  value = { for key, value in var.var.ssm_parameters : key => aws_ssm_parameter.main[key].arn }
}

output "ssm:db_host" {
  value = aws_ssm_parameter.main["DB_HOST"].arn
}