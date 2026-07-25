variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-terraform-landing-zone"
}

variable "vnet_name" {
  type    = string
  default = "vnet-landing-zone"
}

variable "subnet_name" {
  type    = string
  default = "subnet-workload"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
