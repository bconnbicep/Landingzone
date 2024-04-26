// This script makes multiple VM's within 1 VNET/subnet

@description('The name of the Virtual Machine')
param vmName string 

@description('The name of location to deploy the resources')
param location string 

@description('The username')
@secure()
param adminUsername string 

@description('The password for the user')
@secure()
param adminPassword string 

param Subnet1Name string 

param Subnet2Name string 

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-06-01' = {
    name: '${vmName}Vnet'
    location: location
    properties: {
        addressSpace: {
            addressPrefixes: ['10.0.0.0/16']
        }
    }
}
resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2023-09-01' = {
    parent: virtualNetwork
    name: Subnet1Name
    properties: {
        addressPrefix: '10.0.1.0/24'
    }
}

resource subnet2 'Microsoft.Network/virtualNetworks/subnets@2023-09-01' = {
    parent: virtualNetwork
    name: Subnet2Name
    properties: {
        addressPrefix: '10.0.2.0/24'
    }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-06-01' = [for i in range(0,4): {
    name: 'Nic-${i}'
    location: location
    properties: {
        ipConfigurations: [{
            name: 'ipconfig1'
            properties: {
                privateIPAllocationMethod: 'Dynamic'
                subnet: {
                    id: subnet1.id
                }
            }
        }]
    }
  }]
  
  resource virtualMachine 'Microsoft.Compute/virtualMachines@2020-06-01' = [for i in range(0,4): {
    name: 'VM-${i}'
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
                id: networkInterface[i].id
            }]
        }
    }
  }]
