Connect-AzAccount
Set-AzContext -SubscriptionName "CamiloZero"
$userPrincipalId = (Get-AzADUser -UserPrincipalName "mazorra006@hotmail.com").Id
$keyVault = Get-AzKeyVault -VaultName "techskillskv" -ResourceGroupName "CamiloMazorra"
$keyVaultId = $keyVault.Id
New-AzRoleAssignment -ObjectId $userPrincipalId -RoleDefinitionName "Role Based Access Control Administrator" -Scope $keyVaultId
