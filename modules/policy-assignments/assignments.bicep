targetScope = 'managementGroup'

// PARAMETERS
param policySource string
param assignmentIdentityLocation string
param assignmentEnforcementMode string
param monitoringCaCGovernanceID string
param managementGroupID string
@description('The name of the log anaylytic workspace to send diagnostic logs to.')
param logAnalyticsWorkspace string
// VARIABLES

// OUTPUTS
output assignmentNames array = [
  monitoringCaCGovernanceAssignment.name
]

output roleAssignmentIDs array = [
  monitoringGovernanceRoleAssignment.id
]

output assignmentIDs array = [
  monitoringCaCGovernanceAssignment.id
]

// RESOURCES
resource monitoringCaCGovernanceAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'monitoringCaCGovAss' // Max length 24 char
  location: assignmentIdentityLocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: 'Monitoring CaC Governance (CloudBlox™)'
    description: 'The CloudBlox™ Governance Monitoring Compliance As Code (CaC) Governance  Assignment'
    enforcementMode: assignmentEnforcementMode
    metadata: {
      source: policySource
      version: '0.1.0'
    }
    policyDefinitionId: monitoringCaCGovernanceID
    parameters: {
      logAnalytics: {
        value: logAnalyticsWorkspace
      }  
    } 
 /*   nonComplianceMessages: [
      {
        message: 'message'
      }
      {
        message: 'message'
        policyDefinitionReferenceId: 'policyDefinitionReferenceId'
      }
    ]*/   
  }
}

resource monitoringGovernanceRoleAssignment 'Microsoft.Authorization/roleAssignments@2018-01-01-preview' = {
  name: guid(monitoringCaCGovernanceAssignment.name, monitoringCaCGovernanceAssignment.type, managementGroupID)
  properties: {
    principalId: monitoringCaCGovernanceAssignment.identity.principalId
    //roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists/modify effects
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635' // Owner  RBAC role for deployIfNotExists/modify effects
  }
}


 
