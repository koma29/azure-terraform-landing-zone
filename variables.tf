variable "location" {
  description = "Azure region"
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "rg-terraform-landing-zone"
}

variable "vnet_name" {
  default = "vnet-landing-zone"
}

variable "subnet_name" {
  default = "subnet-workload"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  default = ["10.0.1.0/24"]
}