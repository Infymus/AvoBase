 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MainForm_FormControlUnit;

// this piece will have to be created prior to mainform. because once mainform is created,
// this form has to be created and the welcomeform docked to it. this form handles ALL events
// in and out of all of the objects.
//
// ControlForm <- WelcomeForm
// ControlForm <- CustomerControlForm <- CustomerListForm <- CustomerEditFOrm

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   img_storageformunit,
   avobase_dialogformunit,
   avobase_helpformunit,
   avobase_baseform_menuunit,
   avobase_baseform_standardunit,
   actionunit,
   //
   // All of the forms that are dockable
   welcomeformunit,
   customer_controlformunit,
   product_controlformunit,
   order_controlformunit,
   ShellAPI,
   cycle_controlformunit,
   brochure_controlformunit,
   preference_menuformunit,
   expense_controlformunit,
   earning_controlformunit,
   AvoBase_PercentFormUnit,
   email_controlformunit,
   toolbox_ordertoolboxunit,
   Accounting_ControlFormUnit,
   Report_ControlFormUnit,
   Preference_BaseFormUnit,
   Preference_RegistrationFormUnit,
   AvoBase_UpdateViewerFormUnit,
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
   Buttons,
   ExtCtrls,
   ComCtrls,
   ActnList,
   ToolWin;

const
   // Control Forms
   FORM_CONTROL_CUSTOMER = 300;
   FORM_CONTROL_PRODUCT = 301;
   FORM_CONTROL_CYCLE = 302;
   FORM_CONTROL_ORDER = 303;
   FORM_CONTROL_CUSTOMER_SELECT = 304;
   FORM_CONTROL_PRODUCT_SELECT = 305;

   // Form Constants
   FORM_WELCOME = 100;
   FORM_PREFERENCES = 101;
   FORM_CUSTOMERS = 102;
   FORM_PRODUCTS = 103;
   FORM_CYCLES = 104;
   FORM_CUSTLIST = 105;
   FORM_SUMMARY = 106;
   FORM_REPORT = 107;
   FORM_EXPENSES = 108;
   FORM_BROCHURES = 109;
   FORM_EARNINGS = 110;
   FORM_ORDERS = 111;
   FORM_HELPERS = 112;
   FORM_EARNINGS_TYPES = 113;
   FORM_EXPENSES_TYPES = 114;
   FORM_CAMP_PRODUCT_COST = 115;
   FORM_AWARDS = 116;
   FORM_EMAIL = 117;
   FORM_HELP = 118;
   FORM_FEEDBACK = 119;
   FORM_ACCOUNTING = 120;

{
   // Report Constants
   FORM_REPORT_EXPENSETYPE = 200;
   FORM_REPORT_EARNINGTYPE = 201;
   FORM_REPORT_EARNINGSBYYEAR = 202;
   FORM_REPORT_CUSTOMER_LIST = 203;
   FORM_REPORT_ONHANDPRODUCT = 204;
   FORM_REPORT_ORDERLABEL = 205;
   FORM_REPORT_TOPCUSTOMER = 206;
   FORM_REPORT_TOPCUSTOMERMONEY = 207;
   FORM_REPORT_ORDERPRODUCTLIST = 208;
   FORM_REPORT_CAMPAIGNSUMMARY = 209;
   FORM_REPORT_EARNINGSVSEXPENSES = 210;
   FORM_REPORT_CUSTOMERLIST = 211;
   FORM_REPORT_ORDERLIST = 212;
   FORM_REPORT_ORDERBYCAMP = 213;
   FORM_REPORT_PRINTSINGLECUST = 214;
}
type
   tFormControl = class( tObject )
   private
   	fDockObj : tScrollBox;

   	// event handlers coming out of all of the forms and how to handle them
      // all of the forms WE need to worry about. we don't worry about forms used by forms.

(* BIG NOTICE HERE HOENIE...

   this area was original built on the foundation that a control form would dock onto the main dock panel,
   and every subsequent form would dock that dock_form's dock panel. it was under the assumption that
   a list form, view form, edit form, report form - would all be dockable. but the direction
   you seem to be going is with edit and view forms being modal popups - this all seems
   like a lot of extra work. then again, expandable you do got...
*)

      //
      fOnLoadOrderEvent : tLoadOrderEvent;
      fOnRibbonChangeEvent : tRibbonChangeEvent;
      fOnCheckForUpdatesEvent : tCheckForUpdatesEvent;
      FNewOrderWithCustomerEvent : tnewOrderWithCustomerEvent;
      fOrderListEditCustomerEvent : tOrderListEditCustomerEvent;
      //
      procedure HandleCloseForm(Sender: TObject);
      procedure HandleWelcomeEvent(Sender : tObject; actionID : integer );
      procedure HandleOnLoadOrderEvent( sender : tObject; inOrderID : string );
      procedure HandleOnNewOrderWithCustomerEvent( inCustId : string );
      procedure HandleOnMethodOfPaymentCustomerEvent( inCustID : string );
      Procedure HandleOnViewOrderInvoiceEvent( sender : tObject; inOrderID : string );
      Procedure HandleOnPrintOrderInvoiceEvent ( sender : tObject; inOrderID : string );
      Procedure HandleOnCancelUnCancelOrderEvent( CancelType : tCanceLtypes; InorderID : string );
      Procedure HandleOnTakeMethodOFPayment( inOrderID : string );
      Procedure HandleOnNewReturn( inOrderID : string );
      procedure HandleInvoiceUpdated;
      procedure AssignOrderControlEvents;
      procedure HandleBackOrderDeliveredEvent( InProdID,InBOProdID : string );
      procedure HandleBackOrderNotAvailableEvent( InProdID,InBOProdID : string );
      procedure HandleEmailUpdateEvent;
      //
      procedure HandleOrderRefreshEvent();
      procedure HandleCustomerRefreshEvent();
      procedure HandleProductRefreshEvent();
      procedure HandleCycleRefreshEvent();
      procedure HandleExpenseRefreshEvent();
      procedure HandleEarningRefreshEvent();
      procedure HandleEmailRefreshEvent();
      procedure HandlePreferenceRefreshEvent();
      procedure HandleEmailEvent( inOrderID : string );
      procedure HandleVoidMethodOfPaymentCustomerEvent( inCustID : string );
      procedure HandleOnViewPrintCustomerEvent( inCustID : string );
      procedure HandleEOnOrderListEditCustomerEvent( inCustID : string );
      procedure HandleOnEmailCycle( inCycleID : string );
      //
   public
      frm_Welcome : tWelcomeForm;
      frm_CustControl : TControlForm_Customer;
      frm_ProdControl : tControlForm_Product;
      frm_OrderControl : tControlForm_Order;
      frm_CycleControl : TControlForm_Cycle;
      frm_BrochureControl : tControlForm_Brochure;
      frm_ExpenseControl : tControlForm_Expense;
      frm_EarningControl : tControlForm_Earning;
      frm_EmailControl : tControlForm_Email;
      frm_AccountingControl : tControlForm_Accounting;
      frm_Report : tControlForm_Report;

      // <-------------------------------------------------------------------> //
      // MAIN FORM
      procedure CreatePreferencesStartup;
      procedure CreatePreferences( inPrefArea : tPrefAreaTypes );
      procedure MainHelp();
      procedure Forums();
      procedure ContactUs();
      procedure CheckUpdates();
      procedure RegisterAvoBase();
      procedure HomeButton();
      procedure BlogButton();
      procedure FaceBook();
      procedure ViewUpdates();

      // <-------------------------------------------------------------------> //
      // CUSTOMERS
      procedure CustomerActivateDeactivate();
      procedure CustomerNew();
      procedure CustomerEdit();
      procedure CustomerView();
      procedure CustomerEmail();
      procedure CustomerPrint();
      procedure CustomerHelp();
      procedure CustomerReport();
      procedure CustomerNewOrder();
      procedure CustomerNewREturn();
      procedure CustomerPayment();
      procedure CustomerNSF();
      procedure CustomerVoidPayment();
      procedure CustomerViewAccount();
      procedure CustomerNotes();
      procedure CustomerOrderProd();
      procedure ImportCustomer();
      procedure ExportCustomer();

      // <-------------------------------------------------------------------> //
      // Orders
      procedure OrderList();
      procedure OrderNew();
      procedure OrderReturn();
      procedure OrderLoad();
      procedure OrderViewInvoice();
      procedure OrderPrintInvoice();
      procedure OrderReport();
      procedure OrderPayment();
      procedure OrderNSF();
      procedure OrderVoidPayment();
      procedure OrderHelp();
      procedure OrderFinalize();
      procedure OrderLoadNum();
      procedure OrderCancel();
      procedure OrderUnCancel();
      procedure OrderBackOrderManager();
      procedure OrderChangeCycle();
      procedure OrderReturnManager();
		procedure OrderSaveInvoice();
      procedure PrintAllCycleInvoices();
      procedure EmailAllCycleInvoices();
      procedure OrderEmailInvoice();
      procedure OrderCustomerProduct();
      function Order_EnableDisableButtons : Boolean;

      // <-------------------------------------------------------------------> //
      // Products
      procedure ProductNew();
      procedure ProductEdit();
      procedure ProductHelp();
      procedure ProductReports();
      procedure ProductPrint();
      procedure ProductDelete();
      procedure ProductView();
      procedure BackOrderManager();
      procedure ProductImport();
      procedure ProductExport();
      function Product_EnableDisableButtons : Boolean;

      // <-------------------------------------------------------------------> //
      // Cycles
      procedure CycleNew();
      procedure CycleEdit();
      procedure CycleGenerate();
      procedure CycleReports();
      procedure CycleView();
      procedure CycleViewOrders();
      procedure CycleHelp();

      // <-------------------------------------------------------------------> //
      // Brocures
      procedure BrochureList();
      procedure BrochureNew();
      procedure BrochureEdit();
      procedure BrochureDelete();
      procedure BrochureView();
      procedure BrochureReports;
      procedure BrochureHelp();

      // <-------------------------------------------------------------------> //
      // Expenses
      procedure ExpenseNew();
      procedure ExpenseEdit();
      procedure ExpenseView();
      procedure ExpensePrint();
      procedure ExpenseHelp();
      procedure ExpenseReports();
      procedure ExpenseLoadByCycle();
      procedure ExpenseQuickAdd();
      procedure EditExpenseTypes();
      function Expense_EnableDisableButtons : boolean;

      // <-------------------------------------------------------------------> //
      // Earnings
      procedure EarningNew();
      procedure EarningEdit();
      procedure EarningView();
      procedure EarningPrint();
      procedure EarningHelp();
      procedure EarningReports();
      procedure EarningLoadByCycle();
      procedure EarningQuickAdd();
      procedure EditEarningTypes();
      function Earning_EnableDisableButtons : boolean;

      // <-------------------------------------------------------------------> //
      // Email
      procedure EmailRequeue();
      procedure EmailSend();
      procedure EmailSendAll();
      procedure EmailDelete();
      procedure EmailDeleteAll();
      procedure EmailSetting();
      procedure EmailHelp();
      procedure EmailClean();
      procedure EmailRequeueAll();

      // <-------------------------------------------------------------------> //
      // Accounting
      procedure AccountingEscrow();
      procedure AccountingTransactions();
      procedure AccountingHelp();

      // <-------------------------------------------------------------------> //
      // Reports
      procedure ShowReportForm();
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
      procedure Report_OrderProductList();
      procedure Report_ProductReturnList();
      procedure Report_AccountingShippingReturned();
      procedure Report_AccountingFeesReturned();
      procedure Report_CustomerOutstandingBalance();
      procedure Report_Accounting_CycleBreakDown();
      procedure Report_CustomerEscrow();

      // <-------------------------------------------------------------------> //
      // Form Control Specifics
      //
      procedure Browse;

      function OrderControlListState : boolean;
      property OnRibbonChangeEvent : tRibbonChangeEvent read fOnRibbonChangeEvent write fOnRibbonChangeEvent;
      property OnCheckForUpdatesEvent : tCheckForUpdatesEvent read fOnCheckForUpdatesEvent write fOnCheckForUpdatesEvent;
      procedure CreateItem( inFormType, inReportType : integer; inDockObj : tScrollBox );
      procedure ShutDown;
   end;

var formControl : tFormControl; // <--- This must stay here as it IS used.

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Destroy, Show'}

procedure tFormControl.CreateItem(inFormType, inReportType: integer; inDockObj: tScrollBox);
var
   ControlFormObject : tForm;
begin
   ControlFormObject := nil;
   fDockObj := inDockObj;

   // Assign the ControlFormObject
   case inFormType of
      FORM_WELCOME: ControlFormObject := frm_Welcome;
      FORM_CUSTOMERS: ControlFormObject := frm_CustControl;
      FORM_PRODUCTs: ControlFormObject := frm_ProdControl;
      FORM_CYCLES: ControlFormObject := frm_CycleControl;
      FORM_BROCHURES : ControlFormObject := frm_BrochureControl;
      FORM_ORDERS : ControlFormObject := frm_OrderControl;
      FORM_EXPENSES : ControlFormOBject := frm_ExpenseControl;
      FORM_EarningS : ControlFormOBject := frm_EarningControl;
      FORM_EMAIL : ControlFormOBject := frm_EmailControl;
      FORM_ACCOUNTING : ControlFormOBject := frm_AccountingControl;
      FORM_REPORT: ControlFormOBject := frm_Report;
   end;


   // If it is NOT created, then we create it.
   if NOT Assigned( ControlFormObject ) then
   begin

      {  Now create it.
         We could wrap the creation and then assigning into a sub class, but many of these forms
         require constructor methods and that just won't work. So while this is tedius, it is on purpose. }
      case inFormType of
         FORM_REPORT:
         begin
            frm_Report := tControlForm_Report.Create(Application);
            frm_Report.StartForm();
            ControlFormObject := frm_Report;
         end;
         FORM_ACCOUNTING:
         begin
            frm_AccountingControl := tControlForm_Accounting.Create(Application);
            frm_AccountingControl.StartForm();
            ControlFormObject := frm_AccountingControl;
         end;
         FORM_EMAIL:
         begin
            frm_EmailControl := tControlForm_Email.Create(Application);
            frm_EmailControl.StartForm();
            ControlFormObject := frm_EmailControl;
         end;
         FORM_EXPENSES:
         begin
            frm_ExpenseControl := tControlForm_Expense.Create(Application);
            frm_ExpenseControl.StartForm();
            ControlFormObject := frm_ExpenseControl;
         end;
         FORM_EarningS:
         begin
            frm_EarningControl := tControlForm_Earning.Create(Application);
            frm_EarningControl.StartForm();
            ControlFormObject := frm_EarningControl;
         end;
         FORM_WELCOME:
         begin
            frm_Welcome := TWelcomeForm.Create();
            frm_Welcome.onActionEvent := HandleWelcomeEvent;
            ControlFormObject := frm_Welcome;
         end;
         FORM_CUSTOMERS:
         begin
         	frm_CustControl := TControlForm_Customer.Create(Application);
            frm_CustControl.OnViewOrderInvoiceEvent := Self.HandleOnViewOrderInvoiceEvent;
            frm_CustControl.OnPrintOrderInvoiceEvent := Self.HandleOnPrintOrderInvoiceEvent;
            frm_CustControl.OnLoadOrderEvent := HandleOnLoadOrderEvent;
            frm_CustControl.OnNewOrderWithCustomerEvent := HandleOnNewOrderWithCustomerEvent;
            frm_CustControl.OnCustomerMethodOfPaymentEvent := HandleOnMethodOfPaymentCustomerEvent;
            frm_CustControl.OnCancelUnCancelOrderEvent := Self.HandleOnCancelUnCancelOrderEvent;
            frm_CustControl.OnTakeMethodOfPaymentEvent := Self.HandleOnTakeMethodOFPayment;
            frm_CustControl.OnReturnOrderEvent := Self.HandleOnNewReturn;
            frm_CustControl.OnVoidMethodOfPaymentEvent := Self.HandleVoidMethodOfPaymentCustomerEvent;
            frm_CustControl.OnCustomerRefreshEvent := Self.HandleCustomerRefreshEvent;
            frm_CustControl.OnViewPrintCustomerEvent := Self.HandleOnViewPrintCustomerEvent;
            frm_CustControl.StartForm();
            ControlFormObject := frm_CustControl;
         end;
         FORM_PRODUCTs:
         begin
         	frm_ProdControl := tControlForm_Product.Create(Application);
            frm_ProdControl.OnViewOrderInvoiceEvent := Self.HandleOnViewOrderInvoiceEvent;
            frm_ProdControl.OnPrintOrderInvoiceEvent := Self.HandleOnPrintOrderInvoiceEvent;
            frm_ProdControl.OnLoadOrderEvent := HandleOnLoadOrderEvent;
            frm_ProdControl.OnBackOrderDeliveredEvent := HandleBackOrderDeliveredEvent;
            frm_ProdControl.OnBackOrderNotAvailableEvent := HandleBackOrderNotAvailableEvent;
            frm_ProdControl.StartForm();
            ControlFormObject := frm_ProdControl;
         end;
         FORM_ORDERS:
         begin
         	frm_OrderControl := tControlForm_Order.Create(Application);
            frm_OrderControl.OnOrderRefreshEvent := Self.HandleOrderRefreshEvent;
            frm_OrderControl.OnEmailEvent := Self.HandleEmailEvent;
            frm_OrderControl.OnOrderListEditCustomerEvent := Self.HandleEOnOrderListEditCustomerEvent;
            frm_OrderControl.OnEmailCycle := Self.HandleOnEmailCycle;
            frm_OrderControl.StartForm();
            AssignOrderControlEvents();
            ControlFormObject := frm_OrderControl;
         end;
         FORM_CYCLES:
         begin
         	frm_CycleControl := TControlForm_Cycle.Create(Application);
            frm_CycleControl.StartForm();
            frm_CycleControl.OnLoadOrderEvent := HandleOnLoadOrderEvent;
            frm_CycleControl.OnViewOrderInvoice := Self.HandleOnViewOrderInvoiceEvent;
            frm_CycleControl.OnCycleRefreshEvent := Self.HandleCycleRefreshEvent;
            ControlFormObject := frm_CycleControl;
         end;
      end;

      // Dock it to the object passed to us
      ControlFormObject.ManualDock(inDockObj, nil, alClient);
      ControlFormObject.BorderStyle := bsNone;
      ControlFormObject.Left := (inDockObj.Width - inDockObj.Width) div 2;
      ControlFormObject.Top := (inDockObj.Height - inDockObj.Height) div 2;
      ControlFormObject.WindowState := wsMaximized;
      ControlFormObject.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
      ControlFormObject.BorderIcons := [];
      ControlFormObject.Position := poDefault;
      ControlFormObject.OnDestroy := HandleCloseForm;
      ControlFormObject.Tag := inFormType;
   end;

   // Now show it regardless
   if Assigned( ControlFormObject ) then
      ControlFormObject.Show();

   // extras?
   if (inFormType = FORM_ORDERS) then
   begin
      frm_OrderControl.OrderControlListState := true;
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.Show();
   end;
end;

procedure tFormControl.HandleCloseForm(Sender: TObject);
begin
   case tForm(Sender).Tag of
      FORM_WELCOME: frm_Welcome := Nil;
      FORM_CUSTOMERS: frm_CustControl := Nil;
      FORM_PRODUCTS : frm_ProdControl := Nil;
      FORM_ORDERS : frm_OrderControl := Nil;
      FORM_CYCLES : frm_CycleControl := Nil;
      FORM_BROCHURES : frm_BrochureControl := Nil;
      FORM_EXPENSES : frm_ExpenseControl := Nil;
      FORM_EarningS : frm_EarningControl := Nil;
      FORM_EMAIL: frm_EmailControl := Nil;
      FORM_ACCOUNTING: frm_AccountingControl := Nil;
      FORM_REPORT: frm_Report := Nil;
   end;
end;

procedure tFormControl.ShowReportForm;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Show();
end;

procedure tFormControl.ShutDown;
begin
   if (frm_Welcome <> NIL) then
      frm_Welcome.Close();
   if (frm_CustControl <> NIL) then
   	frm_CustControl.Close();
   if (frm_ProdControl <> NIL) then
   	frm_ProdControl.Close();
   if (frm_OrderControl <> NIL) then
   	frm_OrderControl.Close();
   if (frm_CycleControl <> NIL) then
   	frm_CycleControl.Close();
   if (frm_BrochureControl <> NIL) then
      frm_BrochureControl.Close();
   if (frm_ExpenseControl <> NIL) then
      frm_ExpenseControl.Close();
   if (frm_EarningControl <> NIL) then
      frm_EarningControl.Close();
   if (frm_AccountingControl <> NIL) then
      frm_AccountingControl.Close();
   if (frm_Report <> NIL) then
      frm_Report.Close();
   //
   FreeAndNil(frm_AccountingControl);
   FreeAndNil(frm_EarningControl);
   FreeAndNil(frm_ExpenseControl);
   FreeAndNil(frm_Welcome);
   FreeAndNil(frm_CustControl);
   FreeAndNil(frm_ProdControl);
   FreeAndNil(frm_OrderControl);
   FreeAndNil(frm_CycleControl);
   FreeAndNil(frm_BrochureControl);
   FreeAndNil(frm_Report);
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

procedure tFormControl.HandleBackOrderDeliveredEvent(InProdID,InBOProdID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.BackOrderDelivered( InProdID,InBOProdID );
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
   	frm_OrderControl.BackOrderDelivered( InProdID,InBOProdID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleBackOrderNotAvailableEvent(InProdID,InBOProdID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.BackOrderNotAvailable( InProdID,InBOProdID );
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
   	frm_OrderControl.BackOrderNotAvailable( InProdID,InBOProdID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleEmailUpdateEvent;
begin
   if ( frm_EmailControl <> NIL ) then
      frm_EmailControl.UpdateEmailEvent();
end;

procedure tFormControl.HandleEOnOrderListEditCustomerEvent( inCustID: string);
begin
   if ( frm_CustControl <> NIL ) then
      frm_CustControl.OrderListEditCustomer( inCustID );
end;

procedure tFormControl.AssignOrderControlEvents;
begin
   frm_OrderControl.OnInvoiceUpdated := HandleInvoiceUpdated;
end;

// This method says that a Order_ControlForm -> Order_EditForm -> orderInvoice was saved/updated/etc.
// So we have to tell any forms that we control to update grids and recalculate anything required.
procedure tFormControl.HandleInvoiceUpdated;
begin
   if (frm_OrderControl <> nil) AND (frm_OrderControl.frm_OrderList <> nil) then
   begin
      frm_OrderControl.frm_OrderList.Recalculate();
      frm_ProdControl.frm_ProductList.GlobalRefreshEvent();
   end;
end;

procedure tFormControl.HandleOnCancelUnCancelOrderEvent( CancelType: tCanceLtypes; InorderID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.HandleOnCancelUnCancelEventprocedure( CancelType, inOrderID);
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
         frm_OrderControl.HandleOnCancelUnCancelEventprocedure( CancelType, inOrderID);
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleOnEmailCycle(inCycleID: string);
begin
   if ( frm_EmailControl <> NIL ) then
      frm_EmailControl.EmailCycle( inCycleID );
end;

procedure tFormControl.HandleOnLoadOrderEvent(sender: tObject; inOrderID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.HandleOnLoadOrderEvent( nil, inOrderId );
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
			frm_OrderControl.HandleOnLoadOrderEvent( nil, inOrderId );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleOnMethodOfPaymentCustomerEvent( inCustID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.HandleOnTakeMethodOfPaymentCustomerEvent( inCustID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
			frm_OrderControl.HandleOnTakeMethodOfPaymentCustomerEvent( inCustID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleOnNewOrderWithCustomerEvent( inCustId: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.Order_New( inCustId );
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
      	frm_OrderControl.Order_New( inCustId );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleOnNewReturn(inOrderID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.HandleOnReturnOrderEvent( inOrderID );
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
			frm_OrderControl.HandleOnReturnOrderEvent( inOrderID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleOnPrintOrderInvoiceEvent(sender: tObject; inOrderID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.HandleOnPrintOrderInvoiceEvent( sender, inOrderID );
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
      	frm_OrderControl.HandleOnPrintOrderInvoiceEvent( sender, inOrderID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleOnTakeMethodOFPayment(inOrderID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.HandleOnTakeMethodOfPaymentEvent( inOrderID );
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
      	frm_OrderControl.HandleOnTakeMethodOfPaymentEvent( inOrderID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleOnViewOrderInvoiceEvent(sender: tObject; inOrderID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.Show();
   	frm_OrderControl.HandleOnViewOrderInvoiceEvent( sender, inOrderID );
      if Assigned(fOnRibbonChangeEvent) then
      	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
      	frm_OrderControl.HandleOnViewOrderInvoiceEvent( sender, inOrderID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.HandleWelcomeEvent(Sender: tObject; actionID : integer);
begin
   case actionID of
      CMD_MAIN_HELP : formControl.MainHelp();
      CMD_MAIN_FORUMS : formControl.Forums();
      CMD_MAIN_CONTACTUS : formControl.ContactUs();
      CMD_MAIN_SETTINGS : formControl.CreatePreferences( tPrefAreaTypes.GeneralSettings );
      CMD_MAIN_CHECKUPDATES : formControl.CheckUpdates();
      CMD_MAIN_DONATE: formControl.RegisterAvoBase();
      CMD_WELCOME_FB: formControl.FaceBook();
   end;
end;

procedure tFormControl.HandleOrderRefreshEvent;
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   if ( frm_Welcome <> Nil ) then
      frm_Welcome.GlobalRefreshEvent();

   if ( frm_CycleControl <> Nil ) then
      frm_CycleControl.GlobalRefreshEvent();

   if ( frm_EmailControl <> Nil ) then
      frm_EmailControl.GlobalRefreshEvent();

   if ( frm_AccountingControl <> Nil ) then
      frm_AccountingControl.GlobalRefreshEvent();

   if ( frm_CustControl <> NIL ) then
      frm_CustControl.GlobalRefreshEvent();

   PercentForm_Free();
end;

procedure tFormControl.HandlePreferenceRefreshEvent;
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   if ( frm_Welcome <> Nil ) then
      frm_Welcome.GlobalRefreshEvent();

   if ( frm_ProdControl <> Nil ) then
      frm_ProdControl.GlobalRefreshEvent();

   if ( frm_OrderControl <> Nil ) then
      frm_OrderControl.GlobalRefreshEvent();

   if ( frm_CycleControl <> Nil ) then
      frm_CycleControl.GlobalRefreshEvent();

   if ( frm_ExpenseControl <> Nil ) then
      frm_ExpenseControl.GlobalRefreshEvent();

   if ( frm_EarningControl <> Nil ) then
      frm_EarningControl.GlobalRefreshEvent();

   if ( frm_EmailControl <> Nil ) then
      frm_EmailControl.GlobalRefreshEvent();

   if ( frm_AccountingControl <> Nil ) then
      frm_AccountingControl.GlobalRefreshEvent();
   PercentForm_Free();
end;

procedure tFormControl.HandleProductRefreshEvent;
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   // Stubbed for future use.
   PercentForm_Free();
end;

procedure tFormControl.HandleCustomerRefreshEvent;
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   if ( frm_OrderControl <> Nil ) then
      frm_OrderControl.GlobalRefreshEvent();
   if ( frm_EmailControl <> Nil ) then
      frm_EmailControl.GlobalRefreshEvent();
   if ( frm_AccountingControl <> Nil ) then
      frm_AccountingControl.GlobalRefreshEvent();
   PercentForm_Free();
end;

procedure tFormControl.HandleCycleRefreshEvent;
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   if ( frm_Welcome <> Nil ) then
      frm_Welcome.GlobalRefreshEvent();

   if ( frm_ProdControl <> Nil ) then
      frm_ProdControl.GlobalRefreshEvent();

   if ( frm_OrderControl <> Nil ) then
      frm_OrderControl.GlobalRefreshEvent();

   if ( frm_ExpenseControl <> Nil ) then
      frm_ExpenseControl.GlobalRefreshEvent();

   if ( frm_EarningControl <> Nil ) then
      frm_EarningControl.GlobalRefreshEvent();

   if ( frm_EmailControl <> Nil ) then
      frm_EmailControl.GlobalRefreshEvent();

   if ( frm_AccountingControl <> Nil ) then
      frm_AccountingControl.GlobalRefreshEvent();
   PercentForm_Free();
end;

procedure tFormControl.HandleEarningRefreshEvent;
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   // Stubbed for future use.
   PercentForm_Free();
end;

procedure tFormControl.HandleEmailEvent(inOrderID: string);
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailQueueOrder( inOrderID )
   else
      begin
         CreateItem(FORM_EMAIL, 0, fDockObj );
         frm_EmailControl.Show();
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupEmail );
         frm_EmailControl.EmailQueueOrder( inOrderID )
      end;
   PercentForm_Free();
end;

procedure tFormControl.HandleEmailRefreshEvent;
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   // Stubbed for future use.
   PercentForm_Free();
end;

procedure tFormControl.HandleExpenseRefreshEvent;
begin
   PercentForm_Create('Refreshing AvoBase - One Moment Please...', 0, 0);
   // Stubbed for future use.
   PercentForm_Free();
end;

procedure tFormControl.HandleOnViewPrintCustomerEvent(inCustID: string);
begin
	if (frm_Report <> nil) then
   begin
      if Assigned(fOnRibbonChangeEvent) then
         fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupReport );
      frm_Report.Show();
      frm_Report.Report_PrintSingleCustomer( inCustID );
   end else
   	begin
         CreateItem(FORM_REPORT, 0, fDockObj );
         frm_Report.Show();
         frm_Report.Report_PrintSingleCustomer( inCustID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupReport );
      end;
end;

procedure tFormControl.HandleVoidMethodOfPaymentCustomerEvent( inCustID: string);
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.HandleVoidPaymentByCustomerID( inCustID );
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
         frm_OrderControl.HandleVoidPaymentByCustomerID( inCustID );
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Main Form Items'}

procedure tFormControl.RegisterAvoBase;
{ OLD:
begin
   Preference_RegistrationPage();
   if ( frm_Welcome <> NIL ) then
      frm_Welcome.RefreshAllData();
end;
}
   function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
   begin
     Result := ShellExecute(Application.MainForm.Handle, nil, PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
   end;
begin
   if AvoBaseDialog('Donate To AvoBase!',
      'This will open your favorite browswer and take you to the AvoBase Donation Page.\n\n' +
      'Donations help make AvoBase better!\n\n' +
      'Visit the AvoBase Donation Page?', mtConfirmation, [mbyes, mbno], 0 ) = mbyes then
   begin
      ExecuteFile(AVOBASE_DONATE, '', '', 0);
   end;
end;

procedure tFormControl.CreatePreferencesStartup;
var
	PreferencesForm : tPreferencesForm;
begin
	// the preferences are done here
	PreferencesForm := tPreferencesForm.Create(Application);
   try
      PreferencesForm.ExecuteStartupHelp();
   	PreferencesForm.ShowModal();
      HandlePreferenceRefreshEvent();
   finally
   	FreeAndNil(PreferencesForm);
   end;
end;

procedure tFormControl.CreatePreferences( inPrefArea : tPrefAreaTypes );
var
	PreferencesForm : tPreferencesForm;
   canLoad : boolean;
begin
   canLoad := true;
   if ( frm_OrderControl <> nil ) then
      if ( frm_OrderControl.OrderOrReturnOpen ) then
         canLoad := false;
	// the preferences are done here
   if ( canLoad ) then
   begin
      PreferencesForm := tPreferencesForm.Create(Application);
      try
         PreferencesForm.SetPreferenceArea( inPrefArea );
         PreferencesForm.ShowModal();
         HandlePreferenceRefreshEvent();
      finally
         FreeAndNil(PreferencesForm);
      end;
   end else
      AvoBaseDialog('Settings Temporarily Disabled',
         'The Settings/Preferences area is temporarily disabled while you have an open Order or ' +
         'Return.\n\nPlease save and close any open Order or Return first.', mtWarning, [mbOk], 0);
end;

procedure tFormControl.CheckUpdates;
begin
   if Assigned(fOnCheckForUpdatesEvent) then
      fOnCheckForUpdatesEvent( Self );
end;

procedure tFormControl.ContactUs;
begin
   if AvoBaseDialog('Contact AvoBase Support',
      'This will open up your favorite email program and allow you to send an email to Support@AvoBase.com.\n\n' +
      'Let us know if you need any help, registration changes or how we can make AvoBase better!\n\n' +
      'Confirm you want to send us an Email?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
// TODO: this has to get moved out of here. IT is an email function.
   ShellExecute(0,
      nil,
      'mailto:' +
      'support@avobase.com' +
      '?Subject=AvoBase Support' +
      '&Body=Sent via AvoBase ' + VER_NUM,
// (ifattachment)      '&Attach=&quot;c:\Mail Attachments\attachment.txt&quot;',
      nil,
      nil,
      SW_NORMAL);
end;

procedure tFormControl.FaceBook;
   function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
   begin
     Result := ShellExecute(Application.MainForm.Handle, nil, PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
   end;
begin
   if AvoBaseDialog('AvoBase On Facebook',
      'This will open your favorite browswer and take you to Facebook.\n\n' +
      'Join the AvoBase Facebook Group and share your AvoBase experiences - and keep up to date ' +
      'with AvoBase updates!\n\n' +
      'Visit the Facebook?', mtConfirmation, [mbyes, mbno], 0 ) = mbyes then
   begin
      ExecuteFile(AVOBASE_FACEBOOK, '', '', 0);
   end;
end;

procedure tFormControl.Forums;
   function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
   begin
     Result := ShellExecute(Application.MainForm.Handle, nil, PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
   end;
begin
   if AvoBaseDialog('AvoBase Forums',
      'This will open your favorite browswer and take you to the AvoBase Support Forums.\n\n' +
      'Register and participate on the AvoBase public forums. Read frequently asked questions and ' +
      'share your AvoBase experiences.\n\n' +
      'Visit the AvoBase Forums?', mtConfirmation, [mbyes, mbno], 0 ) = mbyes then
   begin
      ExecuteFile(AVOBASE_FORUMS, '', '', 0);
   end;
end;

procedure tFormControl.HomeButton;
begin
   if ( frm_Welcome <> NIL ) then
      frm_Welcome.HomeButton();
end;

procedure tFormControl.ImportCustomer;
begin
	if ( frm_CustControl <> NIL ) then
   	frm_CustControl.ImportCustomer();
end;

procedure tFormControl.BlogButton;
begin
   if ( frm_Welcome <> NIL ) then
      frm_Welcome.BlogButton();
end;

procedure tFormControl.MainHelp;
begin
   AvoBaseHelp_Execute('MainHelp');
end;

procedure tFormControl.ViewUpdates;
var
   AvoBase_UpdateViewer: TAvoBase_UpdateViewer;
begin
   AvoBase_UpdateViewer := TAvoBase_UpdateViewer.Create( Application );
   AvoBase_UpdateViewer.ShowModal();
   FreeAndNil( AvoBase_UpdateViewer );
end;

procedure tFormControl.Browse;
begin
{	hold off on this until we get it fixed.
   frm_Welcome.Browser.Navigate('http://www.avobase.com/blog/index.html');
}
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Customers'}

procedure tFormControl.CustomerActivateDeactivate;
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerActivateDeactivate();
end;

procedure tFormControl.CustomerEdit;
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerEditCustomer();
end;

procedure tFormControl.CustomerNew;
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerNewCustomer();
end;

procedure tFormControl.CustomerView;
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerView();
end;

procedure tFormControl.CustomerViewAccount;
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerViewAccount();
end;

procedure tFormControl.CustomerEmail();
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerEmail();
end;

procedure tFormControl.CustomerPrint();
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerPrint();
end;

procedure tFormControl.CustomerHelp();
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerHelp();
end;

procedure tFormControl.CustomerReport();
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerReport();
end;

procedure tFormControl.CustomerNewOrder();
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerNewOrder();
end;

procedure tFormControl.CustomerNewREturn();
begin
{
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerNewREturn();
}
end;

procedure tFormControl.CustomerNotes;
begin
   if ( frm_CustControl <> Nil ) then
      ( frm_CustControl.CustomerNotes() );
end;

procedure tFormControl.CustomerPayment();
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerPayment();
end;

procedure tFormControl.CustomerNSF();
begin
{
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerNSF();
}
end;

procedure tFormControl.CustomerOrderProd;
begin
   if (frm_CustControl <> NIL) then
      frm_CustControl.CustomerOrderProd();
end;

procedure tFormControl.CustomerVoidPayment();
begin
	if (frm_CustControl <> nil) then
   	if (frm_CustControl.frm_CustomerList <> nil) then
      	frm_CustControl.frm_CustomerList.CustomerVoidPayment();
end;

procedure tFormControl.ExportCustomer;
begin
	if ( frm_CustControl <> NIL ) then
   	frm_CustControl.ExportCustomer();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Orders'}

function tFormControl.Order_EnableDisableButtons: Boolean;
begin
   result := true;
   if ( frm_OrderControl <> NIL ) then
      result := frm_OrderControl.Order_EnableDisableButtons;
end;

procedure tFormControl.OrderHelp();
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderHelp();
end;

procedure tFormControl.OrderBackOrderManager;
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.OrderBackOrderManager();
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
         frm_OrderControl.OrderBackOrderManager();
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.OrderCancel;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderCancel();
end;

procedure tFormControl.OrderChangeCycle;
begin
   if (frm_OrderControl <> nil) then
      frm_OrderControl.OrderChangeCycle();
end;

procedure tFormControl.OrderUnCancel;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderUnCancel();
end;

function tFormControl.OrderControlListState: boolean;
begin
   result := true;
   if (frm_OrderControl <> nil) then
      result := frm_OrderControl.OrderControlListState;
end;

procedure tFormControl.OrderCustomerProduct;
begin
   if ( frm_OrderControl <> NIL ) then
      frm_OrderControl.OrderCustomerProduct();
end;

procedure tFormControl.OrderEmailInvoice;
var
   orderID : string;
begin
   if ( frm_OrderControl = nil ) then
      CreateItem(FORM_ORDERS, 0, fDockObj );
   if ( frm_EmailControl = nil ) then
      CreateItem(FORM_EMAIL, 0, fDockObj);
   //
   //frm_EmailControl.Show();
   orderID := frm_OrderControl.OrderListID;
   if ( orderID <> '' ) then
   begin
      if ( frm_OrderControl.OrderEditState( frm_OrderControl.frm_OrderList.ID )) then
      begin
         AvoBaseDialog('Order Email', 'Order #' + Order_GetOrderNumberByOrderID(orderID) + ' is currently being edited. \n\n' +
            'You cannot email an Order while the Order is in an editing state.\n\n' +
            'Save and close the Order first.', mtconfirmation, [mbOK], 0);
      end else
         begin
            frm_EmailControl.EmailQueueOrder( orderID );
            //
            {
            if Assigned(fOnRibbonChangeEvent) then
               fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupEmail );
            }
            //
            HandleOrderRefreshEvent();
         end;
   end;
end;

procedure tFormControl.OrderFinalize;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderFinalize();
end;

procedure tFormControl.OrderList;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.ShowOrderList();
end;

procedure tFormControl.OrderLoad;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderLoad();
end;

procedure tFormControl.OrderLoadNum;
begin
   if (frm_OrderControl <> nil) then
      frm_OrderControl.OrderLoadNum;
end;

procedure tFormControl.OrderNew;
begin
   if (frm_OrderControl <> nil) then
      frm_OrderControl.Order_New();
end;

procedure tFormControl.OrderNSF;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderNSF();
end;

procedure tFormControl.OrderPayment;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderPayment();
end;

procedure tFormControl.OrderPrintInvoice;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderPrintInvoice();
end;

procedure tFormControl.OrderReport;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderReport();
end;

procedure tFormControl.OrderReturn;
begin
   if (frm_OrderControl <> nil) then
      frm_OrderControl.Return_New();
end;

procedure tFormControl.OrderReturnManager;
begin
	if (frm_OrderControl <> nil) then
   begin
      frm_OrderControl.OrderReturnManager();
   end else
   	begin
         CreateItem(FORM_ORDERS, 0, fDockObj );
         frm_OrderControl.Show();
         frm_OrderControl.OrderReturnManager();
         if Assigned(fOnRibbonChangeEvent) then
         	fOnRibbonChangeEvent( Self,  tRibbonGroups.RibbonGroupOrder );
      end;
end;

procedure tFormControl.OrderSaveInvoice;
begin
   if (frm_OrderControl <> nil) then
      frm_OrderControl.OrderSaveInvoice();
end;

procedure tFormControl.OrderViewInvoice;
begin
   if (frm_OrderControl <> nil) then
   begin
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderViewInvoice();
   end;
end;

procedure tFormControl.OrderVoidPayment;
begin
   if (frm_OrderControl <> nil) then
      if (frm_OrderControl.frm_OrderList <> nil) then
         frm_OrderControl.frm_OrderList.OrderVoidPayment();
end;

procedure tFormControl.PrintAllCycleInvoices;
begin
	if (frm_OrderControl <> nil) then
      frm_OrderControl.PrintAllCycleInvoices();
end;

procedure tFormControl.EmailAllCycleInvoices;
begin
	if (frm_OrderControl <> nil) then
      frm_OrderControl.EmailAllCycleInvoices();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Products'}

procedure tFormControl.ProductNew();
begin
   if (frm_ProdControl <> nil) then
      if (frm_ProdControl.frm_ProductList <> nil) then
         frm_ProdControl.frm_ProductList.ProductNew();
end;

procedure tFormControl.ProductEdit();
begin
   if (frm_ProdControl <> nil) then
      if (frm_ProdControl.frm_ProductList <> nil) then
         frm_ProdControl.frm_ProductList.ProductEdit();
end;

procedure tFormControl.ProductHelp();
begin
   if (frm_ProdControl <> nil) then
      if (frm_ProdControl.frm_ProductList <> nil) then
         frm_ProdControl.frm_ProductList.ProductHelp();
end;

procedure tFormControl.ProductReports();
begin
   if (frm_ProdControl <> nil) then
      if (frm_ProdControl.frm_ProductList <> nil) then
         frm_ProdControl.frm_ProductList.ProductReports();
end;

procedure tFormControl.ProductPrint();
begin
   if (frm_ProdControl <> nil) then
      frm_ProdControl.ProductPrint();
end;

procedure tFormControl.ProductDelete();
begin
   if (frm_ProdControl <> nil) then
      if (frm_ProdControl.frm_ProductList <> nil) then
         frm_ProdControl.frm_ProductList.ProductDelete();
end;

procedure tFormControl.ProductView();
begin
   if (frm_ProdControl <> nil) then
      if (frm_ProdControl.frm_ProductList <> nil) then
         frm_ProdControl.frm_ProductList.ProductView();
end;

function tFormControl.Product_EnableDisableButtons: Boolean;
begin
   result := true;
   if ( frm_ProdControl <> NIL ) then
      result := frm_ProdControl.Product_EnableDisableButtons;

end;

procedure tFormControl.BackOrderManager;
begin
   if (frm_ProdControl <> nil) then
      frm_ProdControl.BackOrderManager();
end;

procedure tFormControl.ProductImport;
begin
   if (frm_ProdControl <> nil) then
      frm_ProdControl.ProductImport();
end;

procedure tFormControl.ProductExport;
begin
   if (frm_ProdControl <> nil) then
      frm_ProdControl.ProductExport();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Cycles'}

procedure tFormControl.CycleNew();
begin
   if (frm_CycleControl <> nil) then
      if (frm_CycleControl.frm_CycleList <> nil) then
         frm_CycleControl.frm_CycleList.CycleNew();
end;

procedure tFormControl.CycleEdit();
begin
   if (frm_CycleControl <> nil) then
      if (frm_CycleControl.frm_CycleList <> nil) then
         frm_CycleControl.frm_CycleList.CycleEdit();
end;

procedure tFormControl.CycleGenerate();
begin
   if (frm_CycleControl <> nil) then
      if (frm_CycleControl.frm_CycleList <> nil) then
         frm_CycleControl.frm_CycleList.CycleGenerate();
end;

procedure tFormControl.CycleHelp;
begin
   AvoBaseHelp_Execute('CycleHelp');
end;

procedure tFormControl.CycleReports();
begin
   if (frm_CycleControl <> nil) then
      if (frm_CycleControl.frm_CycleList <> nil) then
         frm_CycleControl.frm_CycleList.CycleReports();
end;

procedure tFormControl.CycleView();
begin
   if (frm_CycleControl <> nil) then
      if (frm_CycleControl.frm_CycleList <> nil) then
         frm_CycleControl.frm_CycleList.CycleView();
end;

procedure tFormControl.CycleViewOrders;
begin
   if (frm_CycleControl <> nil) then
      if (frm_CycleControl.frm_CycleList <> nil) then
         frm_CycleControl.frm_CycleList.CycleViewOrders();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
{$REGION 'Expenses'}

procedure tFormControl.ExpenseEdit;
begin
   if (frm_ExpenseControl <> nil) then
      frm_ExpenseControl.ExpenseEdit();
end;

procedure tFormControl.ExpenseHelp;
begin
   if (frm_ExpenseControl <> nil) then
      frm_ExpenseControl.ExpenseHelp();

end;

procedure tFormControl.ExpenseLoadByCycle;
begin
   if (frm_ExpenseControl <> nil) then
      frm_ExpenseControl.ExpenseLoadByCycle();
end;

procedure tFormControl.ExpenseNew;
begin
   if (frm_ExpenseControl <> nil) then
      frm_ExpenseControl.ExpenseNew();

end;

procedure tFormControl.ExpensePrint;
begin
   if (frm_ExpenseControl <> nil) then
      frm_ExpenseControl.ExpensePrint();

end;

procedure tFormControl.ExpenseReports;
begin
   if (frm_ExpenseControl <> nil) then
      frm_ExpenseControl.ExpenseReports();

end;

procedure tFormControl.ExpenseView;
begin
   if (frm_ExpenseControl <> nil) then
      frm_ExpenseControl.ExpenseView();

end;

function tFormControl.Expense_EnableDisableButtons: boolean;
begin
   result := true;
   if ( frm_ExpenseControl <> NIL ) then
      result := frm_ExpenseControl.Expense_EnableDisableButtons;

end;

procedure tFormControl.ExpenseQuickAdd;
begin
   if ( frm_ExpenseControl <> NIL ) then
      frm_ExpenseControl.ExpenseQuickAdd();
end;

procedure tFormControl.EditExpenseTypes;
begin
   if ( frm_ExpenseControl <> Nil ) then
      frm_ExpenseControl.EditExpenseTypes();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Earnings'}

procedure tFormControl.EarningEdit;
begin
   if (frm_EarningControl <> nil) then
      frm_EarningControl.EarningEdit();
end;

procedure tFormControl.EarningHelp;
begin
   if (frm_EarningControl <> nil) then
      frm_EarningControl.EarningHelp();

end;

procedure tFormControl.EarningLoadByCycle;
begin
   if (frm_EarningControl <> nil) then
      frm_EarningControl.EarningLoadByCycle();
end;

procedure tFormControl.EarningNew;
begin
   if (frm_EarningControl <> nil) then
      frm_EarningControl.EarningNew();

end;

procedure tFormControl.EarningPrint;
begin
   if (frm_EarningControl <> nil) then
      frm_EarningControl.EarningPrint();

end;

procedure tFormControl.EarningQuickAdd;
begin
   if ( frm_EarningControl <> NIL ) then
      frm_EarningControl.EarningQuickAdd();
end;

procedure tFormControl.EarningReports;
begin
   if (frm_EarningControl <> nil) then
      frm_EarningControl.EarningReports();

end;

procedure tFormControl.EarningView;
begin
   if (frm_EarningControl <> nil) then
      frm_EarningControl.EarningView();

end;

function tFormControl.Earning_EnableDisableButtons: boolean;
begin
   result := true;
   if ( frm_EarningControl <> NIL ) then
      result := frm_EarningControl.Earning_EnableDisableButtons;
end;

procedure tFormControl.EditEarningTypes;
begin
   if ( frm_EarningControl <> Nil ) then
      frm_EarningControl.EditEarningTypes();

end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Email'}

procedure tFormControl.EmailClean;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailClean();
end;

procedure tFormControl.EmailDelete;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailDelete();

end;

procedure tFormControl.EmailDeleteAll;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailDeleteAll();

end;

procedure tFormControl.EmailHelp;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailHelp();
end;

procedure tFormControl.EmailRequeue;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailRequeue();

end;

procedure tFormControl.EmailRequeueAll;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailRequeueAll();
end;

procedure tFormControl.EmailSend;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailSend();

end;

procedure tFormControl.EmailSendAll;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailSendAll();

end;

procedure tFormControl.EmailSetting;
begin
   if (frm_EmailControl <> nil) then
      frm_EmailControl.EmailSetting();

end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Brochures'}

procedure tFormControl.BrochureList();
begin
   if (frm_BrochureControl <> nil) then
      if (frm_BrochureControl.frm_BrochureList <> nil) then
         frm_BrochureControl.frm_BrochureList.BrochureList();
end;

procedure tFormControl.BrochureNew();
begin
   if (frm_BrochureControl <> nil) then
      if (frm_BrochureControl.frm_BrochureList <> nil) then
         frm_BrochureControl.frm_BrochureList.BrochureNew();
end;

procedure tFormControl.BrochureEdit();
begin
   if (frm_BrochureControl <> nil) then
      if (frm_BrochureControl.frm_BrochureList <> nil) then
         frm_BrochureControl.frm_BrochureList.BrochureEdit();
end;

procedure tFormControl.BrochureDelete();
begin
   if (frm_BrochureControl <> nil) then
      if (frm_BrochureControl.frm_BrochureList <> nil) then
         frm_BrochureControl.frm_BrochureList.BrochureDelete();
end;

procedure tFormControl.BrochureView();
begin
   if (frm_BrochureControl <> nil) then
      if (frm_BrochureControl.frm_BrochureList <> nil) then
         frm_BrochureControl.frm_BrochureList.BrochureView();
end;

procedure tFormControl.BrochureReports;
begin
   if (frm_BrochureControl <> nil) then
      if (frm_BrochureControl.frm_BrochureList <> nil) then
         frm_BrochureControl.frm_BrochureList.BrochureReports();
end;

procedure tFormControl.BrochureHelp();
begin
   if (frm_BrochureControl <> nil) then
      if (frm_BrochureControl.frm_BrochureList <> nil) then
         frm_BrochureControl.frm_BrochureList.BrochureHelp();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Reports'}

procedure tFormControl.Report_AccountingDepositSlipByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingDepositSlipByCycle();
end;

procedure tFormControl.Report_AccountingFeesCollectedByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingFeesCollectedByCycle();
end;

procedure tFormControl.Report_AccountingFeesReturned;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingFeesReturned();
end;

procedure tFormControl.Report_AccountingReturnsByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingReturnsByCycle();

end;

procedure tFormControl.Report_AccountingShippingCollectedByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingShippingCollectedByCycle();

end;

procedure tFormControl.Report_AccountingShippingReturned;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingShippingReturned();
end;

procedure tFormControl.Report_AccountingTaxExemptByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingTaxExemptByCycle();

end;

procedure tFormControl.Report_AccountingTransactionLogByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingTransactionLogByCycle();

end;

procedure tFormControl.Report_AccountingVoidNSFByCycle;
begin

   if ( frm_Report <> NIL ) then
      frm_Report.Report_AccountingVoidNSFByCycle();
end;

procedure tFormControl.Report_Accounting_CycleBreakDown;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_Accounting_CycleBreakDown;
end;

procedure tFormControl.Report_CustomerEscrow;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_CustomerEscrow();
end;

procedure tFormControl.Report_CustomerLabels;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_CustomerLabels();

end;

procedure tFormControl.Report_CustomerOrderHistory;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_CustomerOrderHistory();

end;

procedure tFormControl.Report_CustomerOrderTransactionHistory;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_CustomerOrderTransactionHistory();

end;

procedure tFormControl.Report_CustomerOutstandingBalance;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_CustomerOutstandingBalance();
end;

procedure tFormControl.Report_Customer_CustomerList;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_Customer_CustomerList();
end;

procedure tFormControl.Report_Customer_CustomerTopCustByMoney;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_Customer_CustomerTopCustByMoney();
end;

procedure tFormControl.Report_Customer_CustomerTopCustByOrd;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_Customer_CustomerTopCustByOrd();
end;

procedure tFormControl.Report_CycleListByOrg;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_CycleListByOrg();

end;

procedure tFormControl.Report_EarningByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_EarningByCycle();

end;

procedure tFormControl.Report_EarningListByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_EarningListByCycle();

end;

procedure tFormControl.Report_EarningTypes;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_EarningTypes();

end;

procedure tFormControl.Report_EarningVsExpenseByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_EarningVsExpenseByCycle();

end;

procedure tFormControl.Report_ExpenseByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_ExpenseByCycle();

end;

procedure tFormControl.Report_ExpenseListByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_ExpenseListByCycle();

end;

procedure tFormControl.Report_ExpenseType;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_ExpenseType();

end;

procedure tFormControl.Report_OrderBackOrderList;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_OrderBackOrderList();

end;

procedure tFormControl.Report_OrderLabels;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_OrderLabels();

end;

procedure tFormControl.Report_OrderProductList;
begin
   if ( frm_Report <> NIL ) then
      frm_report.Report_OrderProductList();
end;

procedure tFormControl.Report_Order_OrderList;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_Order_OrderList();
end;

procedure tFormControl.Report_ProductList;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_ProductList();

end;

procedure tFormControl.Report_ProductQuantityOnHand;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_ProductQuantityOnHand();

end;

procedure tFormControl.Report_ProductReturnList;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_ProductReturnList();
end;

procedure tFormControl.Report_TaxesCollectedByCycle;
begin
   if ( frm_Report <> NIL ) then
      frm_Report.Report_TaxesCollectedByCycle();

end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Accounting'}

procedure tFormControl.AccountingEscrow;
begin
   if ( frm_AccountingControl <> NIL ) then
      frm_AccountingControl.AccountingEscrow();
end;

procedure tFormControl.AccountingHelp;
begin
   AvoBaseHelp_Execute('AccountingHelp');
end;

procedure tFormControl.AccountingTransactions;
begin
   showmessage('Accounting Transactions');
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



end.



