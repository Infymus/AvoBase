 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit	Return_LineItem_FormUnit;

interface uses
	Return_LineItem_InterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   avobase_dialogformunit,
   CalculatorFormUnit,
   DiscountFormUnit,
   product_selectformunit,
   toolbox_producttoolboxunit,
   toolbox_preferencetoolboxunit,
   recordstructureunit,
	//
   windows,
   messages,
   sysutils,
   forms,
   contnrs,
   classes,
   Variants,
   Graphics,
   Controls,
   Dialogs,
   StdCtrls,
   Mask,
   ExtCtrls,
   Menus, Buttons;

type
   tReturn_LineItem_Form = class(tForm, iReturnLineItem)
      BACK_PANEL: TPanel;
      InvoceLineBackPanel: TPanel;
      InvoceLineFrontPanel: TPanel;
      LineItemOnePanel: TPanel;
      CalculationGroupBox: TGroupBox;
      RetailCostLabel: TLabel;
      SellAtCostLabel: TLabel;
      TaxLabel: TLabel;
      TOtalCostLabel: TLabel;
      tInvoiceLineRetailCostEdit: TMaskEdit;
      tInvoiceLineItemSellAtCostEdit: TMaskEdit;
      OptionsGroupBox: TGroupBox;
      tInvoiceLineItemFreeItem: TCheckBox;
      tTotalCostLabel: TLabel;
      tTotalTaxLabel: TLabel;
      TaxRateLabel: TLabel;
      tInvoiceLineItemProductNumEdit: TLabeledEdit;
      CycleNumLabel: TLabel;
      CycleNumComboBox: TComboBox;
      campYearLabel: TLabel;
      CycleYearComboBox: TComboBox;
      orgLabel: TLabel;
      orgCombo: TComboBox;
      tInvoiceLineItemSoldQTYEdit: TLabeledEdit;
      tInvoiceLineItemQTYFreeEdit: TLabeledEdit;
      tInvoiceLineItemDescriptionEdit: TLabeledEdit;
      db_prodn1: TLabeledEdit;
      db_prodn2: TLabeledEdit;
      tInvoiceLineItemDesc: TLabeledEdit;
      tInvoiceLineItemBackOrderComboBox: TComboBox;
      LINE_ITEM_SIDE_PANEL: TPanel;
      MenuBackPanel: TPanel;
      OrderProductNumPanel: TPanel;
      saleImage: TImage;
    RenameGroupBox: TGroupBox;
      db_qtyret: TLabeledEdit;
      qtyPriorReturnedEdit: TLabeledEdit;
      db_prodn3: TLabeledEdit;
      db_prodn4: TLabeledEdit;
      procedure tInvoiceLineItemWaveTaClick(Sender: TObject);
      procedure InvoiceLineItemChanged(Sender: TObject);
      procedure tInvoiceLineItemFreeItemClick(Sender: TObject);
      procedure InvoiceLineItemClicked(Sender: TObject);
      procedure orgComboChange(Sender: TObject);
      procedure CycleYearComboBoxChange(Sender: TObject);
      procedure DiscountLineItemPrice1Click(Sender: TObject);
      procedure DeleteThisItem1Click(Sender: TObject);
      procedure AddProductToInvoice1Click(Sender: TObject);
      procedure ReturnBarClick(Sender: TObject);
   private
		// ----------------------------------------------------------------------------- //
      // variables
      fCycleID : string;
      fLineNumber : integer;
      fCostRetail : currency;
      fCostSellAt : currency;
      fID : string;
      fOrderID : string;
      fOrgID : string;
      fBackOrderedType : integer;
      fLineItemCharge : boolean;
      fOrderType : tOrderTypes;
      fTaxRate : currency;
      fQTYSold : integer;
      fQTYReturned : integer;
      fQTYFree : integer;
      fQTYOnHand : integer;
      fQTYPriorReturned : integer;
      fProductNum : string;
      fProductName : string;
      fProductDesc : string;
      fProductSold : boolean;
      fProdN1 : string;
      fProdN2 : string;
      fProdN3 : string;
      fProdN4 : string;
      fReturnProdID : string;
      fmTaxID : string; // master tax ID

      // events
      fInvoiceLineItemClickedEvent : tInvoiceLineItemClickedEvent;
      eLineDelete : tDeleteLineEvent;

      eLineUpdate : tEvent_LineItem_LineUpdate;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;

		// ----------------------------------------------------------------------------- //
		// Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmountRetail( inValue : currency );
      procedure fSetAmountSellAt( inValue : currency );
      procedure fSetID( inValue : string );
      procedure fSetOrderID( inValue : string );
      procedure fSetOrgID( inValue : string );
      procedure fSetBackOrderedType( inValue : integer );
      procedure fSetLineItemCharge( inValue : boolean);
      procedure fSetTaxRate( inValue : currency );
      procedure fsetQTYSold( inValue : integer );
      procedure fSetQTYReturned( inValue : integer );
      procedure fSetQTYFree( inValue : integer );
      procedure fSetProductNum( inValue : string );
      procedure fSetProductName( inValue : string );
      procedure fSetProductDesc( inValue : string );
      procedure fSetQTYOnHand( inValue : integer );
      procedure fSetProductSold( inValue : boolean );
      procedure fSetOrderType( inValue : tOrderTypes );
      procedure fSetReturnProdID( inValue : string );
      procedure fSetQTYPriorReturned( inValue : integer );
      procedure fSetReturnPRODN1( inValue : string );
      procedure fSetReturnPRODN2( inValue : string );
      procedure fSetReturnPRODN3( inValue : string );
      procedure fSetReturnPRODN4( inValue : string );
      procedure fSetmTaxID( inValue : string );

		// ----------------------------------------------------------------------------- //
      // Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmountRetail : currency;
      function fGetAmountSellAt : currency;
      function fGetID : string;
      function fGetOrderID : string;
      function fGetOrgID : string;
      function fGetBackOrderedType : integer;
      function fGetLineItemCharge : boolean;
      function fGetTaxRate : currency;
      function fGetQTYSold : integer;
      function fGetQTYReturned : integer;
      function fGetQTYFree : integer;
      function fGetProductNum : string;
      function fGetProductName : string;
      function fGetProductDesc : string;
      function fGetQTYOnHand : integer;
      function fGetProductSold : boolean;
      function fGetReturnProdID : string;
      function fGetQTYPriorReturned : integer;
      function fGetReturnPRODN1 : string;
      function fGetReturnPRODN2 : string;
      function fGetReturnPRODN3 : string;
      function fGetReturnPRODN4 : string;
      function fGetmTaxID : string;

		// ----------------------------------------------------------------------------- //
      // Private functions
      procedure Fill_Cycle_Years;
      procedure Fill_Cycle_Numbers;
   public
      LineItem_FormHeight_Order : integer;

		// ----------------------------------------------------------------------------- //
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;
      procedure RecalculateInvoice;
      procedure LineItemClicked;
      procedure ReturnAllLineItems( inVal : boolean );

		// ----------------------------------------------------------------------------- //
      // Properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property CycleID : string read fGetCycleID write fSetCycleID;
      property Amount_Retail : currency read fGetAmountRetail write fSetAmountRetail;
      property Amount_SellAt : currency read fGetAmountSellAt write fSetAmountSellAt;
      property ID : string read fGetID write fSetID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property OrgID : string read fGetOrgID write fSetOrgID;
      property BackOrderType : integer read fGetBackOrderedType write fSetBackOrderedType;
      property LineItemFree : boolean read fGetLineItemCharge write fSetLineItemCharge;
      property TaxRate : currency read fGetTaxRate write fSetTaxRate;
      property QTYSold : integer read fGetQTYSold write fSetQTYSold;
      property QTYReturned : integer read fGetQTYReturned write fSetQTYReturned;
      property QTYFree : integer read fGetQTYFree write fSetQTYFree;
      property QTYOnHand : integer read fGetQTYOnHand write fSetQTYOnHand;
      property ProductNum : string read fGetProductNum write fSetProductNum;
      property ProductName : string read fGetProductName write fSetProductName;
      property ProductDesc : string read fGetProductDesc write fSetProductDesc;
      property ProductSold : boolean read fGetProductSold write fSetProductSold;
      property OrderType : tOrderTypes read fOrderType write fSetOrderType;
      property ReturnProdID : string read fGetReturnProdID write fSetReturnProdID;
      property QTYPriorReturned : integer read fGetQTYPriorReturned write fSetQTYPriorReturned;
      property ProductPRODN1 : string read fGetReturnPRODN1 write fSetReturnPRODN1;
      property ProductPRODN2 : string read fGetReturnPRODN2 write fSetReturnPRODN2;
      property ProductPRODN3 : string read fGetReturnPRODN3 write fSetReturnPRODN3;
      property ProductPRODN4 : string read fGetReturnPRODN4 write fSetReturnPRODN4;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;

      // Events
      property OnLineDelete : tDeleteLineEvent read eLineDelete write eLineDelete;
      property OnLineUpdate : tEvent_LineItem_LineUpdate read eLineUpdate write eLineUpdate;
      property OnRecalculateInvoice : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;
      property OnLineClicked : tInvoiceLineItemClickedEvent read fInvoiceLineItemClickedEvent write fInvoiceLineItemClickedEvent;
      //
      constructor create( inOwner : tComponent ); override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tReturn_LineItem_Form.create(inOwner: tComponent);
var
   ProdPref : string;
   OrgID : string;
begin
	inherited create( inOwner );
   //

   // Initialize
   LineItem_FormHeight_Order := 161;

   // fill in back ordered items
   tInvoiceLineItemBackOrderComboBox.Clear();
   with tInvoiceLineItemBackOrderComboBox do
   begin
   	Clear();
   	Items.Add('Not Back Ordered');
      Items.Add('Back Ordered');
      Items.Add('Missed Shipment');
      Items.Add('No Longer Available');
      ItemIndex := 0;
	end;

   Org_ComboBox_FillActiveOrgs_WithCycles( orgCombo );
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );

   //
   saleImage.Visible := false;

   // Set PROD captions
   db_prodn1.Visible := false;
   db_prodn2.Visible := false;
   db_prodn3.Visible := false;
   db_prodn4.Visible := false;


   OrgID := Org_GetOrgIDByOrgName( orgCombo.Text );
   if ( OrgID <> '' ) then
   begin
      ProdPref := Org_GetOrgProductSpecialField( OrgID, 'PRODN1' );
      if ( ProdPref <> '' ) then
      begin
         db_prodn1.editlabel.Caption := ProdPref;
         db_prodn1.visible := true;
      end;
      //
      ProdPref := Org_GetOrgProductSpecialField( OrgID, 'PRODN2' );
      if ( ProdPref <> '' ) then
      begin
         db_prodn2.editlabel.Caption := ProdPref;
         db_prodn2.visible := true;
      end;
      //
      ProdPref := Org_GetOrgProductSpecialField( OrgID, 'PRODN3' );
      if ( ProdPref <> '' ) then
      begin
         db_prodn3.editlabel.Caption := ProdPref;
         db_prodn3.visible := true;
      end;
      //
      ProdPref := Org_GetOrgProductSpecialField( OrgID, 'PRODN4' );
      if ( ProdPref <> '' ) then
      begin
         db_prodn4.editlabel.Caption := ProdPref;
         db_prodn4.visible := true;
      end;
   end;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetAmountRetail: currency;
begin
   fCostRetail := Return_MaskEdit_Curr(tInvoiceLineRetailCostEdit.Text);
   result := fCostRetail;
end;

procedure tReturn_LineItem_Form.fSetAmountRetail(inValue: currency);
begin
   fCostRetail := inValue;
	tInvoiceLineRetailCostEdit.Text := FormatFloat('####0.00', fCostRetail);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetAmountSellAt: currency;
begin
   fCostSellAt := Return_MaskEdit_Curr(tInvoiceLineItemSellAtCostEdit.Text);
   result := fCostSellAt;
end;

procedure tReturn_LineItem_Form.fSetAmountSellAt(inValue: currency);
begin
   fCostSellAt := inValue;
	tInvoiceLineItemSellAtCostEdit.Text := FormatFloat('####0.00', fCostSellAt);
   if ( fCostSellAt < fCostRetail ) then
      saleImage.Visible := true
   else
      saleImage.Visible := false;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetBackOrderedType: integer;
begin
   fBackOrderedType := tInvoiceLineItemBackOrderComboBox.ItemIndex;
   result := fBackOrderedType;
end;

procedure tReturn_LineItem_Form.fSetBackOrderedType(inValue: integer);
begin
   fBackOrderedType := inValue;
   tInvoiceLineItemBackOrderComboBox.ItemIndex := fBackOrderedType;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetCycleID: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( CycleYearComboBox.Text );
   cycleRec.Num := StrToInt( CycleNumComboBox.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( orgCombo.Text, cycleRec.Year, cycleRec.Num );
   //
   fCycleID := C_ID;
   result := fCycleID;
end;

procedure tReturn_LineItem_Form.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
   Fill_Cycle_Years();
   Fill_Cycle_Numbers();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetID: string;
begin
   result := fID;
end;

procedure tReturn_LineItem_Form.fSetID(inValue: string);
begin
   fID := inValue;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetLineItemCharge: boolean;
begin
   fLineItemCharge := tInvoiceLineItemFreeItem.Checked;
   result := fLineItemCharge;
end;

procedure tReturn_LineItem_Form.fSetLineItemCharge(inValue: boolean);
begin
   fLineItemCharge := inValue;
   tInvoiceLineItemFreeItem.Checked := fLineItemCharge;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetOrgID: string;
begin
   result := fOrgID;
end;

procedure tReturn_LineItem_Form.fSetOrgID(inValue: string);
var
   cnt : integer;
   orgName : string;
begin
   fOrgID := inValue;
   //
   Org_ComboBox_FillActiveOrgs_WithCycles( orgCombo );
   orgName := Org_GetOrgNameByOrgID( fOrgID );
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


function tReturn_LineItem_Form.fGetQTYPriorReturned: integer;
begin
   fQTYPriorReturned := Return_MaskEdit_Int(qtyPriorReturnedEdit.Text);
   result := fQTYPriorReturned;
end;

procedure tReturn_LineItem_Form.fSetQTYPriorReturned(inValue: integer);
begin
   fQTYPriorReturned := inValue;
   qtyPriorReturnedEdit.Text := IntToStr( inValue );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


function tReturn_LineItem_Form.fGetProductName: string;
begin
	fProductName := tInvoiceLineItemDescriptionEdit.Text;
   result := fProductName;
end;

procedure tReturn_LineItem_Form.fSetProductName(inValue: string);
begin
   fProductName := inValue;
	tInvoiceLineItemDescriptionEdit.Text := fProductName;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetQTYOnHand: integer;
begin
   result := fQTYOnHand;
end;


procedure tReturn_LineItem_Form.fSetQTYOnHand(inValue: integer);
begin
   fQTYOnHand := inValue;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetTaxRate: currency;
begin
   result := fTaxRate;
end;

procedure tReturn_LineItem_Form.fSetTaxRate(inValue: currency);
begin
   fTaxRate := inValue;
   TaxRateLabel.Caption := CurrToStr( fTaxRate ) + '%';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
	OrderProductNumPanel.Caption := intToStr( fLineNumber + 1 );
end;

function tReturn_LineItem_Form.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.fSetOrderID(inValue: string);
begin
   fOrderID := inValue;
end;

procedure tReturn_LineItem_Form.fSetOrderType(inValue: tOrderTypes);
begin
   fOrderType := inValue;
end;

function tReturn_LineItem_Form.fGetOrderID: string;
begin
   result := fOrderID;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.fSetProductDesc(inValue: string);
begin
   fProductDesc := inValue;
   tInvoiceLineItemDesc.Text := fProductDesc;
end;

function tReturn_LineItem_Form.fGetProductDesc: string;
begin
   fProductDesc := tInvoiceLineItemDesc.Text;
   result := fProductDesc;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.fSetProductNum(inValue: string);
begin
   fProductNum := inValue;
	tInvoiceLineItemProductNumEdit.Text := fProductNum;
end;

function tReturn_LineItem_Form.fGetProductNum: string;
begin
	fProductNum := tInvoiceLineItemProductNumEdit.Text;
   result := fProductNum;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.fSetProductSold(inValue: boolean);
begin
   fProductSold := inValue;
end;

function tReturn_LineItem_Form.fGetProductSold: boolean;
begin
   result := fProductSold;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetQTYReturned: integer;
begin
   fQTYReturned := Return_MaskEdit_Int(db_qtyret.Text);
   result := fQTYReturned;
end;

procedure tReturn_LineItem_Form.fSetQTYReturned(inValue: integer);
begin
   fQTYReturned := inValue;
   db_qtyret.Text := IntToStr( inValue );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.fsetQTYSold(inValue: integer);
begin
   fQTYSold := inValue;
   tInvoiceLineItemSoldQTYEdit.Text := IntToStr( inValue );
end;

function tReturn_LineItem_Form.fGetQTYSold: integer;
begin
   fQTYSold := Return_MaskEdit_Int(tInvoiceLineItemSoldQTYEdit.Text);
   result := fQTYSold;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetReturnProdID: string;
begin
   result := fReturnProdID;
end;

procedure tReturn_LineItem_Form.fSetReturnProdID(inValue: string);
begin
   fReturnProdID := inValue;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetReturnPRODN2: string;
begin
   fprodn2 := db_prodn2.Text;
   result := fProdn2;
end;

procedure tReturn_LineItem_Form.fSetReturnPRODN2(inValue: string);
begin
   fprodn2 := invalue;
   db_prodn2.Text := fprodn2;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetReturnPRODN4: string;
begin
   fprodn4 := db_prodn4.Text;
   result := fProdn4;
end;

procedure tReturn_LineItem_Form.fSetReturnPRODN4(inValue: string);
begin
   fprodn4 := invalue;
   db_prodn4.Text := fprodn4;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetReturnPRODN1: string;
begin
   fprodn1 := db_prodn1.Text;
   result := fProdn1;
end;

procedure tReturn_LineItem_Form.fSetReturnPRODN1(inValue: string);
begin
   fprodn1 := invalue;
   db_prodn1.Text := fprodn1;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.fSetReturnPRODN3(inValue: string);
begin
   fprodn3 := invalue;
   db_prodn3.Text := fprodn3;

end;

function tReturn_LineItem_Form.fGetReturnPRODN3: string;
begin
   fprodn3 := db_prodn3.Text;
   result := fProdn3;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturn_LineItem_Form.fGetQTYFree: integer;
begin
   fQTYFree := Return_MaskEdit_Int(tInvoiceLineItemQTYFreeEdit.Text);
   result := fQTYFree;
end;

procedure tReturn_LineItem_Form.fSetQTYFree(inValue: integer);
begin
   fQTYFree := inValue;
   tInvoiceLineItemQTYFreeEdit.Text := IntToStr( fQTYFree );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.TabBackward;
begin

end;

procedure tReturn_LineItem_Form.TabForward;
begin

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.tInvoiceLineItemFreeItemClick(Sender: TObject);
begin
   RecalculateInvoice();
   LineItemClicked();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.tInvoiceLineItemWaveTaClick(Sender: TObject);
begin
   RecalculateInvoice;
   LineItemClicked();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.InvoiceLineItemChanged(Sender: TObject);
begin
   RecalculateInvoice;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.InvoiceLineItemClicked(Sender: TObject);
begin
   LineItemClicked();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.LineItemClicked;
begin
  if assigned(fInvoiceLineItemClickedEvent) then
    fInvoiceLineItemClickedEvent(Self, fLineNumber);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.orgComboChange(Sender: TObject);
begin
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ RECALCULATE LINE ITEM - This tells the Line_Item_Control to recalculate }
procedure tReturn_LineItem_Form.RecalculateInvoice;
begin
   if ( Amount_SellAt < Amount_Retail ) then
      saleImage.Visible := true
   else
      saleImage.Visible := false;
   //
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

procedure tReturn_LineItem_Form.ReturnAllLineItems(inVal: boolean);
var
   total : integer;
begin
   if ( inVal ) then
   begin
      total := QtySold + QtyFree;
      total := total - qtyPriorReturned;
      //
      QTYReturned := total;
{
QTYPriorReturned
QTYSold
QTYReturned
QTYFree
}

   end else
      begin
         QTYReturned := 0;
      end;
end;

procedure tReturn_LineItem_Form.ReturnBarClick(Sender: TObject);
begin

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.Fill_Cycle_Numbers;
var
   cnt : integer;
   cNum : integer;
   cycleRec : tCycleRec;
begin
   cycleRec := Cycle_GetCycleByCycleID(fCycleID );
   for cnt := 0 to CycleNumComboBox.Items.Count - 1 do
   begin
      cNum := StrToInt( CycleNumComboBox.Items.Strings[ cnt ] );
      if ( cNum = cycleRec.num )  then
         CycleNumComboBox.ItemIndex := cnt;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.Fill_Cycle_Years;
var
   cnt : integer;
   cYear : integer;
   cycleRec : tCycleRec;
begin
   cycleRec := Cycle_GetCycleByCycleID( fCycleID );
   for cnt := 0 to CycleYearComboBox.Items.Count - 1 do
   begin
      cYear := StrToInt( CycleYearComboBox.Items.Strings[ cnt ] );
      if ( cYear = cycleRec.year )  then
         CycleYearComboBox.ItemIndex := cnt;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.CycleYearComboBoxChange(Sender: TObject);
begin
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.DeleteThisItem1Click(Sender: TObject);
begin
   if Assigned( eLineDelete ) then
      eLineDelete( fLineNumber );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.DiscountLineItemPrice1Click( Sender: TObject);
var
  QuickDisc : tDiscountForm;
  _Cost : Currency;
  _Discount : Currency;
  _TotalCost : Currency;
begin
  QuickDisc := tDiscountForm.Create( Application );
  Try
    QuickDisc.ShowModal;
    { Check the Results }
    if QuickDisc._DiscountAmount <> 0 then
      tInvoiceLineItemSellAtCostEdit.Text := FormatFloat('####.00', QuickDisc._DiscountAmount);
    if QuickDisc._DiscountPercent <> 0 then
    begin
      _Cost := Return_MaskEdit_Curr(tInvoiceLineRetailCostEdit.Text);
      _TotalCost := _Cost * QuickDisc._DiscountPercent;
      _Discount := _Cost - _TotalCost;
      tInvoiceLineItemSellAtCostEdit.Text := FormatFloat('####.00', _Discount);
    end;
  Finally
    QuickDisc.Free;
  End;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.AddProductToInvoice1Click( Sender: TObject);
var
   prodSel : tProductSelectForm;
   errChk : boolean;
   prodRec : tprodRec;
begin
   errChk := False;
   //
   if ( ProductNum <> '' ) then
      errChk := true;
   //
   if ( ErrChk ) then
      if AvoBaseDialog('Line Item Has A Product',
        'This line item already has a product number.' + #13 + #13 +
        'Do you wish to over-write this product ' +
        'with a different product from your product list?', mtconfirmation, [mbyes, mbno], 0) = mbyes then
         errChk := false;
   //
   if (NOT ErrChk) then
   begin
      prodSel := tProductSelectForm.Create( Application, 'Select Product To Add', True );
      try
         prodSel.ShowModal();
         if ( prodSel.fFormEvent = mrOK) then
         begin
            prodRec := Product_GetProductByProductID( prodSel.ProdID );
            //
            CycleID := prodRec.c_id;
            Amount_Retail := prodRec.amount;
            Amount_SellAt := prodRec.amount;
            ID := prodRec.id;
            OrderID := fOrderID;
            OrgID := prodRec.org_id;
            QTYSold := 1;
            QTYReturned := 0;
            QTYFree := 0;
            ProductNum := prodRec.num;
            ProductName := prodRec.name;
            ProductDesc := prodRec.descr;
            ProductPRODN1 := prodRec.prodn1;
            ProductPRODN2 := prodRec.prodn2;
            ProductPRODN3 := prodRec.prodn3;
            ProductPRODN4 := prodRec.prodn4;
         end;
      finally
         FreeAndNil( prodSel );
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturn_LineItem_Form.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
end;

function tReturn_LineItem_Form.fGetmTaxID: string;
begin
   result := fmTaxID;
end;

end.

