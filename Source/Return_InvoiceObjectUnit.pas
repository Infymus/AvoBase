 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_InvoiceObjectUnit;

interface uses
	constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   avobase_dialogformunit,
   avobase_percentformunit,
   masterdata_BaseDataClassUnit,
   //
   Return_LineItemControlObjectUnit,
   Return_FEEItemControlObjectUnit,
   //
   toolbox_cycletoolboxunit,
   toolbox_PreferenceToolBoxUnit,
   toolbox_ordertoolboxunit,
   toolbox_customertoolboxunit,
   recordstructureunit,
   toolbox_orgtoolboxunit,
   toolbox_shippingtoolboxunit,
   toolbox_taxtoolboxunit,
   toolbox_paymenttoolboxunit,
   toolbox_producttoolboxunit,
   toolbox_feetoolboxunit,
   //
   Return_FinalizationFormUnit,
   Escrow_SelectEscrowFormUnit,
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
	tReturnInvoice = class( tObject )
   private
      // ----------------------------------------------------------------------------- //
      fOrderSaved: boolean;
      fReturnOrderID : string;
      fOrderID : string;
      fReturnID : string;
      fCustSoldID : string;
      fCustShipID : string;
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
      fRefundShipping : boolean;
      fAmountPriorVoided : currency;

      // ----------------------------------------------------------------------------- //
      // Dock Areas and other objects we have to control
      fLineItemDock : tScrollBox;
      fFeeDock : tScrollBox;

      // ----------------------------------------------------------------------------- //
      // Dock Areas and other objects we have to control
      LineItems : tLineItemControlObject;
      FEELineItems : tReturnFEEItemControlObject;

      // Events
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;
      eInvoiceUpdatedEvent : tInvoiceUpdatedEvent;
   	fSomeKindOfNewEvent : tNotifyEvent; { a brand new event }
      fSomeKindofEvent : eSomeKindOfEvent; { see above }
      fOnNewLine : TNotifyEvent;

      // ----------------------------------------------------------------------------- //
      // All associated Queries
      fReturnQuery : tQuery;

      // ----------------------------------------------------------------------------- //
      function fGetOrderID : string;
      function fGetOrderType: tOrderTypes;
      function fGetOrderTypeName : string;
      function fGetOrgName: string;
      function fGetCustName : string;
      function fGetCycleName : string;
      function fGetAmountTotal : currency;
		function fGetAmountPaid : currency;
      function fGetAmountRefund : currency;
      function fGetOrderStatusName : string;
      function fGetTaxRate : double;
      function fGetAmountOverPaid : currency;
      function fGetAmountLineItemSubTotal : currency;
      function fGetAmountFeeSubTotal : currency;
      function fGetOrderNumName : string;
      function fGetAmountTax : currency;
      function fGetCompoundTax : currency;
		function fGetAmountShippingSubTotal : currency;
      function fGetAmountShippingTax : currency;
      function Save_CheckOrder : boolean;
      function fOrderNotSaved : boolean;
      function fGetAmountPriorVoided : currency;
      function fGetAmountShippingREALSubTotal : currency;
      function fGetShippingREALTotalTax : currency;
      function fGetLineItemCount : integer;
      function fGetFeeItemCount : integer;
      function fGetAmountCredit : currency;
      function fGetOrderDate : tDateTime;
      function fGetPriorOrderNumberName : string;
      function fGetAmount_TotalRetail : currency;
      function fGetAmount_TotalSellAt : currency;
      //
		procedure HandleRecalculateInvoice;
      procedure fSetCustSoldID( inValue : String );
   public
      // ----------------------------------------------------------------------------- //
   	// functions
      function NewReturn(inOrderId : string): tErrorResult;
      function Load( inOrderID : string ) : tErrorResult;
      function Delete( inOrderID : string ) : tErrorResult;
      function Save : tErrorResult;
      function Edit : tErrorResult;
      function Finalize : tErrorResult;

      // ----------------------------------------------------------------------------- //
      // procedures
      procedure Clear;
		procedure RecalculateInvoice;
      procedure AddBlankFee;
      procedure AddFeeSelect();
      procedure DeleteLineItem;
      procedure DeleteFeeItem;
      procedure ReturnAllLineItems( inVal : boolean );
      procedure ReturnAllFeeItemsCheck( inVal : boolean );
      procedure OrderNumberSet( inVal : integer );

      // ----------------------------------------------------------------------------- //
      // Properties
      property Amount_Total : currency read fGetAmountTotal;
      property Amount_TotalMOP : currency read fGetAmountPaid;
      property Amount_OverPaid : currency read fGetAmountOverPaid;
      property Amount_LineItemTotal : currency read fGetAmountLineItemSubTotal;
      property Amount_FeeTotal : currency read fGetAmountFeeSubTotal;
      property Amount_TotalTax : currency read fGetAmountTax;
      property Amount_CompoundTax : currency read fGetCompoundTax write fCompoundTaxAmount;
      property Amount_TotalRefund : currency read fGetAmountRefund;
      property Amount_TotalPriorVoidNSF : currency read fGetAmountPriorVoided;
      property Amount_TotalCredit : currency read fGetAmountCredit;
      property Amount_ShippingTaxRate : double read fShippingTaxRate write fShippingTaxRate;
      property Amount_ShippingTotal : currency read fGetAmountShippingSubTotal;
      property Amount_ShippingTotalTax : currency read fGetAmountShippingTax;
      property AmountShippingREALSubTotal : currency read fGetAmountShippingREALSubTotal;
      property AmountShippingREALTotalTax : currency read fGetShippingREALTotalTax;
      property Amount_TotalRetail : currency read fGetAmount_TotalRetail;
      property Amount_TotalSellAt : currency read fGetAmount_TotalSellAt;

      property Customer_GetSoldToName : string read fGetCustName;
      property Cycle_GetCycleName : string read fGetCycleName;
      property CycleID : string read fCycleID;
      property CustSoldToID : string read fCustSoldID write fSetCustSoldID;
      property CustShipToID : string read fCustShipID write fCustShipID;

      property FeeLineCount : integer read fGetFeeItemCount;

      property ID : string read fGetOrderID;
      property Order_Message : string read fInvoiceMsg write fInvoiceMsg;
      property LineItemCount : integer read fGetLineItemCount;


      property OrgID : string read fOrgID;
      property OrgName : string read fGetOrgName;
      property OrderType : tOrderTypes read fGetOrderType;
      property Order_GetOrderTypeName : string read fGetOrderTypeName;
      property Order_GetOrderStatusName : string read fGetOrderStatusName;
      property Order_GetOrderNum : integer read fOrderNum;
      property Order_GetOrderNumberName : string read fGetOrderNumName;
      property OrderNotSaved : boolean read fOrderNotSaved;
      property Order_GetOrderDate : tDateTime read fGetOrderDate;

      property PriorOrderID : string read fReturnOrderID;
      property RefundShipping : boolean read fRefundShipping write fRefundShipping;
      property ShowDiscount : boolean read fShowDiscount write fShowDiscount;
      property TaxRate :  double read fGetTaxRate;
      property WaveTax : boolean read fWaveTax write fWaveTax;
      property WaveShipping : boolean read fWaveShipping write fWaveShipping;
      property PriorOrderNumberName : string read fGetPriorOrderNumberName;
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
      constructor Create( inOrderType : tInvoiceTypes; lineItemDock, feeDock : tScrollBox );
      destructor destroy; override;
  end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tReturnInvoice.Create( inOrderType : tInvoiceTypes; lineItemDock, feeDock : tScrollBox );
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
   fLineItemDock := lineItemDock;
   fFeeDock := feeDock;

   //
   LineItems := tLineItemControlObject.create( fLineItemDock, fInvoiceType);
   LineItems.OnRecalculateInvoiceEvent := HandleRecalculateInvoice;
   //
	FEELineItems := tReturnFEEItemControlObject.Create( fFEEDock, fInvoiceType);
   FeeLineItems.OnRecalculateInvoiceEvent := HandleRecalculateInvoice;
   //
   fReturnQuery := masterData.GetQuery();
   fReturnQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_order;
end;

destructor tReturnInvoice.Destroy;
begin
   if (fReturnQuery.State in [dsEdit, dsInsert]) then
      fReturnQuery.Cancel();
   //
   FreeAndNil(LineItems);
   FreeAndNil(FEELineItems);
   FreeAndNil(fReturnQuery);
   //
   inherited Destroy();
end;

function tReturnInvoice.Edit: tErrorResult;
begin
   result := Error_Init;
   fReturnQuery.Edit();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.Load(inOrderID: string): tErrorResult;
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
      fReturnQuery.Close();
      fReturnQuery.SQL.Text := sql;
      fReturnQuery.Open();

      // We ONLY put the original order into EDIT mode IF it is actually an Order. Not reports, otherwise
      // they always stay in edit mode and lock records.
      if (fInvoiceType = InvoiceTypeOrder) then
         fReturnQuery.Edit();

      // Setup internal object fParameters
      fOrderId := inOrderId;
      fOrderNum := fReturnQuery.FieldByName('ONUM').AsInteger;
      fCustSoldID := fReturnQuery.FieldByName('C_STID').AsString;
      fCustShipID := fReturnQuery.FieldByName('C_SHID').AsString;
      fReturnOrderID := fReturnQuery.FieldByName('RET_ID').AsString;
      fCycleID := fReturnQuery.FieldByName('C_ID').AsString;
      fOrgID := fReturnQuery.FieldByName('ORG_ID').AsString;
      fOrderDate := fReturnQuery.FieldByName('ODATE').AsDateTime;
      fOrderTime := fReturnQuery.FieldByName('OTIME').AsDateTime;
      fStatus := tOrderStatusTypes(fReturnQuery.FieldByName('STATUS').AsInteger);
      fWaveTax := fReturnQuery.FieldByName('WTAX').AsBoolean;
      fWaveShipping := fReturnQuery.FieldByName('WSHIP').AsBoolean;
      fShowDiscount := fReturnQuery.FieldByName('SHOW_DISC').AsBoolean;
      fOrderType :=  tOrderTypes(fReturnQuery.FieldByName('O_TYPE').AsInteger);
      fInvoiceMsg := fReturnQuery.FieldByName('I_MSG').AsString;
      fShippingAmount := fReturnQuery.FieldByName('SHIPAMT').AsCurrency;
      fShippingTaxAmount := fReturnQuery.FieldByName('SHIPTAXAMT').AsCurrency;
      fShippingTaxRate := fReturnQuery.FieldByName('SHIPTAX').AsFloat;
      fCompoundTaxAmount := fReturnQuery.FieldByName('CTAXAMT').AsCurrency;
      fRefundShipping := fReturnQuery.FieldByName('REFSHIP').AsBoolean;

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

      // Recalculate
      fRecalcON := true;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.NewReturn(inOrderId : string): tErrorResult;
var
	sql : String;
begin
   try
      fRecalcON := false;

      // First, we have to load the prior order and set everything in place. Then,
      // we turn around and create a NEW order, and APPEND out with that said ID.

      //
      sql := 'SELECT * FROM ' + masterData.GetTable_Order + ' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      //
      fReturnQuery.Close();
      fReturnQuery.SQL.Text := sql;
      fReturnQuery.Open();

      // Now set the variables we WANT to set for a RETURN, so we DON'T PULL them from the original ORDER
      fOrderType := OrdTypeReturn;

      // Now, we load all the original information
      fOrderId := inOrderId;
      fReturnOrderID := inOrderID;
      fOrderNum := fReturnQuery.FieldByName('ONUM').AsInteger;
      fCustSoldID := fReturnQuery.FieldByName('C_STID').AsString;
      fCustShipID := fReturnQuery.FieldByName('C_SHID').AsString;
      fCycleID := fReturnQuery.FieldByName('C_ID').AsString;
      fOrgID := fReturnQuery.FieldByName('ORG_ID').AsString;
      fOrderDate := fReturnQuery.FieldByName('ODATE').AsDateTime;
      fOrderTime := fReturnQuery.FieldByName('OTIME').AsDateTime;
      fStatus := tOrderStatusTypes(fReturnQuery.FieldByName('STATUS').AsInteger);
      fWaveTax := fReturnQuery.FieldByName('WTAX').AsBoolean;
      fWaveShipping := fReturnQuery.FieldByName('WSHIP').AsBoolean;
      fShowDiscount := fReturnQuery.FieldByName('SHOW_DISC').AsBoolean;
      fInvoiceMsg := fReturnQuery.FieldByName('I_MSG').AsString;
      fShippingAmount := fReturnQuery.FieldByName('SHIPAMT').AsCurrency;
      fShippingTaxAmount := fReturnQuery.FieldByName('SHIPTAXAMT').AsCurrency;
      fShippingTaxRate := fReturnQuery.FieldByName('SHIPTAX').AsFloat;
      fCompoundTaxAmount := fReturnQuery.FieldByName('CTAXAMT').AsCurrency;

      // Was the prior shipping ALREADY returned? If so, we want to kiss that shit off
      if ( fReturnQuery.FieldByName('SHIPREF').AsBoolean ) then
      begin
         fShippingTaxRate := 0.00;
         fShippingAmount := 0.00;
      end;

      // load the line items
      LineItems.OrgID := fOrgID;
      LineItems.OrderID := fOrderID;
      LineItems.CycleID := fCycleID;
      LineItems.OrderType := fOrderType;
      LineItems.LoadNewReturn( inOrderID );

      // Load the Fees
      FeeLineItems.OrgID := fOrgID;
      FeeLineItems.OrderID := fOrderID;
      FeeLineItems.CycleID := fCycleID;
      FeeLineItems.OrderType := fOrderType;
      FEELineItems.LoadNewReturn( inOrderID );

      // Now, we CLOSE the file
      fReturnQuery.Close();

      // Now we open it back up for reading as if it were NEW and set a NEW
      // OrderID, Date, Time, and STATUS
      fOrderID := masterData.NewDBGuid;
      sql := 'SELECT * FROM ' + masterData.GetTable_Order + ' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fReturnQuery.SQL.Text := sql;
      fReturnQuery.Open();
      fReturnQuery.Append();
      fOrderNum := Order_GetNextOrderNumber;
      fOrderDate := Now;
      fOrderTime := Now;
      fStatus := OrderStatusOpen;

      // Set anything that has to do with a RETURN NOW..
      fReturnQuery.FieldByName('ID').AsString := fOrderID;
      fReturnQuery.FieldByName('REFSHIP').AsBoolean := False;

      // Reset both line items and Fee Items
      LineItems.OrderID := fOrderID;
      FeeLineItems.OrderID := fOrderID;

      // Now, add any ORG fees that are RETURN fees
      FEELineItems.Add_Org_Return_Fees(fOrgID);

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


procedure tReturnInvoice.OrderNumberSet(inVal: integer);
begin
   fOrderNum := inVal;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// Only validate that we CAN save the invoice, this does NOT save it
function tReturnInvoice.Save_CheckOrder : boolean;
var
   errMsg : string;
   lineErr : string;
   mopErr : string;
   feeErr : string;
begin
	errMsg := '';

   if (CustSoldToID = '') then
   	errMsg := 'Return cannot be saved without a Customer. Please add a Customer first.';

   // check line item issues
   lineErr := LineItems.CheckSave();
   if ( lineErr <> '') and ( errMsg = '') then
      errMsg := lineErr;

   // check Fee Issues
   feeErr := FEELineItems.CheckSave();
   if ( feeErr <> '') and ( errMsg = '') then
      errMsg := feeErr;

   if (errMsg <> '') then
   begin
      PercentForm_Free(); // just in case there is one
      AvoBaseDialog('Unable to ave Return', errMsg, mtWarning, [mbOK], 0);
   end;

   result := (ErrMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// Save the Invoice
function tReturnInvoice.Save : tErrorResult;
begin
	result := Error_Init;
   //
	if (Save_CheckOrder) then
   begin
      fReturnQuery.FieldByName('ONUM').AsInteger := fOrderNum;
      fReturnQuery.FieldByName('RET_ID').AsString := fReturnOrderID;
      fReturnQuery.FieldByName('C_STID').AsString := fCustSoldID;
      fReturnQuery.FieldByName('C_SHID').AsString := fCustShipID;
      fReturnQuery.FieldByName('C_ID').AsString := fCycleID;
      fReturnQuery.FieldByName('ORG_ID').AsString := fOrgID;
      fReturnQuery.FieldByName('ODATE').AsDateTime := fOrderDate;
      fReturnQuery.FieldByName('OTIME').AsDateTime := fOrderTime;
      fReturnQuery.FieldByName('STATUS').AsInteger := integer(fStatus);
      fReturnQuery.FieldByName('WTAX').AsBoolean :=  fWaveTax;
      fReturnQuery.FieldByName('WSHIP').AsBoolean :=  fWaveShipping;
      fReturnQuery.FieldByName('SHOW_DISC').AsBoolean := fShowDiscount;
      fReturnQuery.FieldByName('O_TYPE').AsInteger := integer(fOrderType);
      fReturnQuery.FieldByName('I_MSG').AsString := fInvoiceMsg;
      fReturnQuery.FieldByName('SHIPAMT').AsCurrency := ( AmountShippingREALSubTotal );
      fReturnQuery.FieldByName('SHIPTAXAMT').AsCurrency := ( AmountShippingREALTotalTax );
      fReturnQuery.FieldByName('SHIPTAX').AsFloat := fShippingTaxRate;
      fReturnQuery.FieldByName('CTAXAMT').AsCurrency := fCompoundTaxAmount;
      fReturnQuery.FieldByName('REFSHIP').AsBoolean := fRefundShipping;
      // Save the Invoice Line Items
      LineItems.Save();
      // Save the FEES
      FEELineItems.Save();

      fReturnQuery.Post;
      // Now back in edit mode

      // send an event so that any lists or what not will update
{
      if Assigned(eInvoiceUpdatedEvent) then
         eInvoiceUpdatedEvent();
}

      result.AsBoolean := false;
   end else
   	begin
			result.AsBoolean := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.Delete(inOrderID: string): tErrorResult;
begin
   { We are NOT going to handle deleting an order here. We will do it in the Order_ControlFormUnit. }
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnInvoice.RecalculateInvoice;
begin
   if (fRecalcON)  then
   begin
      LineItems.RecalculateInvoice();
      FEELineItems.RecalculateInvoice();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnInvoice.ReturnAllFeeItemsCheck(inVal: boolean);
begin
   FEELineItems.ReturnAllFeeItems( inVal );
end;

procedure tReturnInvoice.ReturnAllLineItems(inVal: boolean);
begin
   LineItems.ReturnAllLineItems( inVal );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnInvoice.DeleteFeeItem;
begin
   FeeLineItems.DeleteLine;
end;

procedure tReturnInvoice.DeleteLineItem;
begin
   LineItems.DeleteLine;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnInvoice.AddBlankFee;
begin
   FEELineItems.AddBlankLineItem();
   FEELineItems.DoLineColor();
end;

procedure tReturnInvoice.AddFeeSelect;
begin
   FEELineItems.AddFeeSelect();
   LineItems.DoLineColor();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnInvoice.Clear;
begin
   // this will probably never ever been done.
	// clear the invoice, all values
   // clear the method of payment
   // clear the invoice line items
   // clear the fees
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetCustName: string;
begin
   result := Customer_GetCustomerNameByCustID( fCustSoldID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetCycleName: string;
begin
   result := Cycle_GetCycleNameByCycleID( fCycleID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetFeeItemCount: integer;
begin
   result := FeeLineItems.Count;
end;

function tReturnInvoice.fGetLineItemCount: integer;
begin
   result := LineItems.Count;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetOrderDate: tDateTime;
begin
   result := fOrderDate;
end;

function tReturnInvoice.fGetOrderID: string;
begin
   result := fOrderID;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetOrderNumName: string;
begin
   result := IntToStr( fOrderNum );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetOrderStatusName : string;
begin
   case fStatus of
   	OrderStatusOpen : result := 'OPEN';
   	OrderStatusClosed : result := 'CLOSED';
   	OrderStatusCancelled : result := 'CANCELLED';
      else result := 'unknown';
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetOrderType: tOrderTypes;
begin
   result := fOrderType;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetOrderTypeName: string;
begin
	result := 'RETURN';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetOrgName: string;
begin
   result := Org_GetOrgNameByOrgID( fOrgID );
end;


function tReturnInvoice.fGetPriorOrderNumberName: string;
begin
   result := Order_GetOrderNumberByOrderID( fReturnOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetTaxRate: double;
begin

end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fOrderNotSaved: boolean;
begin
   Result := fReturnQuery.State in [dsEdit, dsInsert];
end;

procedure tReturnInvoice.fSetCustSoldID(inValue: String);
begin
   // set BOTH IDS here
   fCustSoldID := inValue;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnInvoice.HandleDeleteLine(sender: tObject; lineNum: integer);
begin

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ this is from all levels saying HEY RECALCULATE }
procedure tReturnInvoice.HandleRecalculateInvoice;
begin
   if (fRecalcON) then
   begin
      RecalculateInvoice();
      // tell anyone else THEY need to recalculate
      if Assigned(eRecalculateInvoiceEvent) then
         eRecalculateInvoiceEvent();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnInvoice.HandleUpdateLine(sender: tObject; lineNum: integer);
begin

end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountRefund: currency;
var
   LineItemTotal : currency;
   FeeItemTotal : currency;
   ShippingTotal : currency;
   amtVoid : currency;
   amtPaid : currency;
   amtCredit : currency;
   fullRefundTotal : currency;
   amtTotDebit : currency;
begin
   // initalize
   LineItemTotal := 0.00;
   FeeItemTotal := 0.00;
   ShippingTotal := 0.00;
   amtVoid := 0.00;
   amtPaid := 0.00;
   amtCredit := 0.00;
   fullRefundTotal := 0.00;
   // Line Items
   LineItemTotal := LineItems.AmountSubTotal;
   if (NOT fWaveTax) then
   	LineItemTotal := LineItemTotal + LineItems.AmountTotalTax;
   // Fees
   FeeItemTotal := FEELineItems.AmountSubTotal;
   if (NOT fWaveTax) then
      FeeItemTotal := FeeItemTotal + FEELineItems.AmountTotalTax;
   // Shipping
   if (NOT fWaveShipping) then
      ShippingTotal := Amount_ShippingTotal;
   if (NOT fWaveTax) then
         ShippingTotal := ShippingTotal + Amount_ShippingTotalTax;
   //
   // THIS AMOUNT : this is the amount of the return invoice
   fullRefundTotal := LineItemTotal + FeeItemTotal + ShippingTotal + Amount_CompoundTax;

   // Now, take off prior voided amounts

   amtVoid := Amount_TotalPriorVoidNSF; // Payment_GetAmountVoidedByOrderID( fReturnOrderID );
   amtPaid := Amount_TotalMOP; // Payment_GetAmountPaidMinusVoidByOrderID( fOrderID );
   amtCredit := Amount_TotalCredit; // Payment_GetAmountTransCreditByOrderID
   //
   amtPaid := amtPaid - amtVoid;
   amtPaid := amtPaid + amtCredit;



{

   AMOUNT OF REFUND REQUESTED:

      fullRefundTotal

   AMOUNT OF ALL PAYMENTS MADE

      Amount_TotalMOP

   AMOUNT OF ALL VOIDED PAYMENTS

      Amount_TotalPriorVoidNSF


}

   amtTotDebit := 0;

   amtPaid := Amount_TotalMOP - Amount_TotalPriorVoidNSF;

   if ( amtPaid <= 0 ) then
      amtTotDebit := 0 // no refund if amount paid < 0
   else
      begin
         // ok we have some money in the bucket
         if ( fullRefundTotal > amtPaid ) then
            amtTotDebit := amtPaid
         else
            amtTotDebit := fullRefundTotal;
      end;





{
the problem here is that if the prior amounts were voided, but then they paid on those
delinquencies, it still reflects that the amounts were voided, thus, if they were paid in
full, this won't reflect it. this doesn't calculate payments. this only calculates the invoice
totals and reverses those as a "amount due" is really now "amount refund".
}
   result := amtTotDebit;

   //
   if (result < 0) then
      result := 0.00;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountCredit: currency;
begin
   result := Payment_GetAmountTransCreditByOrderID( freturnOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountFeeSubTotal: currency;
begin
	Result := FEELineItems.AmountSubTotal;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountOverPaid: currency;
var
   AmountOP : currency;
begin
   AmountOP := 0.00;
   //
   if (fGetAmountRefund - fGetAmountPaid > 0) then
   begin
      AmountOP := AmountOP + fGetAmountPaid;
      AmountOP := AmountOP - fGetAmountRefund;
   end else
      AmountOP := fGetAmountRefund - fGetAmountPaid;
   //
   if (AmountOP < 0) then
      AmountOP := 0;

   //
   result := AmountOP;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountPaid: currency;
begin
   result := Payment_GetAmountPaidByOrderID( freturnOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// Get the shipping amount
function tReturnInvoice.fGetAmountShippingREALSubTotal: currency;
begin
   result := fShippingAmount;
end;

function tReturnInvoice.fGetAmountShippingSubTotal: currency;
begin
   if (fRefundShipping) then
      result := fShippingAmount
   else
      result := 0.00;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetShippingREALTotalTax: currency;
begin
   result := fShippingTaxAmount;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountShippingTax: currency;
var
   AmtShippingTax : currency;
begin
	AmtShippingTax := fShippingTaxAmount;
   //
   if (fWaveTax) then
      AmtShippingTax := 0.00;
   //
   if (fRefundShipping) then
      result := AmtShippingTax
   else
      result := 0.00;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This ONLY the line items WITHOUT tax
function tReturnInvoice.fGetAmountLineItemSubTotal: currency;
var
   LineItemTotal : currency;
begin
   // initalize
   LineItemTotal := 0.00;
   // Line Items
   LineItemTotal := LineItems.AmountSubTotal;
   //
   result := LineItemTotal;
   //
   if (result < 0) then
      result := 0.00;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountTax: currency;
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
   	LineItemTotal := LineItems.AmountTotalTax;
   // Fees
   if (NOT fWaveTax) then
      FeeItemTotal := FEELineItems.AmountTotalTax;
   // Shipping
   if (NOT fWaveTax) then
      ShippingTotal := ShippingTotal + Amount_ShippingTotalTax;
   // Finished, add them
   result := LineItemTotal + FeeItemTotal + ShippingTotal + Amount_CompoundTax;
   // ----------------------------------------------------------
   //
   if (fWaveTax) then
   	result := 0.00;
end;

function tReturnInvoice.fGetCompoundTax : currency;
var
   LineItemTotal : currency;
   FeeItemTotal : currency;
   ShippingTotal : currency;
   CompoundTotal : currency;
   subTotal : currency;
//   taxRec : tTaxRecord;
begin
   LineItemTotal := 0.00;
   FeeItemTotal := 0.00;
   ShippingTotal := 0.00;
   CompoundTotal := 0.00;
   // Line Items
   LineItemTotal := LineItems.AmountSubTotal;
   LineItemTotal := LineItemTotal + LineItems.AmountTotalTax;
   // Fees
   FeeItemTotal := FEELineItems.AmountSubTotal;
   FeeItemTotal := FeeItemTotal + FEELineItems.AmountTotalTax;
   // Shipping
   ShippingTotal := Amount_ShippingTotal;
   ShippingTotal := ShippingTotal + Amount_ShippingTotalTax;
   // Compound from storage which is ONLY on the PRIOR order!!
   result := fCompoundTaxAmount;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountTotal: currency;
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
   LineItemTotal := LineItems.AmountSubTotal;
   if (NOT fWaveTax) then
   	LineItemTotal := LineItemTotal + LineItems.AmountTotalTax;
   // Fees
   FeeItemTotal := FEELineItems.AmountSubTotal;
   if (NOT fWaveTax) then
      FeeItemTotal := FeeItemTotal + FEELineItems.AmountTotalTax;
   // Shipping
   ShippingTotal := Amount_ShippingTotal;
   if (NOT fWaveTax) then
      ShippingTotal := ShippingTotal + Amount_ShippingTotalTax;
   // Finished, add them
   result := LineItemTotal + FeeItemTotal + ShippingTotal + Amount_CompoundTax;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmount_TotalRetail: currency;
begin
   result := LineItems.Amount_TotalRetail;
end;

function tReturnInvoice.fGetAmount_TotalSellAt: currency;
begin
   result := LineItems.Amount_TotalSellAt;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.fGetAmountPriorVoided: currency;
begin
   result := Payment_GetAmountVoidedByOrderID( freturnOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnInvoice.Finalize: tErrorResult;
var
   errMsg : string;
   EscrowSelect : TEscrow_SelectEscrow;
   TranRec : tTransRec;
   returnFinalForm : tReturn_FinalizationForm;
begin
   PercentForm_Free();

   result := Error_Init;
   //

   // check line item issues
   errMsg := LineItems.CheckSave();

   // check Fee Issues
   if (errMsg = '') then
      errMsg := FEELineItems.CheckSave();

   if ( Amount_Total <= 0 ) then
      errMsg := 'Return does not contain any return information. Must contain at least 1 Line Item or 1 Fee or 1 Shipping ' +
         ' returned.';

   //
   if (fStatus = OrderStatusClosed) then
      errMsg := 'Return is already Closed.';

   //
   if ( errMsg <> '') then
   begin
      returnFinalForm := tReturn_FinalizationForm.Create( Application, formTypeError );
      //
      returnFinalForm.FormErrors := errMsg;
      returnFinalForm.orgID := self.fOrgID;
      returnFinalForm.OrderNumName := self.Order_GetOrderNumberName;
      returnFinalForm.CustID := fCustSoldID;
      returnFinalForm.CycleID := fCycleID;
      returnFinalForm.AmountRefund := Self.Amount_TotalRefund;
      returnFinalForm.AmountShippingSubTotal := Self.Amount_ShippingTotal;
      returnFinalForm.AmountTotal := Self.Amount_Total;
      returnFinalForm.AmountTotalTax := Self.Amount_TotalTax;
      returnFinalForm.AmountFeeSubTotal := Self.Amount_FeeTotal;
      returnFinalForm.AmountLineItemSubTotal := Self.Amount_LineItemTotal;
      //
      returnFinalForm.ShowModal();
      result.errorResult := true;
   end else
      begin
         returnFinalForm := tReturn_FinalizationForm.Create( Application, formTypeOk );
         // fill in information
         returnFinalForm.orgID := self.fOrgID;
         returnFinalForm.OrderNumName := self.Order_GetOrderNumberName;
         returnFinalForm.CustID := fCustSoldID;;
         returnFinalForm.CycleID := fCycleID;
         returnFinalForm.AmountRefund := Self.Amount_TotalRefund;
         returnFinalForm.AmountShippingSubTotal := Self.Amount_ShippingTotal;
         returnFinalForm.AmountTotal := Self.Amount_Total;
         returnFinalForm.AmountTotalTax := Self.Amount_TotalTax;
         returnFinalForm.AmountFeeSubTotal := Self.Amount_FeeTotal;
         returnFinalForm.AmountLineItemSubTotal := Self.Amount_LineItemTotal;
         returnFinalForm.AmountVoided := Self.Amount_TotalPriorVoidNSF;
         //
         returnFinalForm.ShowModal();
         //
         if ( returnFinalForm.CloseAction = actionConfirm ) then
         begin
            PercentForm_Create('Closing Return - One Moment Please...', 0, 0);
            // set the order to closed
            fStatus := OrderStatusClosed;
            //
            LineItems.RemoveNonReturnedQTYLines();
            FEELineItems.RemoveNonReturnedLines();
            //
            if (fInvoiceType = InvoiceTypeOrder) then
            begin
               // we are IN the invoice
               Save();
            end else
               begin
                  // we are OUTSIDE the invoice
                  { we have to save both the LineItems AND the FeeLineItems because we had to run
                     a RemoveNonReturnedQTY on them. on finalize, we don't want anything else in
                     there mucking around }
                  LineItems.SaveReport();
                  FeeLineItems.SaveReport();
                  fReturnQuery.Edit();
                  fReturnQuery.FieldByName('STATUS').AsInteger := integer(OrderStatusClosed);
                  fReturnQuery.Post();
               end;

            // Mark the prior order's products as returned
            PercentForm_UpdateHeader('Marking Prior Product as Returned...');
            Product_MarkPriorProductAsReturned( fOrderID, fReturnOrderID);

            // Mark the FEES as being returned
            Fee_MarkPriorFeeAsReturned( fOrderID, fReturnOrderID );

            // Move Returned Products into the Return Manager
            if ( Order_GetOrderStatusByOrderID( fReturnOrderID ) = OrderStatusDelinquent ) then
            begin
               if AvoBaseDialog('Prior Delinquent Order',
               	'The prior Order # ' + Order_GetOrderNumberByOrderID( fReturnOrderID ) +
                  ' is Delinquent. This means the products on the Invoice may or may not have' +
						' been returned to you.\n\n' +
                  'Products returned to you will be moved into the Return Product Manager.\n\n' +
                  'Have the products been returned to you?', mtConfirmation, [mbyes, mbno], 0) = mbYes then
                  	if ( Product_MoveOrderProductToReturnManager( fOrderID ) ) then
                     	AvoBaseDialog('Return Product moved to Return Manager',
                        	'Products returned on this Invoice have been moved into the Return Product Manager.', mtInformation, [mbok], 0);
            end else
            	begin
               	PercentForm_UpdateHeader('Moving Product to Return Manager...');
                  if ( Product_MoveOrderProductToReturnManager( fOrderID ) ) then
                  begin
                     PercentForm_Free();
                  	AvoBaseDialog('Return Product moved to Return Manager',
                     	'Products returned on this Invoice have been moved into the Return Product Manager.', mtInformation, [mbok], 0);
                  end;
      			end;

            // If shipping was refunded, mark prior order as such so we don't bring it in
            if ( RefundShipping ) then
               Order_MarkShippingRefundedByOrderID( fReturnOrderID );

            // Send to Escrow now.
            PercentForm_UpdateHeader('Creating Return Transaction...');

            //
            if ( Self.Amount_TotalRefund > 0 ) then
            begin
               PercentForm_Free();
               TranRec.id := masterData.NewDBGuid();
               tranRec.disp_msg := 'The Return has been closed.' + #13 + #13 +
                  'A refund must be issued in the form of Cash, Check or Escrow.' + #13 + #13 +
                  'If issued as Escrow, the transaction can be used on any future Invoice by this Customer.';
               tranRec.order_id := fOrderID;
               tranRec.c_stid := fCustSoldID;
               tranRec.c_id := fCycleID;
               tranRec.amount := Amount_TotalRefund;
               EscrowSelect := TEscrow_SelectEscrow.Create( Application, 'Select Return Escrow', True, TranRec);
               EscrowSelect.ShowModal();
               // DO NOT FREE, form is a caFREE upon closure.
            end;

            PercentForm_Free();
         end else
            result.errorResult := true;
      end;
end;

{ RETURNS ISSUES:

1 take order. take payment. close order. amount due is $5. paid is $5.

2. create return, prior amount paid is $5.

3. return all, return amount is $5.


}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.






