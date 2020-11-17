import { ShowToastEvent } from 'lightning/platformShowToastEvent'

function notification({message = '',title = '', variant = 'info', mode = 'dismissable'}) {
  this.dispatchEvent(new ShowToastEvent({title, message, variant, mode}))
}

export { notification }