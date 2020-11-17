({
  doInit : function(cmp, event, helper) {
    cmp.set('v.columns', [
      {label: 'Pending Work', fieldName: 'workUrl', type: 'url', typeAttributes: { label: {fieldName: 'Name'}}},
      {label: 'Asset', fieldName: 'assetUrl', type: 'url', typeAttributes: { label: {fieldName: 'assetName'}}},
      {label: 'Project', fieldName: 'projectUrl', type: 'url', typeAttributes: { label: {fieldName: 'projectName'}}},
      {label: 'Description of Pending Work', fieldName: 'Description_of_Pending_Work__c', type: 'text', initialWidth : 400},
      {label: 'Contract', fieldName: 'contractUrl', type: 'url', typeAttributes: { label: {fieldName: 'contractNumber'}}}
    ])
   helper.initializeLists(cmp)
  },
  addToWorkOrder : function(cmp, event, helper) {
    var workTable = cmp.find('workTable')
    var selectedRows = workTable.getSelectedRows()
    var pendingIds = selectedRows && selectedRows.length > 0 ? selectedRows.map(row => row.Id) : null
    var workOrderId = cmp.get('v.selectedValue')
    console.log('workOrderId', workOrderId)
    var caseId = cmp.get('v.recordId')
    if (caseId && workOrderId && pendingIds) {
      console.log('callhelper: ' + caseId + ', ' + workOrderId + ', ', pendingIds)
      helper.createWorkOrderItems(cmp, caseId, workOrderId, pendingIds).then(res => {

      }).catch(err => console.error('init res error: ', err)).then(res => {
        helper.initializeLists(cmp)
      })
    }
    
  }
})