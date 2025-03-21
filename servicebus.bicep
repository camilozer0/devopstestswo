// Parameters
param projectName string = 'devopstest'
param location string = resourceGroup().location
param serviceBusSku string = 'Standard'

// Variables
var serviceBusNamespaceName ='${projectName}sbns'

// Resources
resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2021-06-01-preview' = {
  name: serviceBusNamespaceName
  location: location
  sku: {
    name: serviceBusSku
    capacity: 1
    tier: serviceBusSku
  }
}


// Outputs
output serviceBusNamespaceID string = serviceBusNamespace.id

