
resource mg1  'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'non-prod'
  scope: tenant()
}
