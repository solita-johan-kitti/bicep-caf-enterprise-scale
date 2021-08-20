targetScope = 'subscription'

// PARAMS
param location string = 'westeurope'
param resourceGroupName  string
param tags object

// OUTPUTS
output resourceGroupID  string = rg.id
output resourceGroupName  string = rg.name

//RESOURCES
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}
