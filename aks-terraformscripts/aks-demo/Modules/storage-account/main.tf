data "azurerm_resource_group" "aks-dev-rg" {
    name = var.resource_group_name
}

########################
# Create Storage Account
########################
resource "azurerm_storage_account" "aksdevbucket" {
    name = "${var.resource_prefix}bucket"
    resource_group_name = data.azurerm_resource_group.aks-dev-rg.name
    location = var.location
    account_tier = "Standard"
    account_replication_type = "GRS"
    tags = var.tags
}

