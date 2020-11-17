/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CBTaxSvc {
    global CBTaxSvc() {

    }
global class AdjustTaxRequest {
    global String AdjustmentDescription;
    global Integer AdjustmentReason;
    global AvaAcctSeed.CBTaxSvc.GetTaxRequest GetTaxRequest;
    global AdjustTaxRequest() {

    }
}
global class AdjustTaxResponse_element {
    global AvaAcctSeed.CBTaxSvc.AdjustTaxResult AdjustTaxResult;
    global AdjustTaxResponse_element() {

    }
}
global class AdjustTaxResult {
    global String AdjustmentDescription;
    global Integer AdjustmentReason;
    global String DocCode;
    global Date DocDate;
    global String DocId;
    global String DocStatus;
    global String DocType;
    global Integer HashCode;
    global Boolean Locked;
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global Boolean Reconciled;
    global String ResultCode;
    global AvaAcctSeed.CBTaxSvc.ArrayOfTaxAddress TaxAddresses;
    global Date TaxDate;
    global AvaAcctSeed.CBTaxSvc.ArrayOfTaxLine TaxLines;
    global AvaAcctSeed.CBTaxSvc.ArrayOfTaxDetail TaxSummary;
    global Datetime Timestamp;
    global Decimal TotalAmount;
    global Decimal TotalDiscount;
    global Decimal TotalExemption;
    global Decimal TotalTax;
    global Decimal TotalTaxable;
    global Decimal TotalTaxCalculated;
    global String TransactionId;
    global Integer Version;
    global Boolean VolatileTaxRates;
    global AdjustTaxResult() {

    }
}
global class AdjustTax_element {
    global AvaAcctSeed.CBTaxSvc.AdjustTaxRequest AdjustTaxRequest;
    global AdjustTax_element() {

    }
}
global class ApplyPaymentRequest {
    global String CompanyCode;
    global String DocCode;
    global String DocType;
    global Date PaymentDate;
    global ApplyPaymentRequest() {

    }
}
global class ApplyPaymentResponse_element {
    global AvaAcctSeed.CBTaxSvc.ApplyPaymentResult ApplyPaymentResult;
    global ApplyPaymentResponse_element() {

    }
}
global class ApplyPaymentResult {
    global ApplyPaymentResult() {

    }
}
global class ApplyPayment_element {
    global AvaAcctSeed.CBTaxSvc.ApplyPaymentRequest ApplyPaymentRequest;
    global ApplyPayment_element() {

    }
}
global class ArrayOfBaseAddress {
    global List<AvaAcctSeed.CBTaxSvc.BaseAddress> BaseAddress;
    global ArrayOfBaseAddress() {

    }
}
global class ArrayOfGetTaxResult {
    global List<AvaAcctSeed.CBTaxSvc.GetTaxResult> GetTaxResult;
    global ArrayOfGetTaxResult() {

    }
}
global class ArrayOfLine {
    global List<AvaAcctSeed.CBTaxSvc.Line> Line;
    global ArrayOfLine() {

    }
}
global class ArrayOfMessage {
    global List<AvaAcctSeed.CBTaxSvc.Message> Message;
    global ArrayOfMessage() {

    }
}
global class ArrayOfTaxAddress {
    global List<AvaAcctSeed.CBTaxSvc.TaxAddress> TaxAddress;
    global ArrayOfTaxAddress() {

    }
}
global class ArrayOfTaxDetail {
    global List<AvaAcctSeed.CBTaxSvc.TaxDetail> TaxDetail;
    global ArrayOfTaxDetail() {

    }
}
global class ArrayOfTaxLine {
    global List<AvaAcctSeed.CBTaxSvc.TaxLine> TaxLine;
    global ArrayOfTaxLine() {

    }
}
global class AuditMessage {
    global String Message;
    global AuditMessage() {

    }
}
global class BaseAddress {
    global String AddressCode;
    global String City;
    global String Country;
    global String Latitude;
    global String Line1;
    global String Line2;
    global String Line3;
    global String Longitude;
    global String PostalCode;
    global String Region;
    global Integer TaxRegionId;
    global BaseAddress() {

    }
}
global class CBTaxSvcSoap {
    global AvaAcctSeed.CBTaxSvc.AuditMessage AuditMessage;
    global String clientCert_x;
    global String clientCertName_x;
    global String clientCertPasswd_x;
    global String endpoint_x;
    global Map<String,String> inputHttpHeaders_x;
    global Map<String,String> outputHttpHeaders_x;
    global AvaAcctSeed.CBTaxSvc.Profile Profile;
    global AvaAcctSeed.CBTaxSvc.Security Security;
    global Integer timeout_x {
        get;
        set;
    }
    global CBTaxSvcSoap(String SvcURL) {

    }
    global AvaAcctSeed.CBTaxSvc.AdjustTaxResult AdjustTax(AvaAcctSeed.CBTaxSvc.AdjustTaxRequest AdjustTaxRequest) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.ApplyPaymentResult ApplyPayment(AvaAcctSeed.CBTaxSvc.ApplyPaymentRequest ApplyPaymentRequest) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.CancelTaxResult CancelTax(AvaAcctSeed.CBTaxSvc.CancelTaxRequest CancelTaxRequest) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.CommitTaxResult CommitTax(AvaAcctSeed.CBTaxSvc.CommitTaxRequest CommitTaxRequest) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.GetTaxResult GetTax(AvaAcctSeed.CBTaxSvc.GetTaxRequest GetTaxRequest) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.GetTaxHistoryResult GetTaxHistory(AvaAcctSeed.CBTaxSvc.GetTaxHistoryRequest GetTaxHistoryRequest) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.IsAuthorizedResult IsAuthorized(String Operations) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.PingResult Ping(String Message) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.PostTaxResult PostTax(AvaAcctSeed.CBTaxSvc.PostTaxRequest PostTaxRequest) {
        return null;
    }
    global AvaAcctSeed.CBTaxSvc.ReconcileTaxHistoryResult ReconcileTaxHistory(AvaAcctSeed.CBTaxSvc.ReconcileTaxHistoryRequest ReconcileTaxHistoryRequest) {
        return null;
    }
}
global class CancelTaxRequest {
    global String CancelCode;
    global String CompanyCode;
    global String DocCode;
    global String DocType;
    global CancelTaxRequest() {

    }
}
global class CancelTaxResponse_element {
    global AvaAcctSeed.CBTaxSvc.CancelTaxResult CancelTaxResult;
    global CancelTaxResponse_element() {

    }
}
global class CancelTaxResult {
    global String DocId;
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global String ResultCode;
    global String TransactionId;
    global CancelTaxResult() {

    }
}
global class CancelTax_element {
    global AvaAcctSeed.CBTaxSvc.CancelTaxRequest CancelTaxRequest;
    global CancelTax_element() {

    }
}
global class CommitTaxRequest {
    global String CompanyCode;
    global String DocCode;
    global String DocType;
    global String NewDocCode;
    global CommitTaxRequest() {

    }
}
global class CommitTaxResponse_element {
    global AvaAcctSeed.CBTaxSvc.CommitTaxResult CommitTaxResult;
    global CommitTaxResponse_element() {

    }
}
global class CommitTaxResult {
    global String DocId;
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global String ResultCode;
    global String TransactionId;
    global CommitTaxResult() {

    }
}
global class CommitTax_element {
    global AvaAcctSeed.CBTaxSvc.CommitTaxRequest CommitTaxRequest;
    global CommitTax_element() {

    }
}
global class GetTaxHistoryRequest {
    global String CompanyCode;
    global String DetailLevel;
    global String DocCode;
    global String DocType;
    global GetTaxHistoryRequest() {

    }
}
global class GetTaxHistoryResponse_element {
    global AvaAcctSeed.CBTaxSvc.GetTaxHistoryResult GetTaxHistoryResult;
    global GetTaxHistoryResponse_element() {

    }
}
global class GetTaxHistoryResult {
    global AvaAcctSeed.CBTaxSvc.GetTaxRequest GetTaxRequest;
    global AvaAcctSeed.CBTaxSvc.GetTaxResult GetTaxResult;
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global String ResultCode;
    global String TransactionId;
    global GetTaxHistoryResult() {

    }
}
global class GetTaxHistory_element {
    global AvaAcctSeed.CBTaxSvc.GetTaxHistoryRequest GetTaxHistoryRequest;
    global GetTaxHistory_element() {

    }
}
global class GetTaxRequest {
    global AvaAcctSeed.CBTaxSvc.ArrayOfBaseAddress Addresses;
    global String BatchCode;
    global String BusinessIdentificationNo;
    global Boolean Commit_x;
    global String CompanyCode;
    global String CurrencyCode;
    global String CustomerCode;
    global String CustomerUsageType;
    global String DestinationCode;
    global String DetailLevel;
    global Decimal Discount;
    global String DocCode;
    global Date DocDate;
    global String DocType;
    global Decimal ExchangeRate;
    global Date ExchangeRateEffDate;
    global String ExemptionNo;
    global Integer HashCode;
    global AvaAcctSeed.CBTaxSvc.ArrayOfLine Lines;
    global String LocationCode;
    global String OriginCode;
    global Date PaymentDate;
    global String PosLaneCode;
    global String PurchaseOrderNo;
    global String ReferenceCode;
    global String SalespersonCode;
    global String ServiceMode;
    global AvaAcctSeed.CBTaxSvc.TaxOverride TaxOverride;
    global GetTaxRequest() {

    }
}
global class GetTaxResponse_element {
    global AvaAcctSeed.CBTaxSvc.GetTaxResult GetTaxResult;
    global GetTaxResponse_element() {

    }
}
global class GetTaxResult {
    global String AdjustmentDescription;
    global Integer AdjustmentReason;
    global String DocCode;
    global Date DocDate;
    global String DocId;
    global String DocStatus;
    global String DocType;
    global Integer HashCode;
    global Boolean Locked;
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global Boolean Reconciled;
    global String ResultCode;
    global AvaAcctSeed.CBTaxSvc.ArrayOfTaxAddress TaxAddresses;
    global Date TaxDate;
    global AvaAcctSeed.CBTaxSvc.ArrayOfTaxLine TaxLines;
    global AvaAcctSeed.CBTaxSvc.ArrayOfTaxDetail TaxSummary;
    global Datetime Timestamp;
    global Decimal TotalAmount;
    global Decimal TotalDiscount;
    global Decimal TotalExemption;
    global Decimal TotalTax;
    global Decimal TotalTaxable;
    global Decimal TotalTaxCalculated;
    global String TransactionId;
    global Integer Version;
    global Boolean VolatileTaxRates;
    global GetTaxResult() {

    }
}
global class GetTax_element {
    global AvaAcctSeed.CBTaxSvc.GetTaxRequest GetTaxRequest;
    global GetTax_element() {

    }
}
global class IsAuthorizedResponse_element {
    global AvaAcctSeed.CBTaxSvc.IsAuthorizedResult IsAuthorizedResult;
    global IsAuthorizedResponse_element() {

    }
}
global class IsAuthorizedResult {
    global Datetime Expires;
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global String Operations;
    global String ResultCode;
    global String TransactionId;
    global IsAuthorizedResult() {

    }
}
global class IsAuthorized_element {
    global String Operations;
    global IsAuthorized_element() {

    }
}
global class Line {
    global Decimal Amount;
    global String BusinessIdentificationNo;
    global String CustomerUsageType;
    global String Description;
    global String DestinationCode;
    global Boolean Discounted;
    global String ExemptionNo;
    global String ItemCode;
    global String No;
    global String OriginCode;
    global Decimal Qty;
    global String Ref1;
    global String Ref2;
    global String RevAcct;
    global String TaxCode;
    global Boolean TaxIncluded;
    global AvaAcctSeed.CBTaxSvc.TaxOverride TaxOverride;
    global Line() {

    }
}
global class Message {
    global String Details;
    global String HelpLink;
    global String Name;
    global String RefersTo;
    global String Severity;
    global String Source;
    global String Summary;
    global Message() {

    }
}
global class PingResponse_element {
    global AvaAcctSeed.CBTaxSvc.PingResult PingResult;
    global PingResponse_element() {

    }
}
global class PingResult {
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global String ResultCode;
    global String TransactionId;
    global String Version;
    global PingResult() {

    }
}
global class Ping_element {
    global String Message;
    global Ping_element() {

    }
}
global class PostTaxRequest {
    global Boolean Commit_x;
    global String CompanyCode;
    global String DocCode;
    global Date DocDate;
    global String DocType;
    global Integer HashCode;
    global String NewDocCode;
    global Decimal TotalAmount;
    global Decimal TotalTax;
    global PostTaxRequest() {

    }
}
global class PostTaxResponse_element {
    global AvaAcctSeed.CBTaxSvc.PostTaxResult PostTaxResult;
    global PostTaxResponse_element() {

    }
}
global class PostTaxResult {
    global String DocId;
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global String ResultCode;
    global String TransactionId;
    global PostTaxResult() {

    }
}
global class PostTax_element {
    global AvaAcctSeed.CBTaxSvc.PostTaxRequest PostTaxRequest;
    global PostTax_element() {

    }
}
global class Profile {
    global String Adapter;
    global String Client;
    global String Machine;
    global String Name;
    global Profile() {

    }
}
global class ReconcileTaxHistoryRequest {
    global String CompanyCode;
    global String DocStatus;
    global String DocType;
    global Date EndDate;
    global String LastDocCode;
    global Integer PageSize;
    global Boolean Reconciled;
    global Date StartDate;
    global ReconcileTaxHistoryRequest() {

    }
}
global class ReconcileTaxHistoryResponse_element {
    global AvaAcctSeed.CBTaxSvc.ReconcileTaxHistoryResult ReconcileTaxHistoryResult;
    global ReconcileTaxHistoryResponse_element() {

    }
}
global class ReconcileTaxHistoryResult {
    global AvaAcctSeed.CBTaxSvc.ArrayOfGetTaxResult GetTaxResults;
    global String LastDocCode;
    global AvaAcctSeed.CBTaxSvc.ArrayOfMessage Messages;
    global Integer RecordCount;
    global String ResultCode;
    global String TransactionId;
    global ReconcileTaxHistoryResult() {

    }
}
global class ReconcileTaxHistory_element {
    global AvaAcctSeed.CBTaxSvc.ReconcileTaxHistoryRequest ReconcileTaxHistoryRequest;
    global ReconcileTaxHistory_element() {

    }
}
global class Security {
    global AvaAcctSeed.CBTaxSvc.UsernameToken_element UsernameToken;
    global Security() {

    }
}
global class TaxAddress {
    global String Address;
    global String AddressCode;
    global Integer BoundaryLevel;
    global String City;
    global String Country;
    global String DistanceToBoundary;
    global String GeocodeType;
    global String JurisCode;
    global String Latitude;
    global String Longitude;
    global String PostalCode;
    global String Region;
    global Integer TaxRegionId;
    global String ValidateStatus;
    global TaxAddress() {

    }
}
global class TaxDetail {
    global Decimal Base;
    global String Country;
    global Decimal Exemption;
    global String JurisCode;
    global String JurisName;
    global String JurisType;
    global Decimal NonTaxable;
    global Decimal Rate;
    global String RateType;
    global String Region;
    global String StateAssignedNo;
    global Decimal Tax;
    global Decimal Taxable;
    global Integer TaxAuthorityType;
    global Decimal TaxCalculated;
    global String TaxGroup;
    global String TaxName;
    global String TaxType;
    global TaxDetail() {

    }
}
global class TaxLine {
    global String AccountingMethod;
    global String BoundaryLevel;
    global Decimal Discount;
    global Integer ExemptCertId;
    global Decimal Exemption;
    global String No;
    global Decimal Rate;
    global Date ReportingDate;
    global Decimal Tax;
    global Boolean Taxability;
    global Decimal Taxable;
    global Decimal TaxCalculated;
    global String TaxCode;
    global Date TaxDate;
    global AvaAcctSeed.CBTaxSvc.ArrayOfTaxDetail TaxDetails;
    global Boolean TaxIncluded;
    global TaxLine() {

    }
}
global class TaxOverride {
    global String Reason;
    global Decimal TaxAmount;
    global Date TaxDate;
    global String TaxOverrideType;
    global TaxOverride() {

    }
}
global class UsernameToken_element {
    global String Password;
    global String Username;
    global UsernameToken_element() {

    }
}
}
