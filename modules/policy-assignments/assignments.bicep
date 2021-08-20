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
  //scope: managementGroup()
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
/*
resource policyAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'name'
  location: 'location'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: 'displayName'
    description: 'description'
    enforcementMode: 'Default'
    metadata: {
      source: 'source'
      version: '0.1.0'
    }
    policyDefinitionId: 'policyDefinitionId'
    parameters: {
      parameterName: {
        value: 'value'
      }
    }
    nonComplianceMessages: [
      {
        message: 'message'
      }
      {
        message: 'message'
        policyDefinitionReferenceId: 'policyDefinitionReferenceId'
      }
    ]
  }
}
*/

resource monitoringGovernanceRoleAssignment 'Microsoft.Authorization/roleAssignments@2018-01-01-preview' = {
  name: guid(monitoringGovernanceAssignment.name, monitoringGovernanceAssignment.type, managementGroupID)
  //scope: monitoringGovernanceAssignment
  properties: {
    principalId: monitoringGovernanceAssignment.identity.principalId
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists/modify effects
  }
}

/*
resource "azurerm_role_assignment" "operation_governance" {
  count                = length(var.operation_governance_assignment.identity)
  scope                = var.operation_governance_assignment.scope
  role_definition_name = "Owner"
  principal_id         = var.operation_governance_assignment.identity[count.index].principal_id
}
*/
 
