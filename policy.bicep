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
  definitions.outputs.deployDiagnosticsSettingsToLogAnalytics
  monitoringCaCDiagSetLAGovernanceInitiativ.outputs.initiativeName
  securityGovernanceInitiativ.outputs.initiativeName
  assignments.outputs.assignmentNames
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

module definitions 'modules/policy-definitions/definitions.bicep' = {
  scope: managementGroup() 
  name: 'definitions'
  params: {
    
  }
}

module monitoringCaCDiagSetLAGovernanceInitiativ 'modules/policy-initiatives/diagnostic-settings-to-log-analytics-cac-monitoring-governance.bicep' = {
  scope: managementGroup() 
  name: 'monitoringCaCDiagSetLAGovernanceInitiativ'
  dependsOn: [
    definitions
  ]    
  params:{
    policySource: policySource
    managementGroupId: managementGroupId
//    customPolicyIDs: definitions.outputs.deployDiagnosticsSettingsToLogAnalytics
  }
}

module securityGovernanceInitiativ 'modules/policy-initiatives/security-governance.bicep' = {
  scope: managementGroup() 
  name: 'securityGovernanceInitiativ'
  dependsOn: [
    // Need to set depends on. We are expecting that the custom definitions exist in azure.
    // We could send in a array of the policy created in the definitions module but the goal is
    // to us the policy in same wy as for built-in once that alrady exist to get code for both
    definitions
  ]    
  params:{
    policySource: policySource
    managementGroupId: managementGroupId
  }
}

module iamGovernanceInitiativ 'modules/policy-initiatives/iam-governance.bicep' = {
  scope: managementGroup() 
  name: 'iamGovernanceInitiativ'
  dependsOn: [
    // Need to set depends on. We are expecting that the custom definitions exist in azure.
    // We could send in a array of the policy created in the definitions module but the goal is
    // to us the policy in same wy as for built-in once that alrady exist to get code for both
    definitions
  ]    
  params:{
    policySource: policySource
    managementGroupId: managementGroupId
  }
}

module assignments 'modules/policy-assignments/assignments.bicep' = {
  scope: managementGroup() 
  name: 'assignments'
  dependsOn: [
    monitoringCaCDiagSetLAGovernanceInitiativ
  ]  
  params: {
    managementGroupID: managementGroupId
    logAnalyticsWorkspace: logAnalyticWorkspace.outputs.logAnalyticsWorkspaceID
    policySource: policySource
    assignmentIdentityLocation: location
    assignmentEnforcementMode: assignmentEnforcementMode
    monitoringCaCDiagSetLAGovernanceInitiativId: monitoringCaCDiagSetLAGovernanceInitiativ.outputs.initiativeID
    securityGovernanceInitiativId: securityGovernanceInitiativ.outputs.initiativeID
    iamGovernanceInitiativId: iamGovernanceInitiativ.outputs.initiativeID
  }  
}
