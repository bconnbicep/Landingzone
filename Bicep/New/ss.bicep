
resource sub1 'Microsoft.Subscription/aliases@2021-10-01' = {
  name: 'Sub1'
  scope: tenant()
  properties: {
    displayName: 'Sub1'
    billingScope:'152bd4a5-2a51-4e57-8bcf-4a27846a80f9'
    workload: 'Production'
  }
}
