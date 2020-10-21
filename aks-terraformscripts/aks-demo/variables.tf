variable "location" {
  description = "The resource group location"
  default     = "East US2"
}

variable "vnet_resource_group_name" {
  description = "The resource group name to be created"
  default     = "AZ-RG-KubernetesCICD-Dev-01"
}

variable "nodepool_nodes_count" {
  description = "Default nodepool nodes count"
  default     = 3
}

variable "nodepool_vm_size" {
  description = "Default nodepool VM size"
  default     = "Standard_D2_v2"
}

variable "network_docker_bridge_cidr" {
  description = "CNI Docker bridge cidr"
  default     = "172.17.0.1/16"
}

variable "network_dns_service_ip" {
  description = "CNI DNS service IP"
  default     = "10.2.0.10"
}

variable "network_service_cidr" {
  description = "CNI service cidr"
  default     = "10.2.0.0/24"
}

variable "vnet_name" {
    type = string
    default = "aks-dev-vnet-eastu2"
}

variable "name" {
  description = "The name of the ACR"
  type        = string
  default = "devacrrepo"
}

variable "admin" {
  description = "Admin access enabled"
  type        = bool
  default = true
}

variable "sku" {
  description = "The SKU of the ACR"
  type        = string
  default = "Standard"
}

variable "resource_prefix" {
    type = string
    default = "aksdev"
}