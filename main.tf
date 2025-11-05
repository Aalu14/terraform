provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source    = "./modules/ec2"
  subnet_id = module.vpc.public_subnet_ids[0]
  vpc_id    = module.vpc.vpc_id
}

module "alb" {
  source  = "./modules/alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnet_ids
}
