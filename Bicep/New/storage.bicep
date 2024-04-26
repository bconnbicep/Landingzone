
param Storage1Name string 
param location string 
 
resource storage1 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: Storage1Name
  kind: 'StorageV2'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
}
