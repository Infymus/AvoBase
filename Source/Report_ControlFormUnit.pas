 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_ControlFormUnit;

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   img_storageformunit,
   avobase_dialogformunit,
   avobase_helpformunit,
   avobase_baseform_menuunit,
   avobase_baseform_standardunit,
   ActionUnit,
   //
   Report_InterfaceFormUnit,
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
   StdCtrls;

type
   tControlForm_Report = class(TForm)
      MAIN_DOCK_PANEL: TScrollBox;
   private
      frm_Report_Customer_List : tReport_InterfaceForm;
      frm_Report_Customer_TopCustByOrd  : tReport_InterfaceForm;
      frm_Report_Customer_TopCustByMoney : tReport_InterfaceForm;
      frm_Report_Order_List : tReport_InterfaceForm;
      frm_Report_Customer_OrderTransactionHistory : tReport_InterfaceForm;
      frm_Report_Customer_OrderHistory : tReport_InterfaceForm;
      frm_Report_CustomerLabels : tReport_InterfaceForm;
      frm_Report_Customer_SingleCustomer : tReport_InterfaceForm;
      frm_Report_Cycle_CycleListByOrg : tReport_InterfaceForm;
      frm_Report_Order_Labels : tReport_InterfaceForm;
      frm_Report_Order_BackOrderList : tReport_InterfaceForm;
      frm_Report_Earning_Types : tReport_InterfaceForm;
      frm_Report_Earning_EarningByCycle : tReport_InterfaceForm;
      frm_Report_Earning_ListByCycle : tReport_InterfaceForm;
      frm_Report_Expense_Type : tReport_InterfaceForm;
      frm_Report_Expense_ByCycle : tReport_InterfaceForm;
      frm_Report_Expense_ListByCycle : tReport_InterfaceForm;
      frm_Report_EarningVsExpenseByCycle : tReport_InterfaceForm;
      frm_Report_Product_SingleProduct : tReport_InterfaceForm;
      frm_Report_Product_QuantityOnHand : tReport_InterfaceForm;
      frm_Report_Product_ProductList : tReport_InterfaceForm;
      frm_Report_Accounting_FeesCollectedByCycle : tReport_InterfaceForm;
      frm_Report_Accounting_ShippingCollectedByCycle : tReport_InterfaceForm;
      frm_Report_Accounting_TaxesCollectedByCycle : tReport_InterfaceForm;
      frm_Report_Accounting_TaxExemptByCycle : tReport_InterfaceForm;
      frm_Report_Accounting_DepositSlipByCycle : tReport_InterfaceForm;
      frm_Report_Accounting_VoidNSFByCycle : tReport_InterfaceForm;
      frm_Report_Accounting_ReturnsByCycle : tReport_InterfaceForm;
      frm_Report_Accounting_TransactionLogByCycle : tReport_InterfaceForm;
      frm_Report_OrderProductList : tReport_InterfaceForm;
      frm_Report_ReturnProductList : tReport_InterfaceForm;
      frm_Report_AccountingShippingReturned : tReport_InterfaceForm;
      frm_Report_AccountingFeesReturned : tReport_InterfaceForm;
      frm_Report_Customer_OutstandingBalanace : tReport_InterfaceForm;
      frm_Report_Accounting_CycleBreakDown : tReport_InterfaceForm;
      frm_Report_CustomerEscrowBalance : tReport_InterfaceForm;
      //
      procedure HandleCloseForm(Sender: TObject);
   public
      procedure Report_Customer_CustomerList();
      procedure Report_Customer_CustomerTopCustByOrd();
      procedure Report_Customer_CustomerTopCustByMoney();
      procedure Report_Order_OrderList();
      procedure Report_EarningTypes();
      procedure Report_EarningByCycle();
      procedure Report_EarningListByCycle();
      procedure Report_ExpenseType();
      procedure Report_ExpenseByCycle();
      procedure Report_ExpenseListByCycle();
      procedure Report_EarningVsExpenseByCycle();
      procedure Report_OrderLabels();
      procedure Report_ProductQuantityOnHand();
      procedure Report_CustomerOrderHistory();
      procedure Report_OrderBackOrderList();
      procedure Report_AccountingFeesCollectedByCycle();
      procedure Report_AccountingShippingCollectedByCycle();
      procedure Report_TaxesCollectedByCycle();
      procedure Report_AccountingTaxExemptByCycle();
      procedure Report_AccountingDepositSlipByCycle();
      procedure Report_AccountingVoidNSFByCycle();
      procedure Report_AccountingReturnsByCycle();
      procedure Report_AccountingTransactionLogByCycle();
      procedure Report_CustomerOrderTransactionHistory();
      procedure Report_ProductList();
      procedure Report_CycleListByOrg();
      procedure Report_CustomerLabels();
      procedure Report_PrintSingleCustomer( inCustID : string );
      procedure Report_OrderProductList();
      procedure Report_ProductReturnList();
      procedure Report_AccountingShippingReturned();
      procedure Report_AccountingFeesReturned();
      procedure Report_CustomerOutstandingBalance();
      procedure Report_Accounting_CycleBreakDown();
      procedure Report_CustomerEscrow();
      //
      procedure GlobalRefreshEvent();
   	procedure StartForm;
      procedure StopForm;
      procedure DockForm(inForm: tForm; inFormType : integer);
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


procedure tControlForm_Report.DockForm(inForm: tForm; inFormType: integer);
begin
	inForm.ManualDock(MAIN_DOCK_PANEL, nil, alClient);
   inForm.BorderStyle := bsNone;
   inForm.Left := (MAIN_DOCK_PANEL.Width - MAIN_DOCK_PANEL.Width) div 2;
   inForm.Top := (MAIN_DOCK_PANEL.Height - MAIN_DOCK_PANEL.Height) div 2;
   inForm.WindowState := wsMaximized;
   inForm.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
   inForm.BorderIcons := [];
   inForm.Position := poDefault;
   inForm.OnDestroy := HandleCloseForm;
   inForm.Tag := inFormType;
end;

procedure tControlForm_Report.GlobalRefreshEvent;
begin
   // we do not do anything because these are reports.
end;

procedure tControlForm_Report.HandleCloseForm(Sender: TObject);
begin
   case tForm(Sender).Tag of
      CMD_REPORT_CUSTOMER_LIST: frm_Report_Customer_List := Nil;
      CMD_REPORT_CUSTOMER_TOPCUSTBYORD: frm_Report_Customer_TopCustByOrd := Nil;
      CMD_REPORT_ACCOUNTINGDEPOSITSLIPBYCYCLE:                 frm_Report_Accounting_DepositSlipByCycle       := Nil;
      CMD_REPORT_ACCOUNTINGFEESCOLLECTEDBYCYCLE:               frm_Report_Accounting_FeesCollectedByCycle     := Nil;
      CMD_REPORT_ACCOUNTINGRETURNSBYCYCLE:                     frm_Report_Accounting_ReturnsByCycle           := Nil;
      CMD_REPORT_ACCOUNTINGSHIPPINGCOLLECTEDBYCYCLE:           frm_Report_Accounting_ShippingCollectedByCycle := Nil;
      CMD_REPORT_ACCOUNTINGTAXEXEMPTBYCYCLE:                   frm_Report_Accounting_TaxExemptByCycle         := Nil;
      CMD_REPORT_ACCOUNTINGTRANSACTIONLOGBYCYCLE:              frm_Report_Accounting_TransactionLogByCycle    := Nil;
      CMD_REPORT_ACCOUNTINGVOIDNSFBYCYCLE:                     frm_Report_Accounting_VoidNSFByCycle           := Nil;
      CMD_REPORT_CUSTOMER_LABELS:                              frm_Report_CustomerLabels                      := Nil;
      CMD_REPORT_CUSTOMERORDERHISTORY:                         frm_Report_Customer_OrderHistory               := Nil;
      CMD_REPORT_CUSTOMERORDERTRANSACTIONHISTORY:              frm_Report_Customer_OrderTransactionHistory    := Nil;
      CMD_REPORT_CUSTOMER_TOPCUSTBYMONEY:                      frm_Report_Customer_TopCustByMoney             := Nil;
      CMD_REPORT_CYCLE_CYCLELISTBYORG:                         frm_Report_Cycle_CycleListByOrg                := Nil;
      CMD_REPORT_EARNINGBYCYCLE:                               frm_Report_Earning_EarningByCycle              := Nil;
      CMD_REPORT_EARNINGLISTBYCYCLE:                           frm_Report_Earning_ListByCycle                 := Nil;
      CMD_REPORT_EARNING_TYPES:                                frm_Report_Earning_Types                       := Nil;
      CMD_REPORT_EARNINGVSEXPENSEBYCYCLE:                      frm_Report_EarningVsExpenseByCycle             := Nil;
      CMD_REPORT_EXPENSEBYCYCLE:                               frm_Report_Expense_ByCycle                     := Nil;
      CMD_REPORT_EXPENSELISTBYCYCLE:                           frm_Report_Expense_ListByCycle                 := Nil;
      CMD_REPORT_EXPENSETYPE:                                  frm_Report_Expense_Type                        := Nil;
      CMD_REPORT_ORDERBACKORDERLIST:                           frm_Report_Order_BackOrderList                 := Nil;
      CMD_REPORT_ORDERLABELS:                                  frm_Report_Order_Labels                        := Nil;
      CMD_REPORT_ORDER_LIST:                                   frm_Report_Order_List                          := Nil;
      CMD_REPORT_CUSTOMERSINGLECUSTOMER:                       frm_Report_Customer_SingleCustomer             := Nil;
      CMD_REPORT_PRODUCTPRODUCTLIST:                           frm_Report_Product_ProductList                 := Nil;
      CMD_REPORT_PRODUCTQUANTITYONHAND:                        frm_Report_Product_QuantityOnHand              := Nil;
      CMD_REPORT_ACCOUNTINGTAXESCOLLECTEDBYCYCLE:              frm_Report_Accounting_TaxesCollectedByCycle    := Nil;
      CMD_REPORT_ORDER_ORDERPRODUCTLIST:                       frm_Report_OrderProductList                    := Nil;
      CMD_REPORT_ORDER_PRODUCTRETURNLIST:                      frm_Report_ReturnProductList := Nil;
      CMD_REPORT_ACCOUNTINGSHIPPINGRETURNED:                   frm_Report_AccountingShippingReturned          := Nil;
      CMD_REPORT_ACCOUNTINGFEESRETURNED:                       frm_Report_AccountingFeesReturned              := Nil;
   end;
end;

procedure tControlForm_Report.StartForm;
begin
   // We do nothing because it is done outside.
end;

procedure tControlForm_Report.StopForm;
begin
	if (frm_Report_Customer_List <> NIL) then
   	frm_Report_Customer_List.CloseForm();
	if (frm_Report_Customer_TopCustByOrd <> NIL) then
   	frm_Report_Customer_TopCustByOrd.CloseForm();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//###### REPORTS ##################################################################################//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Report.Report_AccountingDepositSlipByCycle;
begin
	if (frm_Report_Accounting_DepositSlipByCycle = NIL) then
   begin
   	frm_Report_Accounting_DepositSlipByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_DepositSlipByCycle);
      //
      DockForm( frm_Report_Accounting_DepositSlipByCycle, CMD_REPORT_ACCOUNTINGDEPOSITSLIPBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_DepositSlipByCycle <> NIL) then
   	frm_Report_Accounting_DepositSlipByCycle.Show();
end;

procedure tControlForm_Report.Report_AccountingFeesCollectedByCycle;
begin
	if (frm_Report_Accounting_FeesCollectedByCycle = NIL) then
   begin
   	frm_Report_Accounting_FeesCollectedByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_FeesCollectedByCycle);
      //
      DockForm( frm_Report_Accounting_FeesCollectedByCycle, CMD_REPORT_ACCOUNTINGFEESCOLLECTEDBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_FeesCollectedByCycle <> NIL) then
   	frm_Report_Accounting_FeesCollectedByCycle.Show();
end;


procedure tControlForm_Report.Report_AccountingReturnsByCycle;
begin
	if (frm_Report_Accounting_ReturnsByCycle = NIL) then
   begin
   	frm_Report_Accounting_ReturnsByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_ReturnsByCycle);
      //
      DockForm( frm_Report_Accounting_ReturnsByCycle, CMD_REPORT_ACCOUNTINGRETURNSBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_ReturnsByCycle <> NIL) then
   	frm_Report_Accounting_ReturnsByCycle.Show();
end;

procedure tControlForm_Report.Report_AccountingShippingCollectedByCycle;
begin
	if (frm_Report_Accounting_ShippingCollectedByCycle = NIL) then
   begin
   	frm_Report_Accounting_ShippingCollectedByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_ShippingCollectedByCycle);
      //
      DockForm( frm_Report_Accounting_ShippingCollectedByCycle, CMD_REPORT_ACCOUNTINGSHIPPINGCOLLECTEDBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_ShippingCollectedByCycle <> NIL) then
   	frm_Report_Accounting_ShippingCollectedByCycle.Show();
end;


procedure tControlForm_Report.Report_AccountingTaxExemptByCycle;
begin
	if (frm_Report_Accounting_TaxExemptByCycle = NIL) then
   begin
   	frm_Report_Accounting_TaxExemptByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_TaxExemptByCycle);
      //
      DockForm( frm_Report_Accounting_TaxExemptByCycle, CMD_REPORT_ACCOUNTINGTAXEXEMPTBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_TaxExemptByCycle <> NIL) then
   	frm_Report_Accounting_TaxExemptByCycle.Show();
end;

procedure tControlForm_Report.Report_AccountingTransactionLogByCycle;
begin
	if (frm_Report_Accounting_TransactionLogByCycle = NIL) then
   begin
   	frm_Report_Accounting_TransactionLogByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_TransactionLogByCycle);
      //
      DockForm( frm_Report_Accounting_TransactionLogByCycle, CMD_REPORT_ACCOUNTINGTRANSACTIONLOGBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_TransactionLogByCycle <> NIL) then
   	frm_Report_Accounting_TransactionLogByCycle.Show();
end;

procedure tControlForm_Report.Report_AccountingVoidNSFByCycle;
begin
	if (frm_Report_Accounting_VoidNSFByCycle = NIL) then
   begin
   	frm_Report_Accounting_VoidNSFByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_VoidNSFByCycle);
      //
      DockForm( frm_Report_Accounting_VoidNSFByCycle, CMD_REPORT_ACCOUNTINGVOIDNSFBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_VoidNSFByCycle <> NIL) then
   	frm_Report_Accounting_VoidNSFByCycle.Show();
end;

procedure tControlForm_Report.Report_Accounting_CycleBreakDown;
begin
	if (frm_Report_Accounting_CycleBreakDown = NIL) then
   begin
   	frm_Report_Accounting_CycleBreakDown := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_OrderAmountBreakDownByCycle);
      //
      DockForm( frm_Report_Accounting_CycleBreakDown, CMD_REPORT_ACCOUNTING_ORDERAMOUNTBREAKDOWNBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_CycleBreakDown <> NIL) then
   	frm_Report_Accounting_CycleBreakDown.Show();
end;

procedure tControlForm_Report.Report_CustomerEscrow;
begin
	if (frm_Report_CustomerEscrowBalance = NIL) then
   begin
   	frm_Report_CustomerEscrowBalance := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_EscrowBalance);
      //
      DockForm( frm_Report_CustomerEscrowBalance, CMD_REPORT_CUSTOMER_ESCROW );
   end;
   //
   if (frm_Report_CustomerEscrowBalance <> NIL) then
   	frm_Report_CustomerEscrowBalance.Show();
end;

procedure tControlForm_Report.Report_CustomerLabels;
begin
	if (frm_Report_CustomerLabels = NIL) then
   begin
   	frm_Report_CustomerLabels := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_Labels);
      //
      DockForm( frm_Report_CustomerLabels, CMD_REPORT_CUSTOMER_LABELS );
   end;
   //
   if (frm_Report_CustomerLabels <> NIL) then
   	frm_Report_CustomerLabels.Show();
end;

procedure tControlForm_Report.Report_CustomerOrderHistory;
begin
	if (frm_Report_Customer_OrderHistory = NIL) then
   begin
   	frm_Report_Customer_OrderHistory := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_OrderHistory);
      //
      DockForm( frm_Report_Customer_OrderHistory, CMD_REPORT_CUSTOMERORDERHISTORY );
   end;
   //
   if (frm_Report_Customer_OrderHistory <> NIL) then
   	frm_Report_Customer_OrderHistory.Show();
end;

procedure tControlForm_Report.Report_CustomerOrderTransactionHistory;
begin
	if (frm_Report_Customer_OrderTransactionHistory = NIL) then
   begin
   	frm_Report_Customer_OrderTransactionHistory := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_OrderTransactionHistory);
      //
      DockForm( frm_Report_Customer_OrderTransactionHistory, CMD_REPORT_CUSTOMERORDERTRANSACTIONHISTORY );
   end;
   //
   if (frm_Report_Customer_OrderTransactionHistory <> NIL) then
   	frm_Report_Customer_OrderTransactionHistory.Show();
end;

procedure tControlForm_Report.Report_CustomerOutstandingBalance;
begin
	if (frm_Report_Customer_OutstandingBalanace = NIL) then
   begin
   	frm_Report_Customer_OutstandingBalanace := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_OutstandingBalance );
      //
      DockForm( frm_Report_Customer_OutstandingBalanace, CMD_REPORT_CUSTOMEROUTSTANDINGBALANCE );
   end;
   //
   if (frm_Report_Customer_OutstandingBalanace <> NIL) then
   	frm_Report_Customer_OutstandingBalanace.Show();
end;

procedure tControlForm_Report.Report_Customer_CustomerList;
begin
	if (frm_Report_Customer_List = NIL) then
   begin
   	frm_Report_Customer_List := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_List );
      //
      DockForm( frm_Report_Customer_List, CMD_REPORT_CUSTOMER_LIST );
   end;
   //
   if (frm_Report_Customer_List <> NIL) then
   	frm_Report_Customer_List.Show();
end;

procedure tControlForm_Report.Report_Customer_CustomerTopCustByMoney;
begin
	if (frm_Report_Customer_TopCustByMoney = NIL) then
   begin
   	frm_Report_Customer_TopCustByMoney := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_TopCustByMoney );
      //
      DockForm( frm_Report_Customer_TopCustByMoney, CMD_REPORT_CUSTOMER_TOPCUSTBYMONEY );
   end;
   //
   if (frm_Report_Customer_TopCustByMoney <> NIL) then
   	frm_Report_Customer_TopCustByMoney.Show();
end;

procedure tControlForm_Report.Report_Customer_CustomerTopCustByOrd;
begin
	if (frm_Report_Customer_TopCustByOrd = NIL) then
   begin
   	frm_Report_Customer_TopCustByOrd := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_TopCustByOrd );
      //
      DockForm( frm_Report_Customer_TopCustByOrd, CMD_REPORT_CUSTOMER_TOPCUSTBYORD );
   end;
   //
   if (frm_Report_Customer_TopCustByOrd <> NIL) then
   	frm_Report_Customer_TopCustByOrd.Show();
end;

procedure tControlForm_Report.Report_CycleListByOrg;
begin
	if (frm_Report_Cycle_CycleListByOrg = NIL) then
   begin
   	frm_Report_Cycle_CycleListByOrg := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Cycle_CycleListByOrg);
      //
      DockForm( frm_Report_Cycle_CycleListByOrg, CMD_REPORT_CYCLE_CYCLELISTBYORG );
   end;
   //
   if (frm_Report_Cycle_CycleListByOrg <> NIL) then
   	frm_Report_Cycle_CycleListByOrg.Show();
end;

procedure tControlForm_Report.Report_EarningByCycle;
begin
	if (frm_Report_Earning_EarningByCycle = NIL) then
   begin
   	frm_Report_Earning_EarningByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Earning_EarningByCycle);
      //
      DockForm( frm_Report_Earning_EarningByCycle, CMD_REPORT_EARNINGBYCYCLE );
   end;
   //
   if (frm_Report_Earning_EarningByCycle <> NIL) then
   	frm_Report_Earning_EarningByCycle.Show();
end;

procedure tControlForm_Report.Report_EarningListByCycle;
begin
	if (frm_Report_Earning_ListByCycle = NIL) then
   begin
   	frm_Report_Earning_ListByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Earning_ListByCycle);
      //
      DockForm( frm_Report_Earning_ListByCycle, CMD_REPORT_EARNINGLISTBYCYCLE );
   end;
   //
   if (frm_Report_Earning_ListByCycle <> NIL) then
   	frm_Report_Earning_ListByCycle.Show();
end;

procedure tControlForm_Report.Report_EarningTypes;
begin
	if (frm_Report_Earning_Types = NIL) then
   begin
   	frm_Report_Earning_Types := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Earning_Types);
      //
      DockForm( frm_Report_Earning_Types, CMD_REPORT_EARNING_TYPES );
   end;
   //
   if (frm_Report_Earning_Types <> NIL) then
   	frm_Report_Earning_Types.Show();
end;

procedure tControlForm_Report.Report_EarningVsExpenseByCycle;
begin
	if (frm_Report_EarningVsExpenseByCycle = NIL) then
   begin
   	frm_Report_EarningVsExpenseByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_EarningVsExpenseByCycle);
      //
      DockForm( frm_Report_EarningVsExpenseByCycle, CMD_REPORT_EARNINGVSEXPENSEBYCYCLE );
   end;
   //
   if (frm_Report_EarningVsExpenseByCycle <> NIL) then
   	frm_Report_EarningVsExpenseByCycle.Show();
end;
procedure tControlForm_Report.Report_ExpenseByCycle;
begin
	if (frm_Report_Expense_ByCycle = NIL) then
   begin
   	frm_Report_Expense_ByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Expense_ByCycle);
      //
      DockForm( frm_Report_Expense_ByCycle, CMD_REPORT_EXPENSEBYCYCLE );
   end;
   //
   if (frm_Report_Expense_ByCycle <> NIL) then
   	frm_Report_Expense_ByCycle.Show();
end;

procedure tControlForm_Report.Report_ExpenseListByCycle;
begin
	if (frm_Report_Expense_ListByCycle = NIL) then
   begin
   	frm_Report_Expense_ListByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Expense_ListByCycle);
      //
      DockForm( frm_Report_Expense_ListByCycle, CMD_REPORT_EXPENSELISTBYCYCLE );
   end;
   //
   if (frm_Report_Expense_ListByCycle <> NIL) then
   	frm_Report_Expense_ListByCycle.Show();
end;

procedure tControlForm_Report.Report_ExpenseType;
begin
	if (frm_Report_Expense_Type = NIL) then
   begin
   	frm_Report_Expense_Type := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Expense_Type);
      //
      DockForm( frm_Report_Expense_Type, CMD_REPORT_EXPENSETYPE );
   end;
   //
   if (frm_Report_Expense_Type <> NIL) then
   	frm_Report_Expense_Type.Show();
end;

procedure tControlForm_Report.Report_OrderBackOrderList;
begin
	if (frm_Report_Order_BackOrderList = NIL) then
   begin
   	frm_Report_Order_BackOrderList := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Order_BackOrderList);
      //
      DockForm( frm_Report_Order_BackOrderList, CMD_REPORT_ORDERBACKORDERLIST );
   end;
   //
   if (frm_Report_Order_BackOrderList <> NIL) then
   	frm_Report_Order_BackOrderList.Show();
end;

procedure tControlForm_Report.Report_OrderLabels;
begin
	if (frm_Report_Order_Labels = NIL) then
   begin
   	frm_Report_Order_Labels := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Order_Labels);
      //
      DockForm( frm_Report_Order_Labels, CMD_REPORT_ORDERLABELS );
   end;
   //
   if (frm_Report_Order_Labels <> NIL) then
   	frm_Report_Order_Labels.Show();
end;

procedure tControlForm_Report.Report_Order_OrderList;
begin
	if (frm_Report_Order_List = NIL) then
   begin
   	frm_Report_Order_List := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Order_List);
      //
      DockForm( frm_Report_Order_List, CMD_REPORT_ORDER_LIST );
   end;
   //
   if (frm_Report_Order_List <> NIL) then
   	frm_Report_Order_List.Show();
end;

procedure tControlForm_Report.Report_PrintSingleCustomer(inCustID: string);
begin
	if (frm_Report_Customer_SingleCustomer = NIL) then
   begin
   	frm_Report_Customer_SingleCustomer := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Customer_SingleCustomer);
      //
      DockForm( frm_Report_Customer_SingleCustomer, CMD_REPORT_CUSTOMERSINGLECUSTOMER );
      frm_Report_Customer_SingleCustomer.CustID := inCustID;
   end;
   //
   if (frm_Report_Customer_SingleCustomer <> NIL) then
   	frm_Report_Customer_SingleCustomer.Show();
end;

procedure tControlForm_Report.Report_ProductList;
begin
	if (frm_Report_Product_ProductList = NIL) then
   begin
   	frm_Report_Product_ProductList := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Product_ProductList);
      //
      DockForm( frm_Report_Product_ProductList, CMD_REPORT_PRODUCTPRODUCTLIST );
   end;
   //
   if (frm_Report_Product_ProductList <> NIL) then
   	frm_Report_Product_ProductList.Show();
end;

procedure tControlForm_Report.Report_ProductQuantityOnHand;
begin
	if (frm_Report_Product_QuantityOnHand = NIL) then
   begin
   	frm_Report_Product_QuantityOnHand := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Product_QTYOnHand);
      //
      DockForm( frm_Report_Product_QuantityOnHand, CMD_REPORT_PRODUCTQUANTITYONHAND );
   end;
   //
   if (frm_Report_Product_QuantityOnHand <> NIL) then
   	frm_Report_Product_QuantityOnHand.Show();
end;



procedure tControlForm_Report.Report_TaxesCollectedByCycle;
begin
	if (frm_Report_Accounting_TaxesCollectedByCycle = NIL) then
   begin
   	frm_Report_Accounting_TaxesCollectedByCycle := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_TaxesCollectedByCycle);
      //
      DockForm( frm_Report_Accounting_TaxesCollectedByCycle, CMD_REPORT_ACCOUNTINGTAXESCOLLECTEDBYCYCLE );
   end;
   //
   if (frm_Report_Accounting_TaxesCollectedByCycle <> NIL) then
   	frm_Report_Accounting_TaxesCollectedByCycle.Show();
end;

procedure tControlForm_Report.Report_OrderProductList;
begin
	if (frm_Report_OrderProductList = NIL) then
   begin
   	frm_Report_OrderProductList := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Order_OrderProductList);
      //
      DockForm( frm_Report_OrderProductList, CMD_REPORT_ORDER_ORDERPRODUCTLIST );
   end;
   //
   if (frm_Report_OrderProductList <> NIL) then
   	frm_Report_OrderProductList.Show();
end;


procedure tControlForm_Report.Report_ProductReturnList;
begin
	if (frm_Report_ReturnProductList = NIL) then
   begin
   	frm_Report_ReturnProductList := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Product_ReturnProductList);
      //
      DockForm( frm_Report_ReturnProductList, CMD_REPORT_ORDER_PRODUCTRETURNLIST );
   end;
   //
   if (frm_Report_ReturnProductList <> NIL) then
   	frm_Report_ReturnProductList.Show();
end;


procedure tControlForm_Report.Report_AccountingFeesReturned;
begin
	if (frm_Report_AccountingFeesReturned = NIL) then
   begin
   	frm_Report_AccountingFeesReturned := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_FeesReturned);
      //
      DockForm( frm_Report_AccountingFeesReturned, CMD_REPORT_ACCOUNTINGFEESRETURNED );
   end;
   //
   if (frm_Report_AccountingFeesReturned <> NIL) then
   	frm_Report_AccountingFeesReturned.Show();
end;

procedure tControlForm_Report.Report_AccountingShippingReturned;
begin
	if (frm_Report_AccountingShippingReturned = NIL) then
   begin
   	frm_Report_AccountingShippingReturned := tReport_InterfaceForm.Create(Application, tReportTypes.Report_Accounting_ShippingReturned);
      //
      DockForm( frm_Report_AccountingShippingReturned, CMD_REPORT_ACCOUNTINGSHIPPINGRETURNED );
   end;
   //
   if (frm_Report_AccountingShippingReturned <> NIL) then
   	frm_Report_AccountingShippingReturned.Show();
end;

end.



