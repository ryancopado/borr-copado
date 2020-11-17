import { LightningElement, track, api } from 'lwc'
import deleteBoxFolder from '@salesforce/apex/BoxBPSHandler.deleteBoxFolder'
import deleteBoxFile from '@salesforce/apex/BoxBPSHandler.deleteBoxFile'  
import { notification } from 'c/notificationToast'

export default class BoxDelete extends LightningElement {
  @api detail

  @track showLoadingSpinner = false

  notification = notification

  handleCloseModal(event) {
    event.preventDefault()
    const closeEvent = new CustomEvent('closemodal')
    this.dispatchEvent(closeEvent)
  }
  handleDelete(event) {
    this.showLoadingSpinner = true
    if (this.detail.type === 'file') {
      deleteBoxFile({fileId : this.detail.id}).then(() => {
        const successEvent = new CustomEvent('delete')
        this.dispatchEvent(successEvent)
      }).catch(err => {
        this.notification({message:err && err.body && err.body.message, title: 'Error Deleting File', variant:'error', mode:'sticky'})
        this.showLoadingSpinner = false
      })
    } else if (this.detail.type === 'folder') {
      deleteBoxFolder({folderId : this.detail.id}).then(() => {
        const successEvent = new CustomEvent('delete')
        this.dispatchEvent(successEvent)
      }).catch(err => {
        this.notification({message:err && err.body && err.body.message, title: 'Error Deleting Folder', variant:'error', mode:'sticky'})
        this.showLoadingSpinner = false
      })
    }
    
  }
}