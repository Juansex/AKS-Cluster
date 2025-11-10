# AKS-Cluster
# 🚀 Despliegue de Cluster AKS con Terraform y Nginx

## 📋 Descripción del Proyecto

Este proyecto implementa la creación de un **cluster de Azure Kubernetes Service (AKS)** utilizando **Terraform** como herramienta de Infrastructure as Code (IaC). Una vez creado el cluster, se despliega una aplicación **Nginx** con múltiples réplicas y se expone mediante un servicio LoadBalancer.

## 🎯 Objetivos

1. Automatizar la creación de infraestructura en Azure usando Terraform
2. Desplegar un cluster de Kubernetes gestionado (AKS)
3. Desplegar una aplicación web (Nginx) en el cluster
4. Exponer la aplicación al público mediante un LoadBalancer
5. Documentar todo el proceso con evidencias

## 📁 Estructura del Proyecto

```
AKS-Cluster/
├── main.tf                    # Recursos principales de Azure (AKS, Resource Group)
├── providers.tf               # Configuración de providers (Azure, Kubernetes)
├── variables.tf               # Variables de configuración
├── nginx-deployment.yaml      # Manifiesto de Kubernetes para Nginx
├── LICENSE.txt               # Licencia del proyecto
└── README.md                 # Documentación (este archivo)
```

## 📝 Descripción de los Archivos

### `main.tf`
Contiene la definición de los recursos principales:
- **Resource Group**: Grupo de recursos de Azure donde se creará el cluster
- **AKS Cluster**: Configuración del cluster de Kubernetes
- **Data Source**: Para obtener las credenciales del cluster
- **Outputs**: Información del cluster (nombre, grupo de recursos, credenciales)

### `providers.tf`
Define los providers necesarios:
- **Azure Provider (azurerm)**: Para crear recursos en Azure
- **Kubernetes Provider**: Para desplegar aplicaciones en el cluster
- Incluye la configuración de autenticación para Kubernetes

### `variables.tf`
Variables configurables del proyecto:
- `aks_cluster_name`: Nombre del cluster (default: "myakscluster")
- `resource_group_name`: Nombre del grupo de recursos (default: "myResourceGroup")
- `location`: Región de Azure (default: "East US")
- `node_count`: Número de nodos (default: 2)
- `node_vm_size`: Tamaño de las VMs (default: "standard_a2_v2")

### `nginx-deployment.yaml`
Manifiesto de Kubernetes que define:
- **Deployment**: 3 réplicas de Nginx
- **Service**: LoadBalancer en el puerto 80

## 🛠️ Requisitos Previos

- [ ] Cuenta de Azure activa
- [ ] Azure CLI instalado
- [ ] Terraform instalado (versión >= 1.0)
- [ ] kubectl instalado
- [ ] Autenticación configurada en Azure

## 📸 Evidencia: Requisitos Previos
```
# Insertar captura de pantalla mostrando las versiones:
az --version
terraform --version
kubectl version --client
```
*[Aquí insertar captura de pantalla de las versiones instaladas]*

---

## 🚀 Proceso de Despliegue

### Paso 1: Autenticación en Azure

```bash
# Iniciar sesión en Azure
az login

# Verificar la suscripción activa
az account show

# (Opcional) Cambiar de suscripción si es necesario
az account set --subscription "SUBSCRIPTION_ID"
```

## 📸 Evidencia: Autenticación Azure
*[Aquí insertar captura de pantalla del `az account show`]*

---

### Paso 2: Inicializar Terraform

```bash
# Inicializar el proyecto de Terraform
terraform init
```

Este comando:
- Descarga los providers necesarios (azurerm, kubernetes)
- Prepara el directorio de trabajo
- Crea el directorio `.terraform/`

## 📸 Evidencia: Terraform Init
*[Aquí insertar captura de pantalla del `terraform init` exitoso]*

---

### Paso 3: Validar la Configuración

```bash
# Validar la sintaxis de los archivos .tf
terraform validate
```

## 📸 Evidencia: Terraform Validate
*[Aquí insertar captura de pantalla mostrando "Success! The configuration is valid."]*

---

### Paso 4: Planificar el Despliegue

```bash
# Ver el plan de ejecución
terraform plan
```

Este comando muestra:
- Recursos que se van a crear
- Configuración de cada recurso
- Estimación de cambios

## 📸 Evidencia: Terraform Plan
*[Aquí insertar captura de pantalla del plan mostrando los recursos a crear]*

---

### Paso 5: Aplicar la Configuración

```bash
# Crear los recursos en Azure
terraform apply
```

Terraform preguntará confirmación. Escribir `yes` para continuar.

**Tiempo estimado**: 5-10 minutos

## 📸 Evidencia: Terraform Apply
*[Aquí insertar captura de pantalla del `terraform apply` completado exitosamente]*

---

### Paso 6: Configurar kubectl

```bash
# Obtener las credenciales del cluster
az aks get-credentials --resource-group myResourceGroup --name myakscluster

# Verificar la conexión al cluster
kubectl get nodes
```

## 📸 Evidencia: Conexión al Cluster
*[Aquí insertar captura de pantalla mostrando los nodos del cluster activos]*

---

### Paso 7: Desplegar Nginx

```bash
# Aplicar el manifiesto de Kubernetes
kubectl apply -f nginx-deployment.yaml

# Verificar el deployment
kubectl get deployments

# Verificar los pods
kubectl get pods

# Verificar el servicio
kubectl get services
```

## 📸 Evidencia: Despliegue de Nginx
*[Aquí insertar captura de pantalla mostrando deployments, pods y services]*

---

### Paso 8: Obtener la IP Externa

```bash
# Esperar a que se asigne la IP externa (puede tomar unos minutos)
kubectl get services --watch

# Una vez asignada, copiar la EXTERNAL-IP del nginx-service
```

## 📸 Evidencia: IP Externa Asignada
*[Aquí insertar captura de pantalla mostrando el servicio con EXTERNAL-IP]*

---

### Paso 9: Verificar la Aplicación

```bash
# Acceder a la aplicación usando la IP externa
curl http://<EXTERNAL-IP>

# O abrir en el navegador
```

## 📸 Evidencia: Aplicación Funcionando
*[Aquí insertar captura de pantalla del navegador mostrando la página de bienvenida de Nginx]*

---

## 🔍 Verificaciones Adicionales

### Ver detalles del cluster en Azure Portal
1. Ir a Azure Portal
2. Buscar el Resource Group creado
3. Ver el cluster AKS y sus componentes

## 📸 Evidencia: Azure Portal
*[Aquí insertar capturas de pantalla del Resource Group y el cluster AKS en Azure Portal]*

---

### Explorar los recursos de Kubernetes

```bash
# Ver todos los recursos
kubectl get all

# Ver detalles del deployment
kubectl describe deployment nginx-deployment

# Ver logs de un pod
kubectl logs <nombre-del-pod>

# Ver información detallada del servicio
kubectl describe service nginx-service
```

## 📸 Evidencia: Recursos de Kubernetes
*[Aquí insertar capturas de pantalla de los comandos kubectl]*

---

## 🧹 Limpieza de Recursos

Para evitar costos innecesarios, eliminar los recursos cuando termines:

```bash
# Eliminar el deployment y service de Nginx
kubectl delete -f nginx-deployment.yaml

# Destruir la infraestructura de Azure
terraform destroy
```

Terraform pedirá confirmación. Escribir `yes` para continuar.

## 📸 Evidencia: Limpieza
*[Aquí insertar captura de pantalla del `terraform destroy` completado]*

---

## ⚙️ Personalización

Para modificar la configuración, editar las variables en `variables.tf` o usar un archivo `terraform.tfvars`:

```hcl
aks_cluster_name    = "mi-cluster-personalizado"
resource_group_name = "mi-rg-personalizado"
location            = "West Europe"
node_count          = 3
node_vm_size        = "Standard_DS2_v2"
```

---

## 🐛 Solución de Problemas

### Error: Provider authentication
**Problema**: Terraform no puede autenticarse con Azure  
**Solución**: Ejecutar `az login` y verificar `az account show`

### Error: Insufficient quota
**Problema**: La suscripción no tiene cuota suficiente  
**Solución**: Solicitar aumento de cuota o usar una región/tamaño de VM diferente

### Error: IP externa en <pending>
**Problema**: El servicio no obtiene IP externa  
**Solución**: Esperar unos minutos más. Azure está aprovisionando el LoadBalancer

### Error: Connection refused al acceder a la IP
**Problema**: El servicio aún no está listo  
**Solución**: Verificar que los pods estén en estado Running con `kubectl get pods`

---

## 📚 Recursos Adicionales

- [Documentación de Azure AKS](https://learn.microsoft.com/en-us/azure/aks/)
- [Documentación de Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Documentación de Kubernetes](https://kubernetes.io/docs/home/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

---

## 👤 Autor

**Tu Nombre**  
Proyecto de Infraestructura como Código  
Fecha: Noviembre 2025

---

## 📄 Licencia

Este proyecto está bajo la licencia especificada en el archivo `LICENSE.txt`.

---

## ✅ Checklist de Entrega

- [ ] Código fuente completo subido al repositorio
- [ ] README con toda la documentación
- [ ] Capturas de pantalla de cada paso insertadas
- [ ] Evidencia de terraform init, plan, apply
- [ ] Evidencia del cluster en Azure Portal
- [ ] Evidencia de kubectl mostrando recursos
- [ ] Evidencia de Nginx funcionando (navegador)
- [ ] Evidencia de terraform destroy (limpieza)

---

## 🎓 Notas de Aprendizaje

### Conceptos Clave
- **IaC (Infrastructure as Code)**: Gestión de infraestructura mediante código
- **AKS**: Servicio de Kubernetes gestionado por Azure
- **Terraform**: Herramienta de IaC multi-cloud
- **LoadBalancer**: Servicio que distribuye tráfico y proporciona IP pública
- **Deployment**: Objeto de Kubernetes que gestiona réplicas de pods
- **Service**: Abstracción que expone aplicaciones en Kubernetes

### Buenas Prácticas Implementadas
1. Uso de variables para configuración reutilizable
2. Separación de concerns (archivos diferentes para providers, variables, recursos)
3. Outputs para información útil del cluster
4. Tags para organización de recursos
5. Network plugin Azure para mejor integración
6. SystemAssigned identity para seguridad

---

**¡Proyecto completado! 🎉**
