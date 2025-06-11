module "mysql_sg" {
    source = "git::https://github.com/devopsbygani/terraform-aws-security-group.git?ref=main" # to call module from git
    #source = "../../terraform-aws-security-group" # it is local module 
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = "mysql"   
}

module "bastion_sg" {
    source = "git::https://github.com/devopsbygani/terraform-aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = "bastion"   
}

module "ingress_alb_sg" {
    source = "git::https://github.com/devopsbygani/terraform-aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = "ingress-alb"   
}

module "eks_control_plane_sg" {
    source = "git::https://github.com/devopsbygani/terraform-aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = "eks-control-plane"   
}
module "node_sg" {
    source = "git::https://github.com/devopsbygani/terraform-aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = "node"   
}


#  to allow connection between mysql to backend.
#  the port 3306 to be enabled . port 8080 for backend. and port 80 for frontend. 
#  to accept connections.
#  these are to added in inbound rules.

# resource "aws_security_group_rule" "mysql_node" {
#   type              = "ingress"
#   from_port         = 3306
#   to_port           = 3306
#   protocol          = "tcp"
#   source_security_group_id = module.node_sg.id
#   security_group_id = module.mysql_sg.id
# #   source_security_group_id = [data.aws_ssm_parameter.backend_sg_id.value]
# #   security_group_id = data.aws_ssm_parameter.mysql_sg_id.value
# }

# resource "aws_security_group_rule" "ingress_alb_https" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = module.ingress_alb_sg.id
# }

# resource "aws_security_group_rule" "node_ingress_alb" {
#   type              = "ingress"
#   from_port         = 30000
#   to_port           = 32767
#   protocol          = "tcp"
#   source_security_group_id = module.ingress_alb_sg.id
#   security_group_id = module.node_sg.id  
# }

# resource "aws_security_group_rule" "eks_control_plane_bastion" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   source_security_group_id = module.bastion_sg.id
#   security_group_id = module.eks_control_plane_sg.id  
# }

# resource "aws_security_group_rule" "node_bastion" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.bastion_sg.id
#   security_group_id = module.node_sg.id  
# }

# resource "aws_security_group_rule" "mysql_bastion" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.bastion_sg.id
#   security_group_id = module.mysql_sg.id  
# }

# resource "aws_security_group_rule" "eks_control_plane_node" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   source_security_group_id = module.node_sg.id
#   security_group_id = module.eks_control_plane_sg.id  
# }
# resource "aws_security_group_rule" "node_eks_control_plane" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   source_security_group_id = module.eks_control_plane_sg.id
#   security_group_id = module.node_sg.id  
# }

# resource "aws_security_group_rule" "node_vpc" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/16"]
#   security_group_id = module.node_sg.id
# }
# resource "aws_security_group_rule" "bastion_public" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = module.bastion_sg.id  
# }

# from siva


resource "aws_security_group_rule" "ingress_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.ingress_alb_sg.id
}

resource "aws_security_group_rule" "node_ingress_alb" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  source_security_group_id = module.ingress_alb_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "node_eks_control_plane" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.eks_control_plane_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "eks_control_plane_node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.node_sg.id
  security_group_id = module.eks_control_plane_sg.id
}

resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.eks_control_plane_sg.id
}

resource "aws_security_group_rule" "node_vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["10.0.0.0/16"]
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "node_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id       = module.bastion_sg.id
  security_group_id = module.mysql_sg.id
}


resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.id
}