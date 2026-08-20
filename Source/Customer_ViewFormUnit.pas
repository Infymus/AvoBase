 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_ViewFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   MasterData_CustomerOrderDetailsListUnit,
   AvoBase_ToolBarUnit,
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
   Mask,
   DB,
   jpeg;


type
	tCustomer_ViewForm = class(TAvoBase_BaseForm_Menu)
    VIEWGRID_DOCK_PANEL: TPanel;
    BASE_NAVBAR_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
    addresGroupBox: TGroupBox;
    stateLabel: TLabel;
    addr1Label: TLabel;
    zipLabel: TLabel;
    addr2Label: TLabel;
    cityLabel: TLabel;
    infoGroupBox: TGroupBox;
    phonehLabel: TLabel;
    phonewLabel: TLabel;
    phonecLabel: TLabel;
    addr1Edit: TEdit;
    cityEdit: TEdit;
    zipEdit: TEdit;
    stateEdit: TEdit;
    addr2Edit: TEdit;
    phonehEdit: TEdit;
    phonecEdit: TEdit;
    phonewEdit: TEdit;
    bdayLabel: TLabel;
    bdayEdit: TEdit;
    emailLabel: TLabel;
    emailEdit: TEdit;
    activeLabel: TLabel;
    taxeLabel: TLabel;
   private
      fNewOrderWithCustomerEvent : tNewOrderWithCustomerEvent;
      fLoadOrderEvent : tLoadOrderEvent;
      fTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent;
      fVoidPaymentEvent : tVoidPaymentEvent;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fPrintInvoiceEvent : tPrintInvoiceEvent;
      fFinalizeOrderEvent : tFinalizeOrderEvent;
      fCancelEvent : tCancelEvent;
      fCustQuery : tMasterData_BaseDataClass;
   	custOrderDetailListGrid : tAvoBaseDBGrid;
      custOrderDetailListQuery : tMasterDataCustomerOrderDetailsList;
      dbNavTool : tAvoBaseDBNavigationTool;
      ordGridToolBar : tAvoBaseToolBar;

      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure StartUpForm();
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   public
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OnViewOrderInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OnPrintOrderInvoiceEvent : tPrintInvoiceEvent read fPrintInvoiceEvent write fPrintInvoiceEvent;
      property OnFinalizeOrderInvoiceEvent : tFinalizeOrderEvent read fFinalizeOrderEvent write fFinalizeOrderEvent;
      property OnTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent read fTakeMethodOfPaymentEvent write fTakeMethodOfPaymentEvent;
      property OnVoidPaymentEvent : tVoidPaymentEvent read fVoidPaymentEvent write fVoidPaymentEvent;
      property OnCancelUnCancelOrderEvent : tCancelEvent read fCancelEvent write fCancelEvent;
      property OnNewOrderWithCustomerEvent : tNewOrderWithCustomerEvent read fNewOrderWithCustomerEvent write fNewOrderWithCustomerEvent;
   	procedure StatBarUpdate();
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tCustomer_ViewForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inQuery: tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   self.Height := 575; // must be set or you lose the menu bars and shit
   self.Width := 743;
   //
   fCustQuery := inQuery;
   //
   custOrderDetailListQuery := tMasterDataCustomerOrderDetailsList.Create( masterData, inQuery.ID);
   //
   custOrderDetailListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, custOrderDetailListQuery, 'FNAME' );
   custOrderDetailListGrid.Clear;
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('ORDTYPE'), 'TYPE', 80, clRed, [fsBold], taLeftJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('ONUM'), '#', 60, clRed, [fsBold], taLeftJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('ORGNAME'), 'ORG', 60, clGreen, [], taLeftJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('CYCLE'), 'CYCLE', 80, clHighlight, [], taLeftJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('ODATE'), 'DATE', 80, clBlack, [], taRightJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('ORDITEMS'), 'ITEMS', 80, clBlack, [], taRightJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('TOTALINVAMOUNT'), 'TOTAL', 80, clBlack, [], taRightJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('TOTPAID'), 'PAID', 80, clBlack, [], taRightJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('ORDSTATUS'), 'STATUS', 80, clBlack, [fsBold], taRightJustify);
   custOrderDetailListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, custOrderDetailListQuery);
   //
   addr1Edit.Text := fCustQuery.GetFieldByName('ADDR1').AsString;
   addr2Edit.Text := fCustQuery.GetFieldByName('ADDR2').AsString;
   cityEdit.Text := fCustQuery.GetFieldByName('CITY').AsString;
   stateEdit.Text := fCustQuery.GetFieldByName('STATE').AsString;
   zipEdit.Text := fCustQuery.GetFieldByName('ZIP').AsString;
   phonehEdit.Text := fCustQuery.GetFieldByName('PHONEH').AsString;
   phonecEdit.Text := fCustQuery.GetFieldByName('PHONEC').AsString;
   phonewEdit.Text := fCustQuery.GetFieldByName('PHONEW').AsString;
   bdayEdit.Text := DateToStr(fCustQuery.GetFieldByName('BDAY').AsDateTime);
   emailEdit.Text := fCustQuery.GetFieldByName('EMAIL').AsString;
   //
   if (fCustQuery.GetFieldByName('TAXE').AsBoolean = true) then
      taxeLabel.Caption := 'Customer is TAX-EXEMPT'
   else
      taxeLabel.Caption := '';
   if (fCustQuery.GetFieldByName('ISACTIVE').AsBoolean = true) then
   begin
      activeLabel.Caption := 'ACTIVE Customer';
      activeLabel.Font.Color := clBlue;
   end else
      begin
         activeLabel.Caption := 'INACTIVE Customer';
         activeLabel.Font.Color := clRed;
      end;
   //
   ordGridToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   ordGridToolBar.actionList.OnUpdate := HandleActionListUpdate;
   ordGridToolBar.actionList.onActionEvent := HandleActionExecute;
   ordGridToolBar.Align := alClient;
   ordGridToolBar.CreateButton( CMD_PRINT_INVOICE);
   ordGridToolBar.CreateButton( CMD_ORDER_VIEWINVOICE );
   ordGridToolBar.CreateButtonSep();
   ordGridToolBar.CreateButton( CMD_CUST_UNCANCEL_ORDER );
   ordGridToolBar.CreateButton( CMD_CUST_CANCEL_ORDER );
   ordGridToolBar.CreateButtonSep();
   ordGridToolBar.CreateButton( CMD_ORDER_PAYMENT );
   ordGridToolBar.CreateButton( CMD_ORDER_LOAD );
   //
	StartUpForm();
   StatBarUpdate();
end;

procedure tCustomer_ViewForm.CloseForm;
begin
	FreeAndNil(custOrderDetailListGrid);
   FreeAndNil(dbNavTool);
   freeAndNil(custOrderDetailListQuery);
   freeAndNil(ordGridToolBar);
	Close();
end;

procedure tCustomer_ViewForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_CLOSE : CloseForm();
      CMD_ORDER_LOAD:
      begin
      	if Assigned(fLoadOrderEvent) then
         begin
            Close();
         	fLoadOrderEvent( Self, custOrderDetailListQuery.FieldByName('ID').AsString );
         end;
      end;
{ This is removed for now. Contemplating WHY it should be HERE...
      CMD_NEW_ORDER :
      begin
      	if Assigned(fNewOrderWithCustomerEvent) then
         begin
            Close();
         	fLoadOrderEvent( self, fCustQuery.GetFieldByName('ID').AsString );
         end;
      end; }
      CMD_ORDER_PAYMENT:
      begin
         if Assigned(fTakeMethodOfPaymentEvent) then
         begin
            Close();
            fTakeMethodOfPaymentEvent( custOrderDetailListQuery.FieldByName('ID').AsString );
         end;
      end;
      CMD_ORDER_VIEWINVOICE :
      begin
      	if Assigned(fViewInvoiceEvent) then
         begin
            Close();
         	fViewInvoiceEvent( Self, custOrderDetailListQuery.FieldByName('ID').AsString );
         end;
      end;
      CMD_PRINT_INVOICE :
      begin
      	if Assigned(fPrintInvoiceEvent) then
         begin
            Close();
         	fPrintInvoiceEvent( Self, custOrderDetailListQuery.FieldByName('ID').AsString );
         end;
      end;
      CMD_CUST_CANCEL_ORDER :
      begin
      	if Assigned(fCancelEvent) then
         begin
            Close();
         	fCancelEvent( CancelOrders, custOrderDetailListQuery.FieldByName('ID').AsString );
         end;
      end;
      CMD_CUST_UNCANCEL_ORDER :
      begin
      	if Assigned(fCancelEvent) then
         begin
            Close();
         	fCancelEvent( CancelUnCancel, custOrderDetailListQuery.FieldByName('ID').AsString );
         end;
      end;
   end;
end;

procedure tCustomer_ViewForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_PRINT_INVOICE,
         CMD_ORDER_VIEWINVOICE: enabled := (custOrderDetailListQuery.FieldByName('STATUS').AsInteger = integer(OrderClosed)) OR
            (custOrderDetailListQuery.FieldByName('STATUS').AsInteger = integer(OrderOpen));
         //
         CMD_ORDER_LOAD,
         CMD_ORDER_PAYMENT,
         CMD_CUST_CANCEL_ORDER: enabled := (custOrderDetailListQuery.FieldByName('STATUS').AsInteger = integer(OrderOpen));
         //
         CMD_CUST_UNCANCEL_ORDER: enabled := (custOrderDetailListQuery.FieldByName('STATUS').AsInteger = integer(OrderCancelled));
         //

{
            'ID VARCHAR(40), ' +
            'RET_ID VARCHAR(40), ' + // The prior order ID only for returns
            'C_ID VARCHAR(40), ' + // cycle id
            'C_STID VARCHAR(40), ' + // sold to id
            'C_SHID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'ORG_ID VARCHAR(40), ' +
            'ONUM INTEGER, ' + // order number
            'ODATE DATE, ' +
            'OTIME TIME, ' +
            'SHIPAMT MONEY, ' +
            'SHIPTAXAMT MONEY, ' +
            'CTAXAMT MONEY, ' + // compound tax amount
            'STATUS INTEGER, ' +
            'WTAX BOOLEAN, ' +
            'WSHIP BOOLEAN, ' +
            'WSHIPTAX BOOLEAN, ' + // wave shipping?
            'SHIPTAX FLOAT, ' + // shipping tax rate
            'SHOW_DISC BOOLEAN, ' +
            'O_TYPE INTEGER, ' +
            'I_MSG BLOB(240,1)',
}

      end;
   // overall, if there isn't anything, then fwak that shat
   if (custOrderDetailListQuery.RecordCount = 0) then
      enabled := false;
end;

procedure tCustomer_ViewForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

procedure tCustomer_ViewForm.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
   CreateButtonSep;
   CreateButton( CMD_PRINT );
end;

procedure tCustomer_ViewForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(custOrderDetailListQuery.RecNo) + ' of ' + IntToStr(custOrderDetailListQuery.RecordCount);
end;

end.
