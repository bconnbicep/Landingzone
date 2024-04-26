

param vmName string = 'wdVM'
param location string = 'westeurope'

@secure()
param adminUsername string

@secure()
param adminPassword string

resource nsgResourcesSubnet 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: 'nsg-spoke-resources'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowAllInBound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
        }
      }
      {
        name: 'AcceptAllOutbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          direction: 'Outbound'
          priority: 1001
        }
      }
    ]
  }
}

resource vnetHub 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'vnet-${location}-hub-WaterDrop'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/22'
      ]
    }
    subnets: [
      {
        name: 'WaterSubnet'
        properties: {
          addressPrefix: '10.0.1.0/26'
        }
      }
      {
        name: 'DropSubnet'
        properties: {
          addressPrefix: '10.0.2.0/27'
        }
      }
      {
        name: 'FireSubnet'
        properties: {
          addressPrefix: '10.0.3.0/26'
        }
      }
    ]
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-09-01' = {
  parent: vnetHub
  name: 'sb1'
  properties: {
      addressPrefix: '10.0.0.0/24'
      networkSecurityGroup: {
        id: nsgResourcesSubnet.id
      }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: '${vmName}Nic'
  location: location
  properties: {
    networkSecurityGroup: {
      id: nsgResourcesSubnet.id
    }
      ipConfigurations: [{
          name: 'ipconfig1'
          properties: {
              privateIPAllocationMethod: 'Dynamic'
              subnet: {
                  id: subnet.id
              }
              publicIPAddress: {
                id: pipVnet.id
              }
          }
      }]
  }
}

resource pipVnet 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: 'pip-vnet-${location}'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
  }
}
resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  location: location
  properties: {
      hardwareProfile: {
          vmSize: 'Standard_DS1_v2'
      }
      osProfile: {
          computerName: vmName
          adminUsername: adminUsername
          adminPassword: adminPassword
      }
      storageProfile: {
          imageReference: {
              publisher: 'MicrosoftWindowsDesktop'
              offer: 'Windows-10'
              sku: 'win10-22h2-pro-g2'
              version: 'latest'
          }
          osDisk: {
              createOption: 'FromImage'
          }
      }
      networkProfile: {
          networkInterfaces: [{
              id: networkInterface.id
          }]
      }
  }
}
