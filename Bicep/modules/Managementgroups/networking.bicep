
targetScope = 'tenant'

@description('Name for Parent Platform managementgroup')
param Platformname string

@description('Name for Identity managementgroup')
param Identityname string

@description('Name for Management managementgroup')
param Managementname string

@description('Name for Connectivity managementgroup')
param Connectivityname string

// level 1
resource NetworkPlatform 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: Platformname
  properties: {
    displayName: 'NetworkPlatformdisplayname'
  }
}

// Level 2
resource IdentityMG 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: Identityname
  properties: {
    displayName: 'Developementmanagementgroup'
    details: {
      parent: {
        id: NetworkPlatform.id
      }
    }
  }
}

resource ManagementMG 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: Managementname
  properties: {
    displayName: 'Testmanagementgroup'
    details: {
      parent: {
        id: NetworkPlatform.id
      }
    }
  }
}

resource ConnectivityMG 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: Connectivityname
  properties: {
    displayName: 'Acceptatiemanagementgroup'
    details: {
      parent: {
        id: NetworkPlatform.id
      }
    }
  }
}
