 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

// this unit controls all of the line items on an invoice.

{ Author Notes...

   This is probably by far the biggest object in AvoBase 2, and by far, the largest and most complicated
   object I've ever written.

}

unit  Order_InvoiceObjectUnit;

interface uses
	constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   avobase_dialogformunit,
   avobase_percentformunit,
   masterdata_BaseDataClassUnit,
   RecordStructureUnit,
   //
   Invoice_LineItemControlObjectUnit,
   Invoice_MOPItemControlObjectUnit,
   Invoice_FEEItemControlObjectUnit,
   Order_FinalizationFormUnit,
   //
   Escrow_SelectEscrowFormUnit,
   toolbox_cycletoolboxunit,
   toolbox_PreferenceToolBoxUnit,
   toolbox_ordertoolboxunit,
   toolbox_customertoolboxunit,
   toolbox_orgtoolboxunit,
   toolbox_shippingtoolboxunit,
   toolbox_taxtoolboxunit,
   toolbox_producttoolboxunit,
   toolbox_paymenttoolboxunit,
   toolbox_escrowtoolboxunit,
   //
   windows,
   messages,
   sysutils,
   bde,
   db,
   math,
   dialogs,
   dbtables,
   forms,
   contnrs,
   classes;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

type
	tInvoice = class( tObject )
   private
      // ----------------------------------------------------------------------------- //
      fOrderSaved: boolean;
      fOrderID : string;
      fReturnID : string;
      fCustSoldID : string;
      fCustShipID : string;
      fTaxExID : string;
      fExOrdTax : Currency;
      fCycleID : string;
      fOrgID : string;
      fOrderNum : integer;
      fOrderDate : tDateTime;
      fOrderTime : tDateTime;
      fStatus : tOrderStatusTypes;
      fWaveTax : boolean;
      fWaveShipping : boolean;
      fShowDiscount : boolean;
      fOrderType : tOrderTypes;
   	fInvoiceType : tInvoiceTypes; // what kind of invoice is this?
      fInvoiceMsg : string;
      fShippingAmount : currency;
      fShippingTaxAmount : currency;
      fShippingTaxRate : double;
      fCompoundTaxAmount : currency;
      fRecalcON : boolean;
      fEscrowCredit : currency;
      fmShipTaxID : string; // master tax ID
      fmOrdTaxID : string;

      // ----------------------------------------------------------------------------- //
      // Dock Areas and other objects we have to control
      fMOPDock : tScrollBox;
      fLineItemDock : tScrollBox;
      fFeeDock : tScrollBox;

      // ----------------------------------------------------------------------------- //
      // Dock Areas and other objects we have to control
      LineItems : tLineItemControlObject;
      MOPLineItems : tMOPItemControlObject;
      FEELineItems : tFEEItemControlObject;

      // Events
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;
      eInvoiceUpdatedEvent : tInvoiceUpdatedEvent;
   	fSomeKindOfNewEvent : tNotifyEvent; { a brand new event }
      fSomeKindofEvent : eSomeKindOfEvent; { see above }
      fOnNewLine : TNotifyEvent;

      // ----------------------------------------------------------------------------- //
      // All associated Queries
      fOrderQuery : tQuery;

      // ----------------------------------------------------------------------------- //
		function fGetAmountPaid : currency;
		function fGetAmountShippingSubTotal : currency;
      function fGetAmountDue : currency;
      function fGetAmountFeeSubTotal : currency;
      function fGetAmountLineItemSubTotal : currency;
      function fGetAmountOverPaid : currency;
      function fGetAmountPaidTotalEscrow : currency;
      function fGetAmountShippingTax : currency;
      function fGetAmountTax : currency;
      function fGetAmountTotal : currency;
      function fGetAmountVoid : currency;
      function fGetAmount_Total_RCOST : currency;
      function fGetAmount_Total_SCOST : currency;
      function fGetAmount_Total_YCOST : currency;
      function fGetBackOrderCount : integer;
      function fGetCompoundTax : currency;
      function fGetCustName : string;
      function fGetCycleName : string;
      function fGetFEELines: integer;
      function fGetFeeItemTax : currency;
      function fGetFeeItemTaxWaved : currency;
      function fGetLineItemTax : currency;
      function fGetLineItemTaxWaved : currency;
      function fGetMOPLines: integer;
      function fGetOrderDate : tDateTime;
      function fGetOrderID : string;
      function fGetOrderNumName : string;
      function fGetOrderStatusName : string;
      function fGetOrderTaxWaved : currency;
      function fGetOrderType: tOrderTypes;
      function fGetOrderTypeName : string;
      function fGetOrgName: string;
      function fGetShippingTaxWaved : currency;
      function fGetmTaxID : string;
      function fInvoiceGetLines : integer;
      function fOrderNotSaved : boolean;
      //
		procedure HandleRecalculateInvoice;
      procedure fSetCustSoldID( inValue : String );
      procedure fSetmTaxID( inValue : string );
   public

      // ----------------------------------------------------------------------------- //
   	// functions
      function New(inOrderId, inOrgID, inCycleID, inCustID : string): tErrorResult;
      function Load( inOrderID : string ) : tErrorResult;
      function Delete( inOrderID : string ) : tErrorResult;
      function Save_CheckOrder : boolean;
      function Save : tErrorResult;
      function Edit : tErrorResult;
      function Finalize : tErrorResult;

      // ----------------------------------------------------------------------------- //
      // procedures
      procedure Clear;
      procedure Fee_AddBlankFee;
      procedure Fee_AddFeeBySelect();
      procedure Fee_DeleteFeeItem;
      procedure LineItem_AddBlankLine;
      procedure LineItem_AddProductByProductID( inID : string );
      procedure LineItem_DeleteLineItem;
      procedure MOP_AddBlankMOP;
      procedure MOP_AddEscrowMOP;
      procedure MOP_DeleteMOPItem;
      procedure Order_SetOrderNumber( inVal : integer );
      procedure RecalculateInvoice;
      procedure TabBackward;
      procedure TabForward;

      // ----------------------------------------------------------------------------- //
      // Properties
      property Amount_FeeItemTax : currency read fGetFeeItemTax;
      property Amount_FeeItemTaxWaved : currency read fGetFeeItemTaxWaved;
      property Amount_FeeTotal : currency read fGetAmountFeeSubTotal;
      property Amount_LineItemTax : currency read fGetLineItemTax;
      property Amount_LineItemTaxWaved : currency read fGetLineItemTaxWaved;
      property Amount_LineItemTotal : currency read fGetAmountLineItemSubTotal;
      property Amount_OrderTaxWaved : currency read fGetOrderTaxWaved;
      property Amount_OverPaid : currency read fGetAmountOverPaid;
      property Amount_ShippingSubTotal : currency read fGetAmountShippingSubTotal;
      property Amount_ShippingTaxRate : double read fShippingTaxRate write fShippingTaxRate;
      property Amount_ShippingTaxWaved : currency read fGetShippingTaxWaved;
      property Amount_Total : currency read fGetAmountTotal;
      property Amount_TotalCompoundTax : currency read fGetCompoundTax write fCompoundTaxAmount;
      property Amount_TotalDue : currency read fGetAmountDue;
      property Amount_TotalMOP : currency read fGetAmountPaid;
      property Amount_TotalMOP_Escrow : currency read fGetAmountPaidTotalEscrow;
      property Amount_Total_RCOST : currency read fGetAmount_Total_RCOST;
      property Amount_Total_SCOST : currency read fGetAmount_Total_SCOST;
      property Amount_Total_YCOST : currency read fGetAmount_Total_YCOST;
      property Amount_TotalShippingTax : currency read fGetAmountShippingTax;
      property Amount_TotalTax : currency read fGetAmountTax;
      property Amount_VoidNSF : currency read fGetAmountVoid;
      property BackOrderCount : integer read fGetBackOrderCount;
      property Customer_GetSoldToName : string read fGetCustName;
      property Customer_ShipToID : string read fCustShipID write fCustShipID;
      property Customer_SoldToID : string read fCustSoldID write fSetCustSoldID;
      property CycleID : string read fCycleID;
      property Cycle_GetCycleName : string read fGetCycleName;
      property Escrow_TotalEscrow : currency read fEscrowCredit write fEscrowCredit;
      property FeeLineCount : integer read fGetFEELines;
      property LineItemCount : integer read fInvoiceGetLines;
      property MOPLineCount : integer read fGetMOPLines;
      property Order_GetOrderDate : tDateTime read fGetOrderDate;
      property Order_GetOrderNumber : integer read fOrderNum;
      property Order_GetOrderNumberName : string read fGetOrderNumName;
      property Order_GetOrderStatusName : string read fGetOrderStatusName;
      property Order_GetOrderTypeName : string read fGetOrderTypeName;
      property Order_ID : string read fGetOrderID;
      property Order_Message : string read fInvoiceMsg write fInvoiceMsg;
      property Order_ShowDiscount : boolean read fShowDiscount write fShowDiscount;
      property Order_TaxID : string read fmOrdTaxID write fmOrdTaxID;
      property Order_Type : tOrderTypes read fGetOrderType;
      property Order_WaveOrderTax : boolean read fWaveTax write fWaveTax;
      property OrgID : string read fOrgID;
      property Org_GetOrgName : string read fGetOrgName;
      property Shipping_TaxID : string read fGetmTaxID write fSetmTaxID;
      property Shipping_WaveShipping : boolean read fWaveShipping write fWaveShipping;
      property TaxExemptID : string read fTaxExID write fTaxExID;

      //
   	// ----------------------------------------------------------------------------- //
      // Events
      property OnRecalculateInvoiceEvent : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;
      property OnInvoiceUpdated : tInvoiceUpdatedEvent read eInvoiceUpdatedEvent write eInvoiceUpdatedEvent;
      procedure HandleUpdateLine( sender : tObject; lineNum : integer );
      procedure HandleDeleteLine( sender : tObject; lineNum : integer);
      //
   	// ----------------------------------------------------------------------------- //
      // Standard constructors
      constructor Create( inOrderType : tInvoiceTypes; mopDock, lineItemDock, feeDock : tScrollBox );
      destructor destroy; override;
  end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Destroy'}

constructor tInvoice.Create( inOrderType : tInvoiceTypes; mopDock, lineItemDock, feeDock : tScrollBox );
begin
   inherited create();
   //
   fOrderSaved := false;
   fOrderID := '';
   fReturnID := '';
   fCustSoldID := '';
   fCustShipID := '';
   fCycleID := '';
   fOrgID := '';
   fOrderNum := 0;
   fOrderDate := Now;
   fOrderTime := Now;
   fWaveTax := false;
   fWaveShipping := false;
   fShowDiscount := false;
   fInvoiceMsg := '';
   fShippingAmount := 0.00;
   //
   fInvoiceType := inOrderType;
   fMOPDock := mopDock;
   fLineItemDock := lineItemDock;
   fFeeDock := feeDock;

   //
   LineItems := tLineItemControlObject.create( fLineItemDock, fInvoiceType);
   LineItems.OnRecalculateInvoiceEvent := HandleRecalculateInvoice;
   //
	MOPLineItems := tMOPItemControlObject.Create( fMOPDock, fInvoiceType);
   MOPLineItems.OnRecalculateInvoiceEvent := HandleRecalculateInvoice;
   //
	FEELineItems := tFEEItemControlObject.Create( fFEEDock, fInvoiceType);
   FeeLineItems.OnRecalculateInvoiceEvent := HandleRecalculateInvoice;
   //
   fOrderQuery := masterData.GetQuery();
   fOrderQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_order;
end;

destructor tInvoice.Destroy;
begin
   if (fOrderQuery.State in [dsEdit, dsInsert]) then
      fOrderQuery.Cancel();
   //
   FreeAndNil(LineItems);
   FreeAndNil(MOPLineItems);
   FreeAndNil(FEELineItems);
   FreeAndNil(fOrderQuery);
   //
   inherited Destroy();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties'}

function tInvoice.fGetMOPLines: integer;
begin
	result := MOPLineItems.Count;
end;

function tInvoice.fGetFEELines: integer;
begin
	result := FEELineItems.Count;
end;

function tInvoice.fGetFeeItemTax: currency;
begin
   result := FEELineItems.AmountTotalTax;
end;

function tInvoice.fGetCustName: string;
begin
   result := Customer_GetCustomerNameByCustID( fCustSoldID );
end;

function tInvoice.fGetCycleName: string;
begin
   result := Cycle_GetCycleNameByCycleID( fCycleID );
end;

function tInvoice.fGetLineItemTax: currency;
begin
   result := LineItems.Amount_TotalTax;
end;

function tInvoice.fGetOrderDate: tDateTime;
begin
   result := fOrderDate;
end;

function tInvoice.fGetOrderID: string;
begin
   result := fOrderID;
end;

function tInvoice.fGetOrderNumName: string;
begin
   result := IntToStr( fOrderNum );
end;

function tInvoice.fGetOrderStatusName : string;
begin
   case fStatus of
   	OrderStatusOpen : result := 'OPEN';
   	OrderStatusClosed : result := 'CLOSED';
   	OrderStatusCancelled : result := 'CANCEL';
      OrderStatusDelinquent : result := 'DELINQ';
      else result := 'unknown';
   end;
end;

function tInvoice.fGetOrderType: tOrderTypes;
begin
   result := fOrderType;
end;

function tInvoice.fGetOrderTypeName: string;
begin
	result := 'ORDER';
end;

function tInvoice.fGetOrgName: string;
begin
   result := Org_GetOrgNameByOrgID( fOrgID );
end;

function tInvoice.fInvoiceGetLines: integer;
begin
   result := LineItems.Count;
end;

function tInvoice.fOrderNotSaved: boolean;
begin
   Result := fOrderQuery.State in [dsEdit, dsInsert];
end;

procedure tInvoice.fSetCustSoldID(inValue: String);
begin
   // set BOTH IDS here
   fCustSoldID := inValue;
   MOPLineItems.CustID := inValue;
end;

function tInvoice.fGetAmountDue: currency;
var
   LineItemTotal : currency;
   FeeItemTotal : currency;
   ShippingTotal : currency;
   MOPTotal: currency;
begin
   // initalize
   LineItemTotal := 0.00;
   FeeItemTotal := 0.00;
   ShippingTotal := 0.00;
   MOPTotal := 0.00;
   // Line Items
   LineItemTotal := LineItems.Amount_LineItemSubTotal;
   if (NOT fWaveTax) then
   	LineItemTotal := LineItemTotal + LineItems.Amount_TotalTax;
   // Fees
   FeeItemTotal := FEELineItems.AmountSubTotal;
   if (NOT fWaveTax) then
      FeeItemTotal := FeeItemTotal + FEELineItems.AmountTotalTax;
   // Shipping
   if (NOT fWaveShipping) then
      ShippingTotal := Amount_ShippingSubTotal;
   if (NOT fWaveTax) then
      ShippingTotal := ShippingTotal + Amount_TotalShippingTax;
   // Method of Payment
   MOPTotal := MOPLineItems.AmountPaid;
   result := LineItemTotal + FeeItemTotal + ShippingTotal + Amount_TotalCompoundTax;
   result := (result - MOPTotal);
   // now do voided payments for reports only
   if ( fInvoiceType = InvoiceTypeReport ) then
   	result := result + Amount_VoidNSF;
   //
   if (result < 0) then
      result := 0.00;
end;

function tInvoice.fGetAmountFeeSubTotal: currency;
begin
	Result := FEELineItems.AmountSubTotal;
end;

function tInvoice.fGetAmountOverPaid: currency;
var
   LineItemTotal : currency;
   FeeItemTotal : currency;
   ShippingTotal : currency;
   MOPTotal: currency;
begin
   // initalize
   LineItemTotal := 0.00;
   FeeItemTotal := 0.00;
   ShippingTotal := 0.00;
   MOPTotal := 0.00;
   // Line Items
   LineItemTotal := LineItems.Amount_LineItemSubTotal;
   if (NOT fWaveTax) then
   	LineItemTotal := LineItemTotal + LineItems.Amount_TotalTax;
   // Fees
   FeeItemTotal := FEELineItems.AmountSubTotal;
   if (NOT fWaveTax) then
      FeeItemTotal := FeeItemTotal + FEELineItems.AmountTotalTax;
   // Shipping
   if (NOT fWaveShipping) then
      ShippingTotal := Amount_ShippingSubTotal;
   if (NOT fWaveTax) then
      ShippingTotal := ShippingTotal + Amount_TotalShippingTax;
   // Method of Payment
   MOPTotal := MOPLineItems.AmountPaid;
   result := LineItemTotal + FeeItemTotal + ShippingTotal + Amount_TotalCompoundTax;
   result := (result - MOPTotal);
   if ( fInvoiceType = InvoiceTypeReport ) then
   	result := result + Amount_VoidNSF;
   //
   if (result < 0) then
   begin
      result := result - result - result;
   end else
      result := 0.00;
end;

function tInvoice.fGetAmountPaid: currency;
begin
	result := MOPLineItems.AmountPaid;
end;

function tInvoice.fGetAmountPaidTotalEscrow: currency;
begin
   result := MOPLineItems.Amount_Escrow;
end;

// Get the shipping amount
function tInvoice.fGetAmountShippingSubTotal: currency;
var
   shipRec : tShippingRecord;
begin
   case fInvoiceType of
      InvoiceTypeOrder:
      begin
         if ( NOT fWaveShipping ) then
         begin
            shipRec := Shipping_GetShippingAmountByOrgByAmount( fOrgID, fGetAmountLineItemSubTotal );
            fShippingAmount := shipRec.shipAmount;
            result := shipRec.shipAmount;
         end else
            result := 0.00;
      end;
      InvoiceTypeReport:
      begin
         if ( NOT fWaveShipping ) then
            result := fShippingAmount
         else
            result := 0.00;
      end;
   end;
end;

function tInvoice.fGetAmountShippingTax: currency;
var
   AmtShippingTax : currency;
   taxRate : double;
begin
   AmtShippingTax := 0.00;
   // if this is an order, then we go get a NEW shipping tax rate.
   // if it is NOT an order and we are just displaying it, we use the one we stored IN THE ORDER...
   case fInvoiceType of
      InvoiceTypeOrder:
      begin
         if ( NOT fWaveShipping ) then
         begin
            taxRate := Tax_TaxRateTotalByMasterTaxClassID( fGetAmountShippingSubTotal, fmShipTaxID );
            AmtShippingTax := ( fGetAmountShippingSubTotal * Tax_PerformTaxCalculation( taxRate ));
            AmtShippingTax := RoundTo( AmtShippingTax, -2);
         end else
            AmtShippingTax := 0.00;
      end;
      InvoiceTypeReport:
      begin
         if ( NOT fWaveShipping ) then
            AmtShippingTax := fShippingTaxAmount
         else
            AmtShippingTax := 0;
      end;
   end;
   //
   result := AmtShippingTax;
end;

// This ONLY the line items WITHOUT tax
function tInvoice.fGetAmountLineItemSubTotal: currency;
var
   LineItemTotal : currency;
begin
   // initalize
   LineItemTotal := 0.00;
   // Line Items
   LineItemTotal := LineItems.Amount_LineItemSubTotal;
   //
   result := LineItemTotal;
   //
   if (result < 0) then
      result := 0.00;
end;

function tInvoice.fGetAmountTax: currency;
var
   LineItemTotal : currency;
   FeeItemTotal : currency;
   ShippingTotal : currency;
begin
   result := 0;
   // ----------------------------------------------------------
   // initalize
   LineItemTotal := 0.00;
   FeeItemTotal := 0.00;
   ShippingTotal := 0.00;
   // Line Items
   if (NOT fWaveTax) then
   	LineItemTotal := LineItems.Amount_TotalTax;
   // Fees
   if (NOT fWaveTax) then
      FeeItemTotal := FEELineItems.AmountTotalTax;
   // Shipping
   if (NOT fWaveTax) then
      ShippingTotal := ShippingTotal + Amount_TotalShippingTax;
   // Finished, add them
   result := LineItemTotal + FeeItemTotal + ShippingTotal + Amount_TotalCompoundTax;
   // ----------------------------------------------------------
   //
   fExOrdTax := LineItems.Amount_TotalTax + FEELineItems.AmountTotalTax + Amount_TotalShippingTax + Amount_TotalCompoundTax;
   //
   if (fWaveTax) then
   	result := 0.00;
end;

function tInvoice.fGetCompoundTax : currency;
var
   LineItemTotal : currency;
   FeeItemTotal : currency;
   ShippingTotal : currency;
   CompoundTotal : currency;
   subTotal : currency;
   taxRate : double;
begin
   LineItemTotal := 0.00;
   FeeItemTotal := 0.00;
   ShippingTotal := 0.00;
   CompoundTotal := 0.00;
   // Line Items
   LineItemTotal := LineItems.Amount_LineItemSubTotal;
   LineItemTotal := LineItemTotal + LineItems.Amount_TotalTax;
   // Fees
   FeeItemTotal := FEELineItems.AmountSubTotal;
   FeeItemTotal := FeeItemTotal + FEELineItems.AmountTotalTax;
   // Shipping
   ShippingTotal := Amount_ShippingSubTotal;
   ShippingTotal := ShippingTotal + Amount_TotalShippingTax;
   // Compound
   if ( fInvoiceType = InvoiceTypeReport ) then
   begin
      result := fCompoundTaxAmount;
   end else
   begin
{
      taxRec := tax_ReturnCompoundTaxRate( LineItemTotal + FeeItemTotal + ShippingTotal );
      if ( taxRec.taxRate <> 0 ) then
}
      taxRate := Tax_TaxRateTotalCompoundTaxByMasterTaxClassID( LineItemTotal + FeeItemTotal + ShippingTotal, fmOrdTaxID );
      if ( taxRate <> 0 ) then
      begin
         subTotal := (LineItemTotal + FeeItemTotal + ShippingTotal);
         CompoundTotal := (  subTotal * Tax_PerformTaxCalculation( taxRate ) );
         CompoundTotal := RoundTo( CompoundTotal, -2);
      end;
      //
{
      if (fWaveTax) then
         CompoundTotal := 0.00;
}
      { STORE THE CompoundTotal NOW }
      fCompoundTaxAmount := CompoundTotal;
      result := CompoundTotal;
   end;
end;

function tInvoice.fGetAmountTotal: currency;
var
   LineItemTotal : currency;
   FeeItemTotal : currency;
   ShippingTotal : currency;
begin
   // initalize
   LineItemTotal := 0.00;
   FeeItemTotal := 0.00;
   ShippingTotal := 0.00;
   // Line Items
   LineItemTotal := LineItems.Amount_LineItemSubTotal;
   if (NOT fWaveTax) then
   	LineItemTotal := LineItemTotal + LineItems.Amount_TotalTax;
   // Fees
   FeeItemTotal := FEELineItems.AmountSubTotal;
   if (NOT fWaveTax) then
      FeeItemTotal := FeeItemTotal + FEELineItems.AmountTotalTax;
   // Shipping
   ShippingTotal := Amount_ShippingSubTotal;
   if (NOT fWaveTax) then
      ShippingTotal := ShippingTotal + Amount_TotalShippingTax;
   // Finished, add them
   result := LineItemTotal + FeeItemTotal + ShippingTotal + Amount_TotalCompoundTax;
end;

function tInvoice.fGetAmountVoid: currency;
begin
   result := MOPLineItems.AmountVoid;
end;

function tInvoice.fGetAmount_Total_RCOST: currency;
begin
   result := LineItems.Amount_Total_RCOST;
end;

function tInvoice.fGetAmount_Total_SCOST: currency;
begin
   result := LineItems.Amount_Total_SCOST;
end;

function tInvoice.fGetAmount_Total_YCOST: currency;
begin
   result := LineItems.Amount_Total_YCOST;
end;

function tInvoice.fGetBackOrderCount: integer;
begin
   result := LineItems.BackOrderCount;
end;

procedure tInvoice.fSetmTaxID(inValue: string);
begin
   fmShipTaxID := inValue;
   RecalculateInvoice();
end;

function tInvoice.fGetmTaxID: string;
begin
   result := fmShipTaxID;
end;

// oh my god this took time to code right.....
function tInvoice.fGetFeeItemTaxWaved: currency;
begin
   result := 1.0;
end;

function tInvoice.fGetLineItemTaxWaved: currency;
begin
   result := 1.0;

end;

function tInvoice.fGetShippingTaxWaved: currency;
begin
   result := 1.0;

end;

function tInvoice.fGetOrderTaxWaved: currency;
begin
   result := fExOrdTax;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

procedure tInvoice.HandleDeleteLine(sender: tObject; lineNum: integer);
begin

end;

{ this is from all levels saying HEY RECALCULATE }
procedure tInvoice.HandleRecalculateInvoice;
begin
   if (fRecalcON) then
   begin
      RecalculateInvoice();
      // tell anyone else THEY need to recalculate
      if Assigned(eRecalculateInvoiceEvent) then
         eRecalculateInvoiceEvent();
   end;
end;

procedure tInvoice.HandleUpdateLine(sender: tObject; lineNum: integer);
begin

end;

procedure tInvoice.TabBackward;
begin

end;

procedure tInvoice.TabForward;
begin

end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'New, Load, Save, Delete, Finalize - Order'}

function tInvoice.Load(inOrderID: string): tErrorResult;
var
	sql : String;
begin
	// Clear all previous data
   result := Error_Init;

   // Setup the Query
   try
      fRecalcON := false;
      sql := 'SELECT * FROM ' + masterData.GetTable_Order + ' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      //
      fOrderQuery.Close();
      fOrderQuery.SQL.Text := sql;
      fOrderQuery.Open();
      //
      if ( fOrderQuery.RecordCount = 0 ) then
      begin
         result.errorResult := true;
         result.errorMessage := 'Order Not Found';
         exit;
      end;


      // We ONLY put the original order into EDIT mode IF it is actually an Order. Not reports, otherwise
      // they always stay in edit mode and lock records.
      if (fInvoiceType = InvoiceTypeOrder) then
         fOrderQuery.Edit();


      // Setup internal object fParameters
      fOrderId := inOrderId;
      fOrderNum := fOrderQuery.FieldByName('ONUM').AsInteger;
      fCustSoldID := fOrderQuery.FieldByName('C_STID').AsString;
      fCustShipID := fOrderQuery.FieldByName('C_SHID').AsString;
      fCycleID := fOrderQuery.FieldByName('C_ID').AsString;
      fOrgID := fOrderQuery.FieldByName('ORG_ID').AsString;
      fOrderDate := fOrderQuery.FieldByName('ODATE').AsDateTime;
      fOrderTime := fOrderQuery.FieldByName('OTIME').AsDateTime;
      fStatus := tOrderStatusTypes(fOrderQuery.FieldByName('STATUS').AsInteger);
      fWaveTax := fOrderQuery.FieldByName('WTAX').AsBoolean;
      fWaveShipping := fOrderQuery.FieldByName('WSHIP').AsBoolean;
      fShowDiscount := fOrderQuery.FieldByName('SHOW_DISC').AsBoolean;
      fOrderType :=  tOrderTypes(fOrderQuery.FieldByName('O_TYPE').AsInteger);
      fInvoiceMsg := fOrderQuery.FieldByName('I_MSG').AsString;
      fShippingAmount := fOrderQuery.FieldByName('SHIPAMT').AsCurrency;
      fShippingTaxAmount := fOrderQuery.FieldByName('SHIPTAXAMT').AsCurrency;
      fShippingTaxRate := fOrderQuery.FieldByName('SHIPTAX').AsFloat;
      fCompoundTaxAmount := fOrderQuery.FieldByName('CTAXAMT').AsCurrency;
      fmShipTaxID := fOrderQuery.FieldByName('SHIPTAXID').AsString;
      fmOrdTaxID := fOrderQuery.FieldByName('ORDTAXID').AsString;
      fTaxExID := fOrderQuery.FieldByName('TAXEXID').AsString;
      fExOrdTax := fOrderQuery.FieldByName('EXORDTAX').AsCurrency;

      (**** THESE MUST BE LAST ****)

      // load the line items
      LineItems.OrgID := fOrgID;
      LineItems.OrderID := fOrderID;
      LineItems.CycleID := fCycleID;
      LineItems.OrderType := fOrderType;
      LineItems.Load( inOrderID );

      // Load the Fees
      FeeLineItems.OrgID := fOrgID;
      FeeLineItems.OrderID := fOrderID;
      FeeLineItems.CycleID := fCycleID;
      FeeLineItems.OrderType := fOrderType;
      FEELineItems.Load( inOrderID );

      // Load the Method Of Payments
      MOPLineITems.OrgID := fOrgID;
      MOPLineITems.OrderID := fOrderID;
      MOPLineITems.CycleID := fCycleID;
      MOPLineITems.CustID := fCustSoldID;
      MOPLineItems.EscrowCredit := fEscrowCredit;
      MOPLineItems.Load( inOrderID );


      fRecalcON := true;

      // Recalculate
      RecalculateInvoice();
      if Assigned(eRecalculateInvoiceEvent) then
         eRecalculateInvoiceEvent();

   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

function tInvoice.New(inOrderId , inOrgID, inCycleID, inCustID : string): tErrorResult;
var
	sql : String;
begin
   try
      fRecalcON := false;
      //
      fOrgID := inOrgID;
      fOrderID := inOrderID;
      fCycleID := inCycleID;
      fOrderType := OrdTypeOrder;

      sql := 'SELECT * FROM ' + masterData.GetTable_Order + ' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      //
      fOrderQuery.Close();
      fOrderQuery.SQL.Text := sql;
      fOrderQuery.Open();
      fOrderQuery.Append();
      fOrderQuery.FieldByName('ID').AsString := InOrderID;

      //
      LineItems.OrgID := fOrgID;
      LineItems.OrderID := fOrderID;
      LineItems.CycleID := fCycleID;
      LineItems.OrderType := fOrderType;
      LineItems.AddBlankLineItem;

      // Add any fees
      FeeLineItems.OrgID := fOrgID;
      FeeLineItems.OrderID := fOrderID;
      FeeLineItems.CycleID := fCycleID;
      FeeLineItems.OrderType := fOrderType;
      FeeLineItems.Add_Org_Fees( fOrgID );

      // Method of Payment
      MOPLineITems.OrgID := fOrgID;
      MOPLineITems.OrderID := fOrderID;
      MOPLineITems.CycleID := fCycleID;
      MOPLineITems.CustID := inCustID;
      MOPLineItems.EscrowCredit := fEscrowCredit;

      // Setup internal object fParameters
      fOrderNum := 0; // this is set AFTERWARD
      fOrderID := inOrderID;
      fCustSoldID := inCustID;
      fCycleID := inCycleID;
      fOrderDate := Now;
      fOrderTime := Now;
      fStatus := OrderStatusOpen;
      fWaveTax := false;
      fShowDiscount := Pref_GetBoolean(tPrefConstants.InvoiceShowDiscount, True);
      fOrderType := OrdTypeOrder;
   	fInvoiceType := InvoiceTypeOrder;
      fInvoiceMsg := ''; // <--- THIS HAS TO COME FROM THE ORG LEVEL
      fShippingAmount := 0.00;
      fCompoundTaxAmount := 0.00;
      fmShipTaxID := Pref_GetPrefGUID(tPrefConstants.DSHIPTAXID); // default shipping master tax ID
      fmOrdTaxID := Pref_GetPrefGUID(tPrefConstants.DORDTAXID); // default order master tax ID for compound tax
      fTaxExId := '';


      // setup values based on in passed values
      if ( fCustSoldID <> '') then
      begin
         // go load the customer and bring in that shit
      end;

      // LAST ITEM
      fRecalcON := true;

      // Recalculate
      RecalculateInvoice();
      if Assigned(eRecalculateInvoiceEvent) then
         eRecalculateInvoiceEvent();

   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

// Save the Invoice
function tInvoice.Save : tErrorResult;
begin
	result := Error_Init;
   //
	if (Save_CheckOrder) then
   begin
      fOrderQuery.FieldByName('ONUM').AsInteger := fOrderNum;
      fOrderQuery.FieldByName('C_STID').AsString := fCustSoldID;
      fOrderQuery.FieldByName('C_SHID').AsString := fCustShipID;
      fOrderQuery.FieldByName('C_ID').AsString := fCycleID;
      fOrderQuery.FieldByName('ORG_ID').AsString := fOrgID;
      fOrderQuery.FieldByName('ODATE').AsDateTime := fOrderDate;
      fOrderQuery.FieldByName('OTIME').AsDateTime := fOrderTime;
      fOrderQuery.FieldByName('STATUS').AsInteger := integer(fStatus);
      fOrderQuery.FieldByName('WTAX').AsBoolean :=  fWaveTax;
      fOrderQuery.FieldByName('WSHIP').AsBoolean :=  fWaveShipping;
      fOrderQuery.FieldByName('SHOW_DISC').AsBoolean := fShowDiscount;
      fOrderQuery.FieldByName('O_TYPE').AsInteger := integer(fOrderType);
      fOrderQuery.FieldByName('I_MSG').AsString := fInvoiceMsg;
      fOrderQuery.FieldByName('SHIPAMT').AsCurrency := ( Amount_ShippingSubTotal );
      fOrderQuery.FieldByName('SHIPTAXAMT').AsCurrency := ( Amount_TotalShippingTax );
      fOrderQuery.FieldByName('SHIPTAX').AsFloat := fShippingTaxRate;
      fOrderQuery.FieldByName('CTAXAMT').AsCurrency := fCompoundTaxAmount;
      fOrderQuery.FieldByName('SHIPREF').AsBoolean :=  False; // open orders don't have their shipping refunded. always set to false.
      fOrderQuery.FieldByName('SHIPTAXID').AsString := fmShipTaxID;
      fOrderQuery.FieldByName('ORDTAXID').AsString := fmOrdTaxID;
      fOrderQuery.FieldByName('EXORDTAX').AsCurrency := fExOrdTax;
      fOrderQuery.FieldByName('TAXEXID').AsString := fTaxExID;

      // Save the Invoice Line Items
      LineItems.Save();
      // Save the Method of Payment
      MOPLineItems.Save();
      // Save the FEES
      FEELineItems.Save();

      fOrderQuery.Post;
      // Now back in edit mode

      // take any order products that are marked as back ordered and move them into the back ordered table
      Product_MoveBackOrderedProduct( fOrderID, fCustSoldID );

      result.AsBoolean := false;
   end else
   	begin
			result.AsBoolean := true;
      end;
end;

function tInvoice.Delete(inOrderID: string): tErrorResult;
begin
   { We are NOT going to handle deleting an order here. We will do it in the Order_ControlFormUnit. }
end;

function tInvoice.Finalize: tErrorResult;
var
   errMsg : string;
   tempErrMsg : string;
   orderFinalForm : tOrder_FinalizationForm;
   EscrowSelect : TEscrow_SelectEscrow;
   TranRec : tTransRec;
   hasBackOrder : boolean;

begin
   result := Error_Init;
   errMsg := '';
   tempErrMsg := '';
   //
   if (Customer_SoldToID = '') then
   	errMsg := errMsg + '* Order must have a Customer.\n\n';
   //
   if (Amount_TotalDue > 0) then
      errMsg := errMsg + '* Order has an amount due totalling ' + Pref_GetCashSymbol + FormatCurrency(Amount_TotalDue) + '\n\n';
   //
   if (LineItems.Count = 0) then
      errMsg := errMsg +  '* Order must contain at least 1 Product (Line Item).\n\n';
   //
   if (fStatus = OrderStatusClosed) then
      errMsg := errMsg + '* Order is already Closed.\n\n';

   tempErrMsg := LineItems.CheckSave();
   if ( tempErrMsg <> '' ) then
      errMsg := errMsg + '*' + tempErrMsg + '\n\n';

   tempErrMsg := MOPLineItems.CheckSave();
   if ( tempErrMsg <> '' ) then
      errMsg := errMsg + '*' + tempErrMsg + '\n\n';

   tempErrMsg := FEELineItems.CheckSave();
   if ( tempErrMsg <> '' ) then
      errMsg := errMsg + '*' + tempErrMsg + '\n\n';

   //
   if ( errMsg <> '') then
   begin
      orderFinalForm := tOrder_FinalizationForm.Create( Application, formTypeError );
      //
      orderFinalForm.FormErrors := errMsg;
      orderFinalForm.orgID := self.fOrgID;
      orderFinalForm.OrderNumName := self.Order_GetOrderNumberName;
      orderFinalForm.CustID := fCustSoldID;
      orderFinalForm.CycleID := fCycleID;
      orderFinalForm.AmountOverPaid := Self.Amount_OverPaid;
      orderFinalForm.AmountDue := Self.Amount_TotalDue;
      orderFinalForm.AmountPaid := Self.Amount_TotalMOP;
      orderFinalForm.AmountShippingSubTotal := Self.Amount_ShippingSubTotal;
      orderFinalForm.AmountTotal := Self.Amount_Total;
      orderFinalForm.AmountTotalTax := Self.Amount_TotalTax;
      orderFinalForm.AmountFeeSubTotal := Self.Amount_FeeTotal;
      orderFinalForm.AmountLineItemSubTotal := Self.Amount_LineItemTotal;
      //
      orderFinalForm.ShowModal();
      result.errorResult := true;
   end else
      begin
         orderFinalForm := tOrder_FinalizationForm.Create( Application, formTypeOk );
         // fill in information
         orderFinalForm.orgID := self.fOrgID;
         orderFinalForm.OrderNumName := self.Order_GetOrderNumberName;
         orderFinalForm.CustID := fCustSoldID;;
         orderFinalForm.CycleID := fCycleID;
         orderFinalForm.AmountOverPaid := Self.Amount_OverPaid;
         orderFinalForm.AmountDue := Self.Amount_TotalDue;
         orderFinalForm.AmountPaid := Self.Amount_TotalMOP;
         orderFinalForm.AmountShippingSubTotal := Self.Amount_ShippingSubTotal;
         orderFinalForm.AmountTotal := Self.Amount_Total;
         orderFinalForm.AmountTotalTax := Self.Amount_TotalTax;
         orderFinalForm.AmountFeeSubTotal := Self.Amount_FeeTotal;
         orderFinalForm.AmountLineItemSubTotal := Self.Amount_LineItemTotal;
         //
         orderFinalForm.ShowModal();
         //
         hasBackOrder := LineItems.HasBackOrder;
         //
         if ( orderFinalForm.CloseAction = actionConfirm ) then
         begin
            PercentForm_Create('Closing/Finalizing Order - One Moment Please...', 0, 0);
            // set the order to closed
            //
            fStatus := OrderStatusClosed;
            if (fInvoiceType = InvoiceTypeOrder) then
            begin
               // we are IN the invoice
               Save();
            end else
               begin
                  // we are OUTSIDE the invoice
                  fOrderQuery.Edit();
                  fOrderQuery.FieldByName('STATUS').AsInteger := integer(OrderStatusClosed);
                  fOrderQuery.Post();
               end;
            // mark all the invoice line items as sold
            LineItems.MarkLineItemsSold();
            // take the order products and copy them into the products table
            // This also updates the QTY for products. So this can't be stopped!
            Product_MoveOrderProductToProduct( fOrderID );
            //
            Payment_MovePaymentToTransactions( fOrderID );
            //
            Payment_SubtractEscrowByOrderID( fOrderID, fCustSoldID );
            //
            if ( Amount_OverPaid > 0 ) then
            begin
               PercentForm_Free();
               TranRec.id := masterData.NewDBGuid();
               tranRec.disp_msg := 'The Order has been closed, however, there has been an over-payment on the Order.\n\n' +
                  'Total over-payment amount: ' + Pref_GetCashSymbol + FormatCurrency( Amount_OverPaid ) + '\n\n' +
                  'A refund must be issued in the form of Cash, Check or Escrow.\n\n' +
                  'If issued as Escrow, the transaction can be used on any future Invoice by this Customer.';
               tranRec.order_id := fOrderID;
               tranRec.c_stid := fCustSoldID;
               tranRec.c_id := fCycleID;
               tranRec.amount := Amount_OverPaid;
               EscrowSelect := TEscrow_SelectEscrow.Create( Application, 'Select Return Escrow', True, TranRec);
               EscrowSelect.ShowModal();
               // DO NOT FREE, form is a caFREE upon closure.
            end;
            //
            PercentForm_Free();
            //
            if ( hasBackOrder ) then
               AvoBaseDialog('Back Ordered Products',
                  'This Order has Back-Ordered Products. Those Products have been moved into the ' +
                  'Back-Order Manager.', mtInformation, [mbOk], 0);
         end else
            result.errorResult := true;
      end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Methods and Functions'}

procedure tInvoice.Order_SetOrderNumber(inVal: integer);
begin
   fOrderNum := inVal;
   if Assigned(eRecalculateInvoiceEvent) then
      eRecalculateInvoiceEvent();
end;

// Only validate that we CAN save the invoice, this does NOT save it
function tInvoice.Save_CheckOrder : boolean;
var
   errMsg : string;
   lineErr : string;
   mopErr : string;
   feeErr : string;
begin
	errMsg := '';

   if (Customer_SoldToID = '') then
   	errMsg := 'Order cannot be saved without a Customer. Please add a Customer first.';

   // check line item issues
   lineErr := LineItems.CheckSave();
   if ( lineErr <> '') and ( errMsg = '') then
      errMsg := lineErr;

   // check Method of Payment
   mopErr := MOPLineItems.CheckSave();
   if ( mopErr <> '') and ( errMsg = '') then
      errMsg := mopErr;

   // check Fee Issues
   feeErr := FEELineItems.CheckSave();
   if ( feeErr <> '') and ( errMsg = '') then
      errMsg := feeErr;

   if ( Order_WaveOrderTax ) then
      if ( fTaxExID = '' ) then
         errMsg := 'Order Tax Exempt has been selected. Tax Exempt ID cannot be left blank.';

   // ====================== Final ====================
   if (errMsg <> '') then
   begin
      PercentForm_Free(); // just in case there is one
      AvoBaseDialog('Unable to save Order', errMsg, mtWarning, [mbOK], 0);
   end;

   result := (ErrMsg = '');
end;

procedure tInvoice.RecalculateInvoice;
begin
   if (fRecalcON)  then
   begin
      LineItems.RecalculateInvoice();
      FEELineItems.RecalculateInvoice();
      MOPLineItems.RecalculateInvoice();
   end;
end;

procedure tInvoice.LineItem_DeleteLineItem;
begin
   LineItems.DeleteLine;
end;

procedure tInvoice.MOP_AddBlankMOP;
begin
   RecalculateInvoice();
   MOPLineItems.AddBlankLineItem( Amount_TotalDue );
   MOPLineItems.DoLineColor();
   RecalculateInvoice();
   // Tell the Order Editor to Update
   if Assigned(eRecalculateInvoiceEvent) then
      eRecalculateInvoiceEvent();
end;

procedure tInvoice.MOP_DeleteMOPItem;
begin
   MOPLineItems.DeleteLine;
   MOPLineItems.DoLineColor();
end;

procedure tInvoice.MOP_AddEscrowMOP;
var
   Amount_EscrowUsed : currency;
   Amount_AvailEscrow : currency;
begin
   Amount_EscrowUsed := MOPLineItems.Amount_Escrow;
   Amount_AvailEscrow := Escrow_GetCustomerEscrowByCustomerID( Customer_SoldToID );
   //
   if ( Amount_EscrowUsed >= Amount_AvailEscrow ) then
      AvoBaseDialog('Amount Exceeds Escrow', 'Insufficient Escrow Available - (Available + Already Used).', mtError, [mbOK], 0)
   else
      begin
         MOPLineItems.AddEscrowMOP( Amount_TotalDue, Amount_AvailEscrow, Amount_EscrowUsed, Amount_TotalMOP );
         MOPLineItems.DoLineColor();
      end;
end;

procedure tInvoice.Fee_DeleteFeeItem;
begin
   FeeLineItems.DeleteLine;
end;

procedure tInvoice.Fee_AddBlankFee;
begin
   FEELineItems.AddBlankLineItem();
   FEELineItems.DoLineColor();
end;

procedure tInvoice.LineItem_AddBlankLine;
begin
   LineItems.AddBlankLineItem();
   LineItems.DoLineColor();
end;

procedure tInvoice.Fee_AddFeeBySelect;
begin
   FEELineItems.AddFeeSelect();
   LineItems.DoLineColor();
end;

procedure tInvoice.Clear;
begin
	// clear the invoice, all values
   // clear the method of payment
   // clear the invoice line items
   // clear the fees
end;

procedure tInvoice.LineItem_AddProductByProductID(inID: string);
begin
   LineItems.AddProduct( inID );
   LineItems.DoLineColor();
end;

function tInvoice.Edit: tErrorResult;
begin
   result := Error_Init;
   fOrderQuery.Edit();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.





