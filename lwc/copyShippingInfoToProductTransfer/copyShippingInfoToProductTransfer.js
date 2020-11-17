import { LightningElement, api, track } from "lwc";

export default class CopyShippingInfoToProductTransfer extends LightningElement {
  _shippingInfo = {};
  _productRequestLineItems;

  @track productTransferLineItems = [];

  @api get productRequestLineItems() {
    return this._productRequestLineItems;
  }
  set productRequestLineItems(value) {
    if (value !== undefined) {
      this._productRequestLineItems = value;
      for (let item of value) {
        this.productTransferLineItems.push(Object.assign({}, item));
      }
    }
  }

  @api
  getShippingInfo() {
    return this._shippingInfo;
  }

  @api
  getSelectedLines() {
    var selectedLines = [];

    for (let item of this.productTransferLineItems) {
      if (item.Selected) {
        selectedLines.push(item);
      }
    }

    return selectedLines;
  }

  onSelectChange(event) {
    var recordId = event.target.name;
    var checked = event.target.checked;
    var productTransferLineItems = this.productTransferLineItems;

    for (let item of productTransferLineItems) {
      if (item.Id === recordId) {
        item.Selected = checked;
      }
    }
    this.productTransferLineItems = productTransferLineItems;
  }

  updateShippingInfo(event) {
    this._shippingInfo[event.target.name] = event.target.value;
  }
}