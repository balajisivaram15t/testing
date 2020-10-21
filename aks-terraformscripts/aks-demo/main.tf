provider "azurerm" {
    skip_provider_registration = true
    features {}
}
data "azurerm_resource_group" "aks-dev-rg" {
    name = var.vnet_resource_group_name
}

module "cli-storage" {
  source = "./Modules/storage-account"

  resource_prefix = "${var.resource_prefix}bucket"
  resource_group_name = data.azurerm_resource_group.aks-dev-rg.name
  location = var.location
  
}
module "main-vnet" {
    source = "./Modules/vnet"
    resource_group_name = data.azurerm_resource_group.aks-dev-rg.name
    location = var.location
    vnet_name = var.vnet_name
    address_space = ["10.0.0.0/18"]
    subnets = [
        {
            name : "AzureSubnet"
            address_prefixes : ["10.0.0.0/24"]
        }
    ]
    
}
resource "azurerm_kubernetes_cluster" "akscliuster" {
    name = "aks-dev-cluster"
    location = var.location
    kubernetes_version = "1.17.11"
    resource_group_name = data.azurerm_resource_group.aks-dev-rg.name
    dns_prefix = "aks-dev-cluster"

    default_node_pool {
        name = "default"
        node_count = var.nodepool_nodes_count
        vm_size = var.nodepool_vm_size
        vnet_subnet_id = module.main-vnet.subnet_ids["AzureSubnet"]
    }

    identity {
        type = "SystemAssigned"
    }

    network_profile {
        docker_bridge_cidr = var.network_docker_bridge_cidr
        dns_service_ip = var.network_dns_service_ip
        network_plugin     = "azure"
        outbound_type      = "loadBalancer"
        service_cidr = var.network_service_cidr
    }
}

resource "azurerm_role_assignment" "vmcontributor" {
    role_definition_name = "Virtual Machine Contributor"
    scope = data.azurerm_resource_group.aks-dev-rg.id
    principal_id = azurerm_kubernetes_cluster.akscliuster.identity[0].principal_id
    skip_service_principal_aad_check = true
}

resource "azurerm_container_registry" "acr" {
  name                     = var.name
  location                 = var.location
  resource_group_name      = data.azurerm_resource_group.aks-dev-rg.name
  admin_enabled            = var.admin
  sku                      = var.sku
  tags = {
    "env" = "Dev"
  }
}



