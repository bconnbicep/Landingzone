
resource sub1 'Microsoft.Subscription/aliases@2021-10-01' = {
  name: 'Sub1'
  scope: tenant()
}
