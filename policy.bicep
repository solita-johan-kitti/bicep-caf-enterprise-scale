targetScope = 'managementGroup'

// PARAMETERS
//@description('The management group to deploy (scope) to')
//param managementGroupName string

param policySource string = 'https://github.com/solita-johan-kitti/bicep-caf-enterprise-scale'
param assignmentEnforcementMode string = 'Default'
@allowed([
  'westeurope'
  'northeurope'
])
@description('Assignment Identity Location')
param location string = 'westeurope'

// VARIABLES

// OUTPUTS

// RESOURCES
// outputs here can be consumed by an .azcli script to delete deployed resources
output resourceNamesForCleanup array = [
  initiatives.outputs.initiativeNames
  assignments.outputs.assignmentNames
  //definitions.outputs.monitoringGovernancePolicies
]

// Prerequite resources.

var tags = {
  'owner':              'Johan Kitti'
  'technical-owner':    'Johan Kitti'
  'costcenter':         '1234'
  'project-identifier': 'M56879'
  'environment':        'shared'
  'gdpr':               'no'
  'sla-level':          '1'
}
/*
resource rgLog 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: log-rg
  location: location
  tags: tags
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: 'name'
  location: location
  properties: {
    sku: {
      name: 'Free'
    }
  }
}
*/

module initiatives 'modules/policy-initiatives/initiatives.bicep' = {
  scope: managementGroup() 
  name: 'initiatives'
  params:{
    policySource: policySource
  }
}

module assignments 'modules/policy-assignments/assignments.bicep' = {
  scope: managementGroup() 
  name: 'assignments'
  params: {
    policySource: policySource
    assignmentIdentityLocation: location
    assignmentEnforcementMode: assignmentEnforcementMode
    monitoringGovernanceID: initiatives.outputs.initiativeIDs[0]
  }  
}
