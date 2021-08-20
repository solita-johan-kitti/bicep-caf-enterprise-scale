targetScope = 'managementGroup'

// PARAMETERS
param policySource string
param assignmentIdentityLocation string
param assignmentEnforcementMode string
param monitoringGovernanceID string
param managementGroupID string

// VARIABLES

// OUTPUTS
output assignmentNames array = [
  monitoringGovernanceAssignment.name
]

output roleAssignmentIDs array = [
  monitoringGovernanceRoleAssignment.id
]

output assignmentIDs array = [
  monitoringGovernanceAssignment.id
]

// RESOURCES
resource monitoringGovernanceAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'monitoringGovAssignment' // Max length 24 char
  location: assignmentIdentityLocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: 'Monitoring Governance Assignment (CloudBlox™)'
    description: 'The CloudBlox™ Monitoring Governance Assignment'
    enforcementMode: assignmentEnforcementMode
    metadata: {
      source: policySource
      version: '0.1.0'
    }
    policyDefinitionId: monitoringGovernanceID
  }
}

resource monitoringGovernanceRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(monitoringGovernanceAssignment.name, monitoringGovernanceAssignment.type, managementGroupID)
  properties: {
    principalId: monitoringGovernanceAssignment.identity.principalId
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists/modify effects
  }
}
