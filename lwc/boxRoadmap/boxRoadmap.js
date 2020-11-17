import { LightningElement, api, wire, track } from 'lwc'
import getBoxBPSRecord from '@salesforce/apex/BoxBPSHandler.getBoxBPSRecord'
import getFreshBoxBPSRecord from '@salesforce/apex/BoxBPSHandler.getFreshBoxBPSRecord'
import { notification } from 'c/notificationToast'
// import { refreshApex } from '@salesforce/apex'

export default class BoxRoadmap extends LightningElement {
  notification = notification
  wiredBPSResult

  @api recordId

  @track bpsRecord
  @track showLoadingSpinner = true

  @wire(getBoxBPSRecord, {'opportunityId' : '$recordId'})
  wiredBPS(result){
    this.wiredBPSResult = result
    console.log('wiredBPS')
    if (result.data) {
      console.log('wiredBPS data:', result.data)
      this.bpsRecord = result.data && result.data.Id ? result.data : undefined
      this.showLoadingSpinner = false
    } else if (result.error) {
      this.error = result.error
      // this.notification({message: error && error.body && error.body.message, title: 'Error', variant:'error', mode:'sticky'})
      this.showLoadingSpinner = false
    }
  }
  handleTemplateSuccess(event) {
    event.preventDefault()
    console.log('handleTemplateSuccess:', event.detail.bpsRecord)
    // this.showLoadingSpinner = true
    // this.bpsRecord = event.detail.bpsRecord
    return getFreshBoxBPSRecord({'opportunityId' : this.recordId}).then((res) => {
      console.log('refreshed:!')
      this.bpsRecord = res
    })
  }
}