param(
    [string] [Parameter(Mandatory=$true)] $authToken,
    [string] [Parameter(Mandatory=$true)] $appPoolId,
    [string] [Parameter(Mandatory=$true)] $deploymentStatus
)

$uri = "https://1833kkkn-7178.uks1.devtunnels.ms/api/update-app-pool-deployment-status"
$headers = @{
    'Content-Type' = 'application/json'
    'Accept' = '*/*'
    'Authorization' = "Bearer $authToken"
}

$body = @{
    "Id"= $appPoolId
    "DeploymentStatus"="$deploymentStatus"
}

Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body ($body | ConvertTo-Json)