# Nombre del RG donde esta el storageAccount
$resourceGroupName = "CamiloMazorra"

# nombre del storageAccount
$storageAccountName = "techskillssa"

# Try para obtener las claves del storageAccount
try {
    $storageAccountKeys = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -StorageAccountName $storageAccountName
}
catch {
    Write-Error "Error al obtener las claves de acceso del storageAccount '$storageAccountName' en el RG '$resourceGroupName': $($_.Exception.Message)"
    exit 1
}

# Se verifica que se encontraron las claves para escribir la cadena de conexion
if ($storageAccountKeys -and $storageAccountKeys.Count -gt 0) {
    $primaryKey = $storageAccountKeys[0].Value
    $connectionString = "DefaultEndpointsProtocol=https;AccountName=$storageAccountName;AccountKey=$primaryKey;EndpointSuffix=$(Get-AzEnvironment | Select-Object -ExpandProperty StorageEndpointSuffix)"
    Write-Host "La cadena de conexion para el storageAccount ' $storageAccountName' es:"
    Write-Host $connectionString -ForegroundColor Blue
}
else {
    Write-Warning "No se encontraron las llaves de claves de acceso para el storageAccount '$storageAccountName'."
}