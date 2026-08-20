 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Return_LineItemControlObjectUnit;

interface uses
   constantsunit,
   masterdataunit,
   toolboxunit,
   masterdata_updateunit,
   inifileunit,
   errorresultunit,
   avobase_percentformunit,
   avobase_dialogformunit,
   toolbox_producttoolboxunit,
   recordstructureunit,
   toolbox_TaxToolBoxUnit,
   //
   Return_LineItem_FormUnit,
   Return_LineItem_NoFormUnit,
   //
   bde,
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Contnrs,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   math,
   StdCtrls,
   DBTables;




//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

type
	tLineItemControlObject = class(tObject)
   private
      fRecalcON : boolean;
   	fOrderID : string;
      fOrgID : string;
      fCycleID : string;
      fOrderType : tOrderTypes;
      fTaxRate : currency;
		fInvoiceType : tInvoiceTypes;
      fLineItemStyle : tInvoiceLineItemStyles;
      fLineQuery : tQuery;
      fDockSite : tScrollBox;
      fLineNumber : integer;
      //
      LineItems : tObjectList; // This controls ALL of the item lists

      // ----------------------------------------------------------------------------- //
      // events
      fOnNewLine : tNotifyEvent;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;
      fDeleteLine : tDeleteLineEvent;

      // ----------------------------------------------------------------------------- //
      // GET
      function fGetCount : integer;
      function fGetTotalAmount : currency;
      function fGetTotalTax : currency;
      function fGetSubTotal : currency;
      function fGetReturnCount : integer;
      function fGetAmount_TotalRetail : currency;
      function fGetAmount_TotalSellAt : currency;

      // ----------------------------------------------------------------------------- //
      // SET

      function CalculateLineItem( inLineItem : tReturn_LineItem_Form ) : tReturnLineItemRecord; overload;
      function CalculateLineItem( inLineItem : tReturn_LineItem_Report ) : tReturnLineItemRecord; overload;

      function LineItemRecordInitialize : tReturnLineItemRecord;
		procedure HandleRecalculateInvoice;
      procedure HandleLineItemClicked( Sender : tObject; LineNum : integer);
      procedure DockSiteScrollBottom;
      procedure RenumberInvoiceLines;
      procedure fSetOrderType( inVal : tOrderTypes );
      procedure fSetOrderID( inVal : string );
   public
   	// Add New Line
   	function Add() : integer; overload;
      function AddProduct( inID : string ) : integer;

      // Delete
      procedure DeleteLine;

      // Load / Save
      procedure Load( inOrderID : string );
      procedure LoadNewReturn(inOrderID: string);
      function CheckSave : string;
      procedure Save();
      procedure SaveReport();
      procedure DoLineColor();
      procedure RemoveNonReturnedQTYLines();
      procedure ReturnAllLineItems( inVal : boolean );

      // ----------------------------------------------------------------------------- //
   	// properties
      property Count : integer read fGetCount;
      property AmountTotalAmount : currency read fGetTotalAmount;
      property AmountTotalTax : currency read fGetTotalTax;
      property AmountSubTotal : currency read fGetSubTotal;
      property Amount_TotalRetail : currency read fGetAmount_TotalRetail;
      property Amount_TotalSellAt : currency read fGetAmount_TotalSellAt;
      property TaxRate : currency read fTaxRate write fTaxRate;
      property OrgID : string read fOrgID write fOrgID;
      property OrderID : string read fOrderID write fSetOrderID;
      property CycleID : string read fCycleID write fCycleID;
      property OrderType : tOrderTypes read fOrderType write fSetOrderType;
      property ReturnCount : integer read fGetReturnCount;

      // ----------------------------------------------------------------------------- //
      // Events
      procedure Handle_LineItem_LineDelete(  lineNum : integer );
      procedure Handle_LineItem_LineUpdate(  sender : tObject; lineNum : integer );
      property OnRecalculateInvoiceEvent : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;

		procedure RecalculateInvoice;

      // ----------------------------------------------------------------------------- //
   	//
      constructor create( inDockPanel : tScrollBox; inInvoiceType : tInvoiceTypes); virtual;
      constructor destroy; virtual;
   end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tLineItemControlObject.create( inDockPanel : tScrollBox; inInvoiceType : tInvoiceTypes);
begin
   inherited Create;
   //
   fOrderID := '';
   fInvoiceType := inInvoiceType;
   fLineItemStyle := liGeneric; // NOTE: eventually this has to COME from preferences.
   fLineQuery := masterData.GetQuery;
   fDockSite := inDockPanel;
   fRecalcON := true;
   //
   LineItems := tObjectList.Create(True);
end;

constructor tLineItemControlObject.destroy;
begin
   FreeAndNil( LineItems );
   FreeAndNil( fLineQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tLineItemControlObject.Add() : integer;
var
	LineItem_Form : tReturn_LineItem_Form;
   LineItem_Report : tReturn_LineItem_Report;
begin
   case fInvoiceType of
      // -------------------------------------------------------------------------
      // For Orders
      InvoiceTypeOrder:
      begin
         // determine the style, there is only one at the momento for release 2.0
         LineItem_Form := tReturn_LineItem_Form.Create( fDockSite );
         fDockSite.Visible := False;
         with LineItem_Form do
         begin
            // Set Normal Variables
            Height := LineItem_FormHeight_Order;
            ManualDock( fDockSite );
            Visible := True;
            Show();
            Align := alBottom;
            Align := alTop;
            // set Events
            OnLineDelete := Handle_LineItem_LineDelete;
            OnLineUpdate := Handle_LineItem_LineUpdate;
            OnRecalculateInvoice := HandleRecalculateInvoice;
            OnLineClicked := HandleLineItemClicked;
         end;
         fDockSite.Visible := true;
         // Now add it to the list
         LineItems.Add( LineItem_Form );
         result := LineItems.Count - 1;
      end;
      // -------------------------------------------------------------------------
      // For NON Orders
      InvoiceTypeReport:
      begin
         // Create
         LineItem_Report := tReturn_LineItem_Report.Create();
         // Set Normal Variables
         // There are NO events on this
         // Now add it to the list
         LineItems.Add( LineItem_Report );
         result := LineItems.Count - 1;
      end;
   end;
end;

// this adds a blank line. we have to add the taxes, cycle, and all that crap to it.
// this is a lot of work here.

function tLineItemControlObject.AddProduct( inID : string ): integer;
var
   prodRec : tprodRec;
begin
   result := -1;
   prodRec := Product_GetProductByProductID( inID );
   if ( inID <> '') then
   begin
      result := Self.Add();
      if (fInvoiceType = InvoiceTypeOrder) then
      begin
         tReturn_LineItem_Form(LineItems[ result ]).LineNumber := result;
         tReturn_LineItem_Form(LineItems[ result ]).CycleID := prodRec.c_id;
         tReturn_LineItem_Form(LineItems[ result ]).Amount_Retail := prodRec.amount;
         tReturn_LineItem_Form(LineItems[ result ]).Amount_SellAt := prodRec.amount;
         tReturn_LineItem_Form(LineItems[ result ]).ID := prodRec.id;
         tReturn_LineItem_Form(LineItems[ result ]).OrderID := fOrderID;
         tReturn_LineItem_Form(LineItems[ result ]).OrgID := prodRec.org_id;
         tReturn_LineItem_Form(LineItems[ result ]).QTYSold := 1;
         tReturn_LineItem_Form(LineItems[ result ]).QTYReturned := 0;
         tReturn_LineItem_Form(LineItems[ result ]).QTYFree := 0;
         tReturn_LineItem_Form(LineItems[ result ]).ProductNum := prodRec.num;
         tReturn_LineItem_Form(LineItems[ result ]).ProductName := prodRec.name;
         tReturn_LineItem_Form(LineItems[ result ]).ProductDesc := prodRec.descr;
         tReturn_LineItem_Form(LineItems[ result ]).productprodn1 := prodrec.prodn1;
         tReturn_LineItem_Form(LineItems[ result ]).productprodn2 := prodrec.prodn2;
         tReturn_LineItem_Form(LineItems[ result ]).productprodn3 := prodrec.prodn3;
         tReturn_LineItem_Form(LineItems[ result ]).productprodn4 := prodrec.prodn4;
      end;
      fLineNumber := result;
      DockSiteScrollBottom();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// LOAD ITEMS ONLY FOR A NEW RETURN
procedure tLineItemControlObject.LoadNewReturn(inOrderID: string);
var
   lineNum : integer;
   canLoad : boolean;
   sQty, fQty, pQTY : integer;
begin
	// initalize the variables
   fRecalcON := false;
   LineItems.Clear;
   fOrderID := inOrderId;

   // load the item
   fLineQuery.Close();
   fLineQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID);
   fLineQuery.Open();
   if (fLineQuery.RecordCount <> 0) then
   begin
   	while NOT fLineQuery.EOF do
      begin
         // Ok these are special cases, we have to find out if these are a GO or a NO GO
         canLoad := true;
         //
         sQty := fLineQuery.FieldByName('SQTY').AsInteger;
         fQty := fLineQuery.FieldByName('FQTY').AsInteger;
         //
         pQTY := fLineQuery.FieldByName('PQTY').AsInteger;

         // have they already returned ALL of the products?
         if pQTY >= ( sQty + fQty ) then
            canLoad := false;

         // Back Ordered NO LOnger Available means it never shipped, can't return those.
         if ( fLineQuery.FieldByName('BOT').AsInteger <> 0 ) then
            canLoad := false;

{
         if ( fLineQuery.FieldByName('BOT').AsInteger = integer(BONoLongerAvail)) then
            canLoad := false;
}

         // ok we ready?
         if ( canLoad ) then
         begin
            // Create a line number, the ADD knows what to do and if to dock
            lineNum := Self.Add();
            // Now assign values to it
            case fInvoiceType of
               InvoiceTypeOrder :
               begin
                  tReturn_LineItem_Form(LineItems[ lineNum ]).LineNumber := lineNum;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).CycleID := fLineQuery.FieldByName('C_ID').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).Amount_Retail := fLineQuery.FieldByName('RCOST').AsCurrency;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).Amount_SellAt := fLineQuery.FieldByName('SCOST').AsCurrency;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).ID := fLineQuery.FieldByName('ID').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).OrderID := fLineQuery.FieldByName('ORDER_ID').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).OrgID := fLineQuery.FieldByName('ORG_ID').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).BackOrderType := fLineQuery.FieldByName('BOT').AsInteger;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).LineItemFree := fLineQuery.FieldByName('LIFREE').AsBoolean;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).TaxRate := fLineQuery.FieldByName('TAX').AsCurrency;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).QTYSold := fLineQuery.FieldByName('SQTY').AsInteger;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).QTYReturned := fLineQuery.FieldByName('RQTY').AsInteger;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).QTYFree := fLineQuery.FieldByName('FQTY').AsInteger;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).ProductNum := fLineQuery.FieldByName('NUM').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).ProductName := fLineQuery.FieldByName('NAME').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).ProductDesc := fLineQuery.FieldByName('DESCR').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn1 := fLineQuery.FieldByName('PRODN1').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn2 := fLineQuery.FieldByName('PRODN2').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn3 := fLineQuery.FieldByName('PRODN3').AsString;
                  tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn4 := fLineQuery.FieldByName('PRODN4').AsString;
                  // the ReturnPRODID here is important as it must match the PRIOR ORDER's ID...
                  tReturn_LineItem_Form(LineItems[ lineNum ]).ReturnProdID := fLineQuery.FieldByName('ID').AsString;
                  //
                  //tReturn_LineItem_Form(LineItems[ lineNum ]).Repaint();
               end;
            end;
         end;
         // we're done, there isn't anything we need to do.
         fLineQuery.Next();
      end;
   end;
   fLineQuery.Close();
   //
   if (fInvoiceType = InvoiceTypeOrder) then
   begin
      // set it to the FIRST line number
      fLineNumber := 0;
      // redraw
      DoLineColor();
   end;
   fRecalcON := true;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


// LOAD
procedure tLineItemControlObject.Load(inOrderID: string);
var
   lineNum : integer;
begin
	// initalize the variables
   fRecalcON := false;
   LineItems.Clear;
   fOrderID := inOrderId;

   // load the item
   fLineQuery.Close();
   fLineQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID);
   fLineQuery.Open();
   if (fLineQuery.RecordCount <> 0) then
   begin
   	while NOT fLineQuery.EOF do
      begin
         // Create a line number, the ADD knows what to do and if to dock
         lineNum := Self.Add();
         // Now assign values to it
         case fInvoiceType of
            InvoiceTypeOrder :
            begin
               tReturn_LineItem_Form(LineItems[ lineNum ]).LineNumber := lineNum;
               tReturn_LineItem_Form(LineItems[ lineNum ]).CycleID := fLineQuery.FieldByName('C_ID').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).Amount_Retail := fLineQuery.FieldByName('RCOST').AsCurrency;
               tReturn_LineItem_Form(LineItems[ lineNum ]).Amount_SellAt := fLineQuery.FieldByName('SCOST').AsCurrency;
               tReturn_LineItem_Form(LineItems[ lineNum ]).ID := fLineQuery.FieldByName('ID').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).OrderID := fLineQuery.FieldByName('ORDER_ID').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).OrgID := fLineQuery.FieldByName('ORG_ID').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).BackOrderType := fLineQuery.FieldByName('BOT').AsInteger;
               tReturn_LineItem_Form(LineItems[ lineNum ]).LineItemFree := fLineQuery.FieldByName('LIFREE').AsBoolean;
               tReturn_LineItem_Form(LineItems[ lineNum ]).TaxRate := fLineQuery.FieldByName('TAX').AsCurrency;
               tReturn_LineItem_Form(LineItems[ lineNum ]).QTYSold := fLineQuery.FieldByName('SQTY').AsInteger;
               tReturn_LineItem_Form(LineItems[ lineNum ]).QTYReturned := fLineQuery.FieldByName('RQTY').AsInteger;
               tReturn_LineItem_Form(LineItems[ lineNum ]).QTYFree := fLineQuery.FieldByName('FQTY').AsInteger;
               tReturn_LineItem_Form(LineItems[ lineNum ]).ProductNum := fLineQuery.FieldByName('NUM').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).ProductName := fLineQuery.FieldByName('NAME').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).ProductDesc := fLineQuery.FieldByName('DESCR').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn1 := fLineQuery.FieldByName('PRODN1').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn2 := fLineQuery.FieldByName('PRODN2').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn3 := fLineQuery.FieldByName('PRODN3').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn4 := fLineQuery.FieldByName('PRODN4').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).ReturnProdID := fLineQuery.FieldByName('R_ID').AsString;
               tReturn_LineItem_Form(LineItems[ lineNum ]).QTYPriorReturned := fLineQuery.FieldByName('PQTY').AsInteger;
               //
               //tReturn_LineItem_Form(LineItems[ lineNum ]).Repaint();
            end;
            InvoiceTypeReport :
            begin
               tReturn_LineItem_Report(LineItems[ lineNum ]).LineNumber := lineNum;
               tReturn_LineItem_Report(LineItems[ lineNum ]).CycleID := fLineQuery.FieldByName('C_ID').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).Amount_Retail := fLineQuery.FieldByName('RCOST').AsCurrency;
               tReturn_LineItem_Report(LineItems[ lineNum ]).Amount_SellAt := fLineQuery.FieldByName('SCOST').AsCurrency;
               tReturn_LineItem_Report(LineItems[ lineNum ]).ID := fLineQuery.FieldByName('ID').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).OrderID := fLineQuery.FieldByName('ORDER_ID').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).OrgID := fLineQuery.FieldByName('ORG_ID').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).BackOrderType := fLineQuery.FieldByName('BOT').AsInteger;
               tReturn_LineItem_Report(LineItems[ lineNum ]).LineItemFree := fLineQuery.FieldByName('LIFREE').AsBoolean;
               tReturn_LineItem_Report(LineItems[ lineNum ]).TaxRate := fLineQuery.FieldByName('TAX').AsCurrency;
               tReturn_LineItem_Report(LineItems[ lineNum ]).QTYSold := fLineQuery.FieldByName('SQTY').AsInteger;
               tReturn_LineItem_Report(LineItems[ lineNum ]).QTYReturned := fLineQuery.FieldByName('RQTY').AsInteger;
               tReturn_LineItem_Report(LineItems[ lineNum ]).QTYFree := fLineQuery.FieldByName('FQTY').AsInteger;
               tReturn_LineItem_Report(LineItems[ lineNum ]).ProductNum := fLineQuery.FieldByName('NUM').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).ProductName := fLineQuery.FieldByName('NAME').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).ProductDesc := fLineQuery.FieldByName('DESCR').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).productprodn1 := fLineQuery.FieldByName('PRODN1').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).productprodn2 := fLineQuery.FieldByName('PRODN2').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).productprodn3 := fLineQuery.FieldByName('PRODN3').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).productprodn4 := fLineQuery.FieldByName('PRODN4').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).ReturnProdID := fLineQuery.FieldByName('R_ID').AsString;
               tReturn_LineItem_Report(LineItems[ lineNum ]).QTYPriorReturned := fLineQuery.FieldByName('PQTY').AsInteger;
            end;
         end;
         // we're done, there isn't anything we need to do.
         fLineQuery.Next();
      end;
   end;
   fLineQuery.Close();
   //
   if (fInvoiceType = InvoiceTypeOrder) then
   begin
      // set it to the FIRST line number
      fLineNumber := 0;
      // redraw
      DoLineColor();
   end;
   fRecalcON := true;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// this only assumes that it IS an invoice kind. not a report.
procedure tLineItemControlObject.Save;
var
   lineNum : integer;
   canSave : boolean;
begin
   // Delete any prior lines
   fLineQuery.Close();
   fLineQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( fOrderID );
   fLineQuery.ExecSQL;

   // Now lets save...
   fLineQuery.Close();
   fLineQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product;
   fLineQuery.Open();

   // Each item and save them.
   for lineNum := 0 to LineItems.Count - 1 do
   begin
      canSave := true;
      //
      if (Return_MaskEdit_ProductNumber(tReturn_LineItem_Form(LineItems[ lineNum ]).ProductNum) = '') then
         canSave := false;
      if (tReturn_LineItem_Form(LineItems[ lineNum ]).QTYSold = 0) AND
         (tReturn_LineItem_Form(LineItems[ lineNum ]).QTYFree = 0) AND
         (tReturn_LineItem_Form(LineItems[ lineNum ]).QTYReturned = 0) then
         canSave := false;
      if (tReturn_LineItem_Form(LineItems[ lineNum ]).ProductName = '') then
         canSave := false;
      //
      if (canSave) then
      begin
         fLineQuery.Append();
         //
         fLineQuery.FieldByName('ID').AsString := masterdata.NewDBGuid;
         fLineQuery.FieldByName('C_ID').AsString :=        tReturn_LineItem_Form(LineItems[ lineNum ]).CycleID;
         fLineQuery.FieldByName('RCOST').AsCurrency :=     tReturn_LineItem_Form(LineItems[ lineNum ]).Amount_Retail;
         fLineQuery.FieldByName('SCOST').AsCurrency :=     tReturn_LineItem_Form(LineItems[ lineNum ]).Amount_SellAt;
         fLineQuery.FieldByName('ORDER_ID').AsString :=    tReturn_LineItem_Form(LineItems[ lineNum ]).OrderID;
         fLineQuery.FieldByName('ORG_ID').AsString :=      tReturn_LineItem_Form(LineItems[ lineNum ]).OrgID;
         fLineQuery.FieldByName('BOT').AsInteger :=        tReturn_LineItem_Form(LineItems[ lineNum ]).BackOrderType;
         fLineQuery.FieldByName('LIFREE').AsBoolean :=     tReturn_LineItem_Form(LineItems[ lineNum ]).LineItemFree;
         fLineQuery.FieldByName('TAX').AsCurrency :=       tReturn_LineItem_Form(LineItems[ lineNum ]).TaxRate;
         fLineQuery.FieldByName('SQTY').AsInteger :=       tReturn_LineItem_Form(LineItems[ lineNum ]).QTYSold;
         fLineQuery.FieldByName('RQTY').AsInteger :=       tReturn_LineItem_Form(LineItems[ lineNum ]).QTYReturned;
         fLineQuery.FieldByName('FQTY').AsInteger :=       tReturn_LineItem_Form(LineItems[ lineNum ]).QTYFree;
         fLineQuery.FieldByName('NUM').AsString :=         tReturn_LineItem_Form(LineItems[ lineNum ]).ProductNum;
         fLineQuery.FieldByName('NAME').AsString :=        ProperCase(tReturn_LineItem_Form(LineItems[ lineNum ]).ProductName, true);
         fLineQuery.FieldByName('DESCR').AsString :=       ProperCase(tReturn_LineItem_Form(LineItems[ lineNum ]).ProductDesc, true);
         fLineQuery.FieldByName('PRODN1').AsString :=       tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn1;
         fLineQuery.FieldByName('PRODN2').AsString :=       tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn2;
         fLineQuery.FieldByName('PRODN3').AsString :=       tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn3;
         fLineQuery.FieldByName('PRODN4').AsString :=       tReturn_LineItem_Form(LineItems[ lineNum ]).productprodn4;
         fLineQuery.FieldByName('R_ID').AsString :=        tReturn_LineItem_Form(LineItems[ lineNum ]).ReturnProdID;
         fLineQuery.FieldByName('PQTY').AsInteger :=        tReturn_LineItem_Form(LineItems[ lineNum ]).QTYPriorReturned;
         //
         fLineQuery.Post();
      end;
   end;
   fLineQuery.Close();
end;

// THIS IS FOR A INVOICE REPORT ONLY (in case they save from the order list rather than inside)
procedure tLineItemControlObject.SaveReport;
var
   lineNum : integer;
   canSave : boolean;
begin
   // Delete any prior lines
   fLineQuery.Close();
   fLineQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( fOrderID );
   fLineQuery.ExecSQL;

   // Now lets save...
   fLineQuery.Close();
   fLineQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product;
   fLineQuery.Open();

   // Each item and save them.
   for lineNum := 0 to LineItems.Count - 1 do
   begin
      canSave := true;
      //
      if (Return_MaskEdit_ProductNumber(tReturn_LineItem_Report(LineItems[ lineNum ]).ProductNum) = '') then
         canSave := false;
      if (tReturn_LineItem_Report(LineItems[ lineNum ]).QTYSold = 0) AND
         (tReturn_LineItem_Report(LineItems[ lineNum ]).QTYFree = 0) AND
         (tReturn_LineItem_Report(LineItems[ lineNum ]).QTYReturned = 0) then
         canSave := false;
      if (tReturn_LineItem_Report(LineItems[ lineNum ]).ProductName = '') then
         canSave := false;
      //
      if (canSave) then
      begin
         fLineQuery.Append();
         //
         fLineQuery.FieldByName('ID').AsString := masterdata.NewDBGuid;
         fLineQuery.FieldByName('C_ID').AsString :=        tReturn_LineItem_Report(LineItems[ lineNum ]).CycleID;
         fLineQuery.FieldByName('RCOST').AsCurrency :=     tReturn_LineItem_Report(LineItems[ lineNum ]).Amount_Retail;
         fLineQuery.FieldByName('SCOST').AsCurrency :=     tReturn_LineItem_Report(LineItems[ lineNum ]).Amount_SellAt;
         fLineQuery.FieldByName('ORDER_ID').AsString :=    tReturn_LineItem_Report(LineItems[ lineNum ]).OrderID;
         fLineQuery.FieldByName('ORG_ID').AsString :=      tReturn_LineItem_Report(LineItems[ lineNum ]).OrgID;
         fLineQuery.FieldByName('BOT').AsInteger :=        tReturn_LineItem_Report(LineItems[ lineNum ]).BackOrderType;
         fLineQuery.FieldByName('LIFREE').AsBoolean :=     tReturn_LineItem_Report(LineItems[ lineNum ]).LineItemFree;
         fLineQuery.FieldByName('TAX').AsCurrency :=       tReturn_LineItem_Report(LineItems[ lineNum ]).TaxRate;
         fLineQuery.FieldByName('SQTY').AsInteger :=       tReturn_LineItem_Report(LineItems[ lineNum ]).QTYSold;
         fLineQuery.FieldByName('RQTY').AsInteger :=       tReturn_LineItem_Report(LineItems[ lineNum ]).QTYReturned;
         fLineQuery.FieldByName('FQTY').AsInteger :=       tReturn_LineItem_Report(LineItems[ lineNum ]).QTYFree;
         fLineQuery.FieldByName('NUM').AsString :=         tReturn_LineItem_Report(LineItems[ lineNum ]).ProductNum;
         fLineQuery.FieldByName('NAME').AsString :=        ProperCase(tReturn_LineItem_Report(LineItems[ lineNum ]).ProductName, true);
         fLineQuery.FieldByName('DESCR').AsString :=       ProperCase(tReturn_LineItem_Report(LineItems[ lineNum ]).ProductDesc, true);
         fLineQuery.FieldByName('PRODN1').AsString :=       tReturn_LineItem_Report(LineItems[ lineNum ]).productprodn1;
         fLineQuery.FieldByName('PRODN2').AsString :=       tReturn_LineItem_Report(LineItems[ lineNum ]).productprodn2;
         fLineQuery.FieldByName('PRODN3').AsString :=       tReturn_LineItem_Report(LineItems[ lineNum ]).productprodn3;
         fLineQuery.FieldByName('PRODN4').AsString :=       tReturn_LineItem_Report(LineItems[ lineNum ]).productprodn4;
         fLineQuery.FieldByName('R_ID').AsString :=        tReturn_LineItem_Report(LineItems[ lineNum ]).ReturnProdID;
         fLineQuery.FieldByName('PQTY').AsInteger :=        tReturn_LineItem_Report(LineItems[ lineNum ]).QTYPriorReturned;
         //
         fLineQuery.Post();
      end;
   end;
   fLineQuery.Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tLineItemControlObject.fGetAmount_TotalRetail: currency;
var
   lineCount : integer;
begin
   result := 0;
   for lineCount := 0 to LineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeOrder : result := result + tReturn_LineItem_Form(LineItems[ lineCount ]).Amount_Retail;
         InvoiceTypeReport : result := result + tReturn_LineItem_Report(LineItems[ lineCount ]).Amount_Retail;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tLineItemControlObject.fGetAmount_TotalSellAt: currency;
var
   lineCount : integer;
begin
   result := 0;
   for lineCount := 0 to LineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeOrder : result := result + tReturn_LineItem_Form(LineItems[ lineCount ]).Amount_SellAt;
         InvoiceTypeReport : result := result + tReturn_LineItem_Report(LineItems[ lineCount ]).Amount_SellAt;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


function tLineItemControlObject.fGetCount: integer;
begin
	result := LineItems.Count;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// this only returns items with return quantities
function tLineItemControlObject.fGetReturnCount: integer;
var
   lineCount : integer;
begin
   result := 0;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   begin
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder : result := result + tReturn_LineItem_Form(LineItems[ lineCount ]).QTYReturned;
         InvoiceTypeReport : result := result + tReturn_LineItem_Report(LineItems[ lineCount ]).QTYReturned;
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(*********************************************)
(*********************************************)
(***** GET SUB TOTAL *)
(*********************************************)
(*********************************************)

function tLineItemControlObject.fGetSubTotal: currency;
var
   lineCount : integer;
   lineItemRecord : tReturnLineItemRecord;
begin
   result := 0.00;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   begin
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder : lineItemRecord := CalculateLineItem(tReturn_LineItem_Form(LineItems[ lineCount ]));
         InvoiceTypeReport : lineItemRecord := CalculateLineItem(tReturn_LineItem_Report(LineItems[ lineCount ]));
      end;
      result := result + lineItemRecord.AmountSubTotal;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(*********************************************)
(*********************************************)
(***** GET TOTAL AMOUNT *)
(*********************************************)
(*********************************************)

function tLineItemControlObject.fGetTotalAmount: currency;
var
   lineCount : integer;
   lineItemRecord : tReturnLineItemRecord;
begin
   result := 0.00;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   begin
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder : lineItemRecord := CalculateLineItem(tReturn_LineItem_Form(LineItems[ lineCount ]));
         InvoiceTypeReport : lineItemRecord := CalculateLineItem(tReturn_LineItem_Report(LineItems[ lineCount ]));
      end;
      result := result + lineItemRecord.AmountTotal;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(*********************************************)
(*********************************************)
(***** GET TOTAL TAX *)
(*********************************************)
(*********************************************)

function tLineItemControlObject.fGetTotalTax: currency;
var
   lineCount : integer;
   lineItemRecord : tReturnLineItemRecord;
begin
   result := 0.00;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   begin
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder : lineItemRecord := CalculateLineItem(tReturn_LineItem_Form(LineItems[ lineCount ]));
         InvoiceTypeReport : lineItemRecord := CalculateLineItem(tReturn_LineItem_Report(LineItems[ lineCount ]));
      end;
      result := result + lineItemRecord.AmountTax;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tLineItemControlObject.fSetOrderID(inVal: string);
var
	line :  integer;
begin
   fOrderID := inval;
   // now set all the Line items as well
   for line := 0 to LineItems.Count - 1 do
   	if ( fInvoiceType = InvoiceTypeOrder ) then
      	tReturn_LineItem_Form(LineItems[ line ]).OrderID := fOrderID;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tLineItemControlObject.fSetOrderType(inVal: tOrderTypes);
begin
   fOrderType := inVal;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tLineItemControlObject.DeleteLine;
var
	line : integer;
   doDelete : boolean;
begin
	// deletes a line
   for line := 0 to LineItems.Count - 1 do
      if tReturn_LineItem_Form(LineItems[line]).LineNumber = fLineNumber then
      begin
         doDelete := false;
         case fInvoiceType of
            InvoiceTypeOrder :
            begin
               // we want to prompt them first...
               if (tReturn_LineItem_Form(LineItems[ line ]).ProductSold) then
                  AvoBaseDialog('Invoice Line Item Sold',
                     'This Invoice Line Item has already been sold and Closed. You cannot ' +
                     'modify this line once Closed.', mtError, [], 0)
               else
                  if AvoBaseDialog('Delete Invoice Line #' + IntToStr( line + 1),
                     'Delete highlighted Invoice Line?', mtConfirmation, [mbYes,mbNo], 0) = mbYes then
                        doDelete := true;
            end;
            InvoiceTypeReport : doDelete := true;
         end;
         if (doDelete) then
         begin
            LineItems.Delete( line );
            Break; // otherwise we just don't fucking know where we are anymore
         end;
      end;
   LineItems.Pack();
   RenumberInvoiceLines();
   RecalculateInvoice();
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ EVENTS }

// a line item in the LineItems[] was clicked. we set the color.
procedure tLineItemControlObject.HandleLineItemClicked(Sender: tObject; LineNum: integer);
begin
   fLineNumber := LineNum;
   DoLineColor();
end;

// a line item told us to recalculate.
procedure tLineItemControlObject.HandleRecalculateInvoice;
begin
	// we received an recaculate, so we are going to pass that all the way
   // down to the bottom because it will tell everyone to recalculate
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

// a line item told us it wants to be deleted
procedure tLineItemControlObject.Handle_LineItem_LineDelete( lineNum: integer);
begin
   DeleteLine();
end;

// this shit is redundant and probably needs to be removed
procedure tLineItemControlObject.Handle_LineItem_LineUpdate( sender: tObject; lineNum: integer);
begin
{
  if assigned(fRecalculate) then
    fRecalculate(Self);
}
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// ALL this method does
// Tell the prior object to recalculate
procedure tLineItemControlObject.RecalculateInvoice;
var
   lineCount : integer;
   lineItemRecord : tReturnLineItemRecord;
   taxTotal : double;
begin
   if (fRecalcON) then
   begin
      if ( fInvoiceType = InvoiceTypeOrder ) then
         for lineCount := 0 to LineItems.Count - 1 do
         begin

// NOTE: this is a RETURN. So we NEVER, EVER go to the Tax Routines! We use what is STORED.


            // because every line is individually taxed, we have to pull the tax rate here
{
            taxTotal := 0.00;
            taxRec := Tax_GetTaxRecord(tReturn_LineItem_Form( LineItems[ lineCount ]).Amount_SellAt );
            taxTotal := taxTotal + taxRec.taxRate;
            tReturn_LineItem_Form( LineItems[ lineCount ]).TaxRate := taxTotal;
}
            // now just do calculations
            lineItemRecord := CalculateLineItem(tReturn_LineItem_Form(LineItems[ lineCount ]));
            tReturn_LineItem_Form( LineItems[ lineCount ]).tTotalCostLabel.Caption := FormatFloat('####.00', lineItemRecord.AmountTotal);
            tReturn_LineItem_Form( LineItems[ lineCount ]).tTotalTaxLabel.Caption := FormatFloat('####.00', lineItemRecord.AmountTax);
         end;
   end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tLineItemControlObject.RenumberInvoiceLines;
var
   lineCount : integer;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
      for lineCount := 0 to LineItems.Count - 1 do
         tReturn_LineItem_Form(LineItems[ lineCount ]).LineNumber := lineCount;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tLineItemControlObject.ReturnAllLineItems(inVal: boolean);
var
   lineCount : integer;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
      for lineCount := 0 to LineItems.Count - 1 do
         tReturn_LineItem_Form(LineItems[ lineCount ]).ReturnAllLineItems(inVal);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

(** ********************************************************** **)
(** ********************************************************** **)
(** CALCULATE THE QUANTITIES, TAXES AND RETURN A PROPER RECORD **)
(** ********************************************************** **)
(** ********************************************************** **)

function tLineItemControlObject.LineItemRecordInitialize: tReturnLineItemRecord;
begin
	result.QTYSold := 0;
   result.QTYReturned := 0;
   result.QTYFree := 0;
   result.AmountTax := 0.00;
   result.AmountSubTotal := 0.00;
   result.AmountTotal := 0.00;
end;

{ ORDER ONLY }

function tLineItemControlObject.CalculateLineItem(inLineItem : tReturn_LineItem_Form): tReturnLineItemRecord;
var
   lineCount : integer;
   TaxRate : currency;
   lineItemFree : boolean;
   sellAtCost : currency;
begin
	// initalize
   result := LineItemRecordInitialize;
	//
	result.QTYSold := inLineItem.QTYSold;
   result.QTYReturned := inLineItem.QTYReturned;
   result.QTYFree := inLineItem.QTYFree;
   //
   lineItemFree := inLineItem.LineItemFree;
	sellAtCost := inLineItem.Amount_SellAt;
	taxRate := inLineItem.TaxRate;

	// calculate the sub total
   result.AmountSubTotal := ( result.QTYReturned * sellAtCost);

   // calculate the amount of tax
   result.AmountTax := (result.AmountSubTotal * Tax_PerformTaxCalculation( TaxRate ));
   result.AmountTax := RoundTo( result.AmountTax, -2);

   // FINALLY - calculate the amount total
   result.AmountTotal := result.AmountSubTotal + result.AmountTax;

	// Is the whole line free?
   if (lineItemFree) then
   begin
      result.AmountTax := 0.00;
      result.AmountSubTotal := 0.00;
      result.AmountTotal := 0.00;
   end;
end;

{ REPORT ONLY }

function tLineItemControlObject.CalculateLineItem(inLineItem: tReturn_LineItem_Report): tReturnLineItemRecord;
var
   lineCount : integer;
   TaxRate : currency;
   lineItemFree : boolean;
   sellAtCost : currency;
begin
	// initalize
   result := LineItemRecordInitialize;
	//
	result.QTYSold := inLineItem.QTYSold;
   result.QTYReturned := inLineItem.QTYReturned;
   result.QTYFree := inLineItem.QTYFree;
   //
   lineItemFree := inLineItem.LineItemFree;
	sellAtCost := inLineItem.Amount_SellAt;
	taxRate := inLineItem.TaxRate;

	// calculate the sub total
   result.AmountSubTotal := ( result.QTYReturned * sellAtCost);

   // calculate the amount of tax
   result.AmountTax := (result.AmountSubTotal * Tax_PerformTaxCalculation( TaxRate ));
   result.AmountTax := RoundTo( result.AmountTax, -2);

   // FINALLY - calculate the amount total
   result.AmountTotal := result.AmountSubTotal + result.AmountTax;

	// Is the whole line free?
   if (lineItemFree) then
   begin
      result.AmountTax := 0.00;
      result.AmountSubTotal := 0.00;
      result.AmountTotal := 0.00;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tLineItemControlObject.CheckSave: string;
var
   lineCount : integer;
   errMsg : string;
   qtyRet : integer;
   qtySold : integer;
   qtyFree : integer;
   qtyPrior : integer;
   //
   qtyTotalSold : integer;
   qtyTotalReturned : integer;
begin
   result := '';
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to LineItems.Count - 1 do
      begin
         errMsg := 'Invoice line # ' + IntToStr( lineCount + 1 ) + ' ';
         //
         if (tReturn_LineItem_Form(LineItems[ lineCount ]).ProductNum <> '') AND (tReturn_LineItem_Form(LineItems[ lineCount ]).ProductName = '')
            then result := errMsg + 'has a product number but no product name.';

         //
         qtySold := tReturn_LineItem_Form(LineItems[ lineCount ]).QTYSold;
         qtyFree := tReturn_LineItem_Form(LineItems[ lineCount ]).QTYFree;
         qtyTotalSold := ( qtySold + qtyFree );

         qtyRet := tReturn_LineItem_Form(LineItems[ lineCount ]).QTYReturned;
         qtyPrior := tReturn_LineItem_Form(LineItems[ lineCount ]).QTYPriorReturned;
         qtyTotalReturned :=  ( qtyRet + qtyPrior);



         if ( qtyTotalReturned > qtyTotalSold ) then
            result := errMsg + 'cannot return more than quantity sold + quantity free.';
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tLineItemControlObject.DockSiteScrollBottom;
begin
   fDockSite.Perform(WM_VSCROLL, SB_BOTTOM, 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tLineItemControlObject.DoLineColor;
var
   lineCount : integer;
begin
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to LineItems.Count - 1 do
      begin
         if (lineCount = fLineNumber) then
         begin
            tReturn_LineItem_Form(LineItems[ lineCount ]).LineItemOnePanel.Color := $00CAFFFF;
         end else
            begin
               tReturn_LineItem_Form(LineItems[ lineCount ]).LineItemOnePanel.Color := clWhite;
            end;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This routine deletes any line items that do not have a RQTY >= 1
procedure tLineItemControlObject.RemoveNonReturnedQTYLines;
var
	line : integer;
begin
   if ( LineItems.Count -1 > -1 ) then
   begin
      if (fInvoiceType = InvoiceTypeOrder) then
      begin
         line := LineItems.Count -1;
         repeat
            if ( tReturn_LineItem_Form(LineItems[line]).QTYReturned <= 0 ) then
            begin
               LineItems.Delete( line );
               line := LineItems.Count -1;
            end else
               dec(line);
         until line <= -1;
      end;
      if (fInvoiceType = InvoiceTypeReport) then
      begin
         line := LineItems.Count -1;
         repeat
            if ( tReturn_LineItem_Report(LineItems[line]).QTYReturned <= 0 ) then
            begin
               LineItems.Delete( line );
               line := LineItems.Count -1;
            end else
               dec(line);
         until line <= -1;
      end;
      //
      LineItems.Pack();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.



