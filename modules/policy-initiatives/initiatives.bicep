targetScope = 'managementGroup'

/////////////////////////////////////////////////////////////
//
//  Monitoring Governance
//
/////////////////////////////////////////////////////////////

// PARAMETERS   
param policySource string
//param monitoringGovernancePolicies array

param monitoringGovernanceBuiltInPolicies array = [
  {
    name: 'Deploy Diagnostic Settings for Key Vault to Log Analytics workspace'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47'
    effect: 'DeployIfNotExists'
    metricsEnabled: false
    logsEnabled: true
  }
]

param logAnalyticsWorkspace string

// VARIABLES


// OUTPUTS
output initiativeIDs array = [
  monitoringGovernance.id
]

output initiativeNames array = [
  monitoringGovernance.name
]

// RESOURCES

resource monitoringGovernance 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: 'monitoringGovernance'
  properties: {
    displayName: 'Monitoring Governance Initiative (CloudBlox™)'
    policyType: 'Custom'
    description: 'The CloudBlox™ Governance Monitoring Initiative'
    metadata: {
      version: '0.1.0'
      category: 'CloudBlox™ - monitoring'
      source: policySource
    }
    parameters: {
//      parameterName: {
//        type: 'String'
//        metadata: {
//          displayName: 'Monitoring Foundation (CloudBlox™)'
//          description: 'Contains common CloudBlox™ Monitoring policies'
//        }
//      }
    }
 
    policyDefinitions: [for (policy, index) in monitoringGovernanceBuiltInPolicies: {
      policyDefinitionId: policy.policyDefinitionId
      policyDefinitionReferenceId: policy.name
      parameters: {
        logAnalytics: {
          value: logAnalyticsWorkspace
        }
        effect: {
          value: policy.effect
        }
        metricsEnabled: {
          value: policy.metricsEnabled
        }
        logsEnabled: {
          value: policy.logsEnabled
        }
      }
    }]
/*
    policyDefinitions: [
      {
        policyDefinitionId: 'policyDefinitionId'
        policyDefinitionReferenceId: 'policyDefinitionReferenceId'
        parameters: {
          parameterName: {
            value: 'value'
          }
        }
      }
    ]
*/    
  }
}
