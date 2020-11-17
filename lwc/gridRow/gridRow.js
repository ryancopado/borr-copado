import { LightningElement, track, api } from 'lwc'
 
export default class GridRow extends LightningElement {
  @api level
  @track showArea = false
  @track isExpanded = false
  @track showAction = false
  @api rowDetails
  @api options
  
  renderedCallback() {
    if (!this.level) {
      const currentStatus = this.calculatePercentValue(this.rowDetails)
      if (!this.lastStatus || this.lastStatus !== currentStatus) {
        this.lastStatus = currentStatus
        const statusEvent = new CustomEvent('statusset', {
          detail : this.lastStatus
        })
        this.dispatchEvent(statusEvent)
      }
    }
  }

  handleToggleText() {
    this.showArea = true
    this.focusTimeout = window.setTimeout(() => {  // eslint-disable-line @lwc/lwc/no-async-operation
      this.template.querySelector(':scope lightning-textarea').focus()
      this.focusTimeout = null
    }, 300)
    
  } 

  handleTextArea() {
    let textElement = this.template.querySelector(':scope lightning-textarea')
    this.handleUpdate(Object.assign({}, this.rowDetails, {'notes' : textElement.value}))
    this.showArea = false
  }

  handleStatusChange(event) {
    this.handleUpdate(Object.assign({}, this.rowDetails, {'status' : event.detail.value}))
  }

  handleDRChange(event) {
    const drToggle = this.template.querySelector(':scope .drtoggle lightning-input')
    this.handleUpdate(Object.assign({}, this.rowDetails, {'drpush' : drToggle.checked}))
  }

  handleScheduleChange(event) {
    this.handleUpdate(Object.assign({}, this.rowDetails, {'schedule' : event.detail.value}))
  }

  handleOwnerChange(event) {
    let textElement = this.template.querySelector(':scope lightning-input[data-name="owner"]')
    this.handleUpdate(Object.assign({}, this.rowDetails, {'owner' : textElement.value}))
  }

  handleExpand() {
    this.isExpanded = !this.isExpanded
  }

  handleDeleteAction(event) {
    this.showAction = false
    const deleteEvent = new CustomEvent('deletedetail', {
      detail : this.rowDetails
    })
    this.dispatchEvent(deleteEvent)
  }

  handleToggleAction(event) {
    this.showAction = !this.showAction
    if (this.showAction) {
      this.focusTimeout = window.setTimeout(() => {  // eslint-disable-line @lwc/lwc/no-async-operation
        this.template.querySelector(':scope .actions a').focus()
        this.focusTimeout = null
      }, 300)
    }
  }

  handleUpload() {
    const uploadEvent = new CustomEvent('uploadfile', {
      detail : this.rowDetails.id
    })
    this.dispatchEvent(uploadEvent)
  }

  handleNewFolder() {
    const newFolderFileEvent = new CustomEvent('newfolder', {
      detail : this.rowDetails.id
    })
    this.dispatchEvent(newFolderFileEvent)
  }

  handleNewFile() {
    const newFolderFileEvent = new CustomEvent('newfile', {
      detail : this.rowDetails.id
    })
    this.dispatchEvent(newFolderFileEvent)
  }

  handleChildUpload(event) {
    const uploadEvent = new CustomEvent('uploadfile', {
      detail : event.detail
    })
    this.dispatchEvent(uploadEvent)
  }

  handleChildDelete(event) {
    const deleteEvent = new CustomEvent('deletedetail', {
      detail : event.detail
    })
    this.dispatchEvent(deleteEvent)
  }

  handleChildNewFolder(event) {
    const newFolderEvent = new CustomEvent('newfolder', {
      detail : event.detail
    })
    this.dispatchEvent(newFolderEvent)
  }

  handleChildNewFile(event) {
    const newFileEvent = new CustomEvent('newfile', {
      detail : event.detail
    })
    this.dispatchEvent(newFileEvent)
  }

  handleUpdate(detail) {
    const {
      drpush, 
      id, 
      name, 
      parentid, 
      status, 
      type,
      schedule,
      owner,
      notes
    } = detail

    const createEvent = new CustomEvent('updatedetails', {
      detail : {
        drpush, 
        id, 
        name, 
        parentid, 
        status, 
        type,
        schedule,
        owner,
        notes
      }
    })

    this.dispatchEvent(createEvent)
  }

  handleChildUpdate(event) {
    const childDetail = event.detail
    this.handleUpdate(childDetail)
  }

  get isFolder() {
    return this.rowDetails.type === 'folder'
  }

  get isFile() {
    return this.rowDetails.type === 'file'
  }

  get getStyle() {
    return `slds-col slds-grid slds-size_10-of-12 slds-grid_vertical-align-center nameCol ${this.level && 'offset' + this.level}`
  }

  get childLevel() {
    return this.level ? this.level < 6 ? this.level + 1 : this.level : 1
  }
  
  get getPrecentComplete() {
    return this.calculatePercentValue(this.rowDetails)
  }

  get getHasChildren() {
    return this.rowDetails.children && this.rowDetails.children.length > 0
  }

  get getRowClass() {
    return `slds-grid slds-grid_align-spread row ${this.isOverDue() && 'overdue'}`
  }

  get getLink() {
    return `https://app.box.com/${this.rowDetails.type}/${this.rowDetails.id}`
  }

  isOverDue() {
    var today = new Date()
    var scheduleDate = this.rowDetails.schedule && Date.parse(this.rowDetails.schedule)
    return scheduleDate && scheduleDate < today && this.calculatePercentValue(this.rowDetails) < 100
  }

  weightedValues = {
    notstarted: 0,
    inProgress: 50,
    complete: 100
  }

  calculatePercentValue(rowDetails) {
    const retObj = this.percentOfFolderValue(rowDetails)
    return retObj.potential ? retObj.actual >= retObj.potential ? 100 : ((retObj.actual / retObj.potential) * 100).toPrecision(2) : 0
  }

  percentOfFolderValue(rowDetails) {
    const valueObj = {
      actual: 0,
      potential: 0
    }
    if (rowDetails.type === 'file') {
      valueObj.potential = 100
      valueObj.actual = this.weightedValues[rowDetails.status]
      return valueObj
    }
    if (rowDetails.type === 'folder' && rowDetails.children) {
      return rowDetails.children.reduce((value, childDetail) => {
        const retValue = this.percentOfFolderValue(childDetail)
        value.potential += retValue.potential
        value.actual += retValue.actual
        return value
      }, valueObj)
    }
    return valueObj
  }
  
}