targetScope='subscription'

param resourceGroup1Name string = 'rg-test-1'
param resourceGroup2Name string = 'rg-test-2'
param resourceGroupLocation string = 'westeurope'

@description('The name of the Virtual Machine')
param vmName string = 'VM1'

@description('The name of location to deploy the resources')
param location string = 'westeurope'

@description('The username')
@secure()
param adminUsername string = 'Waterdropadmin'

@description('The password for the user')
@secure()
param adminPassword string = 'W@t3rDr0p12345'

@description('The name of the first subnet.')
param Subnet1Name string = 'Subnet1'

@description('The name of the second subnet.')
param Subnet2Name string = 'Subnet2'

@description('The name of the first blobstorage')
param Storage1Name string = 'storage${uniqueString(location,subscription().id)}'

var randomString = uniqueString(location)

resource newRG1 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${resourceGroup1Name}-${randomString}' 
  location: resourceGroupLocation
}

resource newRG2 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${resourceGroup2Name}-${randomString}' 
  location: resourceGroupLocation
}

module vnetvm 'Vnetvm.bicep' = {
  scope: newRG1
  name: 'WDVnet'
  params:{
    vmName: vmName
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
    Subnet1Name: Subnet1Name
    Subnet2Name: Subnet2Name
  }
}

module storage 'storage.bicep' = {
  scope: newRG2
  name: Storage1Name
  params: {
    location: location
    Storage1Name: Storage1Name
  }
}
