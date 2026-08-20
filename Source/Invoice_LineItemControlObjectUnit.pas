 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

// This object encapsulates all Invoice Line Items.

unit Invoice_LineItemControlObjectUnit;

interface uses
   constantsunit,
   masterdataunit,
   toolboxunit,
   inifileunit,
   errorresultunit,
   avobase_percentformunit,
   avobase_dialogformunit,
   RecordStructureUnit,
   //
   Invoice_LineItem_FormUnit,
   Invoice_LineItem_Quick_FormUnit,
   Invoice_LineItem_Simple_FormUnit,
   Invoice_LineItem_NoFormUnit,
   toolbox_TaxToolBoxUnit,
   toolbox_producttoolboxunit,
   Product_InvoiceLineItemProductLookupUnit,
   MasterData_InvoiceLineItemProductLookupUnit,
   Invoice_LineItem_InterfaceUnit,
   //
   Toolbox_PreferenceToolBoxUnit,
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
      fprodListLookupQuery : tMasterDataInvoiceLineItemProductLookup;

      // ----------------------------------------------------------------------------- //
      // events
      fOnNewLine : tNotifyEvent;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;
      fDeleteLine : tDeleteLineEvent;

      // ----------------------------------------------------------------------------- //
      // GET
      function fGetCount : integer;
      function fGetTotalAmount : currency;
      function fGetTotalYcost : currency;
      function fGetTotalTax : currency;
      function fGetSubTotal : currency;
      function fGetAmount_YCost : currency;
      function fGetBackOrderCount : integer;
      function fGetAmount_TotalRetail : currency;
      function fGetAmount_TotalSellAt : currency;

      // ----------------------------------------------------------------------------- //
      // SET

      function CalculateLineItem( inLineItem : tInvoice_LineItem_Full_Form ) : tLineItemRecord; overload;
      function CalculateLineItem(inLineItem : tInvoice_LineItem_Quick_Form): tLineItemRecord; overload;
      function CalculateLineItem( inLineItem : tLineItem_Report ) : tLineItemRecord; overload;

      function LineItemRecordInitialize : tLineItemRecord;

      // ----------------------------------------------------------------------------- //
      // Methods
		procedure HandleRecalculateInvoice;
      procedure HandleLineItemClicked( Sender : tObject; LineNum : integer);
      procedure DockSiteScrollBottom;
      procedure RenumberInvoiceLines;
      procedure fSetOrderType( inVal : tOrderTypes );
      procedure HandleInvoiceLineItemProductLookupEvent( inLineNumber : integer; inProdNum : string );

   public
   	// Add New Line
   	function Add() : integer; overload;
      function AddBlankLineItem() : integer;
      function AddProduct( inID : string ) : integer; overload;
      function AddProduct( inID : string; inLineNum : integer ): integer; overload;

      // Delete
      procedure DeleteLine;

      // Load / Save
      procedure Load( inOrderID : string );
      function CheckSave : string;
      function HasBackOrder : boolean;
      procedure Save();
      procedure DoLineColor();
      procedure MarkLineItemsSold();

      // ----------------------------------------------------------------------------- //
   	// properties
      property Count : integer read fGetCount;
      property Amount_LineItemTotal : currency read fGetTotalAmount;
      property Amount_TotalTax : currency read fGetTotalTax;
      property Amount_LineItemSubTotal : currency read fGetSubTotal;

      property Amount_Total_RCOST : currency read fGetAmount_TotalRetail;
      property Amount_Total_SCOST : currency read fGetAmount_TotalSellAt;
      property Amount_Total_YCOST : currency read fGetAmount_YCost;

      property TaxRate : currency read fTaxRate write fTaxRate;
      property OrgID : string read fOrgID write fOrgID;
      property OrderID : string read fOrderID write fOrderID;
      property CycleID : string read fCycleID write fCycleID;
      property OrderType : tOrderTypes read fOrderType write fSetOrderType;
      property BackOrderCount : integer read fGetBackOrderCount;

      // ----------------------------------------------------------------------------- //
      // Events
      procedure Handle_LineItem_LineDelete(  lineNum : integer );
      procedure Handle_LineItem_LineUpdate(  sender : tObject; lineNum : integer );
      procedure Handle_LineItem_Tab( LineNum : integer );
      property OnRecalculateInvoiceEvent : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;

		procedure RecalculateInvoice;

      // ----------------------------------------------------------------------------- //
   	//
      constructor create( inDockPanel : tScrollBox; inInvoiceType : tInvoiceTypes); virtual;
      constructor destroy; virtual;
   end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Destroy'}

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
   if (fInvoiceType = InvoiceTypeOrder) then
   	fprodListLookupQuery := tMasterDataInvoiceLineItemProductLookup.Create( masterData );
end;

constructor tLineItemControlObject.destroy;
begin
   FreeAndNil( LineItems );
   FreeAndNil( fLineQuery );
   if ( fProdListLookupQuery <> NIL ) then
   	FreeAndNil( fprodListLookupQuery );
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

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

// tab character pressed from inside the invoice_lineitem_form
procedure tLineItemControlObject.Handle_LineItem_Tab(LineNum: integer);
var
   NewLine : integer;
begin
   NewLine := LineNum;
   //
   if ( NewLine < LineItems.Count - 1 ) then
   begin
      Inc( NewLine );
      fLineNumber := NewLine;
      DoLineColor();
      Case( Pref_GetInteger( tPrefConstants.InvoiceLineItemStyle, integer(tInvoiceLineItemStyles.liGeneric) )) of
         integer(tInvoiceLineItemStyles.liGeneric) : tInvoice_LineItem_Full_Form( LineItems[ fLineNumber ]).productNumberEdit.SetFocus();
         integer(tInvoiceLineItemStyles.liQuick) : tInvoice_LineItem_Quick_Form( LineItems[ fLineNumber ]).productNumberEdit.SetFocus();
      end;
   end else
      begin
         fLineNumber := AddBlankLineItem();
         DoLineColor();
         Case( Pref_GetInteger( tPrefConstants.InvoiceLineItemStyle, integer(tInvoiceLineItemStyles.liGeneric) )) of
            integer(tInvoiceLineItemStyles.liGeneric) : tInvoice_LineItem_Full_Form( LineItems[ fLineNumber ]).productNumberEdit.SetFocus();
            integer(tInvoiceLineItemStyles.liQuick) : tInvoice_LineItem_Quick_Form( LineItems[ fLineNumber ]).productNumberEdit.SetFocus();
         end;
      end;
end;

procedure tLineItemControlObject.HandleInvoiceLineItemProductLookupEvent( inLineNumber: integer; inProdNum: string);
var
   prefType : integer;
   prodID : string;
   cycleSearch : string;
begin
   if (fRecalcON) then
   begin
      prefType := Pref_GetInteger(tPrefConstants.CPRODTYPE, integer(cprodNone));
      //
      if ( prefType = integer(cprodCurrent) ) then
         cycleSearch := fCycleID
      else
         cycleSearch := '';
      //
      if ( prefType <> integer(cprodNone) ) then
      begin
         prodID := Product_InvoiceLineItemProductLookup( inProdNum, cycleSearch, fprodListLookupQuery );
         if ( prodID <> '' ) then
         begin
            AddProduct( prodID, inLineNumber );
            RenumberInvoiceLines();
         end;
      end;
   end;
end;

procedure tLineItemControlObject.DockSiteScrollBottom;
begin
   fDockSite.Perform(WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure tLineItemControlObject.DoLineColor;
var
   lineCount : integer;
begin
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to LineItems.Count - 1 do
      begin
         if (lineCount = fLineNumber) then
         begin
            Case( Pref_GetInteger( tPrefConstants.InvoiceLineItemStyle, integer(tInvoiceLineItemStyles.liGeneric) )) of
               integer(tInvoiceLineItemStyles.liGeneric) : tInvoice_LineItem_Full_Form(LineItems[ lineCount ]).LineItemOnePanel.Color := $00CAFFFF;
               integer(tInvoiceLineItemStyles.liQuick) : tInvoice_LineItem_Quick_Form(LineItems[ lineCount ]).LineItemOnePanel.Color := $00CAFFFF;
            end;
         end else
            begin
               Case( Pref_GetInteger( tPrefConstants.InvoiceLineItemStyle, integer(tInvoiceLineItemStyles.liGeneric) )) of
                  integer(tInvoiceLineItemStyles.liGeneric) : tInvoice_LineItem_Full_Form(LineItems[ lineCount ]).LineItemOnePanel.Color := clWhite;
                  integer(tInvoiceLineItemStyles.liQuick) : tInvoice_LineItem_Quick_Form(LineItems[ lineCount ]).LineItemOnePanel.Color := clWhite;
               end;
            end;
      end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties - Sub Totals, Amounts, Taxes, Quantities '}

(*********************************************)
(*********************************************)
(***** GET SUB TOTAL *)
(*********************************************)
(*********************************************)

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
         InvoiceTypeOrder :
         begin
            Case( Pref_GetInteger( tPrefConstants.InvoiceLineItemStyle, integer(tInvoiceLineItemStyles.liGeneric) )) of
               integer(tInvoiceLineItemStyles.liGeneric) : lineItemRecord := CalculateLineItem(tInvoice_LineItem_Full_Form(LineItems[ lineCount ]));
               integer(tInvoiceLineItemStyles.liQuick) : lineItemRecord := CalculateLineItem(tInvoice_LineItem_Quick_Form(LineItems[ lineCount ]));
            end;
         end;
         InvoiceTypeReport :
         begin
            lineItemRecord := CalculateLineItem(tLineItem_Report(LineItems[ lineCount ]));
         end;
      end;
      result := result + lineItemRecord.AmountSubTotal;
   end;
end;

(*********************************************)
(*********************************************)
(***** GET TOTAL AMOUNT *)
(*********************************************)
(*********************************************)

function tLineItemControlObject.fGetTotalAmount: currency;
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
         InvoiceTypeOrder : lineItemRecord := CalculateLineItem(tInvoice_LineItem_Form(LineItems[ lineCount ]));
         InvoiceTypeReport : lineItemRecord := CalculateLineItem(tLineItem_Report(LineItems[ lineCount ]));
      end;
      result := result + lineItemRecord.AmountTotal;
   end;
end;

(*********************************************)
(*********************************************)
(***** GET TOTAL TAX *)
(*********************************************)
(*********************************************)

function tLineItemControlObject.fGetTotalTax: currency;
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
         InvoiceTypeOrder : lineItemRecord := CalculateLineItem(tInvoice_LineItem_Form(LineItems[ lineCount ]));
         InvoiceTypeReport : lineItemRecord := CalculateLineItem(tLineItem_Report(LineItems[ lineCount ]));
      end;
      result := result + lineItemRecord.AmountTax;
   end;
end;

(** ********************************************************** **)
(** ********************************************************** **)
(** CALCULATE THE QUANTITIES, TAXES AND RETURN A PROPER RECORD **)
(** ********************************************************** **)
(** ********************************************************** **)

{ ORDER ONLY }

function tLineItemControlObject.CalculateLineItem(inLineItem : tInvoice_LineItem_Full_Form): tLineItemRecord;
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
   result.AmountSubTotal := ( result.QTYSold * sellAtCost );

   // calculate the amount of tax
   result.AmountTax := (result.AmountSubTotal * Tax_PerformTaxCalculation( TaxRate ));
   //result.AmountTax := RoundTo( result.AmountTax, -2);

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

{ OVERLOADED for tInvoice_LineItem_Quick_Form }
function tLineItemControlObject.CalculateLineItem(inLineItem : tInvoice_LineItem_Quick_Form): tLineItemRecord;
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
   result.AmountSubTotal := ( result.QTYSold * sellAtCost );

   // calculate the amount of tax
   result.AmountTax := (result.AmountSubTotal * Tax_PerformTaxCalculation( TaxRate ));
   //result.AmountTax := RoundTo( result.AmountTax, -2);

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

function tLineItemControlObject.CalculateLineItem(inLineItem: tLineItem_Report): tLineItemRecord;
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
   result.AmountSubTotal := ( result.QTYSold * sellAtCost);

   // calculate the amount of tax
   result.AmountTax := (result.AmountSubTotal * Tax_PerformTaxCalculation( TaxRate ));

//   result.AmountTax := RoundTo( result.AmountTax, -2);

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

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties - Regular'}

procedure tLineItemControlObject.fSetOrderType(inVal: tOrderTypes);
begin
   fOrderType := inVal;
end;

function tLineItemControlObject.fGetTotalYcost: currency;
var
   lineCount : integer;
   totAmount : currency;
begin
   totAmount:= 0;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   case fInvoiceType of
      InvoiceTypeOrder : totAmount := totAmount + tInvoice_LineItem_Form(LineItems[ lineCount ]).Amount_Ycost;
      InvoiceTypeReport : totAmount := totAmount + tLineItem_Report(LineItems[ lineCount ]).Amount_Ycost;
   end;
   //
   Result := totAmount;
end;

function tLineItemControlObject.fGetAmount_TotalRetail: currency;
var
   lineCount : integer;
   totAmount : currency;
begin
   totAmount:= 0;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   case fInvoiceType of
      InvoiceTypeOrder : totAmount := totAmount + tInvoice_LineItem_Form(LineItems[ lineCount ]).Amount_Retail;
      InvoiceTypeReport : totAmount := totAmount + tLineItem_Report(LineItems[ lineCount ]).Amount_Retail;
   end;
   //
   Result := totAmount;
end;

function tLineItemControlObject.fGetAmount_TotalSellAt: currency;
var
   lineCount : integer;
   totAmount : currency;
begin
   totAmount:= 0;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   case fInvoiceType of
      InvoiceTypeOrder : totAmount := totAmount + tInvoice_LineItem_Form(LineItems[ lineCount ]).Amount_SellAt;
      InvoiceTypeReport : totAmount := totAmount + tLineItem_Report(LineItems[ lineCount ]).Amount_SellAt;
   end;
   //
   Result := totAmount;
end;

function tLineItemControlObject.fGetAmount_YCost: currency;
var
   lineCount : integer;
   totAmount : currency;
begin
   totAmount:= 0;
   //
   for lineCount := 0 to LineItems.Count - 1 do
   case fInvoiceType of
      InvoiceTypeOrder : totAmount := totAmount + tInvoice_LineItem_Form(LineItems[ lineCount ]).Amount_Ycost;
      InvoiceTypeReport : totAmount := totAmount + tLineItem_Report(LineItems[ lineCount ]).Amount_Ycost;
   end;
   //
   Result := totAmount;
end;

function tLineItemControlObject.fGetBackOrderCount: integer;
var
   lineCount : integer;
begin
   result := 0;
   for lineCount := 0 to LineItems.Count - 1 do
   begin
      // Gather the data together
      case fInvoiceType of
         InvoiceTypeOrder : if tInvoice_LineItem_Form(LineItems[ lineCount ]).BackOrderType <> 0 then
            inc(result);
         InvoiceTypeReport : if tLineItem_Report(LineItems[ lineCount ]).BackOrderType <> 0 then
            inc(result);
      end;
   end;
end;

function tLineItemControlObject.fGetCount: integer;
begin
	result := LineItems.Count;
end;

function tLineItemControlObject.HasBackOrder: boolean;
var
   lineCount : integer;
begin
   result := false;
   //
   if ( fInvoiceType = InvoiceTypeOrder ) then
      for lineCount := 0 to LineItems.Count - 1 do
         if ( tInvoice_LineItem_Form( LineItems[ lineCount ]).BackOrderType <> 0 ) then
            result := true;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Methods and Functions'}

function tLineItemControlObject.LineItemRecordInitialize: tLineItemRecord;
begin
	result.QTYSold := 0;
   result.QTYReturned := 0;
   result.QTYFree := 0;
   result.AmountTax := 0.00;
   result.AmountSubTotal := 0.00;
   result.AmountTotal := 0.00;
end;

function tLineItemControlObject.Add() : integer;
var
	LineItem_Form : tInvoice_LineItem_Form;
   LineItem_Simple_Form : tInvoice_LineItem_SimpleForm;
   LineItem_Report : tLineItem_Report;

begin
   case fInvoiceType of
      // -------------------------------------------------------------------------
      // For Orders
      InvoiceTypeOrder:
      begin
         // determine the style, there is only one at the momento for release 2.0
         //LineItem_TE := tInvoice_LineItem_SimpleForm.Create( fDockSite );
         LineItem_Form := tInvoice_LineItem_Form.Create( fDockSite );
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
            OnInvoiceLineItemExit := Handle_LineItem_Tab;
            IsNewLine := true;
            OnLineClicked := HandleLineItemClicked;
            OnInvoiceLineItemProductLookupEvent := HandleInvoiceLineItemProductLookupEvent;
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
         LineItem_Report := tLineItem_Report.Create();
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
function tLineItemControlObject.AddBlankLineItem: integer;
begin
   result := Self.Add();
   if (fInvoiceType = InvoiceTypeOrder) then
   begin
      tInvoice_LineItem_Form(LineItems[ result ]).OrgID := fOrgID;
      tInvoice_LineItem_Form(LineItems[ result ]).LineNumber := result;
      tInvoice_LineItem_Form(LineItems[ result ]).CycleID := fCycleID;
      tInvoice_LineItem_Form(LineItems[ result ]).ID := masterData.NewDBGuid;
      tInvoice_LineItem_Form(LineItems[ result ]).OrderID := fOrderID;
      tInvoice_LineItem_Form(LineItems[ result ]).LineItemFree := false;
      tInvoice_LineItem_Form(LineItems[ result ]).OrderType := fOrderType;
      tInvoice_LineItem_Form(LineItems[ result ]).mTaxID := Pref_GetPrefGUID(tPrefConstants.DPRODTAXID);
   end;
   fLineNumber := result;
   DockSiteScrollBottom();
end;

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
         tInvoice_LineItem_Form(LineItems[ result ]).OrgID := prodRec.org_id;
         tInvoice_LineItem_Form(LineItems[ result ]).LineNumber := result;
         tInvoice_LineItem_Form(LineItems[ result ]).CycleID := prodRec.c_id;
         tInvoice_LineItem_Form(LineItems[ result ]).Amount_Retail := prodRec.amount;
         tInvoice_LineItem_Form(LineItems[ result ]).Amount_SellAt := prodRec.sellat;
         tInvoice_LineItem_Form(LineItems[ result ]).Amount_Ycost := prodRec.ycost;
         tInvoice_LineItem_Form(LineItems[ result ]).ID := prodRec.id;
         tInvoice_LineItem_Form(LineItems[ result ]).OrderID := fOrderID;
         tInvoice_LineItem_Form(LineItems[ result ]).QTYSold := 1;
         tInvoice_LineItem_Form(LineItems[ result ]).QTYReturned := 0;
         tInvoice_LineItem_Form(LineItems[ result ]).QTYFree := 0;
         tInvoice_LineItem_Form(LineItems[ result ]).ProductNum := prodRec.num;
         tInvoice_LineItem_Form(LineItems[ result ]).ProductName := prodRec.name;
         tInvoice_LineItem_Form(LineItems[ result ]).ProductDesc := prodRec.descr;
         tInvoice_LineItem_Form(LineItems[ result ]).ProductPRODN1 := prodRec.prodn1;
         tInvoice_LineItem_Form(LineItems[ result ]).ProductPRODN2 := prodRec.prodn2;
         tInvoice_LineItem_Form(LineItems[ result ]).ProductPRODN3 := prodRec.prodn3;
         tInvoice_LineItem_Form(LineItems[ result ]).ProductPRODN4 := prodRec.prodn4;
         tInvoice_LineItem_Form(LineItems[ result ]).mTaxID := prodRec.mTaxID;
         tInvoice_LineItem_Form(LineItems[ result ]).IsNewLine := false;
      end;
      fLineNumber := result;
      DockSiteScrollBottom();
   end;
end;

// Add from the product insta-lookup
function tLineItemControlObject.AddProduct( inID : string; inLineNum : integer ): integer;
var
   prodRec : tprodRec;
begin
   result := -1;
   prodRec := Product_GetProductByProductID( inID );
   if ( inID <> '') then
   begin
      if (fInvoiceType = InvoiceTypeOrder) then
      begin
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).OrgID := prodRec.org_id;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).LineNumber := result;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).CycleID := prodRec.c_id;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).Amount_Retail := prodRec.amount;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).Amount_SellAt := prodRec.sellat;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).Amount_Ycost := prodRec.ycost;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).ID := prodRec.id;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).OrderID := fOrderID;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).QTYSold := 1;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).QTYReturned := 0;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).QTYFree := 0;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).ProductNum := prodRec.num;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).ProductName := prodRec.name;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).ProductDesc := prodRec.descr;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).ProductPRODN1 := prodRec.prodn1;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).ProductPRODN2 := prodRec.prodn2;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).ProductPRODN3 := prodRec.prodn3;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).ProductPRODN4 := prodRec.prodn4;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).mTaxID := prodRec.mTaxID;
         tInvoice_LineItem_Form(LineItems[ inLineNum ]).IsNewLine := false;
      end;
   end;
end;

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
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID) +
      ' ORDER BY SO';
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
               tInvoice_LineItem_Form(LineItems[ lineNum ]).OrgID := fLineQuery.FieldByName('ORG_ID').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).LineNumber := lineNum;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).CycleID := fLineQuery.FieldByName('C_ID').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).Amount_Retail := fLineQuery.FieldByName('RCOST').AsCurrency;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).Amount_SellAt := fLineQuery.FieldByName('SCOST').AsCurrency;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).Amount_Ycost := fLineQuery.FieldByName('YCOST').AsCurrency;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).ID := fLineQuery.FieldByName('ID').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).OrderID := fLineQuery.FieldByName('ORDER_ID').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).BackOrderType := fLineQuery.FieldByName('BOT').AsInteger;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).LineItemFree := fLineQuery.FieldByName('LIFREE').AsBoolean;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).TaxRate := fLineQuery.FieldByName('TAX').AsCurrency;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYSold := fLineQuery.FieldByName('SQTY').AsInteger;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYReturned := fLineQuery.FieldByName('RQTY').AsInteger;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYFree := fLineQuery.FieldByName('FQTY').AsInteger;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductNum := fLineQuery.FieldByName('NUM').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductName := fLineQuery.FieldByName('NAME').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductDesc := fLineQuery.FieldByName('DESCR').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).productprodn1 := fLineQuery.FieldByName('PRODN1').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).productprodn2 := fLineQuery.FieldByName('PRODN2').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).productprodn3 := fLineQuery.FieldByName('PRODN3').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).productprodn4 := fLineQuery.FieldByName('PRODN4').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).mTaxID := fLineQuery.FieldByName('TAXID').AsString;
               tInvoice_LineItem_Form(LineItems[ lineNum ]).IsNewLine := false;
               //
               //tInvoice_LineItem_Form(LineItems[ lineNum ]).Repaint();
            end;
            InvoiceTypeReport :
            begin
               tLineItem_Report(LineItems[ lineNum ]).OrgID := fLineQuery.FieldByName('ORG_ID').AsString;
               tLineItem_Report(LineItems[ lineNum ]).LineNumber := lineNum;
               tLineItem_Report(LineItems[ lineNum ]).CycleID := fLineQuery.FieldByName('C_ID').AsString;
               tLineItem_Report(LineItems[ lineNum ]).Amount_Retail := fLineQuery.FieldByName('RCOST').AsCurrency;
               tLineItem_Report(LineItems[ lineNum ]).Amount_SellAt := fLineQuery.FieldByName('SCOST').AsCurrency;
               tLineItem_Report(LineItems[ lineNum ]).Amount_Ycost := fLineQuery.FieldByName('YCOST').AsCurrency;
               tLineItem_Report(LineItems[ lineNum ]).ID := fLineQuery.FieldByName('ID').AsString;
               tLineItem_Report(LineItems[ lineNum ]).OrderID := fLineQuery.FieldByName('ORDER_ID').AsString;
               tLineItem_Report(LineItems[ lineNum ]).BackOrderType := fLineQuery.FieldByName('BOT').AsInteger;
               tLineItem_Report(LineItems[ lineNum ]).LineItemFree := fLineQuery.FieldByName('LIFREE').AsBoolean;
               tLineItem_Report(LineItems[ lineNum ]).TaxRate := fLineQuery.FieldByName('TAX').AsCurrency;
               tLineItem_Report(LineItems[ lineNum ]).QTYSold := fLineQuery.FieldByName('SQTY').AsInteger;
               tLineItem_Report(LineItems[ lineNum ]).QTYReturned := fLineQuery.FieldByName('RQTY').AsInteger;
               tLineItem_Report(LineItems[ lineNum ]).QTYFree := fLineQuery.FieldByName('FQTY').AsInteger;
               tLineItem_Report(LineItems[ lineNum ]).ProductNum := fLineQuery.FieldByName('NUM').AsString;
               tLineItem_Report(LineItems[ lineNum ]).ProductName := fLineQuery.FieldByName('NAME').AsString;
               tLineItem_Report(LineItems[ lineNum ]).ProductDesc := fLineQuery.FieldByName('DESCR').AsString;
               tLineItem_Report(LineItems[ lineNum ]).productprodn1 := fLineQuery.FieldByName('PRODN1').AsString;
               tLineItem_Report(LineItems[ lineNum ]).productprodn2 := fLineQuery.FieldByName('PRODN2').AsString;
               tLineItem_Report(LineItems[ lineNum ]).productprodn3 := fLineQuery.FieldByName('PRODN3').AsString;
               tLineItem_Report(LineItems[ lineNum ]).productprodn4 := fLineQuery.FieldByName('PRODN4').AsString;
               tLineItem_Report(LineItems[ lineNum ]).mTaxID := fLineQuery.FieldByName('TAXID').AsString;
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
      // add a blank line number
      if (LineItems.Count - 1 = 0) then
      	AddBlankLineItem();
      // set it to the FIRST line number
      fLineNumber := 0;
      // redraw
      DoLineColor();
   end;
   fRecalcON := true;
end;

procedure tLineItemControlObject.MarkLineItemsSold;
var
   lineNum : integer;
begin
   for lineNum := 0 to LineItems.Count - 1 do
      case fInvoiceType of
         InvoiceTypeOrder : tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductSold := true;
      end;
end;

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
      if (Return_MaskEdit_ProductNumber(tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductNum) = '') then
         canSave := false;
      if (tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYSold = 0) AND
         (tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYFree= 0) AND
         (tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYReturned = 0) then
         canSave := false;
      if (tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductName = '') then
         canSave := false;
      //
      if (canSave) then
      begin
         fLineQuery.Append();
         //
         fLineQuery.FieldByName('ID').AsString := masterdata.NewDBGuid;
         fLineQuery.FieldByName('C_ID').AsString :=          tInvoice_LineItem_Form(LineItems[ lineNum ]).CycleID;
         fLineQuery.FieldByName('RCOST').AsCurrency :=     tInvoice_LineItem_Form(LineItems[ lineNum ]).Amount_Retail;
         fLineQuery.FieldByName('SCOST').AsCurrency :=     tInvoice_LineItem_Form(LineItems[ lineNum ]).Amount_SellAt;
         fLineQuery.FieldByName('YCOST').AsCurrency :=     tInvoice_LineItem_Form(LineItems[ lineNum ]).Amount_Ycost;
         fLineQuery.FieldByName('ORDER_ID').AsString :=    tInvoice_LineItem_Form(LineItems[ lineNum ]).OrderID;
         fLineQuery.FieldByName('ORG_ID').AsString :=      tInvoice_LineItem_Form(LineItems[ lineNum ]).OrgID;
         fLineQuery.FieldByName('BOT').AsInteger :=        tInvoice_LineItem_Form(LineItems[ lineNum ]).BackOrderType;
         fLineQuery.FieldByName('LIFREE').AsBoolean :=     tInvoice_LineItem_Form(LineItems[ lineNum ]).LineItemFree;
         fLineQuery.FieldByName('TAX').AsCurrency :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).TaxRate;
         fLineQuery.FieldByName('SQTY').AsInteger :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYSold;
         fLineQuery.FieldByName('RQTY').AsInteger :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYReturned;
         fLineQuery.FieldByName('FQTY').AsInteger :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).QTYFree;
         fLineQuery.FieldByName('NUM').AsString :=         tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductNum;
         fLineQuery.FieldByName('NAME').AsString :=        ProperCase(tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductName, true);
         fLineQuery.FieldByName('DESCR').AsString :=       ProperCase(tInvoice_LineItem_Form(LineItems[ lineNum ]).ProductDesc, true);
         fLineQuery.FieldByName('PRODN1').AsString :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).productprodn1;
         fLineQuery.FieldByName('PRODN2').AsString :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).productprodn2;
         fLineQuery.FieldByName('PRODN3').AsString :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).productprodn3;
         fLineQuery.FieldByName('PRODN4').AsString :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).productprodn4;
         fLineQuery.FieldByName('TAXID').AsString :=       tInvoice_LineItem_Form(LineItems[ lineNum ]).mTaxID;
         fLineQuery.FieldByName('SO').AsInteger := (lineNum + 1); // the sort
         //
         fLineQuery.Post();
      end;
   end;
   fLineQuery.Close();
end;

procedure tLineItemControlObject.DeleteLine;
var
	line : integer;
   doDelete : boolean;
begin
	// deletes a line
   for line := 0 to LineItems.Count - 1 do
      if tInvoice_LineItem_Form(LineItems[line]).LineNumber = fLineNumber then
      begin
         doDelete := false;
         case fInvoiceType of
            InvoiceTypeOrder :
            begin
               // we want to prompt them first...
               if (tInvoice_LineItem_Form(LineItems[ line ]).ProductSold) then
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

// ALL this method does
// Tell the prior object to recalculate
procedure tLineItemControlObject.RecalculateInvoice;
var
   lineCount : integer;
   lineItemRecord : tLineItemRecord;
//   taxRec : tTaxREcord;
   taxRateTotal : double;
begin
   if (fRecalcON) then
   begin
      if ( fInvoiceType = InvoiceTypeOrder ) then
         for lineCount := 0 to LineItems.Count - 1 do
         begin
            // because every line is individually taxed, we have to pull the tax rate here
            taxRateTotal := 0.00;
            {
            taxRec := Tax_GetTaxRecord(tInvoice_LineItem_Form( LineItems[ lineCount ]).Amount_SellAt );
            taxRateTotal := taxRateTotal + taxRec.taxRate;
            }
            taxRateTotal := Tax_TaxRateTotalByMasterTaxClassID(
               tInvoice_LineItem_Form( LineItems[ lineCount ]).Amount_SellAt,
               tInvoice_LineItem_Form( LineItems[ lineCount ]).mTaxID );
            //
            tInvoice_LineItem_Form( LineItems[ lineCount ]).TaxRate := taxRateTotal;


            // now just do calculations
            lineItemRecord := CalculateLineItem(tInvoice_LineItem_Form(LineItems[ lineCount ]));
            tInvoice_LineItem_Form( LineItems[ lineCount ]).tTotalCostLabel.Caption := FormatFloat('####.00', lineItemRecord.AmountTotal);
            tInvoice_LineItem_Form( LineItems[ lineCount ]).tTotalTaxLabel.Caption := FormatFloat('####.00', lineItemRecord.AmountTax);
         end;
   end;
end;

procedure tLineItemControlObject.RenumberInvoiceLines;
var
   lineCount : integer;
begin
   if ( fInvoiceType = InvoiceTypeOrder ) then
      for lineCount := 0 to LineItems.Count - 1 do
         tInvoice_LineItem_Form(LineItems[ lineCount ]).LineNumber := lineCount;
end;

function tLineItemControlObject.CheckSave: string;
var
   lineCount : integer;
   errMsg : string;
   boType : integer;
   lineItem : tInvoice_LineItem_Form;
begin
   result := '';
   if (fInvoiceType = InvoiceTypeOrder) then
      for lineCount := 0 to LineItems.Count - 1 do
      begin
         lineItem := tInvoice_LineItem_Form(LineItems[ lineCount ]);
         errMsg := 'Invoice line # ' + IntToStr( lineCount + 1 ) + ' ';
         //
         if (lineItem.ProductNum <> '') AND (lineItem.ProductName = '') then
            result := errMsg + 'has a product number but no product name.';

         boType := lineItem.BackOrderType;
         if ( boType in [1..2] ) AND (lineItem.LineItemFree) then
            result := errMsg + 'cannot be marked as Back-Ordered or Back-Ordered Not Shipped - AND - "No Charge" at the same time.';
         if ( boType = 3 ) AND (NOT lineItem.LineItemFree) then
            result := errMsg + 'cannot be marked as Back-Ordered No Longer Available - AND - Charged for.';

         if ( lineItem.ProductNum = '') AND ( lineItem.ProductName = '' ) AND ( lineItem.QTYSold = 0 ) then
         begin
            // we do nothing here because if they had nothing on there, we do nothing on there.
         end else
         begin
            if ( lineItem.ProductNum = '' ) then
               result := errMsg + 'cannot have a blank Product Number, Product Name and must have a Quantity Sold or Quantity Free.';
            if ( lineItem.ProductName = '' ) then
               result := errMsg + 'cannot have a blank Product Number, Product Name and must have a Quantity Sold or Quantity Free.';
            if ( lineItem.QTYSold = 0 ) then
               if ( lineItem.QTYFree = 0 ) then
               result := errMsg + 'cannot have a blank Product Number, Product Name and must have a Quantity Sold or Quantity Free.';
         end;
(* old code:

         if (tInvoice_LineItem_Form(LineItems[ lineCount ]).ProductNum <> '') AND (tInvoice_LineItem_Form(LineItems[ lineCount ]).ProductName = '') then
            result := errMsg + 'has a product number but no product name.';
         boType := tInvoice_LineItem_Form(LineItems[ lineCount ]).BackOrderType;
         if ( boType in [1..2] ) AND (tInvoice_LineItem_Form(LineItems[ lineCount ]).LineItemFree) then
            result := errMsg + 'cannot be marked as Back-Ordered or Back-Ordered Not Shipped - AND - "No Charge" at the same time.';
         if ( boType = 3 ) AND (NOT tInvoice_LineItem_Form(LineItems[ lineCount ]).LineItemFree) then
            result := errMsg + 'cannot be marked as Back-Ordered No Longer Available - AND - Charged for.';


*)
      end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.



