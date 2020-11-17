import { LightningElement, api, wire, track } from "lwc";
import getProductTransferRecordTypes from "@salesforce/apex/MassCreateProductTransferController.getProductTransferRecordTypes";
import getLocations from "@salesforce/apex/MassCreateProductTransferController.getLocations";
import getVendors from "@salesforce/apex/MassCreateProductTransferController.getVendors";

export default class ProductTransferDetail extends LightningElement {
  isMultiEntry = false;

  @track loaded = false;
  @track recordTypes;

  @api productTransferDetail;

  @wire(getProductTransferRecordTypes)
  wiredRecordTypes({ data, error }) {
    if (data) {
      // eslint-disable-next-line no-console
      console.log("Record Types", JSON.parse(data));
      this.recordTypes = JSON.parse(data);
      this.loaded = true;
    } else {
      // eslint-disable-next-line no-console
      console.log(error);
    }
  }

  handleTypeChange(event) {
    var productTransferDetail = Object.assign({}, this.productTransferDetail);
    productTransferDetail.RecordTypeId = event.target.value;
    this.productTransferDetail = productTransferDetail;
  }

  get destinationSelection() {
    if (
      this.productTransferDetail === undefined ||
      this.productTransferDetail.DestinationLocationId === undefined ||
      this.productTransferDetail.DestinationLocationId === ""
    ) {
      return [];
    }
    return [
      {
        id: this.productTransferDetail.DestinationLocationId,
        sObjectType: "Location",
        icon: "standard:location",
        title: this.productTransferDetail.DestinationLocation.Name,
        subtitle: ""
      }
    ];
  }

  get sourceSelection() {
    console.log(JSON.parse(JSON.stringify(this.productTransferDetail)));
    if (
      this.productTransferDetail === undefined ||
      this.productTransferDetail.SourceLocationId === undefined ||
      this.productTransferDetail.SourceLocationId === ""
    ) {
      return [];
    }
    return [
      {
        id: this.productTransferDetail.SourceLocationId,
        sObjectType: "Location",
        icon: "standard:location",
        title: this.productTransferDetail.SourceLocation.Name,
        subtitle: ""
      }
    ];
  }

  get vendorSelection() {
    if (
      this.productTransferDetail === undefined ||
      this.productTransferDetail.Vendor__c === undefined ||
      this.productTransferDetail.Vendor__c === ""
    ) {
      return [];
    }
    return [
      {
        id: this.productTransferDetail.Vendor__c,
        sObjectType: "Account",
        icon: "standard:account",
        title: this.productTransferDetail.Vendor__r.Name,
        subtitle: ""
      }
    ];
  }

  handleDestinationSearch(event) {
    getLocations(event.detail)
      .then(results => {
        this.template
          .querySelector("c-lookup[data-id='destination']")
          .setSearchResults(results);
      })
      .catch(error => {
        // eslint-disable-next-line no-console
        console.error("Lookup error", JSON.stringify(error));
      });
  }

  handleSourceSearch(event) {
    getLocations(event.detail)
      .then(results => {
        this.template
          .querySelector("c-lookup[data-id='source']")
          .setSearchResults(results);
      })
      .catch(error => {
        // eslint-disable-next-line no-console
        console.error("Lookup error", JSON.stringify(error));
      });
  }

  handleVendorSearch(event) {
    getVendors(event.detail)
      .then(results => {
        this.template
          .querySelector("c-lookup[data-id='vendor']")
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
    var productTransferDetail = Object.assign({}, this.productTransferDetail);
    if (selection.length === 0) {
      selectionId = "";
      selectionTitle = "";
    } else {
      selectionId = selection[0].id;
      selectionTitle = selection[0].title;
    }
    switch (label) {
      case "Destination Location":
        productTransferDetail.DestinationLocationId = selectionId;
        productTransferDetail.DestinationLocation = {};
        productTransferDetail.DestinationLocation.Name = selectionTitle;
        break;
      case "Source Location":
        productTransferDetail.SourceLocationId = selectionId;
        productTransferDetail.SourceLocation = {};
        productTransferDetail.SourceLocation.Name = selectionTitle;
        break;
      case "Vendor":
        productTransferDetail.Vendor__c = selectionId;
        productTransferDetail.Vendor__r = {};
        productTransferDetail.Vendor__r.Name = selectionTitle;
        break;
      default:
        // eslint-disable-next-line no-console
        console.log("Invalid Selection");
    }
    this.productTransferDetail = productTransferDetail;
  }

  @api
  handleSaveAndNext() {
    return this.productTransferDetail;
  }
}