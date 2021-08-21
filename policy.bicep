targetScope = 'managementGroup'

// PARAMETERS
@description('The management group to deploy (scope) to')
param managementGroupId string

@description('Resource goupe used for logs')
param resourceGroupNameLogs string = 'rg-logs-shared'
@description('The name of the log anaylytic workspace.')
param logAnalyticWorkspaceName string = 'la-logs-shared'

@description('')
param policySource string = 'https://github.com/solita-johan-kitti/bicep-caf-enterprise-scale'

@description('')
param assignmentEnforcementMode string = 'Default'
@allowed([
  'westeurope'
  'northeurope'
])

@description('Assignment Identity Location')
param location string = 'westeurope'

// VARIABLES
var tags = {
  'owner':              'Johan Kitti'
  'technical-owner':    'Johan Kitti'
  'costcenter':         '1234'
  'project-identifier': 'M56879'
  'environment':        'shared'
  'gdpr':               'no'
  'sla-level':          '1'
}


// OUTPUTS
// outputs here can be consumed by an .azcli script to delete deployed resources
output resourceNamesForCleanup array = [
  initiatives.outputs.initiativeNames
  assignments.outputs.assignmentNames
  //definitions.outputs.monitoringGovernancePolicies
]

// RESOURCES
module rgLog 'modules/foundation-resources/resourceGroups.bicep' = {
  scope: subscription('1b6348ed-c10a-42cf-9aa9-6b81e637c337')
  name: resourceGroupNameLogs
  params: {
    resourceGroupName: resourceGroupNameLogs
    location: location
    tags: tags
  }
}

module logAnalyticWorkspace 'modules/foundation-resources/logAnalyticsWorkspace.bicep' = {
  
  scope: resourceGroup('1b6348ed-c10a-42cf-9aa9-6b81e637c337', resourceGroupNameLogs)
  name: logAnalyticWorkspaceName 
  dependsOn: [
    rgLog
  ]
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
    logAnalyticsWorkspace: logAnalyticWorkspace.outputs.logAnalyticsWorkspaceID
    managementGroupId: managementGroupId
  }
}

module assignments 'modules/policy-assignments/assignments.bicep' = {
  scope: managementGroup() 
  name: 'assignments'
  dependsOn: [
    initiatives
  ]  
  params: {
    managementGroupID: managementGroupId
    policySource: policySource
    assignmentIdentityLocation: location
    assignmentEnforcementMode: assignmentEnforcementMode
    monitoringCaCGovernanceID: monitoringCaCGovernance.outputs.initiativeIDs[0]
  }  
}
