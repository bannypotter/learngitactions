param appServicePlanName string
param webAppName string
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
   sku:{   
     size: 'B1'
   }
   kind: 'linux'    
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
