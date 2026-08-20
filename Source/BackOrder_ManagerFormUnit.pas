 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit BackOrder_ManagerFormUnit;

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
   masterdata_BaseDataClassUnit,
   avobase_percentformunit,
   MasterData_ProductBOListUnit,
   AvoBase_ToolBarUnit,
   AvoBase_HelpFormUnit,
   Toolbox_OrgToolBoxUnit,
   toolbox_producttoolboxunit,
   //
   db,
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
   ExtCtrls,
   ComCtrls,
   ToolWin,
   ActnList,
   jpeg, Buttons;

type
   tBackOrder_ManagerForm = class(TAvobase_BaseForm_List)
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    searchButton: TSpeedButton;
    clearButton: TSpeedButton;
    SearchEdit: TEdit;
    Label1: TLabel;
    orgComboBox: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    top_menu_panel: TPanel;
    SortByComboBox: TComboBox;
    SortViewComboBox: TComboBox;
    Label2: TLabel;
    viewTypeCombo: TComboBox;
    procedure clearButtonClick(Sender: TObject);
    procedure SortByComboBoxChange(Sender: TObject);
    procedure SortViewComboBoxChange(Sender: TObject);
    procedure orgComboBoxChange(Sender: TObject);
    procedure searchButtonClick(Sender: TObject);
    procedure SearchEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure viewTypeComboChange(Sender: TObject);
   private
      fNewOrderWithCustomerEvent : tNewOrderWithCustomerEvent;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fPrintInvoiceEvent : tPrintInvoiceEvent;
      fLoadOrderEvent : tLoadOrderEvent;
      fTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent;
      fVoidPaymentEvent : tVoidPaymentEvent;
      fFinalizeOrderEvent : tFinalizeOrderEvent;
      fCancelEvent : tCancelEvent;
      fTakeMethodOfPaymentCustomerEvent : tTakeMethodOfPaymentCustomerEvent;
      fReturnEvent : tReturnEvent;
      fBackOrderNotAvailableEvent : tBackOrderNotAvailableEvent;
      fBackOrderDeliveredEvent : tBackOrderDeliveredEvent;
      //
      BOQuery : tMasterData_BaseDataClass;
      BOListQuery : tMasterData_ProductBOTempList;
      //
      ToolBar : tAvoBaseToolBar;

      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      //
      procedure UpdateBOQuery();
      procedure Recalculate();
      procedure BOReports();
      procedure BOHelp();
      procedure BackOrderNotAvailable();
      procedure BackOrderDelivered();
      //
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OnViewOrderInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OnPrintOrderInvoiceEvent : tPrintInvoiceEvent read fPrintInvoiceEvent write fPrintInvoiceEvent;
      property OnBackOrderNotAvailableEvent : tBackOrderNotAvailableEvent read fBackOrderNotAvailableEvent write fBackOrderNotAvailableEvent;
      property OnBackOrderDeliveredEvent : tBackOrderDeliveredEvent read fBackOrderDeliveredEvent write fBackOrderDeliveredEvent;
      //
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tBackOrder_ManagerForm.create(owner : TComponent);
begin
	inherited create( Nil, 'Back-Order Manager', true, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   ShowBorder := True;
   BASE_FORM_LABEL.Caption := 'Back-Order Manager';
   //
   BOListQuery := tMasterData_ProductBOTempList.Create( masterData);
   //
   BOQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_BackOrdered );
   //
   // These items are INHERITED from the AvoBase_BasweForm_StandardUnit
   // DataListGrid, gridDataSource, dbNavTool <-- all inherited
   gridDataSource.DataSet := BOListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( BOListQuery, 'NUM' );
   DataListGrid.Clear;
   DataListGrid.Add(BOListQuery.FieldByName('ORGNAME'), 'ORG', 60, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(BOListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(BOListQuery.FieldByName('ORDER'), 'ORDER', 60, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(BOListQuery.FieldByName('CUST'), 'CUST', 175, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(BOListQuery.FieldByName('NUM'), 'PRODUCT', 80, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(BOListQuery.FieldByName('NAME'), 'NAME', 140, clHighlight, [fsBold], taLeftJustify);
   DataListGrid.Add(BOListQuery.FieldByName('SQTY'), 'SQTY', 50, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(BOListQuery.FieldByName('YCOST'), 'YCOST', 40, clGreen, [fsBold], taRightJustify);
   DataListGrid.Add(BOListQuery.FieldByName('RCOST'), 'RETAIL', 40, clGreen, [fsBold], taRightJustify);
   DataListGrid.Add(BOListQuery.FieldByName('STAT'), 'STATUS', 120, clGreen, [fsBold], taLeftJustify);
   // DataListGrid.OnDblClick := HandleDoubleClick; <<--- not used, but here for ref just in case
   //
   dbNavTool.Init( BOListQuery );
   //
   ToolBar := tAvoBaseToolBar.Create( top_menu_panel );
   ToolBar.actionList.OnUpdate := HandleActionListUpdate;
   ToolBar.actionList.onActionEvent := HandleActionExecute;
   ToolBar.Align := alClient;
   ToolBar.CreateButton( CMD_CLOSE);
   ToolBar.CreateButtonSep;
   ToolBar.CreateButton( CMD_HELP);
   ToolBar.CreateButtonSep;
   ToolBar.CreateButton( CMD_ORDER_VIEWINVOICE );
   ToolBar.CreateButtonSep;
   ToolBar.CreateButton( CMD_BO_NOTAVAIL );
   ToolBar.CreateButton( CMD_BO_DELIVER );
   //
   Org_ComboBox_FillActiveOrgs( 'All', orgComboBox );
   //
   SortByComboBox.Items.Clear;
   SortByComboBox.Items.Add('ORGANIZATION');
   SortByComboBox.Items.Add('CYCLE');
   SortByComboBox.Items.Add('PRODUCT NUMBER');
   SortByComboBox.Items.Add('NAME');
   SortByComboBox.Items.Add('ORDER');
   SortByComboBox.ItemIndex := 4;
   //
   //
   viewTypeCombo.Items.Clear;
   viewTypeCombo.Items.Add('PENDING');
   viewTypeCombo.Items.Add('DELIVERED');
   viewTypeCombo.Items.Add('NOT AVAILABLE');
   viewTypeCombo.ItemIndex := 0;
   //
   UpdateBOQuery();
end;

{
         retVal := masterData.AddTable(masterData.dbPath + table_backordered,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_STID VARCHAR(40), ' + // sold to id
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'STATUS INTEGER, ' + // status : see tBackOrderStatus
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
}

destructor tBackOrder_ManagerForm.Destroy;
begin
	BOListQuery.Close();
   freeAndNil(BOListQuery);
   FreeAndNil(BOQuery);
   FreeAndNil(ToolBar);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.HandleActionExecute(sender: tObject;
  actionID: integer);
begin
   case actionID of
      CMD_CLOSE : Close();
      CMD_HELP : AvoBaseHelp_Execute('BackOrder_ManagerForm');
      CMD_ORDER_VIEWINVOICE:
      begin
         if Assigned( fViewInvoiceEvent ) then
            fViewInvoiceEvent( Self, BOlistQuery.FieldByName('ORDER_ID').AsString);
         Close();
      end;
      CMD_BO_NOTAVAIL: BackOrderNotAvailable();
      CMD_BO_DELIVER: BackOrderDelivered();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.HandleActionListUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_ORDER_VIEWINVOICE,
         CMD_BO_NOTAVAIL,
         CMD_BO_DELIVER : enabled := (BOListQuery.RecordCount <> 0) AND ( BOListQuery.FieldByname('STATUS').AsInteger = integer(BOSPending));
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(BOListQuery.RecNo) + ' of ' + IntToStr(BOListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.orgComboBoxChange(Sender: TObject);
begin
   UpdateBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.Recalculate;
var
   findID : string;
begin
   findID := BOListQuery.FieldByName('ID').AsString;
   BOListQuery.Close();
   BOListQuery.Open();
   BOListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.searchButtonClick(Sender: TObject);
begin
   UpdateBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if ( Key = VK_RETURN ) then
      UpdateBOQuery()
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.SortByComboBoxChange(Sender: TObject);
begin
   UpdateBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.SortViewComboBoxChange(Sender: TObject);
begin
   UpdateBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.UpdateBOQuery;
begin
   // first to last, or last to first?
	if (SortViewComboBox.ItemIndex = 0) then
      BOListQuery.SortOption := 'DESC'
   else
      BOListQuery.SortOption := '';
   //
   BOListQuery.SearchText := ProperCase(SearchEdit.Text, True);
   //   tSortProdTypes = (ProdOrg, ProdCycle, ProdNum, ProdName, ProdQTY, ProdAmount);
   case SortByComboBox.ItemIndex of
   	0 : BOListQuery.SortType := ProdOrg;
   	1 : BOListQuery.SortType := ProdCycle;
   	2 : BOListQuery.SortType := ProdNum;
   	3 : BOListQuery.SortType := ProdName;
   	4 : BOListQuery.SortType := ProdOrder;
   end;
   //
   case viewTypeCombo.ItemIndex of
      0 : BOListQuery.StatusType := BOSPending;
      1 : BOListQuery.StatusType := BOSDelivered;
      2 : BOListQuery.StatusType := BOSNotAvail;
   end;
   //
   BOListQuery.Update();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.viewTypeComboChange(Sender: TObject);
begin
   UpdateBOQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.BackOrderDelivered;
var
   oldID : string;
   prodNum : string;
   prodName : string;
begin
   if ( BOListQuery.FieldByname('STATUS').AsInteger = integer(BOSPending)) then
   begin
      prodNum := Product_GetBackOrderProdNumByID( BOListQuery.FieldByName('ID').AsString );
      prodName := Product_GetBackOrderProdNameByID( BOListQuery.FieldByName('ID').AsString );
      if AvoBaseDialog('Confirm Product Delivered',
         'Product # ' + prodNum + ' "' + prodName + '"' + #13 + #13 +
         'Confirm setting this Product to Delivered?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
      begin
         if ( BoListQuery.FieldByName('STATUS').AsInteger <> integer(BOSPending)) then
         begin
            AvoBaseDialog('Back-Order Status',
               'This Product has already been set to Delivered or Not Available. It cannot be changed.', mtError, [mbOk], 0);
         end else
            begin
               //      tBackOrderStatus = ( BOSPending = 0, BOSDelivered = 1, BOSNotAvail );
               oldID := BOListQuery.FieldByName('ID').AsString;
               //
               if Assigned( fBackOrderDeliveredEvent ) then
                  fBackOrderDeliveredEvent( BOListQuery.FieldByName('OPT_ID').AsString, BOListQuery.FieldByName('ID').AsString );
               //
               UpdateBOQuery();
               BOListQuery.Locate('ID', oldID, [loCaseInsensitive]);
            end;
      end;
   end else
      AvoBaseDialog('Cannot Mark Product',
         'This Product has already been marked as either Delivered or Not Available. It is viewable for information only.', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.BackOrderNotAvailable;
var
   oldID : string;
   prodNum : string;
   prodName : string;
begin
   if ( BOListQuery.FieldByname('STATUS').AsInteger = integer(BOSPending)) then
   begin
      prodNum := Product_GetBackOrderProdNumByID( BOListQuery.FieldByName('ID').AsString );
      prodName := Product_GetBackOrderProdNameByID( BOListQuery.FieldByName('ID').AsString );
      if AvoBaseDialog('Confirm Product Not Available',
         'Product # ' + prodNum + ' "' + prodName + '"' + #13 + #13 +
         'Confirm setting this Product to Not Available?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
      begin
         if ( BoListQuery.FieldByName('STATUS').AsInteger <> integer(BOSPending)) then
         begin
            AvoBaseDialog('Back-Order Status',
               'This Product has already been set to Delivered or Not Available. It cannot be changed.', mtError, [mbOk], 0);
         end else
            begin
               oldID := BOListQuery.FieldByName('ID').AsString;
               //
               if Assigned(fBackOrderNotAvailableEvent) then
                  fBackOrderNotAvailableEvent( BOListQuery.FieldByName('OPT_ID').AsString, BOListQuery.FieldByName('ID').AsString );
               //
               UpdateBOQuery();
               BOListQuery.Locate('ID', oldID, [loCaseInsensitive]);
            end;
      end;
   end else
      AvoBaseDialog('Cannot Mark Product',
         'This Product has already been marked as either Delivered or Not Available. It is viewable for information only.', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.BOHelp;
begin
	showmessage('HELP');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.BOReports;
begin
	showmessage('REPORT');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tBackOrder_ManagerForm.clearButtonClick(Sender: TObject);
begin
   SearchEdit.Text := '';
   UpdateBOQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.

