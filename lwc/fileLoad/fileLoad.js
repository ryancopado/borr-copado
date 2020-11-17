import { LightningElement, track, api } from 'lwc'
// import updateFile from '@salesforce/apex/BoxBPSHandler.updateFile'
// import createFile from '@salesforce/apex/BoxBPSHandler.createFile'
import newFileResponse from '@salesforce/apex/BoxBPSHandler.newFileResponse'
import scopedAccessToken from '@salesforce/apex/BoxBPSHandler.scopedAccessToken'
import { notification } from 'c/notificationToast'

export default class FileLoad extends LightningElement {
  @api 
  set fileName(value) {
    this.uploadFileName = value.substring(0,value.lastIndexOf('.')).trim()
    this._fileName = value
  }
  get fileName() {
    return this._fileName
  }
  
  @api fileId
  @api parentId
  
  @track showLoadingSpinner = false
  @track uploadFileName
  @track fileEnd
  @track filesUploaded = []
  MAX_FILE_SIZE = 52428800 // 50MB
  _fileName
  fileContents
  fileReader
  content
  notification = notification

  handleFilesChange(event) {
    if (event.target.files.length > 0) {
      this.filesUploaded = event.target.files
      const targetFileName =  event.target.files[0].name
      const strLength = targetFileName.length
      const dotLoc = targetFileName.lastIndexOf('.')
      if (dotLoc > 0 && dotLoc < strLength) {
        this.fileEnd =  targetFileName.substring(dotLoc)
      } else {
        this.fileEnd = undefined
      }
      // this.notification({message: `Size: ${this.filesUploaded[0].size / 1024 / 1024}`,title: 'FileSize',})
      
    } else {
      this.fileEnd = undefined
    }
  }

  get canSetName() {
    return !(this.fileId || (this.filesUploaded && this.filesUploaded.length > 1))
  }
  
  handleCloseModal(event) {
    event.preventDefault()
    const closeEvent = new CustomEvent('closemodal')
    this.dispatchEvent(closeEvent)
  }

  handleFileName(event) {
    event.preventDefault()
    this.uploadFileName = event.target.value
  }

  handleSave(event) {
    event.preventDefault()
    if (this.filesUploaded.length > 0) {
      this.uploadHelper()
    }
    else {
      this.notification({message: 'Please select file to upload!',title: 'Error',variant: 'error'})
    }
  }

  uploadHelper() {
    
    const fileOverMax = [...this.filesUploaded].reduce((limit, file) => {
      if (file.size > this.MAX_FILE_SIZE) {
        this.notification({message: `Max File Size : ${this.MAX_FILE_SIZE / 1024 / 1024}, Current File: ${this.filesUploaded[0].size / 1024 / 1024}`,title: 'Unable to load file.',variant: 'error'})
        limit = true
      }
      return limit
    }, false)

    if (fileOverMax) {
      return
    }
    this.showLoadingSpinner = true
    
    this.saveToFile()

  }

  saveToFile() {
    // get upload file scopped access token  
    scopedAccessToken().then(token => {
      let formData = new FormData() //attributes='{"name":"Photo.jpg", "parent":{"id":"11446498"}}'
      if (this.fileId) {
        //update single file
        formData.append('attributes', '{"name":"'+ this.uploadFileName + this.fileEnd + '"}')
        formData.append('file', this.filesUploaded[0], this.uploadFileName + this.fileEnd)
        return this.calloutBox({endpoint: `https://upload.box.com/api/2.0/files/${this.fileId}/content`, type: 'POST', body: formData, token}).then(res => {
          const responseObj = JSON.parse(res)
          if (responseObj && responseObj.entries && responseObj.entries.length) {
            this.notification({message: 'Id: ' + responseObj.entries[0].id, title: 'Save Success', variant: 'success'})
            const loadEvent = new CustomEvent('fileloaded')
            this.dispatchEvent(loadEvent)
          }
        })
      }
      //new file
      if (this.filesUploaded.length == 1) {
        formData.append('attributes', '{"name":"'+ this.uploadFileName + this.fileEnd + '", "parent":{"id":"'+ this.parentId + '"}}')
        formData.append('file', this.filesUploaded[0], this.uploadFileName + this.fileEnd)
        return this.calloutBox({endpoint: 'https://upload.box.com/api/2.0/files/content', type: 'POST', body: formData, token}).then(res => {
          return newFileResponse({parentId: this.parentId, responseString: res}).then(folderentry => {
            this.notification({message: 'Id: ' + folderentry.id ,title: 'Save Success',variant: 'success'})
            const loadEvent = new CustomEvent('filecreated', {detail: {folderentry}})
            this.dispatchEvent(loadEvent)
          })
        })
      }
      const calloutArray = [...this.filesUploaded].map(file => {
        let formData = new FormData()
        formData.append('attributes', '{"name":"'+ file.name + '", "parent":{"id":"'+ this.parentId + '"}}')
        formData.append('file', file, file.name)
        return this.calloutBox({endpoint: 'https://upload.box.com/api/2.0/files/content', type: 'POST', body: formData, token}).then(res => {
            return newFileResponse({parentId: this.parentId, responseString: res})
        })
      })
      return Promise.all(calloutArray).then(folderentryarray => {
        const entryIds = folderentryarray.map(folderentry => {
          return folderentry.id
        })
        this.notification({message: 'Ids: ' + JSON.stringify(entryIds) ,title: 'Save Success',variant: 'success'})
        const loadEvent = new CustomEvent('filecreated', {detail: {folderentryarray}})
        this.dispatchEvent(loadEvent)
      })
      
    }).catch(err => {
      this.notification({message: err.message || err, title: 'Save Error', variant: 'error'})
      console.error('err: ', err) // eslint-disable-line no-console
    }).finally(() => {
      this.showLoadingSpinner = false
    })
  }

  calloutBox({endpoint, type, body, token}) {
    return new Promise((resolve,reject) => {
      var xmlhttp = new XMLHttpRequest()
      xmlhttp.addEventListener("load", () => {
        if (xmlhttp.status >= 200 && xmlhttp.status < 300) {
          resolve(xmlhttp.response)
        }
        reject(JSON.parse(xmlhttp.response))
      })
      xmlhttp.addEventListener("error", loadEvt => {
        reject('failed:' + loadEvt)
      })
      xmlhttp.open(type, endpoint)
      xmlhttp.setRequestHeader("Authorization", "Bearer " + token)
      if (type === 'Put') {
        xmlhttp.setRequestHeader("Content-Type", "multipart/form-data")
      }
      xmlhttp.send(body ? body : undefined)
    })
  }

  get disableSave() {
    return !((this.filesUploaded.length > 0 && this.uploadFileName) || this.filesUploaded.length > 1)
  }
}