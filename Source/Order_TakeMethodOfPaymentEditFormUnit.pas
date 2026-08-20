 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Order_TakeMethodOfPaymentEditFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
  recordstructureunit,
   avobase_dialogformunit,
   toolbox_PreferenceToolBoxUnit,
   masterdata_BaseDataClassUnit,
   toolbox_customertoolboxunit,
   toolbox_OrderToolBoxUnit,
   encryptunit,
   Invoice_MOPItem_FormUnit,
   Order_InvoiceObjectUnit,
   toolbox_escrowtoolboxunit,
   AvoBase_HelpFormUnit,
   Invoice_MOP_SelectEscrowFormUnit,
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
   Mask;

{ this allows taking of a payment outside of an order. it is all still controlled by the ordercontrolform. }

type
   tOrderTakeMethodOfPaymentForm = class(TAvoBase_BaseForm_Menu)
    CUST_INFO_BACK_PANEL: TPanel;
    InvoiceTotalsPanel: TPanel;
    SubTotalLabel: TLabel;
    OrderProcLabel: TLabel;
    SalesTaxLabel: TLabel;
    PaymentsLabel: TLabel;
    AmountDueLabel: TLabel;
    Amount_SubTotal: TLabel;
    Amount_Fees: TLabel;
    Amount_Tax: TLabel;
    InvoiceTotalLabel: TLabel;
    Amount_Total: TLabel;
    Amount_MOP: TLabel;
    Amount_Due: TLabel;
    ShippingLabel: TLabel;
    Amount_Shipping: TLabel;
    Panel9: TPanel;
    CustSoldToName: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToPhone: TLabel;
    db_void: TLabel;
    Label1: TLabel;
    MOPEscrowPanel: TPanel;
    credImage: TImage;
    credLabel: TLabel;
    escLabelDesc: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
   private
      fMOPQuery : tMasterData_BaseDataClass;
   	fCloseAction : tFormActions;
      fOrderID : string;
      fEscrowCredit : currency;
      orderInvoice : tInvoice;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure HandleUseEscrow( inLineNum : integer );
      procedure StartupForm;
      function Save : boolean;
      function AddEscrowMOP( inAmount_TotalDue, inAmount_AvailEscrow, inAmount_EscrowUsed, inAmount_TotalMOP : currency ) : integer;
   public
      MOPItem_Form : tInvoice_MOPItem_Form;
   	property CloseAction : tFormActions read fCloseAction;
      constructor Create( owner: TComponent; InCaption : string; inOrderID : string; isTopBarVisble : boolean); overload;
   end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tOrderTakeMethodOfPaymentForm.Create(owner: TComponent; InCaption, inOrderID: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fOrderID := inOrderID;
   //
   StartupForm();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrderTakeMethodOfPaymentForm.StartupForm;
var
   custRec : tCustRec;
begin
   fMOPQuery := tMasterData_BaseDataClass.Create( masterData, masterData.GetTable_Mop);
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;

   //
   MOPItem_Form := tInvoice_MOPItem_Form.Create( BASE_DOCK_PANEL );
   with MOPItem_Form do
   begin
      ManualDock( BASE_DOCK_PANEL );
      Visible := True;
      Show();
      Align := alClient;
   end;
   MOPItem_Form.LineNumber := 0;
   MOPItem_Form.ID := masterData.NewDBGuid;
   MOPItem_Form.OrderID := fOrderID;
   //
   MOPItem_Form.MopDate := Now;
   MOPItem_Form.MopType := 1;
   MOPItem_Form.MopValue := '';
   MOPItem_Form.MopCCExpM := 1;
   MOPItem_Form.MopCCExpY := 1;
   MOPItem_Form.MopNoc := '';
   MOPItem_Form.MopCVV := '';
   MOPItem_Form.Amount := 0.00;
   MOPItem_Form.MOP_SIDE_PANEL.Visible := false;
   //
   MOPItem_Form.Repaint();
   //
{
   Self.Width := MOPItem_Form.FormWidth_Order;
   Self.Height := 190 + MOPItem_Form.FormHeight_Order;
}
   //
   orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
   orderInvoice.Load( fOrderID );
   //
   //
   CustRec := Customer_GetCustomerByCustID( orderInvoice.Customer_SoldToID );
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
   //
   BASE_FORM_CAPTION_LABEL.Caption := BASE_FORM_CAPTION_LABEL.Caption + ' | Order # ' + orderInvoice.Order_GetOrderNumberName;
   Amount_SubTotal.Caption  := FormatCurrency(orderInvoice.Amount_LineItemTotal);
   Amount_Fees.Caption  := FormatCurrency(orderInvoice.Amount_FeeTotal);
   Amount_Tax.Caption  := FormatCurrency(orderInvoice.Amount_TotalTax);
   Amount_Total.Caption  := FormatCurrency(orderInvoice.Amount_Total);
   Amount_MOP.Caption  := FormatCurrency(orderInvoice.Amount_TotalMOP);
   Amount_Shipping.Caption   := FormatCurrency(orderInvoice.Amount_ShippingSubTotal);
   db_void.Caption := FormatCurrency(orderInvoice.Amount_VoidNSF);
   //
   if (orderInvoice.Amount_TotalDue > 0) then
   begin
      AmountDueLabel.Caption := 'AMOUNT OWED:';
      AmountDueLabel.Font.Color := clRed;
      Amount_Due.Font.COlor := clRed;
      Amount_Due.Caption := FormatCurrency(orderInvoice.Amount_TotalDue);
      MOPItem_Form.Amount := orderInvoice.Amount_TotalDue;
   end;
   if (orderInvoice.Amount_TotalDue = 0) then
   begin
      AmountDueLabel.Caption := 'BALANCE:';
      AmountDueLabel.Font.Color := clBlack;
      Amount_Due.Font.COlor := clBlack;
      Amount_Due.Caption := FormatCurrency(orderInvoice.Amount_TotalDue);
   end;
   if (orderInvoice.Amount_OverPaid > 0) then
   begin
      AmountDueLabel.Caption := 'CHANGE DUE:';
      AmountDueLabel.Font.Color := clBlue;
      Amount_Due.Font.COlor := clBlue;
      Amount_Due.Caption := FormatCurrency(orderInvoice.Amount_OverPaid);
   end;

   // These have to be last because they depend on the invoice object being instantiated

	CreateButton( CMD_HELP );
   // escrow
   fEscrowCredit := Escrow_GetCustomerEscrowByCustomerID( orderInvoice.Customer_SoldToID );
   if ( fEscrowCredit > 0 ) then
   begin
      CreateButtonSep();
      CreateButton( CMD_ESCROW_TAKEPAYMENT );
      credLabel.Caption := 'CUSTOMER ESCROW BALANCE: ' + Pref_GetCashSymbol + FormatCurrency( fEscrowCredit ) + '.';
   end else
      MOPEscrowPanel.Visible := False;
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SAVE );

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrderTakeMethodOfPaymentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // DO NOT INHERITED HERE... WE CONTROL THIS POPUP BS
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrderTakeMethodOfPaymentForm.FormDestroy(Sender: TObject);
begin
   FreeAndNil( MOPItem_Form );
   FreeAndNil( fMOPQuery );
   FreeAndNil( orderInvoice );
   //
  inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrderTakeMethodOfPaymentForm.FormShow(Sender: TObject);
begin
   MOPItem_Form.db_amount.SetFocus();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrderTakeMethodOfPaymentForm.HandleActionExecute(
  sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SAVE :
      begin
         if (Save) then
         begin
            fCloseAction := actionSave;
            Close();
         end;
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel Method Of Payment', 'Are you sure you want to Cancel this Method Of Payment?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
            Close();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('OrderTakeMethodOfPaymentForm');
      CMD_ESCROW_TAKEPAYMENT :
      begin
         AddEscrowMOP( orderInvoice.Amount_TotalDue, fEscrowCredit,
            orderInvoice.Amount_TotalMOP_Escrow, orderInvoice.Amount_TotalMOP );
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrderTakeMethodOfPaymentForm.HandleActionListUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

procedure tOrderTakeMethodOfPaymentForm.HandleUseEscrow( inLineNum: integer);
begin
   // Do what?
end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
   tMethodOfPaymentTypes = ( PayTypeCash = 1, PayTypeCreditCard = 2, PayTypeCheck = 3, PayTypeCashierCheck = 4,
      PayTypeMoneyOrder = 5, PayTypeDebitCard = 6, PayTypeEscrow = 7 );
}

function tOrderTakeMethodOfPaymentForm.Save: boolean;
var
   errMsg : string;
   oPay : currency;
   amtdue,amtpaid,amtvoid : currency;
begin
   errMsg := '';
   // validate here
   if ( MOPItem_Form.Amount = 0 ) then
      errMsg := 'Amount of payment cannot be 0.00';
   //
   if ( MOPItem_Form.MopType = integer(PayTypeCheck) ) AND ( MOPItem_Form.MopValue = '' ) then
      errMsg := 'Check Number cannot be blank.';
   //
   if ( MOPItem_Form.MopType = integer(PayTypeCashierCheck) ) AND ( MOPItem_Form.MopValue = '' ) then
      errMsg := 'Cashier Check Number cannot be blank.';
   //
   if ( MOPItem_Form.MopType = integer(PayTypeMoneyOrder) ) AND ( MOPItem_Form.MopValue = '' ) then
      errMsg := 'Money Order Number cannot be blank.';

   if ( MOPItem_Form.MopType = integer(PayTypeEscrow )) then
      if ( MOPItem_Form.Amount > fEscrowCredit ) then
         errMsg := 'The total Method Of Payments used Escrow Credit exceeds the total credit available to the ' +
            'Customer.';
   //
   if ( MOPItem_Form.MopType = integer(PayTypePayPal) ) AND ( MOPItem_Form.MopValue = '' ) then
      errMsg := 'PayPal Transaction Number cannot be blank.';
   //
   if (errMsg <> '') then
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);
   //

   if (errMsg = '') then
   begin
   	amtDue := orderInvoice.Amount_Total;
      amtPaid := orderInvoice.Amount_TotalMOP;
      amtVoid := orderInvoice.Amount_VoidNSF;

      amtDue := amtDue - amtPaid;
      amtDue := amtDue + amtVoid;

      if ( MOPItem_Form.Amount > amtDue ) then
      begin

      //   oPay := (MOPItem_Form.Amount + orderInvoice.AmountPaid) - orderInvoice.AmountTotal;
      	oPay := ( MOPItem_Form.Amount - amtDue );
			//
         if AvoBaseDialog('Over Payment', 'You are paying ' + Pref_GetCashSymbol+ FormatCurrency(oPay) + ' over the ' +
            'Invoice amount due.\n\n' +
            'Total Due ' + Pref_GetCashSymbol+ FormatCurrency(amtDue) + '\n\n' +
            'Total Payments ' + Pref_GetCashSymbol+ FormatCurrency(amtPaid) + '\n\n' +
            'Total Voided Payments ' + Pref_GetCashSymbol + FormatCurrency( amtVoid ) + '\n\n' +
            'Take payment anyway?', mtConfirmation, [mbYes, mbNo], 0) = mbNo then
               errMsg := 'NO';
      end;
   end;
   //
   result := (errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tOrderTakeMethodOfPaymentForm.AddEscrowMOP( inAmount_TotalDue, inAmount_AvailEscrow, inAmount_EscrowUsed, inAmount_TotalMOP : currency ) : integer;
var
   selectEscrow : tInvoice_MOP_SelectEscrowForm;
   inLineNum : integer;
   errMsg : string;
   Amount_EscrowLeftAvailable : currency;
   Amount_UsedEscrow : currency;
   Amount_BalanceToPay: currency;
begin
   // First, set it up so that whatever happens, the amount of escrow can't exceed used escrow
   Amount_UsedEscrow := 0;
   Amount_EscrowLeftAvailable := 0;
   Amount_EscrowLeftAvailable := ( inAmount_AvailEscrow - inAmount_EscrowUsed );
   if ( Amount_EscrowLeftAvailable <= 0 ) then
   begin
      AvoBaseDialog('No Available Escrow',
         'While Customer Escrow shows available by Customer Account - current Methods of Payment on ' +
         'this Order use all available Customer Escrow.\n\n' +
         'Note: Escrow is not deducted until an Order is closed.', mtError, [mbOK], 0)
   end else
      begin
         //
         selectEscrow := tInvoice_MOP_SelectEscrowForm.Create( Application, 'Customer Escrow', true, orderInvoice.Customer_SoldToID);
         // fill in the values
         selectEscrow.Amount_TotalEscrowUsed := inAmount_EscrowUsed;
         selectEscrow.Amount_TotalDue := inAmount_TotalDue;
         selectEscrow.Amount_MOP := inAmount_TotalMOP;
         selectEscrow.Amount_TotalAvailEscrow := inAmount_AvailEscrow;
         selectEscrow.Amount := Amount_EscrowLeftAvailable;
         //
         Amount_BalanceToPay := ( inAmount_TotalDue - inAmount_TotalMOP );

         if ( Amount_EscrowLeftAvailable < Amount_BalanceToPay ) then
            Amount_BalanceToPay := Amount_EscrowLeftAvailable;

         selectEscrow.Amount := Amount_BalanceToPay;
         //
         if ( selectEscrow.ValidateData ) then
         begin
            selectEscrow.ShowModal();
            Amount_UsedEscrow := selectEscrow.Amount;
            if ( selectEscrow.FormResult = mrOk ) then
            begin
               if ( Amount_UsedEscrow + inAmount_EscrowUsed >  inAmount_AvailEscrow ) then
               AvoBaseDialog('Amount Exceeds Escrow',
                  'The amount selected exceed the total available Escrow funds (Available + Already Used).', mtError, [mbOK], 0)
               else
               begin
                  MOPItem_Form.Amount := Amount_UsedEscrow;
                  MOPItem_Form.MopType := integer(PayTypeEscrow);
               end;
            end;
         end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
