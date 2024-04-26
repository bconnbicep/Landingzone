
targetScope = 'tenant'

@description('Name for Parent Landing zone')
param PMGname string

@description('Name for Development Landing zone')
param CMGname1 string

@description('Name for Test Landing zone')
param CMGname2 string

@description('Name for Acceptatie Landing zone')
param CMGname3 string

// level 1
resource PMG 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: PMGname
  properties: {
    displayName: 'Parentmanagementgroupdisplayname'
  }
}

// Level 2
resource DevelopementMG 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: CMGname1
  properties: {
    displayName: 'Developementmanagementgroup'
    details: {
      parent: {
        id: PMG.id
      }
    }
  }
}

resource TestMG 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: CMGname2
  properties: {
    displayName: 'Testmanagementgroup'
    details: {
      parent: {
        id: PMG.id
      }
    }
  }
}

resource AcceptatieMG 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: CMGname3
  properties: {
    displayName: 'Acceptatiemanagementgroup'
    details: {
      parent: {
        id: PMG.id
      }
    }
  }
}
