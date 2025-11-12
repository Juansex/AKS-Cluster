# 📸 Screenshots del Proyecto AKS-Cluster

Esta carpeta contiene todas las evidencias visuales del despliegue del cluster de AKS.

## 📋 Listado de Capturas Requeridas

Guarda tus capturas de pantalla en esta carpeta con los siguientes nombres:

### Requisitos Previos
- **01-versiones.png** - Captura mostrando `az --version`, `terraform --version`, `kubectl version --client`

### Autenticación Azure
- **02-azure-account.png** - Captura de `az account show` con información de la suscripción

### Terraform - Inicialización
- **03-terraform-init.png** - Captura de `terraform init` exitoso con providers instalados

### Terraform - Validación
- **04-terraform-validate.png** - Captura de `terraform validate` mostrando "Success!"

### Terraform - Plan (5 capturas del plan completo)
- **05-terraform-plan-1.png** - Primera parte del plan (data sources)
- **06-terraform-plan-2.png** - Segunda parte (configuración del cluster)
- **07-terraform-plan-3.png** - Tercera parte (node pool y network)
- **08-terraform-plan-4.png** - Cuarta parte (identity y outputs)
- **09-terraform-plan-summary.png** - Resumen final "Plan: 2 to add, 0 to change, 0 to destroy"

### Terraform - Apply
- **10-terraform-apply-creating.png** - Captura del cluster creándose (Still creating...)
- **11-terraform-apply-complete.png** - Captura de "Apply complete! Resources: 1 added, 0 changed, 0 destroyed"

### Kubernetes - Conexión y Nodos
- **12-kubectl-get-nodes.png** - Captura de `kubectl get nodes` mostrando 2 nodos Ready

### Kubernetes - Despliegue Nginx
- **13-kubectl-apply-all.png** - Captura de `kubectl get all` mostrando pods, services y deployments

### Kubernetes - LoadBalancer
- **14-kubectl-describe-service.png** - Captura de `kubectl describe service nginx-service`

### Aplicación Funcionando
- **15-nginx-browser.png** - Captura del navegador mostrando "Welcome to nginx!" en http://20.165.102.69

---

## 🔢 Total de Capturas: 15

Una vez que guardes todas las capturas en esta carpeta, ejecuta desde Windows:

```cmd
cd "C:\Users\Asus Rog Strix\Documents\8vo Semestre\Plataformas II\AKS-Cluster"
git add screenshots/
git commit -m "docs: Agregar capturas de pantalla del proyecto"
git push origin main
```

---

## ✅ Verificación

Asegúrate de que cada captura:
- ✅ Sea legible y clara
- ✅ Muestre la información relevante
- ✅ Tenga el nombre correcto
- ✅ Esté en formato PNG o JPG
