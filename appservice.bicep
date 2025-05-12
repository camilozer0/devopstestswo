// Parameters
param projectName string = 'techskills'
param location string = resourceGroup().location
param skuName string = 'B1'
param skuKind string = 'Linux'

// Variables
var appServicePlanName = '${projectName}as'

// Resources
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
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
output appServicePlanSkuName string = appServicePlan.sku.name
output appservicePlanSkuTier string = appServicePlan.sku.tier
