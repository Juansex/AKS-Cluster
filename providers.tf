terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Data source para obtener el token de autenticación
data "azurerm_kubernetes_cluster" "credentials" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_resource_group.aks_rg.name
  depends_on          = [azurerm_kubernetes_cluster.aks]
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)
}

