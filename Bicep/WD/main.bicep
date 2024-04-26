
param rgName string = 'rg-waterdrop'
param vnName string = '${rgName}Vnet'  

param virtualNetworkName string
param subnetName string
param vmName string = 'WDVM2'

@secure()
param adminUsername string

@secure()
param adminPassword string

module vm './vm.bicep' = {
  name: vmName
  params: {
    adminPassword: adminPassword
    adminUsername: adminUsername
    subnetName: subnetName
    virtualNetworkName: virtualNetworkName
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnName
}


