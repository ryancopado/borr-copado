import { LightningElement, api, track, wire } from 'lwc'
import getTemplateFolders from '@salesforce/apex/BoxBPSHandler.getTemplateFolders'
import getOpportunityBoxFrup from '@salesforce/apex/BoxBPSHandler.getOpportunityBoxFrup'
import cloneTemplateFolder from '@salesforce/apex/BoxBPSHandler.cloneTemplateFolder'
import canManuallySetFRUP from '@salesforce/apex/BoxBPSHandler.canManuallySetFRUP'
import createBoxBPSRecord from '@salesforce/apex/BoxBPSHandler.createBoxBPSRecord'
import { notification } from 'c/notificationToast'

export default class BoxTemplates extends LightningElement {
  @api recordId

  @track templateId
  @track templateName
  @track templateFolders
  @track boxOppFolderId
  @track error
  @track showLoadingSpinner = false
  @track setFrup = false

  notification = notification
  
  @wire(canManuallySetFRUP)
  wiredSetFrup({data, error}){
    if (data) {
      this.setFrup = data
    } else if (error) {
      this.error = error
    }
  }

  @wire(getTemplateFolders)
  wiredTemplateFolders({data, error}){
    if (data) {
      this.templateFolders = data
    } else if (error) {
      this.error = error
      this.notification({message:error.body.message, variant:'error', title: 'Error with Box Templates', mode:'sticky'})
    }
  }
  @wire(getOpportunityBoxFrup, {'opportunityId' : '$recordId'})
  wiredBoxFolder({data, error}){
    if (data) {
      this.boxOppFolderId = data.box__Folder_ID__c
      this.boxOppFrupId = data.Id
    } else if (error) {
      this.error = error
      this.notification({message:error.body.message, variant:'error', title: 'Unable to find Base Box Opportunity Folder', mode:'sticky'})
    }
  }

  handleChange(event) {
    this.templateId = event.detail.value
    const folder = this.templateFolders.find(row => row.value === this.templateId)
    this.templateName = folder.label
  }
  handleFRUP(event) {
    this.boxOppFolderId = event.detail.value 
  }

  handleClone(event) {
    event.preventDefault()
    this.showLoadingSpinner = true
    cloneTemplateFolder({templateId : this.templateId, opportunityFolderId : this.boxOppFolderId}).then(res => {
      this.bpsId = res.id
      return createBoxBPSRecord({opportunityId: this.recordId, folderId: res.id, templateId: this.templateId, templateName: this.templateName})
    }).then((res) => {
      this.templateId = null
      this.notification({message:'New folder Id: ' + this.bpsId, variant:'success', title: 'Success'})
      const successEvent = new CustomEvent('templatesuccess', {detail: {bpsRecord : res}})
      this.dispatchEvent(successEvent)
    }).catch(err => {
      this.notification({message:err.body.message, variant:'error', title: 'Error cloning from Template'})
    }).finally(() => {
      this.showLoadingSpinner = false
    })
  }
  get canOverwriteFrup() {

  }
  get getDisabled() {
    return !(this.boxOppFolderId && this.templateId)
  }
}