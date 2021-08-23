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
  '${tenantResourceId('Microsoft.Management/managementGroups', managementGroupId)}${tenantResourceId('Microsoft.Authorization/policySetDefinitions', monitoringCaCDiagSetLAGovernanceInitiative.name)}' 
]
output initiativeNames array = [
  monitoringCaCDiagSetLAGovernanceInitiative.name
]

// RESOURCES

// Initiativ monitoring Compliance as Code (CaC) - diagnostic settings to log analytics
resource monitoringCaCDiagSetLAGovernanceInitiative 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: 'monitoringCaCDiagSetLAGovernanceInitiative'
  properties: {
    displayName: 'Diagnostic Settings to Log Analytics Monitoring Compliance As Code (CaC) Governance'
    policyType: 'Custom'
    description: 'The CloudBlox™ Governance Diagnostic Settings to Log Analytics Monitoring Compliance As Code (CaC) Governance Initiative'
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
      // ACI
      // ACR
      // ActivityLogs  
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
        defaultValue: 'DeployIfNotExists'        
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
      // AKS
      // AnalysisService
      // APIMgmt
      // ApplicationGateway
      // AutomationAccount
      // BatchAccount
      batchAccountEffect: {
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
      batchAccountMetricsEnabled: {
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
      batchAccountLogsEnabled: {
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
      // CDNEndpoints
      // CognitiveServices
      // CosmosDB
      // DataBricks
      // DataFactory
      // DataLakeAnalytics          
      datalakeAnalyticsEffect: {
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
      datalakeAnalyticsMetricsEnabled: {
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
      datalakeAnalyticsLogsEnabled: {
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
      // DataLakeStore   
      datalakeStoreEffect: {
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
      datalakeStoreMetricsEnabled: {
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
      datalakeStoreLogsEnabled: {
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
      // EventGridSubscription
      // EventGridSystemTopics
      // EventGridTopic
      // EventHub
      eventHubEffect: {
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
      eventHubMetricsEnabled: {
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
      eventHubLogsEnabled: {
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
      // ExpressRoute
      // FireWall
      // FrontDoor
      // HDInsight
      // IoTHub
      // KeyVault
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
        defaultValue: 'DeployIfNotExists'        
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
      // LoadBalancer
      // LogicAppsWF
      logicAppsWfEffect: {
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
      logicAppsWfMetricsEnabled: {
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
      logicAppsWfLogsEnabled: {
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
      // MariaDB
      // MLWorkspace
      // MySQL
      // NSG
      // NIC
      // PostgressSQL
      // PowerBIEmbedded
      // PublicIP
      // RecoveryVault
      recoveryVaultTagName: {
        type: 'String'
        metadata: {
          displayName: 'Exclusion Tag Name'
          description: 'Name of the tag to use for excluding vaults from this policy. This should be used along with the Exclusion Tag Value parameter.'
        }
        defaultValue: ''
      }
      recoveryVaultTagValue: {
        type: 'String'
        metadata: {
          displayName: 'Exclusion Tag Value'
          description: 'Value of the tag to use for excluding vaults from this policy. This should be used along with the Exclusion Tag Name parameter.'
        }
        defaultValue: ''
      }     
      // RedisCache
      // Realy
      // SearchService
      searchServicesEffect: {
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
      searchServicesMetricsEnabled: {
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
      searchServicesLogsEnabled: {
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
      // ServiceBus
      serviceBusEffect: {
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
      serviceBusMetricsEnabled: {
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
      serviceBusLogsEnabled: {
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
      // Signalr
      // SQLDB
      // SQLElasticpools
      // SQLManagedInstance
      // StorageAccount
      // StreamAnalytics   
      streamAnalyticsEffect: {
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
      streamAnalyticsMetricsEnabled: {
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
      streamAnalyticsLogsEnabled: {
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
      // TrafficManager
      // VNET
      // VM
      // VMSS
      // VNETGw
      // Webserverfarms
      // WebSiteAppService
      // WebSiteFunctionApp
      // WVDAppgroup
      // WVDHostPools
      // WVWorkSpace         
       
      
/*
      logicAppsWfEffect: {
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
      logicAppsWfMetricsEnabled: {
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
     logicAppsWfLogsEnabled: {
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
*/      

    }
 
    policyDefinitions: [
      // ACI
      // ACR
      // ActivityLogs
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
      // AKS
      // AnalysisService
      // APIMgmt
      // ApplicationGateway
      // AutomationAccount
      // BatchAccount
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Batch Account to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/c84e5349-db6d-4769-805e-e14037dab9b5'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'batchAccountEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'batchAccountMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'batchAccountLogsEnabled\')]'
          }
        }
      }          
      // CDNEndpoints
      // CognitiveServices
      // CosmosDB
      // DataBricks
      // DataFactory
      // DataLakeAnalytics  
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Data Lake Analytics to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d56a5a7c-72d7-42bc-8ceb-3baf4c0eae03'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'datalakeAnalyticsEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'datalakeAnalyticsMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'datalakeAnalyticsLogsEnabled\')]'
          }
        }
      }            
      // DataLakeStore
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Data Lake Storage Gen1 to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/25763a0a-5783-4f14-969e-79d4933eb74b'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'datalakeStoreEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'datalakeStoreMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'datalakeStoreLogsEnabled\')]'
          }
        }
      }        
      // EventGridSubscription
      // EventGridSystemTopics
      // EventGridTopic
      // EventHub
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Event Hub to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/1f6e93e8-6b31-41b1-83f6-36e449a42579'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'eventHubEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'eventHubMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'eventHubLogsEnabled\')]'
          }
        }
      }      
      // ExpressRoute
      // FireWall
      // FrontDoor
      // HDInsight
      // IoTHub
      // KeyVault
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
      // LoadBalancer
      // LogicAppsWF
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Logic Apps to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/b889a06c-ec72-4b03-910a-cb169ee18721'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'logicAppsWfEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'logicAppsWfMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'logicAppsWfLogsEnabled\')]'
          }
        }
      }       
      // MariaDB
      // MLWorkspace
      // MySQL
      // NSG

      // NIC
      // PostgressSQL
      // PowerBIEmbedded
      // PublicIP
      // RecoveryVault
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Recovery Services Vault to Log Analytics workspace for resource specific categories.'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/c717fb0c-d118-4c43-ab3d-ece30ac81fb3'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          tagName: {
            value: '[parameters(\'recoveryVaultTagName\')]'
          }
          tagValue: {
            value: '[parameters(\'recoveryVaultTagValue\')]' 
          }
        }
      }          
      // RedisCache
      // Realy
      // SearchService
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Search Services to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/08ba64b8-738f-4918-9686-730d2ed79c7d'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'searchServicesEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'searchServicesMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'searchServicesLogsEnabled\')]'
          }
        }
      }      
      // ServiceBus
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Service Bus to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/04d53d87-841c-4f23-8a5b-21564380b55e'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'serviceBusEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'serviceBusMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'serviceBusLogsEnabled\')]'
          }
        }
      }      
      // Signalr
      // SQLDB
      // ???
      // SQLElasticpools
      // SQLManagedInstance
      // StorageAccount
      // StreamAnalytics
      {
        policyDefinitionReferenceId: 'Deploy Diagnostic Settings for Stream Analytics to Log Analytics workspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/237e0f7e-b0e8-4ec4-ad46-8c12cb66d673'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'streamAnalyticsEffect\')]'
          }
          metricsEnabled: {
            value: '[parameters(\'streamAnalyticsMetricsEnabled\')]' 
          }
          logsEnabled: {
            value: '[parameters(\'streamAnalyticsLogsEnabled\')]'
          }
        }
      }      
      // TimerSeriesInsights
      // TrafficManager
      // VNET
      // VM
      // VMSS
      // VNETGw
      // Webserverfarms
      // WebSiteAppService
      // WebSiteFunctionApp
      // WVDAppgroup
      // WVDHostPools
      // WVWorkSpace 
    ]

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

  }
}
