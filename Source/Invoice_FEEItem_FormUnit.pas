 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_FEEItem_FormUnit;

interface uses
   Invoice_FEEItem_InterfaceUnit,
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
  TInvoice_FEEItem_Form = class(TForm, iFEELineItem)
    PopMenu: TPopupMenu;
    None1: TMenuItem;
    InvoceLineFrontPanel: TPanel;
    Fee_Opt_Panel: TPanel;
    FEE_BACK_PANEL: TPanel;
    LineItemOnePanel: TPanel;
    FeeNameLabel: TLabel;
    Label1: TLabel;
    tFeeLineFeeName: TEdit;
    tFeeLineDescr: TEdit;
    OrderProductNumPanel: TPanel;
    FeeCostLabel: TLabel;
    tFeeLineFeeAmount: TMaskEdit;
    TaxRateLabel: TLabel;
    TaxLabel: TLabel;
    tTotalTaxLabel: TLabel;
    TOtalCostLabel: TLabel;
    tTotalCostLabel: TLabel;
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
      fmTaxID : string; // master tax ID

      // events
      fInvoiceFeeItemClickedEvent : tInvoiceFeeItemClickedEvent;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;
      eLineDelete : tEvent_FEEItem_LineDelete;
      eLineUpdate : tEvent_FEEItem_LineUpdate;

   	// Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmount : currency;
      function fGetOrgID : string;
      function fGetOrderID : string;
      function fGetFeeName : string;
      function fGetDesc : string;
      function fGetTaxRate : double;
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
      procedure fSetmTaxID( inValue : string );

   public
      FormHeight_Order : integer;
		// ----------------------------------------------------------------------------- //
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;
      procedure RecalculateInvoice;
      procedure LineItemClicked;

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
      property mTaxID : string read fGetmTaxID write fSetmTaxID;
      // Events
      property OnLineClicked : tInvoiceFeeItemClickedEvent read fInvoiceFeeItemClickedEvent write fInvoiceFeeItemClickedEvent;
      property OnRecalculateInvoice : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;
      constructor create( inOwner : tComponent ); override;
   end;

implementation

{$R *.dfm}

// ============================================================================== //

constructor TInvoice_FEEItem_Form.create(inOwner: tComponent);
begin
	inherited create( inOwner );
   // Initialize
   FormHeight_Order := 38;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, fmTaxID );
end;

function TInvoice_FEEItem_Form.fGetAmount: currency;
begin
   fAmount := Return_MaskEdit_Curr(tFeeLineFeeAmount.Text);
   result := fAmount;
end;

procedure TInvoice_FEEItem_Form.fSetAmount(inValue: currency);
begin
   fAmount := inValue;
   tFeeLineFeeAmount.Text := FormatFloat('####0.00', fAmount);
end;

// ============================================================================== //

function TInvoice_FEEItem_Form.fGetCycleID: string;
begin
   result := fCycleID;
end;

procedure TInvoice_FEEItem_Form.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

// ============================================================================== //


function TInvoice_FEEItem_Form.fGetFeeName: string;
begin
   fFeeName := tFeeLineFeeName.Text;
   result := fFeeName;
end;

procedure TInvoice_FEEItem_Form.fSetFeeName(inValue: string);
begin
   fFeeName := inValue;
   tFeeLineFeeName.Text := fFeeName;
end;

// ============================================================================== //

procedure TInvoice_FEEItem_Form.fSetDesc(inValue: string);
begin
   fDesc := inValue;
   tFeeLineDescr.Text := fDesc;
end;

function TInvoice_FEEItem_Form.fGetDesc: string;
begin
   fDesc := tFeeLineDescr.Text;
   result := fDesc;
end;

// ============================================================================== //

function TInvoice_FEEItem_Form.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

procedure TInvoice_FEEItem_Form.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
   OrderProductNumPanel.Caption := IntToStr(fLineNumber  + 1);
end;

// ============================================================================== //

function TInvoice_FEEItem_Form.fGetOrderID: string;
begin
   result := fOrderId;
end;

procedure TInvoice_FEEItem_Form.fSetOrderID(inValue: string);
begin
   fOrderId := inValue;
end;

procedure TInvoice_FEEItem_Form.fSetOrderType(inValue: tOrderTypes);
begin
   fOrderType := inValue;
end;

// ============================================================================== //

function TInvoice_FEEItem_Form.fGetOrgID: string;
begin
   result := fOrgID;
end;

procedure TInvoice_FEEItem_Form.fSetOrgID(inValue: string);
begin
   fOrgID := inValue;
//   OrgLabel.Caption := Org_GetOrgNameByOrgID( fOrgID );
end;

// ============================================================================== //

function TInvoice_FEEItem_Form.fGetTaxRate: double;
begin
	result := fTaxRate;
end;

procedure TInvoice_FEEItem_Form.fSetTaxRate(inValue: double);
begin
	fTaxRate := inValue;
   TaxRateLabel.Caption := CurrToStr( fTaxRate ) + '%';
end;


procedure TInvoice_FEEItem_Form.LineItemClicked;
begin
  if assigned(fInvoiceFeeItemClickedEvent) then
    fInvoiceFeeItemClickedEvent(Self, fLineNumber);
end;

// ============================================================================== //

procedure TInvoice_FEEItem_Form.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, fmTaxID );
end;

function TInvoice_FEEItem_Form.fGetmTaxID: string;
begin
   fmTaxID := Tax_GetMasterTaxIDByName( db_taxclass.Text );
   //
   result := fmTaxID;
end;

// ============================================================================== //
// ============================================================================== //

procedure TInvoice_FEEItem_Form.TabBackward;
begin
   // back tab
end;

procedure TInvoice_FEEItem_Form.TabForward;
begin
   // forward tab
end;

procedure TInvoice_FEEItem_Form.tFeeLineFeeAmountChange(Sender: TObject);
begin
   RecalculateInvoice;
end;

procedure TInvoice_FEEItem_Form.tInvoiceLineItemWaveTaxClick(Sender: TObject);
begin
   LineItemClicked();
   RecalculateInvoice;
end;

procedure TInvoice_FEEItem_Form.FeeLineItemClicked(Sender: TObject);
begin
   if ( Sender is TMaskEdit ) then
   begin
      if ( tMaskEdit(Sender).Name = 'tFeeLineFeeAmount' ) then
         tMaskEdit(Sender).SelectAll;
   end;
   LineItemClicked();
end;

procedure TInvoice_FEEItem_Form.RecalculateInvoice;
begin
	// we received an recaculate, so we are going to pass that all the way
   // down to the bottom because it will tell everyone to recalculate
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;

end.