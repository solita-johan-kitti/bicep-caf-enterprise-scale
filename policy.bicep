targetScope = 'managementGroup'

// PARAMETERS
//@description('The management group to deploy (scope) to')
//param managementGroupName string

param policySource string = 'https://github.com/solita-johan-kitti/bicep-caf-enterprise-scale'
param assignmentEnforcementMode string = 'Default'
@allowed([
  'westeurope'
  'northeurope'
])
@description('Assignment Identity Location')
param assignmentIdentityLocation string = 'westeurope'

// VARIABLES

// OUTPUTS

// RESOURCES
// outputs here can be consumed by an .azcli script to delete deployed resources
output resourceNamesForCleanup array = [
  initiatives.outputs.initiativeNames
  assignments.outputs.assignmentNames
  //definitions.outputs.monitoringGovernancePolicies
]

module initiatives 'modules/policy-initiatives/initiatives.bicep' = {
  scope: managementGroup() 
  name: 'initiatives'
  params:{
    policySource: policySource
  }
}

module assignments 'modules/policy-assignments/assignments.bicep' = {
  scope: managementGroup() 
  name: 'assignments'
  params: {
    policySource: policySource
    assignmentIdentityLocation: assignmentIdentityLocation
    assignmentEnforcementMode: assignmentEnforcementMode
    monitoringGovernanceID: initiatives.outputs.initiativeIDs[0]
  }  
}
