targetScope = 'resourceGroup'

// ------------------
//    PARAMETERS
// ------------------

@description('The location where the resources will be created.')
param location string = resourceGroup().location

@description('Optional. The tags to be assigned to the created resources.')
param tags object = {
  solution: 'spas'
  iac: 'bicep'
  environment: 'aca'
}

// Container Apps Env / Log Analytics Workspace / Application Insights
@description('Optional. The name of the container apps environment. If set, it overrides the name generated by the template.')
param containerAppsEnvironmentName string = 'cae-${uniqueString(resourceGroup().id)}'

@description('Optional. The name of the log analytics workspace. If set, it overrides the name generated by the template.')
param logAnalyticsWorkspaceName string = 'log-${uniqueString(resourceGroup().id)}'

@description('Optional. The name of the application insights. If set, it overrides the name generated by the template.')
param applicationInsightName string = 'appi-${uniqueString(resourceGroup().id)}'// Services
@description('The name of the service ')
param theServiceName string  

// App Ports
@description('The target port for the service.')
param thePortNumber int = 44318

module acr 'modules/container-registry.bicep' = {
  name: 'acr-${uniqueString(resourceGroup().id)}'
  params: {
    acrName: 'acr${uniqueString(resourceGroup().id)}'
    location: location
    tags: tags
  }
}

module containerApps 'modules/container-apps.bicep' = {
  name: 'containerApps${uniqueString(resourceGroup().id)}'
  params: {
    location: location
    tags: tags
    containerAppsEnvironmentName: containerAppsEnvironmentName
    containerRegistryName: acr.outputs.acrName
    theServiceName: theServiceName
    thePortNumber: thePortNumber
  }
}


