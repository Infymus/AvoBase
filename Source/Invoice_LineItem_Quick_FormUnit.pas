 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)










 (*
 Aight... This is a LOT of work.

 1. You have to find every single instance of tInvoice_LineItem_Form object and you have to add a preference to select between
    the tInvoice_LineItem_Form and tInvoice_LineItem_Quick_Form.
 2. In order to maintain the inherited lineitem_interface shit, you're going to have to make an additional form that will handle
    all the extra shit that is requried from the interface. A popup form can do this with some quick editing shit.



*)







unit	Invoice_LineItem_Quick_FormUnit;

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
   Invoice_lineItem_QuickPop_FormUnit,
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
   tInvoice_LineItem_Quick_Form = class(tForm, iInvoiceLineItem)
      BACK_PANEL: TPanel;
      InvoceLineBackPanel: TPanel;
      PopMenu: TPopupMenu;
      AddProductToInvoice1: TMenuItem;
      DiscountLineItemPrice1: TMenuItem;
      N1: TMenuItem;
      DeleteThisItem1: TMenuItem;
      N3: TMenuItem;
      Cancel1: TMenuItem;
      LINE_ITEM_SIDE_PANEL: TPanel;
      saleBtn: TSpeedButton;
    OrderProductNumPanel: TPanel;
    LineItemOnePanel: TPanel;
    CalculationGroupBox: TGroupBox;
    RetailCostLabel: TLabel;
    SellAtCostLabel: TLabel;
    TaxLabel: TLabel;
    TOtalCostLabel: TLabel;
    tTotalCostLabel: TLabel;
    tTotalTaxLabel: TLabel;
    TaxRateLabel: TLabel;
    Label2: TLabel;
    retailCostEdit: TMaskEdit;
    sellAtCostEdit: TMaskEdit;
    YcostEdit: TMaskEdit;
    productNumberEdit: TLabeledEdit;
    qtySoldEdit: TLabeledEdit;
    qtyFreeEdit: TLabeledEdit;
    productNameEdit: TLabeledEdit;
    LineItemOptions1: TMenuItem;
    N4: TMenuItem;
    lineItemFreeCheckBox: TCheckBox;
    tProductOnHandImage: TImage;
    saleImage: TImage;
    db_cycle: TLabel;
    db_org: TLabel;
      procedure tInvoiceLineItemWaveTaClick(Sender: TObject);
      procedure InvoiceLineItemChanged(Sender: TObject);
      procedure lineItemFreeCheckBoxClick(Sender: TObject);
      procedure InvoiceLineItemClicked(Sender: TObject);
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
    procedure LineItemOptions1Click(Sender: TObject);
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
      procedure fSetOrgControlID( inID : string );
      procedure RecalculateInvoice;
      procedure LineItemClicked;
      procedure TurnOffBackPanel;
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

constructor tInvoice_LineItem_Quick_Form.create(inOwner: tComponent);
begin
	inherited create( inOwner );
   // Initialize
   LineItem_FormHeight_Order := 63;
   //
   saleImage.Visible := false;
   // just to make sure the event doesn't go away because delphi keeps dropping it!!!!!!!
   sellAtCostEdit.OnKeyPress := sellAtCostEditKeyPress;
   fTabSaveSellAtAmount := '';
   //
   fLineNew := True;
end;

procedure tInvoice_LineItem_Quick_Form.FormShow(Sender: TObject);
begin
   productNumberEdit.SetFocus();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'PROPERTIES: SET '}

procedure tInvoice_LineItem_Quick_Form.fSetAmountRetail(inValue: currency);
begin
   fCostRetail := inValue;
	retailCostEdit.Text := FormatFloat('####0.00', fCostRetail);
end;

procedure tInvoice_LineItem_Quick_Form.fSetAmountSellAt(inValue: currency);
begin
   fCostSellAt := inValue;
	sellAtCostEdit.Text := FormatFloat('####0.00', fCostSellAt);
   if ( fCostSellAt < fCostRetail ) then
      saleImage.Visible := true
   else
      saleImage.Visible := false;
end;

procedure tInvoice_LineItem_Quick_Form.fSetAmountYCost(inValue: currency);
begin
   fCostYCost := inValue;
	YcostEdit.Text := FormatFloat('####0.00', fCostYCost);
end;

procedure tInvoice_LineItem_Quick_Form.fSetBackOrderedType(inValue: integer);
begin
   fBackOrderedType := inValue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetID(inValue: string);
begin
   fID := inValue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetLineItemCharge(inValue: boolean);
begin
   fLineItemCharge := inValue;
   lineItemFreeCheckBox.Checked := fLineItemCharge;
end;

procedure tInvoice_LineItem_Quick_Form.fSetOrgControlID(inID: string);
begin
   // Do nothing? Why Hoenie?
end;

procedure tInvoice_LineItem_Quick_Form.fSetOrgID(inValue: string);
var
   cnt : integer;
   orgName : string;
begin
   fOrgID := inValue;
   //
   orgName := Org_GetOrgNameByOrgID( fOrgID );
end;

procedure tInvoice_LineItem_Quick_Form.fSetProductName(inValue: string);
begin
   fProductName := inValue;
	productNameEdit.Text := fProductName;
end;

procedure tInvoice_LineItem_Quick_Form.fSetQTYOnHand(inValue: integer);
begin
   fQTYOnHand := inValue;
   if (inValue >= 1) then
      tProductOnHandImage.Visible := True
   else
      tProductOnHandImage.Visible := False;
end;

procedure tInvoice_LineItem_Quick_Form.fSetTaxRate(inValue: currency);
begin
   fTaxRate := inValue;
   TaxRateLabel.Caption := CurrToStr( fTaxRate ) + '%';
end;

procedure tInvoice_LineItem_Quick_Form.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
	OrderProductNumPanel.Caption := intToStr( fLineNumber + 1 );
end;

procedure tInvoice_LineItem_Quick_Form.fSetOrderID(inValue: string);
begin
   fOrderID := inValue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetOrderType(inValue: tOrderTypes);
begin
   fOrderType := inValue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetProductDesc(inValue: string);
begin
   fProductDesc := inValue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetProductNum(inValue: string);
begin
   fProductNum := inValue;
	productNumberEdit.Text := fProductNum;
end;

procedure tInvoice_LineItem_Quick_Form.fSetProductPRODN1(inValue: string);
begin
   fprodn1 := invalue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetProductPRODN2(inValue: string);
begin
   fprodn2 := invalue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetProductPRODN3(inValue: string);
begin
   fprodn3 := invalue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetProductPRODN4(inValue: string);
begin
   fprodn4 := invalue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetProductSold(inValue: boolean);
begin
   fProductSold := inValue;
end;

procedure tInvoice_LineItem_Quick_Form.fSetQTYReturned(inValue: integer);
begin
   fQTYReturned := inValue;
end;

procedure tInvoice_LineItem_Quick_Form.fsetQTYSold(inValue: integer);
begin
   fQTYSold := inValue;
   qtySoldEdit.Text := IntToStr( inValue );
end;

procedure tInvoice_LineItem_Quick_Form.fSetQTYFree(inValue: integer);
begin
   fQTYFree := inValue;
   qtyFreeEdit.Text := IntToStr( fQTYFree );
end;

procedure tInvoice_LineItem_Quick_Form.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'GET - Properties'}

function tInvoice_LineItem_Quick_Form.fGetAmountRetail: currency;
begin
   fCostRetail := Return_MaskEdit_Curr(retailCostEdit.Text);
   result := fCostRetail;
end;

function tInvoice_LineItem_Quick_Form.fGetAmountSellAt: currency;
begin
   fCostSellAt := Return_MaskEdit_Curr(sellAtCostEdit.Text);
   result := fCostSellAt;
end;

function tInvoice_LineItem_Quick_Form.fGetAmountYcost: currency;
begin
   fCostYCost := Return_MaskEdit_Curr(YcostEdit.Text);
   result := fCostYCost;
end;

function tInvoice_LineItem_Quick_Form.fGetBackOrderedType: integer;
begin
   result := fBackOrderedType;
end;

function tInvoice_LineItem_Quick_Form.fGetCycleID: string;
begin
   result := fCycleID;
end;

function tInvoice_LineItem_Quick_Form.fGetID: string;
begin
   result := fID;
end;

function tInvoice_LineItem_Quick_Form.fGetLineItemCharge: boolean;
begin
   fLineItemCharge := lineItemFreeCheckBox.Checked;
   result := fLineItemCharge;
end;

function tInvoice_LineItem_Quick_Form.fGetOrgID: string;
begin
   result := fOrgID;
end;

function tInvoice_LineItem_Quick_Form.fGetProductName: string;
begin
	fProductName := productNameEdit.Text;
   result := fProductName;
end;

function tInvoice_LineItem_Quick_Form.fGetQTYOnHand: integer;
begin
   result := fQTYOnHand;
end;

function tInvoice_LineItem_Quick_Form.fGetTaxRate: currency;
begin
   result := fTaxRate;
end;

function tInvoice_LineItem_Quick_Form.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

function tInvoice_LineItem_Quick_Form.fGetOrderID: string;
begin
   result := fOrderID;
end;

function tInvoice_LineItem_Quick_Form.fGetProductDesc: string;
begin
   result := fProductDesc;
end;

function tInvoice_LineItem_Quick_Form.fGetProductNum: string;
begin
	fProductNum := productNumberEdit.Text;
   result := fProductNum;
end;

function tInvoice_LineItem_Quick_Form.fGetProductPRODN1: string;
begin
   result := fProdn1;
end;

function tInvoice_LineItem_Quick_Form.fGetProductPRODN2: string;
begin
   result := fProdn2;
end;

function tInvoice_LineItem_Quick_Form.fGetProductPRODN3: string;
begin
   result := fProdn3;
end;

function tInvoice_LineItem_Quick_Form.fGetProductPRODN4: string;
begin
   result := fProdn4;
end;

function tInvoice_LineItem_Quick_Form.fGetProductSold: boolean;
begin
   result := fProductSold;
end;

function tInvoice_LineItem_Quick_Form.fGetQTYReturned: integer;
begin
   result := fQTYReturned;
end;

function tInvoice_LineItem_Quick_Form.fGetQTYSold: integer;
begin
   fQTYSold := Return_MaskEdit_Int(qtySoldEdit.Text);
   result := fQTYSold;
end;

function tInvoice_LineItem_Quick_Form.fGetQTYFree: integer;
begin
   fQTYFree := Return_MaskEdit_Int(qtyFreeEdit.Text);
   result := fQTYFree;
end;

function tInvoice_LineItem_Quick_Form.fGetmTaxID: string;
begin
   result := fmTaxID;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

procedure tInvoice_LineItem_Quick_Form.backOrderComboChange( Sender: TObject);
begin
//    tBackOrderTypes = ( BONone = 0, BOOrdered = 1, BONotShipped = 2, BONoLongerAvail = 3);
   case BackOrderType of
      integer(BONone): LineItemFree := False;
      integer(BOOrdered): LineItemFree := False;
      integer(BONotShipped): LineItemFree := False;
      integer(BONoLongerAvail): LineItemFree := True;
   end;
end;

procedure tInvoice_LineItem_Quick_Form.productNumberEditChange( Sender: TObject);
begin
   fLineNew := true;
end;

procedure tInvoice_LineItem_Quick_Form.productNumberEditExit( Sender: TObject);
begin
   if ( productNumberEdit.Text <> '' ) AND ( fLineNew) then
   begin
      fLineNew := false;
      if Assigned( fInvoiceLineItemProductLookupEvent ) then
         fInvoiceLineItemProductLookupEvent( fLineNumber, productNumberEdit.Text );
   end;
end;

procedure tInvoice_LineItem_Quick_Form.InvoiceLineItemChanged(Sender: TObject);
begin
   RecalculateInvoice;
end;

procedure tInvoice_LineItem_Quick_Form.db_taxclassChange(Sender: TObject);
begin
   // Do nothing right now.
   RecalculateInvoice;
end;

procedure tInvoice_LineItem_Quick_Form.db_taxclassKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if ( key = VK_TAB ) then
      if Assigned( eInvoiceLineItemExit ) then
         eInvoiceLineItemExit( LineNumber );
end;

procedure tInvoice_LineItem_Quick_Form.sellAtCostEditKeyPress(Sender: TObject;   var Key: Char);
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

procedure tInvoice_LineItem_Quick_Form.lineItemFreeCheckBoxClick(Sender: TObject);
begin
   RecalculateInvoice();
   LineItemClicked();
end;

procedure tInvoice_LineItem_Quick_Form.LineItemOptions1Click(Sender: TObject);
var
   quickPopForm : TLineItem_QuickPop;
begin
   // We do the pop pop pop da pop pop pop da pop opop pop     POP AND LOCK BITCHES POP AND LOCK!!!
   quickPopForm := TLineItem_QuickPop.Create(Application);
   //
   quickPopForm.OrderID := fOrderID;
   quickPopForm.OrgID := fOrgID;
   quickPopForm.CycleID := fCycleID;
   quickPopForm.mTaxID := mTaxID;
   quickPopForm.BackOrderType := fBackOrderedType;
   quickPopForm.ProductPRODN1 := fprodn1;
   quickPopForm.ProductPRODN2 := fProdN2;
   quickPopForm.ProductPRODN3 := fProdN3;
   quickPopForm.ProductPRODN4 := fProdN4;
   //
   quickPopForm.ShowModal();
   //
   //pull the values back out
   fOrderID := quickPopForm.OrderID;
   fOrgID := quickPopForm.OrgID;
   fCycleID := quickPopForm.CycleID;
   mTaxID := quickPopForm.mTaxID;
   fBackOrderedType := quickPopForm.BackOrderType;
   fprodn1 := quickPopForm.ProductPRODN1;
   fProdN2 := quickPopForm.ProductPRODN2;
   fProdN3 := quickPopForm.ProductPRODN3;
   fProdN4 := quickPopForm.ProductPRODN4;
   //
   FreeAndNil(quickPopForm);
end;

procedure tInvoice_LineItem_Quick_Form.tInvoiceLineItemWaveTaClick(Sender: TObject);
begin
   RecalculateInvoice;
   LineItemClicked();
end;

procedure tInvoice_LineItem_Quick_Form.InvoiceLineItemClicked(Sender: TObject);
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

procedure tInvoice_LineItem_Quick_Form.LineItemClicked;
begin
   if assigned(fInvoiceLineItemClickedEvent) then
      fInvoiceLineItemClickedEvent(Self, fLineNumber);
end;

procedure tInvoice_LineItem_Quick_Form.saleBtnClick(Sender: TObject);
var
  CurPos : tPoint;
begin
   LineItemClicked();
   GetCursorPos(CurPos);
   PopMenu.Popup(CurPos.X, CurPos.Y);
end;

procedure tInvoice_LineItem_Quick_Form.DeleteThisItem1Click(Sender: TObject);
begin
   if Assigned( eLineDelete ) then
      eLineDelete( fLineNumber );
end;

procedure tInvoice_LineItem_Quick_Form.DiscountLineItemPrice1Click( Sender: TObject);
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

procedure tInvoice_LineItem_Quick_Form.AddProductToInvoice1Click( Sender: TObject);
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

procedure tInvoice_LineItem_Quick_Form.TurnOffBackPanel;
begin
   self.BACK_PANEL.BorderWidth := 0;
end;

// RECALCULATE LINE ITEM - This tells the Line_Item_Control to recalculate
procedure tInvoice_LineItem_Quick_Form.RecalculateInvoice;
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

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.

