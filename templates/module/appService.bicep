param location string
param appSeviceAppName string
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'toy-product-launch-plan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name:appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-03-01' = {
  name: appSeviceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
