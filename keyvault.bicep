// Parameters
param location string = resourceGroup().location
param projectName string = 'devopstest'
param keyVaultName string = '${projectName}kv'
param tenantID string = '257b7186-8eb0-40e4-afec-99211ef451ee'

// Variables
var keyVaultSku = 'standard'

// resources
resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: tenantID
    accessPolicies: [
      {
        tenantId: tenantID
        objectId: sys.guid(tenantID)
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
        }
      }
    ]
    sku: {
      name: keyVaultSku
      family: 'A'
    }
  }
}

// Outputs
output keyVaultID string = keyVault.id
output keyVaultUri string = keyVault.properties.vaultUri
