// Parameters
param projectName string = 'techskills'
param location string = resourceGroup().location
param skuName string = 'Standard_LRS'
param SAkind string = 'StorageV2'

// Variables
var StoAccName = '${projectName}sa'

// Resource
resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: StoAccName
  location: location
  sku: {
    name: skuName
  }
  kind: SAkind
}

// Outputs
output StoAccID string = storageAccount.id
output StoAccName string = storageAccount.name
