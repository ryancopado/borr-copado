({
  initializeLists : function(cmp) {
    var caseId = cmp.get('v.recordId')
    var relatedWork = this.getRelatedWork(cmp, caseId)
    var relatedWordOrder = this.getRelatedWorkOrders(cmp, caseId)
    cmp.set('v.workList', null)
    cmp.set('v.workOrderList', null)
    console.log('init')
    Promise.all([relatedWork,relatedWordOrder]).then( resArray => {
      if (resArray[0]) {
        var workWrapper = resArray[0].map(arrayObj => {
          console.log('obj ', arrayObj)
          return Object.assign(
            {
              workUrl : '/' + arrayObj['Id'], 
              assetUrl : '/' + arrayObj['Asset__c'], 
              assetName : arrayObj['Asset__r'] ? arrayObj['Asset__r']['Name'] : null,
              projectUrl : '/' + arrayObj['Project__c'], 
              projectName : arrayObj['Project__r'] ? arrayObj['Project__r']['Name'] : null, 
              contractUrl : arrayObj['Contract__c'] ? '/' + arrayObj['Contract__c'] : null,  
              contractNumber : arrayObj['Contract__r'] ? arrayObj['Contract__r']['ContractNumber'] : null
            }, arrayObj
          )
        })
        workWrapper = workWrapper && workWrapper.length > 0 ? workWrapper : null
        console.log('workWrapper ',workWrapper)
        cmp.set('v.workList', workWrapper)
      }
      if (resArray[1]){
        var workOrderList = resArray[1]
        workOrderList = workOrderList && workOrderList.length > 0 ? workOrderList : null
        console.log('WorkOrders ',workOrderList)
        if (workOrderList && workOrderList.length == 1) {
          // set as selected work order and lock picklist
          cmp.set('v.readonlyWO', "true")
          cmp.set('v.selectedValue', workOrderList[0].Id)
        }
        cmp.set('v.workOrderList', workOrderList)
      }
    }).catch(err => console.error('init res error: ', err))
  },
  getRelatedWork : function(cmp, caseId) {
    return this.controllerCallout(cmp, "c.getCaseRelatedWork", {caseId : caseId})
  },
  getRelatedWorkOrders : function(cmp, caseId) {
    return this.controllerCallout(cmp, "c.getCaseRelatedWorkOrders", {caseId : caseId})
  },
  createWorkOrderItems : function(cmp, caseId, workOrderId, pendingWorkIds) {
    return this.controllerCallout(cmp, "c.createWorkOrderLineItems", {caseId : caseId, workOrderId : workOrderId, pendingWorkIds : pendingWorkIds})
  },
  controllerCallout : function(cmp, cFunction, params) {
    return new Promise($A.getCallback((resolve,reject) => {
      var action = cmp.get(cFunction)
      params && action.setParams(params)
      action.setCallback(this, (response,event) => {
        var state = response.getState()
        if (state === "SUCCESS") {
          resolve(response.getReturnValue())
        }
        else {
          reject(event)
        }
      })
      $A.enqueueAction(action)
    }))
  },
})