 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


unit	Invoice_LineItem_FormUnit;

interface uses
	Invoice_LineItem_InterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   avobase_dialogformunit,
   CalculatorFormUnit,
   DiscountFormUnit,
   RecordStructureUnit,
   product_selectformunit,
   toolbox_producttoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_taxtoolboxunit,
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
   Menus,
   Buttons;

type
   tInvoice_LineItem_Full_Form = class(tForm, iInvoiceLineItem)
      BACK_PANEL: TPanel;
      InvoceLineBackPanel: TPanel;
      InvoceLineFrontPanel: TPanel;
      LineItemOnePanel: TPanel;
      PopMenu: TPopupMenu;
      AddProductToInvoice1: TMenuItem;
      N2: TMenuItem;
      DiscountLineItemPrice1: TMenuItem;
      N1: TMenuItem;
      DeleteThisItem1: TMenuItem;
      N3: TMenuItem;
      Cancel1: TMenuItem;
      CalculationGroupBox: TGroupBox;
      RetailCostLabel: TLabel;
      SellAtCostLabel: TLabel;
      TaxLabel: TLabel;
      TOtalCostLabel: TLabel;
      tTotalCostLabel: TLabel;
      tTotalTaxLabel: TLabel;
      TaxRateLabel: TLabel;
      productNumberEdit: TLabeledEdit;
      CycleNumLabel: TLabel;
      CycleNumComboBox: TComboBox;
      campYearLabel: TLabel;
      CycleYearComboBox: TComboBox;
      orgLabel: TLabel;
      orgCombo: TComboBox;
      qtySoldEdit: TLabeledEdit;
      qtyFreeEdit: TLabeledEdit;
      productNameEdit: TLabeledEdit;
      descriptionEdit: TLabeledEdit;
      backOrderCombo: TComboBox;
      LINE_ITEM_SIDE_PANEL: TPanel;
      saleBtn: TSpeedButton;
      saleImage: TImage;
      db_prodn1: TLabeledEdit;
      db_prodn2: TLabeledEdit;
      db_prodn3: TLabeledEdit;
      db_prodn4: TLabeledEdit;
      db_taxclass: TComboBox;
      db_taxclasslabel: TLabel;
      Label1: TLabel;
      lineItemFreeCheckBox: TCheckBox;
      tProductOnHandImage: TImage;
    OrderProductNumPanel: TPanel;
    retailCostEdit: TMaskEdit;
    sellAtCostEdit: TMaskEdit;
    Label2: TLabel;
    YcostEdit: TMaskEdit;
      procedure tInvoiceLineItemWaveTaClick(Sender: TObject);
      procedure InvoiceLineItemChanged(Sender: TObject);
      procedure lineItemFreeCheckBoxClick(Sender: TObject);
      procedure InvoiceLineItemClicked(Sender: TObject);
      procedure orgComboChange(Sender: TObject);
      procedure CycleYearComboBoxChange(Sender: TObject);
      procedure DiscountLineItemPrice1Click(Sender: TObject);
      procedure saleBtnClick(Sender: TObject);
      procedure DeleteThisItem1Click(Sender: TObject);
      procedure AddProductToInvoice1Click(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure backOrderComboChange(Sender: TObject);
      procedure productNumberEditExit(Sender: TObject);
      procedure productNumberEditChange(Sender: TObject);
      procedure db_taxclassChange(Sender: TObject);
      procedure db_taxclassKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure sellAtCostEditKeyPress(Sender: TObject; var Key: Char);
   private
		// ----------------------------------------------------------------------------- //
      // variables
      fCycleID : string;
      fLineNumber : integer;
      fCostRetail : currency;
      fCostSellAt : currency;
      fCostYCost : currency;
      fID : string;
      fOrderID : string;
      fOrgID : string;
      fTabSaveSellAtAmount : string;
      fBackOrderedType : integer;
      fLineItemCharge : boolean;
      fOrderType : tOrderTypes;
      fTaxRate : currency;
      fQTYSold : integer;
      fQTYReturned : integer;
      fQTYFree : integer;
      fQTYOnHand : integer;
      fProductNum : string;
      fProductName : string;
      fProductDesc : string;
      fProductSold : boolean;
      fprodn1 : string;
      fprodn2 : string;
      fprodn3 : string;
      fprodn4 : string;
      fLineNew : boolean;
      fmTaxID : string; // master tax ID

      // events
      fInvoiceLineItemClickedEvent : tInvoiceLineItemClickedEvent;
      eLineDelete : tDeleteLineEvent;
      eLineUpdate : tEvent_LineItem_LineUpdate;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;
      fInvoiceLineItemProductLookupEvent : tInvoiceLineItemProductLookupEvent;
      eInvoiceLineItemExit : tInvoiceLineItemExit;

		// ----------------------------------------------------------------------------- //
		// Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmountRetail( inValue : currency );
      procedure fSetAmountSellAt( inValue : currency );
      procedure fSetAmountYCost( inValue : currency );
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
      procedure fSetProductPRODN1( inValue : string );
      procedure fSetProductPRODN2( inValue : string );
      procedure fSetProductPRODN3( inValue : string );
      procedure fSetProductPRODN4( inValue : string );
      procedure fSetmTaxID( inValue : string );

		// ----------------------------------------------------------------------------- //
      // Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmountRetail : currency;
      function fGetAmountSellAt : currency;
      function fGetAmountYcost : currency;
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
      function fGetProductPRODN1 : string;
      function fGetProductPRODN2 : string;
      function fGetProductPRODN3 : string;
      function fGetProductPRODN4 : string;
      function fGetmTaxID : string;

		// ----------------------------------------------------------------------------- //
      // Private functions
      procedure Fill_Cycle_Years;
      procedure Fill_Cycle_Numbers;
      procedure fSetOrgControlID( inID : string );
      procedure RecalculateInvoice;
      procedure LineItemClicked;
      procedure TurnOffBackPanel;
      procedure SetOrgProductLabels();
   public
      LineItem_FormHeight_Order : integer;

		// ----------------------------------------------------------------------------- //
		// Standard Procedures

      // ----------------------------------------------------------------------------- //
      // Properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property CycleID : string read fGetCycleID write fSetCycleID;
      property Amount_Retail : currency read fGetAmountRetail write fSetAmountRetail;
      property Amount_SellAt : currency read fGetAmountSellAt write fSetAmountSellAt;
      property Amount_Ycost : currency read fGetAmountYcost write fSetAmountYCost;
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
      property ProductPRODN1 : string read fGetProductPRODN1 write fSetProductPRODN1;
      property ProductPRODN2 : string read fGetProductPRODN2 write fSetProductPRODN2;
      property ProductPRODN3 : string read fGetProductPRODN3 write fSetProductPRODN3;
      property ProductPRODN4 : string read fGetProductPRODN4 write fSetProductPRODN4;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;

      // Events
      property OnLineDelete : tDeleteLineEvent read eLineDelete write eLineDelete;
      property OnLineUpdate : tEvent_LineItem_LineUpdate read eLineUpdate write eLineUpdate;
      property OnRecalculateInvoice : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;
      property OnLineClicked : tInvoiceLineItemClickedEvent read fInvoiceLineItemClickedEvent write fInvoiceLineItemClickedEvent;
      property OnInvoiceLineItemProductLookupEvent : tInvoiceLineItemProductLookupEvent read fInvoiceLineItemProductLookupEvent write fInvoiceLineItemProductLookupEvent;
      property IsNewLine : boolean read fLineNew write fLineNew;
      property OnInvoiceLineItemExit : tInvoiceLineItemExit read eInvoiceLineItemExit write eInvoiceLineItemExit;
      //
      constructor create( inOwner : tComponent ); override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Destroy, Startup, Shutdown'}

constructor tInvoice_LineItem_Full_Form.create(inOwner: tComponent);
begin
	inherited create( inOwner );
   //

   // Initialize
   LineItem_FormHeight_Order := 196;

   // fill in back ordered items
   backOrderCombo.Clear();
   with backOrderCombo do
   begin
   	Clear();
   	Items.Add('Not Back Ordered');
      Items.Add('Back Ordered');
      Items.Add('Missed Shipment');
      Items.Add('No Longer Available');
      ItemIndex := 0;
	end;

   //
   saleImage.Visible := false;

   // Set PROD captions
   db_prodn1.Visible := false;
   db_prodn2.Visible := false;
   db_prodn3.Visible := false;
   db_prodn4.Visible := false;

   SetOrgProductLabels();

   // just to make sure the event doesn't go away because delphi keeps dropping it!!!!!!!
   sellAtCostEdit.OnKeyPress := sellAtCostEditKeyPress;
   fTabSaveSellAtAmount := '';

   //
   fLineNew := True;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, '');

end;

procedure tInvoice_LineItem_Full_Form.FormShow(Sender: TObject);
begin
   productNumberEdit.SetFocus();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'PROPERTIES: SET '}

procedure tInvoice_LineItem_Full_Form.fSetAmountRetail(inValue: currency);
begin
   fCostRetail := inValue;
	retailCostEdit.Text := FormatFloat('####0.00', fCostRetail);
end;

procedure tInvoice_LineItem_Full_Form.fSetAmountSellAt(inValue: currency);
begin
   fCostSellAt := inValue;
	sellAtCostEdit.Text := FormatFloat('####0.00', fCostSellAt);
   if ( fCostSellAt < fCostRetail ) then
      saleImage.Visible := true
   else
      saleImage.Visible := false;
end;

procedure tInvoice_LineItem_Full_Form.fSetAmountYCost(inValue: currency);
begin
   fCostYCost := inValue;
	YcostEdit.Text := FormatFloat('####0.00', fCostYCost);
end;

procedure tInvoice_LineItem_Full_Form.fSetBackOrderedType(inValue: integer);
begin
   fBackOrderedType := inValue;
   backOrderCombo.ItemIndex := fBackOrderedType;
end;

procedure tInvoice_LineItem_Full_Form.fSetCycleID(inValue: string);
var
   cycleRec : tCycleRec;
   cnt : integer;
begin
   fCycleID := inValue;
   Fill_Cycle_Years();
   Fill_Cycle_Numbers();
   if ( fCycleID <> '' ) then
   begin
      cycleRec := Cycle_GetCycleByCycleID( fCycleID );
      // Years MUST be first
      Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
      // Numbers MUST be after YEARS
      Cycle_ComboBox_FillCycleNumbersLineItem( Org_GetOrgIDByOrgName(orgCombo.Text), cycleRec.year, CycleNumComboBox );
      // Now set the YEAR correctly
      for cnt := 0 to CycleYearComboBox.Items.Count do
         if ( CycleYearComboBox.Items.Strings[ cnt ] = IntToStr( cycleRec.year ) ) then
            CycleYearComboBox.ItemIndex := cnt;
      // Now set the NUM correctly
      for cnt := 0 to CycleNumComboBox.Items.Count do
         if ( CycleNumComboBox.Items.Strings[ cnt ] = IntToStr( cycleRec.num ) ) then
            CycleNumComboBox.ItemIndex := cnt;
   end;
end;

procedure tInvoice_LineItem_Full_Form.fSetID(inValue: string);
begin
   fID := inValue;
end;

procedure tInvoice_LineItem_Full_Form.fSetLineItemCharge(inValue: boolean);
begin
   fLineItemCharge := inValue;
   lineItemFreeCheckBox.Checked := fLineItemCharge;
end;

procedure tInvoice_LineItem_Full_Form.fSetOrgControlID(inID: string);
begin
   // Do nothing? Why Hoenie?
end;

procedure tInvoice_LineItem_Full_Form.fSetOrgID(inValue: string);
var
   cnt : integer;
   orgName : string;
begin
   fOrgID := inValue;
   //
   Org_ComboBox_FillActiveOrgs_WithCycles( fOrgID, orgCombo );
   //
   orgName := Org_GetOrgNameByOrgID( fOrgID );
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;
   SetOrgProductLabels()
end;

procedure tInvoice_LineItem_Full_Form.fSetProductName(inValue: string);
begin
   fProductName := inValue;
	productNameEdit.Text := fProductName;
end;

procedure tInvoice_LineItem_Full_Form.fSetQTYOnHand(inValue: integer);
begin
   fQTYOnHand := inValue;
   if (inValue >= 1) then
      tProductOnHandImage.Visible := True
   else
      tProductOnHandImage.Visible := False;
end;

procedure tInvoice_LineItem_Full_Form.fSetTaxRate(inValue: currency);
begin
   fTaxRate := inValue;
   TaxRateLabel.Caption := CurrToStr( fTaxRate ) + '%';
end;

procedure tInvoice_LineItem_Full_Form.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
	OrderProductNumPanel.Caption := intToStr( fLineNumber + 1 );
end;

procedure tInvoice_LineItem_Full_Form.fSetOrderID(inValue: string);
begin
   fOrderID := inValue;
end;

procedure tInvoice_LineItem_Full_Form.fSetOrderType(inValue: tOrderTypes);
begin
   fOrderType := inValue;
end;

procedure tInvoice_LineItem_Full_Form.fSetProductDesc(inValue: string);
begin
   fProductDesc := inValue;
   descriptionEdit.Text := fProductDesc;
end;

procedure tInvoice_LineItem_Full_Form.fSetProductNum(inValue: string);
begin
   fProductNum := inValue;
	productNumberEdit.Text := fProductNum;
end;

procedure tInvoice_LineItem_Full_Form.fSetProductPRODN1(inValue: string);
begin
   fprodn1 := invalue;
   db_prodn1.Text := fprodn1;
end;

procedure tInvoice_LineItem_Full_Form.fSetProductPRODN2(inValue: string);
begin
   fprodn2 := invalue;
   db_prodn2.Text := fprodn2;
end;

procedure tInvoice_LineItem_Full_Form.fSetProductPRODN3(inValue: string);
begin
   fprodn3 := invalue;
   db_prodn3.Text := fprodn3;
end;

procedure tInvoice_LineItem_Full_Form.fSetProductPRODN4(inValue: string);
begin
   fprodn4 := invalue;
   db_prodn4.Text := fprodn4;
end;

procedure tInvoice_LineItem_Full_Form.fSetProductSold(inValue: boolean);
begin
   fProductSold := inValue;
end;

procedure tInvoice_LineItem_Full_Form.fSetQTYReturned(inValue: integer);
begin
   fQTYReturned := inValue;
end;

procedure tInvoice_LineItem_Full_Form.fsetQTYSold(inValue: integer);
begin
   fQTYSold := inValue;
   qtySoldEdit.Text := IntToStr( inValue );
end;

procedure tInvoice_LineItem_Full_Form.fSetQTYFree(inValue: integer);
begin
   fQTYFree := inValue;
   qtyFreeEdit.Text := IntToStr( fQTYFree );
end;

procedure tInvoice_LineItem_Full_Form.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, fmTaxID );
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'GET - Properties'}

function tInvoice_LineItem_Full_Form.fGetAmountRetail: currency;
begin
   fCostRetail := Return_MaskEdit_Curr(retailCostEdit.Text);
   result := fCostRetail;
end;

function tInvoice_LineItem_Full_Form.fGetAmountSellAt: currency;
begin
   fCostSellAt := Return_MaskEdit_Curr(sellAtCostEdit.Text);
   result := fCostSellAt;
end;

function tInvoice_LineItem_Full_Form.fGetAmountYcost: currency;
begin
   fCostYCost := Return_MaskEdit_Curr(YcostEdit.Text);
   result := fCostYCost;
end;

function tInvoice_LineItem_Full_Form.fGetBackOrderedType: integer;
begin
   fBackOrderedType := backOrderCombo.ItemIndex;
   result := fBackOrderedType;
end;

function tInvoice_LineItem_Full_Form.fGetCycleID: string;
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

function tInvoice_LineItem_Full_Form.fGetID: string;
begin
   result := fID;
end;

function tInvoice_LineItem_Full_Form.fGetLineItemCharge: boolean;
begin
   fLineItemCharge := lineItemFreeCheckBox.Checked;
   result := fLineItemCharge;
end;

function tInvoice_LineItem_Full_Form.fGetOrgID: string;
begin
   result := Org_GetOrgIDByOrgName( orgCombo.Text );
end;

function tInvoice_LineItem_Full_Form.fGetProductName: string;
begin
	fProductName := productNameEdit.Text;
   result := fProductName;
end;

function tInvoice_LineItem_Full_Form.fGetQTYOnHand: integer;
begin
   result := fQTYOnHand;
end;

function tInvoice_LineItem_Full_Form.fGetTaxRate: currency;
begin
   result := fTaxRate;
end;

function tInvoice_LineItem_Full_Form.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

function tInvoice_LineItem_Full_Form.fGetOrderID: string;
begin
   result := fOrderID;
end;

function tInvoice_LineItem_Full_Form.fGetProductDesc: string;
begin
   fProductDesc := descriptionEdit.Text;
   result := fProductDesc;
end;

function tInvoice_LineItem_Full_Form.fGetProductNum: string;
begin
	fProductNum := productNumberEdit.Text;
   result := fProductNum;
end;

function tInvoice_LineItem_Full_Form.fGetProductPRODN1: string;
begin
   fprodn1 := db_prodn1.Text;
   result := fProdn1;
end;

function tInvoice_LineItem_Full_Form.fGetProductPRODN2: string;
begin
   fprodn2 := db_prodn2.Text;
   result := fProdn2;
end;

function tInvoice_LineItem_Full_Form.fGetProductPRODN3: string;
begin
   fprodn3 := db_prodn3.Text;
   result := fProdn3;
end;

function tInvoice_LineItem_Full_Form.fGetProductPRODN4: string;
begin
   fprodn4 := db_prodn4.Text;
   result := fProdn4;
end;

function tInvoice_LineItem_Full_Form.fGetProductSold: boolean;
begin
   result := fProductSold;
end;

function tInvoice_LineItem_Full_Form.fGetQTYReturned: integer;
begin
   result := fQTYReturned;
end;

function tInvoice_LineItem_Full_Form.fGetQTYSold: integer;
begin
   fQTYSold := Return_MaskEdit_Int(qtySoldEdit.Text);
   result := fQTYSold;
end;

function tInvoice_LineItem_Full_Form.fGetQTYFree: integer;
begin
   fQTYFree := Return_MaskEdit_Int(qtyFreeEdit.Text);
   result := fQTYFree;
end;

function tInvoice_LineItem_Full_Form.fGetmTaxID: string;
begin
   fmTaxID := Tax_GetMasterTaxIDByName( db_taxclass.Text );
   //
   result := fmTaxID;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

procedure tInvoice_LineItem_Full_Form.backOrderComboChange( Sender: TObject);
begin
//    tBackOrderTypes = ( BONone = 0, BOOrdered = 1, BONotShipped = 2, BONoLongerAvail = 3);
   case BackOrderType of
      integer(BONone): LineItemFree := False;
      integer(BOOrdered): LineItemFree := False;
      integer(BONotShipped): LineItemFree := False;
      integer(BONoLongerAvail): LineItemFree := True;
   end;
end;

procedure tInvoice_LineItem_Full_Form.productNumberEditChange( Sender: TObject);
begin
   fLineNew := true;
end;

procedure tInvoice_LineItem_Full_Form.productNumberEditExit( Sender: TObject);
begin
   if ( productNumberEdit.Text <> '' ) AND ( fLineNew) then
   begin
      fLineNew := false;
      if Assigned( fInvoiceLineItemProductLookupEvent ) then
         fInvoiceLineItemProductLookupEvent( fLineNumber, productNumberEdit.Text );
   end;
end;

procedure tInvoice_LineItem_Full_Form.InvoiceLineItemChanged(Sender: TObject);
begin
   RecalculateInvoice;
end;

procedure tInvoice_LineItem_Full_Form.orgComboChange(Sender: TObject);
begin
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

procedure tInvoice_LineItem_Full_Form.CycleYearComboBoxChange(Sender: TObject);
begin
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

procedure tInvoice_LineItem_Full_Form.db_taxclassChange(Sender: TObject);
begin
   // Do nothing right now.
   RecalculateInvoice;
end;

procedure tInvoice_LineItem_Full_Form.db_taxclassKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if ( key = VK_TAB ) then
      if Assigned( eInvoiceLineItemExit ) then
         eInvoiceLineItemExit( LineNumber );
end;

procedure tInvoice_LineItem_Full_Form.sellAtCostEditKeyPress(Sender: TObject;   var Key: Char);
begin
   if ( key = #9 ) then
   begin
      { this fTabSaveSellAtAmount is a goddamn HACK. we have to save the amount into a temp
         string field, and then later in the recaculation, put it back. otherwise, delphi on the tab
         event handled somehow internally will WIPE the field out and that sucks ass }
      fTabSaveSellAtAmount := sellAtCostEdit.text;
      if Assigned( eInvoiceLineItemExit ) then
         eInvoiceLineItemExit( LineNumber );
   end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Click Events'}

procedure tInvoice_LineItem_Full_Form.lineItemFreeCheckBoxClick(Sender: TObject);
begin
   RecalculateInvoice();
   LineItemClicked();
end;

procedure tInvoice_LineItem_Full_Form.tInvoiceLineItemWaveTaClick(Sender: TObject);
begin
   RecalculateInvoice;
   LineItemClicked();
end;

procedure tInvoice_LineItem_Full_Form.InvoiceLineItemClicked(Sender: TObject);
begin
   if ( Sender is TMaskEdit ) then
   begin
      if ( tMaskEdit(Sender).Name = 'retailCostEdit' ) then
         tMaskEdit(Sender).SelectAll;
      if ( tMaskEdit(Sender).Name = 'sellAtCostEdit' ) then
         tMaskEdit(Sender).SelectAll;
   end;
   LineItemClicked();
end;

procedure tInvoice_LineItem_Full_Form.LineItemClicked;
begin
   if assigned(fInvoiceLineItemClickedEvent) then
      fInvoiceLineItemClickedEvent(Self, fLineNumber);
end;

procedure tInvoice_LineItem_Full_Form.saleBtnClick(Sender: TObject);
var
  CurPos : tPoint;
begin
   LineItemClicked();
   GetCursorPos(CurPos);
   PopMenu.Popup(CurPos.X, CurPos.Y);
end;

procedure tInvoice_LineItem_Full_Form.DeleteThisItem1Click(Sender: TObject);
begin
   if Assigned( eLineDelete ) then
      eLineDelete( fLineNumber );
end;

procedure tInvoice_LineItem_Full_Form.DiscountLineItemPrice1Click( Sender: TObject);
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
      sellAtCostEdit.Text := FormatFloat('####.00', QuickDisc._DiscountAmount);
    if QuickDisc._DiscountPercent <> 0 then
    begin
      _Cost := Return_MaskEdit_Curr(retailCostEdit.Text);
      _TotalCost := _Cost * QuickDisc._DiscountPercent;
      _Discount := _Cost - _TotalCost;
      sellAtCostEdit.Text := FormatFloat('####.00', _Discount);
    end;
  Finally
    QuickDisc.Free;
  End;
end;

procedure tInvoice_LineItem_Full_Form.AddProductToInvoice1Click( Sender: TObject);
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
            OrgID := prodRec.org_id;
            CycleID := prodRec.c_id;
            Amount_Retail := prodRec.amount;
            Amount_SellAt := prodRec.amount;
            ID := prodRec.id;
            OrderID := fOrderID;
            QTYSold := 1;
            QTYReturned := 0;
            QTYFree := 0;
            ProductNum := prodRec.num;
            ProductName := prodRec.name;
            ProductDesc := prodRec.descr;
            productprodn1 := prodRec.prodn1;
            productprodn2 := prodRec.prodn2;
            productprodn3 := prodRec.prodn3;
            productprodn4 := prodRec.prodn4;
            fLineNew := false;
         end;
      finally
         FreeAndNil( prodSel );
      end;
   end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Methods and Functions'}

procedure tInvoice_LineItem_Full_Form.TurnOffBackPanel;
begin
   self.BACK_PANEL.BorderWidth := 0;
end;

// RECALCULATE LINE ITEM - This tells the Line_Item_Control to recalculate
procedure tInvoice_LineItem_Full_Form.RecalculateInvoice;
begin
   { this fTabSaveSellAtAmount is a goddamn HACK. we have to save the amount into a temp
     string field, and then later in the recaculation, put it back. otherwise, delphi on the tab
     event handled somehow internally will WIPE the field out and that sucks ass }
   if ( fTabSaveSellAtAmount <> '') then
      SellAtCostEdit.Text := fTabSaveSellAtAmount;
   fTabSaveSellAtAmount := '';
   if ( Amount_SellAt < Amount_Retail ) then
      saleImage.Visible := true
   else
      saleImage.Visible := false;
   //
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

procedure tInvoice_LineItem_Full_Form.Fill_Cycle_Numbers;
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

procedure tInvoice_LineItem_Full_Form.Fill_Cycle_Years;
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

procedure tInvoice_LineItem_Full_Form.SetOrgProductLabels;
begin
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN1') <> '' ) then
   begin
      db_prodn1.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN1');
      db_prodn1.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN2') <> '' ) then
   begin
      db_prodn2.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN2');
      db_prodn2.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN3') <> '' ) then
   begin
      db_prodn3.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN3');
      db_prodn3.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN4') <> '' ) then
   begin
      db_prodn4.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN4');
      db_prodn4.visible := true;
   end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.

