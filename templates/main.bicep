
//les parametres
param staorageAccountName string = 'toylaunchj${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toyproductj${uniqueString(resourceGroup().id)}'
param location string = 'westus3' //resourceGroup().location

@allowed([
  'prod'
  'nonprod'
])
param environmentType string

// var appServicePlanName = 'toy-product-launch-plan-starter'
var storageAccountSkuName = (environmentType == 'prod') ? 'standard_GRS': 'Standard_LRS'
// var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: staorageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}




module appService 'module/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appSeviceAppName: appServiceAppName
    environmentType: environmentType
  }
}

output appServiceAppHostName string = appService.outputs.appServiceAppHostName
