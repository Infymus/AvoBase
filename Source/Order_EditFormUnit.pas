 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Order_EditFormUnit;

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
   order_invoiceobjectunit,
  recordstructureunit,
   Avobase_HelpFormUnit,
   avobase_texteditorformunit,
   avobase_percentformunit,
   toolbox_customertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_credittoolboxunit,
   Toolbox_TaxToolBoxUnit,
   product_selectformunit,
   Toolbox_PreferenceToolBoxUnit,
   toolbox_escrowtoolboxunit,
   Customer_NoteListFormUnit,
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
	tOrderEditForm = class(TAvoBase_BaseForm_Menu)
    ORDER_NOTEBOOK: TNotebook;
    MESSAGE_BACK_PANEL: TPanel;
    TOP_SEP_PANEL: TPanel;
    MOP_BACK_PANEL: TPanel;
    INVOICE_LINEITEMS_BACK_PANEL: TPanel;
    CUST_BACK_PANEL: TPanel;
    FEE_BACK_PANEL: TPanel;
    FEE_DOCK: TScrollBox;
    MOP_DOCK: TScrollBox;
    BOTTOM_TOTAL_PANEL: TPanel;
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
    Panel9: TPanel;
    Panel17: TPanel;
    ShippingLabel: TLabel;
    Amount_Shipping: TLabel;
    FeeToolBar: TToolBar;
    AddBlankFeeLineBtn: TToolButton;
    AddFeeLineBtn: TToolButton;
    DeleteFeeLineBtn: TToolButton;
    ToolBar1: TToolBar;
    MopAddBlankLine: TToolButton;
    DeleteMOPButton: TToolButton;
    GroupBox1: TGroupBox;
    ShowDiscount: TCheckBox;
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
    Panel5: TPanel;
    Panel6: TPanel;
    Label3: TLabel;
    Image4: TImage;
    Panel7: TPanel;
    Panel8: TPanel;
    Label4: TLabel;
    Image5: TImage;
    LineItemToolBar_DOCK: TPanel;
    db_taxclasslabel: TLabel;
    db_taxclass: TComboBox;
    Label5: TLabel;
    db_compoundtax: TComboBox;
    db_taxexid: TLabeledEdit;
    WaveTaxCheckBox: TCheckBox;
    cust_shipsold_dock: TPanel;
    SoldToGroupBox: TPanel;
    CustSoldToName: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToPhone: TLabel;
    OrdPurchLabel: TLabel;
    custSoldToToolBar: TToolBar;
    AddCustSoldToButton: TToolButton;
    ClearCustSoldToButton: TToolButton;
    OrdShipToPanel: TPanel;
    CustShipToName: TLabel;
    CustShipToAddress: TLabel;
    CustShipToCityStateZip: TLabel;
    CustShipToPhone: TLabel;
    Label16: TLabel;
    CustShipToToolBar: TToolBar;
    AddCustShipToButton: TToolButton;
    ClearCustShipToButton: TToolButton;
    noteButton: TToolButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Image2: TImage;
    ToolButton1: TToolButton;
    MOPEscrowPanel: TPanel;
    credImage: TImage;
    credLabel: TLabel;
    escLabelDesc: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LineItemToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
    procedure WaveTaxCheckBoxClick(Sender: TObject);
    procedure AddCustSoldToButtonClick(Sender: TObject);
    procedure AddCustShipToButtonClick(Sender: TObject);
    procedure ClearCustSoldToButtonClick(Sender: TObject);
    procedure ClearCustShipToButtonClick(Sender: TObject);
    procedure AddBlankFeeLineBtnClick(Sender: TObject);
    procedure AddFeeLineBtnClick(Sender: TObject);
    procedure DeleteFeeLineBtnClick(Sender: TObject);
    procedure WaveShippingBoxClick(Sender: TObject);
    procedure WaveShippingTaxBoxClick(Sender: TObject);
    procedure MopAddBlankLineClick(Sender: TObject);
    procedure DeleteMOPButtonClick(Sender: TObject);
    procedure ShowDiscountClick(Sender: TObject);
    procedure db_taxclassChange(Sender: TObject);
    procedure db_compoundtaxChange(Sender: TObject);
    procedure db_taxexidChange(Sender: TObject);
    procedure noteButtonClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
   private
      fViewInvoiceEvent : tViewInvoiceEvent;
      fCreditImage : boolean;
      eInvoiceUpdatedEvent : tInvoiceUpdatedEvent;
      fViewInvoiceClosed : tViewInvoiceClosed;
   	fOrderID : string;
      TextEditor : tAvoBaseTextEditor;
      LineItemToolBar : tAvoBaseToolBar;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
		procedure HandleRecalculateInvoice;
      procedure HandleInvoiceUpdated;
   	procedure StartUpForm();
      procedure SetOrderFormCaption();
      procedure fSetImsg( inValue : string );
      procedure fSetCreditImage( inVal : boolean );
      procedure fSetOrderMsg( inMsg : string );
      //
      function fGetImsg : string;
      function fGetOrderID : string;
      function fGetOrderNumber : integer;
      function fGetOrderMsg : string;
   public
      orderInvoice : tInvoice;
      //
      procedure Cancel;
      property OrderID : string read fGetOrderId;
      property OnInvoiceUpdated : tInvoiceUpdatedEvent read eInvoiceUpdatedEvent write eInvoiceUpdatedEvent;
      property InvoiceMessage : string read fGetImsg write fSetImsg;
      procedure Save;
      procedure Finalize;
      procedure RecalculateInvoice;
      procedure AddBlankInvoiceLine();
      procedure AddProduct();
      procedure DeleteInvoiceLine();
      procedure Check_Customer_Escrow();
      property OrderNumber : integer read fGetOrderNumber;
      property Order_Message : string read fGetOrderMsg write fSetOrderMsg;
      //
      property CreditImage : boolean read fCreditImage write fSetCreditImage;
      property OnViewInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
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

{$REGION 'Create, Destroy, Startup, Shutdown'}

constructor TOrderEditForm.Create;
var
   cnt : integer;
begin
	// Do the inherited create
	inherited create( nil, '', true, false);
   //
   // Setup some things we need by default

   // Create the invoice
   orderInvoice := tInvoice.Create( InvoiceTypeOrder, MOP_DOCK, LINE_ITEM_DOCK, FEE_DOCK );

   LINE_ITEM_DOCK.Visible := False;
   LINE_ITEM_DOCK.Realign;
   LINE_ITEM_DOCK.Perform(WM_VSCROLL, SB_BOTTOM, 0);
   LINE_ITEM_DOCK.Visible := True;

   MOP_DOCK.Visible := False;
   MOP_DOCK.Realign;
   MOP_DOCK.Perform(WM_VSCROLL, SB_BOTTOM, 0);
   MOP_DOCK.Visible := True;

   // Set up all the Events for recalculation, etc.
   orderInvoice.OnRecalculateInvoiceEvent := HandleRecalculateInvoice;
   orderInvoice.OnInvoiceUpdated := HandleInvoiceUpdated;

   //

   // Line Item Tool Bar
   LineItemToolBar := tAvoBaseToolBar.Create( LineItemToolBar_DOCK );
   LineItemToolBar.actionList.OnUpdate := HandleActionListUpdate;
   LineItemToolBar.actionList.onActionEvent := HandleActionExecute;
   LineItemToolBar.Align := alLeft;
   LineItemToolBar.Wrapable := True;
   LineItemToolBar.AutoSize := True;
   LineItemToolBar.CreateButton( CMD_ORDEREDIT_LINEITEM_PRODUCT );
   LineItemToolBar.CreateButton( CMD_ORDEREDIT_LINEITEM_DELETE );
   LineItemToolBar.CreateButton( CMD_ORDEREDIT_LINEITEM_BLANK );

   // Fee Tool Bar

   // MOP Tool Bar


   //

   //
   StartUpForm();
   RecalculateInvoice();
end;

procedure TOrderEditForm.StartUpForm;
begin
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_ORDER_EDIT_FINALIZE );
   CreateButtonSep();
   CreateButton(    CMD_ORDER_EDIT_MESSAGE );
   CreateButton(    CMD_ORDER_EDIT_MOP );
   CreateButton(    CMD_ORDER_EDIT_FEES );
   CreateButton(    CMD_ORDER_EDIT_LINEITEMS );
   CreateButton(    CMD_ORDER_EDIT_CUSTOMER );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SAVE );
   ORDER_NOTEBOOK.ActivePage := 'CUST_PAGE';
   //
   TextEditor := tAvoBaseTextEditor.Create(nil, MESSAGE_BACK_PANEL); // <-- will have to fill this in with the invocie message
end;

destructor tOrderEditForm.Destroy;
begin
	FreeAndNil(TextEditor);

{
This shit aint gonna work. gotta find a better way to shut down avobase. a real way.

   if ( orderInvoice <> nil ) then
      if ( orderInvoice.OrderNotSaved ) then
         showmessage('Order was not saved');
}
   FreeAndNil(LineItemToolBar);
   FreeAndNil(orderInvoice);
   //
   inherited Destroy;
end;

procedure tOrderEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
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

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

procedure tOrderEditForm.HandleInvoiceUpdated;
begin
   // this form can't handle that an invoice was updated. this kind of event is only to notify the
   // mainform_control that an invoice was updated, and to cascade upwards to any particular open form
   // to recalculate grids and so forth.
   if Assigned(eInvoiceUpdatedEvent) then
      eInvoiceUpdatedEvent();
end;

procedure tOrderEditForm.HandleRecalculateInvoice;
begin
	RecalculateInvoice();
end;

procedure tOrderEditForm.db_compoundtaxChange(Sender: TObject);
begin
   orderInvoice.Order_TaxID := Tax_GetMasterTaxIDByName( db_compoundtax.Text );
   RecalculateInvoice();
end;

procedure tOrderEditForm.db_taxclassChange(Sender: TObject);
begin
   orderInvoice.Shipping_TaxID := Tax_GetMasterTaxIDByName( db_taxclass.Text );
   RecalculateInvoice();
end;

procedure tOrderEditForm.db_taxexidChange(Sender: TObject);
begin
   orderInvoice.TaxExemptID := db_taxexid.Text;
end;

procedure tOrderEditForm.LineItemToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
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

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties'}

function tOrderEditForm.fGetImsg: string;
begin
   result := TextEditor.Text;
end;

procedure tOrderEditForm.fSetCreditImage(inVal: boolean);
begin
{
   fCreditImage := inVal;
   //
   imgCredit.Visible := fCreditImage;
   credLabel.Visible := fCreditImage;
   //
   if (fCreditImage) then
   begin
   end;
}
end;

procedure tOrderEditForm.fSetImsg(inValue: string);
begin
   TextEditor.Text := inValue;
end;

procedure tOrderEditForm.fSetOrderMsg(inMsg: string);
begin
   orderInvoice.Order_Message := inMsg;
   TextEditor.Text := inMsg;
end;

function tOrderEditForm.fGetOrderID: string;
begin
   result := fOrderID;
end;

function tOrderEditForm.fGetOrderMsg: string;
begin
   result := orderInvoice.Order_Message;
end;

function tOrderEditForm.fGetOrderNumber: integer;
begin
   result := orderInvoice.Order_GetOrderNumber;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Action Execute and Handle Execute'}

procedure TOrderEditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_HELP: AvoBaseHelp_Execute('OrderEditForm');
      CMD_ORDER_EDIT_FINALIZE:  Finalize();
      CMD_ORDER_EDIT_MOP: ORDER_NOTEBOOK.ActivePage := 'MOP_PAGE';
      CMD_ORDER_EDIT_FEES: ORDER_NOTEBOOK.ActivePage := 'FEE_PAGE';
      CMD_ORDER_EDIT_MESSAGE: ORDER_NOTEBOOK.ActivePage := 'MESSAGE_PAGE';
      CMD_ORDER_EDIT_LINEITEMS: ORDER_NOTEBOOK.ActivePage := 'LINEITEMS_PAGE';
      CMD_ORDER_EDIT_CUSTOMER: ORDER_NOTEBOOK.ActivePage := 'CUST_PAGE';
      CMD_SAVE : Save();
      CMD_CANCEL : if AvoBaseDialog('Cancel Changes?', 'This will CANCEL any changes you have made to this Order.', mtconfirmation, [mbyes, mbno], 0) = mbYes then
         Cancel();
      CMD_ORDEREDIT_LINEITEM_BLANK : AddBlankInvoiceLine();
      CMD_ORDEREDIT_LINEITEM_PRODUCT : AddProduct();
      CMD_ORDEREDIT_LINEITEM_DELETE : DeleteInvoiceLine();
   end;
end;

procedure TOrderEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true; // always set on. we do checks elsewhere.
{
         CMD_ORDEREDIT_LINEITEM_BACKORDER : enabled := ( orderInvoice.BackOrderItemCount <> 0 );
}
         CMD_ORDEREDIT_LINEITEM_DELETE: enabled := ( orderInvoice.LineItemCount <> 0 );
      end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Methods and Functions'}

procedure tOrderEditForm.Cancel;
begin
   Close();
end;

procedure tOrderEditForm.AddBlankInvoiceLine;
begin
   orderInvoice.LineItem_AddBlankLine();
end;

procedure tOrderEditForm.AddProduct;
var
   prodSel : tProductSelectForm;
begin
   prodSel := tProductSelectForm.Create( Application, 'Select Product To Add', True );
   try
      prodSel.ShowModal();
      if ( prodSel.fFormEvent = mrOK) then
      begin
         orderInvoice.LineItem_AddProductByProductID( prodSel.ProdID );
      end;
   finally
      FreeAndNil( prodSel );
   end;
end;

procedure tOrderEditForm.Check_Customer_Escrow;
var
   escrowCurr : currency;
begin
   orderInvoice.Escrow_TotalEscrow := 0;
   credLabel.Visible := false;
   credImage.Visible := false;
   MOPEscrowPanel.Visible := false;
   //
   if ( orderInvoice.Customer_SoldToID <> '' ) then
   begin
      escrowCurr := Escrow_GetCustomerEscrowByCustomerID( orderInvoice.Customer_SoldToID );
      if ( escrowCurr > 0 ) then
      begin
         credLabel.Visible := true;
         credImage.Visible := true;
         MOPEscrowPanel.Visible := true;
         orderInvoice.Escrow_TotalEscrow := escrowCurr;
         credLabel.Caption := 'CUSTOMER ESCROW BALANCE: ' + Pref_GetCashSymbol + FormatCurrency( escrowCurr ) + '.';
      end;
   end;
end;

procedure tOrderEditForm.DeleteInvoiceLine;
begin
   orderInvoice.LineItem_DeleteLineItem();
end;

procedure tOrderEditForm.Save;
var
	errResult : tErrorResult;
begin
   // Save the invoice
   PercentForm_Create('Saving - One Moment Please...', 0, 0);
   orderInvoice.Order_Message := TextEditor.Text;
   errResult := orderInvoice.Save;
   PercentForm_Free();
   if (errResult.AsBoolean = false) then
   	Close();
{
   you'lll get an access violation if you do this shit...

   if (errResult.AsBoolean = false) then
      if Assigned(eInvoiceUpdatedEvent) then
         eInvoiceUpdatedEvent();
}
end;

procedure tOrderEditForm.SetOrderFormCaption;
begin
   BASE_FORM_CAPTION_LABEL.Caption :=
   	orderInvoice.Order_GetOrderTypeName + ' # ' + orderInvoice.Order_GetOrderNumberName +
      ' | Cycle ' + orderInvoice.Cycle_GetCycleName +
      ' | ' + orderInvoice.Customer_GetSoldToName +
      ' | ' + orderInvoice.Org_GetOrgName;
end;

procedure tOrderEditForm.Finalize;
var
   errRec : tErrorResult;
begin
   Check_Customer_Escrow();
   errRec := orderInvoice.Finalize;
   if (NOT  errRec.errorResult) then
      if AvoBaseDialog('Print Final Invoice','Do you wish to View/Print a final Invoice for this Order?', mtInformation, [mbyes, mbno], 0) = mbYes then
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

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Invoice Functions, Recalculate, Etc'}

// This method takes informatin out of the invoiceObject and displays them
procedure tOrderEditForm.RecalculateInvoice;
var
   CustRec : tCustRec;
   totNotes : integer;
begin
   fOrderID := orderInvoice.Order_ID;
   //
   Amount_SubTotal.Caption  := FormatCurrency(orderInvoice.Amount_LineItemTotal);
   Amount_Fees.Caption  := FormatCurrency(orderInvoice.Amount_FeeTotal);
   Amount_Tax.Caption  := FormatCurrency(orderInvoice.Amount_TotalTax);
   Amount_Total.Caption  := FormatCurrency(orderInvoice.Amount_Total);
   Amount_MOP.Caption  := FormatCurrency(orderInvoice.Amount_TotalMOP);
   Amount_Shipping.Caption   := FormatCurrency(orderInvoice.Amount_ShippingSubTotal);
   db_taxexid.Text := orderInvoice.TaxExemptID;
   //
   ShowDiscount.Checked := orderInvoice.Order_ShowDiscount;
   WaveTaxCheckBox.Checked := orderInvoice.Order_WaveOrderTax;
   WaveShippingBox.Checked := orderInvoice.Shipping_WaveShipping;
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
      Amount_Due.Font.Color := clBlue;
      Amount_Due.Caption := FormatCurrency(orderInvoice.Amount_OverPaid);
   end;
   SetOrderFormCaption();
   //
   CustRec := Customer_GetCustomerByCustID( orderInvoice.Customer_SoldToID );
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
   //
   if ( orderInvoice.Customer_SoldToID <> '' ) then
   begin
      totNotes := Customer_GetTotalNoteCountByCustID( orderInvoice.Customer_SoldToID );
      if ( totNotes = 0 ) then
         noteButton.Caption := 'Add Note'
      else
         if ( totNotes = 1) then
            noteButton.Caption := '1 Note'
         else
            noteButton.Caption := IntToStr( totNotes ) + ' Notes';
   end;
   //
   CustRec := Customer_GetCustomerByCustID( orderInvoice.Customer_ShipToID );
   CustShipToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustShipToAddress.Caption := CustRec.ADDR1;
   CustShipToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustShipToCityStateZip.Caption := '';
   CustShipToPhone.Caption := CustRec.PHONEH;
   //
   if ( db_taxclass <> nil ) then
      Tax_FillTaxSubClassesByTaxClass( db_taxclass, orderInvoice.Shipping_TaxID );
   if ( db_compoundtax <> nil ) then
      Tax_FillTaxSubClassesByTaxClass( db_compoundtax, orderInvoice.Order_TaxID );

   // Credits
{
   if ( Credit_ReturnCreditAmountByCustID( orderInvoice.CustSoldToID ) <> 0) then
      CreditImage := true
   else
      CreditImage := false;
}
      CreditImage := true

end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Click Events'}

procedure tOrderEditForm.AddCustSoldToButtonClick(Sender: TObject);
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
         orderInvoice.Customer_SoldToID := CustID;
         Check_Customer_Escrow();
         RecalculateInvoice();
      end;
   finally
      FreeAndNil(CustSelectForm);
   end;
end;

procedure tOrderEditForm.AddCustShipToButtonClick(Sender: TObject);
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
         orderInvoice.Customer_ShipToID := CustID;
         RecalculateInvoice();
      end;
   finally
      FreeAndNil(CustSelectForm);
   end;
end;

procedure tOrderEditForm.MopAddBlankLineClick(Sender: TObject);
begin
   OrderInvoice.MOP_AddBlankMOP();
end;

procedure tOrderEditForm.AddBlankFeeLineBtnClick(Sender: TObject);
begin
   orderInvoice.Fee_AddBlankFee();
end;

procedure tOrderEditForm.AddFeeLineBtnClick(Sender: TObject);
begin
   orderInvoice.Fee_AddFeeBySelect();
end;

procedure tOrderEditForm.ClearCustShipToButtonClick(Sender: TObject);
begin
   if AvoBaseDialog('Clear Ship-To Customer?',
      'Are you sure you want to clear the Ship-To Customer?', mtconfirmation, [mbyes, mbno], 0) = mbYes then
   begin
      orderInvoice.Customer_ShipToID := '';
      RecalculateInvoice();
   end;
end;

procedure tOrderEditForm.ClearCustSoldToButtonClick(Sender: TObject);
begin
   if AvoBaseDialog('Clear Sold-To Customer?',
      'Are you sure you want to clear the Sold-To Customer?', mtconfirmation, [mbyes, mbno], 0) = mbYes then
   begin
      orderInvoice.Customer_SoldToID := '';
      Check_Customer_Escrow();
      RecalculateInvoice();
   end;
end;

procedure tOrderEditForm.DeleteFeeLineBtnClick(Sender: TObject);
begin
   orderInvoice.Fee_DeleteFeeItem();
end;

procedure tOrderEditForm.WaveShippingBoxClick(Sender: TObject);
begin
   orderInvoice.Shipping_WaveShipping := WaveShippingBox.Checked;
   RecalculateInvoice();
end;

procedure tOrderEditForm.WaveShippingTaxBoxClick(Sender: TObject);
begin
   RecalculateInvoice();
end;

procedure tOrderEditForm.WaveTaxCheckBoxClick(Sender: TObject);
begin
   orderInvoice.Order_WaveOrderTax := WaveTaxCheckBox.Checked;
   RecalculateInvoice();
end;

procedure tOrderEditForm.ShowDiscountClick(Sender: TObject);
begin
   orderInvoice.Order_ShowDiscount := ShowDiscount.Checked;
   RecalculateInvoice();
end;

procedure tOrderEditForm.ToolButton1Click(Sender: TObject);
begin
   OrderInvoice.MOP_AddEscrowMOP();
end;

procedure tOrderEditForm.DeleteMOPButtonClick(Sender: TObject);
begin
   OrderInvoice.MOP_DeleteMOPItem;
end;

procedure tOrderEditForm.noteButtonClick(Sender: TObject);
var
   noteForm :tCustomer_NoteListForm;
begin
   if ( orderInvoice.Customer_SoldToID <> '' ) then
   begin
      noteForm := tCustomer_NoteListForm.Create( Application, NIL, orderInvoice.Customer_SoldToID );
      noteForm.ShowModal();
      FreeAndNil(noteForm);
   end else
      AvoBaseDialog('No Customer', 'Once you have added a Customer to this Invoice, you can add or edit ' +
         'notes.', mtInformation, [mbok], 0);
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

