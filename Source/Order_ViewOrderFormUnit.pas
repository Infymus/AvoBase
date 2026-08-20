 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


 {

the purpose of this form is to view an order by passing an invoiceobject to it. it does not contain any kind
of datasource object nor queries. it just displays all of the information about the order for verification of
said invoice - like for finalization, cancellation, uncancellation and that sort of thing. it should never
be used with an invoice that is already open, only used with an invoice that is a type of report.

}

unit Order_ViewOrderFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   errorresultunit,
  recordstructureunit,
   avobase_toolbarunit,
   masterdata_BaseDataClassUnit,
   order_invoiceobjectunit,
   avobase_texteditorformunit,
   avobase_percentformunit,
   toolbox_customertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_credittoolboxunit,
   product_selectformunit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   MasterData_OrderConfirmationListUnit,
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
   Themes,
   stdctrls,
   extctrls,
   ComCtrls,
   ToolWin,
   Mask,
   Buttons,
   Grids,
   DBGrids;

type
   tOrderViewOrderForm = class(TForm)
      BackPanel: TPanel;
      BOT_PANEL: TPanel;
      imgAvoName: TImage;
      imgAvoIcon: TImage;
      MOPButtonBar: TToolBar;
      YesButton: TToolButton;
      OkButton: TToolButton;
      NoButton: TToolButton;
    CancelButton: TToolButton;
    STATUS_MESSAGE_BACK_PANEL: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    HeaderLabel: TLabel;
    ErrorImg: TImage;
    BASE_FORM_TOP_PANEL: TPanel;
    BASE_FORM_CAPTION_LABEL: TLabel;
    BASE_LABEL_SEP_PANEL: TPanel;
    WarningImg: TImage;
    InfoImg: TImage;
    ConfirmImg: TImage;
    GroupBox2: TGroupBox;
    info_back_panel: TPanel;
    StatusMsg: TLabel;
    OptionTotalPanel: TPanel;
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
    Panel17: TPanel;
    ShowDiscount: TCheckBox;
    WaveTaxCheckBox: TCheckBox;
    WaveShippingBox: TCheckBox;
    WaveShippingTaxBox: TCheckBox;
    TRANS_DOCK_GRID: TPanel;
    bot_sep_panel: TPanel;
    cust_top_panel: TPanel;
    CustSoldToPhone: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToName: TLabel;
    Label1: TLabel;
    db_voided: TLabel;
    procedure YesButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure NoButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
   	iResult : Integer;
   	OrderDetailGrid : tAvoBaseDBGrid;
      OrderDetailQuery : tMasterDataOrderConfirmationList;
  public
   procedure StartForm( inOrderID : string );
   procedure StopForm();
   constructor destroy; overload;
  end;

Function OrderViewOrder( InHeader, InMsg : String; DlgType:tMsgDlgType; DlgButtons : tMsgDlgButtons; invoiceObj : tInvoice ) : tMsgDlgBtn;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

Function OrderViewOrder( InHeader, InMsg : String; DlgType:tMsgDlgType; DlgButtons : tMsgDlgButtons; invoiceObj : tInvoice ) : tMsgDlgBtn;
Var
   AvoDialog : TOrderViewOrderForm;
   CustRec : tCustRec;
Const
  Img_Top = 1;
  Img_Left = 1;
  Img_Size = 50;
begin
   AvoDialog := TOrderViewOrderForm.Create(nil);

   try
      AvoDialog.iResult := 0;
      //
      with AvoDialog do
      begin
         // set the Dialog
         AvoDialog.ErrorImg.Visible := False;
         AvoDialog.WarningImg.Visible := False;
         AvoDialog.InfoImg.Visible := False;
         AvoDialog.ConfirmImg.Visible := False;
         Case DlgType of
            mtWarning :
            begin
               AvoDialog.WarningImg.Visible := True;
               AvoDialog.WarningImg.Top := Img_Top;
               AvoDialog.WarningImg.Left := Img_Left;
               AvoDialog.WarningImg.Width := Img_Size;
               AvoDialog.WarningImg.Height := Img_Size;
            end;
            mtError :
            begin
               AvoDialog.ErrorImg.Visible := True;
               AvoDialog.ErrorImg.Top := Img_Top;
               AvoDialog.ErrorImg.Left := Img_Left;
               AvoDialog.ErrorImg.Width := Img_Size;
               AvoDialog.ErrorImg.Height := Img_Size;
            end;
            mtInformation :
            begin
               AvoDialog.InfoImg.Visible := True;
               AvoDialog.InfoImg.Top := Img_Top;
               AvoDialog.InfoImg.Left := Img_Left;
               AvoDialog.InfoImg.Width := Img_Size;
               AvoDialog.InfoImg.Height := Img_Size;
            end;
            mtConfirmation :
            begin
               AvoDialog.ConfirmImg.Visible := True;
               AvoDialog.ConfirmImg.Top := Img_Top;
               AvoDialog.ConfirmImg.Left := Img_Left;
               AvoDialog.ConfirmImg.Width := Img_Size;
               AvoDialog.ConfirmImg.Height := Img_Size;
            end;
         end;
         Amount_SubTotal.Caption  := FormatCurrency(invoiceObj.Amount_LineItemTotal);
         Amount_Fees.Caption  := FormatCurrency(invoiceObj.Amount_FeeTotal);
         Amount_Tax.Caption  := FormatCurrency(invoiceObj.Amount_TotalTax);
         Amount_Total.Caption  := FormatCurrency(invoiceObj.Amount_Total);
         Amount_MOP.Caption  := FormatCurrency(invoiceObj.Amount_TotalMOP);
         Amount_Shipping.Caption   := FormatCurrency(invoiceObj.Amount_ShippingSubTotal);
         db_voided.Caption := FormatCurrency(invoiceObj.Amount_VoidNSF);
         //
         if (invoiceObj.Amount_TotalDue > 0) then
         begin
            AmountDueLabel.Caption := 'AMOUNT OWED:';
            AmountDueLabel.Font.Color := clRed;
            Amount_Due.Font.COlor := clRed;
            Amount_Due.Caption := FormatCurrency(invoiceObj.Amount_TotalDue);
         end;
         if (invoiceObj.Amount_TotalDue = 0) then
         begin
            AmountDueLabel.Caption := 'BALANCE:';
            AmountDueLabel.Font.Color := clBlack;
            Amount_Due.Font.COlor := clBlack;
            Amount_Due.Caption := FormatCurrency(invoiceObj.Amount_TotalDue);
         end;
         if (invoiceObj.Amount_OverPaid > 0) then
         begin
            AmountDueLabel.Caption := 'CHANGE DUE:';
            AmountDueLabel.Font.Color := clBlue;
            Amount_Due.Font.Color := clBlue;
            Amount_Due.Caption := FormatCurrency(invoiceObj.Amount_OverPaid);
         end;
         //
         BASE_FORM_CAPTION_LABEL.Caption := invoiceObj.Org_GetOrgName + ' | ' + invoiceObj.Order_GetOrderTypeName + ' # ' +
            invoiceObj.Order_GetOrderNumberName + ' | Cycle ' + invoiceObj.Cycle_GetCycleName;
         //
         CustRec := Customer_GetCustomerByCustID( invoiceObj.Customer_SoldToID );
         CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
         CustSoldToAddress.Caption := CustRec.ADDR1;
         CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
         if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
            CustSoldToCityStateZip.Caption := '';
         CustSoldToPhone.Caption := CustRec.PHONEH;
       end;

      AvoDialog.StartForm(invoiceObj.Order_ID);

      // Turn On Whatever Buttons Are Necessary
      if (mbYes in DlgButtons) then
         AvoDialog.YesButton.Visible := True
      else
         AvoDialog.YesButton.Visible := False;
      if (mbNo in DlgButtons) then
         AvoDialog.NoButton.Visible := True
      else
         AvoDialog.NoButton.Visible := False;
      if (mbCancel in DlgButtons) then
         AvoDialog.CancelButton.Visible := True
      else
         AvoDialog.CancelButton.Visible := False;
      if (mbOK in DlgButtons) then
         AvoDialog.OkButton.Visible := True
      else
         AvoDialog.OkButton.Visible := False;

      // Header
      AvoDialog.HeaderLabel.Caption := InHeader;

      // Display the Message in the Caption
      AvoDialog.StatusMsg.WordWrap := False;
      AvoDialog.StatusMsg.Caption := InMsg;
      AvoDialog.StatusMsg.WordWrap := True;

      // Show the Form
      AvoDialog.ShowModal;

      // Figure Out the Result of the Modal
      if ( AvoDialog.iResult = 1 ) then
         Result := mbYes;
      if ( AvoDialog.iResult = 3 ) then
         Result := mbNo;
      if ( AvoDialog.iResult = 2 ) then
         Result := mbOk;
      if ( AvoDialog.iResult = 4 ) then
         Result := mbCancel;

   // Free And Go Away
   Finally
      AvoDialog.StopForm();
      FreeAndNil(AvoDialog);
   end;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TOrderViewOrderForm.CancelButtonClick(Sender: TObject);
begin
  Self.iResult := 4;
  Close;
end;

procedure TOrderViewOrderForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  X : Integer;
begin
  x := Ord(KEY);
  case ORD(KEY) of
    { YES }
    89,121:
    begin
      Self.iResult := 1;
      Close;
    end;
    { NO }
    78,110:
    begin
      Self.iResult := 3;
      Close;
    end;
    { CANCEL }
    67,99:
    begin
      Self.iResult := 4;
      Close;
    end;
    { OK }
    79,111,13:
    begin
      Self.iResult := 2;
      Close;
    end;
  end;
end;

procedure TOrderViewOrderForm.NoButtonClick(Sender: TObject);
begin
  Self.iResult := 3;
  Close;
end;

procedure TOrderViewOrderForm.OkButtonClick(Sender: TObject);
begin
  Self.iResult := 2;
  Close;
end;

procedure TOrderViewOrderForm.StartForm( inOrderID : string );
begin
   OrderDetailQuery := tMasterDataOrderConfirmationList.Create( inOrderID );
   //
   OrderDetailGrid := tAvoBaseDBGrid.Create( nil, TRANS_DOCK_GRID, OrderDetailQuery, '' );
   OrderDetailGrid.Clear;
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('LINETYPE'), 'TYPE', 90, clNavy, [fsBold], taLeftJustify);
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('NUM'), 'NUM', 60, clBlack, [], taLeftJustify);
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('SQTY'), 'QTY', 40, clBlack, [], taRightJustify);
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('NAME'), 'NAME', 180, clBlack, [], taLeftJustify);
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('TAMT'), 'AMOUNT', 60, clRed, [], taRightJustify);
   //
   orderDetailQuery.Update();
end;

procedure TOrderViewOrderForm.StopForm;
begin
   FreeAndNil( OrderDetailGrid );
   FreeAndNil( OrderDetailQuery );
end;

{

      errResult := masterData.AddTable(masterData.dbPath + table_cust_account,
         'ID VARCHAR(40), ' + // simple ID
         'NAME VARCHAR(40), ' + // name
         'NUM VARCHAR(40), ' + // number
         'QTY, ' + // Quantity
         'TTYPE INTEGER, ' + // 1 = Line Item | 2 = Fee
         'TAMT MONEY', // transaction amount

}

constructor TOrderViewOrderForm.destroy;
begin
   inherited destroy;
end;


procedure TOrderViewOrderForm.YesButtonClick(Sender: TObject);
begin
  Self.iResult := 1;
  Close;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.


