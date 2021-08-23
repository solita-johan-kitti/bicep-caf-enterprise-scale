targetScope = 'managementGroup'

// PARAMETERS   
param policySource string
param managementGroupId string

// VARIABLES

// OUTPUTS
// When scope is management group the initiativ id not returning the full id
output initiativeID string = '${tenantResourceId('Microsoft.Management/managementGroups', managementGroupId)}${tenantResourceId('Microsoft.Authorization/policySetDefinitions', securityGovernanceInitiative.name)}' 
output initiativeName string = securityGovernanceInitiative.name

// RESOURCES
resource securityGovernanceInitiative 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: 'securityGovernanceInitiative'
  properties: {
    displayName: 'Security Governance (CloudBlox™)'
    policyType: 'Custom'
    description: 'Contains common CloudBlox™ Security Governance policies'
    metadata: {
      version: '0.1.0'
      category: 'CloudBlox™ - Security (CaC)'
      source: policySource
    }
    parameters: {
      ascStdPricingEffect: {
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
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'Security Center standard pricing tier should be selected'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a1181c5f-672a-477a-979a-7d58aa086233'
        parameters: {
          effect: {
            value: '[parameters(\'ascStdPricingEffect\')]'
          }
        }
      }  
    ]
  }
}
