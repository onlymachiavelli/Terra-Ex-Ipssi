locals {
  prefix = "${var.username}-${var.environment}"
}

resource "azurerm_subnet" "this" {
  name                 = "${local.prefix}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.address_prefix]
}
