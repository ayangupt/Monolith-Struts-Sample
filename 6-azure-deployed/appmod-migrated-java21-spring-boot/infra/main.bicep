targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment used to generate a unique resource token')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

@description('Name of the resource group')
param resourceGroupName string = 'rg-${environmentName}'

@description('PostgreSQL administrator username')
@secure()
param postgresqlAdminUsername string

@description('PostgreSQL administrator password')
@secure()
param postgresqlAdminPassword string

@description('PostgreSQL database name')
param postgresqlDatabaseName string = 'skishop'

@description('PostgreSQL version')
param postgresqlVersion string = '17'

@description('PostgreSQL SKU name')
param postgresqlSkuName string = 'Standard_B1ms'

@description('PostgreSQL SKU tier')
param postgresqlSkuTier string = 'Burstable'

@description('PostgreSQL storage size in GB')
param postgresqlStorageSizeGB int = 32

// Generate unique token for resource naming
var resourceToken = uniqueString(subscription().id, location, environmentName)

// Resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: {
    'azd-env-name': environmentName
  }
}

// Deploy resources module
module resources './resources.bicep' = {
  name: 'resources-${resourceToken}'
  scope: rg
  params: {
    environmentName: environmentName
    location: location
    resourceToken: resourceToken
    postgresqlAdminUsername: postgresqlAdminUsername
    postgresqlAdminPassword: postgresqlAdminPassword
    postgresqlDatabaseName: postgresqlDatabaseName
    postgresqlVersion: postgresqlVersion
    postgresqlSkuName: postgresqlSkuName
    postgresqlSkuTier: postgresqlSkuTier
    postgresqlStorageSizeGB: postgresqlStorageSizeGB
  }
}

// Outputs required by AZD
output RESOURCE_GROUP_ID string = rg.id
output AZURE_CONTAINER_REGISTRY_ENDPOINT string = resources.outputs.AZURE_CONTAINER_REGISTRY_ENDPOINT
output AZURE_CONTAINER_APP_ID string = resources.outputs.AZURE_CONTAINER_APP_ID
output AZURE_POSTGRESQL_ID string = resources.outputs.AZURE_POSTGRESQL_ID
output AZURE_IDENTITY_NAME string = resources.outputs.AZURE_IDENTITY_NAME
output AZURE_KEY_VAULT_NAME string = resources.outputs.AZURE_KEY_VAULT_NAME
output AZURE_CONTAINER_APP_ENDPOINT string = resources.outputs.AZURE_CONTAINER_APP_ENDPOINT
