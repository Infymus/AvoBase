 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_EditFormUnit;

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
   masterdata_BaseDataClassUnit,
   Return_InvoiceObjectUnit,
   avobase_texteditorformunit,
   avobase_percentformunit,
   Toolbox_PreferenceToolBoxUnit,
   toolbox_customertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_credittoolboxunit,
   product_selectformunit,
   AvoBase_HelpFormUnit,
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
   Buttons;

type
	tReturnEditForm = class(TAvoBase_BaseForm_Menu)
    ORDER_NOTEBOOK: TNotebook;
    MESSAGE_BACK_PANEL: TPanel;
    TOP_SEP_PANEL: TPanel;
    INVOICE_LINEITEMS_BACK_PANEL: TPanel;
    CUST_BACK_PANEL: TPanel;
    FEE_BACK_PANEL: TPanel;
    FEE_DOCK: TScrollBox;
    BOTTOM_TOTAL_PANEL: TPanel;
    OptionTotalPanel: TPanel;
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
    Panel9: TPanel;
    Panel17: TPanel;
    ShippingLabel: TLabel;
    Amount_Shipping: TLabel;
    FeeToolBar: TToolBar;
    AddBlankFeeLineBtn: TToolButton;
    AddFeeLineBtn: TToolButton;
    DeleteFeeLineBtn: TToolButton;
    GroupBox1: TGroupBox;
    ShowDiscount: TCheckBox;
    WaveTaxCheckBox: TCheckBox;
    WaveShippingBox: TCheckBox;
    LINE_ITEM_DOCK: TScrollBox;
    PREF_TOP_BACK_PANEL: TPanel;
    PREF_HEADER_BACK_PANEL: TPanel;
    PREF_HEADER_LABEL: TLabel;
    Image1: TImage;
    Panel4: TPanel;
    Panel10: TPanel;
    Label2: TLabel;
    Image3: TImage;
    Panel7: TPanel;
    Panel8: TPanel;
    Label4: TLabel;
    Image5: TImage;
    CustSoldToPhone: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToName: TLabel;
    OrdPurchLabel: TLabel;
    Label3: TLabel;
    amount_void: TLabel;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    db_refundshipping: TCheckBox;
    returnAllLineItemsCheck: TCheckBox;
    returnAllFeeItemsCheck: TCheckBox;
    PRIOR_ORDER_LABEL: TLabel;
    Panel2: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    Image2: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LineItemToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
    procedure WaveTaxCheckBoxClick(Sender: TObject);
    procedure DeleteLineItemBtnClick(Sender: TObject);
    procedure AddCustSoldToButtonClick(Sender: TObject);
    procedure AddCustShipToButtonClick(Sender: TObject);
    procedure ClearCustSoldToButtonClick(Sender: TObject);
    procedure ClearCustShipToButtonClick(Sender: TObject);
    procedure AddBlankFeeLineBtnClick(Sender: TObject);
    procedure AddFeeLineBtnClick(Sender: TObject);
    procedure DeleteFeeLineBtnClick(Sender: TObject);
    procedure WaveShippingBoxClick(Sender: TObject);
    procedure WaveShippingTaxBoxClick(Sender: TObject);
    procedure ShowDiscountClick(Sender: TObject);
    procedure db_refundshippingClick(Sender: TObject);
    procedure returnAllLineItemsCheckClick(Sender: TObject);
    procedure InvoiceTotalsPanelClick(Sender: TObject);
    procedure returnAllFeeItemsCheckClick(Sender: TObject);
   private
      fCreditImage : boolean;
      eInvoiceUpdatedEvent : tInvoiceUpdatedEvent;
   	fOrderID : string;
      TextEditor : tAvoBaseTextEditor;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fViewInvoiceClosed : tViewInvoiceClosed;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
		procedure HandleRecalculateInvoice;
      procedure HandleInvoiceUpdated;
   	procedure StartUpForm();
      procedure SetOrderFormCaption();
      procedure fSetImsg( inValue : string );
      procedure fSetCreditImage( inVal : boolean );
      //
      function fGetImsg : string;
      function fGetOrderID : string;
      function fGetOrderNumber : integer;
      function fGetPriorOrderID : string;
   public
      ReturnInvoice : tReturnInvoice;
      //
      procedure Cancel;
      property OrderID : string read fGetOrderId;
      property PriorOrderID : string read fGetPriorOrderID;
      property InvoiceMessage : string read fGetImsg write fSetImsg;
      property OrderNumber : integer read fGetOrderNumber;
      procedure Save;
      procedure Finalize;
      procedure RecalculateInvoice;
      property CreditImage : boolean read fCreditImage write fSetCreditImage;
      // Events
      property OnViewInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OnInvoiceUpdated : tInvoiceUpdatedEvent read eInvoiceUpdatedEvent write eInvoiceUpdatedEvent;
      property OnFinalizeViewPrint : tViewInvoiceClosed read fViewInvoiceClosed write fViewInvoiceClosed;
      //
      constructor create; overload;
      destructor Destroy; override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tReturnEditForm.Create;
begin
	// Do the inherited create
	inherited create( nil, '', true, false);
   //
   // Setup some things we need by default

   // Create the invoice
   ReturnInvoice := tReturnInvoice.Create( InvoiceTypeOrder, LINE_ITEM_DOCK, FEE_DOCK );

   LINE_ITEM_DOCK.Visible := False;
   LINE_ITEM_DOCK.Realign;
   LINE_ITEM_DOCK.Perform(WM_VSCROLL, SB_BOTTOM, 0);
   LINE_ITEM_DOCK.Visible := True;

   // Set up all the Events for recalculation, etc.
   ReturnInvoice.OnRecalculateInvoiceEvent := HandleRecalculateInvoice;
   ReturnInvoice.OnInvoiceUpdated := HandleInvoiceUpdated;
   //
   StartUpForm();
   RecalculateInvoice();
end;

procedure tReturnEditForm.db_refundshippingClick(Sender: TObject);
begin
   ReturnInvoice.RefundShipping := db_refundshipping.Checked;
   RecalculateInvoice();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

destructor tReturnEditForm.Destroy;
begin
	FreeAndNil(TextEditor);
{
This shit aint gonna work. gotta find a better way to shut down avobase. a real way.

   if ( orderInvoice <> nil ) then
      if ( orderInvoice.OrderNotSaved ) then
         showmessage('Order was not saved');
}
   FreeAndNil(ReturnInvoice);
   //
   inherited Destroy;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.Save;
var
	errResult : tErrorResult;
begin
   // Save the invoice
   PercentForm_Create('Saving - One Moment Please...', 0, 0);
   ReturnInvoice.Order_Message := TextEditor.Text;
   errResult := ReturnInvoice.Save;
   PercentForm_Free();
   if (errResult.AsBoolean = false) then
   	Close();
{ if the following is uncommented, you will get an access violation...

   if (errResult.AsBoolean = false) then
      if Assigned(eInvoiceUpdatedEvent) then
         eInvoiceUpdatedEvent();
}
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.SetOrderFormCaption;
begin
   BASE_FORM_CAPTION_LABEL.Caption := ReturnInvoice.Order_GetOrderTypeName + ' # ' +
      ReturnInvoice.Order_GetOrderNumberName + ' | ' + ReturnInvoice.Customer_GetSoldToName;
   PRIOR_ORDER_LABEL.Caption := 'Prior Order # ' + ReturnInvoice.PriorOrderNumberName + ' | ' +
      ' Cycle ' + ReturnInvoice.Cycle_GetCycleName + ' | ' + ReturnInvoice.OrgName;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.StartUpForm;
begin
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_ORDER_EDIT_FINALIZE );
   CreateButtonSep();
   CreateButton( CMD_ORDER_EDIT_MESSAGE );
   CreateButton( CMD_ORDER_EDIT_FEES );
   CreateButton( CMD_ORDER_EDIT_LINEITEMS );
   CreateButton( CMD_ORDER_EDIT_CUSTOMER );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SAVE );
   ORDER_NOTEBOOK.ActivePage := 'CUST_PAGE';
   //
   TextEditor := tAvoBaseTextEditor.Create(nil, MESSAGE_BACK_PANEL); // <-- will have to fill this in with the invocie message
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.WaveShippingBoxClick(Sender: TObject);
begin
   ReturnInvoice.WaveShipping := WaveShippingBox.Checked;
   RecalculateInvoice();
end;

procedure tReturnEditForm.WaveShippingTaxBoxClick(Sender: TObject);
begin
   RecalculateInvoice();
end;

procedure tReturnEditForm.WaveTaxCheckBoxClick(Sender: TObject);
begin
   ReturnInvoice.WaveTax := WaveTaxCheckBox.Checked;
   RecalculateInvoice();
end;

procedure tReturnEditForm.ShowDiscountClick(Sender: TObject);
begin
   ReturnInvoice.ShowDiscount := ShowDiscount.Checked;
   RecalculateInvoice();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


function tReturnEditForm.fGetOrderID: string;
begin
   result := fOrderID;
end;

function tReturnEditForm.fGetOrderNumber: integer;
begin
   result := ReturnInvoice.Order_GetOrderNum;
end;

function tReturnEditForm.fGetPriorOrderID: string;
begin
   result := returnInvoice.PriorOrderID;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.Finalize;
var
   errRec : tErrorResult;
begin
   errRec := ReturnInvoice.Finalize;
   if (NOT  errRec.errorResult) then
   if AvoBaseDialog('Print Final Return Invoice','Do you wish to View/Print a final Return Invoice for this Return?', mtInformation, [mbyes, mbno], 0) = mbYes then
      if Assigned(fViewInvoiceClosed) then
         fViewInvoiceClosed( fOrderID );
   if (NOT  errRec.errorResult) then
   begin
      // send an event so that any lists or what not will update
      Close();
      if Assigned(eInvoiceUpdatedEvent) then
         eInvoiceUpdatedEvent();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

// note. the issue here is that if the person just closed avobase and this order form was still
// here, we have to ask them to save any changes they made. but the problem is that it will ask the
// same question over and over, even if you hit cancel you'd get "do you want to?" and then another
// "do you want to?". there has to be some kind of item within the invoice object that flags if the
// order has been modified.
// if (orderInvoice <> NIL) then showmessage(' order invoice is not nill ');
{
   if AvoBaseDialog('Save Order Changes', 'Save Changes To This Current Order # TBD?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then

    begin
      Save_Order(True);
    end else
      OrderFormQuery.Cancel;
}
  inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tReturnEditForm.fGetImsg: string;
begin
   result := TextEditor.Text;
end;

procedure tReturnEditForm.fSetCreditImage(inVal: boolean);
begin
   fCreditImage := inVal;
   //
   if (fCreditImage) then
   begin
   end;
end;

procedure tReturnEditForm.fSetImsg(inValue: string);
begin
   TextEditor.Text := inValue;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      // --------------------------------------- //
      CMD_ORDER_EDIT_FINALIZE:
      begin
         Finalize();
      end;
      // --------------------------------------- //
      CMD_ORDER_EDIT_FEES:
      begin
         ORDER_NOTEBOOK.ActivePage := 'FEE_PAGE';
      end;
      // --------------------------------------- //
      CMD_ORDER_EDIT_MESSAGE:
      begin
         ORDER_NOTEBOOK.ActivePage := 'MESSAGE_PAGE';
      end;
      // --------------------------------------- //
      CMD_ORDER_EDIT_LINEITEMS:
      begin
         ORDER_NOTEBOOK.ActivePage := 'LINEITEMS_PAGE';
      end;
      // --------------------------------------- //
      CMD_ORDER_EDIT_CUSTOMER:
      begin
         ORDER_NOTEBOOK.ActivePage := 'CUST_PAGE';
      end;
      // --------------------------------------- //
      CMD_SAVE :
      begin
         Save();
      end;
      // --------------------------------------- //
      CMD_CANCEL :
      begin
         if AvoBaseDialog('Cancel Changes?', 'This will CANCEL any changes you have made to this Return.', mtconfirmation, [mbyes, mbno], 0) = mbYes then
            Cancel();
      end;
      // --------------------------------------- //
      CMD_HELP :
      begin
         AvoBaseHelp_Execute('ReturnEditForm');
      end;
      // --------------------------------------- //
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.HandleInvoiceUpdated;
begin
   // this form can't handle that an invoice was updated. this kind of event is only to notify the
   // mainform_control that an invoice was updated, and to cascade upwards to any particular open form
   // to recalculate grids and so forth.
   if Assigned(eInvoiceUpdatedEvent) then
      eInvoiceUpdatedEvent();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.HandleRecalculateInvoice;
begin
	RecalculateInvoice();
end;

procedure tReturnEditForm.InvoiceTotalsPanelClick(Sender: TObject);
begin
  inherited;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.LineItemToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
var
	eleDetail : tThemedElementDetails;
begin
   exit;
	if (ThemeServices.ThemesEnabled) then
   begin
   	eleDetail := ThemeServices.GetElementDetails(trRebarDontCare);
      ThemeServices.DrawElement(Sender.Canvas.Handle, eleDetail, Sender.ClientRect);
      ThemeServices.DrawElement(Self.Canvas.Handle, eleDetail, Sender.ClientRect);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This method takes informatin out of the invoiceObject and displays them
procedure tReturnEditForm.RecalculateInvoice;
var
   CustRec : tCustRec;
begin
   fOrderID := ReturnInvoice.ID;
   //
   ShowDiscount.Checked := ReturnInvoice.ShowDiscount;
   WaveTaxCheckBox.Checked := ReturnInvoice.WaveTax;
   WaveShippingBox.Checked := ReturnInvoice.WaveShipping;
   db_refundshipping.Checked := ReturnInvoice.RefundShipping;
   //
   Amount_SubTotal.Caption  := FormatCurrency(ReturnInvoice.Amount_LineItemTotal);
   Amount_Fees.Caption  := FormatCurrency(ReturnInvoice.Amount_FeeTotal);
   Amount_Tax.Caption  := FormatCurrency(ReturnInvoice.Amount_TotalTax);
   Amount_Total.Caption  := FormatCurrency(ReturnInvoice.Amount_Total);
   Amount_Shipping.Caption   := FormatCurrency(ReturnInvoice.Amount_ShippingTotal);
   amount_void.caption := formatcurrency( returninvoice.Amount_TotalPriorVoidNSF );

   //
   db_refundshipping.Caption := 'Refund Prior Shipping (' +
      Pref_GetCashSymbol + FormatCurrency(ReturnInvoice.AmountShippingREALSubTotal) + ')';
   //
   if ( ReturnInvoice.LineItemCount <= 0 ) then
      returnAllLineItemsCheck.Enabled := false
   else
      returnAllLineItemsCheck.Enabled := true;
   if ( ReturnInvoice.FeeLineCount <= 0 ) then
      returnAllFeeItemsCheck.Enabled := false
   else
      returnAllFeeItemsCheck.Enabled := true;

   if (ReturnInvoice.AmountShippingREALSubTotal < 0) then
      db_refundshipping.enabled := false
   else
      db_refundshipping.enabled := true;

   if ( ReturnInvoice.WaveShipping ) then
   begin
      db_refundshipping.Checked := false;
      db_refundshipping.Caption := 'Shipping is NON Refundable';
      db_refundshipping.Enabled := false;
   end;

{
   leaving this in for reasoning.

   if (ReturnInvoice.AmountDue > 0) then
   begin
      AmountDueLabel.Caption := 'AMOUNT OWED:';
      AmountDueLabel.Font.Color := clRed;
      Amount_Due.Font.COlor := clRed;
      Amount_Due.Caption := FormatCurrency(ReturnInvoice.AmountDue);
   end;
}
   Amount_Due.Caption := FormatCurrency(ReturnInvoice.Amount_TotalRefund);
   SetOrderFormCaption();
   //
   CustRec := Customer_GetCustomerByCustID( ReturnInvoice.CustSoldToID );
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
end;

procedure tReturnEditForm.returnAllFeeItemsCheckClick(Sender: TObject);
begin
   if ( returnAllFeeItemsCheck.Checked ) then
      ReturnInvoice.ReturnAllFeeItemsCheck( True )
   else
      ReturnInvoice.ReturnAllFeeItemsCheck( False );
end;

procedure tReturnEditForm.returnAllLineItemsCheckClick(Sender: TObject);
begin
   if ( returnAllLineItemsCheck.Checked ) then
      ReturnInvoice.ReturnAllLineItems( True )
   else
      ReturnInvoice.ReturnAllLineItems( False );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.AddBlankFeeLineBtnClick(Sender: TObject);
begin
   ReturnInvoice.AddBlankFee();
end;

procedure tReturnEditForm.AddCustShipToButtonClick(Sender: TObject);
var
   CustSelectForm : TCustomerSelectForm;
   CustID : string;
begin
   CustID := '';
   //
   CustSelectForm := TCustomerSelectForm.Create( Application, '', true);
   try
      CustSelectForm.ShowModal;
      if (CustSelectForm.fFormEvent = mrOk) then
      begin
         CustID := CustSelectForm.CustID;
         ReturnInvoice.CustShipToID := CustID;
         RecalculateInvoice();
      end;
   finally
      FreeAndNil(CustSelectForm);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.AddCustSoldToButtonClick(Sender: TObject);
var
   CustSelectForm : TCustomerSelectForm;
   CustID : string;
begin
   CustID := '';
   //
   CustSelectForm := TCustomerSelectForm.Create( Application, '', true);
   try
      CustSelectForm.ShowModal;
      if (CustSelectForm.fFormEvent = mrOk) then
      begin
         CustID := CustSelectForm.CustID;
         ReturnInvoice.CustSoldToID := CustID;
         RecalculateInvoice();
      end;
   finally
      FreeAndNil(CustSelectForm);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.AddFeeLineBtnClick(Sender: TObject);
begin
   ReturnInvoice.AddFeeSelect();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.Cancel;
begin
   Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.ClearCustShipToButtonClick(Sender: TObject);
begin
   if AvoBaseDialog('Clear Ship-To Customer?',
      'Are you sure you want to clear the Ship-To Customer?', mtconfirmation, [mbyes, mbno], 0) = mbYes then
   begin
      ReturnInvoice.CustShipToId := '';
      RecalculateInvoice();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.ClearCustSoldToButtonClick(Sender: TObject);
begin
   if AvoBaseDialog('Clear Sold-To Customer?',
      'Are you sure you want to clear the Sold-To Customer?', mtconfirmation, [mbyes, mbno], 0) = mbYes then
   begin
      ReturnInvoice.CustSoldToId := '';
      RecalculateInvoice();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReturnEditForm.DeleteFeeLineBtnClick(Sender: TObject);
begin
   ReturnInvoice.DeleteFeeItem();
end;

procedure tReturnEditForm.DeleteLineItemBtnClick(Sender: TObject);
begin
   ReturnInvoice.DeleteLineItem();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
