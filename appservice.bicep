// Parameters
param projectName string = 'devopstest'
param appServicePlanName string = '${projectName}as'
param location string = 'canadacentral'
param skuName string = 'B1'
param skuKind string = 'Linux'

// Resources
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  kind: skuKind
  sku: {
    name: skuName
    tier: skuName == 'F1' ? 'Free' : 'Basic'
  }
  properties: {
    reserved: false
  }
}

// Outputs
output appServicePlanID string = appServicePlan.id
output appServicePlanNameOutput string = appServicePlan.name
