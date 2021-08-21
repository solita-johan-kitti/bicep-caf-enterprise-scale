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

// VARIABLES

// OUTPUTS
output initiativeIDs array = [
  // When scope is management group the initiativ id not returning the full id
  '${tenantResourceId('Microsoft.Management/managementGroups', managementGroupId)}${tenantResourceId('Microsoft.Authorization/policySetDefinitions', monitoringCaCGovernance.name)}' 
]
output initiativeNames array = [
  monitoringCaCGovernance.name
]

// RESOURCES

resource monitoringCaCGovernance 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: 'monitoringCaCGovernance'
  properties: {
    displayName: 'Monitoring CaC Governance (CloudBlox™)'
    policyType: 'Custom'
    description: 'The CloudBlox™ Governance Monitoring Compliance As Code (CaC) Governance Initiative Diagnostic Logs '
    metadata: {
      version: '0.1.0'
      category: 'CloudBlox™ - Monitoring (CaC)'
      source: policySource
    }
    parameters: {
      logAnalytics: {
        type: 'String'
        metadata: {
          displayName: 'Log Analytics workspace'
          description: 'Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant \'Log Analytics Contributor\' permissions (or similar) to the policy assignment\'s principal ID.'
          strongType: 'omsWorkspace'
          assignPermissions: true
        }
      }      
      keyVaultEffect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
      }
      keyVaultMetricsEnabled: {
        type: 'String'
        metadata: {
          displayName: 'Enable metrics'
          description: 'Whether to enable metrics stream to the Log Analytics workspace - True or False'
        }
        allowedValues: [
          'True'
          'False'
        ]
        defaultValue: 'False'
      }
      keyVaultLogsEnabled: {
        type: 'String'
        metadata: {
          displayName: 'Enable logs'
          description: 'Whether to enable logs stream to the Log Analytics workspace - True or False'
        }
        allowedValues: [
          'True'
          'False'
        ]
        defaultValue: 'True'
      }

      activitylogsEffect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
      }
      activitylogsLogsEnabled: {
        type: 'String'
        metadata: {
          displayName: 'Enable logs'
          description: 'Whether to enable logs stream to the Log Analytics workspace - True or False'
        }
        allowedValues: [
          'True'
          'False'
        ]
        defaultValue: 'True'
      }      
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
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'keyVaultEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'keyVaultMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'keyVaultLogsEnabled\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'Configure Azure Activity logs to stream to specified Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/2465583e-4e78-4c15-b6be-a36cbc7c8b0f'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'activitylogsEffect\')]'
          }
          logsEnabled: {
            value: '[parameters(\'activitylogsLogsEnabled\')]' 
          }
        }
      }
    ]
  }
}
