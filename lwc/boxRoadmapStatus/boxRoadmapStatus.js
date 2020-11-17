import { LightningElement, api, wire, track } from 'lwc'
import getBoxBPSRecord from '@salesforce/apex/BoxBPSHandler.getBoxBPSRecord'
import getFreshBoxBPSRecord from '@salesforce/apex/BoxBPSHandler.getFreshBoxBPSRecord'
import { registerListener, unregisterAllListeners } from 'c/pubsub'
 
export default class BoxRoadmapStatus extends LightningElement {
  @api recordId

  @track realEstatePercent
  @track permittingPercent
  @track interconnectionPercent

  wiredBPSStatusResult

  connectedCallback() {
    // subscribe to inputChangeEvent event
    registerListener('statusUpdated', this.refreshStatus, this)
  }
  disconnectedCallback() {
    // unsubscribe from inputChangeEvent event
    unregisterAllListeners(this)
  }

  @wire(getBoxBPSRecord, {'opportunityId' : '$recordId'})
  wiredBPSRecordStatuses(result){
    this.wiredBPSStatusResult = result
    if (result.data) {
      this.mapData(result.data)
    } else if (result.error) {
      this.error = result.error
    }
  }
  
  mapData(data = {}) {
    const {
      Real_Estate_Status__c = 0, 
      Permitting_Status__c = 0, 
      Interconnection_Status__c = 0
    } = data
    
    this.realEstatePercent = Real_Estate_Status__c
    this.permittingPercent = Permitting_Status__c
    this.interconnectionPercent = Interconnection_Status__c
  }
  
  refreshStatus(params) {
    return getFreshBoxBPSRecord({'opportunityId' : this.recordId}).then(res => {
      this.mapData(res)
    })
  }

}