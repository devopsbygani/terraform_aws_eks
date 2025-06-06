variable "project_name" {
    type = string
    default = "expense"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "common_tags" {
    type = map
    default= {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}

