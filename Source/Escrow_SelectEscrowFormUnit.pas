 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Escrow_SelectEscrowFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   masterdata_BaseDataClassUnit,
   encryptunit,
   ToolBox_PreferenceToolBoxUnit,
   toolbox_cycletoolboxunit,
   RecordStructureUnit,
   toolbox_orgtoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_paymenttoolboxunit,
   toolbox_customertoolboxunit,
   Invoice_MOPItem_FormUnit,
   ToolBox_EscrowToolBoxUnit,
   errorresultunit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
   dbtables,
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
   tEscrow_SelectEscrow = class(TAvoBase_BaseForm_Menu)
    finalImage: TImage;
    OrdPurchLabel: TLabel;
    CustSoldToName: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToPhone: TLabel;
    CustSoldToAddress: TLabel;
    db_amount: TLabel;
    db_refundlabel: TLabel;
    escrowLabel: TLabel;
    GroupBox1: TGroupBox;
    paymentTypeCombo: TComboBox;
    Label1: TLabel;
    mopvalueLabel: TLabel;
    db_mopvalue: TEdit;
    procedure FormDestroy(Sender: TObject);
    procedure paymentTypeComboChange(Sender: TObject);
   private
      fTransRec : tTransRec;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      procedure StartUpForm();
      procedure TakeEscrowPayment();
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inTransRec : tTransRec); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TEscrow_SelectEscrow.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inTransRec : tTransRec);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fTransRec := inTransRec;
   //
	StartUpForm();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEscrow_SelectEscrow.FormDestroy(Sender: TObject);
begin
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEscrow_SelectEscrow.StartUpForm;
var
   custRec : tCustRec;
   formatMsg : string;
  strCnt : integer;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_SELECT_OK );
   //
   formatMsg := fTransRec.disp_msg;
   while POS('\n', formatMsg) > 0 do
   begin
      strCnt := POS('\n', formatMsg);
      delete( formatMsg, strCnt, 2);
      insert( #13, formatMsg, strCnt );
   end;
   escrowLabel.Caption := formatMsg;
   //
   CustRec := Customer_GetCustomerByCustID( fTransRec.c_stid );
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
   //
   db_refundlabel.caption := Pref_GetCashSymbol + FormatFloat('####0.00', fTransRec.amount);
   //
   paymentTypeCombo.Items.Clear;
   paymentTypeCombo.Items.Add('CASH'); // 0
   paymentTypeCombo.Items.Add('CHECK'); // 1
   paymentTypeCombo.Items.Add('CASHIERS CHECK'); // 2
   paymentTypeCombo.Items.Add('MONEY ORDER'); // 3
   paymentTypeCombo.Items.Add('SAVE TO ESCROW'); // 3
   paymentTypeCombo.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEscrow_SelectEscrow.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_SELECT_OK : TakeEscrowPayment();
      CMD_HELP: AvoBaseHelp_Execute('Escrow_SelectEscrow');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEscrow_SelectEscrow.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // we don't need no shit.
   Handled := true;
end;

procedure tEscrow_SelectEscrow.paymentTypeComboChange(Sender: TObject);
var
   enA : boolean;
begin
   case paymentTypeCombo.ItemIndex of
      0 : enA := false;
      1 : enA := true;
      2 : enA := true;
      3 : enA := true;
      4 : enA := false;
   end;
   if ( enA ) then
   begin
      mopvalueLabel.caption := 'CHECK NUMBER';
      mopvalueLabel.visible := true;
      db_mopvalue.visible := true;
   end else
      begin
         mopvalueLabel.visible := false;
         db_mopvalue.visible := false;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEscrow_SelectEscrow.TakeEscrowPayment;
var
   errMsg : string;
   payType : string;
   errRec : tErrorResult;
begin
   errMsg := '';
   //
   if ( paymentTypeCombo.ItemIndex = 1 ) AND ( db_mopvalue.Text = '' ) then
      errMsg := 'With Payment Type of Check, the Check Number is required.';
   if ( paymentTypeCombo.ItemIndex = 2 ) AND ( db_mopvalue.Text = '' ) then
      errMsg := 'With Payment Type of Cashiers Check, the Check Number is required.';
   if ( paymentTypeCombo.ItemIndex = 3 ) AND ( db_mopvalue.Text = '' ) then
      errMsg := 'With Payment Type of Money Order, the Money Order Number is required.';
   //
   if ( errMsg = '' ) then
   begin
      case paymentTypeCombo.ItemIndex of
         0 : payType := 'Cash';
         1 : payType := 'Check';
         2 : payType := 'Cashiers Check';
         3 : payType := 'Money Order';
         4 : payType := 'Transfer To Customer Escrow';
      end;
      if AvoBaseDialog('Confirm Payment Type', 'Confirm that you are making a ' + payType + ' of ' + Pref_GetCashSymbol +
         FormatFloat('####0.00', fTransRec.amount) + ' to ' + Customer_GetCustomerNameByCustID( fTransRec.c_stid ) + '.' + #13 + #13 +
         'This will create a Transaction Entry against the Customer and count as a deduction in your Sales Cycle.' + #13 + #13 +
         'Click YES to continue, or NO to change payment type.', mtConfirmation, [mbyes, mbno], 0) = mbYes then
      begin
         with fTransRec do
         begin
            tdate := Now;
            ttime := Now;
            tmopvalue := db_mopvalue.Text;
            ttype := integer(tTransTypes.TransCredit);
            case paymentTypeCombo.ItemIndex of
               0 : tMopType := integer( tMethodOfPaymentTypes.PayTypeCash );
               1 : tMopType := integer( tMethodOfPaymentTypes.PayTypeCheck );
               2 : tMopType := integer( tMethodOfPaymentTypes.PayTypeCashierCheck );
               3 : tMopType := integer( tMethodOfPaymentTypes.PayTypeMoneyOrder );
               4 : tMopType := integer( tMethodOfPaymentTypes.PayTypeEscrow );
            end;
            //

            // Create a transaction against it showing a credit was given
            errRec := Payment_MakeTransactionPayment( fTransRec );

            // Create an actual escrow record adding the credit to the customer, but ONLY if it was escrow.
            if ( fTransRec.tmoptype = integer( tMethodOfPaymentTypes.PayTypeEscrow ) ) then
               errRec := Escrow_AddEscrowByCustomerID( fTransRec.c_stid, fTransRec.amount );

            // errors?
            if ( errRec.errorResult ) then
               Error_Log( errRec, true );
            //
            Close();
         end;
      end;
   end else
      AvoBaseDialog('Unable To Proceed', errMsg, mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
