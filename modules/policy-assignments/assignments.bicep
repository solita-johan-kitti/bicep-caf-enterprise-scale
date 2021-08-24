targetScope = 'managementGroup'

// PARAMETERS
param policySource string
param assignmentIdentityLocation string
param assignmentEnforcementMode string
param monitoringCaCDiagSetLAGovernanceInitiativId string
param securityGovernanceInitiativId string
param iamGovernanceInitiativId string
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
  name: 'diagSetToLaCaCGovernance' // Max length 24 char
  location: assignmentIdentityLocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: 'Diagnostic Settings to Log Analytics Monitoring Compliance As Code (CaC) Governance (CloudBlox™)'
    description: 'The CloudBlox™ Governance Diagnostic Settings to Log Analytics Monitoring Compliance As Code (CaC) Governance Assignment'
    enforcementMode: assignmentEnforcementMode
    metadata: {
      category: 'CloudBlox™ - Monitoring (CaC)'
      version: '0.1.0'
      source: policySource
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

resource securityGovernanceAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'securityGovernance' // Max length 24 char
  location: assignmentIdentityLocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: 'Security Governance (CloudBlox™)'
    description: 'Assignment of the Security Governance initiative to management group (CloudBlox™).'
    enforcementMode: assignmentEnforcementMode
    metadata: {
      category: 'CloudBlox™ - Security (CaC)'
      version: '0.1.0'
      source: policySource
    }
    policyDefinitionId: securityGovernanceInitiativId
 /*
    parameters: {
      logAnalytics: {
        value: logAnalyticsWorkspace
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
    ]*/   
  }
}

resource iamGovernanceAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'iamGovernance' // Max length 24 char
  location: assignmentIdentityLocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: 'IAM Governance (CloudBlox™)'
    description: 'Assignment of the IAM Governance initiative to management group (CloudBlox™).'
    enforcementMode: assignmentEnforcementMode
    metadata: {
      category: 'CloudBlox™ - IAM (CaC)'
      version: '0.1.0'
      source: policySource
    }
    policyDefinitionId: iamGovernanceInitiativId
 /*
    parameters: {
      logAnalytics: {
        value: logAnalyticsWorkspace
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
    ]*/   
  }
}

resource monitoringCaCDiagSetLAGovernanceRoleAssignment 'Microsoft.Authorization/roleAssignments@2018-01-01-preview' = {
  name: guid(monitoringCaCDiagSetLAGovernanceAssignment.name, monitoringCaCDiagSetLAGovernanceAssignment.type, managementGroupID)
  properties: {
    principalId: monitoringCaCDiagSetLAGovernanceAssignment.identity.principalId
    //roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists/modify effects
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635' // Owner  RBAC role for deployIfNotExists/modify effects
  }
}

resource securityGovernanceRoleAssignment 'Microsoft.Authorization/roleAssignments@2018-01-01-preview' = {
  name: guid(securityGovernanceAssignment.name, securityGovernanceAssignment.type, managementGroupID)
  properties: {
    principalId: securityGovernanceAssignment.identity.principalId
    //roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists/modify effects
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635' // Owner  RBAC role for deployIfNotExists/modify effects
  }
}

resource iamGovernanceRoleAssignment 'Microsoft.Authorization/roleAssignments@2018-01-01-preview' = {
  name: guid(iamGovernanceAssignment.name, iamGovernanceAssignment.type, managementGroupID)
  properties: {
    principalId: iamGovernanceAssignment.identity.principalId
    //roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists/modify effects
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635' // Owner  RBAC role for deployIfNotExists/modify effects
  }
}

