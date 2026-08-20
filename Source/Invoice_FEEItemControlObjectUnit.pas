 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_FEEItemControlObjectUnit;

interface uses
   constantsunit,
   masterdataunit,
   toolboxunit,
  recordstructureunit,
   inifileunit,
   errorresultunit,
   avobase_percentformunit,
   avobase_dialogformunit,
   //
   Invoice_FEEItem_FormUnit,
   Invoice_FEEItem_NoFormUnit,
   Toolbox_PreferenceToolBoxUnit,
   toolbox_TaxToolBoxUnit,
   Fee_SelectFormUnit,
   //
   bde,
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   math,
   Contnrs,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   DBTables;



type
	tFEEItemControlObject = class(tObject)
   private
      fRecalcON : boolean;
   	fOrderID : string;
      fOrgID : string;
      fCycleID : string;
		fInvoiceType : tInvoiceTypes;
      fOrderType : tOrderTypes;
      fFEELineQuery : tQuery;
      fDockSite : tScrollBox;
      fLineNumber : integer;
      //
      FEELineItems : tObjectList; // This controls ALL of the item lists

      // ----------------------------------------------------------------------------- //
      // events
      fOnNewLine : tNotifyEvent;
      fRecalculate : tNotifyEvent;
      fDeleteLine : tDeleteLineEvent;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;

      // ----------------------------------------------------------------------------- //
      // GET
      function fGetCount : integer;
      function fGetAmountPaid : currency;
		function fGetTotalAmount : currency;
		function fGetTotalTax : currency;
      function fGetAmountSubTotal : currency;

      // ----------------------------------------------------------------------------- //
      // SET

      procedure HandleRecalculateInvoice;
      procedure HandleLineItemClicked( Sender : tObject; LineNum : integer);

      function CalculateLineItem(inLineItem : tInvoice_FEEItem_Form): tFeeItemRecord;
      function LineItemRecordInitialize: tFeeItemRecord;
      procedure DockSiteScrollBottom;
      procedure fSetOrderType( inVal : tOrderTypes );
   public
   	// Add New Line
   	function Add() : integer; overload;
      function AddBlankLineItem() : integer;

      // Delete
      procedure DeleteLine;

      // Load / Save
      procedure Load( inOrderID : string );
      function CheckSave : string;
      procedure Save();
      procedure DoLineColor();
      procedure RenumberInvoiceLines();
		procedure RecalculateInvoice();
      procedure Clear();
      procedure Add_Org_Fees( inOrgID : string);
      function AddFeeSelect() : integer;

      // ----------------------------------------------------------------------------- //
   	// properties
      property Count : integer read fGetCount;
      property GetAmountPaid : currency read fGetAmountPaid;
		property AmountTotalAmount : currency read fGetTotalAmount;
      property AmountTotalTax : currency read fGetTotalTax;
      property AmountSubTotal : currency read fGetAmountSubTotal;
      property OrgID : string read fOrgID write fOrgID;
      property OrderID : string read fOrderID write fOrderID;
      property CycleID : string read fCycleID write fCycleID;
      property OrderType : tOrderTypes read fOrderType write fSetOrderType;

      // ----------------------------------------------------------------------------- //
      // Events
      procedure Handle_FEEItem_LineDelete(  sender : tObject; lineNum : integer );
      procedure Handle_FEEItem_LineUpdate(  sender : tObject; lineNum : integer );
      property OnRecalculateInvoiceEvent : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;

      // Other

      // ----------------------------------------------------------------------------- //
   	//
      constructor create( inDockPanel : tScrollBox; inInvoiceType : tInvoiceTypes); virtual;
      constructor destroy; virtual;
   end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tFEEItemControlObject.create( inDockPanel : tScrollBox; inInvoiceType : tInvoiceTypes);
begin
  inherited Create;
  //
  fInvoiceType := inInvoiceType;
  fFEELineQuery := masterData.GetQuery;
  fDockSite := inDockPanel;
  fRecalcON := true;
  //
  FEELineItems := tObjectList.Create(True);
end;

constructor tFEEItemControlObject.destroy;
begin
   FreeAndNil( FEELineItems );
   FreeAndNil( fFEELineQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tFEEItemControlObject.Add: integer;
var
	FEEItem_Form : tInvoice_FEEItem_Form;
   FEEItem_Report : tFEEItem_Report;
begin
   case fInvoiceType of
      // -------------------------------------------------------------------------
      // For Orders
      InvoiceTypeOrder:
      begin
         // determine the style, there is only one at the momento for release 2.0
         FEEItem_Form := tInvoice_FEEItem_Form.Create( nil );
         fDockSite.Visible := False;
         with FEEItem_Form do
         begin
            Height := FormHeight_Order;
            ManualDock( fDockSite );
            Visible := True;
            Show();
            Align := alBottom;
            Align := alTop;
            // set Events
            OnRecalculateInvoice := HandleRecalculateInvoice;
            OnLineClicked := HandleLineItemClicked;
            {
            OnLineDelete := Handle_FEEItem_LineDelete;
            OnLineUpdate := Handle_FEEItem_LineUpdate;
            }
         end;
         fDockSite.Visible := true;
         fDockSite.Align := alClient;
         // Now add it to the list
         FEELineItems.Add( FEEItem_Form );
         result := FEELineItems.Count - 1;
      end;
      // -------------------------------------------------------------------------
      // For NON Orders
      InvoiceTypeReport:
      begin
         // Create
         FEEItem_Report := tFEEItem_Report.Create();
         // Set Normal Variables
         // There are NO events on this
         // Now add it to the list
         FEELineItems.Add( FEEItem_Report );
         result := FEELineItems.Count - 1;
      end;
   end;
end;

function tFEEItemControlObject.AddBlankLineItem: integer;
begin
   result := Self.Add();
   if (fInvoiceType = InvoiceTypeOrder) then
   begin
      tInvoice_FEEItem_Form(FEELineItems[ result ]).LineNumber := result;
      tInvoice_FEEItem_Form(FEELineItems[ result ]).ID := masterData.NewDBGuid;
      tInvoice_FEEItem_Form(FEELineItems[ result ]).OrderID := fOrderID;
      tInvoice_FEEItem_Form(FEELineItems[ result ]).OrgID := fOrgID;
      tInvoice_FEEItem_Form(FEELineItems[ result ]).OrderType := fOrderType;
      tInvoice_FEEItem_Form(FEELineItems[ result ]).mTaxID := Pref_GetPrefGUID(tPrefConstants.DFEETAXID);
      //
      tInvoice_FEEItem_Form(FEELineItems[ result ]).Repaint();
   end;
   fLineNumber := result;
   DockSiteScrollBottom();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tFEEItemControlObject.AddFeeSelect : integer;
var
   FeeSelectForm : TFeeSelectForm;
   feeID : string;
   lineNum : integer;
   fFeeQuery : tQuery;
begin
   FeeSelectForm := TFeeSelectForm.Create(Application, 'Select Fee', True);
   try
      FeeSelectForm.ShowModal();
      if (FeeSelectForm.FormResult = mrOk) then
      begin
         feeID := FeeSelectForm.FeeID;
         fFeeQuery := masterData.GetQuery;
         fFeeQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Fee +
            ' WHERE ID = ' + masterData.WrapDBID( feeID );
         fFeeQuery.Open();
         if (fFeeQuery.RecordCount <> 0) then
         begin
            // we KNOW this is an order, so don't worry about Order vs Report
            lineNum := Self.Add();
            tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).LineNumber := lineNum;
            tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).OrgID := fFeeQuery.FieldByName('ORG_ID').AsString;
            tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).OrderID := fOrderID;
            tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).Amount := fFeeQuery.FieldByName('AMOUNT').AsCurrency;
            tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).FeeName := fFeeQuery.FieldByName('NAME').AsString;
            tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).Desc := fFeeQuery.FieldByName('DESCR').AsString;
            tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID := fFeeQuery.FieldByName('TAXID').AsString;
         end;
         fFeeQuery.Close();
         FreeAndNil(fFeeQuery);
         fLineNumber := lineNum;
         result := lineNum;
         DockSiteScrollBottom();
      end;
   finally
      FreeAndNil(FeeSelectForm);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This routine adds any organization fees, it should ONLY be called by NewInvoice.

procedure tFEEItemControlObject.Add_Org_Fees(inOrgID: string);
var
   lineCount : integer;
   lineNum : integer;
   fFeeQuery : tQuery;
begin
   FEELineItems.Clear();
   //
   fFeeQuery := masterData.GetQuery;
   fFeeQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Fee +
      ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID );
   fFeeQuery.Open();
   if (fFeeQuery.RecordCount <> 0) then
   begin
      while NOT fFeeQuery.EOF do
      begin
         if (fFeeQuery.FieldByName('AUTOINV').AsBoolean) then
         begin
            lineNum := Self.Add();
            //
            case fInvoiceType of
               InvoiceTypeOrder :
               begin
                  tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).LineNumber := lineNum;
                  tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).OrgID := fFeeQuery.FieldByName('ORG_ID').AsString;
                  tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).OrderID := fOrderID;
                  tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).Amount := fFeeQuery.FieldByName('AMOUNT').AsCurrency;
                  tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).FeeName := fFeeQuery.FieldByName('NAME').AsString;
                  tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).Desc := fFeeQuery.FieldByName('DESCR').AsString;
                  tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID := fFeeQuery.FieldByName('TAXID').AsString;
               end;
            end;
         end;
         //
         fFeeQuery.Next();
      end;
   end;
   //
   fFeeQuery.Close();
   FreeAndNil(fFeeQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tFEEItemControlObject.Load(inOrderID: string);
var
   lineCount : integer;
   lineNum : integer;
begin
	// initalize the variables
   fRecalcON := false;
   FEELineItems.Clear;
   fOrderID := inOrderId;

   // load the item
   fFEELineQuery.Close();
   fFEELineQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_OrderFee +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID);
   fFEELineQuery.Open();
   if (fFEELineQuery.RecordCount <> 0) then
   begin
   	while NOT fFEELineQuery.EOF do
      begin
         // Create a line number, the ADD knows what to do and if to dock
         lineNum := Self.Add();
         // Now assign values to it
         case fInvoiceType of
            InvoiceTypeOrder :
            begin
               tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).LineNumber := lineNum;
               tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).Amount := fFEELineQuery.FieldByName('AMOUNT').AsCurrency;
               tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).OrgID := fFEELineQuery.FieldByName('ORG_ID').AsString;
               tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).OrderID := fFEELineQuery.FieldByName('ORDER_ID').AsString;
               tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).FeeName := fFEELineQuery.FieldByName('NAME').AsString;
               tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).Desc := fFEELineQuery.FieldByName('DESCR').AsString;
               tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).TaxRate := fFEELineQuery.FieldByName('TAX').AsFloat;
               tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID := fFEELineQuery.FieldByName('TAXID').AsString;
            end;
            InvoiceTypeReport :
            begin
               tFEEItem_Report(FEELineItems[ lineNum ]).LineNumber := lineNum;
               tFEEItem_Report(FEELineItems[ lineNum ]).Amount := fFEELineQuery.FieldByName('AMOUNT').AsCurrency;
               tFEEItem_Report(FEELineItems[ lineNum ]).OrgID := fFEELineQuery.FieldByName('ORG_ID').AsString;
               tFEEItem_Report(FEELineItems[ lineNum ]).OrderID := fFEELineQuery.FieldByName('ORDER_ID').AsString;
               tFEEItem_Report(FEELineItems[ lineNum ]).FeeName := fFEELineQuery.FieldByName('NAME').AsString;
               tFEEItem_Report(FEELineItems[ lineNum ]).Desc := fFEELineQuery.FieldByName('DESCR').AsString;
               tFEEItem_Report(FEELineItems[ lineNum ]).TaxRate := fFEELineQuery.FieldByName('TAX').AsFloat;
               tFEEItem_Report(FEELineItems[ lineNum ]).mTaxID := fFEELineQuery.FieldByName('TAXID').AsString;
            end;
         end;
         // we're done, there isn't anything we need to do.
         fFEELineQuery.Next();
      end;
   end;
   fFEELineQuery.Close();
   //
   DoLineColor();
   fRecalcON := true;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// this saves out the fees. we only do this in an invoice.
procedure tFEEItemControlObject.Save;
var
   lineNum : integer;
   canSave : boolean;
begin
   // Delete any prior lines
   fFEELineQuery.Close();
   fFEELineQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_OrderFee +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( fOrderID );
   fFEELineQuery.ExecSQL;

   // Now lets save...
   fFEELineQuery.Close();
   fFEELineQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_OrderFee;
   fFEELineQuery.Open();

   // Each item and save them.
   for lineNum := 0 to FEELineItems.Count - 1 do
   begin
      canSave := true;
      //
      if (tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).FeeName = '') then
         canSave := false;
      //
      if (canSave) then
      begin
         fFEELineQuery.Append();
         //
         fFEELineQuery.FieldByName('ID').AsString := masterdata.NewDBGuid;
         fFEELineQuery.FieldByName('AMOUNT').AsCurrency := tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).Amount;
         fFEELineQuery.FieldByName('ORG_ID').AsString := tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).OrgID;
         fFEELineQuery.FieldByName('ORDER_ID').AsString := tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).OrderID;
         fFEELineQuery.FieldByName('NAME').AsString := ProperCase(tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).FeeName, True);
         fFEELineQuery.FieldByName('DESCR').AsString := tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).Desc;
         fFEELineQuery.FieldByName('TAX').AsFloat := tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).TaxRate;
         fFEELineQuery.FieldByName('TAXID').AsString := tInvoice_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID;
         //
         fFEELineQuery.Post();
      end;
   end;
   fFEELineQuery.Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tFEEItemControlObject.fGetAmountPaid: currency;
var
   FEECount : integer;
begin
   result := 0.00;
   for FEECount := 0 to FEELineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeOrder : result := result + tInvoice_FEEItem_Form(FEELineItems[ FEECount ]).Amount;
         InvoiceTypeReport : result := result + tFEEItem_Report(FEELineItems[ FEECount ]).Amount;
      end;
   //result := RoundTo(result, -2);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tFEEItemControlObject.fGetCount: integer;
begin
	result := FEELineItems.Count;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(*********************************************)
(*********************************************)
(***** GET SUB TOTAL *)
(*********************************************)
(*********************************************)

// Sub total does NOT include tax
function tFEEItemControlObject.fGetAmountSubTotal: currency;
var
   lineCount : integer;
   TotalAmount : currency;
begin
   TotalAmount := 0.00;
   //
   for lineCount := 0 to FEELineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeOrder : TotalAmount := TotalAmount + tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).Amount;
         InvoiceTypeReport : TotalAmount := TotalAmount + tFEEItem_Report(FEELineItems[ lineCount ]).Amount;
      end;
   //
   result := TotalAmount; // we DO NOT ROUND HERE!!!
end;

{
function tLineItemControlObject.fGetSubTotal: currency;
var
   lineCount : integer;
   lineItemRecord : tLineItemRecord;
begin
   result := 0.00;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   begin
      // Gather the data together
      case fInvoiceType of
         InvoiceOrder : lineItemRecord := CalculateLineItem(tInvoice_LineItem_Form(LineItems[ lineCount ]));
         InvoiceReport : lineItemRecord := CalculateLineItem(tLineItem_Report(LineItems[ lineCount ]));
      end;
      result := result + lineItemRecord.AmountSubTotal;
   end;
end;

}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(*********************************************)
(*********************************************)
(***** GET TOTAL AMOUNT *)
(*********************************************)
(*********************************************)

// Returns the total amount - FEE + TAX on FEE
function tFEEItemControlObject.fGetTotalAmount: currency;
var
   lineCount : integer;
   TotalAmount : currency;
   TotalTaxAmount : currency;
   TaxRate : double;
begin
   TotalTaxAmount := 0.00;
   //
   for lineCount := 0 to FEELineItems.Count - 1 do
   begin
   	TotalAmount := 0.00;
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder :
         begin
         	TotalAmount := tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).Amount;
            TaxRate := tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).TaxRate;
         end;
         InvoiceTypeReport :
         begin
         	TotalAmount := tFEEItem_Report(FEELineItems[ lineCount ]).Amount;
            TaxRate := tFEEItem_Report(FEELineItems[ lineCount ]).TaxRate;
         end;
      end;
		// Calculate it
      TotalAmount := TotalAmount + (TotalAmount * Tax_PerformTaxCalculation(TaxRate));
      // Done
      TotalTaxAmount := TotalTaxAmount + TotalAmount;
   end;
   //
   //result := RoundTo(TotalTaxAmount, -2);
   result := TotalTaxAmount;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(*********************************************)
(*********************************************)
(***** GET TOTAL TAX *)
(*********************************************)
(*********************************************)

// Only returns the TAX on the items
function tFEEItemControlObject.fGetTotalTax: currency;
var
   lineCount : integer;
   TotalAmount : currency;
   TotalTaxAmount : currency;
   TaxRate : double;
begin
   TotalTaxAmount := 0.00;
   //
   for lineCount := 0 to FEELineItems.Count - 1 do
   begin
   	TotalAmount := 0.00;
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder :
         begin
         	TotalAmount := tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).Amount;
            TaxRate := tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).TaxRate;
         end;
         InvoiceTypeReport :
         begin
         	TotalAmount := tFEEItem_Report(FEELineItems[ lineCount ]).Amount;
            TaxRate := tFEEItem_Report(FEELineItems[ lineCount ]).TaxRate;
         end;
      end;
		// Calculate it
      TotalTaxAmount := TotalTaxAmount + (TotalAmount * Tax_PerformTaxCalculation(TaxRate));
   end;
   //
   //result := RoundTo(TotalTaxAmount, -2);
   result := TotalTaxAmount;
end;

procedure tFEEItemControlObject.fSetOrderType(inVal: tOrderTypes);
begin
   fOrderType := inVal;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// deletes a line
procedure tFEEItemControlObject.DeleteLine;
var
	line : integer;
   doDelete : boolean;
begin
   for line := 0 to FeeLineItems.Count - 1 do
      if tInvoice_FEEItem_Form(FeeLineItems[line]).LineNumber = fLineNumber then
      begin
         doDelete := false;
         case fInvoiceType of
            InvoiceTypeOrder :
            begin
               // we want to prompt them first...
               if AvoBaseDialog('Delete Fee Line #' + IntToStr( line + 1),
                  'Delete highlighted Fee Line?', mtConfirmation, [mbYes,mbNo], 0) = mbYes then
                     doDelete := true;
            end;
            InvoiceTypeReport : doDelete := true;
         end;
         if (doDelete) then
         begin
            FeeLineItems.Delete( line );
            Break; // otherwise we just don't fucking know where we are anymore
         end;
      end;
   FeeLineItems.Pack();
   RenumberInvoiceLines();
   RecalculateInvoice();
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


{ EVENTS }

procedure tFEEItemControlObject.HandleLineItemClicked(Sender: tObject; LineNum: integer);
begin
   fLineNumber := LineNum;
   DoLineColor();
end;

procedure tFEEItemControlObject.HandleRecalculateInvoice;
begin
	// we received an recaculate, so we are going to pass that all the way
   // down to the bottom because it will tell everyone to recalculate
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

procedure tFEEItemControlObject.Handle_FEEItem_LineDelete(sender: tObject;
  lineNum: integer);
begin
   // do
end;

procedure tFEEItemControlObject.Handle_FEEItem_LineUpdate(sender: tObject;
  lineNum: integer);
begin
   // do
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


// Tell the prior object to recalculate
procedure tFEEItemControlObject.RecalculateInvoice;
var
   lineCount : integer;
   lineItemRecord : tFeeItemRecord;
   //taxRec : tTaxREcord;
   taxRateTotal : double;
begin
   if (fRecalcON) then
   begin
      if ( fInvoiceType = InvoiceTypeOrder ) then
         for lineCount := 0 to FeeLineItems.Count - 1 do
         begin
            // because every line is individually taxed, we have to pull the tax rate here
            taxRateTotal := 0.00;
            {
            taxRec := Tax_GetTaxRecord(tInvoice_FEEItem_Form( FeeLineItems[ lineCount ]).Amount );
            taxRateTotal := taxRateTotal + taxRec.taxRate;
            }
            taxRateTotal := taxRateTotal + Tax_TaxRateTotalByMasterTaxClassID(
               tInvoice_FEEItem_Form( FeeLineItems[ lineCount ]).Amount,
               tInvoice_FEEItem_Form( FeeLineItems[ lineCount ]).mTaxID );
            tInvoice_FEEItem_Form( FeeLineItems[ lineCount ]).TaxRate := taxRateTotal;
            // now just do calculations
            lineItemRecord := CalculateLineItem(tInvoice_FEEItem_Form(FeeLineItems[ lineCount ]));
            tInvoice_FEEItem_Form( FeeLineItems[ lineCount ]).tTotalCostLabel.Caption := FormatFloat('####.00', lineItemRecord.AmountTotal);
            tInvoice_FEEItem_Form( FeeLineItems[ lineCount ]).tTotalTaxLabel.Caption := FormatFloat('####.00', lineItemRecord.AmountTax);
         end;
   end;
end;

(** ********************************************************** **)
(** ********************************************************** **)
(** CALCULATE THE QUANTITIES, TAXES AND RETURN A PROPER RECORD **)
(** ********************************************************** **)
(** ********************************************************** **)

function tFEEItemControlObject.LineItemRecordInitialize: tFeeItemRecord;
begin
   result.AmountTax := 0.00;
   result.AmountSubTotal := 0.00;
   result.AmountTotal := 0.00;
end;

function tFEEItemControlObject.CalculateLineItem(inLineItem : tInvoice_FEEItem_Form): tFeeItemRecord;
var
   lineCount : integer;
   TaxRate : currency;
   sellAtCost : currency;
begin
	// initalize
   result := LineItemRecordInitialize;
	//
	sellAtCost := inLineItem.Amount;
	taxRate := inLineItem.TaxRate;

	// calculate the sub total
   result.AmountSubTotal := ( 1 * sellAtCost); // there is only ever ONE amount per fee

   // calculate the amount of tax
   result.AmountTax := (result.AmountSubTotal * Tax_PerformTaxCalculation( TaxRate ));
   //result.AmountTax := RoundTo( result.AmountTax, -2);

   // FINALLY - calculate the amount total
   result.AmountTotal := result.AmountSubTotal + result.AmountTax;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tFEEItemControlObject.CheckSave: string;
var
   lineCount : integer;
begin
   result := '';
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to FEELineItems.Count - 1 do
      begin
         if (tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).FeeName <> '') AND (tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).Amount = 0)
            then result := 'Fee line # ' + IntToStr( lineCount + 1 ) + ' cannot have a 0.00 amount.';
         if (tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).Amount <> 0) AND (tInvoice_FEEItem_Form(FEELineItems[ lineCount ]).FeeName = '')
            then result := 'Fee line # ' + IntToStr( lineCount + 1 ) + ' has an amount but no fee name.';
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tFEEItemControlObject.Clear;
begin
   FEELineItems.Clear();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tFEEItemControlObject.RenumberInvoiceLines;
var
   lineCount : integer;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
      for lineCount := 0 to FeeLineItems.Count - 1 do
         tInvoice_FEEItem_Form(FeeLineItems[ lineCount ]).LineNumber := lineCount;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tFEEItemControlObject.DockSiteScrollBottom;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
   begin
      fDockSite.Visible := False;
      fDockSite.Realign;
      fDockSite.Perform(WM_VSCROLL, SB_BOTTOM, 0);
      fDockSite.Visible := True;
   end;
end;

procedure tFEEItemControlObject.DoLineColor;
var
   lineCount : integer;
begin
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to FeeLineItems.Count - 1 do
      begin
         if (lineCount = fLineNumber) then
         begin
            tInvoice_FEEItem_Form(FeeLineItems[ lineCount ]).LineItemOnePanel.Color := $00CAFFFF;
         end else
            begin
               tInvoice_FEEItem_Form(FeeLineItems[ lineCount ]).LineItemOnePanel.Color := $00EAEAEA;
            end;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.


