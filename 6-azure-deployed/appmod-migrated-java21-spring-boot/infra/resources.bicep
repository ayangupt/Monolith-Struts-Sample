@description('Name of the environment')
param environmentName string

@description('Primary location for all resources')
param location string

@description('Resource token for unique naming')
param resourceToken string

@description('PostgreSQL administrator username')
@secure()
param postgresqlAdminUsername string

@description('PostgreSQL administrator password')
@secure()
param postgresqlAdminPassword string

@description('PostgreSQL database name')
param postgresqlDatabaseName string

@description('PostgreSQL version')
param postgresqlVersion string

@description('PostgreSQL SKU name')
param postgresqlSkuName string

@description('PostgreSQL SKU tier')
param postgresqlSkuTier string

@description('PostgreSQL storage size in GB')
param postgresqlStorageSizeGB int

// Resource names using the required naming convention
var logAnalyticsName = 'azlog${resourceToken}'
var appInsightsName = 'azai${resourceToken}'
var containerRegistryName = 'azcreg${resourceToken}'
var keyVaultName = 'azkv${resourceToken}'
var managedIdentityName = 'azid${resourceToken}'
var containerAppEnvName = 'azcae${resourceToken}'
var postgresqlServerName = 'azpg${resourceToken}'
var containerAppName = 'azca-${environmentName}-${resourceToken}'

// Log Analytics Workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

// Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

// User-Assigned Managed Identity
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: location
}

// Container Registry
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: containerRegistryName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: false
    publicNetworkAccess: 'Enabled'
  }
}

// AcrPull role assignment for managed identity
resource acrPullRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(containerRegistry.id, managedIdentity.id, 'AcrPull')
  scope: containerRegistry
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d')
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

// Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

// Key Vault Secrets Officer role for managed identity
resource keyVaultSecretsOfficerRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVault.id, managedIdentity.id, 'KeyVaultSecretsOfficer')
  scope: keyVault
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b86a8fe4-44ce-4948-aee5-eccb2c155cd7')
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

// PostgreSQL Flexible Server
resource postgresqlServer 'Microsoft.DBforPostgreSQL/flexibleServers@2023-03-01-preview' = {
  name: postgresqlServerName
  location: location
  sku: {
    name: postgresqlSkuName
    tier: postgresqlSkuTier
  }
  properties: {
    version: postgresqlVersion
    administratorLogin: postgresqlAdminUsername
    administratorLoginPassword: postgresqlAdminPassword
    storage: {
      storageSizeGB: postgresqlStorageSizeGB
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    highAvailability: {
      mode: 'Disabled'
    }
  }
}

// PostgreSQL Firewall rule - Allow Azure services
resource postgresqlFirewallRule 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2023-03-01-preview' = {
  parent: postgresqlServer
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// PostgreSQL Database
resource postgresqlDatabase 'Microsoft.DBforPostgreSQL/flexibleServers/databases@2023-03-01-preview' = {
  parent: postgresqlServer
  name: postgresqlDatabaseName
  properties: {
    charset: 'UTF8'
    collation: 'en_US.utf8'
  }
}

// Store PostgreSQL connection string in Key Vault
resource postgresqlConnectionStringSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'postgresql-connection-string'
  properties: {
    value: 'jdbc:postgresql://${postgresqlServer.properties.fullyQualifiedDomainName}:5432/${postgresqlDatabaseName}?sslmode=require'
  }
  dependsOn: [
    keyVaultSecretsOfficerRole
  ]
}

// Store PostgreSQL username in Key Vault
resource postgresqlUsernameSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'postgresql-username'
  properties: {
    value: postgresqlAdminUsername
  }
  dependsOn: [
    keyVaultSecretsOfficerRole
  ]
}

// Store PostgreSQL password in Key Vault
resource postgresqlPasswordSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'postgresql-password'
  properties: {
    value: postgresqlAdminPassword
  }
  dependsOn: [
    keyVaultSecretsOfficerRole
  ]
}

// Container Apps Environment
resource containerAppEnv 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: containerAppEnvName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalytics.properties.customerId
        sharedKey: logAnalytics.listKeys().primarySharedKey
      }
    }
  }
}

// Container App
resource containerApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: containerAppName
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}
    }
  }
  properties: {
    managedEnvironmentId: containerAppEnv.id
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
        external: true
        targetPort: 8080
        transport: 'auto'
        corsPolicy: {
          allowedOrigins: ['*']
          allowedMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS']
          allowedHeaders: ['*']
        }
      }
      registries: [
        {
          server: containerRegistry.properties.loginServer
          identity: managedIdentity.id
        }
      ]
      secrets: [
        {
          name: 'postgresql-connection-string'
          value: 'jdbc:postgresql://${postgresqlServer.properties.fullyQualifiedDomainName}:5432/${postgresqlDatabaseName}?sslmode=require'
        }
        {
          name: 'postgresql-username'
          value: postgresqlAdminUsername
        }
        {
          name: 'postgresql-password'
          value: postgresqlAdminPassword
        }
        {
          name: 'applicationinsights-connection-string'
          value: appInsights.properties.ConnectionString
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'skishop-app'
          image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
          resources: {
            cpu: json('0.5')
            memory: '1Gi'
          }
          env: [
            {
              name: 'SPRING_DATASOURCE_URL'
              secretRef: 'postgresql-connection-string'
            }
            {
              name: 'SPRING_DATASOURCE_USERNAME'
              secretRef: 'postgresql-username'
            }
            {
              name: 'DB_PASSWORD'
              secretRef: 'postgresql-password'
            }
            {
              name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
              secretRef: 'applicationinsights-connection-string'
            }
            {
              name: 'SPRING_MAIL_HOST'
              value: 'smtp.gmail.com'
            }
            {
              name: 'SPRING_MAIL_PORT'
              value: '587'
            }
          ]
          probes: [
            {
              type: 'Readiness'
              httpGet: {
                path: '/actuator/health'
                port: 8080
              }
              initialDelaySeconds: 30
              periodSeconds: 10
              failureThreshold: 3
            }
            {
              type: 'Liveness'
              httpGet: {
                path: '/actuator/health'
                port: 8080
              }
              initialDelaySeconds: 60
              periodSeconds: 30
              failureThreshold: 3
            }
          ]
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 3
        rules: [
          {
            name: 'http-rule'
            http: {
              metadata: {
                concurrentRequests: '100'
              }
            }
          }
        ]
      }
    }
  }
  tags: {
    'azd-service-name': 'skishop-app'
  }
  dependsOn: [
    acrPullRoleAssignment
    postgresqlConnectionStringSecret
    postgresqlUsernameSecret
    postgresqlPasswordSecret
  ]
}

// Outputs
output AZURE_CONTAINER_REGISTRY_ENDPOINT string = containerRegistry.properties.loginServer
output AZURE_CONTAINER_APP_ID string = containerApp.id
output AZURE_POSTGRESQL_ID string = postgresqlDatabase.id
output AZURE_IDENTITY_NAME string = managedIdentity.name
output AZURE_KEY_VAULT_NAME string = keyVault.name
output AZURE_CONTAINER_APP_ENDPOINT string = 'https://${containerApp.properties.configuration.ingress.fqdn}'
output AZURE_LOG_ANALYTICS_WORKSPACE_ID string = logAnalytics.id
output AZURE_APPLICATION_INSIGHTS_CONNECTION_STRING string = appInsights.properties.ConnectionString
