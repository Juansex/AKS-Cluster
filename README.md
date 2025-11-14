# AKS-Cluster
#  Despliegue de Cluster AKS con Terraform y Nginx

##  Descripción del Proyecto

Este proyecto implementa la creación de un **cluster de Azure Kubernetes Service (AKS)** utilizando **Terraform** como herramienta de Infrastructure as Code (IaC). Una vez creado el cluster, se despliega una aplicación **Nginx** con múltiples réplicas y se expone mediante un servicio LoadBalancer para acceso público.

##  Objetivos

1. Automatizar la creación de infraestructura en Azure usando Terraform
2. Desplegar un cluster de Kubernetes gestionado (AKS) con 2 nodos
3. Desplegar una aplicación web (Nginx) con 3 réplicas en el cluster
4. Exponer la aplicación al público mediante un LoadBalancer
5. Documentar todo el proceso con evidencias de cada paso

##  Estructura del Proyecto

```
AKS-Cluster/
├── main.tf                    # Recursos principales de Azure (AKS, Resource Group)
├── providers.tf               # Configuración de providers (Azure, Kubernetes)
├── variables.tf               # Variables de configuración
├── nginx-deployment.yaml      # Manifiesto de Kubernetes para Nginx
├── LICENSE.txt               # Licencia del proyecto
└── README.md                 # Documentación (este archivo)
```

##  Descripción de los Archivos

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

##  Requisitos Previos

- [ ] Cuenta de Azure activa
- [ ] Azure CLI instalado
- [ ] Terraform instalado (versión >= 1.0)
- [ ] kubectl instalado
- [ ] Autenticación configurada en Azure

##  Evidencia 1: Verificación de Requisitos Previos

Se verificaron las versiones de las herramientas necesarias para el proyecto:

<img width="1223" height="773" alt="AKS_pic_1" src="https://github.com/user-attachments/assets/69c9307f-8895-43e7-a17b-0e6c126a6d56" />


**Herramientas verificadas:**
- Azure CLI: 2.77.0
- Terraform: v1.13.5
- kubectl: v1.29.1

**Suscripción de Azure:**
- Nombre: Azure for Students
- Universidad: Universidad Icesi
- Usuario: 1006172314@u.icesi.edu.co

---

##  Proceso de Despliegue

### Paso 1: Autenticación en Azure

```bash
# Iniciar sesión en Azure
az login

# Verificar la suscripción activa
az account show

# (Opcional) Cambiar de suscripción si es necesario
az account set --subscription "SUBSCRIPTION_ID"
```

##  Evidencia 2: Autenticación en Azure

Autenticación exitosa con Azure CLI:

<img width="1115" height="457" alt="AKS_pic_2" src="https://github.com/user-attachments/assets/e4f6a715-757a-408a-b744-edd5edab8ee8" />


**Detalles de la suscripción:**
- Environment: AzureCloud
- Subscription ID: f34cf60c-25dc-4f10-96d4-489b7a79abd5
- Tenant: Universidad Icesi (icesi.edu.co)

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

##  Evidencia 3: Terraform Init

Inicialización exitosa de Terraform con descarga de providers:

<img width="1507" height="752" alt="AKS_pic_3" src="https://github.com/user-attachments/assets/98af3bec-19c5-4f3a-9e88-41c38607c243" />


**Providers instalados:**
- hashicorp/azurerm v3.117.1
- hashicorp/kubernetes v2.38.0

Se creó el archivo `.terraform.lock.hcl` para garantizar consistencia en futuras ejecuciones.

---

### Paso 3: Validar la Configuración

```bash
# Validar la sintaxis de los archivos .tf
terraform validate
```

##  Evidencia 4: Terraform Validate

Validación exitosa de la sintaxis y configuración:

<img width="1217" height="106" alt="AKS_pic_4" src="https://github.com/user-attachments/assets/8adb4c96-d7ed-4ea5-9dd7-c87ad0bbe660" />


**Resultado:** Success! The configuration is valid.

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

##  Evidencia 5-9: Terraform Plan

Plan de ejecución detallado mostrando todos los recursos a crear:

<img width="1917" height="1012" alt="AKS_pic_5 1" src="https://github.com/user-attachments/assets/57f9cf29-eaba-4a90-a04f-6fad90591ce4" />

<img width="1918" height="1016" alt="AKS_pic_5 2" src="https://github.com/user-attachments/assets/6f98aa55-e6f1-42ba-8be3-3611206331ca" />

<img width="1913" height="1012" alt="AKS_pic_5 3" src="https://github.com/user-attachments/assets/131ccb1b-c90b-407f-b39d-80ac3474b42a" />

<img width="1916" height="1005" alt="AKS_pic_5 4" src="https://github.com/user-attachments/assets/a8438561-e49b-491a-8d90-a7e31c330173" />

<img width="1918" height="832" alt="AKS_pic_5 5" src="https://github.com/user-attachments/assets/1c84ef3d-602f-4097-9162-7a6c570e81f8" />


**Recursos planificados:**
- 1 Resource Group (myResourceGroup)
- 1 AKS Cluster (myakscluster)
  - Región: South Central US
  - Tamaño de VM: standard_b2ps_v2
  - Número de nodos: 2
  - Network plugin: Azure CNI
  - Load Balancer: Standard
- 2 Data sources para credenciales de Kubernetes

**Plan:** 2 to add, 0 to change, 0 to destroy

---

### Paso 5: Aplicar la Configuración

```bash
# Crear los recursos en Azure
terraform apply
```

Terraform preguntará confirmación. Escribir `yes` para continuar.

**Tiempo estimado**: 5-10 minutos

## 📸 Evidencia 10-11: Terraform Apply

Creación exitosa de la infraestructura en Azure:

<img width="1918" height="1000" alt="AKS_pic_6 1" src="https://github.com/user-attachments/assets/6b194ef0-3cf5-4083-ae71-7dbd743fea8f" />

<img width="1912" height="1022" alt="AKS_pic_6 2" src="https://github.com/user-attachments/assets/b0e448fc-5f64-4fa8-8c8c-2c9115fa1e18" />

**Resultado:**
-  Resource Group creado en 13 segundos
-  AKS Cluster creado en 4 minutos y 17 segundos
-  Data sources leídos correctamente

**Apply complete! Resources: 1 added, 0 changed, 0 destroyed.**

**Outputs generados:**
- cluster_name = "myakscluster"
- resource_group_name = "myResourceGroup"
- client_certificate = (sensitive)
- cluster_ca_certificate = (sensitive)
- host = (sensitive)
- kube_config = (sensitive)

---

### Paso 6: Configurar kubectl

```bash
# Obtener las credenciales del cluster
az aks get-credentials --resource-group myResourceGroup --name myakscluster

# Verificar la conexión al cluster
kubectl get nodes
```

##  Evidencia 12: Conexión al Cluster

Obtención de credenciales y verificación de nodos:

<img width="1916" height="1013" alt="AKS_pic_6 3" src="https://github.com/user-attachments/assets/67cfdf4f-a8b8-481b-93f0-46e9ca9031cc" />


**Nodos del cluster:**
- aks-default-34679462-vmss000000: Ready, 96m de antigüedad, versión v1.32.9
- aks-default-34679462-vmss000001: Ready, 96m de antigüedad, versión v1.32.9

Las credenciales se guardaron en: `C:\Users\Asus Rog Strix\.kube\config`

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

##  Evidencia 13: Despliegue de Nginx

Aplicación del manifiesto de Kubernetes:

<img width="1505" height="755" alt="AKS_pic_7" src="https://github.com/user-attachments/assets/8c71bc03-d411-4268-a9b4-d9ea06e5d171" />



**Recursos creados:**
- Deployment: nginx-deployment (3/3 réplicas disponibles)
- Service: nginx-service (tipo LoadBalancer)

**Pods en ejecución:**
- nginx-deployment-96b9d695-cnn5d: Running (22h)
- nginx-deployment-96b9d695-dzctx: Running (22h)
- nginx-deployment-96b9d695-f8msl: Running (22h)

**Service:**
- Tipo: LoadBalancer
- Cluster-IP: 10.0.163.3
- External-IP: 20.165.102.69
- Puerto: 80:30093/TCP

---

### Paso 8: Verificar Recursos de Kubernetes

```bash
# Esperar a que se asigne la IP externa (puede tomar unos minutos)
kubectl get services --watch

# Una vez asignada, copiar la EXTERNAL-IP del nginx-service
```

##  Evidencia 14: Detalles del Servicio

Información detallada del LoadBalancer:

<img width="1078" height="370" alt="AKS_pic_9" src="https://github.com/user-attachments/assets/89df27c6-611e-4a06-849d-66d342e5690e" />


**Detalles del Service nginx-service:**
- Name: nginx-service
- Namespace: default
- Selector: app=nginx
- Type: LoadBalancer
- IP Families: IPv4
- Cluster IP: 10.0.163.3
- LoadBalancer Ingress: **20.165.102.69**
- Port: 80/TCP
- TargetPort: 80/TCP
- NodePort: 30093/TCP
- Endpoints: 3 pods (10.224.0.13:80, 10.224.0.14:80, 10.224.0.38:80)
- External Traffic Policy: Cluster

---

### Paso 9: Verificar la Aplicación

```bash
# Acceder a la aplicación usando la IP externa
curl http://<EXTERNAL-IP>

# O abrir en el navegador
```

##  Evidencia 15: Aplicación Funcionando

Nginx accesible desde el navegador a través de la IP pública:

<img width="1907" height="377" alt="AKS_pic_10" src="https://github.com/user-attachments/assets/45067892-01b6-4844-bb32-e0638e71aa04" />



**URL de acceso:** http://20.165.102.69

La página muestra el mensaje:
> **"Welcome to nginx!"**
> 
> If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

 **La aplicación está funcionando correctamente y es accesible desde Internet.**

---

##  Verificaciones Adicionales

### Ver detalles del cluster en Azure Portal

**Para acceder al Azure Portal:**
1. Ir a https://portal.azure.com
2. Buscar "Resource Groups" o "Grupos de recursos"
3. Seleccionar `myResourceGroup`
4. Ver el cluster AKS `myakscluster` y sus componentes

**Recursos creados en Azure:**
- Resource Group: myResourceGroup (South Central US)
- AKS Cluster: myakscluster
- Virtual Network
- Load Balancer
- Network Security Groups
- Discos administrados para los nodos

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

**Comandos adicionales ejecutados:**

```bash
# Ver todos los recursos
kubectl get all

# Ver información del cluster
kubectl cluster-info

# Ver logs de un pod
kubectl logs nginx-deployment-96b9d695-cnn5d

# Ver detalles del deployment
kubectl describe deployment nginx-deployment
```

**Estado del deployment:**
- Desired: 3 réplicas
- Current: 3 réplicas
- Up-to-date: 3 réplicas
- Available: 3 réplicas
- ReplicaSet: nginx-deployment-96b9d695

---

##  Limpieza de Recursos

Para evitar costos innecesarios, eliminar los recursos cuando termines:

```bash
# Eliminar el deployment y service de Nginx
kubectl delete -f nginx-deployment.yaml

# Destruir la infraestructura de Azure
terraform destroy
```

Terraform pedirá confirmación. Escribir `yes` para continuar.

**Comandos para limpiar:**
```bash
# 1. Eliminar recursos de Kubernetes
kubectl delete -f nginx-deployment.yaml

# 2. Destruir infraestructura de Azure
terraform destroy
```

 **IMPORTANTE:** Recuerda eliminar los recursos cuando termines para evitar costos innecesarios en tu suscripción de Azure.

---

##  Configuración Final del Proyecto

**Configuración utilizada en este proyecto:**

```hcl
# variables.tf
aks_cluster_name    = "myakscluster"
resource_group_name = "myResourceGroup"
location            = "South Central US"  # Región permitida en la suscripción
node_count          = 2
node_vm_size        = "standard_b2ps_v2"  # Tamaño de VM permitido
```

**Notas importantes:**
- La región se cambió a **South Central US** debido a políticas de restricción de la suscripción
- El tamaño de VM **standard_b2ps_v2** se seleccionó por ser uno de los tamaños permitidos en la región
- Se utilizó Azure CNI como network plugin para mejor integración con Azure

---

##  Solución de Problemas

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

##  Resultados Obtenidos

 **Cluster AKS desplegado exitosamente** con 2 nodos en South Central US
 **Nginx corriendo** con 3 réplicas en alta disponibilidad
 **LoadBalancer configurado** con IP pública 20.165.102.69
 **Aplicación accesible** desde Internet
 **Infraestructura como código** completamente funcional y reutilizable

**Tiempo total de despliegue:** ~5-7 minutos (sin contar troubleshooting inicial)

---

##  Lecciones Aprendidas

1. **Políticas de Azure:** Las suscripciones de Azure for Students tienen restricciones de región y tamaños de VM
2. **Troubleshooting:** Se resolvieron errores de región no permitida y tamaño de VM no disponible
3. **IaC con Terraform:** La importancia de variables configurables para adaptarse a diferentes entornos
4. **Kubernetes en Azure:** Integración fluida entre Azure y Kubernetes mediante AKS
5. **LoadBalancer:** Azure aprovisiona automáticamente IPs públicas para servicios de tipo LoadBalancer

---

##  Recursos Adicionales

- [Documentación de Azure AKS](https://learn.microsoft.com/en-us/azure/aks/)
- [Documentación de Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Documentación de Kubernetes](https://kubernetes.io/docs/home/)
- [Azure Kubernetes Service (AKS) Pricing](https://azure.microsoft.com/en-us/pricing/details/kubernetes-service/)

---

##  Autor

**Juan Sebastián**  
Universidad Icesi - 8vo Semestre  
Plataformas II  
Fecha: Noviembre 2025

**Repositorio:** https://github.com/Juansex/AKS-Cluster

---

## Licencia

Este proyecto está bajo la licencia especificada en el archivo `LICENSE.txt`.

---

## Notas de Aprendizaje

### Conceptos Clave
- **IaC (Infrastructure as Code)**: Gestión de infraestructura mediante código
- **AKS**: Servicio de Kubernetes gestionado por Azure
- **Terraform**: Herramienta de IaC multi-cloud
- **LoadBalancer**: Servicio que distribuye tráfico y proporciona IP pública
- **Deployment**: Objeto de Kubernetes que gestiona réplicas de pods
- **Service**: Abstracción que expone aplicaciones en Kubernetes

---
