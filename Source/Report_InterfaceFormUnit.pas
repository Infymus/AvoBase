 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

// ALL REPORT INITIALIZERS ARE CREATED FROM THIS FORM.

unit Report_InterfaceFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   recordstructureunit,
   actionunit,
   masterdata_basegridunit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   toolbox_customertoolboxunit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   avobase_toolbarunit,
   Report_BaseForm,
   toolbox_orgtoolboxunit,
   VerificationUnit,
   toolbox_cycletoolboxunit,
   toolbox_earningtoolboxunit,
   toolbox_expensetoolboxunit,
   toolbox_producttoolboxunit,
   MasterData_CustomerListUnit,
   AvoBase_HelpFormUnit,
   ShellAPI,
   //
   // The Reports
   // -----------------------------------------------
   Report_CustomerListUnit,
   Report_CustomerTopCustomerByOrdersFormUnit,
   Report_CustomerTopCustomerByOrderAmountFormUnit,
   Report_Customer_OrderTransactionHistoryFormUnit,
   Report_Customer_OrderHistoryFormUnit,
   Report_Customer_SingleCustomerFormUnit,
   Report_Customer_LabelsFormUnit,
   Report_Cycle_CycleListByOrgFormUnit,
   Report_OrderListFormUnit,
   Report_Order_LabelsFormUnit,
   Report_Order_OrderProductFormUnit,
   Report_Order_BackOrderListFormUnit,
   Report_Earning_TypesFormUnit,
   Report_Earning_EarningByCycleFormUnit,
   Report_Earning_ListByCycleFormUnit,
   Report_Expense_TypeFormUnit,
   Report_Expense_ByCycleFormUnit,
   Report_Expense_ListByCycleFormUnit,
   Report_EarningVsExpenseByCycleFormUnit,
   Report_Product_SingleProductFormUnit,
   Report_Product_QuantityOnHandFormUnit,
   Report_Product_ProductListFormUnit,
   Report_Accounting_FeesCollectedByCycleFormUnit,
   Report_Accounting_ShippingCollectedByCycleFormUnit,
   Report_Accounting_TaxesCollectedByCycleFormUnit,
   Report_Accounting_DepositSlipByCycleFormUnit,
   Report_Accounting_VoidNSFByCycleFormUnit,
   Report_Accounting_ReturnsByCycleFormUnit,
   Report_Accounting_TransactionLogByCycleFormUnit,
   Report_Accounting_TaxExemptByCycleFormUnit,
   Report_Accounting_ShippingReturnedFormUnit,
   Report_Accounting_FeesReturnedFormUnit,
   Report_Product_ReturnProductListFormUnit,
   Report_Customer_OutstandingBalanceFormUnit,
   Report_Accounting_OrderBreakDownByCycleFormUnit,
   Report_Customer_EscrowBalances,
   // -----------------------------------------------
	//
   QuickRpt,
   Qrctrls,
   QRPDFFilt,
   QRWebFilt,
   QRExport,
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


// -----------------------------------------------------
type
   tReportTypes = (
      Report_Customer_List,
      Report_Customer_TopCustByOrd,
      Report_Customer_TopCustByMoney,
      Report_Customer_OrderTransactionHistory,
      Report_Customer_OrderHistory,
      Report_Customer_SingleCustomer,
      Report_Customer_Labels,
      Report_Customer_OutstandingBalance,
      Report_Customer_EscrowBalance,
      //
      Report_Cycle_CycleListByOrg,
      //
      Report_Order_List,
      Report_Order_Labels,
      Report_Order_BackOrderList,
      Report_Order_OrderProductList,
      //
      Report_Earning_Types,
      Report_Earning_EarningByCycle,
      Report_Earning_ListByCycle,
      //
      Report_Expense_Type,
      Report_Expense_ByCycle,
      Report_Expense_ListByCycle,
      Report_EarningVsExpenseByCycle,
      //
      Report_Product_SingleProduct,
      Report_Product_QTYOnHand,
      Report_Product_ReturnProductList,
      Report_Product_ProductList,
      //
      Report_Accounting_FeesCollectedByCycle,
      Report_Accounting_ShippingCollectedByCycle,
      Report_Accounting_TaxesCollectedByCycle,
      Report_Accounting_TaxExemptByCycle,
      Report_Accounting_DepositSlipByCycle,
      Report_Accounting_VoidNSFByCycle,
      Report_Accounting_ReturnsByCycle,
      Report_Accounting_ShippingReturned,
      Report_Accounting_FeesReturned,
      Report_Accounting_TransactionLogByCycle,
      Report_Accounting_OrderAmountBreakDownByCycle
      );
// -----------------------------------------------------

type
   tReport_InterfaceForm = class(TForm)
       BASEFORM_DOCK: TPanel;
       BASEFORM_BACK_PANEL: TPanel;
       BASE_DOCK_PANEL: TPanel;
       MENU_PANEL: TPanel;
       BAND_CustomerList: TPanel;
       CUST_BOT_SEP_PANEL: TPanel;
       CustListOpt: TRadioGroup;
       BASE_FORM_TOP_PANEL: TPanel;
       REPORT_CAPTION: TLabel;
       BASE_LABEL_SEP_PANEL: TPanel;
       fSave: TSaveDialog;
       BAND_SelectOrgAndCycle: TPanel;
       Panel2: TPanel;
    BAND_No_Options: TPanel;
    CUST_SINGLE_PANEL: TPanel;
    custGroupBox: TGroupBox;
    CustSoldToName: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToPhone: TLabel;
    noOptionsGroupBox: TGroupBox;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    info_label: TLabel;
    GroupBox_SalesOrgs: TGroupBox;
    orgLabel: TLabel;
    SelectOrgCycle_Org: TComboBox;
    GroupBox_StartSalesCycle: TGroupBox;
    campYearLabel: TLabel;
    CycleNumLabel: TLabel;
    SelectOrgCycle_CycleStartNum: TComboBox;
    SelectOrgCycle_CycleStartYear: TComboBox;
    GroupBox_EndSalesCycle: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    SelectOrgCycle_CycleEndNum: TComboBox;
    SelectOrgCycle_CycleEndYear: TComboBox;
    Label1: TLabel;
    BAND_SelectCustomer: TPanel;
    SelectCustGroupBox: TGroupBox;
    CUST_LIST_DOCK_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
    BAND_PRODUCTRETURNLIST: TPanel;
    ProductReturnListGroupBox: TGroupBox;
    db_pr_restocked: TCheckBox;
    db_pr_returned: TCheckBox;
    db_pr_pend: TCheckBox;
    Label3: TLabel;
    BAND_PRODUCTLIST_OPTIONS: TPanel;
    sortProdListGroup: TRadioGroup;
    BAND_ODRER_LABELS: TPanel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label4: TLabel;
    printLabelTypeCombo: TComboBox;
    SkipRows: TComboBox;
    Label5: TLabel;
    db_inv1: TComboBox;
    Label6: TLabel;
    db_inv2: TComboBox;
    Label10: TLabel;
    db_inv3: TComboBox;
    Label11: TLabel;
    db_inv4: TComboBox;
    Label12: TLabel;
    db_inv5: TComboBox;
    Label13: TLabel;
    db_sonum: TEdit;
    GroupBox3: TGroupBox;
    label_prev1: TLabel;
    label_prev2: TLabel;
    label_prev3: TLabel;
    label_prev4: TLabel;
    label_prev5: TLabel;
    BAND_UNREG: TPanel;
    UnRegGroupBox: TGroupBox;
    UnRegLabel: TLabel;
    RegisterButton: TSpeedButton;
    UnRegWeb: TLabel;
    BAND_ORDER_TYPE_OPTIONS: TPanel;
    GroupBox4: TGroupBox;
    db_orderoptions_open: TCheckBox;
    db_orderoptions_closed: TCheckBox;
    db_orderoptions_cancelled: TCheckBox;
       procedure SelectOrgCycle_OrgChange(Sender: TObject);
       procedure GroupBox_StartSalesCycleClick(Sender: TObject);
       procedure SelectOrgCycle_CycleStartYearChange(Sender: TObject);
       procedure SelectOrgCycle_CycleEndYearChange(Sender: TObject);
      //
      procedure fSetCustID( inID : string );
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure db_sonumKeyPress(Sender: TObject; var Key: Char);
    procedure db_inv5Change(Sender: TObject);
    procedure RegisterButtonClick(Sender: TObject);
   private
      Zj3gwT : string;
      j3gT3 : string;
      custListGrid : tAvoBaseDBGrid;
      custgridDataSource : tDataSource;
      dbNavTool : tAvoBaseDBNavigationTool;
      custListQuery : tMasterDataCustomerList;
      custQuery : tMasterData_BaseDataClass;
      fCustID : string;
      fReportType : tReportTypes;
      //
      MenuToolBar : tAvoBaseToolBar;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      function fGetCycleStartID : string;
      function fGetCycleEndID : string;
      function fGetOrgIDCycleStartEnd : string;
      function fGetCycleOrgID : string;
      function fGetCustListID : string;
      function fGetSortProdType : tSortProdTypes;
      function fGetPrintLabelType : tPrintLabelTypes;
      procedure Add_Label_Items( VAR inCombo : tComboBox );
      function GetLabelOptionValue( inIndex : integer ) : string;
   public
      procedure StartReportInterface();
      //
      procedure ViewReport( ViewType : tReportSelectType );
      procedure HelpReport( ViewType : tReportSelectType );
      procedure CloseForm();
      procedure Customer_Select_Startup();
      //
      property Cycle_StartID : string read fGetCycleStartID;
      property Cycle_EndID : string read fGetCycleEndID;
      property OrgID_CycleStartEnd : string read fGetOrgIDCycleStartEnd;
      property CustID : string read fCustID write fSetCustID;
      property CycleOrgID : string read fGetCycleOrgID;
      property CustListID : string read fGetCustListID;
      property PrintLabelType : tPrintLabelTypes read fGetPrintLabelType;
      property ProdSortType : tSortProdTypes read fGetSortProdType;
      //
      constructor Create(owner : tComponent; inReportType : tReportTypes );  overload;
      destructor Destroy; override;
   end;

implementation

{$R *.dfm}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

constructor tReport_InterfaceForm.Create(owner : tComponent; inReportType : tReportTypes );
begin
	inherited create( Owner );
   //
   fReportType := inReportType;
   //
   MenuToolBar := tAvoBaseToolBar.Create( MENU_PANEL );
   MenuToolBar.actionList.OnUpdate := HandleActionListUpdate;
   MenuToolBar.actionList.onActionEvent := HandleActionExecute;
   MenuToolBar.Align := alLeft;
   MenuToolBar.Wrapable := True;
   MenuToolBar.AutoSize := True;
   //
   //
   MenuToolBar.CreateButton( CMD_CLOSE );
   MenuToolBar.CreateButtonSep();
   MenuToolBar.CreateButton( CMD_HELP );
   MenuToolBar.CreateButtonSep();
   MenuToolBar.CreateButton( CMD_SAVE );
   MenuToolBar.CreateButton( CMD_PRINT_PRINT );
   MenuToolBar.CreateButton( CMD_PRINT_PREVIEW );
{
   MenuToolBar.CreateButtonSep();
   MenuToolBar.CreateButton( CMD_PRINT_SETUP );
}
   //
   info_label.Caption := 'First select a Sales Organization - then, select a ' +
      'Sales Cycle Year and Sales Cycle Number within that Sales Organization.';
   // Org Start/End Cycle Selection
   Org_ComboBox_FillActiveOrgs_WithCycles( SelectOrgCycle_Org );
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), SelectOrgCycle_CycleStartYear );
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), SelectOrgCycle_CycleEndYear );
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleStartYear.Text), SelectOrgCycle_CycleStartNum );
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleEndYear.Text), SelectOrgCycle_CycleEndNum );
   //
   //
   StartReportInterface();
end;

destructor tReport_InterfaceForm.Destroy;
begin
   FreeAndNil(MenuToolBar);
   //
   if ( dbNavTool <> NIL ) then
      FreeAndNil( dbNavTool );
   //
   if ( custgridDataSource <> NIL ) then
      FreeAndNil( custgridDataSource );
   //
   if ( custListGrid <> NIL ) then
      FreeAndNil( custListGrid );
   //
   if ( custListQuery <> NIL ) then
      FreeAndNil( custListQuery );
   //
	inherited
end;

procedure tReport_InterfaceForm.Customer_Select_Startup;
begin
   BAND_SelectCustomer.Visible := true;
   BAND_SelectCustomer.Align := alClient;
   //
   custgridDataSource := tDataSource.Create(nil);
   custListGrid := tAvoBaseDBGrid.Create( nil, CUST_LIST_DOCK_PANEL );
   dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL );
   custListQuery := tMasterDataCustomerList.Create( masterData);
   custgridDataSource.DataSet := custListQuery;
   //
   custListGrid.Init( custListQuery, 'FNAME' );
   custListGrid.Clear;
   custListGrid.Add(custListQuery.FieldByName('FULLNAME'), 'CUSTOMER NAME', 150, clRed, [fsBold], taLeftJustify);
   custListGrid.Add(custListQuery.FieldByName('PHONEH'), 'PHONE', 110, clHighlight, [], taLeftJustify);
   custListGrid.Add(custListQuery.FieldByName('PHONEC'), 'CELL', 110, clHighlight, [], taLeftJustify);
   custListGrid.Add(custListQuery.FieldByName('FULLADDR'), 'ADDRESS', 250, clBlack, [], taLeftJustify);
   custListGrid.Add(custListQuery.FieldByName('TOTO'), 'OPEN', 60, clGreen, [], taRightJustify);
   custListGrid.Add(custListQuery.FieldByName('TOTC'), 'CLOSED', 60, clGreen, [], taRightJustify);
   custListGrid.Add(custListQuery.FieldByName('BOT'), 'B/O', 60, clGreen, [], taRightJustify);
   //custListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( custListQuery );
   custListQuery.Update('FNAME', '', tActiveStates.stateAll ); // we want to show inactives too...
   //
   Add_Label_Items( db_inv1 );
   Add_Label_Items( db_inv2 );
   Add_Label_Items( db_inv3 );
   Add_Label_Items( db_inv4 );
   Add_Label_Items( db_inv5 );
   //
   db_inv5Change( Self );
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

// START AND END CYCLE IDS, COMBO BOXES

procedure tReport_InterfaceForm.Add_Label_Items( VAR inCombo : tComboBox );
begin
   with inCombo.Items do
   begin
      Clear();
      Add('REPRESENTATIVE NAME');
      Add('ADDRESS LINE 1');
      Add('ADDRESS LINE 2');
      Add('EMAIL ADDRESS');
      Add('CITY, STATE/PROVICE, ZIP/POSTAL CODE');
      Add('PHONE');
   end;
   inCombo.ItemIndex := 0;
end;

function tReport_InterfaceForm.GetLabelOptionValue( inIndex : integer ) : string;
begin
   result := 'TBD';
end;

procedure tReport_InterfaceForm.db_inv5Change(Sender: TObject);
begin
   label_prev1.Caption := GetLabelOptionValue( 0 );
   label_prev2.Caption := GetLabelOptionValue( 1 );
   label_prev3.Caption := GetLabelOptionValue( 2 );
   label_prev4.Caption := GetLabelOptionValue( 3 );
   label_prev5.Caption := GetLabelOptionValue( 4 );
end;

procedure tReport_InterfaceForm.db_sonumKeyPress(Sender: TObject; var Key: Char);
var
   p : integer;
begin
   case Key of
      '0'..'9', #8  : ;
      else key := #0;
   end;
end;

function tReport_InterfaceForm.fGetCustListID: string;
begin
   if ( custListQuery <> NIL ) then
      result := custListQuery.FieldByName('ID').AsString;
end;

function tReport_InterfaceForm.fGetCycleEndID: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( SelectOrgCycle_CycleEndYear.Text );
   cycleRec.Num := StrToInt( SelectOrgCycle_CycleEndNum.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( SelectOrgCycle_Org.Text, cycleRec.Year, cycleRec.Num );
   //
   result := C_ID;
end;

function tReport_InterfaceForm.fGetCycleOrgID: string;
begin
   if ( SelectOrgCycle_Org.Text = 'ALL' ) then
      result := 'ALL'
   else
      result := Org_GetOrgIDByOrgName( SelectOrgCycle_Org.Text );
end;

function tReport_InterfaceForm.fGetCycleStartID: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( SelectOrgCycle_CycleStartYear.Text );
   cycleRec.Num := StrToInt( SelectOrgCycle_CycleStartNum.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( SelectOrgCycle_Org.Text, cycleRec.Year, cycleRec.Num );
   //
   result := C_ID;
end;

function tReport_InterfaceForm.fGetOrgIDCycleStartEnd: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( SelectOrgCycle_CycleStartYear.Text );
   cycleRec.Num := StrToInt( SelectOrgCycle_CycleStartNum.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( SelectOrgCycle_Org.Text, cycleRec.Year, cycleRec.Num );
   //
   result := C_ID;
end;

function tReport_InterfaceForm.fGetPrintLabelType: tPrintLabelTypes;
begin
{
5160 (1" x 2.63")
5161 (1" x 4")
18160 (1" x 2/58")
}
   case ( printLabelTypeCombo.ItemIndex ) of
      0 : result := tPrintLabelTypes.type5160;
      1 : result := tPrintLabelTypes.type5161;
      2 : result := tPrintLabelTypes.type18160;
   end;
end;

function tReport_InterfaceForm.fGetSortProdType: tSortProdTypes;
begin
   case ( sortProdListGroup.ItemIndex ) of
      0 : result := tSortProdTypes.ProdCycle;
      1 : result := tSortProdTypes.ProdNum;
      2 : result := tSortProdTypes.ProdName;
      3 : result := tSortProdTypes.ProdQTY;
      4 : result := tSortProdTypes.ProdAmount;
   end;
end;

procedure tReport_InterfaceForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure tReport_InterfaceForm.fSetCustID(inID: string);
var
   custRec : tCustRec;
begin
   fCustID := inID;
   // now fill in any item that is using a customer passed ID
   CustRec := Customer_GetCustomerByCustID( fCustID );
   //
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
      CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
end;

procedure tReport_InterfaceForm.SelectOrgCycle_CycleEndYearChange( Sender: TObject);
begin
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleEndYear.Text), SelectOrgCycle_CycleEndNum );
end;

procedure tReport_InterfaceForm.SelectOrgCycle_CycleStartYearChange( Sender: TObject);
begin
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleStartYear.Text), SelectOrgCycle_CycleStartNum );
end;

procedure tReport_InterfaceForm.SelectOrgCycle_OrgChange(Sender: TObject);
begin
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), SelectOrgCycle_CycleStartYear );
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), SelectOrgCycle_CycleEndYear );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleStartYear.Text), SelectOrgCycle_CycleStartNum );
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleEndYear.Text), SelectOrgCycle_CycleEndNum );
end;


// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //


procedure tReport_InterfaceForm.GroupBox_StartSalesCycleClick(Sender: TObject);
begin

end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tReport_InterfaceForm.CloseForm;
begin
   Close();
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tReport_InterfaceForm.HandleActionExecute(sender: tObject;
  actionID: integer);
begin
   case actionID of
      CMD_CLOSE : CloseForm();
      CMD_PRINT_PREVIEW: ViewReport( ReportSelectTypeView );
      CMD_PRINT_PRINT: ViewReport( ReportSelectTypePrint );
      CMD_SAVE: ViewReport( ReportSelectTypeSave );
      CMD_PRINT_SETUP : showmessage('Setup Not Coded');
      CMD_HELP : HelpReport( ReportSelectTypeView );
   end;
end;

procedure tReport_InterfaceForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;
   with Action as tAction do
   case tag of
      CMD_PRINT_PREVIEW, CMD_PRINT_PRINT, CMD_SAVE, CMD_PRINT_SETUP:
         if ( zj3gwT <> '0-=' ) AND (j3gT3 = '*') then
            enabled := false
         else
            enabled := true;
   end;
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //


procedure tReport_InterfaceForm.HelpReport(ViewType: tReportSelectType);
begin
   AvoBaseHelp_Execute('REPORT_HELP_GENERAL');
{ Add this stuff later....
   case fReportType of
      Report_Customer_List : AvoBaseHelp_Execute('Report_Customer_List');
      Report_Customer_TopCustByOrd : AvoBaseHelp_Execute('Report_Customer_TopCustByOrd');
      Report_Customer_TopCustByMoney : AvoBaseHelp_Execute('Report_Customer_TopCustByMoney');
      Report_Customer_OrderTransactionHistory : AvoBaseHelp_Execute('Report_Customer_OrderTransactionHistory');
      Report_Customer_OrderHistory : AvoBaseHelp_Execute('Report_Customer_OrderHistory');
      Report_Customer_SingleCustomer : AvoBaseHelp_Execute('Report_Customer_SingleCustomer');
      Report_Customer_Labels : AvoBaseHelp_Execute('Report_Customer_Labels');
      Report_Cycle_CycleListByOrg : AvoBaseHelp_Execute('Report_Cycle_CycleListByOrg');
      Report_Order_List : AvoBaseHelp_Execute('Report_Order_List');
      Report_Order_Labels : AvoBaseHelp_Execute('Report_Order_Labels');
      Report_Order_BackOrderList : AvoBaseHelp_Execute('Report_Order_BackOrderList');
      Report_Order_OrderProductList : AvoBaseHelp_Execute('Report_Order_OrderProductList');
      Report_Earning_Types : AvoBaseHelp_Execute('Report_Earning_Types');
      Report_Earning_EarningByCycle : AvoBaseHelp_Execute('Report_Earning_EarningByCycle');
      Report_Earning_ListByCycle : AvoBaseHelp_Execute('Report_Earning_ListByCycle');
      Report_Expense_Type : AvoBaseHelp_Execute('Report_Expense_Type');
      Report_Expense_ByCycle : AvoBaseHelp_Execute('Report_Expense_ByCycle');
      Report_Expense_ListByCycle : AvoBaseHelp_Execute('Report_Expense_ListByCycle');
      Report_EarningVsExpenseByCycle : AvoBaseHelp_Execute('Report_EarningVsExpenseByCycle');
      Report_Product_SingleProduct : AvoBaseHelp_Execute('Report_Product_SingleProduct');
      Report_Product_QTYOnHand : AvoBaseHelp_Execute('Report_Product_QTYOnHand');
      Report_Product_ReturnProductList : AvoBaseHelp_Execute('Report_Product_ReturnProductList');
      Report_Product_ProductList : AvoBaseHelp_Execute('Report_Product_ProductList');
      Report_Accounting_FeesCollectedByCycle : AvoBaseHelp_Execute('Report_Accounting_FeesCollectedByCycle');
      Report_Accounting_ShippingCollectedByCycle : AvoBaseHelp_Execute('Report_Accounting_ShippingCollectedByCycle');
      Report_Accounting_TaxesCollectedByCycle : AvoBaseHelp_Execute('Report_Accounting_TaxesCollectedByCycle');
      Report_Accounting_TaxExemptByCycle : AvoBaseHelp_Execute('Report_Accounting_TaxExemptByCycle');
      Report_Accounting_DepositSlipByCycle : AvoBaseHelp_Execute('Report_Accounting_DepositSlipByCycle');
      Report_Accounting_VoidNSFByCycle : AvoBaseHelp_Execute('Report_Accounting_VoidNSFByCycle');
      Report_Accounting_ReturnsByCycle : AvoBaseHelp_Execute('Report_Accounting_ReturnsByCycle');
      Report_Accounting_ShippingReturned : AvoBaseHelp_Execute('Report_Accounting_ShippingReturned');
      Report_Accounting_FeesReturned : AvoBaseHelp_Execute('Report_Accounting_FeesReturned');
      Report_Accounting_TransactionLogByCycle : AvoBaseHelp_Execute('Report_Accounting_TransactionLogByCycle');
   end;
}
end;

procedure tReport_InterfaceForm.RegisterButtonClick(Sender: TObject);
   function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
   begin
     Result := ShellExecute(Application.MainForm.Handle, nil, PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
   end;
begin
   if AvoBaseDialog(#80 + #117 + #114 + #99 + #104 + #97 + #115 + #101 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 {Purchase AvoBase},
      #84 + #104 + #105 + #115 + #32 + #119 + #105 + #108 + #108 + #32 + #111 + #112 + #101 + #110 +
      #32 + #121 + #111 + #117 + #114 + #32 + #102 + #97 + #118 + #111 + #114 + #105 + #116 + #101 +
      #32 + #98 + #114 + #111 + #119 + #115 + #101 + #114 + #32 + #97 + #110 + #100 + #32 + #116 +
      #97 + #107 + #101 + #32 + #121 + #111 + #117 + #32 + #116 + #111 + #32 + #116 + #104 +
      #101 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #80 + #117 + #114 +
      #99 + #104 + #97 + #115 + #101 + #32 + #97 + #114 + #101 + #97 + #46 + #92 + #110 +
      #92 + #110 + #87 + #101 + #32 + #97 + #114 + #101 + #32 + #80 + #114 + #101 + #109 +
      #105 + #117 + #109 + #32 + #80 + #97 + #121 + #80 + #97 + #108 + #32 + #86 + #101 +
      #114 + #105 + #102 + #105 + #101 + #100 + #32 + #97 + #110 + #100 + #32 + #83 +
      #101 + #99 + #117 + #114 + #101 + #100 + #46 + #32 + #89 + #111 + #117 + #114 + #32 +
      #116 + #114 + #97 + #110 + #115 + #97 + #99 + #116 + #105 + #111 + #110 + #115 + #32 +
      #97 + #114 + #101 + #32 + #103 + #117 + #97 + #114 + #97 + #110 + #116 + #101 + #101 +
      #100 + #32 + #111 + #114 + #32 + #121 + #111 + #117 + #114 + #32 + #109 + #111 + #110 +
      #101 + #121 + #32 + #98 + #97 + #99 + #107 + #46 + #92 + #110 + #92 + #110 + #87 +
      #101 + #32 + #103 + #114 + #101 + #97 + #116 + #108 + #121 + #32 + #97 + #112 +
      #112 + #114 + #101 + #99 + #105 + #97 + #116 + #101 + #32 + #121 + #111 + #117 +
      #114 + #32 + #98 + #117 + #115 + #105 + #110 + #101 + #115 + #115 + #33 + #92 +
      #110 + #92 + #110 + #86 + #105 + #115 + #105 + #116 + #32 + #116 + #104 + #101 +
      #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #87 + #101 + #98 + #115 +
      #105 + #116 + #101 + #63, {This will open your favorite browser and take you to the
      AvoBase Purchase area.\n\nWe are Premium PayPal Verified and Secured. Your transactions are guaranteed or
      your money back.\n\nWe greatly appreciate your business!\n\nVisit the AvoBase Website?}
      mtConfirmation, [mbyes, mbno], 0 ) = mbyes then
   begin
      ExecuteFile(AVOBASE_PURCHASE, '', '', 0);
   end;
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tReport_InterfaceForm.StartReportInterface;
//var ObjVerf : tKeyVerif;
begin
   // Initialize by turning the bands OFF
   { DO NOT FORGET TO SET THESE VISABLES BELOW IN THE REGISTRATION SECTION!! }
   BAND_CustomerList.Visible := false;
   BAND_SelectOrgAndCycle.Visible := false;
   BAND_No_Options.Visible := False;
   CUST_SINGLE_PANEL.Visible := False;
   BAND_SelectCustomer.Visible := False;
   BAND_PRODUCTRETURNLIST.visible := false;
   BAND_PRODUCTLIST_OPTIONS.Visible := false;
   BAND_ODRER_LABELS.Visible := False;
   BAND_UNREG.Visible := false;
   BAND_ORDER_TYPE_OPTIONS.Visible := false;
   { DO NOT FORGET TO SET THESE VISABLES BELOW IN THE REGISTRATION SECTION!! }
   Zj3gwT := '0-=';
   //
   UnRegGroupBox.Caption := #85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 +
      #101 + #100 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101; {Unregistered AvoBase}
   UnRegLabel.Caption := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #105 + #115 + #32 +
      #85 + #78 + #82 + #69 + #71 + #73 + #83 + #84 + #69 + #82 + #69 + #68 + #46 + #32 + #84 +
      #104 + #105 + #115 + #32 + #82 + #101 + #112 + #111 + #114 + #116 + #32 + #105 + #115 +
      #32 + #111 + #110 + #108 + #121 + #32 + #97 + #118 + #97 + #105 + #108 + #97 + #98 + #108 +
      #101 + #32 + #116 + #111 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 +
      #101 + #100 + #32 + #86 + #101 + #114 + #115 + #105 +
      #111 + #110 + #115 + #46; {AvoBase is UNREGISTERED. This Report is only available to Registered Versions.}
   UnRegWeb.Caption := #87 + #101 + #32 + #97 + #112 + #112 + #114 + #101 + #99 + #105 + #97 + #116 + #101 +
      #32 + #116 + #104 + #97 + #116 + #32 + #121 + #111 + #117 + #32 + #104 + #97 + #118 + #101 + #32 + #116 +
      #97 + #107 + #101 + #110 + #32 + #116 + #104 + #101 + #32 + #116 + #105 + #109 + #101 + #32 + #116 + #111 +
      #32 + #100 + #111 + #119 + #110 + #108 + #111 + #97 + #100 + #44 + #32 + #105 + #110 + #115 + #116 + #97 +
      #108 + #108 + #32 + #97 + #110 + #100 + #32 + #117 + #115 + #101 + #32 + #65 + #118 + #111 + #66 + #97 +
      #115 + #101 + #46 + #13 + #13 + #82 + #101 + #103 + #105 + #115 + #116 + #114 + #97 + #116 + #105 + #111 +
      #110 + #32 + #104 + #101 + #108 + #112 + #115 + #32 + #116 + #111 + #32 + #101 + #110 + #115 + #117 + #114 +
      #101 + #32 + #116 + #104 + #97 + #116 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #105 +
      #115 + #32 + #112 + #114 + #111 + #112 + #101 + #114 + #108 + #121 + #32 + #109 + #97 + #105 + #110 + #116 +
      #97 + #105 + #110 + #101 + #100 + #44 + #32 + #117 + #112 + #100 + #97 + #116 + #101 + #100 + #32 + #97 +
      #110 + #100 + #32 + #97 + #115 + #32 + #98 + #117 + #103 + #45 + #102 + #114 + #101 + #101 + #32 + #97 +
      #115 + #32 + #112 + #111 + #115 + #115 + #105 + #98 + #108 + #101 + #46 + #13 + #13 + #80 + #108 + #101 +
      #97 + #115 + #101 + #32 + #118 + #105 + #115 + #105 + #116 + #32 + #65 + #118 + #111 + #66 + #97 + #115 +
      #101 + #46 + #99 + #111 + #109 + #32 + #116 + #111 + #32 + #118 + #105 + #101 + #119 + #32 + #109 + #111 +
      #114 + #101 + #32 + #105 + #110 + #102 + #111 + #114 + #109 + #97 + #116 + #105 + #111 + #110 + #32 + #111 +
      #110 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #44 + #32 + #105 + #110 + #99 + #108 + #117 +
      #100 + #105 + #110 + #103 + #32 + #83 + #99 + #114 + #101 + #101 + #110 + #32 + #83 + #104 + #111 + #116 +
      #115 + #44 + #32 + #80 + #114 + #105 + #99 + #101 + #115 + #32 + #97 + #110 + #100 + #32 + #83 + #117 +
      #112 + #112 + #111 + #114 + #116 + #46 + #13 + #13 + #65 + #103 + #97 + #105 + #110 + #44 + #32 + #116 +
      #104 + #97 + #110 + #107 + #32 + #121 + #111 + #117 + #32 + #102 + #111 + #114 + #32 + #117 + #115 +
      #105 + #110 + #103 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #33;



   {We appreciate that you have taken the time to download, install and use AvoBase.
      Registration helps to ensure that AvoBase is properly maintained, updated and as bug-free as possible.\n\n
      Please visit AvoBase.com to view more information on AvoBase, including Screen Shots, Prices and Support.\n\nAgain, thank you for using
      AvoBase!}

   //
   // Now turn the bands back ON depending upon report type
	//ObjVerf := tKeyVerif.Create;
   case fReportType of
      {----------------------------------------------------------}
      Report_Customer_List:
      begin
         REPORT_CAPTION.caption := 'Customer List Report';
         BAND_CustomerList.Visible := true;
      end;
      {----------------------------------------------------------}
      Report_Customer_TopCustByOrd:
      begin
         REPORT_CAPTION.caption := 'Customer - Top Customer By Orders Placed Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Customer_TopCustByMoney:
      begin
         REPORT_CAPTION.caption := 'Customer - Top Customer By Order Amounts';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Order_List:
      begin
         REPORT_CAPTION.caption := 'Order - Order List By Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
      end;
      {----------------------------------------------------------}
      Report_Customer_OrderTransactionHistory:
      begin
         REPORT_CAPTION.caption := 'Customer - Order Transaction Report';
         Customer_Select_Startup();
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Customer_OrderHistory:
      begin
         REPORT_CAPTION.caption := 'Customer - Order History Report';
         Customer_Select_Startup();
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Customer_SingleCustomer:
      begin
         CUST_SINGLE_PANEL.Visible := True;
         REPORT_CAPTION.caption := 'Customer - Single Customer';
      end;
      {----------------------------------------------------------}
      Report_Customer_Labels:
      begin
         REPORT_CAPTION.caption := 'Report_Customer_Labels';
      end;
      {----------------------------------------------------------}
      Report_Cycle_CycleListByOrg:
      begin
         REPORT_CAPTION.caption := 'Sales Cycle By Organization Report';
         BAND_SelectOrgAndCycle.Visible := true;
      end;
      {----------------------------------------------------------}
      Report_Order_Labels:
      begin
         REPORT_CAPTION.caption := 'Labels';
         BAND_ODRER_LABELS.Visible := True;
         BAND_SelectOrgAndCycle.Visible := true;
      end;
      {----------------------------------------------------------}
      Report_Order_BackOrderList:
      begin
         REPORT_CAPTION.caption := 'Order Backorder List Report';
         BAND_No_Options.Visible := True;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Earning_Types:
      begin
         REPORT_CAPTION.caption := 'Earning Types By Sales Organization Report';
         BAND_SelectOrgAndCycle.Visible := true;
         GroupBox_EndSalesCycle.Visible := false;
         GroupBox_StartSalesCycle.Visible := false;
      end;
      {----------------------------------------------------------}
      Report_Earning_EarningByCycle:
      begin { individuals broken down by cycle }
         REPORT_CAPTION.caption := 'Earnings By Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Earning_ListByCycle:
      begin { combined report - 1 liner of all lines combined into 1 }
         REPORT_CAPTION.caption := 'Earnings List by Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
      end;
      {----------------------------------------------------------}
      Report_Expense_Type:
      begin
         REPORT_CAPTION.caption := 'Expense Types By Sales Organization Report';
         BAND_SelectOrgAndCycle.Visible := true;
         GroupBox_EndSalesCycle.Visible := false;
         GroupBox_StartSalesCycle.Visible := false;
      end;
      {----------------------------------------------------------}
      Report_Expense_ByCycle: { individuals broken down by cycle }
      begin
         REPORT_CAPTION.caption := 'Expenses By Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Expense_ListByCycle:
      begin
         REPORT_CAPTION.caption := 'Expense List by Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_EarningVsExpenseByCycle:
      begin
         REPORT_CAPTION.caption := 'Earning Vs Expense by Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Product_SingleProduct:
      begin
         REPORT_CAPTION.caption := 'Report_Product_SingleProduct';
      end;
      {----------------------------------------------------------}
      Report_Product_QTYOnHand:
      begin
         REPORT_CAPTION.caption := 'Product Quantity On Hand Report';
         BAND_No_Options.Visible := True;
      end;
      {----------------------------------------------------------}
      Report_Product_ProductList:
      begin
         REPORT_CAPTION.caption := 'Product List Report';
         BAND_PRODUCTLIST_OPTIONS.Visible := true;
         BAND_SelectOrgAndCycle.Visible := true;
      end;
      {----------------------------------------------------------}
      Report_Accounting_FeesCollectedByCycle:
      begin
         REPORT_CAPTION.caption := 'Fees Collected by Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Accounting_ShippingCollectedByCycle:
      begin
         REPORT_CAPTION.caption := 'Shipping Collected by Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Accounting_TaxesCollectedByCycle:
      begin
         REPORT_CAPTION.caption := 'Taxes Collected by Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Accounting_TaxExemptByCycle:
      begin
         REPORT_CAPTION.caption := 'Tax Exempt by Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Accounting_DepositSlipByCycle:
      begin
         REPORT_CAPTION.caption := 'Report_Accounting_DepositSlipByCycle';
      end;
      {----------------------------------------------------------}
      Report_Accounting_VoidNSFByCycle:
      begin
         REPORT_CAPTION.caption := 'Void And NSF By Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Accounting_ReturnsByCycle:
      begin
         REPORT_CAPTION.caption := 'Returns By Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         db_orderoptions_closed.checked := true;
         db_orderoptions_open.Checked := false;
         db_orderoptions_cancelled.checked := false;
      end;
      {----------------------------------------------------------}
      Report_Accounting_TransactionLogByCycle:
      begin
         REPORT_CAPTION.caption := 'Transaction Log By Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
      end;
      {----------------------------------------------------------}
      Report_Order_OrderProductList:
      begin
         REPORT_CAPTION.caption := 'Order - Order Product List By Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         GroupBox_EndSalesCycle.Visible := false;
      end;
      {----------------------------------------------------------}
      Report_Product_ReturnProductList:
      begin
         REPORT_CAPTION.caption := 'Product Return List Report';
         BAND_PRODUCTRETURNLIST.visible := True;
      end;
      {----------------------------------------------------------}
      Report_Accounting_ShippingReturned:
      begin
         REPORT_CAPTION.caption := 'Shipping Returned By Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         db_orderoptions_closed.checked := true;
         db_orderoptions_open.Checked := false;
         db_orderoptions_cancelled.checked := false;
      end;
      {----------------------------------------------------------}
      Report_Accounting_FeesReturned:
      begin
         REPORT_CAPTION.caption := 'Fees Returned By Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
      end;
      {----------------------------------------------------------}
      Report_Customer_OutstandingBalance:
      begin
         REPORT_CAPTION.caption := 'Customer Outstanding Balance Report';
         BAND_No_Options.Visible := True;
         j3gT3 := '*';
      end;
      {----------------------------------------------------------}
      Report_Accounting_OrderAmountBreakDownByCycle:
      begin
         REPORT_CAPTION.caption := 'Order Amount Breakdown By Sales Cycle Report';
         BAND_SelectOrgAndCycle.Visible := true;
         //BAND_ORDER_TYPE_OPTIONS.Visible := True;
         db_orderoptions_closed.checked := true;
         db_orderoptions_open.Checked := false;
         db_orderoptions_cancelled.checked := false;
      end;
      {----------------------------------------------------------}
      Report_Customer_EscrowBalance:
      begin
         REPORT_CAPTION.caption := 'Customer Escrow Balance Report';
         j3gT3 := '*';
         BAND_No_Options.Visible := True;
      end;
   end;
   //
   BAND_UNREG.Visible := False;
   (*
	if NOT(ObjVerf.Tk4726TuI) then
      zj3gwT := '%122x';
	if (ObjVerf.Tk4726TuI) AND NOT(ObjVerf.Tk4726Tu1) then
      zj3gwT := '%122x';
   if ( zj3gwT <> '0-=' ) AND (j3gT3 = '*') then
   begin
      BAND_CustomerList.Visible := false;
      BAND_SelectOrgAndCycle.Visible := false;
      BAND_No_Options.Visible := False;
      CUST_SINGLE_PANEL.Visible := False;
      BAND_SelectCustomer.Visible := False;
      BAND_PRODUCTRETURNLIST.visible := false;
      BAND_PRODUCTLIST_OPTIONS.Visible := false;
      BAND_ODRER_LABELS.Visible := False;
      BAND_UNREG.Visible := true;
   end;
   //
	FreeAndNil(ObjVerf);
   *)
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tReport_InterfaceForm.ViewReport(ViewType : tReportSelectType);
var
   rpt_Customer_List : TReport_Customer_List;
   rpt_Customer_TopCustByOrd : TReport_Customer_TopCustByOrder;
   rpt_Customer_TopCustByOrdMoney : TReport_Customer_TopCustByOrderAmount;
   rpt_Order_List : TReport_Order_List;
   rpt_Product_SingleProduct : TReport_Product_SingleProduct;
   rpt_Product_QuantityOnHand : TReport_Product_QuantityOnHand;
   rpt_Product_ProductList : TReport_Product_ProductList;
   rpt_Order_Labels : TReport_Order_Labels;
   rpt_Order_BackOrderList : TReport_Order_BackOrderList;
   rpt_Expense_Type : TReport_Expense_Type;
   rpt_Expense_ListByCycle : TReport_Expense_ListByCycle;
   rpt_Expense_ByCycle : TReport_Expense_ByCycle;
   rpt_Earning_Types : TReport_Earning_Types;
   rpt_Earning_ListByCycle : TReport_Earning_ListByCycle;
   rpt_Earning_EarningByCycle : TReport_Earning_EarningByCycle;
   rpt_EarningVsExpenseByCycle : TReport_EarningVsExpenseByCycle;
   rpt_Cycle_CycleListByOrg : TReport_Cycle_CycleListByOrg;
   rpt_Customer_SingleCustomer : TReport_Customer_SingleCustomer;
   rpt_Customer_OrderTransactionHistory : TReport_Customer_OrderTransactionHistory;
   rpt_Customer_OrderHistory : TReport_Customer_OrderHistory;
   rpt_Customer_Labels : TReport_Customer_Labels;
   rpt_Customer_TopCustByOrder : TReport_Customer_TopCustByOrder;
   rpt_Customer_TopCustByOrderAmount : TReport_Customer_TopCustByOrderAmount;
   rpt_Accounting_VoidNSFByCycle : TReport_Accounting_VoidNSFByCycle;
   rpt_Accounting_TransactionLogByCycle : TReport_Accounting_TransactionLogByCycle;
   rpt_Accounting_TaxesCollectedByCycle :  TReport_Accounting_TaxesCollectedByCycle;
   rpt_Accounting_ShippingCollectedByCycle : TReport_Accounting_ShippingCollectedByCycle;
   rpt_Accounting_ReturnsByCycle : TReport_Accounting_ReturnsByCycle;
   rpt_Accounting_FeesCollectedByCycle : TReport_Accounting_FeesCollectedByCycle;
   rpt_Accounting_DepositSlipByCycle : TReport_Accounting_DepositSlipByCycle;
   rpt_Accounting_TaxExemptByCycle : TReport_Accounting_TaxExemptByCycle;
   rpt_Order_OrderProductList : TReport_Order_OrderProduct;
   rpt_Order_ReturnProductList : TReport_Product_ReturnProductList;
   rpt_Accounting_ShippingReturned : TReport_Accounting_ShippingReturns;
   rpt_Accounting_FeesReturned : TReport_Accounting_FeesReturned;
   rpt_Customer_OutstandingBalanace : tReport_Customer_OutstandingBalance;
   rpt_Accounting_OrderAmountBreakDownByCycle : TReport_Accounting_OrderAmountBreakDownByCycle;
   rpt_Report_Customer_EscrowBalance : TReport_CustomerEscrowBalance;
   //
   errMsg: string;
   fPrevDir : string;
   fileName : string;
begin
   // first do some checking
   case fReportType of
      {----------------------------------------------------------}
      Report_Customer_SingleCustomer,
      Report_Customer_Labels,
      Report_Customer_List,
      Report_Customer_OutstandingBalance,
      Report_Customer_TopCustByOrd,
      Report_Customer_EscrowBalance,
      Report_Customer_TopCustByMoney:
      begin
         if ( Customer_GetCustomerCount = 0 ) then
            errMsg := 'There are no Customers. Please add a Customer first.';
         if ( Cycle_GetCycleCount = 0 ) then
            errMsg := ' There are no Cycles. Please add Sales Cycles first.';
         if ( Order_GetOrderCount = 0 ) then
            errMsg := 'There are no Orders. Please add an Order first.';
      end;
      {----------------------------------------------------------}
      Report_Accounting_FeesCollectedByCycle,
      Report_Accounting_ShippingCollectedByCycle,
      Report_Accounting_TaxesCollectedByCycle,
      Report_Accounting_TaxExemptByCycle,
      Report_Accounting_DepositSlipByCycle,
      Report_Accounting_VoidNSFByCycle,
      Report_Accounting_ShippingReturned,
      Report_Accounting_FeesReturned,
      Report_Accounting_ReturnsByCycle,
      Report_Accounting_TransactionLogByCycle,
      Report_Customer_OrderTransactionHistory,
      Report_Customer_OrderHistory,
      Report_Order_Labels,
      Report_Order_BackOrderList,
      Report_Order_List:
      begin
         if ( Order_GetOrderCount = 0 ) then
            errMsg := 'There are no Orders. Please add an Order first.';
         if ( Cycle_GetCycleCount = 0 ) then
            errMsg := ' There are no Cycles. Please add Sales Cycles first.';
      end;
      {----------------------------------------------------------}
      Report_Cycle_CycleListByOrg:
      begin
         if ( Cycle_GetCycleCount = 0 ) then
            errMsg := ' There are no Cycles. Please add Sales Cycles first.';
      end;
      {----------------------------------------------------------}
      Report_Earning_Types,
      Report_Earning_EarningByCycle,
      Report_Earning_ListByCycle:
      begin
         if ( Earning_RecordCount = 0 ) then
            errMsg := 'There are no Earnings. Please add Earnings to a Sales Cycle first.';
         if ( Earning_EarningTypeRecordCount = 0 ) then
            errMsg := 'There are no Earning Types. Please add Earning Types first.';
      end;
      {----------------------------------------------------------}
      Report_Expense_Type,
      Report_Expense_ByCycle,
      Report_Expense_ListByCycle:
      begin
         if ( Expense_RecordCount = 0 ) then
            errMsg := 'There are no Expensese. Please add Expenses to a Sales Cycle first.';
         if ( Expense_ExpenseTypeRecordCount = 0 ) then
            errMsg := 'There are no Expense Types. Please add Expense Types first.';
      end;
      {----------------------------------------------------------}
      Report_EarningVsExpenseByCycle:
      begin
         if ( Expense_RecordCount = 0 ) then
            errMsg := 'There are no Expensese. Please add Expenses to a Sales Cycle first.';
         if ( Earning_RecordCount = 0 ) then
            errMsg := 'There are no Earnings. Please add Earnings to a Sales Cycle first.';
         if ( Expense_ExpenseTypeRecordCount = 0 ) then
            errMsg := 'There are no Expense Types. Please add Expense Types first.';
         if ( Earning_EarningTypeRecordCount = 0 ) then
            errMsg := 'There are no Earning Types. Please add Earning Types first.';
      end;
      {----------------------------------------------------------}
      Report_Product_SingleProduct,
      Report_Product_QTYOnHand,
      Report_Product_ProductList:
      begin
         if ( Product_RecordCount = 0 ) then
            errMsg := 'There are no Products. Please add a Product first.';
      end;
      {----------------------------------------------------------}
      Report_Product_ReturnProductList:
      begin
         if ( Product_ReturnProductRecordCount = 0 ) then
            errMsg := 'There are no Return Products.';
      end;
   end;
   //
   if ( errMsg <> '' ) then
   begin
      AvoBaseDialog('Unable to run Report', errMsg, mtError, [mbok], 0);
   end else
      begin
         // Which one is it?
         case fReportType of
            //
            // CUSTOMER ESCROW BALANCE REPORT
            Report_Customer_EscrowBalance:
            begin
               rpt_Report_Customer_EscrowBalance := TReport_CustomerEscrowBalance.Create( Application );
               // Setup Options
               rpt_Report_Customer_EscrowBalance.SetOptions();
               errMsg := rpt_Report_Customer_EscrowBalance.CanPrint;
               // Check for Errors
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Report_Customer_EscrowBalance.QReport.Preview();
                     ReportSelectTypePrint : rpt_Report_Customer_EscrowBalance.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'rpt_Report_Customer_EscrowBalance.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Report_Customer_EscrowBalance.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Report_Customer_EscrowBalance <> NIL) then
                  FreeAndNil(rpt_Report_Customer_EscrowBalance);
            end;
            {----------------------------------------------------------}
            //
            // ACCOUNTING CYCLE BREAKDOWN
            Report_Accounting_OrderAmountBreakDownByCycle:
            begin
               rpt_Accounting_OrderAmountBreakDownByCycle := TReport_Accounting_OrderAmountBreakDownByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_OrderAmountBreakDownByCycle.SetOptions( CycleOrgID, Cycle_StartID, Cycle_EndID,
                   db_orderoptions_open.checked, db_orderoptions_closed.checked, db_orderoptions_cancelled.checked);
               errMsg := rpt_Accounting_OrderAmountBreakDownByCycle.CanPrint;
               // Check for Errors
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_OrderAmountBreakDownByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_OrderAmountBreakDownByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Order_List.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_OrderAmountBreakDownByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_OrderAmountBreakDownByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_OrderAmountBreakDownByCycle);
            end;
            {----------------------------------------------------------}
            //
            // CUSTOMER OUTSTANDING BALANCE REPORT
            Report_Customer_OutstandingBalance:
            begin
               rpt_Customer_OutstandingBalanace := tReport_Customer_OutstandingBalance.Create( Application );
               // Setup Options
               rpt_Customer_OutstandingBalanace.SetOptions( CustListID );
               errMsg := rpt_Customer_OutstandingBalanace.CanPrint;
               // Check for Errors
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Customer_OutstandingBalanace.QReport.Preview();
                     ReportSelectTypePrint : rpt_Customer_OutstandingBalanace.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Customer_OutstandingBalance.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Customer_OutstandingBalanace.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Customer_OutstandingBalanace <> NIL) then
                  FreeAndNil(rpt_Customer_OutstandingBalanace);
            end;
            {----------------------------------------------------------}
            //
            // CUSTOMER LIST
            Report_Customer_List:
            begin
               rpt_Customer_List := TReport_Customer_List.Create( Application );
               // Setup Options
               case CustListOpt.ItemIndex of
                  0 : rpt_Customer_List.SetOptions( CustListOpt1 );
                  1 : rpt_Customer_List.SetOptions( CustListOpt2 );
                  2 : rpt_Customer_List.SetOptions( CustListOpt3 );
                  3 : rpt_Customer_List.SetOptions( CustListOpt4 );
                  4 : rpt_Customer_List.SetOptions( CustListOpt5 );
               end;
               // Check for Errors
               errMsg := rpt_Customer_List.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Customer_List.QReport.Preview();
                     ReportSelectTypePrint : rpt_Customer_List.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Customer_List.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Customer_List.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Customer_List <> NIL) then
                  FreeAndNil(rpt_Customer_List);
            end;
            {----------------------------------------------------------}
            //
            // TOP CUSTOMER BY ORDERS PLACED
            Report_Customer_TopCustByOrd:
            begin
               rpt_Customer_TopCustByOrd := TReport_Customer_TopCustByOrder.Create( Application );
               // Setup Options
               rpt_Customer_TopCustByOrd.SetOptions( OrgID_CycleStartEnd, Cycle_StartID, Cycle_EndID );
               errMsg := rpt_Customer_TopCustByOrd.CanPrint;
               // Check for Errors
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Customer_TopCustByOrd.QReport.Preview();
                     ReportSelectTypePrint : rpt_Customer_TopCustByOrd.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Customer_TopCustByOrd.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Customer_TopCustByOrd.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Customer_TopCustByOrd <> NIL) then
                  FreeAndNil(rpt_Customer_TopCustByOrd);
            end;
            {----------------------------------------------------------}
            //
            // TOP CUSTOMER BY ORDER AMOUNTS
            Report_Customer_TopCustByMoney:
            begin
               rpt_Customer_TopCustByOrdMoney := TReport_Customer_TopCustByOrderAmount.Create( Application );
               // Setup Options
               rpt_Customer_TopCustByOrdMoney.SetOptions( OrgID_CycleStartEnd, Cycle_StartID, Cycle_EndID );
               errMsg := rpt_Customer_TopCustByOrdMoney.CanPrint;
               // Check for Errors
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Customer_TopCustByOrdMoney.QReport.Preview();
                     ReportSelectTypePrint : rpt_Customer_TopCustByOrdMoney.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Customer_TopCustByMoney.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Customer_TopCustByOrdMoney.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Customer_TopCustByOrdMoney <> NIL) then
                  FreeAndNil(rpt_Customer_TopCustByOrdMoney);
            end;
            {----------------------------------------------------------}
            //
            // ORDER LIST
            Report_Order_List:
            begin
               rpt_Order_List := TReport_Order_List.Create( Application );
               // Setup Options
               rpt_Order_List.SetOptions( OrgID_CycleStartEnd, Cycle_StartID, Cycle_EndID );
               errMsg := rpt_Order_List.CanPrint;
               // Check for Errors
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Order_List.QReport.Preview();
                     ReportSelectTypePrint : rpt_Order_List.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Order_List.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Order_List.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Order_List <> NIL) then
                  FreeAndNil(rpt_Order_List);
            end;
            {----------------------------------------------------------}
            Report_Customer_OrderTransactionHistory:
            begin
               rpt_Customer_OrderTransactionHistory := TReport_Customer_OrderTransactionHistory.Create( Application );
               // Setup Options
               rpt_Customer_OrderTransactionHistory.SetOptions( CustListID );
               // Check for Errors
               errMsg := rpt_Customer_OrderTransactionHistory.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Customer_OrderTransactionHistory.QReport.Preview();
                     ReportSelectTypePrint : rpt_Customer_OrderTransactionHistory.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Customer_OrderTransactionHistory.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Customer_OrderTransactionHistory.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Customer_OrderTransactionHistory <> NIL) then
                  FreeAndNil(rpt_Customer_OrderTransactionHistory);
            end;
            {----------------------------------------------------------}
            Report_Customer_OrderHistory:
            begin
               rpt_Customer_OrderHistory := TReport_Customer_OrderHistory.Create( Application );
               // Setup Options
               rpt_Customer_OrderHistory.SetOptions( CustListID );
               // Check for Errors
               errMsg := rpt_Customer_OrderHistory.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Customer_OrderHistory.QReport.Preview();
                     ReportSelectTypePrint : rpt_Customer_OrderHistory.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Customer_OrderHistory.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Customer_OrderHistory.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Customer_OrderHistory <> NIL) then
                  FreeAndNil(rpt_Customer_OrderHistory);
            end;
            {----------------------------------------------------------}
            Report_Customer_Labels:
            begin
               rpt_Customer_Labels := TReport_Customer_Labels.Create( Application );
               // Setup Options
               rpt_Customer_Labels.SetOptions( OrgID_CycleStartEnd, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Customer_Labels.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Customer_Labels.QReport.Preview();
                     ReportSelectTypePrint : rpt_Customer_Labels.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Customer_Labels.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Customer_Labels.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Customer_Labels <> NIL) then
                  FreeAndNil(rpt_Customer_Labels);
            end;
            {----------------------------------------------------------}
            Report_Cycle_CycleListByOrg:
            begin
               rpt_Cycle_CycleListByOrg := TReport_Cycle_CycleListByOrg.Create( Application );
               // Setup Options
               rpt_Cycle_CycleListByOrg.SetOptions( CycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Cycle_CycleListByOrg.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Cycle_CycleListByOrg.QReport.Preview();
                     ReportSelectTypePrint : rpt_Cycle_CycleListByOrg.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Cycle_CycleListByOrg.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Cycle_CycleListByOrg.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Cycle_CycleListByOrg <> NIL) then
                  FreeAndNil(rpt_Cycle_CycleListByOrg);
            end;
            {----------------------------------------------------------}
            Report_Order_Labels:
            begin
               rpt_Order_Labels := TReport_Order_Labels.Create( Application );
               // Setup Options
               rpt_Order_Labels.SetOptions( OrgID_CycleStartEnd, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Order_Labels.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
{
                  case ViewType of
                     ReportSelectTypeView : rpt_Order_Labels.QReport.Preview();
                     ReportSelectTypePrint : rpt_Order_Labels.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Order_Labels.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Order_Labels.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
}
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Order_Labels <> NIL) then
                  FreeAndNil(rpt_Order_Labels);
            end;
            {----------------------------------------------------------}
            Report_Order_BackOrderList:
            begin
               rpt_Order_BackOrderList := TReport_Order_BackOrderList.Create( Application );
               // Setup Options
               rpt_Order_BackOrderList.SetOptions( OrgID_CycleStartEnd, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Order_BackOrderList.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Order_BackOrderList.QReport.Preview();
                     ReportSelectTypePrint : rpt_Order_BackOrderList.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Order_BackOrderList.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Order_BackOrderList.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Order_BackOrderList <> NIL) then
                  FreeAndNil(rpt_Order_BackOrderList);
            end;
            {----------------------------------------------------------}
            Report_Earning_Types:
            begin
               rpt_Earning_Types := TReport_Earning_Types.Create( Application );
               // Setup Options
               rpt_Earning_Types.SetOptions( CycleOrgID );
               // Check for Errors
               errMsg := rpt_Earning_Types.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Earning_Types.QReport.Preview();
                     ReportSelectTypePrint : rpt_Earning_Types.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Earning_Types.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Earning_Types.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Earning_Types <> NIL) then
                  FreeAndNil(rpt_Earning_Types);
            end;
            {----------------------------------------------------------}
            Report_Earning_EarningByCycle:
            begin
               rpt_Earning_EarningByCycle := TReport_Earning_EarningByCycle.Create( Application );
               // Setup Options
               rpt_Earning_EarningByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Earning_EarningByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Earning_EarningByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Earning_EarningByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Earning_EarningByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Earning_EarningByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Earning_EarningByCycle <> NIL) then
                  FreeAndNil(rpt_Earning_EarningByCycle);
            end;
            {----------------------------------------------------------}
            Report_Earning_ListByCycle:
            begin
               rpt_Earning_ListByCycle := TReport_Earning_ListByCycle.Create( Application );
               // Setup Options
               rpt_Earning_ListByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Earning_ListByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Earning_ListByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Earning_ListByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Earning_ListByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Earning_ListByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Earning_ListByCycle <> NIL) then
                  FreeAndNil(rpt_Earning_ListByCycle);
            end;
            {----------------------------------------------------------}
            Report_Expense_Type:
            begin
               rpt_Expense_Type := TReport_Expense_Type.Create( Application );
               // Setup Options
               rpt_Expense_Type.SetOptions( CycleOrgID );
               // Check for Errors
               errMsg := rpt_Expense_Type.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Expense_Type.QReport.Preview();
                     ReportSelectTypePrint : rpt_Expense_Type.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Expense_Type.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Expense_Type.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Expense_Type <> NIL) then
                  FreeAndNil(rpt_Expense_Type);
            end;
            {----------------------------------------------------------}
            Report_Expense_ByCycle:
            begin
               rpt_Expense_ByCycle := TReport_Expense_ByCycle.Create( Application );
               // Setup Options
               rpt_Expense_ByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Expense_ByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Expense_ByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Expense_ByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Expense_ByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Expense_ByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Expense_ByCycle <> NIL) then
                  FreeAndNil(rpt_Expense_ByCycle);
            end;
            {----------------------------------------------------------}
            Report_Expense_ListByCycle:
            begin
               rpt_Expense_ListByCycle := TReport_Expense_ListByCycle.Create( Application );
               // Setup Options
               rpt_Expense_ListByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Expense_ListByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Expense_ListByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Expense_ListByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Expense_ListByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Expense_ListByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Expense_ListByCycle <> NIL) then
                  FreeAndNil(rpt_Expense_ListByCycle);
            end;
            {----------------------------------------------------------}
            Report_EarningVsExpenseByCycle:
            begin
               rpt_EarningVsExpenseByCycle := TReport_EarningVsExpenseByCycle.Create( Application );
               // Setup Options
               rpt_EarningVsExpenseByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_EarningVsExpenseByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_EarningVsExpenseByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_EarningVsExpenseByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_EarningVsExpenseByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_EarningVsExpenseByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_EarningVsExpenseByCycle <> NIL) then
                  FreeAndNil(rpt_EarningVsExpenseByCycle);
            end;
            {----------------------------------------------------------}
            Report_Product_QTYOnHand:
            begin
               rpt_Product_QuantityOnHand := TReport_Product_QuantityOnHand.Create( Application );
               // Setup Options
               rpt_Product_QuantityOnHand.SetOptions( OrgID_CycleStartEnd, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Product_QuantityOnHand.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Product_QuantityOnHand.QReport.Preview();
                     ReportSelectTypePrint : rpt_Product_QuantityOnHand.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Product_QTYOnHand.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Product_QuantityOnHand.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Product_QuantityOnHand <> NIL) then
                  FreeAndNil(rpt_Product_QuantityOnHand);
            end;
            {----------------------------------------------------------}
            Report_Product_ProductList:
            begin
               rpt_Product_ProductList := TReport_Product_ProductList.Create( Application );
               // Setup Options
               rpt_Product_ProductList.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID, ProdSortType );
               // Check for Errors
               errMsg := rpt_Product_ProductList.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Product_ProductList.QReport.Preview();
                     ReportSelectTypePrint : rpt_Product_ProductList.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Product_ProductList.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Product_ProductList.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Product_ProductList <> NIL) then
                  FreeAndNil(rpt_Product_ProductList);
            end;
            {----------------------------------------------------------}
            Report_Accounting_FeesCollectedByCycle:
            begin
               rpt_Accounting_FeesCollectedByCycle := TReport_Accounting_FeesCollectedByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_FeesCollectedByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Accounting_FeesCollectedByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_FeesCollectedByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_FeesCollectedByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_FeesCollectedByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_FeesCollectedByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_FeesCollectedByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_FeesCollectedByCycle);
            end;
            {----------------------------------------------------------}
            Report_Accounting_ShippingCollectedByCycle:
            begin
               rpt_Accounting_ShippingCollectedByCycle := TReport_Accounting_ShippingCollectedByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_ShippingCollectedByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Accounting_ShippingCollectedByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_ShippingCollectedByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_ShippingCollectedByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_ShippingCollectedByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_ShippingCollectedByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_ShippingCollectedByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_ShippingCollectedByCycle);
            end;
            {----------------------------------------------------------}
            Report_Accounting_TaxesCollectedByCycle:
            begin
               rpt_Accounting_TaxesCollectedByCycle := TReport_Accounting_TaxesCollectedByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_TaxesCollectedByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Accounting_TaxesCollectedByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_TaxesCollectedByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_TaxesCollectedByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_TaxesCollectedByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_TaxesCollectedByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_TaxesCollectedByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_TaxesCollectedByCycle);
            end;
            {----------------------------------------------------------}
            Report_Accounting_TaxExemptByCycle:
            begin
               rpt_Accounting_TaxExemptByCycle := TReport_Accounting_TaxExemptByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_TaxExemptByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Accounting_TaxExemptByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_TaxExemptByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_TaxExemptByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_TaxExemptByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_TaxExemptByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_TaxExemptByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_TaxExemptByCycle);
            end;
            {----------------------------------------------------------}
            Report_Accounting_DepositSlipByCycle:
            begin
               rpt_Accounting_DepositSlipByCycle := TReport_Accounting_DepositSlipByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_DepositSlipByCycle.SetOptions( OrgID_CycleStartEnd, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Accounting_DepositSlipByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_DepositSlipByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_DepositSlipByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_DepositSlipByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_DepositSlipByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_DepositSlipByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_DepositSlipByCycle);
            end;
            {----------------------------------------------------------}
            Report_Accounting_VoidNSFByCycle:
            begin
               rpt_Accounting_VoidNSFByCycle := TReport_Accounting_VoidNSFByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_VoidNSFByCycle.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Accounting_VoidNSFByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_VoidNSFByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_VoidNSFByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_VoidNSFByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_VoidNSFByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_VoidNSFByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_VoidNSFByCycle);
            end;
            {----------------------------------------------------------}
            Report_Accounting_ReturnsByCycle:
            begin
               rpt_Accounting_ReturnsByCycle := TReport_Accounting_ReturnsByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_ReturnsByCycle.SetOptions( CycleOrgID, Cycle_StartID, Cycle_EndID,
                   db_orderoptions_open.checked, db_orderoptions_closed.checked, db_orderoptions_cancelled.checked);
               // Check for Errors
               errMsg := rpt_Accounting_ReturnsByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_ReturnsByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_ReturnsByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_ReturnsByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_ReturnsByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_ReturnsByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_ReturnsByCycle);
            end;
            {----------------------------------------------------------}
            Report_Accounting_TransactionLogByCycle:
            begin
               rpt_Accounting_TransactionLogByCycle := TReport_Accounting_TransactionLogByCycle.Create( Application );
               // Setup Options
               rpt_Accounting_TransactionLogByCycle.SetOptions( CycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Accounting_TransactionLogByCycle.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_TransactionLogByCycle.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_TransactionLogByCycle.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_TransactionLogByCycle.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_TransactionLogByCycle.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_TransactionLogByCycle <> NIL) then
                  FreeAndNil(rpt_Accounting_TransactionLogByCycle);
            end;
            {----------------------------------------------------------}
            Report_Customer_SingleCustomer:
            begin
               rpt_Customer_SingleCustomer := TReport_Customer_SingleCustomer.Create( Application );
               // Setup Options
               rpt_Customer_SingleCustomer.SetOptions( CustID );
               // Check for Errors
               errMsg := rpt_Customer_SingleCustomer.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Customer_SingleCustomer.QReport.Preview();
                     ReportSelectTypePrint : rpt_Customer_SingleCustomer.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Customer_SingleCustomer.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Customer_SingleCustomer.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Customer_SingleCustomer <> NIL) then
                  FreeAndNil(rpt_Customer_SingleCustomer);
            end;
            {----------------------------------------------------------}
            Report_Order_OrderProductList:
            begin
               rpt_Order_OrderProductList := TReport_Order_OrderProduct.Create( Application );
               // Setup Options
               rpt_Order_OrderProductList.SetOptions( CycleOrgID, Cycle_StartID );
               // Check for Errors
               errMsg := rpt_Order_OrderProductList.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Order_OrderProductList.QReport.Preview();
                     ReportSelectTypePrint : rpt_Order_OrderProductList.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Order_OrderProductList.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Order_OrderProductList.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Order_OrderProductList <> NIL) then
                  FreeAndNil(rpt_Order_OrderProductList);
            end;
            {----------------------------------------------------------}
            Report_Product_ReturnProductList:
            begin

               if ((db_pr_pend.checked = false) AND ( db_pr_returned.checked = false ) AND ( db_pr_restocked.Checked = false )) then
               begin
                  AvoBaseDialog('Unable To Print Report', 'You must select a printing option.', mtInformation, [mbOk], 0);
                  Exit;
               end;
               rpt_Order_ReturnProductList := TReport_Product_ReturnProductList.Create( Application );
               // Setup Options
               rpt_Order_ReturnProductList.SetOptions( db_pr_pend.Checked, db_pr_returned.checked, db_pr_restocked.checked );
               // Check for Errors
               errMsg := rpt_Order_ReturnProductList.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Order_ReturnProductList.QReport.Preview();
                     ReportSelectTypePrint : rpt_Order_ReturnProductList.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Product_ReturnProductList.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Order_ReturnProductList.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Order_ReturnProductList <> NIL) then
                  FreeAndNil(rpt_Order_ReturnProductList);
            end;
            {----------------------------------------------------------}
            Report_Accounting_ShippingReturned:
            begin
               rpt_Accounting_ShippingReturned := TReport_Accounting_ShippingReturns.Create( Application );
               // Setup Options
               rpt_Accounting_ShippingReturned.SetOptions( CycleOrgID, Cycle_StartID, Cycle_EndID,
                   db_orderoptions_open.checked, db_orderoptions_closed.checked, db_orderoptions_cancelled.checked);
               // Check for Errors
               errMsg := rpt_Accounting_ShippingReturned.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_ShippingReturned.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_ShippingReturned.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_ShippingReturned.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_ShippingReturned.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_ShippingReturned <> NIL) then
                  FreeAndNil(rpt_Accounting_ShippingReturned);
            end;
            {----------------------------------------------------------}
            Report_Accounting_FeesReturned:
            begin
               rpt_Accounting_FeesReturned := TReport_Accounting_FeesReturned.Create( Application );
               // Setup Options
               rpt_Accounting_FeesReturned.SetOptions( cycleOrgID, Cycle_StartID, Cycle_EndID );
               // Check for Errors
               errMsg := rpt_Accounting_FeesReturned.CanPrint;
               if ( errMsg = '' ) then
               begin
                  // Display it
                  case ViewType of
                     ReportSelectTypeView : rpt_Accounting_FeesReturned.QReport.Preview();
                     ReportSelectTypePrint : rpt_Accounting_FeesReturned.QReport.Print();
                     ReportSelectTypeSave:
                     begin
                        fPrevDir := AvoINIReadString(AVOBASE_NAME, 'ReportSaveDir', '');
                        fileName := 'Report_Accounting_FeesReturned.PDF';
                        //
                        fSave.InitialDir := fPrevDir;
                        fSave.FileName := fileName;
                        if (fSave.Execute()) then
                        begin
                           fPrevDir := ExtractFilePath(fSave.FileName);
                           AvoINIWriteString( AVOBASE_NAME, 'ReportSaveDir', fPrevDir );
                           rpt_Accounting_FeesReturned.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
                        end;
                     end;
                  end;
               end else
                  AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
               // Free it
               if (rpt_Accounting_FeesReturned <> NIL) then
                  FreeAndNil(rpt_Accounting_FeesReturned);
            end;
            {----------------------------------------------------------}
            {----------------------------------------------------------}
            {----------------------------------------------------------}
            {----------------------------------------------------------}
            {----------------------------------------------------------}
         end;
      end;
end;

end.


