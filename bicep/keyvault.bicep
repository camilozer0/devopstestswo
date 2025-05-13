// Parameters
param projectName string = 'techskills'
param location string = resourceGroup().location
param tenantID string = subscription().tenantId

// Variables
param keyVaultName string = '${projectName}kv'
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
output tenantId string = subscription().tenantId
