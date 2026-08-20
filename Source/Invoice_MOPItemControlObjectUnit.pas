 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_MOPItemControlObjectUnit;

interface uses
   constantsunit,
   masterdataunit,
   toolboxunit,
   inifileunit,
   errorresultunit,
   avobase_percentformunit,
   avobase_dialogformunit,
   //
   Invoice_MOPItem_FormUnit,
   Invoice_MOPItem_NoFormUnit,
   EncryptUnit,
   toolbox_escrowtoolboxunit,
   toolbox_preferencetoolboxunit,
   Invoice_MOP_SelectEscrowFormUnit,
   //
   bde,
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Contnrs,
   math,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   DBTables;


type
	tMOPItemControlObject = class(tObject)
   protected
   private
   	fOrderID : string;
      fRecalcON : boolean;
      fOrgID : string;
      fCycleID : string;
      fCustID : string;
		fInvoiceType : tInvoiceTypes;
      fMOPLineQuery : tQuery;
      fDockSite : tScrollBox;
      fLineNumber : integer;
      fEscrowCredit : currency;
      //
      MOPLineItems : tObjectList; // This controls ALL of the item lists

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
		function fGetAmountVoid : currency;
      function fGetAmountEscrowUsed : currency;

      // ----------------------------------------------------------------------------- //
      // SET

      procedure HandleRecalculateInvoice;
      procedure HandleLineItemClicked( Sender : tObject; LineNum : integer);

   public
   	// Add New Line
   	function Add() : integer; overload;
      function AddBlankLineItem( inAmount : Currency ) : integer;
      function AddEscrowMOP( inAmount_TotalDue, inAmount_AvailEscrow, inAmount_EscrowUsed, inAmount_TotalMOP : currency ) : integer;



      // Delete
      procedure DeleteLine;

      // Load / Save
      procedure Load( inOrderID : string );
      function CheckSave : string;
      procedure Save();
      procedure DoLineColor();
      procedure RenumberInvoiceLines();
		procedure RecalculateInvoice();
      procedure DockSiteScrollBottom;
      procedure Clear();

      // ----------------------------------------------------------------------------- //
      // Events
      procedure Handle_MOPItem_LineDelete(  sender : tObject; lineNum : integer );
      procedure Handle_MOPItem_LineUpdate(  sender : tObject; lineNum : integer );

      // ----------------------------------------------------------------------------- //
   	// properties
      property Count : integer read fGetCount;
      property AmountPaid : currency read fGetAmountPaid;
      property OnRecalculateInvoiceEvent : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;
      property OrgID : string read fOrgID write fOrgID;
      property OrderID : string read fOrderID write fOrderID;
      property CycleID : string read fCycleID write fCycleID;
      property CustID : string read fCustID write fCustID;
      property EscrowCredit : currency read fEscrowCredit write fEscrowCredit;
      property AmountVoid : currency read fGetAmountVoid;
      property Amount_Escrow : currency read fGetAmountEscrowUsed;

      // ----------------------------------------------------------------------------- //
   	//
      constructor create( inDockPanel : tScrollBox; inInvoiceType : tInvoiceTypes); virtual;
      constructor destroy; virtual;
   end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tMOPItemControlObject.create( inDockPanel : tScrollBox; inInvoiceType : tInvoiceTypes);
begin
  inherited Create;
  //
  fOrderID := '';
  fInvoiceType := inInvoiceType;
  fMOPLineQuery := masterData.GetQuery;
  fDockSite := inDockPanel;
  //
  MOPLineItems := tObjectList.Create(True);
end;

constructor tMOPItemControlObject.destroy;
begin
   FreeAndNil( MOPLineItems );
   FreeAndNil( fMOPLineQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMOPItemControlObject.Add: integer;
var
	MOPItem_Form : tInvoice_MOPItem_Form;
   MOPItem_Report : tMOPItem_Report;
begin
   case fInvoiceType of
      // -------------------------------------------------------------------------
      // For Orders
      InvoiceTypeOrder:
      begin
         // determine the style, there is only one at the momento for release 2.0
         MOPItem_Form := tInvoice_MOPItem_Form.Create( fDockSite );
         fDockSite.Visible := False;
         with MOPItem_Form do
         begin
            // Set Normal Variables
            Height := FormHeight_Order;
            ManualDock( fDockSite );
            Visible := True;
            Show();
            Align := alBottom;
            Align := alTop;
            // set Events
            OnRecalculateInvoice := HandleRecalculateInvoice;
            OnLineClicked := HandleLineItemClicked;
         end;
         fDockSite.Visible := true;
         // Now add it to the list
         MOPLineItems.Add( MOPItem_Form );
         result := MOPLineItems.Count - 1;
      end;
      // -------------------------------------------------------------------------
      // For NON Orders
      InvoiceTypeReport:
      begin
         // Create
         MOPItem_Report := tMOPItem_Report.Create();
         // Set Normal Variables
         // There are NO events on this
         // Now add it to the list
         MOPLineItems.Add( MOPItem_Report );
         result := MOPLineItems.Count - 1;
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tMOPItemControlObject.Load(inOrderID: string);
var
   lineCount : integer;
   lineNum : integer;
begin
   fRecalcON := false;
	// initalize the variables
   MOPLineItems.Clear;
   fOrderID := inOrderID;

   // load the item
   fMOPLineQuery.Close();
   fMOPLineQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_MOP +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID);
   fMOPLineQuery.Open();
   if (fMOPLineQuery.RecordCount <> 0) then
   begin
   	while NOT fMOPLineQuery.Eof do
      begin
         // Create a line number, the ADD knows what to do and if to dock
         lineNum := Self.Add();
         // Now assign values to it
         case fInvoiceType of
            InvoiceTypeOrder :
            begin
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).LineNumber := lineNum;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).CycleID := fCycleID;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).ID := fMOPLineQuery.FieldByName('ID').AsString;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).OrgID := fMOPLineQuery.FieldByName('ORG_ID').AsString;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).OrderID := fOrderID;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).C_ID := fCustID;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopDate := fMOPLineQuery.FieldByName('MOPDATE').AsDateTime;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopType := fMOPLineQuery.FieldByName('MOPTYPE').AsInteger;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopValue := EncryptObj.DecryptString(fMOPLineQuery.FieldByName('MOPVALUE').AsString);
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopCCExpM := fMOPLineQuery.FieldByName('MOPCCEXPM').AsInteger;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopCCExpY := fMOPLineQuery.FieldByName('MOPCCEXPY').AsInteger;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopNoc := EncryptObj.DecryptString(fMOPLineQuery.FieldByName('MOPNOC').AsString);
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopCVV := EncryptObj.DecryptString(fMOPLineQuery.FieldByName('MOPCVV').AsString);
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).Amount := fMOPLineQuery.FieldByName('AMOUNT').AsCurrency;
               tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopCCT := fMOPLineQuery.FieldByName('MOPCCT').AsInteger;
            end;
            InvoiceTypeReport :
            begin
               tMOPItem_Report(MOPLineItems[ lineNum ]).LineNumber := lineNum;
               tMOPItem_Report(MOPLineItems[ lineNum ]).CycleID := fCycleID;
               tMOPItem_Report(MOPLineItems[ lineNum ]).ID := fMOPLineQuery.FieldByName('ID').AsString;
               tMOPItem_Report(MOPLineItems[ lineNum ]).OrgID := fMOPLineQuery.FieldByName('ORG_ID').AsString;
               tMOPItem_Report(MOPLineItems[ lineNum ]).OrderID := fMOPLineQuery.FieldByName('ORDER_ID').AsString;
               tMOPItem_Report(MOPLineItems[ lineNum ]).C_ID := fCustID;
               tMOPItem_Report(MOPLineItems[ lineNum ]).MopDate := fMOPLineQuery.FieldByName('MOPDATE').AsDateTime;
               tMOPItem_Report(MOPLineItems[ lineNum ]).MopType := fMOPLineQuery.FieldByName('MOPTYPE').AsInteger;
               tMOPItem_Report(MOPLineItems[ lineNum ]).MopValue := fMOPLineQuery.FieldByName('MOPVALUE').AsString;
               tMOPItem_Report(MOPLineItems[ lineNum ]).MopCCExpM := fMOPLineQuery.FieldByName('MOPCCEXPM').AsInteger;
               tMOPItem_Report(MOPLineItems[ lineNum ]).MopCCExpY := fMOPLineQuery.FieldByName('MOPCCEXPY').AsInteger;
               tMOPItem_Report(MOPLineItems[ lineNum ]).MopNoc := fMOPLineQuery.FieldByName('MOPNOC').AsString;
               tMOPItem_Report(MOPLineItems[ lineNum ]).MopCVV := fMOPLineQuery.FieldByName('MOPCVV').AsString;
               tMOPItem_Report(MOPLineItems[ lineNum ]).Amount := fMOPLineQuery.FieldByName('AMOUNT').AsCurrency;
               tMOPItem_Report(MOPLineItems[ lineNum ]).MopCCT := fMOPLineQuery.FieldByName('MOPCCT').AsInteger;
               tMOPItem_Report(MOPLineItems[ lineNum ]).Void := fMOPLineQuery.FieldByName('MOP_REV').AsBoolean;
            end;
         end;
         // we're done, there isn't anything we need to do.
         fMOPLineQuery.Next();
      end;
   end;
   fMOPLineQuery.Close();
   DoLineColor();
   fRecalcON := true;
end;

{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY YEAR, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'AMOUNT MONEY',
}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tMOPItemControlObject.Save;
var
   lineNum : integer;
   canSave : boolean;
begin
   // Delete any prior lines
   fMOPLineQuery.Close();
   fMOPLineQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_Mop +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( fOrderID );
   fMOPLineQuery.ExecSQL;

   // Now lets save...
   fMOPLineQuery.Close();
   fMOPLineQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Mop;
   fMOPLineQuery.Open();

   // Each item and save them.
   for lineNum := 0 to MOPLineItems.Count - 1 do
   begin
      canSave := true;
      //
      if (tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).Amount = 0 ) then
         canSave := false;
      //
      if (canSave) then
      begin
         fMOPLineQuery.Append();
         //
         fMOPLineQuery.FieldByName('ID').AsString := masterdata.NewDBGuid;
         fMOPLineQuery.FieldByName('ORG_ID').AsString := fOrgID;
         fMOPLineQuery.FieldByName('ORDER_ID').AsString := fOrderID;
         fMOPLineQuery.FieldByName('C_ID').AsString := fCustID; // We override here. We just do.
         fMOPLineQuery.FieldByName('MOPDATE').AsDateTime := tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopDate;
         fMOPLineQuery.FieldByName('MOPTYPE').AsInteger := tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopType;
         fMOPLineQuery.FieldByName('MOPVALUE').AsString := EncryptObj.EncryptString(tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopValue);
         fMOPLineQuery.FieldByName('MOPCCEXPM').AsInteger := tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopCCExpM;
         fMOPLineQuery.FieldByName('MOPCCEXPY').AsInteger := tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopCCExpY;
         fMOPLineQuery.FieldByName('MOPNOC').AsString := EncryptObj.EncryptString(tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopNoc);
         fMOPLineQuery.FieldByName('MOPCVV').AsString := EncryptObj.EncryptString(tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopCVV);
         fMOPLineQuery.FieldByName('AMOUNT').AsCurrency := tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).Amount;
         fMOPLineQuery.FieldByName('MOPCCT').AsInteger := tInvoice_MOPItem_Form(MOPLineItems[ lineNum ]).MopCCT;
         //
         fMOPLineQuery.Post();
      end;
   end;
   fMOPLineQuery.Close();
end;

{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'CID VARCHAR(40), ' + // customer ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY YEAR, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'AMOUNT MONEY',
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMOPItemControlObject.AddBlankLineItem( inAmount : Currency ) : integer;
begin
   result := Self.Add();
   if (fInvoiceType = InvoiceTypeOrder) then
   begin
      // Turn off recalc for a moment
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).OnRecalculateInvoice := NIL;

      tInvoice_MOPItem_Form(MOPLineItems[ result ]).LineNumber := result;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).ID := masterData.NewDBGuid;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).OrderID := fOrderID;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).OrgID := fOrgID;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).CycleID := fCycleID;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).C_ID := fCustID;
      //
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).MopDate := Now;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).MopType := 1;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).MopValue := '';
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).MopCCExpM := 1;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).MopCCExpY := 1;
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).MopNoc := '';
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).MopCVV := '';
      if ( inAmount <> 0 ) then
         tInvoice_MOPItem_Form(MOPLineItems[ result ]).Amount := inAmount
      else
         tInvoice_MOPItem_Form(MOPLineItems[ result ]).Amount := 0.00;

      // Turn Recalc Back On
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).OnRecalculateInvoice := HandleRecalculateInvoice;
      //
      tInvoice_MOPItem_Form(MOPLineItems[ result ]).Repaint();
   end;
   fLineNumber := result;
   DockSiteScrollBottom();
end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMOPItemControlObject.fGetAmountEscrowUsed: currency;
var
   lineCount : integer;
   usedEscrow : currency;
begin
   usedEscrow := 0;
   for lineCount := 0 to MOPLineItems.Count - 1 do
   begin
      case fInvoiceType of
         InvoiceTypeOrder : if ( tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopType = integer(PayTypeEscrow) ) then
            usedEscrow := usedEscrow + tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).Amount;
         InvoiceTypeReport : if ( tMOPItem_Report(MOPLineItems[ lineCount ]).MopType = integer(PayTypeEscrow) ) then
            usedEscrow := usedEscrow + tMOPItem_Report(MOPLineItems[ lineCount ]).Amount;
      end;
   end;
   result := usedEscrow;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMOPItemControlObject.fGetAmountPaid: currency;
var
   mopCount : integer;
begin
   result := 0.00;
   for mopCount := 0 to MOPLineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeOrder : result := result + tInvoice_MOPItem_Form(MOPLineItems[ mopCount ]).Amount;
         InvoiceTypeReport : result := result + tMOPItem_Report(MOPLineItems[ mopCount ]).Amount;
      end;
   // NOTE: we do NOT roundto here because we're not taxing this. It is a straight up figure.
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//  This method should only be called OUTSIDE of an open order
function tMOPItemControlObject.fGetAmountVoid: currency;
var
   mopCount : integer;
begin
   result := 0.00;
   for mopCount := 0 to MOPLineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeReport :
         begin
            if ( tMOPItem_Report(MOPLineItems[ mopCount ]).Void ) then
            	result := result + tMOPItem_Report(MOPLineItems[ mopCount ]).Amount;
         end;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMOPItemControlObject.fGetCount: integer;
begin
	result := MOPLineItems.Count;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tMOPItemControlObject.DeleteLine;
var
	line : integer;
   doDelete : boolean;
begin
   for line := 0 to MOPLineItems.Count - 1 do
      if tInvoice_MOPItem_Form(MOPLineItems[line]).LineNumber = fLineNumber then
      begin
         doDelete := false;
         case fInvoiceType of
            InvoiceTypeOrder :
            begin
               // we want to prompt them first...
               if AvoBaseDialog('Delete MOP Line #' + IntToStr( line + 1),
                  'Delete highlighted Method Of Payment Line?', mtConfirmation, [mbYes,mbNo], 0) = mbYes then
                     doDelete := true;
            end;
            InvoiceTypeReport : doDelete := true;
         end;
         if (doDelete) then
         begin
            MOPLineItems.Delete( line );
            Break; // otherwise we just don't fucking know where we are anymore
         end;
      end;
   MOPLineItems.Pack();
   RenumberInvoiceLines();
   // this is a delete line, so we'll just pass the same amount
   RecalculateInvoice();
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ EVENTS }

procedure tMOPItemControlObject.HandleLineItemClicked(Sender: tObject; LineNum: integer);
begin
   fLineNumber := LineNum;
   DoLineColor();
end;

procedure tMOPItemControlObject.HandleRecalculateInvoice;
begin
	// we received an recaculate, so we are going to pass that all the way
   // down to the bottom because it will tell everyone to recalculate
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;


procedure tMOPItemControlObject.Handle_MOPItem_LineDelete(sender: tObject;
  lineNum: integer);
begin
   // do
end;

procedure tMOPItemControlObject.Handle_MOPItem_LineUpdate(sender: tObject;
  lineNum: integer);
begin
   // do
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tMOPItemControlObject.RecalculateInvoice();
begin
   // We do very little here as this is a method of payment. It does not require recalculation.
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tMOPItemControlObject.RenumberInvoiceLines;
var
   lineCount : integer;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
      for lineCount := 0 to MOPLineItems.Count - 1 do
         tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).LineNumber := lineCount;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMOPItemControlObject.CheckSave: string;
var
   errMsg : string;
   lineCount : integer;
   mopType : integer;
   escrowCurr : currency;
begin
   result := '';
   if (fInvoiceType = InvoiceTypeOrder) then
   begin
      for lineCount := 0 to MOPLineItems.Count - 1 do
      begin
         errMsg := 'Method Of Payment line # ' + IntToStr( lineCount + 1) + ' ';

         if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).Amount = 0) then
            result := errMsg + 'cannot have a 0.00 amount.';
         //
         mopType := tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopType;
         case mopType of
            integer(PayTypeCheck) :
            begin
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopValue = '') then
                  result := errMsg + 'check number value cannot be blank.';
            end;
{ REMOVED FOR NOW
            integer(PayTypeCreditCard) :
            begin
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopValue = '') then
                  result := errMsg + 'credit card value cannot be blank.';
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopNoc = '') then
                  result := errMsg + 'name on card value cannot be blank.';
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopCVV = '') then
                  result := errMsg + 'CVV value cannot be blank.';
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MOPCCT = integer(CCTNone)) then
                  result := errMsg + 'Credit card type cannot be "None".';
            end;
}
            integer(PayTypeCashierCheck) :
            begin
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopValue = '') then
                  result := errMsg + 'cashier check number value cannot be blank.';
            end;
            integer(PayTypeMoneyOrder) :
            begin
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopValue = '') then
                  result := errMsg + 'money order number value cannot be blank.';
            end;
{ REMOVED FOR NOW
            integer(PayTypeDebitCard) :
            begin
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopValue = '') then
                  result := errMsg + 'debit card number value cannot be blank.';
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopNoc = '') then
                  result := errMsg + 'name on card value cannot be blank.';
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopCVV = '') then
                  result := errMsg + 'CVV value cannot be blank.';
            end;
}
            integer(PayTypePayPal) :
            begin
               if (tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopValue = '') then
                  result := errMsg + 'PayPal Transaction Number cannot be blank.';
            end;
         end;
      end;
      //
      // Now we have to make sure the TOTAL amount of credit used doesn't exceed the total amount of credit available
      escrowCurr := 0;
      for lineCount := 0 to MOPLineItems.Count - 1 do
         if ( tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).MopType = integer(PayTypeEscrow)) then
            escrowCurr := escrowCurr + tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).Amount;
      if ( escrowCurr > Escrow_GetCustomerEscrowByCustomerID( fCustID ) ) then
         result := 'The total Method Of Payments used Escrow Credit exceeds the total credit available to the ' +
            'Customer. Please review your Method Of Payments.';
   end;
end;

procedure tMOPItemControlObject.Clear;
begin
   MOPLineItems.Clear();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tMOPItemControlObject.DockSiteScrollBottom;
begin
   fDockSite.Visible := False;
   fDockSite.Realign;
   fDockSite.Perform(WM_VSCROLL, SB_BOTTOM, 0);
   fDockSite.Visible := True;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tMOPItemControlObject.DoLineColor;
var
   lineCount : integer;
begin
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to MOPLineItems.Count - 1 do
         if (lineCount = fLineNumber) then
            tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).LineItemOnePanel.Color := $00CAFFFF
         else
            tInvoice_MOPItem_Form(MOPLineItems[ lineCount ]).LineItemOnePanel.Color := $00EAEAEA;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This method gets the total invoice amount due passed to it. It then creates the escrow
// screen necessary with the information required.

function tMOPItemControlObject.AddEscrowMOP( inAmount_TotalDue, inAmount_AvailEscrow, inAmount_EscrowUsed, inAmount_TotalMOP : currency ) : integer;
var
   selectEscrow : tInvoice_MOP_SelectEscrowForm;
   inLineNum : integer;
   errMsg : string;
   Amount_EscrowLeftAvailable : currency;
   Amount_UsedEscrow : currency;
   Amount_BalanceToPay : currency;
begin
   // First, set it up so that whatever happens, the amount of escrow can't exceed used escrow
   Amount_UsedEscrow := 0;
   Amount_EscrowLeftAvailable := ( inAmount_AvailEscrow - inAmount_EscrowUsed );
   if ( Amount_EscrowLeftAvailable <= 0 ) then
      Amount_EscrowLeftAvailable := 0;
   //
   selectEscrow := tInvoice_MOP_SelectEscrowForm.Create( Application, 'Customer Escrow', true, fCustID );
   // fill in the values
   selectEscrow.Amount_TotalEscrowUsed := inAmount_EscrowUsed;
   selectEscrow.Amount_TotalDue := inAmount_TotalDue;
   selectEscrow.Amount_MOP := inAmount_TotalMOP;
   selectEscrow.Amount_TotalAvailEscrow := inAmount_AvailEscrow;
   //
   Amount_BalanceToPay := ( inAmount_TotalDue - inAmount_TotalMOP );

   if ( Amount_EscrowLeftAvailable < Amount_BalanceToPay ) then
      Amount_BalanceToPay := Amount_EscrowLeftAvailable;

   selectEscrow.Amount := Amount_BalanceToPay;
   //
   if ( selectEscrow.ValidateData ) then
   begin
      selectEscrow.ShowModal();
      Amount_UsedEscrow := selectEscrow.Amount;
      if ( selectEscrow.FormResult = mrOk ) then
      begin
         if ( Amount_UsedEscrow + inAmount_EscrowUsed >  inAmount_AvailEscrow ) then
         AvoBaseDialog('Amount Exceeds Escrow',
            'The amount selected exceed the total available Escrow funds (Available + Already Used).', mtError, [mbOK], 0)
         else
         begin
            // now create the lin eitem
            inLineNum := AddBlankLineItem( Amount_UsedEscrow );
            tInvoice_MOPItem_Form(MOPLineItems[ inLineNum ]).MopType := integer(PayTypeEscrow);
         end;
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.




