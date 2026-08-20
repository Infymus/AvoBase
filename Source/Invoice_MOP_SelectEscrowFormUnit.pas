 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_MOP_SelectEscrowFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
  recordstructureunit,
   avobase_dialogformunit,
   masterdata_BaseDataClassUnit,
   //
   toolbox_escrowtoolboxunit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   //
   windows,
   messages,
   sysutils,
   variants,
   classes,
   ActnList,
   graphics,
   controls,
   forms,
   dialogs,
   stdctrls,
   extctrls,
   ComCtrls,
   ToolWin,
   Mask, jpeg;

type
   tInvoice_MOP_SelectEscrowForm = class(TAvoBase_BaseForm_Menu)
    OrdPurchLabel: TLabel;
    CustSoldToName: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToPhone: TLabel;
    finalImage: TImage;
    finalizeLabel: TLabel;
    GroupBox1: TGroupBox;
    AmountDueLabel: TLabel;
    db_escrow: TLabel;
    FeeCostLabel: TLabel;
    db_amount: TMaskEdit;
    Label1: TLabel;
    db_totalusedescrow: TLabel;
    Label3: TLabel;
    db_amountdue: TLabel;
    Label2: TLabel;
    db_totalmop: TLabel;
   private
      fCustID : string;
      fEscrowAmount : currency;
      fAmount : currency;
      fAmountMOP : currency;
      fAmountTotalDue : currency;
      fAmountTotalEscrowUsed : currency;
      fAmountTotalAvailEscrow : currency;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      function fGetAmount : currency;
      function fGetAmountMOP : currency;
      function fGetAmountTotalDue : currency;
      function fGetAmountTotalEscrowUsed : currency;
      function fGetAmountTotalAvailEscrow : currency;
      procedure fSetAmount( inAmount : currency );
      procedure fSetAmountMOP( inAmount : currency );
      procedure fSetAmountTotalDue( inAmount : currency );
      procedure fSetAmountTotalEscrowUsed( inAmount : currency );
      procedure fSetAmountTotalAvailEscrow( inAmount : currency );
   public
      procedure StartUpForm();
      //
      property Amount : currency read fGetAmount write fSetAmount;
      property Amount_MOP : currency read fGetAmountMOP write fSetAmountMOP;
      property Amount_TotalDue : currency read fGetAmountTotalDue write fSetAmountTotalDue;
      property Amount_TotalEscrowUsed : currency read fGetAmountTotalEscrowUsed write fSetAmountTotalEscrowUsed;
      property Amount_TotalAvailEscrow : currency read fGetAmountTotalAvailEscrow write fSetAmountTotalAvailEscrow;
      //
      function ValidateData : boolean;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inCustID : string); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tInvoice_MOP_SelectEscrowForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inCustID: string);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fCustID := inCustID;
   fEscrowAmount := Escrow_GetCustomerEscrowByCustomerID( fCustID );
   //
	StartUpForm();
end;

procedure tInvoice_MOP_SelectEscrowForm.StartUpForm;
var
   CustRec : tCustRec;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   CreateButton( CMD_CANCEL );
   CreateButtonSep();
   CreateButton( CMD_SELECT_OK );
   //
   db_escrow.Caption := Pref_GetCashSymbol + FormatFloat('####0.00', fEscrowAmount);
   db_amount.Text := FormatFloat('####0.00', fEscrowAmount);
   //
   CustRec := Customer_GetCustomerByCustID( fCustID );
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tInvoice_MOP_SelectEscrowForm.fGetAmount: currency;
begin
   result := Return_MaskEdit_Curr(db_amount.Text);
end;

function tInvoice_MOP_SelectEscrowForm.fGetAmountMOP: currency;
begin
   result := fAmountMOP;
end;

function tInvoice_MOP_SelectEscrowForm.fGetAmountTotalAvailEscrow: currency;
begin
   result := fAmountTotalAvailEscrow;
end;

function tInvoice_MOP_SelectEscrowForm.fGetAmountTotalDue: currency;
begin
   result := fAmountTotalDue;
end;

function tInvoice_MOP_SelectEscrowForm.fGetAmountTotalEscrowUsed: currency;
begin
   result := fAmountTotalEscrowUsed;
end;

procedure tInvoice_MOP_SelectEscrowForm.fSetAmount(inAmount: currency);
begin
   fAmount := inAmount;
	db_amount.Text := FormatCurrency(inAmount);
end;

procedure tInvoice_MOP_SelectEscrowForm.fSetAmountMOP(inAmount: currency);
begin
   fAmountMOP := inAmount;
   db_escrow.Caption := FormatCurrency(inAmount);
end;

procedure tInvoice_MOP_SelectEscrowForm.fSetAmountTotalAvailEscrow( inAmount: currency);
begin
   fAmountTotalAvailEscrow := inAmount;
   db_escrow.Caption := FormatCurrency(inAmount);
end;

procedure tInvoice_MOP_SelectEscrowForm.fSetAmountTotalDue(inAmount: currency);
begin
   fAmountTotalDue := inAmount;
   db_amountdue.Caption := FormatCurrency(inAmount);
end;

procedure tInvoice_MOP_SelectEscrowForm.fSetAmountTotalEscrowUsed( inAmount: currency);
begin
   fAmountTotalEscrowUsed := inAmount;
   db_totalusedescrow.Caption := FormatCurrency(inAmount);
end;

procedure tInvoice_MOP_SelectEscrowForm.HandleActionExecute( sender: tObject; actionID: integer );
begin
   case actionID of
      CMD_SELECT_OK:
      begin
         if ( Return_MaskEdit_Curr(db_amount.Text) > fEscrowAmount ) then
         begin
            AvoBaseDialog('Amount Exceeds Escrow',
               'The amount cannot exceed the total available Escrow funds.', mtError, [mbOK], 0);
         end else
            begin
               fFormEvent := mrOk;
               Close();
            end;
      end;
      CMD_CANCEL:
      begin
         fFormEvent := mrCancel;
         Close();
      end;
   end;
end;

procedure tInvoice_MOP_SelectEscrowForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean );
begin
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tInvoice_MOP_SelectEscrowForm.ValidateData : boolean;
var
   errMsg : string;
begin
   result := true;
   //
   errMsg := '';
   //
   if ( fEscrowAmount > fAmountTotalAvailEscrow ) then
      errMsg := 'The amount of available Customer Escrow is ' + Pref_GetCashSymbol + FormatFloat('####0.00', fAmountTotalAvailEscrow) + '\n\n' +
         'Amount currently being used is ' + Pref_GetCashSymbol + FormatFloat('####0.00', fAmountTotalEscrowUsed) + '.';
   if ( fAmountTotalAvailEscrow <= 0 ) then
      errMsg := 'The Customer does not have any available Escrow.';
   if ( fAmountTotalDue <= 0 ) then
      errMsg := 'Total Method Of Payment = Total Amount Due.';
   //
   if ( errMsg <> '' ) then
   begin
      AvoBaseDialog('Unable To Use Escrow', errMsg, mtError, [mbOk], 0);
      result := false;
   end;
end;

end.

       {
      fEscrowAmount : currency;
      fAmount : currency;
      fAmountMOP : currency;
      fAmountTotalDue : currency;
      fAmountTotalEscrowUsed : currency;
      fAmountTotalAvailEscrow : currency;
      }
