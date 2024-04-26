
param storagename string = '123storage'
param location string = 'westeurope'
param storagesku string = 'Standard_LRS'
param storagekind string = 'StorageV2'

module StorageAccoun 'modules/storage.bicep' = {
  name: 'storagenew12'
  params: {
    location: location
    storagekind: storagekind
    storagename: storagename
    storagesku: storagesku
  }
}

output storageaccount string = storagename
