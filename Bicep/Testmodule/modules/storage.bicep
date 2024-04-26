
param storagename string
param location string 
param storagesku string 
param storagekind string 


resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storagename
  location: location
  sku: {
    name: storagesku
  }
  kind: storagekind
}

output storage string = storagename
