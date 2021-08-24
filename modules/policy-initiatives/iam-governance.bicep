targetScope = 'managementGroup'

// PARAMETERS   
param policySource string
param managementGroupId string

// VARIABLES

// OUTPUTS
// When scope is management group the initiativ id not returning the full id
output initiativeID string = '${tenantResourceId('Microsoft.Management/managementGroups', managementGroupId)}${tenantResourceId('Microsoft.Authorization/policySetDefinitions', iamGovernanceInitiative.name)}' 
output initiativeName string = iamGovernanceInitiative.name

// RESOURCES
resource iamGovernanceInitiative 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: 'iamGovernanceInitiative'
  properties: {
    displayName: 'IAM Governance (CloudBlox™)'
    policyType: 'Custom'
    description: 'Contains common CloudBlox™ IAM Governance policies'
    metadata: {
      version: '0.1.0'
      category: 'CloudBlox™ - Iam (CaC)'
      source: policySource
    }
    parameters: {
      removeDepracatedAccountEffect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'AuditIfNotExists'
          'Disabled'
        ]
        defaultValue: 'AuditIfNotExists'        
      }
      removeDepracatedOwnerAccountEffect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'AuditIfNotExists'
          'Disabled'
        ]
        defaultValue: 'AuditIfNotExists'        
      }    
      customRBACRulesEffect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'Audit'
          'Disabled'
        ]
        defaultValue: 'Audit'        
      }  
      moreThen1OwnerSubscriptionEffect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'AuditIfNotExists'
          'Disabled'
        ]
        defaultValue: 'AuditIfNotExists'        
      }                 
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'Deprecated accounts should be removed from your subscription'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/6b1cbf55-e8b6-442f-ba4c-7246b6381474'
        parameters: {
          effect: {
            value: '[parameters(\'removeDepracatedAccountEffect\')]'
          }
        }
      }  
      {
        policyDefinitionReferenceId: 'Deprecated accounts with owner permissions should be removed from your subscription'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/ebb62a0c-3560-49e1-89ed-27e074e9f8ad'
        parameters: {
          effect: {
            value: '[parameters(\'removeDepracatedOwnerAccountEffect\')]'
          }
        }
      }  
      {
        policyDefinitionReferenceId: 'Audit usage of custom RBAC rules'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a451c1ef-c6ca-483d-87ed-f49761e3ffb5'
        parameters: {
          effect: {
            value: '[parameters(\'customRBACRulesEffect\')]'
          }
        }
      } 
      {
        policyDefinitionReferenceId: 'There should be more than one owner assigned to your subscription'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/09024ccc-0c5f-475e-9457-b7c0d9ed487b'
        parameters: {
          effect: {
            value: '[parameters(\'moreThen1OwnerSubscriptionEffect\')]'
          }
        }
      }                   
    ]
  }
}
