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
]

// RESOURCES
module deployDiagnosticsSettingsForACIToLogAnalytics 'deployDiagnosticsSettingsForACIToLogAnalytics.bicep' = {
  name: 'deployDiagnosticsSettingsForACIToLogAnalytics'
}
