targetScope = 'managementGroup'

/////////////////////////////////////////////////////////////
//
//  Monitoring Governance
//
/////////////////////////////////////////////////////////////

// PARAMETERS   
param policySource string
param managementGroupId string
//param monitoringGovernancePolicies array
/*
param monitoringGovernanceBuiltInPolicies array = [
  {
    name: 'Deploy Diagnostic Settings for Key Vault to Log Analytics workspace'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47'
    effect: 'DeployIfNotExists'
    metricsEnabled: 'False'
    logsEnabled: 'True'
  }
  {
    name: 'Configure Azure Activity logs to stream to specified Log Analytics workspace'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/2465583e-4e78-4c15-b6be-a36cbc7c8b0f'
    effect: 'DeployIfNotExists'
    logsEnabled: 'True'
  }
]
*/

@description('The name of the log anaylytic workspace to send diagnostic logs to.')
param logAnalyticsWorkspace string

// VARIABLES


// OUTPUTS
output initiativeIDs array = [
  // When scope is management group the initiativ id not returning the full id
  '${tenantResourceId('Microsoft.Management/managementGroups', managementGroupId)}${tenantResourceId('Microsoft.Authorization/policySetDefinitions', monitoringGovernance.name)}' 
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
      category: 'CloudBlox™ - Monitoring'
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
 
/*    
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
*/

    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Key Vault to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47'
        parameters: {
          logAnalytics: {
            value: logAnalyticsWorkspace
          }
          effect: {
            value: 'DeployIfNotExists'
          }
          metricsEnabled: {
            value: 'False' 
          }
          logsEnabled: {
            value: 'True'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'Configure Azure Activity logs to stream to specified Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/2465583e-4e78-4c15-b6be-a36cbc7c8b0f'
        parameters: {
          logAnalytics: {
            value: logAnalyticsWorkspace
          }
          effect: {
            value: 'DeployIfNotExists'
          }
          logsEnabled: {
            value: 'True' 
          }
        }
      }
    ]
  }
}
