 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_MOPItem_FormUnit;

{ NOTE:

	DUE to PCI/ SAS 70 NON Compliance, we CANNOT use the Card Type, Card Value, EXP Date, CVV or Name On Card Values. We should never
   even be USING the CVV values to store! Holy shit! However, since i coded them into the application long before I knew that, I
   have removed the card type, expm/expy,cvv/noc fields from this form.
}

interface uses
   Invoice_MOPItem_InterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   recordstructureunit,
   masterdataunit,
   toolbox_paymenttoolboxunit,
   toolbox_preferencetoolboxunit,
   img_storageformunit,
   avobase_dialogformunit,
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
   ComCtrls, Buttons, Menus;

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

type
  TInvoice_MOPItem_Form = class(TForm, iMOPLineItem)
    MOP_BACK_PANEL: TPanel;
    MOP_SIDE_PANEL: TPanel;
    MOP_PANEL: TPanel;
    LineItemOnePanel: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    mopvalueLabel: TLabel;
    paymentTypeCombo: TComboBox;
    db_mopvalue: TEdit;
    db_mopdate: TDateTimePicker;
    OrderProductNumPanel: TPanel;
    FeeCostLabel: TLabel;
    db_amount: TMaskEdit;
    procedure MOPLineClicked(Sender: TObject);
    procedure db_amountChange(Sender: TObject);
    procedure paymentTypeComboChange(Sender: TObject);
    procedure ClearFee1Click(Sender: TObject);
   protected
      eLineDelete : tEvent_MOPItem_LineDelete;
      eLineUpdate : tEvent_MOPItem_LineUpdate;
   private
      // variables
      fCycleID : string; // the sales cycle
      fCustID : string;
      fLineNumber : integer; // the line number of the MOP
      fAmount : currency;
      fID : string;
      fReadOnly : boolean;
      fOrgID : string;
      fCID : string;
      fMopDate : tDateTime;
      fMopType : integer;
      fMopValue : string;
      fMopCCExpM : integer;
      fMopCCExpY : integer;
      fMopNoc : string;
      fEscrowCredit : currency;
      fMopCCT : integer;
      fMopCVV : string;
      fOrderID : string;

      // events
      fInvoiceMOPItemClickedEvent : tInvoiceMOPItemClickedEvent;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;

   	// Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmount : currency;
      function fGetID : string;
      function fGetOrgId : string;
      function fGetCID : string;
      function fGetMopDate : tDateTime;
      function fGetMopType : integer;
      function fGetMopValue : string;
      function fGetMopCCExpM : integer;
      function fGetMopCCExpy : integer;
      function fGetMopNoc : string;
      function fGetMopCVV : string;
      function fGetOrderID : string;
      function fGetMOPCCT : integer;
      function fGetReadOnly : boolean;

      // Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmount( inValue : currency );
      procedure fSetId( inValue : string );
      procedure fSetOrgID( inValue : string );
      procedure fSetCID( inValue : string );
      procedure fSetMopDate( inValue : tDateTime );
      procedure fSetMopType( inValue : integer );
      procedure fSetMopValue( inValue : string );
      procedure fSetMopCCExpM( inValue : integer );
      procedure fSetMopCCExpY( inValue : integer );
      procedure fSetMopNoc( inValue : string );
      procedure fSetMopCVV( inValue : string );
      procedure fSetOrderID( inValue : string );
      procedure fSetMOPCCT( inValue : integer );
      procedure fSetReadOnly( inValue : boolean );
   public
      FormHeight_Order : integer;
      FormWidth_Order : integer;
      FormWidth_Void : integer;

		// ----------------------------------------------------------------------------- //
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;
      procedure LineItemClicked;
      procedure RecalculateInvoice;
      procedure Update_Fields;
      procedure TurnOffBackPanel;
      procedure TurnOffSidePanel;
      procedure SetEscrow( inAmount : currency );

      // properties
		// ----------------------------------------------------------------------------- //
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property ID : string read fGetID write fSetId;
      property OrgID : string read fGetOrgId write fSetOrgID;
      property CycleID : string read fGetCycleID write fSetCycleID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property C_ID : string read fGetCID write fSetCID;
      property MopDate : tDateTime read fGetMopDate write fSetMopDate;
      property MopType : integer read fGetMopType write fSetMopType;
      property MopValue : string read fGetMopValue write fSetMopValue;
      property MopCCExpM : integer read fGetMopCCExpM write fSetMopCCExpM;
      property MopCCExpY : integer read fGetMopCCExpy write fSetMopCCExpY;
      property MopNoc : string read fGetMopNoc write fSetMopNoc;
      property MopCVV : string read fGetMopCVV write fSetMopCVV;
      property Amount : currency read fGetAmount write fSetAmount;
      property MOPCCT : integer read fGetMOPCCT write fSetMOPCCT;
      property ReadOnly : boolean read fGetReadOnly write fSetReadOnly;
      property CustID : string read fCustID write fCustID;

      // Events
		// ----------------------------------------------------------------------------- //
      property OnLineClicked : tInvoiceMOPItemClickedEvent read fInvoiceMOPItemClickedEvent write fInvoiceMOPItemClickedEvent;
      property OnRecalculateInvoice : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;

      // Constructor
		// ----------------------------------------------------------------------------- //
      constructor create( inOwner : tComponent ); override;

   end;

implementation

{$R *.dfm}

// ################################################################################################# //


constructor TInvoice_MOPItem_Form.create(inOwner: tComponent);
var
   cnt : integer;
   dateRec : tDateRecord;
begin
	inherited create( inOwner );

   // Initialize
   FormHeight_Order := 45;
   FormWidth_Order := 651;
   FormWidth_Void := 728;

   // Fill payment types
   Payment_FillPaymentTypes( paymentTypeCombo );
   //
   Update_Fields();
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetAmount: currency;
begin
   fAmount := Return_MaskEdit_Curr(db_amount.Text);
   result := fAmount;
end;

procedure TInvoice_MOPItem_Form.fSetAmount(inValue: currency);
begin
   fAmount := inValue;
   db_amount.Text := FormatFloat('####0.00', fAmount);
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetCID: string;
begin
   result := fCID;
end;

procedure TInvoice_MOPItem_Form.fSetCID(inValue: string);
begin
   fCID := inValue;
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetCycleID: string;
begin
   result := fCycleID;
end;

procedure TInvoice_MOPItem_Form.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetID: string;
begin
   result := fID;
end;

procedure TInvoice_MOPItem_Form.fSetId(inValue: string);
begin
   fID := inValue;
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

procedure TInvoice_MOPItem_Form.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
   OrderProductNumPanel.Caption := IntToSTr( fLineNumber + 1 );
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetMopCCExpM: integer;
begin
{ REMOVED FOR NOW
   fMopCCExpM := db_mopccexpm.ItemIndex + 1;
   result := fMopCCExpM;
}
	RESULT := 0;
end;

procedure TInvoice_MOPItem_Form.fSetMopCCExpM(inValue: integer);
begin
{ REMOVED FOR NOW
   if (inValue <> 0) then
      db_mopccexpm.itemindex := inValue - 1
   else
      db_mopccexpm.itemindex := 0;
}
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetMopCCExpy: integer;
begin
{ REMOVED FOR NOW
   fMopCCExpy := StrToInt( db_mopccexpy.Text );
   result := fMopCCExpy;
}
	RESULT := 0;
end;


procedure TInvoice_MOPItem_Form.fSetMopCCExpY(inValue: integer);
var
   cnt : integer;
begin
{ REMOVED FOR NOW
   db_mopccexpy.itemindex := 0;
   if (inValue <> 0) then
      for cnt := 0 to db_mopccexpy.Items.Count - 1 do
         if ( StrToInt(db_mopccexpy.Text ) = inValue) then
            db_mopccexpy.ItemIndex := cnt;
}
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetMOPCCT: integer;
begin
{ REMOVED FOR NOW
   fMOPCCT := db_ccardtype.ItemIndex;
   result := fMOPCCT;
}
	RESULT := 0;
end;

procedure TInvoice_MOPItem_Form.fSetMOPCCT(inValue: integer);
begin
{ REMOVED FOR NOW
   fMOPCCT := inValue;
   db_ccardtype.ItemIndex := fMOPCCT;
}
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetMopCVV: string;
begin
{ REMOVED FOR NOW
   fMopCVV := db_mopcvv.Text;
   result := fMopCVV;
}
	RESULT := '';
end;

procedure TInvoice_MOPItem_Form.fSetMopCVV(inValue: string);
begin
{ REMOVED FOR NOW
   fMopCVV := inValue;
   db_mopcvv.Text := fMopCVV;
}
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetMopDate: tDateTime;
begin
   fMopDate := db_mopdate.date;
   result := fMopDate;
end;

procedure TInvoice_MOPItem_Form.fSetMopDate(inValue: tDateTime);
begin
   fMopDate := inValue;
  	db_mopdate.Date := fMopDate;
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetMopNoc: string;
begin
{ REMOVED FOR NOW
   fMopNoc := db_mopnoc.text;
   result := fMopNoc;
}
	RESULT := '';
end;

procedure TInvoice_MOPItem_Form.fSetMopNoc(inValue: string);
begin
{ REMOVED FOR NOW
   fMopNoc := inValue;
   db_mopnoc.Text := fMopNoc;
}
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetMopType: integer;
begin
   fMopType := Payment_GetPaymentIntegerByName ( paymentTypeCombo.Text );
   result := fMopType;
end;

procedure TInvoice_MOPItem_Form.fSetMopType(inValue: integer);
begin
   fMopType := inValue;
   paymenttypecombo.itemindex := inValue - 1;
   Update_Fields();
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetOrgId: string;
begin
   result := fOrgID;
end;

procedure TInvoice_MOPItem_Form.fSetOrgID(inValue: string);
begin
   fOrgID := inValue;
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetMopValue: string;
begin
   fMopValue := db_mopvalue.text;
   result := fMopValue;
end;

procedure TInvoice_MOPItem_Form.fSetMopValue(inValue: string);
begin
   fMopValue := inValue;
   db_mopvalue.text := fMopValue;
end;

// ################################################################################################# //

function TInvoice_MOPItem_Form.fGetOrderID: string;
begin
   result := fOrderID;
end;

procedure TInvoice_MOPItem_Form.fSetOrderID(inValue: string);
begin
   fOrderID := inValue;
end;

// ################################################################################################# //

procedure TInvoice_MOPItem_Form.TabBackward;
begin
   // back tab
end;

procedure TInvoice_MOPItem_Form.TabForward;
begin
   // forward tab
end;

procedure TInvoice_MOPItem_Form.TurnOffBackPanel;
begin
   MOP_PANEL.BorderWidth := 0;
end;

procedure TInvoice_MOPItem_Form.TurnOffSidePanel;
begin
   MOP_SIDE_PANEL.Visible := False;
end;

// ################################################################################################# //

procedure TInvoice_MOPItem_Form.LineItemClicked;
begin
   if assigned(fInvoiceMOPItemClickedEvent) then
      fInvoiceMOPItemClickedEvent(Self, fLineNumber);
end;

// ################################################################################################# //

procedure TInvoice_MOPItem_Form.MOPLineClicked(Sender: TObject);
begin
   if ( Sender is TMaskEdit ) then
   begin
      if ( tMaskEdit(Sender).Name = 'db_amount' ) then
         tMaskEdit(Sender).SelectAll;
   end;
   LineItemClicked();
end;


// ################################################################################################# //

procedure TInvoice_MOPItem_Form.paymentTypeComboChange(Sender: TObject);
begin
   Update_Fields();
end;

// ################################################################################################# //

procedure TInvoice_MOPItem_Form.db_amountChange(Sender: TObject);
begin
   RecalculateInvoice;
end;


// ################################################################################################# //

procedure TInvoice_MOPItem_Form.Update_Fields;
var
   ccDataEnabled : boolean;
   checkEnabled : boolean;
begin
   ccDataEnabled := true;
   checkEnabled := false;
   //
   case Payment_GetPaymentTypeByPaymentName( paymentTypeCombo.Text ) of
      integer(PayTypeCash):
      begin
         mopvalueLabel.Caption := 'NOT USED';
         ccDataEnabled := false;
         checkEnabled := false;
      end;
      integer(PayTypeCreditCard):
      begin
         mopvalueLabel.Caption := 'CREDIT CARD #';
         ccDataEnabled := true;
         checkEnabled := false;
      end;
      integer(PayTypeCheck):
      begin
         mopvalueLabel.Caption := 'CHECK #';
         ccDataEnabled := false;
         checkEnabled := true;
      end;
      integer(PayTypeCashierCheck):
      begin
         mopvalueLabel.Caption := 'CHECK #';
         ccDataEnabled := false;
         checkEnabled := true;
      end;
      integer(PayTypeMoneyOrder):
      begin
         mopvalueLabel.Caption := 'MONEY ORDER #';
         ccDataEnabled := false;
         checkEnabled := true;
      end;
      integer(PayTypeDebitCard):
      begin
         mopvalueLabel.Caption := 'DEBIT CARD #';
         ccDataEnabled := true;
         checkEnabled := false;
      end;
      integer(PayTypePayPal):
      begin
         mopvalueLabel.Caption := 'PAYPAL TRAN #';
         ccDataEnabled := false;
         checkEnabled := true;
      end;
   end;

   // first, they are all off, then we turn the ones on we want
   db_mopvalue.visible := false;
   mopvalueLabel.visible := false;

   //
   if (ccDataEnabled) then
   begin
      db_mopvalue.visible := FALSE;
      mopvalueLabel.visible := FALSE;
   end;

   //
   if (checkEnabled) then
   begin
      db_mopvalue.visible := true;
      mopvalueLabel.visible := true;
   end;
end;

// ################################################################################################# //

procedure TInvoice_MOPItem_Form.RecalculateInvoice;
begin
	// we received an recaculate, so we are going to pass that all the way
   // down to the bottom because it will tell everyone to recalculate
   if Assigned(eRecalculateInvoiceEvent) then
   	eRecalculateInvoiceEvent();
end;


// ################################################################################################# //

procedure TInvoice_MOPItem_Form.ClearFee1Click(Sender: TObject);
begin
   if AvoBaseDialog('Blank Method Of Payment', 'Are you sure you want to blank this Method Of Payment?',
      mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      MopDate := Now;
      MopValue := '';
      MopCCExpM := 1;
      MopCCExpY := 1;
      MopNoc := '';
      MopCVV := '';
      Amount := 0.00;
      MOPCCT := 0;
      MopType := 1;
      Update_Fields();
   end;
end;

// ################################################################################################# //

{ this makes this form totally read only. }

function TInvoice_MOPItem_Form.fGetReadOnly: boolean;
begin
   result := fReadOnly;
end;

procedure TInvoice_MOPItem_Form.fSetReadOnly(inValue: boolean);
begin
   fReadOnly := inValue;
   if (fReadOnly) then
   begin
      db_amount.Enabled := False;
      db_mopdate.Enabled := False;
      paymentTypeCombo.Enabled := False;
      db_mopvalue.Enabled := False;
   end;
end;

// ################################################################################################# //

procedure TInvoice_MOPItem_Form.SetEscrow(inAmount: currency);
begin
   fAmount := inAmount;
   fMopType := integer(PayTypeEscrow);
   fMopValue := '';
   //
   paymenttypecombo.itemindex := ( fMopType - 1 );
   db_amount.Text := FormatFloat('####0.00', fAmount);
   //
   Update_Fields();
end;

// ################################################################################################# //


end.
