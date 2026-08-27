resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.username}-${var.environment}-vpc"
  }
}

module "subnets" {
  source = "../../infra/modules/subnets"

  username          = var.username
  environment       = var.environment
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  ssh_allowed_cidr  = var.ssh_allowed_cidr
  http_allowed_cidr = var.http_allowed_cidr
}

module "security_group" {
  source = "../../infra/modules/security_group"

  username          = var.username
  environment       = var.environment
  vpc_id            = aws_vpc.this.id
  ssh_allowed_cidr  = var.ssh_allowed_cidr
  http_allowed_cidr = var.http_allowed_cidr
}

module "compute" {
  source = "../../infra/modules/compute"

  username      = var.username
  environment   = var.environment
  instance_ami  = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = module.subnets.subnet_id
  sg_ids        = [module.security_group.id]
  public_key    = var.public_key
  has_public_ip = var.has_public_ip
}
