// admin: Waterdrop
// password: _dZ5V|Zx7A9&
// keyvault: KV-Waterdrop-dev

@description('The uninque name for the resource combined with the environment')
param environmentName string = 'dev${uniqueString(resourceGroup().id)}'

@description('the location based on the resourcegroup')
param location string = resourceGroup().location

@description('The several needed information about the storageaccount')
param storageAccountinfo object

@description('The noted param what is connnected to first.parameter.dev.json')
param storageAccountSku object 

@secure()
@description('The administrator login username for the SQL server')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorPassword string

@description('The name and tier of the SQL database SKU.')
param sqlDatabaseSku object

@description('The concotenated name for the storage with the environment')
var StorageAccountName = 'storage${environmentName}'

@description('The name of the sql server within the environment')
var sqlServerName = 'sqlServer-${environmentName}'

@description('The name of the sql database within the environment')
var sqlDatabaseName = 'sqlDatabase-${environmentName}'

resource Storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: StorageAccountName
  location: location
  sku: {
    name: storageAccountSku.name
  }
  kind: storageAccountinfo.kind
  properties: {
    accessTier: storageAccountinfo.accesstier
  }
 }

 resource sqlServer 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorPassword
  }
 }

 resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: sqlDatabaseSku.name
    tier: sqlDatabaseSku.tier
  }
 }
