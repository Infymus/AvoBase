 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_FEEItemControlObjectUnit;

interface uses
   constantsunit,
   masterdataunit,
   toolboxunit,
   masterdata_updateunit,
   inifileunit,
   errorresultunit,
  recordstructureunit,
   avobase_percentformunit,
   avobase_dialogformunit,
   //
   Return_FEEItem_FormUnit,
   Return_FEEItem_NoFormUnit,
   Fee_SelectFormUnit,
   toolbox_TaxToolBoxUnit,
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
	tReturnFEEItemControlObject = class(tObject)
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

      function CalculateLineItem(inLineItem : tReturn_FEEItem_Form): tFeeItemRecord;
      function LineItemRecordInitialize: tFeeItemRecord;
      procedure DockSiteScrollBottom;
      procedure fSetOrderType( inVal : tOrderTypes );
      procedure fSetOrderID( inVal : string );
   public
   	// Add New Line
   	function Add() : integer; overload;
      function AddBlankLineItem() : integer;

      // Delete
      procedure DeleteLine;

      // Load / Save
      procedure Load( inOrderID : string );
      procedure LoadNewReturn(inOrderID: string);
      function CheckSave : string;
      procedure Save();
      procedure SaveReport();
      procedure DoLineColor();
      procedure RenumberInvoiceLines();
		procedure RecalculateInvoice();
      procedure Clear();
      procedure Add_Org_Return_Fees( inOrgID : string);
      function AddFeeSelect() : integer;
      procedure ReturnAllFeeItems( inVal : boolean );
      procedure RemoveNonReturnedLines();

      // ----------------------------------------------------------------------------- //
   	// properties
      property Count : integer read fGetCount;
      property GetAmountPaid : currency read fGetAmountPaid;
		property AmountTotalAmount : currency read fGetTotalAmount;
      property AmountTotalTax : currency read fGetTotalTax;
      property AmountSubTotal : currency read fGetAmountSubTotal;
      property OrgID : string read fOrgID write fOrgID;
      property OrderID : string read fOrderID write fSetOrderID;
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

constructor tReturnFEEItemControlObject.create( inDockPanel : tScrollBox; inInvoiceType : tInvoiceTypes);
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

constructor tReturnFEEItemControlObject.destroy;
begin
   FreeAndNil( FEELineItems );
   FreeAndNil( fFEELineQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnFEEItemControlObject.Add: integer;
var
	FEEItem_Form : tReturn_FEEItem_Form;
   FEEItem_Report : tReturn_FEEItem_Report;
begin
   case fInvoiceType of
      // -------------------------------------------------------------------------
      // For Orders
      InvoiceTypeOrder:
      begin
         // determine the style, there is only one at the momento for release 2.0
         FEEItem_Form := tReturn_FEEItem_Form.Create( nil );
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
         FEEItem_Report := tReturn_FEEItem_Report.Create();
         // Set Normal Variables
         // There are NO events on this
         // Now add it to the list
         FEELineItems.Add( FEEItem_Report );
         result := FEELineItems.Count - 1;
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnFEEItemControlObject.AddBlankLineItem: integer;
begin
   result := Self.Add();
   if (fInvoiceType = InvoiceTypeOrder) then
   begin
      tReturn_FEEItem_Form(FEELineItems[ result ]).LineNumber := result;
      tReturn_FEEItem_Form(FEELineItems[ result ]).ID := masterData.NewDBGuid;
      tReturn_FEEItem_Form(FEELineItems[ result ]).OrderID := fOrderID;
      tReturn_FEEItem_Form(FEELineItems[ result ]).OrgID := fOrgID;
      tReturn_FEEItem_Form(FEELineItems[ result ]).OrderType := fOrderType;
      tReturn_FEEItem_Form(FEELineItems[ result ]).ReturnFlag := True;
      tReturn_FEEItem_Form(FEELineItems[ result ]).ReturnAdd := True;
      //
      tReturn_FEEItem_Form(FEELineItems[ result ]).Repaint();
   end;
   fLineNumber := result;
   DockSiteScrollBottom();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnFEEItemControlObject.AddFeeSelect: integer;
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
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).LineNumber := lineNum;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrgID := fFeeQuery.FieldByName('ORG_ID').AsString;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrderID := fOrderID;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Amount := fFeeQuery.FieldByName('AMOUNT').AsCurrency;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).FeeName := fFeeQuery.FieldByName('NAME').AsString;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Desc := fFeeQuery.FieldByName('DESCR').AsString;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnFlag := True;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnAdd := True;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID := fFeeQuery.FieldByName('TAXID').AsString;
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

procedure tReturnFEEItemControlObject.Add_Org_Return_Fees(inOrgID: string);
var
   lineCount : integer;
   lineNum : integer;
   fFeeQuery : tQuery;
begin
	// DO NOT CLEAR THE FEE LINE ITEMS HERE... They already exist, so just add to them.
   //
   fFeeQuery := masterData.GetQuery;
   fFeeQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Fee +
      ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID );
   fFeeQuery.Open();
   if (fFeeQuery.RecordCount <> 0) then
   begin
      while NOT fFeeQuery.EOF do
      begin
         if (fFeeQuery.FieldByName('AUTORET').AsBoolean) then
         begin
            lineNum := Self.Add();
            //
            case fInvoiceType of
               InvoiceTypeOrder :
               begin
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).LineNumber := lineNum;
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrgID := fFeeQuery.FieldByName('ORG_ID').AsString;
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrderID := fOrderID;
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Amount := fFeeQuery.FieldByName('AMOUNT').AsCurrency;
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).FeeName := fFeeQuery.FieldByName('NAME').AsString;
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Desc := fFeeQuery.FieldByName('DESCR').AsString;
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnFlag := True;
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnAdd := True;
                  tReturn_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID := fFeeQuery.FieldByName('TAXID').AsString;
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

procedure tReturnFEEItemControlObject.Load(inOrderID: string);
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
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).LineNumber := lineNum;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Amount := fFEELineQuery.FieldByName('AMOUNT').AsCurrency;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrgID := fFEELineQuery.FieldByName('ORG_ID').AsString;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrderID := fFEELineQuery.FieldByName('ORDER_ID').AsString;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).FeeName := fFEELineQuery.FieldByName('NAME').AsString;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Desc := fFEELineQuery.FieldByName('DESCR').AsString;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).TaxRate := fFEELineQuery.FieldByName('TAX').AsFloat;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnFlag := fFEELineQuery.FieldByName('RETFLAG').AsBoolean;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnAdd := fFEELineQuery.FieldByName('RETADD').AsBoolean;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnFeeID := fFEELineQuery.FieldByName('R_ID').AsString;
               tReturn_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID := fFEELineQuery.FieldByName('TAXID').AsString;
            end;
            InvoiceTypeReport :
            begin
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).LineNumber := lineNum;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).Amount := fFEELineQuery.FieldByName('AMOUNT').AsCurrency;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).OrgID := fFEELineQuery.FieldByName('ORG_ID').AsString;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).OrderID := fFEELineQuery.FieldByName('ORDER_ID').AsString;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).FeeName := fFEELineQuery.FieldByName('NAME').AsString;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).Desc := fFEELineQuery.FieldByName('DESCR').AsString;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).TaxRate := fFEELineQuery.FieldByName('TAX').AsFloat;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).ReturnFlag := fFEELineQuery.FieldByName('RETFLAG').AsBoolean;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).ReturnAdd := fFEELineQuery.FieldByName('RETADD').AsBoolean;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).ReturnFeeID := fFEELineQuery.FieldByName('R_ID').AsString;
               tReturn_FEEItem_Report(FEELineItems[ lineNum ]).mTaxID := fFEELineQuery.FieldByName('TAXID').AsString;
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

procedure tReturnFEEItemControlObject.LoadNewReturn(inOrderID: string);
var
   lineCount : integer;
   lineNum : integer;
   canLoad : boolean;
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
         // we don't return those that already have an R_ID associated with them.
         if ( NOT fFEELineQuery.FieldByName('RET').AsBoolean ) then
         begin
            // Create a line number, the ADD knows what to do and if to dock
            lineNum := Self.Add();
            // Now assign values to it
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).LineNumber := lineNum;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Amount := fFEELineQuery.FieldByName('AMOUNT').AsCurrency;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrgID := fFEELineQuery.FieldByName('ORG_ID').AsString;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrderID := fFEELineQuery.FieldByName('ORDER_ID').AsString;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).FeeName := fFEELineQuery.FieldByName('NAME').AsString;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Desc := fFEELineQuery.FieldByName('DESCR').AsString;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).TaxRate := fFEELineQuery.FieldByName('TAX').AsFloat;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnFlag := fFEELineQuery.FieldByName('RETFLAG').AsBoolean;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnAdd := fFEELineQuery.FieldByName('RETADD').AsBoolean;
            // for the ID in this case, we put the ID into the returnfeeid, and then later on we use that.
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnFeeID := fFEELineQuery.FieldByName('ID').AsString;
            tReturn_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID := fFEELineQuery.FieldByName('TAXID').AsString;
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
procedure tReturnFEEItemControlObject.Save;
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
      if (tReturn_FEEItem_Form(FEELineItems[ lineNum ]).FeeName = '') then
         canSave := false;
      //
      if (canSave) then
      begin
         fFEELineQuery.Append();
         //
         fFEELineQuery.FieldByName('ID').AsString := masterdata.NewDBGuid;
         fFEELineQuery.FieldByName('AMOUNT').AsCurrency := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Amount;
         fFEELineQuery.FieldByName('ORG_ID').AsString := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrgID;
         fFEELineQuery.FieldByName('ORDER_ID').AsString := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).OrderID;
         fFEELineQuery.FieldByName('NAME').AsString := ProperCase(tReturn_FEEItem_Form(FEELineItems[ lineNum ]).FeeName, True);
         fFEELineQuery.FieldByName('DESCR').AsString := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).Desc;
         fFEELineQuery.FieldByName('TAX').AsFloat := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).TaxRate;
         fFEELineQuery.FieldByName('RETFLAG').AsBoolean := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnFlag;
         fFEELineQuery.FieldByName('RETADD').AsBoolean := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnAdd;
         fFEELineQuery.FieldByName('R_ID').AsString := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).ReturnFeeID;
         fFEELineQuery.FieldByName('TAXID').AsString := tReturn_FEEItem_Form(FEELineItems[ lineNum ]).mTaxID;
         //
         fFEELineQuery.Post();
      end;
   end;
   fFEELineQuery.Close();
end;

procedure tReturnFEEItemControlObject.SaveReport;
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
      if (tReturn_FEEItem_Form(FEELineItems[ lineNum ]).FeeName = '') then
         canSave := false;
      //
      if (canSave) then
      begin
         fFEELineQuery.Append();
         //
         fFEELineQuery.FieldByName('ID').AsString := masterdata.NewDBGuid;
         fFEELineQuery.FieldByName('AMOUNT').AsCurrency := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).Amount;
         fFEELineQuery.FieldByName('ORG_ID').AsString := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).OrgID;
         fFEELineQuery.FieldByName('ORDER_ID').AsString := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).OrderID;
         fFEELineQuery.FieldByName('NAME').AsString := ProperCase(tReturn_FEEItem_Report(FEELineItems[ lineNum ]).FeeName, True);
         fFEELineQuery.FieldByName('DESCR').AsString := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).Desc;
         fFEELineQuery.FieldByName('TAX').AsFloat := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).TaxRate;
         fFEELineQuery.FieldByName('RETFLAG').AsBoolean := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).ReturnFlag;
         fFEELineQuery.FieldByName('RETADD').AsBoolean := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).ReturnAdd;
         fFEELineQuery.FieldByName('R_ID').AsString := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).ReturnFeeID;
         fFEELineQuery.FieldByName('TAXID').AsString := tReturn_FEEItem_Report(FEELineItems[ lineNum ]).mTaxID;
         //
         fFEELineQuery.Post();
      end;
   end;
   fFEELineQuery.Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnFEEItemControlObject.fGetAmountPaid: currency;
var
   FEECount : integer;
begin
   result := 0.00;
   for FEECount := 0 to FEELineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeOrder : result := result + tReturn_FEEItem_Form(FEELineItems[ FEECount ]).Amount;
         InvoiceTypeReport : result := result + tReturn_FEEItem_Report(FEELineItems[ FEECount ]).Amount;
      end;
   result := RoundTo(result, -2);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnFEEItemControlObject.fGetCount: integer;
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
function tReturnFEEItemControlObject.fGetAmountSubTotal: currency;
var
   lineCount : integer;
   TotalAmount : currency;
begin
   TotalAmount := 0.00;
   //
   for lineCount := 0 to FEELineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeOrder :
         begin
            if (tReturn_FEEItem_Form(FEELineItems[ lineCount ]).ReturnFlag ) then
               TotalAmount := TotalAmount + tReturn_FEEItem_Form(FEELineItems[ lineCount ]).Amount;
         end;
         InvoiceTypeReport :
         begin
            if (tReturn_FEEItem_Report(FEELineItems[ lineCount ]).ReturnFlag) then
               TotalAmount := TotalAmount + tReturn_FEEItem_Report(FEELineItems[ lineCount ]).Amount;
         end;
      end;
   //
   result := TotalAmount; // WE DO NOT ROUND HERE!!!
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(*********************************************)
(*********************************************)
(***** GET TOTAL AMOUNT *)
(*********************************************)
(*********************************************)

// Returns the total amount - FEE + TAX on FEE
function tReturnFEEItemControlObject.fGetTotalAmount: currency;
var
   lineCount : integer;
   TotalAmount : currency;
   TotalTaxAmount : currency;
   TaxRate : double;
begin
   TotalTaxAmount := 0.00;
   TotalAmount := 0;
   TaxRate := 0;
   //
   for lineCount := 0 to FEELineItems.Count - 1 do
   begin
   	TotalAmount := 0.00;
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder :
         begin
            if (tReturn_FEEItem_Form(FEELineItems[ lineCount ]).ReturnFlag ) then
            begin
               TotalAmount := tReturn_FEEItem_Form(FEELineItems[ lineCount ]).Amount;
               TaxRate := tReturn_FEEItem_Form(FEELineItems[ lineCount ]).TaxRate;
            end;
         end;
         InvoiceTypeReport :
         begin
            if (tReturn_FEEItem_Form(FEELineItems[ lineCount ]).ReturnFlag ) then
            begin
               TotalAmount := tReturn_FEEItem_Report(FEELineItems[ lineCount ]).Amount;
               TaxRate := tReturn_FEEItem_Report(FEELineItems[ lineCount ]).TaxRate;
            end;
         end;
      end;
		// Calculate it
      TotalAmount := TotalAmount + (TotalAmount * Tax_PerformTaxCalculation(TaxRate));
      // Done
      TotalTaxAmount := TotalTaxAmount + TotalAmount;
   end;
   //
   result := RoundTo(TotalTaxAmount, -2);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(*********************************************)
(*********************************************)
(***** GET TOTAL TAX *)
(*********************************************)
(*********************************************)

// Only returns the TAX on the items
function tReturnFEEItemControlObject.fGetTotalTax: currency;
var
   lineCount : integer;
   TotalAmount : currency;
   TotalTaxAmount : currency;
   TaxRate : double;
begin
   TotalTaxAmount := 0.00;
   TotalAmount := 0;
   TaxRate := 0;
   //
   for lineCount := 0 to FEELineItems.Count - 1 do
   begin
   	TotalAmount := 0.00;
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder :
         begin
            if (tReturn_FEEItem_Form(FEELineItems[ lineCount ]).ReturnFlag ) then
            begin
               TotalAmount := tReturn_FEEItem_Form(FEELineItems[ lineCount ]).Amount;
               TaxRate := tReturn_FEEItem_Form(FEELineItems[ lineCount ]).TaxRate;
            end;
         end;
         InvoiceTypeReport :
         begin
            if (tReturn_FEEItem_Report(FEELineItems[ lineCount ]).ReturnFlag ) then
            begin
               TotalAmount := tReturn_FEEItem_Report(FEELineItems[ lineCount ]).Amount;
               TaxRate := tReturn_FEEItem_Report(FEELineItems[ lineCount ]).TaxRate;
            end;
         end;
      end;
		// Calculate it
      TotalTaxAmount := TotalTaxAmount + (TotalAmount * Tax_PerformTaxCalculation(TaxRate));
   end;
   //
   result := RoundTo(TotalTaxAmount, -2);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnFEEItemControlObject.fSetOrderID(inVal: string);
var
	line :  integer;
begin
   fOrderID := inval;
   // now set all the Line items as well
   for line := 0 to FeeLineItems.Count - 1 do
   	if ( fInvoiceType = InvoiceTypeOrder ) then
      	tReturn_FEEItem_Form( FeeLineItems[ line ]).OrderID := fOrderID;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnFEEItemControlObject.fSetOrderType(inVal: tOrderTypes);
begin
   fOrderType := inVal;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// deletes a line
procedure tReturnFEEItemControlObject.DeleteLine;
var
	line : integer;
   doDelete : boolean;
begin
   for line := 0 to FeeLineItems.Count - 1 do
      if tReturn_FEEItem_Form(FeeLineItems[line]).LineNumber = fLineNumber then
      begin
         doDelete := false;
         case fInvoiceType of
            InvoiceTypeOrder :
            begin
               // we want to prompt them first...

               if ( tReturn_FEEItem_Form(FeeLineItems[line]).ReturnAdd ) then
               begin
                  if AvoBaseDialog('Delete Fee Line #' + IntToStr( line + 1),
                     'Delete highlighted Added Return Fee Line?', mtConfirmation, [mbYes,mbNo], 0) = mbYes then
                        doDelete := true;
               end else
                  AvoBaseDialog('Unable To Delete Return Fee',
                     'You cannot delete a Return Fee associated with a prior Order.', mtError, [mbok], 0);
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

procedure tReturnFEEItemControlObject.HandleLineItemClicked(Sender: tObject; LineNum: integer);
begin
   fLineNumber := LineNum;
   DoLineColor();
end;

procedure tReturnFEEItemControlObject.HandleRecalculateInvoice;
begin
	// we received an recaculate, so we are going to pass that all the way
   // down to the bottom because it will tell everyone to recalculate
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

procedure tReturnFEEItemControlObject.Handle_FEEItem_LineDelete(sender: tObject;
  lineNum: integer);
begin
   // do
end;

procedure tReturnFEEItemControlObject.Handle_FEEItem_LineUpdate(sender: tObject;
  lineNum: integer);
begin
   // do
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// Tell the prior object to recalculate
procedure tReturnFEEItemControlObject.RecalculateInvoice;
var
   lineCount : integer;
   lineItemRecord : tFeeItemRecord;
//   taxRec : tTaxREcord;
   taxRateTotal : double;
begin
   if (fRecalcON) then
   begin
      if ( fInvoiceType = InvoiceTypeOrder ) then
         for lineCount := 0 to FeeLineItems.Count - 1 do
         begin
            // because every line is individually taxed, we have to pull the tax rate here
            taxRateTotal := 0.00;
            if ( tReturn_FEEItem_Form( FeeLineItems[ lineCount ]).ReturnAdd ) then
            begin
               // THIS IS A USER ADDED FEE AFTER THE INVOICE FACT!
               {
               taxRec := Tax_GetTaxRecord(tReturn_FEEItem_Form( FeeLineItems[ lineCount ]).Amount );
               taxTotal := taxTotal + taxRec.taxRate;
               }
               taxRateTotal := taxRateTotal + Tax_TaxRateTotalByMasterTaxClassID(
                  tReturn_FEEItem_Form( FeeLineItems[ lineCount ]).Amount,
                  tReturn_FEEItem_Form( FeeLineItems[ lineCount ]).mTaxID );
               //
               tReturn_FEEItem_Form( FeeLineItems[ lineCount ]).TaxRate := taxRateTotal;
            end else
               // THIS IS A RETURN, NEVER GO GET CURRENT TAX CALCULATIONS - ONLY USE WHAT THEY ALREADY HAVE
               // UNLESS IT IS AN ADD ONLY!!!
               taxRateTotal := taxRateTotal + tReturn_FEEItem_Form( FeeLineItems[ lineCount ]).TaxRate;
            // now just do calculations
            lineItemRecord := CalculateLineItem(tReturn_FEEItem_Form(FeeLineItems[ lineCount ]));
            tReturn_FEEItem_Form( FeeLineItems[ lineCount ]).tTotalCostLabel.Caption := FormatFloat('####.00', lineItemRecord.AmountTotal);
            tReturn_FEEItem_Form( FeeLineItems[ lineCount ]).tTotalTaxLabel.Caption := FormatFloat('####.00', lineItemRecord.AmountTax);
         end;
   end;
end;



(** ********************************************************** **)
(** ********************************************************** **)
(** CALCULATE THE QUANTITIES, TAXES AND RETURN A PROPER RECORD **)
(** ********************************************************** **)
(** ********************************************************** **)

function tReturnFEEItemControlObject.LineItemRecordInitialize: tFeeItemRecord;
begin
   result.AmountTax := 0.00;
   result.AmountSubTotal := 0.00;
   result.AmountTotal := 0.00;
end;

function tReturnFEEItemControlObject.CalculateLineItem(inLineItem : tReturn_FEEItem_Form): tFeeItemRecord;
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
   if ( inLineItem.ReturnFlag ) then
      result.AmountSubTotal := ( 1 * sellAtCost) // there is only ever ONE amount per fee
   else
      Result.AmountSubTotal := 0;

   // calculate the amount of tax
   result.AmountTax := (result.AmountSubTotal * Tax_PerformTaxCalculation( TaxRate ));
   result.AmountTax := RoundTo( result.AmountTax, -2);

   // FINALLY - calculate the amount total
   result.AmountTotal := result.AmountSubTotal + result.AmountTax;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnFEEItemControlObject.CheckSave: string;
var
   lineCount : integer;
begin
   result := '';
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to FEELineItems.Count - 1 do
      begin
         if (tReturn_FEEItem_Form(FEELineItems[ lineCount ]).FeeName <> '') AND (tReturn_FEEItem_Form(FEELineItems[ lineCount ]).Amount = 0)
            then result := 'Fee line # ' + IntToStr( lineCount + 1 ) + ' cannot have a 0.00 amount.';
         if (tReturn_FEEItem_Form(FEELineItems[ lineCount ]).Amount <> 0) AND (tReturn_FEEItem_Form(FEELineItems[ lineCount ]).FeeName = '')
            then result := 'Fee line # ' + IntToStr( lineCount + 1 ) + ' has an amount but no fee name.';
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnFEEItemControlObject.Clear;
begin
   FEELineItems.Clear();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnFEEItemControlObject.RenumberInvoiceLines;
var
   lineCount : integer;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
      for lineCount := 0 to FeeLineItems.Count - 1 do
         tReturn_FEEItem_Form(FeeLineItems[ lineCount ]).LineNumber := lineCount;
end;

procedure tReturnFEEItemControlObject.ReturnAllFeeItems(inVal: boolean);
var
   lineCount : integer;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
      for lineCount := 0 to FeeLineItems.Count - 1 do
         tReturn_FEEItem_Form(FeeLineItems[ lineCount ]).ReturnAllFeeItems(inVal);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnFEEItemControlObject.DockSiteScrollBottom;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
   begin
      fDockSite.Visible := False;
      fDockSite.Realign;
      fDockSite.Perform(WM_VSCROLL, SB_BOTTOM, 0);
      fDockSite.Visible := True;
   end;
end;

procedure tReturnFEEItemControlObject.DoLineColor;
var
   lineCount : integer;
begin
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to FeeLineItems.Count - 1 do
      begin
         if (lineCount = fLineNumber) then
         begin
            tReturn_FEEItem_Form(FeeLineItems[ lineCount ]).LineItemOnePanel.Color := $00CAFFFF;
         end else
            begin
               tReturn_FEEItem_Form(FeeLineItems[ lineCount ]).LineItemOnePanel.Color := $00EAEAEA;
            end;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnFEEItemControlObject.RemoveNonReturnedLines;
var
	line : integer;
begin
   if ( FeeLineItems.Count -1 > -1 ) then
   begin
      if (fInvoiceType = InvoiceTypeOrder) then
      begin
         line := FeeLineItems.Count -1;
         repeat
            if (NOT tReturn_FEEItem_Form(FeeLineItems[line]).ReturnFlag ) then
            begin
               FeeLineItems.Delete( line );
               line := FeeLineItems.Count -1;
            end else
               dec(line);
         until line <= -1;
      end;
      if (fInvoiceType = InvoiceTypeReport) then
      begin
         line := FeeLineItems.Count -1;
         repeat
            if ( tReturn_FEEItem_Report(FeeLineItems[line]).ReturnFlag ) then
            begin
               FeeLineItems.Delete( line );
               line := FeeLineItems.Count -1;
            end else
               dec(line);
         until line <= -1;
      end;
      //
      FeeLineItems.Pack();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.


