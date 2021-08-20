targetScope = 'resourceGroup'

// PARAMETERS
@description('The name of the workspace.')
param name string
@description('The geo-location where the resource lives')
param location string
@allowed([
  'Free'
  'Standard' 
  'Premium' 
  'PerNode' 
  'PerGB2018' 
  'Standalone' 
  'CapacityReservation'
])
@description('The name of the SKU')
param sku string = 'Free'
@description('Tags to set')
param tags object

// OUTPUTS
output logAnalyticsWorkspaceID string = logAnalyticsWorkspace.id
output logAnalyticsWorkspaceName string = logAnalyticsWorkspace.name

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: name
  location: location
  properties: {
    sku: {
      name: sku
    }
  }
  tags:tags
}
