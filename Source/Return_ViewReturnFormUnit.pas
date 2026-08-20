 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_ViewReturnFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   errorresultunit,
   avobase_toolbarunit,
   masterdata_BaseDataClassUnit,
  recordstructureunit,
   return_invoiceobjectunit,
   avobase_texteditorformunit,
   avobase_percentformunit,
   toolbox_customertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_credittoolboxunit,
   product_selectformunit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   MasterData_ReturnConfirmationListUnit,
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
   tReturnViewReturnForm = class(TForm)
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
    WarningImg: TImage;
    InfoImg: TImage;
    ConfirmImg: TImage;
    BASE_FORM_TOP_PANEL: TPanel;
    BASE_FORM_CAPTION_LABEL: TLabel;
    BASE_LABEL_SEP_PANEL: TPanel;
    GroupBox2: TGroupBox;
    OptionTotalPanel: TPanel;
    InvoiceTotalsPanel: TPanel;
    Panel17: TPanel;
    ShowDiscount: TCheckBox;
    WaveTaxCheckBox: TCheckBox;
    WaveShippingBox: TCheckBox;
    TRANS_DOCK_GRID: TPanel;
    bot_sep_panel: TPanel;
    cust_top_panel: TPanel;
    CustSoldToPhone: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToName: TLabel;
    info_back_panel: TPanel;
    StatusMsg: TLabel;
    SubTotalLabel: TLabel;
    OrderProcLabel: TLabel;
    Amount_Fees: TLabel;
    ShippingLabel: TLabel;
    Amount_Shipping: TLabel;
    SalesTaxLabel: TLabel;
    Amount_Tax: TLabel;
    InvoiceTotalLabel: TLabel;
    Amount_Total: TLabel;
    Panel9: TPanel;
    Amount_SubTotal: TLabel;
    Label3: TLabel;
    amount_void: TLabel;
    AmountDueLabel: TLabel;
    Amount_Due: TLabel;
    Panel1: TPanel;
    procedure YesButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure NoButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
   	iResult : Integer;
   	OrderDetailGrid : tAvoBaseDBGrid;
      OrderDetailQuery : tMasterDataReturnConfirmationList;
  public
   procedure StartForm( inOrderID : string );
   procedure StopForm();
   constructor destroy; overload;
  end;

Function ReturnViewReturn( InHeader, InMsg : String; DlgType:tMsgDlgType; DlgButtons : tMsgDlgButtons; returnInvoice : tReturnInvoice ) : tMsgDlgBtn;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

Function ReturnViewReturn( InHeader, InMsg : String; DlgType:tMsgDlgType; DlgButtons : tMsgDlgButtons; returnInvoice : tReturnInvoice ) : tMsgDlgBtn;
Var
   AvoDialog : tReturnViewReturnForm;
   CustRec : tCustRec;
Const
  Img_Top = 1;
  Img_Left = 1;
  Img_Size = 50;
begin
   AvoDialog := tReturnViewReturnForm.Create(nil);

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
         //
         ShowDiscount.Checked := ReturnInvoice.ShowDiscount;
         WaveTaxCheckBox.Checked := ReturnInvoice.WaveTax;
         WaveShippingBox.Checked := ReturnInvoice.WaveShipping;
         //
         Amount_SubTotal.Caption  := FormatCurrency(ReturnInvoice.Amount_LineItemTotal);
         Amount_Fees.Caption  := FormatCurrency(ReturnInvoice.Amount_FeeTotal);
         Amount_Tax.Caption  := FormatCurrency(ReturnInvoice.Amount_TotalTax);
         Amount_Total.Caption  := FormatCurrency(ReturnInvoice.Amount_Total);
         Amount_Shipping.Caption   := FormatCurrency(ReturnInvoice.Amount_ShippingTotal);
         amount_void.caption := formatcurrency( returninvoice.Amount_TotalPriorVoidNSF );
         Amount_Due.Caption := FormatCurrency(ReturnInvoice.Amount_TotalRefund);
         //
         {
         	OLD: 1/28/2014:
         BASE_FORM_CAPTION_LABEL.Caption := ReturnInvoice.OrgName + ' | ' + ReturnInvoice.Order_GetOrderTypeName + ' # ' +
            ReturnInvoice.Order_GetOrderNumberName + ' | Cycle ' + ReturnInvoice.Cycle_GetCycleName;
            }
         BASE_FORM_CAPTION_LABEL.Caption :=  ReturnInvoice.Order_GetOrderTypeName + ' # ' +
            ReturnInvoice.Order_GetOrderNumberName + ' | Cycle ' + ReturnInvoice.Cycle_GetCycleName + ' | ' +
            ReturnInvoice.OrgName;
         //
         CustRec := Customer_GetCustomerByCustID( ReturnInvoice.CustSoldToID );
         CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
         CustSoldToAddress.Caption := CustRec.ADDR1;
         CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
         if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
            CustSoldToCityStateZip.Caption := '';
         CustSoldToPhone.Caption := CustRec.PHONEH;
       end;

      //
      AvoDialog.StartForm(ReturnInvoice.ID);

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

procedure tReturnViewReturnForm.CancelButtonClick(Sender: TObject);
begin
  Self.iResult := 4;
  Close;
end;

procedure tReturnViewReturnForm.FormKeyPress(Sender: TObject; var Key: Char);
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


procedure tReturnViewReturnForm.NoButtonClick(Sender: TObject);
begin
  Self.iResult := 3;
  Close;
end;

procedure tReturnViewReturnForm.OkButtonClick(Sender: TObject);
begin
  Self.iResult := 2;
  Close;
end;

procedure tReturnViewReturnForm.StartForm( inOrderID : string );
begin
   OrderDetailQuery := tMasterDataReturnConfirmationList.Create( inOrderID );
   //
   OrderDetailGrid := tAvoBaseDBGrid.Create( nil, TRANS_DOCK_GRID, OrderDetailQuery, '' );
   OrderDetailGrid.Clear;
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('LINETYPE'), 'TYPE', 90, clNavy, [fsBold], taLeftJustify);
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('NUM'), 'NUM', 60, clBlack, [], taLeftJustify);
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('RQTY'), 'RQTY', 40, clBlack, [], taRightJustify);
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('NAME'), 'NAME', 180, clBlack, [], taLeftJustify);
   OrderDetailGrid.Add(OrderDetailQuery.FieldByName('TAMT'), 'AMOUNT', 60, clRed, [], taRightJustify);
   //
   orderDetailQuery.Update();
end;

procedure tReturnViewReturnForm.StopForm;
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

constructor tReturnViewReturnForm.destroy;
begin
   inherited destroy;
end;


procedure tReturnViewReturnForm.YesButtonClick(Sender: TObject);
begin
  Self.iResult := 1;
  Close;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



end.


