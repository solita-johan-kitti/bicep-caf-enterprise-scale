targetScope = 'managementGroup'

// PARAMETERS
//@description('The management group to deploy (scope) to')
//param managementGroupName string

@description('Resource goupe used for logs')
param rgLogName string = 'rg-logs-shared'
@description('The name of the log anaylytic workspace.')
param logAnalyticWorkspaceName string = 'la-logs-shared'

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

module rgLog 'modules/foundation-resources/rg.bicep' = {
  scope: subscription('1b6348ed-c10a-42cf-9aa9-6b81e637c337')
  name: 'rgLog'
  params: {
    rgName: rgLogName
    tags: tags
  }
}

module logAnalyticWorkspace 'modules/foundation-resources/logAnalyticsWorkspace.bicep' = {
  scope: resourceGroup('1b6348ed-c10a-42cf-9aa9-6b81e637c337', rgLogName)
  name: logAnalyticWorkspaceName 
  params: {
    location: location
    name: logAnalyticWorkspaceName
    sku: 'Free' 
    tags: tags
  }
}

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
