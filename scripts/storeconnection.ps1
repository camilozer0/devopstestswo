$resourceGroupName = "CamiloMazorra"
$storageAccountName = "techskillssa"
$keyVaultName = "techskillskv"
$secretPrefix = "storageAccount-$storageAccountName-"

try {
    $storageAccountKeys = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -StorageAccountName $storageAccountName
}
catch {
    Write-Error "Error al obtener las claves de acceso del storageAccount '$storageAccountName' en el grupo de recursos'$resourceGroupName': $($_.Exception.Message)"
    exit 1
}

if ($storageAccountKeys -and $storageAccountKeys.Count -gt 0) {
    for ($i = 0; $i -lt $storageAccountKeys.Count; $i++) {
        $accountKey = $storageAccountKeys[$i].Value
        $keyName = $storageAccountKeys[$i].KeyName

        $connectionString = "DefaultEndpointsProtocol=https;AccountName=$storageAccountName;AccountKey=$accountKey;EndpointSuffix=$(Get-AzEnvironment | Select-Object -ExpandProperty StorageEndpointSuffix)"

        $secureConnectionString = ConvertTo-SecureString -String $connectionString -AsPlainText -Force

        $secretName = "$secretPrefix$keyName-ConnectionString"

        try {
            Set-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretName -SecretValue $secureConnectionString
            Write-Host "El secreto '$secretName' ha sido creado exitosamente en el key vault '$keyVaultName' para la clave '$keyName'." --ForegroundColor Blue
        }
        catch {
            Write-Error "Error al crear el secreto '$secretName' en el keyVault '$keyVaultName' para la clave '$keyName': $($_.Exception.Message)"
        }
    }
}
else {
    Write-Warning "No se encontraron claves de acceso para el storageAccount '$storageAccountName'."
}