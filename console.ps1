# Define the subscription Id and the resource group name
$subscriptionId = 'a000a24c-8675-4766-a088-80fabf59ae59'
$resourceGroupName = 'DevOpsTest'

# Define the names of the Storage Account and Service Bus
$storageAccountName = 'devopstestonesa'
$serviceBusNamespaceName = 'devopstestsbns'

# Atuthenticate to Azure
Connect-AzAccount

# Set the subscriptin content
Set-AzContext -SubscriptionId $subscriptionId

# Retrieve the storage Account keys
$storageKeys = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageConnectionString = "DefaultEndpointsProtocol=https;AccountName=$storageAccountName;AccountKey=$($storageKeys[0].Value);EndpointSuffix=core.windows.net"

# Retrieve the service bus connection string
$serviceBusKeys = Get-AzServiceBusKey -ResourceGroupName $resourceGroupName -Namespace $serviceBusNamespaceName -Name 'RootManagerSharedAccessKey'
$serviceBusConnectionString = $serviceBusKeys.PrimaryConnectionString

#Print the connection strings
Write-Output "Storage Account Connection String: $storageConnectionString"
Write-Output "Service Bus Connection String: $serviceBusConnectionString"