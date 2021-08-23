targetScope = 'managementGroup'

// PARAMETERS
param policySource string
param assignmentIdentityLocation string
param assignmentEnforcementMode string
param monitoringCaCDiagSetLAGovernanceInitiativId string
param managementGroupID string
@description('The name of the log anaylytic workspace to send diagnostic logs to.')
param logAnalyticsWorkspace string
// VARIABLES

// OUTPUTS
output assignmentNames array = [
  monitoringCaCDiagSetLAGovernanceAssignment.name
]

output roleAssignmentIDs array = [
  monitoringCaCDiagSetLAGovernanceAssignment.id
]

output assignmentIDs array = [
  monitoringCaCDiagSetLAGovernanceAssignment.id
]

// RESOURCES
resource monitoringCaCDiagSetLAGovernanceAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'DiagSetToLaCaCGov' // Max length 24 char
  location: assignmentIdentityLocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: 'Diagnostic Settings to Log Analytics Monitoring Compliance As Code (CaC) Governance (CloudBlox™)'
    description: 'The CloudBlox™ Governance Diagnostic Settings to Log Analytics Monitoring Compliance As Code (CaC) Governance Assignment'
    enforcementMode: assignmentEnforcementMode
    metadata: {
      source: policySource
      version: '0.1.0'
    }
    policyDefinitionId: monitoringCaCDiagSetLAGovernanceInitiativId
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
  //name: guid(monitoringCaCDiagSetLAGovernanceAssignment.name, monitoringCaCDiagSetLAGovernanceAssignment.type, managementGroupID)
  name: '${managementGroupID}-${monitoringCaCDiagSetLAGovernanceAssignment.name}'
  properties: {
    principalId: monitoringCaCDiagSetLAGovernanceAssignment.identity.principalId
    //roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists/modify effects
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635' // Owner  RBAC role for deployIfNotExists/modify effects
  }
}


 
