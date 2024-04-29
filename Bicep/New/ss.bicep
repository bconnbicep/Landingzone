
resource sub1 'Microsoft.Subscription/aliases@2021-10-01' = {
  name: 'Sub1'
  scope: tenant()
  properties: {
    displayName: 'Sub1'
    billingScope:'2e457876-308f-47b3-bdff-2245b775eaf8'
    workload: 'Production'
  }
}
