import { LightningElement, api, wire, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getProductRequestLineItems from "@salesforce/apex/MassCreateProductTransferController.getProductRequestLineItems";
import createProductTransfers from "@salesforce/apex/MassCreateProductTransferController.createProductTransfers";

export default class ProductTransferLines extends LightningElement {
  _productTransferDetail;

  @track productRequestLineItems;
  @track copyShippingInfo = false;

  @api recordId;
  @api get productTransferDetail() {
    return this._productTransferDetail;
  }
  set productTransferDetail(value) {
    if (value !== undefined) {
      console.log("Product Transfer Detail", JSON.parse(JSON.stringify(value)));
      this._productTransferDetail = Object.assign({}, value);
      this.wiredProductRequestLineItems();
    }
  }

  @api async handleSaveAndNew() {
    var lineItemComponents = this.template.querySelectorAll(
      "c-product-transfer-line-item"
    );
    var lineItems = [];
    for (let lineItemComponent of lineItemComponents) {
      let item = lineItemComponent.getSelectedItems();
      if (item !== null) {
        lineItems.push(item);
      }
    }
    await this.saveRecords(lineItems);
  }

  @api async handleSaveAndCreate() {
    var lineItemComponents = this.template.querySelectorAll(
      "c-product-transfer-line-item"
    );
    var lineItems = [];
    for (let lineItemComponent of lineItemComponents) {
      let item = lineItemComponent.getSelectedItems();
      if (item !== null) {
        lineItems.push(item);
      }
    }
    await this.saveRecords(lineItems);
  }

  wiredProductRequestLineItems() {
    getProductRequestLineItems({ productRequestId: this.recordId })
      .then(data => {
        if (data) {
          let productRequestLineItems = [];
          let ind = 0;
          for (let item of data) {
            let tempItem = Object.assign({}, item);
            for (let attribute in this.productTransferDetail) {
              if (attribute !== "Id") {
                tempItem[attribute] = this.productTransferDetail[attribute];
              }
            }
            tempItem.index = ind;
            ind += 1;
            productRequestLineItems.push(tempItem);
          }
          this.productRequestLineItems = productRequestLineItems;
        }
      })
      .catch(error => {
        // eslint-disable-next-line no-console
        console.log("Error", error);
      });
  }

  //   @wire(getProductRequestLineItems, { productRequestId: "$recordId" })
  //   wiredProductRequestLineItems({ data, error }) {
  //     if (data) {
  //       this.productRequestLineItems = data;
  //       for (let item of this.productRequestLineItems) {
  //         for (let attribute in this.productTransferDetail) {
  //           if (this.productRequestLineItems[attribute]) {
  //             item[attribute] = this.productTransferDetail[attribute];
  //           }
  //         }
  //       }
  //     } else {
  //       // eslint-disable-next-line no-console
  //       console.log(error);
  //     }
  //   }

  async saveRecords(lineItems) {
    console.log(JSON.parse(JSON.stringify(lineItems)));
    await createProductTransfers({
      productRequestId: this.recordId,
      productTransfersString: JSON.stringify(lineItems)
    })
      .then(() => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success!",
            message: "Your Product Transfer Requests have been created.",
            variant: "success"
          })
        );
      })
      .catch(error => {
        console.log(error);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error",
            message: error.body.message,
            variant: "error"
          })
        );
      });
  }

  handleOpenShippingModal() {
    this.copyShippingInfo = true;
  }

  handleCloseShippingModal() {
    this.copyShippingInfo = false;
  }

  saveShippingInfo() {
    var shippingCmp = this.template.querySelector(
      "c-copy-shipping-info-to-product-transfer"
    );
    var shippingInfo = shippingCmp.getShippingInfo();
    var lineItems = shippingCmp.getSelectedLines();
    var existingLineItems = [];
    var newLineItems = [];
    for (let item of this.productRequestLineItems) {
      existingLineItems.push(Object.assign({}, item));
    }

    for (let item of lineItems) {
      for (let attribute in shippingInfo) {
        if (shippingInfo[attribute] !== "Selected") {
          item[attribute] = shippingInfo[attribute];
        }
      }
    }

    for (let item of existingLineItems) {
      for (let newItem of lineItems) {
        if (item.Id === newItem.Id) {
          item = Object.assign({}, newItem);
        }
      }
      newLineItems.push(item);
    }

    this.productRequestLineItems = newLineItems;
    this.copyShippingInfo = false;
  }

  handleProductTransferUpdate(event) {
    var productTransferLineItems = JSON.parse(
      JSON.stringify(this.productRequestLineItems)
    );
    var index = event.detail.index;
    var lineItem = event.detail.lineItem;

    for (let item of productTransferLineItems) {
      if (item.index === index) {
        Object.assign(item, lineItem);
        console.log("match", JSON.parse(JSON.stringify(item)));
        break;
      }
    }
    console.log("product request lines", productTransferLineItems);
    this.productRequestLineItems = productTransferLineItems;
  }
}