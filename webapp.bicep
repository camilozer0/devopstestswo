// Parameters
param appServiceName string = 'camilozerowebapp'
param location string = 'canadacentral'
param appServicePlanName string = 'devopstestas'
param spKindName string = 'App'

// Resources
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' existing = {
  name: appServicePlanName
}

resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: appServiceName
  location: location
  kind: spKindName
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// Outputs
output appServiceID string = appService.id
output appServiceHostname string = appService.properties.defaultHostName
