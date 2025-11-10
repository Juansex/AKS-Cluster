resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${var.aks_cluster_name}-dns"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    environment = "dev"
  }
}

# Data source para obtener las credenciales de Kubernetes
data "azurerm_kubernetes_cluster" "aks" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_resource_group.aks_rg.name
  depends_on          = [azurerm_kubernetes_cluster.aks]
}

# Outputs para acceder a la información del cluster
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "cluster_username" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.username
  sensitive = true
}

output "cluster_password" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.password
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.host
  sensitive = true
}

output "resource_group_name" {
  value = azurerm_resource_group.aks_rg.name
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}