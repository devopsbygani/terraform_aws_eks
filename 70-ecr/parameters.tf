resource "aws_ssm_parameter" "backend_arn" {
  name  = "/${var.project_name}/${var.environment}/backend_arn"
  type  = "String"
  value = aws_ecr_repository.backend.arn
}

resource "aws_ssm_parameter" "frontend_arn" {
  name  = "/${var.project_name}/${var.environment}/frontend_arn"
  type  = "String"
  value = aws_ecr_repository.frontend.arn
}

