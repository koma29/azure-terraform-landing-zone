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

resource "azurerm_subnet" "landing_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.landing_zone.name
  virtual_network_name = azurerm_virtual_network.landing_vnet.name
  address_prefixes     = var.subnet_prefix
}

resource "azurerm_network_security_group" "landing_nsg" {
  name                = "nsg-landing-zone"
  location            = var.location
  resource_group_name = azurerm_resource_group.landing_zone.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "landing_assoc" {
  subnet_id                 = azurerm_subnet.landing_subnet.id
  network_security_group_id = azurerm_network_security_group.landing_nsg.id
}