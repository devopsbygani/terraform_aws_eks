module "aws_vpc" {
    source = "git::https://github.com/devopsbygani/terraform_aws_vpc.git?ref=main"
    vpc_cidr = var.vpc_cidr
    project = var.project_name
    envirnoment = var.environment
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs =  var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    is_peering_requried = false  
}
