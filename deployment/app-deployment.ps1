param(
    [string] [Parameter(Mandatory=$true)] $exampleParam,
    [string] [Parameter(Mandatory=$true)] $storageAccountName,
    [string] [Parameter(Mandatory=$true)] $resourceGroupName
)
Write-Output "This is powershell executing as part of the deployment = $exampleParam"
Write-Output "The environment user is $Env:UserName"

$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -AccountName $storageAccountName)[0].Value
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey
$containerName = "contents"
$blobs = Get-AzStorageBlob -Context $storageContext -Container $containerName
$blobs | ForEach-Object { Write-Output $_.Name }