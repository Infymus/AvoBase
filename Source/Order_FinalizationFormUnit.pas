 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Order_FinalizationFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
  recordstructureunit,
   avobase_dialogformunit,
   ToolBox_PreferenceToolBoxUnit,
   masterdata_BaseDataClassUnit,
   encryptunit,
   AvoBase_HelpFormUnit,
   //
   toolbox_orgtoolboxunit,
   toolbox_cycletoolboxunit,
   toolbox_customertoolboxunit,
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
   tOrder_FinalizationForm = class(TAvoBase_BaseForm_Menu)
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
    OrdPurchLabel: TLabel;
    finalImage: TImage;
    finalizeLabel: TLabel;
    errorImage: TImage;
    imgAvoIcon: TImage;
    imgAvoName: TImage;
   private
      fOrgID : string;
      fCustID : string;
      fOrderNumName : string;
      fCycleID : string;
      fFormType : tFormTypes;
      fFormErrors : string;
      fAmountOverPaid : currency;
      fAmountDue : currency;
      fAmountPaid : currency;
      fAmountShippingSubTotal : currency;
      fAmountTotal : currency;
      fAmountTotalTax : currency;
      fAmountFeeSubTotal : currency;
      fAmountLineItemSubTotal : currency;
      //
   	fCloseAction : tFormActions;
    fmountLineItemSubTotal: currency;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure StartUpForm();
      procedure ReCalculate;
      //
      procedure fSetOrgID( inVal : string );
      procedure fSetfOrderNumName( inVal : string );
      procedure fSetCycleID( inVal : string );
      procedure fSetCustID( inVal : string );
      procedure fSetAmountOverPaid( inVal : currency );
      procedure fSetAmountDue( inVal : currency );
      procedure fSetAmountPaid( inVal : currency );
      procedure fSetAmountShippingSubTotal( inVal : currency );
      procedure fSetAmountTotal( inVal : currency );
      procedure fSetAmountTotalTax( inVal : currency );
      procedure fSetAmountFeeSubTotal( inVal : currency );
      procedure fSetAmountLineItemSubTotal( inVal : currency );
      procedure fSetFormErrors( inVal : string );

   public
   	property CloseAction : tFormActions read fCloseAction;
      //
      property orgID : string read fOrgID write fSetOrgID;
      property OrderNumName : string read fOrderNumName write fSetfOrderNumName;
      property CycleID : string read fCycleID write fSetCycleID;
      property CustID : string read fCustID write fSetCustID;
      property FormErrors : string read fFormErrors write fSetFormErrors;
      property AmountOverPaid : currency read fAmountOverPaid write fSetAmountOverPaid;
      property AmountDue : currency read fAmountDue write fSetAmountDue;
      property AmountPaid : currency read fAmountPaid write fSetAmountPaid;
      property AmountShippingSubTotal : currency read fAmountShippingSubTotal write fSetAmountShippingSubTotal;
      property AmountTotal : currency read fAmountTotal write fSetAmountTotal;
      property AmountTotalTax : currency read fAmountTotalTax write fSetAmountTotalTax;
      property AmountFeeSubTotal : currency read fAmountFeeSubTotal write fSetAmountFeeSubTotal;
      property AmountLineItemSubTotal : currency read fmountLineItemSubTotal write fSetAmountLineItemSubTotal;

      //
      constructor Create( owner: TComponent; inFormType : tFormTypes ); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tOrder_FinalizationForm.Create(owner: TComponent; inFormType : tFormTypes );
begin
	inherited create( owner, 'Order Close/Finalization', True, False);
   //
   fFormType := inFormType;
   //
	StartUpForm();
end;

procedure tOrder_FinalizationForm.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   StatusBar.Visible := false;
   if ( fFormType = formTypeOk ) then
      begin
      finalImage.Visible := true;
      errorImage.Visible := false;
      finalImage.Top := 122;
      finalImage.Left := 39;
      CreateButton( CMD_HELP );
      CreateButtonSep();
      CreateButton( CMD_NO );
      CreateButton( CMD_YES );
      ToolBar.Width := 35*3;
      TooLBar.Repaint();
   end else
      begin
         CreateButton( CMD_OK );
         errorImage.Visible := true;
         finalImage.Visible := false;
         errorImage.Top := 122;
         errorImage.Left := 39;
         ToolBar.Width := 35;
         TooLBar.Repaint();
      end;
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrder_FinalizationForm.fSetAmountOverPaid(inVal: currency);
begin
   fAmountOverPaid := inVal;
   Recalculate();
end;

procedure tOrder_FinalizationForm.fSetAmountDue(inVal: currency);
begin
   fAmountDue := inVal;
   Recalculate();

end;

procedure tOrder_FinalizationForm.fSetAmountFeeSubTotal(inVal: currency);
begin
   fAmountFeeSubTotal := inVal;
   Recalculate();

end;

procedure tOrder_FinalizationForm.fSetAmountLineItemSubTotal(
  inVal: currency);
begin

   fAmountLineItemSubTotal := inVal;
   Recalculate();
end;

procedure tOrder_FinalizationForm.fSetAmountPaid(inVal: currency);
begin

   fAmountPaid := inVal;
   Recalculate();
end;

procedure tOrder_FinalizationForm.fSetAmountShippingSubTotal(
  inVal: currency);
begin
   fAmountShippingSubTotal := inVal;
   Recalculate();

end;

procedure tOrder_FinalizationForm.fSetAmountTotal(inVal: currency);
begin
   fAmountTotal := inVal;
   Recalculate();

end;

procedure tOrder_FinalizationForm.fSetAmountTotalTax(inVal: currency);
begin
   fAmountTotalTax := inVal;
   Recalculate();

end;

procedure tOrder_FinalizationForm.fSetCustID(inVal: string);
begin
   fCustID := inVal;
   Recalculate();
end;

procedure tOrder_FinalizationForm.fSetCycleID(inVal: string);
begin
   fCycleID := inVal;
   Recalculate();
end;

procedure tOrder_FinalizationForm.fSetfOrderNumName(inVal: string);
begin
   fOrderNumName := inVal;
   Recalculate();
end;

procedure tOrder_FinalizationForm.fSetFormErrors(inVal: string);
var
   strCnt : integer;
begin
   fFormErrors := inVal;
   while POS('\n', fFormErrors) > 0 do
   begin
      strCnt := POS('\n', fFormErrors);
      delete( fFormErrors, strCnt, 2);
      insert( #13, fFormErrors, strCnt );
   end;
end;

procedure tOrder_FinalizationForm.fSetOrgID(inVal: string);
begin
   fOrgID := inVal;
   Recalculate();
end;

procedure tOrder_FinalizationForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_OK:
      begin
         fCloseAction := actionOk;
         Close();
      end;
      CMD_YES :
      begin
         fCloseAction := actionConfirm;
         Close();
      end;
      CMD_NO :
      begin
         fCloseAction := actionCancel;
         Close();
      end;
      CMD_HELP : AvoBaseHelp_Execute('Order_FinalizationForm');
   end;
end;

procedure tOrder_FinalizationForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
   // this form has nothing to do with any datasets, tables, etc. so we always set everything true.
   handled := true;
end;

procedure tOrder_FinalizationForm.ReCalculate;
var
   custRec : tCustRec;
begin
   BASE_FORM_CAPTION_LABEL.Caption := 'Order Finalization ' +
      ' | ' + Org_GetOrgNameByOrgID( fOrgID ) + ' Order # ' + fOrderNumName +
      ' | Cycle ' + Cycle_GetCycleNameByCycleID( fCycleID );
   //
   CustRec := Customer_GetCustomerByCustID( fCustID );
   //
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
   //
   if ( fFormType = formTypeOk ) then
      finalizeLabel.Caption := 'Closing and Finalizing an Order will mark the Order as "Closed". No further changes will ' +
         'be allowed to the Order. All Line-Items marked as Back-Ordered will need to be managed through the Back-Order Manager.' + #13 + #13 +
         'Please confirm that you are ready to Close and Finalize this Order.'
   else
      finalizeLabel.Caption := 'THE FOLLOWING PREVENTS THIS ORDER FROM CLOSING:' + #13 + #13 + fFormErrors;
   //
   //
   Amount_SubTotal.Caption  := FormatCurrency(fAmountLineItemSubTotal);
   Amount_Fees.Caption  := FormatCurrency(fAmountFeeSubTotal);
   Amount_Tax.Caption  := FormatCurrency(fAmountTotalTax);
   Amount_Total.Caption  := FormatCurrency(fAmountTotal);
   Amount_MOP.Caption  := FormatCurrency(fAmountPaid);
   Amount_Shipping.Caption   := FormatCurrency(fAmountShippingSubTotal);
   //
   if (fAmountDue > 0) then
   begin
      AmountDueLabel.Caption := 'AMOUNT OWED:';
      AmountDueLabel.Font.Color := clRed;
      Amount_Due.Font.COlor := clRed;
      Amount_Due.Caption := FormatCurrency(fAmountDue);
   end;
   if (fAmountDue = 0) then
   begin
      AmountDueLabel.Caption := 'BALANCE:';
      AmountDueLabel.Font.Color := clBlack;
      Amount_Due.Font.COlor := clBlack;
      Amount_Due.Caption := FormatCurrency(fAmountDue);
   end;
   if (fAmountOverPaid > 0) then
   begin
      AmountDueLabel.Caption := 'CHANGE DUE:';
      AmountDueLabel.Font.Color := clBlue;
      Amount_Due.Font.Color := clBlue;
      Amount_Due.Caption := FormatCurrency(fAmountOverPaid);
   end;
end;

end.



