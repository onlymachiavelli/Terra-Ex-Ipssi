resource "azurerm_resource_group" "this" {
  name     = "${var.username}-${var.environment}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.username}-${var.environment}-vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = [var.vnet_cidr]
}

module "subnets" {
  source = "../../infra/modules/subnets"

  username              = var.username
  environment           = var.environment
  resource_group_name   = azurerm_resource_group.this.name
  virtual_network_name  = azurerm_virtual_network.this.name
  address_prefix        = var.subnet_cidr
}

module "security_group" {
  source = "../../infra/modules/security_group"

  username           = var.username
  environment        = var.environment
  resource_group_name = azurerm_resource_group.this.name
  location           = azurerm_resource_group.this.location
  subnet_id          = module.subnets.subnet_id
  ssh_allowed_cidr   = var.ssh_allowed_cidr
  http_allowed_cidr  = var.http_allowed_cidr
}

module "compute" {
  source = "../../infra/modules/compute"

  username             = var.username
  environment          = var.environment
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  subnet_id            = module.subnets.subnet_id
  vm_size              = var.vm_size
  public_key           = var.public_key
  has_public_ip        = var.has_public_ip

  depends_on = [module.security_group]
}
