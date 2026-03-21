output "resource_group_name" {
  value = azurerm_resource_group.landing_zone.name
}

output "vnet_name" {
  value = azurerm_virtual_network.landing_vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.landing_subnet.name
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.landing_logs.name
}