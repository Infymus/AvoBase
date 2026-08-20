 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_FEEItem_FormUnit;

interface uses
   Return_FEEItem_InterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   IMG_StorageFormUnit,
   toolbox_orgtoolboxunit,
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
   ExtCtrls, Menus, Buttons;

type
  TReturn_FEEItem_Form = class(TForm, iReturnFeeItem)
    PopMenu: TPopupMenu;
    None1: TMenuItem;
    InvoceLineFrontPanel: TPanel;
    Fee_Opt_Panel: TPanel;
    MenuBackPanel: TPanel;
    OrderProductNumPanel: TPanel;
    FEE_BACK_PANEL: TPanel;
    LineItemOnePanel: TPanel;
    FeeNameLabel: TLabel;
    OrgLabel: TLabel;
    tFeeLineFeeName: TEdit;
    CalculationGroupBox: TGroupBox;
    FeeCostLabel: TLabel;
    TaxLabel: TLabel;
    TOtalCostLabel: TLabel;
    tTotalCostLabel: TLabel;
    tTotalTaxLabel: TLabel;
    TaxRateLabel: TLabel;
    tFeeLineFeeAmount: TMaskEdit;
    ReturnFeePanel: TPanel;
    db_feerefund: TCheckBox;
    nonAddFeeLabel: TLabel;
    db_taxclasslabel: TLabel;
    db_taxclass: TComboBox;
    procedure FeeLineItemClicked(Sender: TObject);
    procedure tFeeLineFeeAmountChange(Sender: TObject);
    procedure tInvoiceLineItemWaveTaxClick(Sender: TObject);
   private
      // variables
      fID : string;
      fCycleID : string; // the sales cycle
      fLineNumber : integer; // the line number of the MOP
      fAmount : currency;
      fOrgID : string;
      fOrderType : tOrderTypes;
      fOrderID : string;
      fFeeName : string;
      fDesc : string;
      fTaxRate : double;
      fReturnFlag : boolean;
      fReturnAdd : Boolean;
      // events
      fInvoiceFeeItemClickedEvent : tInvoiceFeeItemClickedEvent;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;
      eLineDelete : tEvent_FEEItem_LineDelete;
      eLineUpdate : tEvent_FEEItem_LineUpdate;
      fReturnProdID : string;
      fmTaxID : string; // master tax ID

   	// Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmount : currency;
      function fGetOrgID : string;
      function fGetOrderID : string;
      function fGetFeeName : string;
      function fGetDesc : string;
      function fGetTaxRate : double;
      function fGetReturnFlag : boolean;
      function fGetReturnAdd : boolean;
      function fGetReturnProdID : string;
      function fGetmTaxID : string;
      // Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmount( inValue : currency );
      procedure fSetOrgID( inValue : string );
      procedure fSetOrderID( inValue : string );
      procedure fSetFeeName( inValue : string );
      procedure fSetDesc( inValue : string );
      procedure fSetTaxRate( inValue : double );
      procedure fSetOrderType( inValue : tOrderTypes );
      procedure fSetReturnFlag( inValue : boolean );
      procedure fSetReturnAdd( inValue : boolean );
      procedure fSetReturnProdID( inValue : string );
      procedure fSetmTaxID( inValue : string );

   public
      FormHeight_Order : integer;
		// ----------------------------------------------------------------------------- //
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;
      procedure RecalculateInvoice;
      procedure LineItemClicked;
      procedure ReturnAllFeeItems( inVal : boolean );

      // properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property Amount : currency read fGetAmount write fSetAmount;
      property OrgID : string read fGetOrgID write fSetOrgID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property FeeName : string read fGetFeeName write fSetFeeName;
      property Desc : string read fGetDesc write fSetDesc;
      property TaxRate : double read fGetTaxRate write fSetTaxRate;
      property ID : string read fID write fID;
      property OrderType : tOrderTypes read fOrderType write fSetOrderType;
      property ReturnFlag : boolean read fGetReturnFlag write fSetReturnFlag;
      property ReturnAdd : boolean read fGetReturnAdd write fSetReturnAdd;
      property ReturnFeeID : string read fGetReturnProdID write fSetReturnProdID;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;
      // Events
      property OnLineClicked : tInvoiceFeeItemClickedEvent read fInvoiceFeeItemClickedEvent write fInvoiceFeeItemClickedEvent;
      property OnRecalculateInvoice : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;
      constructor create( inOwner : tComponent ); override;
   end;

implementation

{$R *.dfm}

// ============================================================================== //

constructor TReturn_FEEItem_Form.create(inOwner: tComponent);
begin
	inherited create( inOwner );
   // Initialize
   FormHeight_Order := 145;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, '');
end;

function TReturn_FEEItem_Form.fGetAmount: currency;
begin
   fAmount := Return_MaskEdit_Curr(tFeeLineFeeAmount.Text);
   result := fAmount;
end;

procedure TReturn_FEEItem_Form.fSetAmount(inValue: currency);
begin
   fAmount := inValue;
   tFeeLineFeeAmount.Text := FormatFloat('####0.00', fAmount);
end;

// ============================================================================== //

function TReturn_FEEItem_Form.fGetCycleID: string;
begin
   result := fCycleID;
end;

procedure TReturn_FEEItem_Form.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

// ============================================================================== //


function TReturn_FEEItem_Form.fGetFeeName: string;
begin
   fFeeName := tFeeLineFeeName.Text;
   result := fFeeName;
end;

procedure TReturn_FEEItem_Form.fSetFeeName(inValue: string);
begin
   fFeeName := inValue;
   tFeeLineFeeName.Text := fFeeName;
end;

// ============================================================================== //

procedure TReturn_FEEItem_Form.fSetDesc(inValue: string);
begin
   fDesc := inValue;
end;

function TReturn_FEEItem_Form.fGetDesc: string;
begin
   result := fDesc;
end;

// ============================================================================== //

function TReturn_FEEItem_Form.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

procedure TReturn_FEEItem_Form.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
   OrderProductNumPanel.Caption := IntToStr(fLineNumber  + 1);
end;

// ============================================================================== //

function TReturn_FEEItem_Form.fGetOrderID: string;
begin
   result := fOrderId;
end;

procedure TReturn_FEEItem_Form.fSetOrderID(inValue: string);
begin
   fOrderId := inValue;
end;

procedure TReturn_FEEItem_Form.fSetOrderType(inValue: tOrderTypes);
begin
   fOrderType := inValue;
end;

// ============================================================================== //


 function TReturn_FEEItem_Form.fGetOrgID: string;
begin
   result := fOrgID;
end;

procedure TReturn_FEEItem_Form.fSetOrgID(inValue: string);
begin
   fOrgID := inValue;
   OrgLabel.Caption := Org_GetOrgNameByOrgID( fOrgID );
end;

// ============================================================================== //


function TReturn_FEEItem_Form.fGetReturnAdd: boolean;
begin
   result := fReturnAdd;
end;

procedure TReturn_FEEItem_Form.fSetReturnAdd(inValue: boolean);
begin
   fReturnAdd := inValue;
   if ( fReturnAdd ) then
   begin
      tFeeLineFeeName.ReadOnly := False;
      tFeeLineFeeAmount.Enabled := True;
      ReturnFeePanel.Visible := False;
      nonAddFeeLabel.Visible := False;
      fReturnFlag := true;
   end else
      begin
         nonAddFeeLabel.Visible := true;
         tFeeLineFeeName.ReadOnly := True;
         tFeeLineFeeAmount.Enabled := False;
         ReturnFeePanel.Visible := True;
      end;
end;

// ============================================================================== //


function TReturn_FEEItem_Form.fGetReturnFlag: boolean;
begin
   fReturnFlag := ( db_feerefund.Checked );
   result := fReturnFlag;
end;


procedure TReturn_FEEItem_Form.fSetReturnFlag(inValue: boolean);
begin
   fReturnFlag := inValue;
   db_feerefund.Checked := fReturnFlag;
end;

// ============================================================================== //

function TReturn_FEEItem_Form.fGetReturnProdID: string;
begin
   result := fReturnProdID;
end;

procedure TReturn_FEEItem_Form.fSetReturnProdID(inValue: string);
begin
   fReturnProdID := inValue;
end;


// ============================================================================== //

function TReturn_FEEItem_Form.fGetTaxRate: double;
begin
	result := fTaxRate;
end;

procedure TReturn_FEEItem_Form.fSetTaxRate(inValue: double);
begin
	fTaxRate := inValue;
   TaxRateLabel.Caption := CurrToStr( fTaxRate ) + '%';
end;


procedure TReturn_FEEItem_Form.LineItemClicked;
begin
  if assigned(fInvoiceFeeItemClickedEvent) then
    fInvoiceFeeItemClickedEvent(Self, fLineNumber);
end;


// ============================================================================== //

// ============================================================================== //

procedure TReturn_FEEItem_Form.TabBackward;
begin
   // back tab
end;

procedure TReturn_FEEItem_Form.TabForward;
begin
   // forward tab
end;

procedure TReturn_FEEItem_Form.tFeeLineFeeAmountChange(Sender: TObject);
begin
   RecalculateInvoice;
end;

procedure TReturn_FEEItem_Form.tInvoiceLineItemWaveTaxClick(Sender: TObject);
begin
   LineItemClicked();
   RecalculateInvoice;
end;

procedure TReturn_FEEItem_Form.FeeLineItemClicked(Sender: TObject);
begin
   if ( Sender is TMaskEdit ) then
   begin
      if ( tMaskEdit(Sender).Name = 'tFeeLineFeeAmount' ) then
         tMaskEdit(Sender).SelectAll;
   end;
   LineItemClicked();
end;

procedure TReturn_FEEItem_Form.RecalculateInvoice;
begin
	// we received an recaculate, so we are going to pass that all the way
   // down to the bottom because it will tell everyone to recalculate
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

procedure TReturn_FEEItem_Form.ReturnAllFeeItems(inVal: boolean);
begin
   returnFlag := inVal;
end;

// ============================================================================== //

procedure TReturn_FEEItem_Form.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, fmTaxID );
end;

function TReturn_FEEItem_Form.fGetmTaxID: string;
begin
   fmTaxID := Tax_GetMasterTaxIDByName( db_taxclass.Text );
   //
   result := fmTaxID;
end;

end.