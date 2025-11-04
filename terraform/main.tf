module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"
  subnet_ids = module.vpc.private_subnets
  security_group_id = module.security.db_sg_id
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.vpc.public_subnets[0]
  security_group_id = module.security.ec2_sg_id
  key_name = var.key_name
}

module "alb" {
  source = "./modules/alb"
  subnet_ids = module.vpc.public_subnets
  security_group_id = module.security.alb_sg_id
}
