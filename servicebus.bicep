// Parameters
param projectName string = 'techskills'
param location string = resourceGroup().location
param serviceBusSku string = 'Standard'

// Variables
var serviceBusNamespaceName = '${projectName}sbns'
var queueName = '${projectName}queue'
var topicName = '${projectName}topic'

// Resources
resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2024-01-01' = {
  name: serviceBusNamespaceName
  location: location
  sku: {
    name: serviceBusSku
    capacity: 1
    tier: serviceBusSku
  }
}

resource queue 'Microsoft.ServiceBus/namespaces/queues@2024-01-01' = {
  name: queueName
  parent: serviceBusNamespace
}

resource topic 'Microsoft.ServiceBus/namespaces/topics@2024-01-01' = {
  name: topicName
  parent: serviceBusNamespace
}

// Outputs
output serviceBusNamespaceID string = serviceBusNamespace.id
output servieBusNamespaceName string = serviceBusNamespace.name
output queueName string = queue.name
output topicName string = topic.name
