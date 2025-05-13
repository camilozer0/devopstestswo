// Parameter
param keyVaultName string = 'devopstestkv'
param storageConnectionString string
param serviceBusConnectionString string
param storageSecretName string = 'sa-constring'
param serviceBusSecretName string = 'sb-constring'

// Resources
resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: keyVaultName
}

resource storageConnectionStringSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: storageSecretName
  properties: {
    value: storageConnectionString
  }
}

resource serviceBusConnectionStringSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: serviceBusSecretName
  properties: {
    value: serviceBusConnectionString
  }
}

// Outputs
output storageSecretId string = storageConnectionStringSecret.id
output serviceBusSecretId string = serviceBusConnectionStringSecret.id
