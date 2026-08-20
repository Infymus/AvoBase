 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Order_ListFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   actionunit,
   masterdata_basegridunit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   Toolbox_PreferenceToolBoxUnit,
   avobase_percentformunit,
   masterdata_BaseDataClassUnit,
   MasterData_OrderListUnit,
   AvoBase_HelpFormUnit,
   //
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   actnlist,
   Buttons,
   INIFiles,
   ExtCtrls,
   ComCtrls,
   DBCtrls,
   Mask,
   Grids,
   DBGrids,
   DB,
   Menus,
   DBTables,
   OleCtrls,
   SHDocVw,
   StdActns,
   jpeg;


type
   tOrderListForm = class(TAvobase_BaseForm_List)
    SortViewComboBox: TComboBox;
    Label5: TLabel;
    Label4: TLabel;
    SortTypeComboBox: TComboBox;
    ShowOrderTypesComboBox: TComboBox;
    Label3: TLabel;
    OrderOptionsMenu: TPopupMenu;
    ordOpt_ViewInvoice: TMenuItem;
    N5: TMenuItem;
    ordOpt_EmailInvoice: TMenuItem;
    N1: TMenuItem;
    ordOpt_ChangeOrderCampaign: TMenuItem;
    N2: TMenuItem;
    ordOpt_CanceLOrder: TMenuItem;
    ordOpt_UncancelOrder: TMenuItem;
    N3: TMenuItem;
    None1: TMenuItem;
    ordOpt_LoadOrder: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    akeaPayment1: TMenuItem;
    VoidaPayment1: TMenuItem;
    CreateReturnAgainstOrder1: TMenuItem;
    CloseOrderReturn: TMenuItem;
    viewOrderAccount: TMenuItem;
    N4: TMenuItem;
    N8: TMenuItem;
    EditCustomer1: TMenuItem;
    procedure ComboBoxChange(Sender: TObject);
    procedure ordOpt_LoadOrderClick(Sender: TObject);
    procedure akeaPayment1Click(Sender: TObject);
    procedure VoidaPayment1Click(Sender: TObject);
    procedure ordOpt_UncancelOrderClick(Sender: TObject);
    procedure ordOpt_CanceLOrderClick(Sender: TObject);
    procedure ordOpt_ChangeOrderCampaignClick(Sender: TObject);
    procedure ordOpt_ViewInvoiceClick(Sender: TObject);
    procedure ordOpt_PrintInvoiceClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateReturnAgainstOrder1Click(Sender: TObject);
    procedure CloseOrderReturnClick(Sender: TObject);
    procedure viewOrderAccountClick(Sender: TObject);
    procedure ordOpt_EmailInvoiceClick(Sender: TObject);
    procedure EditCustomer1Click(Sender: TObject);
   private
      OrderListQuery : tMasterDataOrderList;
      fLoadOrderEvent : tLoadOrderEvent;
      fTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent;
      fVoidPaymentEvent : tVoidPaymentEvent;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fPrintInvoiceEvent : tPrintInvoiceEvent;
      fChangeOrderCycleEvent : tChangeOrderCycleEvent;
      fFinalizeOrderEvent : tFinalizeOrderEvent;
      fViewOrderAccount : tViewOrderAccount;
      fReturnEvent : tReturnEvent;
      fCancelEvent : tCancelEvent;
      fCloseOrderEvent : tCloseOrderEvent;
      fOrderRefreshEvent : tOrderRefreshEvent;
      fEmailEvent : tEmailEvent;
      fOrderListEditCustomerEvent : tOrderListEditCustomerEvent;
      //
      procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure UpdateOrderQuery();
      procedure HandleDoubleClick( sender : tObject );
      function fGetOrderRecCount : integer;
      function fGetOrderID : string;
      function fGetCustID : string;
   public
      // Ribbon Commands
      procedure OrderLoad();
      procedure OrderNew();
      procedure OrderNSF();
      procedure OrderPayment();
      procedure OrderPrintInvoice();
      procedure OrderReport();
      procedure OrderReturn();
      procedure OrderViewInvoice();
      procedure OrderVoidPayment();
      procedure OrderHelp();
      procedure Recalculate();
      procedure OrderFinalize();
      procedure OrderCancel();
      procedure OrderChangeSalesCycle();
      procedure OrderUnCancel();
      procedure DBGotoID( inID : string );
      procedure GlobalRefreshEvent();
      procedure RefreshOrderList( inOrdID : string );
      //
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OnViewOrderInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OnPrintOrderInvoiceEvent : tPrintInvoiceEvent read fPrintInvoiceEvent write fPrintInvoiceEvent;
      property OnFinalizeOrderInvoiceEvent : tFinalizeOrderEvent read fFinalizeOrderEvent write fFinalizeOrderEvent;
      property OnTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent read fTakeMethodOfPaymentEvent write fTakeMethodOfPaymentEvent;
      property OnVoidPaymentEvent : tVoidPaymentEvent read fVoidPaymentEvent write fVoidPaymentEvent;
      property OnCancelUnCancelOrderEvent : tCancelEvent read fCancelEvent write fCancelEvent;
      property OnReturnOrderEvent : tReturnEvent read fReturnEvent write fReturnEvent;
      property OrderRecCount : integer read fGetOrderRecCount;
      property OnChangeOrderCycleEvent : tChangeOrderCycleEvent read fChangeOrderCycleEvent write fChangeOrderCycleEvent;
      property OnViewOrderAccountEvent : tViewOrderAccount read fViewOrderAccount write fViewOrderAccount;
      property OnCloseOrderEvent : tCloseOrderEvent read fCloseOrderEvent write fCloseOrderEvent;
      property OnOrderRefreshEvent : tOrderRefreshEvent read fOrderRefreshEvent write fOrderRefreshEvent;
      property OnEmailEvent : tEmailEvent read fEmailEvent write fEmailEvent;
      property onOrderListEditCustomerEvent : tOrderListEditCustomerEvent read fOrderListEditCustomerEvent write fOrderListEditCustomerEvent;
      property ID : string read fGetOrderID;
      property CustID : string read fGetCustID;

      // form declarations
      constructor Create(owner : tComponent);  overload;
  end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

implementation

{$R *.dfm}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

constructor TOrderListForm.Create(owner: tComponent);

   // Method to add header types
   procedure AddHeaderType( inHeaderType : integer );
   begin
      case inHeaderType of
         integer(OlistNone) : ;
         integer(OListLineItemCount) : DataListGrid.Add(OrderListQuery.FieldByName('ITEMS'), 'ITEMS', 45, clBlack, [], taRightJustify);
         integer(OlistBackOrderItemCount) : DataListGrid.Add(OrderListQuery.FieldByName('BOI'), 'BOI', 45, clBlack, [], taRightJustify);
         integer(OlistInvoiceTotalAmount) : DataListGrid.Add(OrderListQuery.FieldByName('TOTAL'), 'TOTAL', 70, clRed, [], taRightJustify);
         integer(OlistInvoiceMOPTotal) : DataListGrid.Add(OrderListQuery.FieldByName('PAID'), 'PAID/REF', 70, clBlue, [], taRightJustify);
         integer(OlistInvoiceAmountDue)  : DataListGrid.Add(OrderListQuery.FieldByName('DUE'), 'DUE', 45, clBlack, [], taRightJustify);
      end;
   end;

begin
	inherited create( Nil, 'Orders', false, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   OrderListQuery := tMasterDataOrderList.Create( masterData);
   //
   // These items are INHERITED from the AvoBase_BasweForm_StandardUnit
   // DataListGrid, gridDataSource, dbNavTool <-- all inherited
   gridDataSource.DataSet := OrderListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( OrderListQuery, '' );
   DataListGrid.Clear;
   DataListGrid.Add(OrderListQuery.FieldByName('OTYPE'), 'TYPE', 65, clPurple, [fsBold], taLeftJustify);
   DataListGrid.Add(OrderListQuery.FieldByName('ONUM'), 'ORDER #', 60, clBlack, [fsBold], tarightJustify);
   DataListGrid.Add(OrderListQuery.FieldByName('ODATE'), 'DATE', 90, clTeal, [fsBold], taRightJustify);
   DataListGrid.Add(OrderListQuery.FieldByName('ORGNAME'), 'ORG', 80, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(OrderListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(OrderListQuery.FieldByName('CUSTNAME'), 'CUSTOMER', 140, clNavy, [fsBold], taLeftJustify);
   DataListGrid.Add(OrderListQuery.FieldByName('DISPSTATUS'), 'STATUS', 75, $00000040, [fsBold], taLeftJustify);

   // Add the database preference header types
   AddHeaderType( Pref_GetInteger(tPrefConstants.INVLIST1, 1));
   AddHeaderType( Pref_GetInteger(tPrefConstants.INVLIST2, 2));
   AddHeaderType( Pref_GetInteger(tPrefConstants.INVLIST3, 3));
   AddHeaderType( Pref_GetInteger(tPrefConstants.INVLIST4, 4));
   AddHeaderType( Pref_GetInteger(tPrefConstants.INVLIST5, 5));

   //
   DataListGrid.ShowHint := True;
   DataListGrid.Hint := 'Right-Click for Options on any Order';
   //
   DataListGrid.OnDblClick := HandleDoubleClick;
   DataListGrid.PopupMenu := OrderOptionsMenu;
   //
   dbNavTool.Init( OrderListQuery );
   //
   ShowOrderTypesComboBox.Clear;
   ShowOrderTypesComboBox.Items.Add('OPEN');
   ShowOrderTypesComboBox.Items.Add('CLOSED');
   ShowOrderTypesComboBox.Items.Add('CANCELLED');
   ShowOrderTypesComboBox.Items.Add('ALL');
   ShowOrderTypesComboBox.ItemIndex := AvoINIReadInteger( AVOBASE_NAME, 'OLISTSOTC', 0);
   //
   SortViewComboBox.Clear;
   SortViewComboBox.Items.Add('LASTEST TO EARLIEST');
   SortViewComboBox.Items.Add('EARLIEST TO LATEST');
   SortViewComboBox.ItemIndex := AvoINIReadInteger( AVOBASE_NAME, 'OLISTSVC', 0);
   //
   SortTypeComboBox.Clear;
   SortTypeComboBox.Items.Add('ORDER NUMBER');
   SortTypeComboBox.Items.Add('CUSTOMER NAME');
   SortTypeComboBox.Items.Add('CYCLE');
   SortTypeComboBox.Items.Add('ORGANIZATION');
   SortTypeComboBox.Items.Add('STATUS');
   SortTypeComboBox.Items.Add('DATE');
   SortTypeComboBox.Items.Add('ORDER TYPE');
   SortTypeComboBox.ItemIndex := AvoINIReadInteger( AVOBASE_NAME, 'OLISTSTC', 0);
   //
   OrderListQuery.Open();
   UpdateOrderQuery();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.CreateReturnAgainstOrder1Click(Sender: TObject);
begin
	if ( OrderListQuery.RecordCount <> 0) then
      if Assigned(fReturnEvent) then
         fReturnEvent( OrderListQuery.FieldByName('ID').AsString );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.DBGotoID(inID: string);
begin
   UpdateOrderQuery();
   OrderListQuery.Locate('ID', inID, [loCaseInsensitive]);
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.EditCustomer1Click(Sender: TObject);
begin
   if Assigned( fOrderListEditCustomerEvent ) then
      fOrderListEditCustomerEvent( CustID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tOrderListForm.fGetCustID: string;
begin
   result := OrderListQuery.FieldByName('C_STID').AsString;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tOrderListForm.fGetOrderID: string;
begin
   result := OrderListQuery.FieldByname('ID').AsString;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tOrderListForm.fGetOrderRecCount: integer;
begin
	result := ( OrderListQuery.RecordCount );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   AvoINIWriteInteger( AVOBASE_NAME, 'OLISTSOTC', ShowOrderTypesComboBox.ItemIndex);
   AvoINIWriteInteger( AVOBASE_NAME, 'OLISTSVC', SortViewComboBox.ItemIndex);
   AvoINIWriteInteger( AVOBASE_NAME, 'OLISTSTC', SortTypeComboBox.ItemIndex);
   FreeAndNil(OrderListQuery);
   inherited;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.GlobalRefreshEvent;
var
   OrdID : string;
begin
   OrdID := OrderListQuery.FieldByName('ID').AsString;
   OrderListQuery.Refresh();
   OrderListQuery.Locate('ID', OrdID, [loCaseInsensitive]);
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(OrderListQuery.RecNo) + ' of ' + IntToStr(OrderListQuery.RecordCount);
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.UpdateOrderQuery;
var
	sortDir : string;
   orderBy : tOrderStatusTypes;
   fieldSort : string;
//  tOrderStatusTypes = (OrderStatusNone = 0, OrderOpen = 1, OrderClosed = 2, OrderCancelled = 3);
begin
   // Sort direction
   if ( SortViewComboBox.Text = 'LASTEST TO EARLIEST') then
      sortDir := 'DESC'
   else
      sortDir := '';
   // Show Order Types
   if ( ShowOrderTypesComboBox.Text = 'OPEN' ) then
      orderBy := OrderStatusOpen;
   if ( ShowOrderTypesComboBox.Text = 'CLOSED' ) then
      orderBy := OrderStatusClosed;
   if ( ShowOrderTypesComboBox.Text = 'CANCELLED' ) then
      orderBy := OrderStatusCancelled;
   if ( ShowOrderTypesComboBox.Text = 'ALL' ) then
      orderBy := OrderStatusNone;
   // Sort By
   if ( SortTypeComboBox.Text = 'STATUS' ) then
      fieldSort := 'STATUS';
   if ( SortTypeComboBox.Text = 'ORDER NUMBER' ) then
      fieldSort := 'ONUM';
   if ( SortTypeComboBox.Text = 'CUSTOMER NAME' ) then
      fieldSort := 'C.FNAME';
   if ( SortTypeComboBox.Text = 'ORGANIZATION' ) then
      fieldSort := 'ORG_ID';
   if ( SortTypeComboBox.Text = 'CYCLE' ) then
      fieldSort := 'S.CNAME';
   if ( SortTypeComboBox.Text = 'DATE' ) then
      fieldSort := 'ODATE';
   if ( SortTypeComboBox.Text = 'ORDER TYPE' ) then
      fieldSort := 'O_TYPE';
   //
   OrderListQuery.UpdateByOrderList( orderBy, fieldSort, sortDir);
end;

procedure tOrderListForm.viewOrderAccountClick(Sender: TObject);
begin
   if assigned( fViewOrderAccount ) then
      fViewOrderAccount();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.OrderFinalize;
begin
	if ( OrderListQuery.RecordCount <> 0) then
   if Assigned(fFinalizeOrderEvent) then
      fFinalizeOrderEvent( ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.OrderHelp;
begin
   AvoBaseHelp_Execute('OrderListForm');
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderLoad;
begin
	if ( OrderListQuery.RecordCount <> 0) then
	if Assigned(fLoadOrderEvent) then
   	fLoadOrderEvent( Self, ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.HandleDoubleClick(sender: tObject);
begin
	if ( OrderListQuery.RecordCount <> 0) then
	if Assigned(fLoadOrderEvent) then
   	fLoadOrderEvent( Self, ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderNew;
begin
   ShowMessage('OrderNew');
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderNSF;
begin
   ShowMessage('OrderNSF');
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderPayment;
begin
	if ( OrderListQuery.RecordCount <> 0) then
   if Assigned( fTakeMethodOfPaymentEvent) then
      fTakeMethodOfPaymentEvent( ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderPrintInvoice;
begin
   { we don't print  it here. only the order control form can do that. so we have to pass an event back. }
	if ( OrderListQuery.RecordCount <> 0) then
	if Assigned(fPrintInvoiceEvent) then
   	fPrintInvoiceEvent( Self, ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderReport;
begin
	if ( OrderListQuery.RecordCount <> 0) then
   ShowMessage('OrderReport');
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderReturn;
begin
	if ( OrderListQuery.RecordCount <> 0) then
	if Assigned(fReturnEvent) then
   	fReturnEvent( ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderViewInvoice;
begin
   { we don't view it here. only the order control form can do that. so we have to pass an event back. }
	if ( OrderListQuery.RecordCount <> 0) then
	if Assigned(fViewInvoiceEvent) then
   	fViewInvoiceEvent( Self, ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TOrderListForm.OrderVoidPayment;
begin
	if ( OrderListQuery.RecordCount <> 0) then
	if Assigned(fVoidPaymentEvent) then
   	fVoidPaymentEvent( ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.ordOpt_CanceLOrderClick(Sender: TObject);
begin
   OrderCancel();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.ordOpt_ChangeOrderCampaignClick(Sender: TObject);
begin
   OrderChangeSalesCycle();
end;

procedure tOrderListForm.ordOpt_EmailInvoiceClick(Sender: TObject);
begin
   if Assigned(fEmailEvent) then
      fEmailEvent( ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.ordOpt_LoadOrderClick(Sender: TObject);
begin
   OrderLoad();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.ordOpt_PrintInvoiceClick(Sender: TObject);
begin
   OrderPrintInvoice();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.ordOpt_UncancelOrderClick(Sender: TObject);
begin
   OrderUncancel();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.ordOpt_ViewInvoiceClick(Sender: TObject);
begin
   OrderViewInvoice();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

// Another form somewhere else updated something, so we need to refresh here
procedure tOrderListForm.Recalculate;
var
   OrdID : string;
begin
   PercentForm_Create('Refreshing Orders - One Moment Please...', 0, 0);
   OrdID := OrderListQuery.FieldByName('ID').AsString;
   OrderListQuery.Refresh();
   OrderListQuery.Locate('ID', OrdID, [loCaseInsensitive]);
   if Assigned( fOrderRefreshEvent ) then
      fOrderRefreshEvent();
   PercentForm_Free();
end;

procedure tOrderListForm.RefreshOrderList( inOrdID : string );
begin
   UpdateOrderQuery();
   OrderListQuery.Locate('ID', inOrdID, [loCaseInsensitive]);
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.VoidaPayment1Click(Sender: TObject);
begin
	if ( OrderListQuery.RecordCount <> 0) then
	if Assigned(fVoidPaymentEvent) then
   	fVoidPaymentEvent( ID );
end;

procedure tOrderListForm.CloseOrderReturnClick(Sender: TObject);
begin
   if Assigned(fCloseOrderEvent) then
      fCloseOrderEvent();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.akeaPayment1Click(Sender: TObject);
begin
	if ( OrderListQuery.RecordCount <> 0) then
   if Assigned( fTakeMethodOfPaymentEvent) then
      fTakeMethodOfPaymentEvent( ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.ComboBoxChange(Sender: TObject);
begin
   UpdateOrderQuery()
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.OrderChangeSalesCycle;
begin
   if Assigned( fChangeOrderCycleEvent ) then
      fChangeOrderCycleEvent();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.OrderUnCancel;
begin
	if ( OrderListQuery.RecordCount <> 0) then
   if Assigned( fCancelEvent) then
      fCancelEvent( CancelUnCancel, ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tOrderListForm.OrderCancel;
begin
	if ( OrderListQuery.RecordCount <> 0) then
   if Assigned( fCancelEvent) then
      fCancelEvent( CancelOrders, ID );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

end.

