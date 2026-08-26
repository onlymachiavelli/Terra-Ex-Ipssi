locals {
  prefix = "${var.username}-${var.environment}"

  # Network ACLs are stateless (unlike security groups): allowing inbound
  # traffic does NOT automatically allow the matching outbound reply, so
  # both directions - including the ephemeral return-traffic range - must
  # be declared explicitly. This is the defense-in-depth layer on top of
  # the security group's stateful rules.
  nacl_ingress_rules = {
    ssh = {
      rule_number = 100
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.ssh_allowed_cidr
      from_port   = 22
      to_port     = 22
    }
    http = {
      rule_number = 110
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.http_allowed_cidr
      from_port   = 80
      to_port     = 80
    }
    ephemeral_return = {
      rule_number = 120
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 65535
    }
  }

  nacl_egress_rules = {
    http = {
      rule_number = 100
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
    }
    https = {
      rule_number = 110
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
    }
    ephemeral_return = {
      rule_number = 120
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 65535
    }
  }
}

resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${local.prefix}-subnet"
  }
}

resource "aws_network_acl" "this" {
  vpc_id     = var.vpc_id
  subnet_ids = [aws_subnet.this.id]

  tags = {
    Name = "${local.prefix}-nacl"
  }
}

resource "aws_network_acl_rule" "ingress" {
  for_each = local.nacl_ingress_rules

  network_acl_id = aws_network_acl.this.id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "egress" {
  for_each = local.nacl_egress_rules

  network_acl_id = aws_network_acl.this.id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}
