param appServicePlanName string
param webAppName string
param location string = resourceGroup().location
param storageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  identity: {
    type: 'SystemAssigned'
  }
  kind: 'StorageV2'
}

resource storageAccountBlobService 'Microsoft.Storage/storageAccounts/blobServices@2019-06-01' = {
  name: 'default'
  parent: storageAccount
}

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: 'contents'
  parent: storageAccountBlobService
  properties: {
    publicAccess: 'None'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
   sku:{   
     name: 'B1'
   }
   kind: 'linux'
   properties: {
    reserved: true
  } 
}

resource webapp 'Microsoft.Web/sites@2023-01-01' = {
  name: webAppName
  location: location
  properties:{
    httpsOnly: true
    serverFarmId: appServicePlan.id
    siteConfig:{
      minTlsVersion: '1.2'
      ftpsState: 'Disabled'
    }
  }
}

resource powershell 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  dependsOn: [storageContainer]
  name: 'powershell-deployment-script'
  location: location
  kind: 'AzurePowerShell'
  properties: {
    azPowerShellVersion: '8.3'
    retentionInterval: 'P1D'
    timeout: 'PT30M'
    cleanupPreference: 'Always'
    scriptContent: loadTextContent('app-deployment.ps1')
    arguments: '-exampleParam \\"this is an example\\"'
  }
}
