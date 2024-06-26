
@description('The Azure regions into which the resources should be deployed.')
param locations array = [
  'westeurope'
  'eastus2'
]

@secure()
@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorLoginPassword string

module databases './condition.bicep' = [for location in locations: {
  name: 'database-${location}'
  params: {
    environmentName: 'Production'
    location: location
    sqlServerAdministratorLogin: sqlServerAdministratorLogin
    sqlServerAdministratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}]
