locals {
  prefix = "${var.username}-${var.environment}"
}

resource "aws_key_pair" "this_keypair" {
  public_key = var.public_key
  key_name   = "${local.prefix}-key"
}


resource "aws_instance" "this" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.this_keypair.key_name
  vpc_security_group_ids      = var.sg_ids
  associate_public_ip_address = var.has_public_ip
}
