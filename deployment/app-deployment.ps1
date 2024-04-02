param(
    [string] [Parameter(Mandatory=$true)] $exampleParam
)
Write-Host "This is powershell executing as part of the deployment = $exampleParam"
Write-Host $Env:UserName