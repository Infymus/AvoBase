 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Payment_SelectPaymentFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
  recordstructureunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   AvoBase_ToolBarUnit,
   AvoBase_BaseForm_SelectUnit,
   MasterData_PaymentListUnit,
   toolbox_customertoolboxunit,
   order_invoiceobjectunit,
   toolbox_ordertoolboxunit,
   avobase_dialogformunit,
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
   dbgrids,
   grids,
   Mask,
   DB,
   jpeg;

type
  TPayment_SelectPaymentForm = class(TAvoBase_BaseForm_Select)
    OrdPurchLabel: TLabel;
    CustSoldToName: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToPhone: TLabel;
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
    bot_warning_panel: TPanel;
    voidWarningLabel: TLabel;
    Label1: TLabel;
    db_void: TLabel;
   private
      fOrderID : string;
      fLoadOrderEvent : tLoadOrderEvent;
      MOPDetailListQuery : tMasterDataPaymentList;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure HandleDoubleClick( sender : tObject );
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn; State: TGridDrawState);
      function fGetMOPID : string;
      function CanSelect : boolean;
   public
      procedure StartUpForm();
      procedure UpdateQuery();
      procedure StatBarUpdate();
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OrderID : string read fOrderID;
      property MOPID : string read fGetMOPID;
      constructor Create( owner: TComponent; inOrderID : string; InCaption : string; isTopBarVisble : boolean); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
         retVal := masterData.AddTable(masterData.dbPath + table_mop,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY INTEGER, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'MOPCCT INTEGER, ' + // credit card type ( see tCreditCardTypes );
            'MOP_REV BOOLEAN, ' + // payment reversed?
            'AMOUNT MONEY',
}

constructor TPayment_SelectPaymentForm.Create(owner: TComponent; inOrderID : string; InCaption: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   fOrderID := inOrderID;
   //
   MOPDetailListQuery := tMasterDataPaymentList.Create( masterData);
   //
   dataListGrid.Init( MOPDetailListQuery, '');
   gridDataSource.DataSet := MOPDetailListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   dataListGrid.Clear;
   //
   DataListGrid.Add(MOPDetailListQuery.FieldByName('ONUM'), 'ORDER #', 60, clBlack, [fsBold], tarightJustify);
   DataListGrid.Add(MOPDetailListQuery.FieldByName('MOPDATE'), 'PAYMENT DATE', 90, clTeal, [], taRightJustify);
   DataListGrid.Add(MOPDetailListQuery.FieldByName('PTYPE'), 'PAYMENT TYPE', 120, clTeal, [], taRightJustify);
   DataListGrid.Add(MOPDetailListQuery.FieldByName('AMOUNT'), 'PAID', 60, clBlue, [], taRightJustify);
   DataListGrid.Add(MOPDetailListQuery.FieldByName('PSTAT'), 'STATUS', 90, clTeal, [], taLeftJustify);
   //
   dataListGrid.OnDblClick := HandleDoubleClick;
   dataListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;

   //
   dbNavTool.Init( MOPDetailListQuery );
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
	StartUpForm();
   StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_SelectPaymentForm.StartUpForm;
var
   CustRec : tCustRec;
   orderInvoice : tInvoice;
begin
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Select Payment to Void for Order # ' + Order_GetOrderNumberByOrderID( fOrderID );
   //
   orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
   orderInvoice.Load( fOrderID );
   //
   Amount_SubTotal.Caption  := FormatCurrency(orderInvoice.Amount_LineItemTotal);
   Amount_Fees.Caption  := FormatCurrency(orderInvoice.Amount_FeeTotal);
   Amount_Tax.Caption  := FormatCurrency(orderInvoice.Amount_TotalTax);
   Amount_Total.Caption  := FormatCurrency(orderInvoice.Amount_Total);
   Amount_MOP.Caption  := FormatCurrency(orderInvoice.Amount_TotalMOP);
   Amount_Shipping.Caption   := FormatCurrency(orderInvoice.Amount_ShippingSubTotal);
   db_void.caption   := FormatCurrency(orderInvoice.Amount_VoidNSF);
   //
   if (orderInvoice.Amount_TotalDue > 0) then
   begin
      AmountDueLabel.Caption := 'AMOUNT OWED:';
      AmountDueLabel.Font.Color := clRed;
      Amount_Due.Font.COlor := clRed;
      Amount_Due.Caption := FormatCurrency(orderInvoice.Amount_TotalDue);
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
   //
   CustRec := Customer_GetCustomerByCustID( orderInvoice.Customer_SoldToID );
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
   //
   FreeAndNil(orderInvoice);
   //
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPayment_SelectPaymentForm.fGetMOPID: string;
begin
   result := MOPDetailListQuery.FieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPayment_SelectPaymentForm.CanSelect : boolean;
begin
   result := true;
	if (MOPDetailListQuery.FieldByName('MOP_REV').AsBoolean) then
   begin
      result := false;
      AvoBaseDialog('Unable to Void Payment', 'Payment Selected has already been Voided.',
         mtError, [mbOk], 0);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_SelectPaymentForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_SELECT_OK :
      begin
         if (CanSelect) then
         begin
            fFormEvent := mrOk;
            Close();
         end;
      end;
      CMD_SELECT_CANCEL :
      begin
         fFormEvent := mrCancel;
         Close();
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_SelectPaymentForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case tag of
         CMD_SELECT_OK :
         begin
            case MOPDetailListQuery.FieldByName('MOPTYPE').AsInteger of
               integer(PayTypeCash) : enabled := false;
               integer(PayTypeCreditCard) : enabled := true;
               integer(PayTypeCheck) : enabled := true;
               integer(PayTypeCashierCheck) : enabled := true;
               integer(PayTypeMoneyOrder) : enabled := true;
               integer(PayTypeDebitCard) : enabled := true;
               integer(PayTypeEscrow) : enabled := false;
            end;
            //
            if ( MOPDetailListQuery.RecordCount = 0) then
               enabled := false;
         end;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_SelectPaymentForm.HandleDoubleClick(sender: tObject);
begin
   fFormEvent := mrOk;
   Close();
end;

procedure TPayment_SelectPaymentForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
   // if the row has already been reversed, then we grey it out
	if (MOPDetailListQuery.FieldByName('MOP_REV').AsBoolean) then
   begin
      dataListGrid.Canvas.Font.Color := clGrayText;
      dataListGrid.Canvas.Font.Style := [fsItalic];
      dataListGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_SelectPaymentForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_SelectPaymentForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(MOPDetailListQuery.RecNo) + ' of ' + IntToStr(MOPDetailListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_SelectPaymentForm.UpdateQuery;
begin
   MOPDetailListQuery.UpdateStatus( fOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
