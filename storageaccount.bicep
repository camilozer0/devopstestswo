// Parameters
param projectName string = 'devopstest'
param StoAccName string = '${projectName}sa'
param location string = resourceGroup().location
param skuName string = 'Standard_LRS'
param SAkind string = 'StorageV2'

resource stoacc 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: StoAccName
  location: location
  sku: {
    name: skuName
  }
  kind: SAkind
}

// Outputs
output StoAccID string = stoacc.id
