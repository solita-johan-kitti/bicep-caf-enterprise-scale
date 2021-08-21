

/*
resource monitoringGovernanceRoleAssignment 'Microsoft.Authorization/roleAssignments@2018-01-01-preview' = {
  name: guid(monitoringGovernanceAssignment.name, monitoringGovernanceAssignment.type, managementGroupID)
  dependsOn: [
    monitoringGovernanceAssignment
  ]
  scope: monitoringGovernanceAssignment
  properties: {
    principalId: monitoringGovernanceAssignment.identity.principalId
    //roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists/modify effects
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635' // Owner  RBAC role for deployIfNotExists/modify effects
  }
}
*/
