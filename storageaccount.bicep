param pStoAccName string
param plocation string = resourceGroup().location

resource stoacc 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: pStoAccName
  location: plocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output StoAccId string = stoacc.id

