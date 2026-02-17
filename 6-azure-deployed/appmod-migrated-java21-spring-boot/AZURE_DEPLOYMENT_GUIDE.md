# Quick Azure Deployment Guide

## Current Deployment Status ✅

**Branch**: `azure-deployed-production`  
**Live URL**: https://azca-skishop-prod-spznmsuc2knh6.lemonfield-5eead396.eastus2.azurecontainerapps.io/  
**Environment**: skishop-prod  
**Region**: East US 2

---

## Deploy to Your Own Azure Subscription

### Prerequisites
- Azure subscription
- Azure CLI installed (`az`)
- Azure Developer CLI installed (`azd`)
- Docker installed

### Quick Start (5 minutes)

```bash
# 1. Switch to deployment branch
git checkout azure-deployed-production

# 2. Login to Azure
az login
azd auth login

# 3. Set your subscription
az account set --subscription <your-subscription-id>

# 4. Create new environment
azd env new my-skishop-env --no-prompt

# 5. Configure environment variables
azd env set AZURE_SUBSCRIPTION_ID <your-subscription-id>
azd env set AZURE_LOCATION eastus2
azd env set AZURE_RESOURCE_GROUP rg-my-skishop-env
azd env set POSTGRESQL_ADMIN_USERNAME skishopadmin
azd env set POSTGRESQL_ADMIN_PASSWORD "YourSecurePassword123!"

# 6. Create resource group
az group create --name rg-my-skishop-env --location eastus2

# 7. Deploy everything
azd up --no-prompt
```

That's it! Your application will be deployed in approximately 5-7 minutes.

---

## What Gets Deployed

### Infrastructure (Bicep Templates)
- **Container App**: Auto-scaling web application (1-3 replicas)
- **PostgreSQL**: Managed database (Burstable B1ms tier)
- **Container Registry**: Private Docker registry
- **Key Vault**: Secure secrets storage
- **Application Insights**: Monitoring and telemetry
- **Log Analytics**: Centralized logging
- **Managed Identity**: Secure service authentication

### Cost Estimate
- **Development/Test**: ~$50-75/month
- **Production**: ~$100-200/month (with scaling)

---

## Updating Your Deployment

### Update Application Code
```bash
# Make code changes, then:
azd deploy --no-prompt
```

### Update Infrastructure
```bash
# Modify infra/*.bicep files, then:
azd up --no-prompt
```

### View Application
```bash
# Get application URL
azd env get-values | grep AZURE_CONTAINER_APP_ENDPOINT
```

---

## Monitoring & Troubleshooting

### View Logs
```bash
# Real-time logs
az containerapp logs show \
  --name $(azd env get-values | grep AZURE_CONTAINER_APP | cut -d'/' -f9) \
  --resource-group $(azd env get-values | grep AZURE_RESOURCE_GROUP | cut -d'=' -f2) \
  --follow
```

### Check Health
```bash
# Health endpoint
curl $(azd env get-values | grep AZURE_CONTAINER_APP_ENDPOINT | cut -d'"' -f2)/actuator/health
```

### Access Azure Portal
```bash
# Open resource group in portal
az group show --name $(azd env get-values | grep AZURE_RESOURCE_GROUP | cut -d'=' -f2) --query id -o tsv | \
  xargs -I {} open "https://portal.azure.com/#@/resource{}"
```

---

## Cleanup

### Delete All Resources
```bash
azd down --purge --force
```

This will delete:
- All Azure resources
- Resource group
- Environment configuration

---

## File Structure

```
.
├── azure.yaml                    # AZD service configuration
├── Dockerfile                    # Container image definition
├── infra/
│   ├── main.bicep               # Main infrastructure template
│   ├── resources.bicep          # Azure resources definitions
│   └── main.parameters.json     # Parameters file
├── .azure/
│   ├── plan.copilotmd          # Deployment plan
│   ├── summary.copilotmd       # Deployment summary
│   └── progress.copilotmd      # Progress tracker
└── README.md                    # Complete documentation
```

---

## Common Issues & Solutions

### Issue: "SKU not available in region"
**Solution**: Change region in environment:
```bash
azd env set AZURE_LOCATION centralus
```

### Issue: "Resource group already exists"
**Solution**: Use the existing group or choose a different name:
```bash
azd env set AZURE_RESOURCE_GROUP rg-different-name
```

### Issue: "Container image not found"
**Solution**: Managed identity might need time to propagate. Wait 1-2 minutes and retry.

---

## Support

For detailed documentation, see:
- [README.md](README.md) - Complete documentation
- [.azure/summary.copilotmd](.azure/summary.copilotmd) - Deployment summary
- [Azure Container Apps Docs](https://learn.microsoft.com/azure/container-apps/)

---

**Last Updated**: February 15, 2026  
**Deployment Version**: 1.0.0
