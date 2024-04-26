
var storagename = 'supa1storage'
var storageAccountSkuName = 'Standard_LRS'
param location string = resourceGroup().location

resource superstorage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storagename
  location: location
  sku: {
    name:storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
