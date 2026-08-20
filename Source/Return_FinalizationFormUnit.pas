 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_FinalizationFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   ToolBox_PreferenceToolBoxUnit,
  recordstructureunit,
   masterdata_BaseDataClassUnit,
   encryptunit,
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
   TReturn_FinalizationForm = class(TAvoBase_BaseForm_Menu)
    InvoiceTotalsPanel: TPanel;
    SubTotalLabel: TLabel;
    OrderProcLabel: TLabel;
    SalesTaxLabel: TLabel;
    AmountDueLabel: TLabel;
    Amount_SubTotal: TLabel;
    Amount_Fees: TLabel;
    Amount_Tax: TLabel;
    InvoiceTotalLabel: TLabel;
    Amount_Total: TLabel;
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
    Label1: TLabel;
    db_void: TLabel;
   private
      fOrgID : string;
      fCustID : string;
      fOrderNumName : string;
      fCycleID : string;
      fFormType : tFormTypes;
      fFormErrors : string;
      fAmountRefund : currency;
      fAmountShippingSubTotal : currency;
      fAmountTotal : currency;
      fAmountTotalTax : currency;
      fAmountFeeSubTotal : currency;
      fAmountLineItemSubTotal : currency;
      fAmountVoided : currency;
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
      procedure fSetAmountRefund( inVal : currency );
      procedure fSetAmountShippingSubTotal( inVal : currency );
      procedure fSetAmountTotal( inVal : currency );
      procedure fSetAmountTotalTax( inVal : currency );
      procedure fSetAmountFeeSubTotal( inVal : currency );
      procedure fSetAmountLineItemSubTotal( inVal : currency );
      procedure fSetAmountVoided( inVal : currency );
   public
   	property CloseAction : tFormActions read fCloseAction;
      //
      property orgID : string read fOrgID write fSetOrgID;
      property OrderNumName : string read fOrderNumName write fSetfOrderNumName;
      property CycleID : string read fCycleID write fSetCycleID;
      property CustID : string read fCustID write fSetCustID;
      property FormErrors : string read fFormErrors write fFormErrors;
      property AmountRefund : currency read fAmountRefund write fSetAmountRefund;
      property AmountShippingSubTotal : currency read fAmountShippingSubTotal write fSetAmountShippingSubTotal;
      property AmountTotal : currency read fAmountTotal write fSetAmountTotal;
      property AmountTotalTax : currency read fAmountTotalTax write fSetAmountTotalTax;
      property AmountFeeSubTotal : currency read fAmountFeeSubTotal write fSetAmountFeeSubTotal;
      property AmountLineItemSubTotal : currency read fmountLineItemSubTotal write fSetAmountLineItemSubTotal;
      property AmountVoided : currency read fAmountVoided write fSetAmountVoided;

      //
      constructor Create( owner: TComponent; inFormType : tFormTypes ); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReturn_FinalizationForm.Create(owner: TComponent; inFormType : tFormTypes );
begin
	inherited create( owner, 'Return Close/Finalization', True, False);
   //
   fFormType := inFormType;
   //
	StartUpForm();
end;

procedure TReturn_FinalizationForm.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   if ( fFormType = formTypeOk ) then
   begin
      finalImage.Visible := true;
      errorImage.Visible := false;
      finalImage.Top := 133;
      finalImage.Left := 31;
      CreateButton( CMD_NO );
      CreateButton( CMD_YES );
   end else
      begin
         CreateButton( CMD_OK );
         errorImage.Visible := true;
         finalImage.Visible := false;
         errorImage.Top := 133;
         errorImage.Left := 31;
      end;
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturn_FinalizationForm.fSetAmountRefund(inVal: currency);
begin
   fAmountRefund := inVal;
   Recalculate();

end;

procedure TReturn_FinalizationForm.fSetAmountFeeSubTotal(inVal: currency);
begin
   fAmountFeeSubTotal := inVal;
   Recalculate();

end;

procedure TReturn_FinalizationForm.fSetAmountLineItemSubTotal(
  inVal: currency);
begin

   fAmountLineItemSubTotal := inVal;
   Recalculate();
end;

procedure TReturn_FinalizationForm.fSetAmountShippingSubTotal(
  inVal: currency);
begin
   fAmountShippingSubTotal := inVal;
   Recalculate();

end;

procedure TReturn_FinalizationForm.fSetAmountTotal(inVal: currency);
begin
   fAmountTotal := inVal;
   Recalculate();

end;

procedure TReturn_FinalizationForm.fSetAmountTotalTax(inVal: currency);
begin
   fAmountTotalTax := inVal;
   Recalculate();

end;

procedure TReturn_FinalizationForm.fSetAmountVoided(inVal: currency);
begin
   fAmountVoided := inVal;
   Recalculate();
end;

procedure TReturn_FinalizationForm.fSetCustID(inVal: string);
begin
   fCustID := inVal;
   Recalculate();
end;

procedure TReturn_FinalizationForm.fSetCycleID(inVal: string);
begin
   fCycleID := inVal;
   Recalculate();
end;

procedure TReturn_FinalizationForm.fSetfOrderNumName(inVal: string);
begin
   fOrderNumName := inVal;
   Recalculate();
end;

procedure TReturn_FinalizationForm.fSetOrgID(inVal: string);
begin
   fOrgID := inVal;
   Recalculate();
end;

procedure TReturn_FinalizationForm.HandleActionExecute(sender: tObject; actionID: integer);
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
   end;
end;

procedure TReturn_FinalizationForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
   // this form has nothing to do with any datasets, tables, etc. so we always set everything true.
   handled := true;
end;

procedure TReturn_FinalizationForm.ReCalculate;
var
   custRec : tCustRec;
begin
   BASE_FORM_CAPTION_LABEL.Caption := 'Return Finalization ' +
      ' | ' + Org_GetOrgNameByOrgID( fOrgID ) + ' Return # ' + fOrderNumName +
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
      finalizeLabel.Caption := 'Closing and Finalizing an Return will mark the Return as "Closed". No further changes will ' +
         'be allowed to the Return.' + #13 + #13 +
         'Please confirm that you are ready to Close and Finalize this Return.'
   else
      finalizeLabel.Caption := 'There are issues with this Return preventing it from closing.' + #13 + #13 +
         fFormErrors;
   //
   //
   Amount_SubTotal.Caption  := FormatCurrency(fAmountLineItemSubTotal);
   Amount_Fees.Caption  := FormatCurrency(fAmountFeeSubTotal);
   Amount_Tax.Caption  := FormatCurrency(fAmountTotalTax);
   Amount_Total.Caption  := FormatCurrency(fAmountTotal);
   Amount_Shipping.Caption   := FormatCurrency(fAmountShippingSubTotal);
   db_void.caption := FormatCurrency(fAmountVoided);
   //
   AmountDueLabel.Caption := 'REFUND DUE:';
   AmountDueLabel.Font.Color := clBlue;
   Amount_Due.Font.Color := clBlue;
   Amount_Due.Caption := FormatCurrency(fAmountRefund);
end;

end.



