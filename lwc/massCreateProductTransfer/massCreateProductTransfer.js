import { LightningElement, api, track, wire } from "lwc";
import getProductRequest from "@salesforce/apex/MassCreateProductTransferController.getProductRequest";

export default class MassCreateProductTransfer extends LightningElement {
  productTransferDetail = {};

  @api recordId;

  @track loaded = false;
  @track showDetails = false;
  @track showLines = false;

  @wire(getProductRequest, { productRequestId: "$recordId" })
  wiredProductRequest({ data, error }) {
    if (data) {
      this.productTransferDetail = data;
    } else {
      console.log(error);
    }
  }

  connectedCallback() {
    this.loaded = true;
    this.showDetails = true;
  }

  handleCancel() {
    this.dispatchEvent(new CustomEvent("closemodal"));
  }

  saveAndNext() {
    this.productTransferDetail = this.template
      .querySelector("c-product-transfer-detail")
      .handleSaveAndNext();
    this.showDetails = false;
    this.showLines = true;
  }

  saveAndNew() {
    this.template
      .querySelector("c-product-transfer-lines")
      .handleSaveAndNew()
      .then(() => {
        this.showLines = false;
        this.showDetails = true;
      });
  }

  saveAndCreate() {
    this.template
      .querySelector("c-product-transfer-lines")
      .handleSaveAndCreate()
      .then(() => {
        this.showLines = false;
        this.dispatchEvent(new CustomEvent("closemodal"));
      });
  }
}