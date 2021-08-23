targetScope = 'managementGroup'

// PARAMETERS

// VARIABLES

// OUTPUTS
output deployDiagnosticsSettingsToLogAnalytics array = [
  {
    id: deployDiagnosticsSettingsForACIToLogAnalytics.outputs.policyID
    name: deployDiagnosticsSettingsForACIToLogAnalytics.outputs.policyName
    policyDisplayName:  deployDiagnosticsSettingsForACIToLogAnalytics.outputs.policyDisplayName
  }
  {
    id: deployDiagnosticsSettingsForACRToLogAnalytics.outputs.policyID
    name: deployDiagnosticsSettingsForACRToLogAnalytics.outputs.policyName
    policyDisplayName:  deployDiagnosticsSettingsForACRToLogAnalytics.outputs.policyDisplayName
  }  
]

// RESOURCES
module deployDiagnosticsSettingsForACIToLogAnalytics 'deploy-diagnostics-settings-for-aci-to-loganalytics.bicep' = {
  name: 'deployDiagnosticsSettingsForACIToLogAnalytics'
}

module deployDiagnosticsSettingsForACRToLogAnalytics 'deploy-diagnostics-settings-for-acr-to-loganalytics.bicep' = {
  name: 'deployDiagnosticsSettingsForACRToLogAnalytics'
}
