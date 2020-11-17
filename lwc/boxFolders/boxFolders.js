import { LightningElement, api, track, wire } from 'lwc'
import { notification } from 'c/notificationToast'
import getFoldersAndFiles from '@salesforce/apex/BoxBPSHandler.getFoldersAndFiles' 
import updateFolderEntry from '@salesforce/apex/BoxBPSHandler.updateFolderEntry' 
import updateRealEstate from '@salesforce/apex/BoxBPSHandler.updateRealEstate' 
import updatePermitting from '@salesforce/apex/BoxBPSHandler.updatePermitting' 
import updateInterconnection from '@salesforce/apex/BoxBPSHandler.updateInterconnection' 
import { fireEvent } from 'c/pubsub'

export default class BoxFolders extends LightningElement {
  get options() {
    return [
      { label: 'Not Started', value: 'notstarted' },
      { label: 'In Progress', value: 'inProgress' },
      { label: 'Complete', value: 'complete' },
    ]
  }
  get newOptions() {
    return [
      { label: 'New Folder', value: 'newfolder' },
      { label: 'New File', value: 'newfile' }
    ]
  }

  @api recordId
  @api boxfolderId

  @track showLoadingSpinner = true
  @track rowDetails
  @track selectRow
  @track createFile = false
  @track updateFile = false
  @track createFolder = false
  @track deleteDetail = false

  notification = notification

  @wire(getFoldersAndFiles, {'opportunityId' : '$recordId'})
  wiredFoldersAndFiles({data, error}){
    if (data) {
      this.rowDetails = JSON.parse(JSON.stringify(data))
      this.showLoadingSpinner = false
    } else if (error) {
      this.error = error
      this.notification({message:error && error.body && error.body.message, title: 'Error Loading Table', variant:'error', mode:'sticky'})
      this.showLoadingSpinner = false
    }
  }

  handleDetailUpdate(event) {
    const detail = JSON.parse(JSON.stringify(event.detail))
    let row = this.searchDetails(detail.id, this.rowDetails)
    row = Object.assign(row, detail)
    // this should be some sorta queue ...
    updateFolderEntry({opportunityId: this.recordId, folderEntryString: JSON.stringify([row])}).then(() => {
      // this.notification({message: res,title: 'Save Success',variant: 'success'})
    }).catch(err => {
      this.notification({message: err,title: 'Save Error',variant: 'error'})
    })
  }
  handleDeleteEvent(event) {
    let row = this.searchDetails(event.detail.id, this.rowDetails)
    this.selectRow = row
    this.deleteDetail = true
  }
  handleBoxDelete(event) {
    const deletedRow = this.selectRow
    if (!this.rowDetails.find(row => row.id === deletedRow.id)) {
      let parentDetail = this.searchDetails(deletedRow.parentid, this.rowDetails)
      parentDetail.children = parentDetail.children.filter(row => row.id !== deletedRow.id)
    }
    this.handleCloseUpload()
  }
  handleCloseUpload() {
    this.selectRow = undefined
    this.updateFile = false
    this.createFile = false
    this.createFolder = false
    this.deleteDetail = false
  }
  
  handleUpload(event) {
    const uploadRow = event.detail
    const row = this.searchDetails(uploadRow, this.rowDetails)
    this.selectRow = row || uploadRow
    this.updateFile = true
  }
  
  handleNewFolder(event) {
    const uploadNew = JSON.parse(JSON.stringify(event.detail))
    const row = this.searchDetails(uploadNew, this.rowDetails)
    this.selectRow = row || uploadNew
    this.createFolder = true
  }
  handleNewFile(event) {
    const uploadNew = JSON.parse(JSON.stringify(event.detail))
    const row = this.searchDetails(uploadNew, this.rowDetails)
    this.selectRow = row || uploadNew
    this.createFile = true
  }
  handleFileUpdate(event) {
    event.preventDefault()
    const updatedRow = this.selectRow
    updatedRow.status = updatedRow.status === 'notstarted' ? 'inProgress' : updatedRow.status
    updateFolderEntry({opportunityId: this.recordId, folderEntryString: JSON.stringify([updatedRow])}).then(() => {
      // this.notification({message: res,title: 'Save Success',variant: 'success'})
    }).catch(err => {
      this.notification({message: err, title: 'Save File Error',variant: 'error'})
    })
    this.handleCloseUpload()
  }
  handleFileCreate(event) {
    if (event.detail.folderentry) {
      const returnFolderentry = JSON.parse(JSON.stringify(event.detail.folderentry))
      const folderentry = returnFolderentry
      folderentry.status = 'inProgress'
      let rowParent = this.searchDetails(folderentry.parentid, this.rowDetails)
      rowParent.children = rowParent.children ? rowParent.children.concat(folderentry) : [folderentry]
      updateFolderEntry({opportunityId: this.recordId, folderEntryString: JSON.stringify([folderentry])}).then(res => {
        // this.notification({message: res,title: 'Save Success',variant: 'success'})
      }).catch(err => {
        this.notification({message: err, title: 'Create File Error',variant: 'error'})
      })
      this.handleCloseUpload()
    } else if (event.detail.folderentryarray) {
      const folderentryarray = JSON.parse(JSON.stringify(event.detail.folderentryarray))
      folderentryarray.forEach(folderentry => {
        folderentry.status = 'inProgress'
        let rowParent = this.searchDetails(folderentry.parentid, this.rowDetails)
        rowParent.children = rowParent.children ? rowParent.children.concat(folderentry) : [folderentry]
        updateFolderEntry({opportunityId: this.recordId, folderEntryString: JSON.stringify([folderentry])}).then(res => {
          // this.notification({message: res,title: 'Save Success',variant: 'success'})
        }).catch(err => {
          this.notification({message: err, title: 'Create File Error',variant: 'error'})
        })
      })
      this.handleCloseUpload()
    }
  }
  handleFolderCreate(event) {
    const folderentry = JSON.parse(JSON.stringify(event.detail.folderentry))
    let rowParent = this.searchDetails(folderentry.parentid, this.rowDetails)
    rowParent.children = rowParent.children ? rowParent.children.concat(folderentry) : [folderentry]
    updateFolderEntry({opportunityId: this.recordId, folderEntryString: JSON.stringify([folderentry])}).then(() => {
      // this.notification({message: res,title: 'Save Success',variant: 'success'})
    }).catch(err => {
      this.notification({message: err, title: 'Folder Create Error',variant: 'error'})
    })
    this.handleCloseUpload()
  }
  handlefolderStatus(event) {
    const folderentry = event.detail
    // need to take key and update the status field on the box record
    const statusRow = this.rowDetails.find(row => row.id === event.currentTarget.dataset.key)
    if (statusRow) {
      if (statusRow.name && statusRow.name.toLowerCase().includes('real estate')) {
        updateRealEstate({opportunityId: this.recordId, status: folderentry}).then(() => {
          fireEvent(this.pageRef, 'statusUpdated', folderentry)
        })
      }
      if (statusRow.name && statusRow.name.toLowerCase().includes('permitting & engineer')) {
        updatePermitting({opportunityId: this.recordId, status: folderentry}).then(() => {
          fireEvent(this.pageRef, 'statusUpdated', folderentry)
        })
      }
      if (statusRow.name && statusRow.name.toLowerCase().includes('interconnection & revenue')) {
        updateInterconnection({opportunityId: this.recordId, status: folderentry}).then(() => {
          fireEvent(this.pageRef, 'statusUpdated', folderentry)
        })
      }
    }
  }

  searchDetails(rowId, detailsArray) {
    const stack = [...detailsArray]
    while (stack.length) {
      const row = stack.pop()
      if (row.id === rowId) {
        return row
      }
      if (row.children) {
        stack.push(...row.children)
      }
    }
    return null // stack.pop() || null
  }

}