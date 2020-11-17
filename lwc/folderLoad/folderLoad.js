import { LightningElement, track, api } from 'lwc'
import createFolder from '@salesforce/apex/BoxBPSHandler.createFolder'
import { notification } from 'c/notificationToast'

export default class FolderLoad extends LightningElement {
  @api parentId

  @track showLoadingSpinner = false
  @track uploadFolderName
  notification = notification

  handleCloseModal(event) {
    event.preventDefault()
    const closeEvent = new CustomEvent('closemodal')
    this.dispatchEvent(closeEvent)
  }
  handleFolderName(event) {
    event.preventDefault()
    this.uploadFolderName = event.target.value
  }
  handleSave(event) {
    event.preventDefault()
    createFolder({folderName: this.uploadFolderName, parentFolderId: this.parentId}).then(res => {
      this.notification({message: 'Id: ' + res.id, title: 'Save Success', variant: 'success'})
      const createEvent = new CustomEvent('foldercreated', {detail: {folderentry : res}})
      this.dispatchEvent(createEvent)
      this.showLoadingSpinner = false
    }).catch(err => {
      console.log('err', JSON.stringify(err))
      this.notification({message: (err.body && err.body.message) || err,title: 'Save Error',variant: 'error'})
      this.showLoadingSpinner = false
    })
  }
  get disableSave() {
    return !(this.parentId && this.uploadFolderName)
  }
}