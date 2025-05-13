# Define el id de la suscripcion y el nombre del recurso
$subscriptionId = 'a000a24c-8675-4766-a088-80fabf59ae59'
$resourceGroupName = 'DevOpsTest'

# Define los nombres del storageAccount y el ServiceBus
$storageAccountName = 'devopstestonesa'
$serviceBusNamespaceName = 'devopstestsbns'

# Se autentica a Azure
Connect-AzAccount

# Configura la suscripcion
Set-AzContext -SubscriptionId $subscriptionId

# Extrae las llaves del StorageAccount
$storageKeys = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageConnectionString = "DefaultEndpointsProtocol=https;AccountName=$storageAccountName;AccountKey=$($storageKeys[0].Value);EndpointSuffix=core.windows.net"

# Extrae el connection string del ServiceBus
$serviceBusKeys = Get-AzServiceBusKey -ResourceGroupName $resourceGroupName -Namespace $serviceBusNamespaceName -Name 'RootManageSharedAccessKey'
$serviceBusConnectionString = $serviceBusKeys.PrimaryConnectionString

# Imprime los connectionStrings
Write-Output "Storage Account Connection String: $storageConnectionString"
Write-Output "Service Bus Connection String: $serviceBusConnectionString"

# Desplegar el archivo Bicep pasando las cadenas de conexión como parámetros
az deployment group create `
    --resource-group $resourceGroupName `
    --template-file ./storekeyvault.bicep `
    --name CreateKVSecretsDeployment `
    --parameters storageConnectionString="$storageConnectionString" `
    --parameters serviceBusConnectionString="$serviceBusConnectionString"