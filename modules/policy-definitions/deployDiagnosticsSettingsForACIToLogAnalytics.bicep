targetScope = 'managementGroup'

// PARAMETERS
param policySource string = 'Bicep'

// VARIABLES
var guid = '6eb49361-4964-401a-b0bb-fa7f77b30baf'
var displayName = 'Deploy Diagnostic Settings for Azure Container Instances to Log Analytics workspace (CloudBlox™)'
var description = 'Deploys the diagnostic settings for Azure Container Instances to stream to a regional Log Analytics workspace when any Azure Container Instances which is missing these diagnostic settings is created or updated.'
var policyCategory = 'CloudBlox™ - Monitoring (CaC)'
var version = '0.1.0'
var resourceType = 'Microsoft.ContainerInstance/containerGroups'

// OUTPUTS
output policyID string = policy.id
output policyName string = policy.name
output policyDisplayName string = policy.properties.displayName

// RESOURCES
resource policy 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: guid
  properties: {
    displayName: displayName
    policyType: 'Custom'
    mode: 'Indexed'
    description: description
    metadata: {
      version: version
      category: policyCategory
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
      effect: {
          type: 'String'
          metadata: {
            displayName: 'Effect'
            description: 'Enable or disable the execution of the policy'
          }
          allowedValues: [
            'DeployIfNotExists'
            'Disabled'
          ]
          defaultValue: 'DeployIfNotExists'
        }
        profileName: {
          type: 'String'
          metadata: {
            displayName: 'Profile name'
            description: 'The diagnostic settings profile name'
          }
          defaultValue: 'setbypolicy_logAnalytics'
        }      
        metricsEnabled: {
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
        logsEnabled: {
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
    policyRule: {
      if: {
        field: 'type'
        equals: resourceType
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          type: 'Microsoft.Insights/diagnosticSettings'
          name: '[parameters(\'profileName\')]'
          existenceCondition: {
            allOf: [
              {
                field: 'Microsoft.Insights/diagnosticSettings/metrics.enabled'
                equals: '[parameters(\'metricsEnabled\')]'
              }
              {
                field: 'Microsoft.Insights/diagnosticSettings/workspaceId'
                equals: '[parameters(\'logAnalytics\')]'
              }
            ]
          }
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
          ]
          deployment: {
            properties: {
              mode: 'incremental'
              template: {
                '$schema': 'http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  resourceName: {
                    type: 'string'
                  }
                  location: {
                    type: 'string'
                  }
                  logAnalytics: {
                    type: 'string'
                  }
                  metricsEnabled: {
                    type: 'string'
                  }
                  logsEnabled: {
                    type: 'string'
                  }
                  profileName: {
                    type: 'string'
                  }
                }
                variables: {}
                resources: [
                  {
                    type: '${resourceType}/providers/diagnosticSettings'
                    apiVersion: '2017-05-01-preview'
                    name: '[concat(parameters(\'resourceName\'), \'/\', \'Microsoft.Insights/\', parameters(\'profileName\'))]'
                    location: '[parameters(\'location\')]'
                    dependsOn: []
                    properties: {
                      workspaceId: '[parameters(\'logAnalytics\')]'
                      metrics: [
                        {
                          category: 'AllMetrics'
                          enabled: '[parameters(\'metricsEnabled\')]'
                          retentionPolicy: {
                            enabled: false
                            days: 0
                          }
                          timeGrain: null
                        }
                      ]
                    }
                  }
                ]
                outputs: {}
              }
              parameters: {
                location: {
                  value: '[field(\'location\')]'
                }
                resourceName: {
                  value: '[field(\'name\')]'
                }
                logAnalytics: {
                  value: '[parameters(\'logAnalytics\')]'
                }
                metricsEnabled: {
                  value: '[parameters(\'metricsEnabled\')]'
                }
                logsEnabled: {
                  value: '[parameters(\'logsEnabled\')]'
                }
                profileName: {
                  value: '[parameters(\'profileName\')]'
                }
              }
            }
          }
        }
      }
    }
  }
}
