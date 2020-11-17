import { LightningElement, api, track, wire } from "lwc";
import getProductTransferRecordTypes from "@salesforce/apex/MassCreateProductTransferController.getProductTransferRecordTypes";
import getSourceProductItem from "@salesforce/apex/MassCreateProductTransferController.getSourceProductItem";
import getDefaultProductItem from "@salesforce/apex/MassCreateProductTransferController.getDefaultProductItem";
import getVendorPOLineItems from "@salesforce/apex/MassCreateProductTransferController.getVendorPOLineItems";
import getDefaultVendorPOLineItem from "@salesforce/apex/MassCreateProductTransferController.getDefaultVendorPOLineItem";

export default class ProductTransferLineItem extends LightningElement {
  _productRequestLineItem;
  productTransferLineItem = {};
  selected = false;
  isMultiEntry = false;
  defaultSourceProduct;
  defaultVendorPOLineItem;
  recordTypes;

  @track loaded = false;
  @track sourceProductItemReadOnly = false;
  @track vendorProductItemReadOnly = false;

  @api get productRequestLineItem() {
    return this._productRequestLineItem;
  }
  set productRequestLineItem(value) {
    console.log(JSON.parse(JSON.stringify(value)));
    this._productRequestLineItem = value;
    if (value !== undefined) {
      this.loaded = false;
      for (let attribute in value) {
        if (value[attribute]) {
          this.productTransferLineItem[attribute] = value[attribute];
        }
      }

      for (let recordType of this.recordTypes) {
        if (recordType.value === this.productTransferLineItem.RecordTypeId) {
          if (recordType.label === "Internal Transfer") {
            this.vendorProductItemReadOnly = true;
          } else {
            this.sourceProductItemReadOnly = true;
          }
        }
      }

      if (this.productTransferLineItem.SourceLocationId !== undefined) {
        this.getSourceProduct();
      }
      if (this.productTransferLineItem.Vendor__c !== undefined) {
        this.getVendorPOLineItem();
      }
      this.loaded = true;
    }
  }

  @api getSelectedItems() {
    if (this.selected) {
      console.log(
        "Product transfer line item from productTransferLineItem",
        JSON.parse(JSON.stringify(this.productTransferLineItem))
      );
      return this.productTransferLineItem;
    }
    return null;
  }

  @wire(getProductTransferRecordTypes)
  wiredRecordTypes({ data, error }) {
    if (data) {
      // eslint-disable-next-line no-console
      console.log("Record Types", JSON.parse(data));
      this.recordTypes = JSON.parse(data);
    } else {
      // eslint-disable-next-line no-console
      console.log(error);
    }
  }

  onSelectChange(event) {
    this.selected = event.target.checked;
  }

  updateQuantitySent(event) {
    var productTransferLineItem = Object.assign(
      {},
      this.productTransferLineItem
    );
    productTransferLineItem.QuantityRequested = event.target.value;
    this.productTransferLineItem = productTransferLineItem;
    this.dispatchEvent(
      new CustomEvent("update", {
        detail: {
          index: this.productRequestLineItem.index,
          lineItem: this.productTransferLineItem
        }
      })
    );
  }

  handleProductItemSearch(event) {
    var params = Object.assign({}, event.detail);
    params.locationId = this.productTransferLineItem.SourceLocationId;
    getSourceProductItem(params)
      .then(results => {
        this.template
          .querySelector("c-lookup[data-id='productitem']")
          .setSearchResults(results);
      })
      .catch(error => {
        // eslint-disable-next-line no-console
        console.error("Lookup error", JSON.stringify(error));
      });
  }

  handlePOLineItemSearch(event) {
    var params = Object.assign({}, event.detail);
    params.locationId = this.productTransferLineItem.Vendor__c;
    getVendorPOLineItems(params)
      .then(results => {
        this.template
          .querySelector("c-lookup[data-id='vendorpolineitem']")
          .setSearchResults(results);
      })
      .catch(error => {
        // eslint-disable-next-line no-console
        console.error("Lookup error", JSON.stringify(error));
      });
  }

  handleSelectionChange(event) {
    const selection = event.target.getSelection();
    const label = event.target.label;
    var selectionId;
    var selectionTitle;
    var selectionSubtitle;
    if (selection.length === 0) {
      selectionId = "";
      selectionTitle = "";
      selectionSubtitle = "";
    } else {
      selectionId = selection[0].id;
      selectionTitle = selection[0].title;
      selectionSubtitle = selection[0].subtitle;
    }
    switch (label) {
      case "Source Product Item":
        this.productTransferLineItem.SourceProductItemId = selectionId;
        this.productTransferLineItem.SourceProductItem = {};
        this.productTransferLineItem.SourceProductItem.Product2 = {};
        this.productTransferLineItem.SourceProductItem.Product2.Name = selectionTitle;
        this.productTransferLineItem.SourceProductItem.Product2.Id = selectionSubtitle;
        break;
      case "Vendor PO Line Item":
        this.productTransferLineItem.Vendor_PO_Line__c = selectionId;
        this.productTransferLineItem.Vendor_PO_Line__r = {};
        this.productTransferLineItem.Vendor_PO_Line__r.AcctSeedERP__Product__r = {};
        this.productTransferLineItem.Vendor_PO_Line__r.AcctSeedERP__Product__r.Name = selectionTitle;
        this.productTransferLineItem.Vendor_PO_Line__r.AcctSeedERP__Product__r.Id = selectionSubtitle;
        break;
      default:
        // eslint-disable-next-line no-console
        console.log("Invalid Selection");
    }
    this.dispatchEvent(
      new CustomEvent("update", {
        detail: {
          index: this.productRequestLineItem.index,
          lineItem: this.productTransferLineItem
        }
      })
    );
  }

  async getSourceProduct() {
    await getDefaultProductItem({
      productId: this.productTransferLineItem.Product2Id,
      locationId: this.productTransferLineItem.SourceLocationId
    })
      .then(result => {
        this.defaultSourceProduct = result;
      })
      .catch(error => {
        console.log("Error", error);
      });
  }

  async getVendorPOLineItem() {
    console.log("Product Id", this.productTransferLineItem.Product2Id);
    console.log("Vendor Id", this.productTransferLineItem.Vendor__c);
    await getDefaultVendorPOLineItem({
      productId: this.productTransferLineItem.Product2Id,
      vendorId: this.productTransferLineItem.Vendor__c
    })
      .then(result => {
        this.defaultVendorPOLineItem = result;
        this.productTransferLineItem.Vendor_PO_Line__c = result.Id;
        this.productTransferLineItem.Vendor_PO_Line__r = {};
        this.productTransferLineItem.Vendor_PO_Line__r.AcctSeedERP__Product__r = {};
        this.productTransferLineItem.Vendor_PO_Line__r.AcctSeedERP__Product__r.Name =
          result.AcctSeedERP__Product__r.Name;
        this.productTransferLineItem.Vendor_PO_Line__r.AcctSeedERP__Product__r.Id =
          result.AcctSeedERP__Product__c;
      })
      .catch(error => {
        console.log("Error", error);
      });
  }

  get sourceProductSelection() {
    if (
      this.defaultSourceProduct === undefined &&
      this.productTransferLineItem.SourceProductItemId === undefined
    ) {
      return [];
    } else if (
      this.defaultSourceProduct === undefined &&
      this.productTransferLineItem.SourceProductItemId !== undefined
    ) {
      return [
        {
          id: this.productTransferLineItem.SourceProductItemId,
          sObjectType: "ProductItem",
          icon: "standard:product_item",
          title: this.productTransferLineItem.SourceProductItem.Product2.Name,
          subtitle: ""
        }
      ];
    }
    return [
      {
        id: this.defaultSourceProduct.Id,
        sObjectType: "ProductItem",
        icon: "standard:product_item",
        title: this.defaultSourceProduct.Product2.Name,
        subtitle: ""
      }
    ];
  }

  get vendorPOLineItemSelection() {
    if (
      this.defaultVendorPOLineItem === undefined &&
      this.productTransferLineItem.Vendor_PO_Line__c === undefined
    ) {
      return [];
    } else if (
      this.defaultVendorPOLineItem === undefined &&
      this.productTransferLineItem.Vendor_PO_Line__c !== undefined
    ) {
      return [
        {
          id: this.productTransferLineItem.Vendor_PO_Line__c,
          sObjectType: "AcctSeedERP__Purchase_Order_Line__c",
          icon: "standard:product",
          title: this.productTransferLineItem.Vendor_PO_Line__r
            .AcctSeedERP__Product__r.Name,
          subtitle: ""
        }
      ];
    }
    return [
      {
        id: this.defaultVendorPOLineItem.Id,
        sObjectType: "AcctSeedERP__Purchase_Order_Line__c",
        icon: "standard:product",
        title: this.defaultVendorPOLineItem.AcctSeedERP__Product__r.Name,
        subtitle: ""
      }
    ];
  }
}