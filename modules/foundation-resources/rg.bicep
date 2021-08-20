targetScope = 'subscription'

// PARAMS
param location string = 'westeurope'
param rgName string
param tags object

// OUTPUTS
output rgLogID string = rgLog.id

//RESOURCES
resource rgLog 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
  tags: tags
}
