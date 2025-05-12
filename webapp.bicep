// Parameters
param projectName string = 'techskills'
param location string = 'canadacentral'
param spKindName string = 'App'

// Variables
var appServiceName = '${projectName}web'
var appServicePlanName = '${projectName}as'

// Resources
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' existing = {
  name: appServicePlanName
}

resource appService 'Microsoft.Web/sites@2024-04-01' = {
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
output appServiceDefaultHostname string = appService.properties.defaultHostName
output appServiceNameOutput string = appService.name
output appServiceSystemAssignedPrincipalId string = appService.identity.principalId
