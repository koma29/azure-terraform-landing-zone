resource "azurerm_resource_group" "landing_zone" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "landing_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.landing_zone.name
  address_space       = var.address_space
}