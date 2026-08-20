 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MAIN_FORM_UNIT;

INTERFACE USES
  // essential to avobase
  constantsunit,
  toolboxunit,
  masterdataunit,
  img_storageformunit,
  inifileunit,
  avobase_dialogformunit,
  avobase_eulaformunit,
  welcomeformunit,
  avobase_groupboxunit,
  avobase_bitbuttonunit,
  AvoBase_BaseForm_MenuUnit,
  avobase_baseform_standardunit,
  AvoBase_HelpFormUnit,
  actionunit,
  mainform_formcontrolunit,
  avobase_percentformunit,
  toolbox_ExpenseToolBoxUnit,
  AvoBase_StartupFormUnit,
  AvoBase_UpdateObjectUnit,
  hintsunit,
  //
  // everything else
  //
  windows,
  messages,
  stdctrls,
  sysutils,
  variants,
  db,
  classes,
  graphics,
  controls,
  forms,
  dialogs,
  Menus,
  ComCtrls,
  ExtCtrls,
  ToolWin,
  ActnMan,
  ActnCtrls,
  ActnList,
  ActnMenus,
  themes,
  ActnPopup,
  ImgList,
  ExtActns,
  StdActns,
  Grids,
  DBGrids,
  DBTables,
  ButtonGroup,
  Ribbon,
  RibbonSilverStyleActnCtrls,
  RibbonActnMenus,
  jpeg,
  AvoBase_UpdateViewerFormUnit,
  RibbonActnCtrls,
  RibbonLunaStyleActnCtrls, RibbonObsidianStyleActnCtrls;

type
	tMainForm = class(tForm)
    BotSepPanel: TPanel;
    AvoActionList: TActionList;
    AvoActionManager: TActionManager;
    actCtrl_Main_Close: TControlAction;
    actCtrl_ExpenseList_Print: TControlAction;
    actCtrl_Order_List: TControlAction;
    actCtrl_Order_New: TControlAction;
    actCtrl_Order_Load: TControlAction;
    actCtrl_ReturnManager: TControlAction;
    actCtrl_Order_ViewInvoice: TControlAction;
    actCtrl_Order_PrintInvoice: TControlAction;
    actCtrl_Order_EmailInvoice: TControlAction;
    actCtrl_Order_EmailAllInvoicesInCycle: TControlAction;
    actCtrl_Order_Reports: TControlAction;
    actCtrl_Order_New_Return: TControlAction;
    actCtrl_Cust_List: TControlAction;
    actCtrl_Cust_New: TControlAction;
    actCtrl_Cust_Edit: TControlAction;
    actCtrl_Cust_Activity: TControlAction;
    actCtrl_Cust_Email: TControlAction;
    actCtrl_Cust_Print: TControlAction;
    actCtrl_Cust_Reports: TControlAction;
    actCtrl_Main_Help: TControlAction;
    actCtrl_Main_Forums: TControlAction;
    actCtrl_Main_Contactus: TControlAction;
    actCtrl_Main_Settings: TControlAction;
    actCtrl_Main_CheckUpdates: TControlAction;
    actCtrl_Main_Donate: TControlAction;
    actCtrl_Product_List: TControlAction;
    actCtrl_Product_New: TControlAction;
    actCtrl_Product_Edit: TControlAction;
    actCtrl_Product_Print: TControlAction;
    actCtrl_Product_Reports: TControlAction;
    actCtrl_Product_Delete: TControlAction;
    actCtrl_Cust_View: TControlAction;
    actCtrl_Order_Help: TControlAction;
    actCtrl_Cycle_View: TControlAction;
    actCtrl_Brochure_Help: TControlAction;
    act_Support_AvoBaseWebsite: TAction;
    act_Support_AvoBaseForums: TAction;
    act_Support_AvoBaseForums_General: TAction;
    act_Support_AvoBaseForums_FAQ: TAction;
    act_Support_AvoBaseForums_Tech: TAction;
    act_Order_TakePayment: TAction;
    act_Order_VoidPayment: TAction;
    AvoBaseRibbon: TRibbon;
    RibbonPage1: TRibbonPage;
    RibbonPage2: TRibbonPage;
    RibbonPage3: TRibbonPage;
    AvoApplicationMenuBar: TRibbonApplicationMenuBar;
    RibbonGroup3: TRibbonGroup;
    RibbonGroup6: TRibbonGroup;
    RibbonPage4: TRibbonPage;
    RibbonGroup14: TRibbonGroup;
    RibbonPage5: TRibbonPage;
    RibbonPage7: TRibbonPage;
    ribbonExpense: TRibbonPage;
    RibbonPage9: TRibbonPage;
    actCtrl_Cycle_List: TControlAction;
    actCtrl_Cycle_New: TControlAction;
    actCtrl_Cycle_Edit: TControlAction;
    actCtrl_Cycle_SetActive: TControlAction;
    actCtrl_Cycle_Generate: TControlAction;
    actCtrl_Cycle_Reports: TControlAction;
    actCtrl_Order_Payment: TControlAction;
    actCtrl_Order_NSF: TControlAction;
    actCtrl_Cust_Help: TControlAction;
    actCtrl_Order_VoidPayment: TControlAction;
    actCtrl_Product_Help: TControlAction;
    actCtrl_Product_View: TControlAction;
    RibbonGroup22: TRibbonGroup;
    actCtrl_Brochure_List: TControlAction;
    actCtrl_Brochure_New: TControlAction;
    actCtrl_Brochure_Edit: TControlAction;
    actCtrl_Brochure_Delete: TControlAction;
    actCtrl_Brochure_View: TControlAction;
    actCtrl_Brochure_Reports: TControlAction;
    actCtrl_Cust_NewOrder: TControlAction;
    actCtrl_Cust_NewReturn: TControlAction;
    actCtrl_Cust_Payment: TControlAction;
    actCtrl_Cust_NSF: TControlAction;
    acCtrl_Cust_VoidPayment: TControlAction;
    actCtrl_Cycle_ViewOrders: TControlAction;
    actCtrl_Order_Finalize: TControlAction;
    actCtrl_Order_LoadNum: TControlAction;
    actCtrl_Cust_ViewAccount: TControlAction;
    actCtrl_ExpenseList_New: TControlAction;
    actCtrl_ExpenseList_Edit: TControlAction;
    actCtrl_ExpenseList_View: TControlAction;
    act_Order_Cust_TakePayment: TAction;
    act_Order_Cust_Void_Payment: TAction;
    act_Order_Cancel: TAction;
    act_Order_UnCancel: TAction;
    RibbonPage8: TRibbonPage;
    actCtrl_Expense_Reports: TControlAction;
    actCtrl_ExpenseList_Help: TControlAction;
    actCtrl_ExpenseList_LoadByCycle: TControlAction;
    actCtrl_EarningList_New: TControlAction;
    actCtrl_EarningList_Edit: TControlAction;
    actCtrl_EarningList_View: TControlAction;
    actCtrl_EarningList_Print: TControlAction;
    actCtrl_EarningList_Help: TControlAction;
    actCtrl_Earning_Reports: TControlAction;
    actCtrl_EarningList_LoadByCycle: TControlAction;
    RibbonGroup2: TRibbonGroup;
    actCtrl_Cust_BackOrder: TControlAction;
    act_Ctrl_Order_BackOrder: TControlAction;
    actCtrl_Email_ReQueue: TControlAction;
    RibbonGroup4: TRibbonGroup;
    RibbonGroup5: TRibbonGroup;
    RibbonGroup7: TRibbonGroup;
    actCtrl_Email_Setting: TControlAction;
    actCtrl_Cycle_Help: TControlAction;
    actCtrl_Email_Send: TControlAction;
    actCtrl_Email_SendAll: TControlAction;
    actCtrl_Email_Delete: TControlAction;
    actCtrl_Email_DeleteAll: TControlAction;
    actCtrl_Email_Help: TControlAction;
    actCtrl_Email_Clean: TControlAction;
    act_Order_ViewInvoice: TAction;
    act_Order_PrintInvoice: TAction;
    act_Order_EmailInvoice: TAction;
    act_Order_ChangeOrderCampaign: TAction;
    act_Report_CustomerTopCustByMoney: TAction;
    act_Report_OrderList: TAction;
    act_Report_CustomerTopCustByOrder: TAction;
    act_Order_SaveInvoice: TControlAction;
    RibbonPage6: TRibbonPage;
    RibbonGroup9: TRibbonGroup;
    actCtrl_Main_Home: TControlAction;
    actCtrl_Main_Blog: TControlAction;
    RibbonGroup10: TRibbonGroup;
    RibbonGroup11: TRibbonGroup;
    actCtrl_Account_Escrow: TControlAction;
    actCtrl_Account_Transaction: TControlAction;
    actCtrl_Reports_Customer: TControlAction;
    RibbonGroup8: TRibbonGroup;
    act_Report_CustomerList: TAction;
    actCtrl_Reports_Order: TControlAction;
    actCtrl_Reports_Cycle: TControlAction;
    actCtrl_Report_Earning: TControlAction;
    actCtrl_Report_Expense: TControlAction;
    actCtrl_Reports_Org: TControlAction;
    actCtrl_Reports_Product: TControlAction;
    act_Report_Earning_Types: TAction;
    act_Report_Earning_EarningByCycle: TAction;
    act_Report_Earning_ListByCycle: TAction;
    act_Report_Expense_Type: TAction;
    act_Report_Expense_ByCycle: TAction;
    act_Report_Expense_ListByCycle: TAction;
    act_Report_EarningVsExpenseByCycle: TAction;
    act_Report_Order_Labels: TAction;
    act_Report_Product_QuantityOnHand: TAction;
    act_Report_Customer_OrderHistory: TAction;
    act_Report_Order_BackOrderList: TAction;
    act_Report_Accounting_FeesCollectedByCycle: TAction;
    act_Report_Accounting_ShippingCollectedByCycle: TAction;
    act_Report_Accounting_TaxesCollectedByCycle: TAction;
    act_Report_Accounting_TaxExemptByCycle: TAction;
    act_Report_Accounting_DepositSlipByCycle: TAction;
    act_Report_Accounting_VoidNSFByCycle: TAction;
    act_Report_Accounting_ReturnsByCycle: TAction;
    act_Report_Accounting_TransactionLogByCycle: TAction;
    actCtrl_Reports_Accounting: TControlAction;
    act_Report_Customer_OrderTransactionHistory: TAction;
    act_Report_Product_ProductList: TAction;
    act_Report_Cycle_CycleListByOrg: TAction;
    act_Report_Customer_Labels: TAction;
    act_Report_ORder_OrderProductList: TAction;
    act_Report_Order_ProductReturnList: TAction;
    act_Report_Accounting_ShippingReturned: TAction;
    act_Report_Accounting_FeesReturned: TAction;
    actCtrl_Accounting_Help: TControlAction;
    act_Order_PrintAllCycleInvoices: TAction;
    act_Order_EmailAllCycleInvoices: TAction;
    actCtrl_Earning_QuickAdd: TControlAction;
    actCtrl_Expense_QuickAdd: TControlAction;
    actCtrl_Cust_Notes: TControlAction;
    act_Report_Customer_OustandingBalance: TAction;
    actCtrl_Expense_EditTypes: TControlAction;
    actCtrl_Earning_EditTypes: TControlAction;
    act_Report_Accounting_CycleBreakDown: TAction;
    act_Order_EmailSingleInvoice: TAction;
    act_Order_EmailCycleInvoices: TAction;
    actCtrl_Cust_OrdProd: TControlAction;
    act_Order_CustProd: TControlAction;
    actViewUpdates: TControlAction;
    act_Report_CustomerEscrowBalance: TAction;
    actCtrl_Email_RequeueAll: TControlAction;
    actCtrl_Product_ImportExport: TControlAction;
    MAIN_DOCK_PANEL: TScrollBox;
    act_Settings_GeneralSettings: TAction;
    act_Settings_RepSettings: TAction;
    act_Settings_Email: TAction;
    act_Settings_Organizations: TAction;
    act_Settings_OrderFees: TAction;
    act_Settings_TaxRates: TAction;
    act_Settings_ShippingRates: TAction;
    act_Settings_EarningTypes: TAction;
    act_Settings_ExpenseTypes: TAction;
    act_Settings_InvoiceSettings: TAction;
    act_Settings_ProductSettings: TAction;
    actCtrl_Main_IconSettings: TControlAction;
    actCtrl_Customer_ImportExport: TControlAction;
    act_Import_Customer: TAction;
    act_Export_Customer: TAction;
    act_Product_Import: TAction;
    act_Product_Export: TAction;
    procedure RibbonActionExecuteLarge(Sender: TObject);
    procedure RibbonActionExecuteSmall(Sender: TObject);
    procedure ActionListExecute(Sender: TObject);
    procedure ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
    procedure AvoBaseRibbonTabChange(Sender: TObject; const NewIndex, OldIndex: Integer; var AllowChange: Boolean);
    procedure HandleOnRibbonChangeEvent( sender : tObject; inRibbon : tRibbonGroups );
    procedure AvoActionManagerUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure MAIN_DOCK_PANELClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    { essential to Avobase TAB operations }
    Procedure CMDialogKey(var Message: TCMDialogKey);message CM_DIALOGKEY;
   private
      fCheckUpdates : boolean;
   public
      // methods
      procedure StartForm;
      procedure StopForm;
      procedure CloseAvoBase;
      procedure InitalizeRibbonActions;
   	procedure ChangeRibbonIndex( inRibbon : tRibbonGroups );
      procedure CheckForUpdates();
      procedure CheckNewUpdateMessage();
      procedure CheckNewAvoBaseUpdater();
      //
      property UpdateRequested : boolean read fCheckUpdates;
   end;

var
  mainForm : tMainForm;

IMPLEMENTATION

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMainForm.StartForm;
begin
   fCheckUpdates := false;

	// names, copyrights, etc.
   Mainform.Caption := AVOBASE_NAME + ' ' + VER_NUM;
   StartPercentForm_Update();

   // set the form margines, top, left, height, width and then do some checking
   WindowSizePosition( mainForm, AVOBASE_NAME, APP_WIDTH, APP_HEIGHT );
   StartPercentForm_Update();

   //
   // create any associated forms { they are done in order!!! }
   //
   StartPercentForm_UpdateHeader('Initializing - Orders');
   formControl.CreateItem(FORM_ORDERS, 0, MAIN_DOCK_PANEL );
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Customers');
   formControl.CreateItem(FORM_CUSTOMERS, 0, MAIN_DOCK_PANEL );
//   inc( PcntCount ); StartPercentForm.Progress.Position := PcntCount;
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Products');
   formControl.CreateItem(FORM_PRODUCTS, 0, MAIN_DOCK_PANEL );
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Cycles');
   formControl.CreateItem(FORM_CYCLES, 0, MAIN_DOCK_PANEL );
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Expenses');
   formControl.CreateItem(FORM_EXPENSES, 0, MAIN_DOCK_PANEL);
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Earnings');
   formControl.CreateItem(FORM_EARNINGS, 0, MAIN_DOCK_PANEL);
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Email');
   formControl.CreateItem(FORM_EMAIL, 0, MAIN_DOCK_PANEL);
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Accounting');
   formControl.CreateItem(FORM_ACCOUNTING, 0, MAIN_DOCK_PANEL);
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Reporting');
   formControl.CreateItem(FORM_REPORT, 0, MAIN_DOCK_PANEL);
   StartPercentForm_Update();
   //
   StartPercentForm_UpdateHeader('Initializing - Welcome');
   formControl.CreateItem(FORM_WELCOME, 0, MAIN_DOCK_PANEL);
   StartPercentForm_Update();
   //
   AvoBaseRibbon.Caption := 'AvoBase ' + VER_NUM + ' ' + VER_COPY;
   AvoBaseRibbon.Font.Color := clWhite;


   StartPercentForm_Update();

   // Assign TAG items to action items
   InitalizeRibbonActions();
   StartPercentForm_Update();

   //
   formControl.Browse();
end;

procedure tMainForm.StopForm;
begin
	AvoINIWriteInteger(AVOBASE_NAME,'FormWidth',mainForm.Width);
   AvoINIWriteInteger(AVOBASE_NAME,'FormHeight',mainForm.Height);
   AvoINIWriteInteger(AVOBASE_NAME,'FormLeft',mainForm.Left);
   AvoINIWriteInteger(AVOBASE_NAME,'FormTop',mainForm.Top);
   if mainForm.WindowState = wsNormal then
   	AvoINIWriteString(AVOBASE_NAME,'FormSize','NORM')
   else
   	AvoINIWriteString(AVOBASE_NAME,'FormSize','MAX');
	// close any forms
   FreeAndNil(AvoBaseHelpForm);
   formControl.ShutDown();
end;
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

// This method is designed to help if there is a NEW AvoBaseUpdater.
procedure tMainForm.CheckNewAvoBaseUpdater;
begin
    if ( FileExists( ExtractFilePath(ParamStr(0)) + AVOBASE_UPDATER_NEW) ) then
    begin
      try
         // FIRST, DELETE THE OLD ONE
         DeleteFile( ExtractFilePath(ParamStr(0)) + AVOBASE_UPDATER );
         // NOW RENAME THE NEW ONE
         RenameFile( ExtractFilePath(ParamStr(0)) + AVOBASE_UPDATER_NEW, ExtractFilePath(ParamStr(0)) + AVOBASE_UPDATER );
      except
         // SHIT..
         AvoBaseDialog('Error In AvoBaseUpdater',
            'There was an error in attempting to install a new AvoBaseUpdater. This process ' +
            'deletes the old updater and renames the newly downloaded updater. This process ' +
            'failed. The original AvoBaseUpdater may no longer exist and thus you will not ' +
            'be able to update automatically.', mtError, [mbok], 0);
      end;
    end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMainForm.CheckNewUpdateMessage;
var
   AvoBase_UpdateViewer: TAvoBase_UpdateViewer;
begin
   if AvoINIReadString(AVOBASE_NAME, 'NewUpdate', 'False') = 'True' then
   begin
      if AvoBaseDialog('New Updates Installed','There have been new updates installed. Would you like to ' +
      'See a list of new updates?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
      begin
         AvoBase_UpdateViewer := TAvoBase_UpdateViewer.Create( Application );
         AvoBase_UpdateViewer.ShowModal();
         FreeAndNil( AvoBase_UpdateViewer );
      end;
   end;
   AvoINIWriteString(AVOBASE_NAME,'NewUpdate','False');
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMainForm.ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
var
	eleDetail : tThemedElementDetails;
begin
	if (ThemeServices.ThemesEnabled) then
   begin
   	eleDetail := ThemeServices.GetElementDetails(trRebarRoot);
      ThemeServices.DrawElement(Sender.Canvas.Handle, eleDetail, Sender.ClientRect);
      ThemeServices.DrawElement(Self.Canvas.Handle, eleDetail, Sender.ClientRect);
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMainForm.CloseAvoBase;
begin
  if AvoBaseDialog('Close AvoBase','Are you sure you want to exit AvoBase?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
    Close();
end;


procedure tMainForm.FormShow(Sender: TObject);
begin
   formControl.frm_Welcome.StartupForm();
   //
   if AvoINIReadString(AVOBASE_NAME, 'NewUser', 'False') = 'False' then
	begin
		AvoBaseDialog('Welcome To AvoBase!',
         'Welcome to AvoBase!\n\n'+
         'Before you get started, make sure you click on Settings and ' +
         'set up your Sales Organziation, Sales Rep Settings, Tax Group and Tax Rates - and Shipping (if needed).\n\n' +
         'Thank you for using AvoBase!', mtinformation, [mbok], 0);
		AvoINIWriteString(AVOBASE_NAME,'NewUser','True');
      //formControl.CreatePreferencesStartup();
	end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMainForm.HandleOnRibbonChangeEvent(sender: tObject; inRibbon: tRibbonGroups);
begin
   ChangeRibbonIndex( inRibbon );
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMainForm.ChangeRibbonIndex(inRibbon: tRibbonGroups);
begin
	AvoBaseRibbon.TabIndex := integer(inRibbon);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMainForm.CheckForUpdates;
var
   checkMainUpdates : tUpdateAvoBase;
   checkUpdateResult : tCheckUpdateTypes;
begin
   if AvoBaseDialog('Check for Updates', 'Connect to AvoBase.com and check for product updates?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
   begin
      try
         checkMainUpdates := tUpdateAvoBase.Create();
         checkUpdateResult := checkMainUpdates.CheckUpdates( checkUpdateNormal );
      finally
         FreeAndNil(checkMainUpdates);
      end;
      //
      if ( checkUpdateResult = checkUpdateFound ) then
      begin
         if AvoBaseDialog('AvoBase Version Update',
            'A new version of AvoBase is now available.\n\nUpdates can be turned off in Preferences' +
            ' ~ General Preferences.\n\nWould you like to download and install the new version?',
            mtInformation, [mbYes, mbNo], 0) = mbYes then
         begin
            fCheckUpdates := true;
            Close();
         end;
      end;
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMainForm.InitalizeRibbonActions;

   {-------------------------------------------------------------------------------------}
   procedure SetControlAction( inCtrlAction : tControlAction; inCmd : integer ); overload;
   begin
      inCtrlAction.Tag := inCmd;
      inCtrlAction.OnExecute := RibbonActionExecuteLarge;
   end;
   procedure SetControlAction( inCtrlAction : tAction; inCmd : integer ); overload;
   begin
      inCtrlAction.Tag := inCmd;
      inCtrlAction.OnExecute := RibbonActionExecuteSmall;
   end;
   {-------------------------------------------------------------------------------------}

begin
   // Ribbon MenuItems
   SetControlAction(act_Settings_GeneralSettings, CMD_PREF_GENERALSETTINGS);

   SetControlAction(act_Settings_RepSettings, CMD_PREF_REPSETTINGS );
   SetControlAction(act_Settings_Email, CMD_PREF_EMAILSETTINGS );
   SetControlAction(act_Settings_Organizations, CMD_PREF_ORGANIZATIONS );
   SetControlAction(act_Settings_OrderFees,  CMD_PREF_ORDERFEES );
   SetControlAction(act_Settings_TaxRates, CMD_PREF_TAXRATES );
   SetControlAction(act_Settings_ShippingRates, CMD_PREF_SHIPPINGRATES );
   SetControlAction(act_Settings_EarningTypes, CMD_PREF_EARNINGTYPES );
   SetControlAction(act_Settings_ExpenseTypes, CMD_PREF_EXPENSETYPES );
   SetControlAction(act_Settings_InvoiceSettings, CMD_PREF_INVOICESETTINGS );
   SetControlAction(act_Settings_ProductSettings, CMD_PREF_PRODUCTSETTINGS );

   // main
   SetControlAction(actCtrl_Main_Help, CMD_MAIN_HELP);
   SetControlAction(actCtrl_Main_Forums, CMD_MAIN_FORUMS);
   SetControlAction(actCtrl_Main_Contactus, CMD_MAIN_CONTACTUS);
   SetControlAction(actCtrl_Main_Settings, CMD_MAIN_SETTINGS);
   SetControlAction(actCtrl_Main_CheckUpdates, CMD_MAIN_CHECKUPDATES);
   SetControlAction(actCtrl_Main_Donate, CMD_MAIN_DONATE);
   SetControlAction(actCtrl_Main_Close, CMD_CLOSE);
   SetControlAction(actCtrl_Main_Home, CMD_HOME );
   SetControlAction(actCtrl_Main_Blog, CMD_BLOG );
   SetControlAction(actViewUpdates, CMD_VIEWUPDATES );

   // Customers
   SetControlAction(actCtrl_Cust_View, CMD_CUST_VIEW);
   SetControlAction(actCtrl_Cust_New, CMD_CUST_NEW);
   SetControlAction(actCtrl_Cust_Edit, CMD_CUST_EDIT);
   SetControlAction(actCtrl_Cust_Activity, CMD_CUSTACTIVEINACTIVE);
   SetControlAction(actCtrl_Cust_Email, CMD_CUST_EMAIL);
   SetControlAction(actCtrl_Cust_Print, CMD_CUST_PRINT);
   SetControlAction(actCtrl_Cust_Help, CMD_CUST_HELP);
   SetControlAction(actCtrl_Cust_Reports, CMD_CUST_REPORT_ONE);
   SetControlAction(actCtrl_Cust_NewOrder, CMD_CUST_NEWORDER);
   SetControlAction(actCtrl_Cust_NewReturn, CMD_CUST_NEWRETURN);
   SetControlAction(act_Order_Cust_TakePayment, CMD_CUST_PAYMENT);
   SetControlAction(act_Order_Cust_Void_Payment, CMD_CUST_VOIDPAYMENT);
   SetControlAction(actCtrl_Cust_ViewAccount, CMD_CUST_VIEWACCOUNT);
   SetControlAction(actCtrl_Cust_Payment, CMD_CUST_MAINFORM_TAKEPAYMENT );
   SetControlAction(actCtrl_Cust_Notes, CMD_CUSTNOTES );
   SetControlAction(actCtrl_Cust_OrdProd, CMD_CUST_ORDPROD);
   SetControlAction(act_Import_Customer, CMD_CUST_IMPORT);
   SetControlAction(act_Export_Customer, CMD_CUST_EXPORT);

   // Orders
   SetControlAction(actCtrl_Order_Help, CMD_ORDER_HELP );
   SetControlAction(actCtrl_Order_List, CMD_ORDER);
   SetControlAction(actCtrl_Order_List, CMD_ORDER_LIST);
   SetControlAction(actCtrl_Order_New, CMD_ORDER_NEW);
   SetControlAction(actCtrl_Order_New_Return, CMD_ORDER_RETURN);
   SetControlAction(actCtrl_Order_Load, CMD_ORDER_LOAD);
   SetControlAction(actCtrl_ReturnManager, CMD_ORDER_RETURN_MANAGER );
   SetControlAction(actCtrl_Order_ViewInvoice, CMD_ORDER_VIEWINVOICE);
   SetControlAction(actCtrl_Order_PrintInvoice, CMD_ORDER_PRINTINVOICE);
   SetControlAction(actCtrl_Order_EmailAllInvoicesInCycle, CMD_ORDER_EMAILALL);
   SetControlAction(actCtrl_Order_Reports, CMD_ORDER_REPORT);
   SetControlAction(actCtrl_Order_Finalize, CMD_ORDER_FINALIZE);
   SetControlAction(actCtrl_Order_LoadNum, CMD_ORDER_LOAD_NUM);
   SetControlAction(act_Order_TakePayment, CMD_ORDER_PAYMENT);
   SetControlAction(act_Order_VoidPayment, CMD_ORDER_VOIDPAYMENT);
   SetControlAction(act_Order_Cancel, CMD_ORDER_CANCEL);
   SetControlAction(act_Order_UnCancel, CMD_ORDER_UNCANCEL);
   SetControlAction(act_Ctrl_Order_BackOrder, CMD_ORDER_BACKORDER);
   SetControlAction(act_Order_ChangeOrderCampaign, CMD_ORDER_CHANGEORDERCYCLE);

   // DONT DO THIS ONE: ( I am not sure WHY I said not to do this one.... )
   SetControlAction(actCtrl_Order_Payment, CMD_ORDER_PAYMENT);

	SetControlAction(act_Order_SaveInvoice, CMD_ORDER_SAVE_INVOICE);
 	SetControlAction(act_Order_PrintAllCycleInvoices, CMD_PRINT_ALL_CYCLE_INVOICES);
	SetControlAction(act_Order_EmailAllCycleInvoices, CMD_EMAIL_ALL_CYCLE_INVOICES);
	SetControlAction(act_Order_PrintInvoice, CMD_ORDER_PRINTINVOICE);
   SetControlAction(actCtrl_Order_EmailInvoice, CMD_ORDER_EMAILINVOICE);
   SetControlAction(act_Order_EmailSingleInvoice, CMD_EMAIL_SINGLEINVOICE);
   SetControlAction(act_Order_EmailCycleInvoices, CMD_EMAIL_ALL_CYCLE_INVOICES);
   setControlAction(act_Order_CustProd, CMD_ORDER_CUSTPROD);

   // products
   SetControlAction(actCtrl_Product_List, CMD_PRODUCT_LIST);
   SetControlAction(actCtrl_Product_New, CMD_PRODUCT_NEW);
   SetControlAction(actCtrl_Product_Edit, CMD_PRODUCT_EDIT);
   SetControlAction(actCtrl_Product_Help, CMD_PRODUCT_HELP);
   SetControlAction(actCtrl_Product_Reports, CMD_PRODUCT_REPORTS);
   SetControlAction(actCtrl_Product_Print, CMD_PRODUCT_PRINT);
   SetControlAction(actCtrl_Product_Delete, CMD_PRODUCT_DELETE);
   SetControlAction(actCtrl_Product_View, CMD_PRODUCT_VIEW);
   SetControlAction(actCtrl_Cust_BackOrder, CMD_PRODUCT_VIEWBACKORDER);
   SetControlAction(act_Product_Import, CMD_PRODUCT_IMPORT);
   SetControlAction(act_Product_Export, CMD_PRODUCT_EXPORT);

   // Cycles
   SetControlAction(actCtrl_Cycle_Help, CMD_CYCLE_HELP );
   SetControlAction(actCtrl_Cycle_List, CMD_CYCLE_LIST);
   SetControlAction(actCtrl_Cycle_New, CMD_CYCLE_NEW);
   SetControlAction(actCtrl_Cycle_Edit, CMD_CYCLE_EDIT);
   SetControlAction(actCtrl_Cycle_Generate, CMD_CYCLE_GENERATE);
   SetControlAction(actCtrl_Cycle_Reports, CMD_CYCLE_REPORTS);
   SetControlAction(actCtrl_Cycle_View, CMD_CYCLE_VIEW);
   SetControlAction(actCtrl_Cycle_ViewOrders, CMD_CYCLE_VIEWORDERS);

   // Brochures
   {
   SetControlAction(actCtrl_Brochure_List, CMD_BROCHURE_LIST);
   SetControlAction(actCtrl_Brochure_New, CMD_BROCHURE_NEW);
   SetControlAction(actCtrl_Brochure_Edit, CMD_BROCHURE_EDIT);
   SetControlAction(actCtrl_Brochure_Delete, CMD_BROCHURE_DELETE);
   SetControlAction(actCtrl_Brochure_View, CMD_BROCHURE_VIEW);
   SetControlAction(actCtrl_Brochure_Reports, CMD_BROCHURE_REPORTS);
   }

   // Expenses
   SetControlAction(actCtrl_ExpenseList_New, CMD_EXPENSE_NEW);
   SetControlAction(actCtrl_ExpenseList_Edit, CMD_EXPENSE_EDIT);
   SetControlAction(actCtrl_ExpenseList_View, CMD_EXPENSE_VIEW);
   SetControlAction(actCtrl_ExpenseList_Print, CMD_EXPENSE_PRINT);
   SetControlAction(actCtrl_ExpenseList_Help, CMD_EXPENSE_HELP);
   SetControlAction(actCtrl_Expense_Reports, CMD_EXPENSE_REPORTS);
   SetControlAction(actCtrl_ExpenseList_LoadByCycle, CMD_EXPENSE_LOAD_BY_CYCLE);
   SetControlAction(actCtrl_Expense_QuickAdd, CMD_EXPENSE_QUICKADD);
   SetControlAction(actCtrl_Expense_EditTypes, CMD_EXPENSE_EDIT_TYPES );

   // Earnings
   SetControlAction(actCtrl_EarningList_New, CMD_Earning_NEW);
   SetControlAction(actCtrl_EarningList_Edit, CMD_Earning_EDIT);
   SetControlAction(actCtrl_EarningList_View, CMD_Earning_VIEW);
   SetControlAction(actCtrl_EarningList_Print, CMD_Earning_PRINT);
   SetControlAction(actCtrl_EarningList_Help, CMD_Earning_HELP);
   SetControlAction(actCtrl_Earning_Reports, CMD_Earning_REPORTS);
   SetControlAction(actCtrl_EarningList_LoadByCycle, CMD_Earning_LOAD_BY_CYCLE);
   SetControlAction(actCtrl_Earning_QuickAdd, CMD_EARNING_QUICKADD);
   SetControlAction(actCtrl_Earning_EditTypes, CMD_EARNING_EDIT_TYPES );

   // Email
   SetControlAction(actCtrl_Email_ReQueue, CMD_EMAIL_REQUEUE);
   SetControlAction(actCtrl_Email_Send, CMD_EMAIL_SEND );
   SetControlAction(actCtrl_Email_SendAll, CMD_EMAIL_SENDALL );
   SetControlAction(actCtrl_Email_Delete, CMD_EMAIL_DELETE );
   SetControlAction(actCtrl_Email_DeleteAll, CMD_EMAIL_DELETEALL );
   SetControlAction(actCtrl_Email_Setting, CMD_EMAIL_SETTING );
   SetControlAction(actCtrl_Email_Help, CMD_EMAIL_HELP );
   SetControlAction(actCtrl_Email_Clean, CMD_EMAIL_CLEAN );
   SetControlAction(actCtrl_Email_RequeueAll, CMD_EMAIL_REQUEUE_ALL );

   // Accounting
   SetControlAction(actCtrl_Account_Escrow, CMD_ACCOUNT_ESCROW );
   SetControlAction(actCtrl_Account_Transaction, CMD_ACCOUNT_TRANS );
   SetControlAction(actCtrl_Accounting_Help, CMD_ACCOUNT_HELP );

   // Reports - Sub Actions
   SetControlAction(act_Report_CustomerList, CMD_REPORT_CUSTOMER_LIST );
   SetControlAction(act_Report_CustomerTopCustByOrder, CMD_REPORT_CUSTOMER_TOPCUSTBYORD );
   SetControlAction(act_Report_CustomerTopCustByMoney, CMD_REPORT_CUSTOMER_TOPCUSTBYMONEY );
   SetControlAction(act_Report_OrderList, CMD_REPORT_ORDER_LIST );
   SetControlAction(act_Report_Earning_Types, CMD_REPORT_EARNING_TYPES);
   SetControlAction(act_Report_Earning_EarningByCycle, CMD_REPORT_EARNINGBYCYCLE);
   SetControlAction(act_Report_Earning_ListByCycle, CMD_REPORT_EARNINGLISTBYCYCLE);
   SetControlAction(act_Report_Expense_Type, CMD_REPORT_EXPENSETYPE);
   SetControlAction(act_Report_Expense_ByCycle, CMD_REPORT_EXPENSEBYCYCLE);
   SetControlAction(act_Report_Expense_ListByCycle, CMD_REPORT_EXPENSELISTBYCYCLE);
   SetControlAction(act_Report_EarningVsExpenseByCycle, CMD_REPORT_EARNINGVSEXPENSEBYCYCLE);
   SetControlAction(act_Report_Order_Labels, CMD_REPORT_ORDERLABELS);
   SetControlAction(act_Report_Product_QuantityOnHand, CMD_REPORT_PRODUCTQUANTITYONHAND);
   SetControlAction(act_Report_Customer_OrderHistory, CMD_REPORT_CUSTOMERORDERHISTORY);
   SetControlAction(act_Report_Order_BackOrderList, CMD_REPORT_ORDERBACKORDERLIST);
   SetControlAction(act_Report_Accounting_FeesCollectedByCycle, CMD_REPORT_ACCOUNTINGFEESCOLLECTEDBYCYCLE);
   SetControlAction(act_Report_Accounting_ShippingCollectedByCycle, CMD_REPORT_ACCOUNTINGSHIPPINGCOLLECTEDBYCYCLE);
   SetControlAction(act_Report_Accounting_TaxesCollectedByCycle, CMD_REPORT_ACCOUNTINGTAXESCOLLECTEDBYCYCLE);
   SetControlAction(act_Report_Accounting_TaxExemptByCycle, CMD_REPORT_ACCOUNTINGTAXEXEMPTBYCYCLE);
   SetControlAction(act_Report_Accounting_DepositSlipByCycle, CMD_REPORT_ACCOUNTINGDEPOSITSLIPBYCYCLE);
   SetControlAction(act_Report_Accounting_VoidNSFByCycle, CMD_REPORT_ACCOUNTINGVOIDNSFBYCYCLE);
   SetControlAction(act_Report_Accounting_ReturnsByCycle, CMD_REPORT_ACCOUNTINGRETURNSBYCYCLE);
   SetControlAction(act_Report_Accounting_TransactionLogByCycle, CMD_REPORT_ACCOUNTINGTRANSACTIONLOGBYCYCLE);
   SetControlAction(act_Report_Customer_OrderTransactionHistory, CMD_REPORT_CUSTOMERORDERTRANSACTIONHISTORY);
   SetControlAction(act_Report_Product_ProductList, CMD_REPORT_PRODUCTPRODUCTLIST);
   SetControlAction(act_Report_Cycle_CycleListByOrg, CMD_REPORT_CYCLE_CYCLELISTBYORG);
   SetControlAction(act_Report_Customer_Labels, CMD_REPORT_CUSTOMER_LABELS);
   SetControlAction(act_Report_ORder_OrderProductList, CMD_REPORT_ORDER_ORDERPRODUCTLIST);
   SetControlAction(act_Report_Order_ProductReturnList, CMD_REPORT_ORDER_PRODUCTRETURNLIST);
   SetControlAction(act_Report_Accounting_ShippingReturned, CMD_REPORT_ACCOUNTINGSHIPPINGRETURNED);
   SetControlAction(act_Report_Accounting_FeesReturned, CMD_REPORT_ACCOUNTINGFEESRETURNED);
   SetControlAction(act_Report_Customer_OustandingBalance, CMD_REPORT_CUSTOMEROUTSTANDINGBALANCE);
   SetControlAction(act_Report_Accounting_CycleBreakDown, CMD_REPORT_ACCOUNTING_ORDERAMOUNTBREAKDOWNBYCYCLE);
   SetControlAction(act_Report_CustomerEscrowBalance, CMD_REPORT_CUSTOMER_ESCROW);

end;

procedure tMainForm.MAIN_DOCK_PANELClick(Sender: TObject);
begin

end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)


procedure tMainForm.AvoBaseRibbonTabChange(Sender: TObject; const NewIndex, OldIndex: Integer; var AllowChange: Boolean);
begin
	case NewIndex of
   	0: // home
      begin
      	formControl.CreateItem(FORM_WELCOME, 0, MAIN_DOCK_PANEL);
      end;
      1:// orders
      begin
      	formControl.CreateItem(FORM_ORDERS, 0, MAIN_DOCK_PANEL );
      end;
      2:// customers
      begin
      	formControl.CreateItem(FORM_CUSTOMERS, 0, MAIN_DOCK_PANEL );
      end;
      3:// Products
      begin
      	formControl.CreateItem(FORM_PRODUCTS, 0, MAIN_DOCK_PANEL );
         Hints_ShowHint( tAvoBaseHintTypes.HintProductTabClick );
      end;
      4:// Sales Cycles
      begin
      	formControl.CreateItem(FORM_CYCLES, 0, MAIN_DOCK_PANEL );
      end;
      5:// expenses
      begin
         formControl.CreateItem(FORM_EXPENSES, 0, MAIN_DOCK_PANEL);
      end;
      6:// Earnings
      begin
         formControl.CreateItem(FORM_EARNINGS, 0, MAIN_DOCK_PANEL);
      end;
      7:// Email
      begin
         formControl.CreateItem(FORM_EMAIL, 0, MAIN_DOCK_PANEL);
      end;
      8:// Accounting
      begin
         formControl.CreateItem(FORM_ACCOUNTING, 0, MAIN_DOCK_PANEL);
      end;
      9:// Reports
      begin
         formControl.CreateItem(FORM_REPORT, 0, MAIN_DOCK_PANEL);
      end;
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

// All TControlAction Items are funneled through THIS method
procedure tMainForm.AvoActionManagerUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;
   with Action as TBasicAction do
      case tag of
         // ************************************************************************************************** //
         // EMAIL
            CMD_EMAIL_REQUEUE, CMD_EMAIL_SEND, CMD_EMAIL_SENDALL, CMD_EMAIL_DELETE,
            CMD_EMAIL_DELETEALL, CMD_EMAIL_REQUEUE_ALL, CMD_EMAIL_CLEARLIST:
            begin
               if ( formControl <> nil ) AND ( formControl.frm_EmailControl.frm_EmailList <> NIL ) then
               begin
                  actCtrl_Email_Clean.enabled := ( formControl.frm_EmailControl.frm_EmailList.EmailCount <> 0 );
                  actCtrl_Email_ReQueue.enabled := ( formControl.frm_EmailControl.frm_EmailList.EmailCount <> 0 );
                  actCtrl_Email_Send.enabled := ( formControl.frm_EmailControl.frm_EmailList.EmailCount  <> 0);
                  actCtrl_Email_SendAll.enabled := ( formControl.frm_EmailControl.frm_EmailList.EmailCount  <> 0);
                  actCtrl_Email_Delete.enabled := ( formControl.frm_EmailControl.frm_EmailList.EmailCount <> 0 );
                  actCtrl_Email_DeleteAll.enabled := ( formControl.frm_EmailControl.frm_EmailList.EmailCount <> 0 );
                  actCtrl_Email_RequeueAll.enabled := ( formControl.frm_EmailControl.frm_EmailList.EmailCount <> 0 );
               end;
            end;
         // ************************************************************************************************** //
         // CUSTOMER

         CMD_CUST_EXPORT : act_Export_Customer.Enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUST_IMPORT: act_Import_Customer.Enabled := true; // always set to true

         CMD_PRODUCT_IMPORT : act_Product_Import.Enabled := True; // alays set ON

         CMD_PRODUCT_EXPORT : act_Product_Export.Enabled := ( formControl.Product_EnableDisableButtons );

         CMD_CUST_MAINFORM_TAKEPAYMENT: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	actCtrl_Cust_Payment.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUSTNOTES: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
               actCtrl_Cust_Notes.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUST_ORDPROD: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
               actCtrl_Cust_OrdProd.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUST_EDIT: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
               actCtrl_Cust_Edit.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUST_VIEW: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	actCtrl_Cust_View.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUSTACTIVEINACTIVE: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	actCtrl_Cust_Activity.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUST_EMAIL: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	actCtrl_Cust_Email.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUST_PRINT: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	actCtrl_Cust_Print.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

         CMD_CUST_NEWORDER: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	actCtrl_Cust_NewOrder.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

			CMD_CUST_NEWRETURN: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	actCtrl_Cust_NewReturn.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

			CMD_CUST_PAYMENT: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	act_Order_Cust_TakePayment.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

			CMD_CUST_VOIDPAYMENT: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	act_Order_Cust_Void_Payment.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);

			CMD_CUST_VIEWACCOUNT: if (formControl.frm_CustControl.frm_CustomerList <> NIL ) then
         	actCtrl_Cust_ViewAccount.enabled := ( formControl.frm_CustControl.frm_CustomerList.CustRecCount <> 0);
         // ************************************************************************************************** //
         // SALES CYCLES
			CMD_CYCLE_EDIT: if ( formControl.frm_CycleControl.frm_CycleList <> NIL ) then
				actCtrl_Cycle_Edit.enabled := ( formControl.frm_CycleControl.frm_CycleList.CycleRecCount <> 0);

         CMD_CYCLE_VIEW: if ( formControl.frm_CycleControl.frm_CycleList <> NIL ) then
				actCtrl_Cycle_View.enabled := ( formControl.frm_CycleControl.frm_CycleList.CycleRecCount <> 0);

         CMD_CYCLE_VIEWORDERS: if ( formControl.frm_CycleControl.frm_CycleList <> NIL ) then
				actCtrl_Cycle_ViewOrders.enabled := ( formControl.frm_CycleControl.frm_CycleList.CycleRecCount <> 0);
         // ************************************************************************************************** //
         // ORDERS
         CMD_ORDER_NEW : enabled := true; // always set this one ON
         CMD_ORDER_RETURN : enabled := true; // always set this one ON
         CMD_ORDER_LOAD : actCtrl_Order_Load.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_CANCEL : act_Order_Cancel.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_UNCANCEL : act_Order_Cancel.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_LOAD_NUM : actCtrl_Order_LoadNum.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_VIEWINVOICE : actCtrl_Order_ViewInvoice.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_PRINTINVOICE : actCtrl_Order_PrintInvoice.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_EMAILINVOICE : actCtrl_Order_EmailInvoice.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_EMAILALL : actCtrl_Order_EmailAllInvoicesInCycle.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_PAYMENT : actCtrl_Order_Payment.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_VOIDPAYMENT : act_Order_VoidPayment.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_FINALIZE : actCtrl_Order_Finalize.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_CHANGEORDERCYCLE : act_Order_ChangeOrderCampaign.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_SAVE_INVOICE : act_Order_SaveInvoice.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_PRINT_ALL_CYCLE_INVOICES : act_Order_PrintAllCycleInvoices.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_EMAIL_SINGLEINVOICE : act_Order_EmailSingleInvoice.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_EMAIL_ALL_CYCLE_INVOICES : act_Order_EmailCycleInvoices.enabled := ( formControl.Order_EnableDisableButtons );
         CMD_ORDER_CUSTPROD : act_Order_CustProd.enabled := ( formControl.Order_EnableDisableButtons );
         // ************************************************************************************************** //
         // PRODUCTS
         CMD_PRODUCT_LIST : actCtrl_Product_List.Enabled := ( formControl.Product_EnableDisableButtons );
         CMD_PRODUCT_EDIT : actCtrl_Product_Edit.Enabled := ( formControl.Product_EnableDisableButtons );
         CMD_PRODUCT_PRINT : actCtrl_Product_Print.Enabled := ( formControl.Product_EnableDisableButtons );
         CMD_PRODUCT_DELETE : actCtrl_Product_Delete.Enabled := ( formControl.Product_EnableDisableButtons );
         CMD_PRODUCT_VIEW :  actCtrl_Product_View.Enabled := ( formControl.Product_EnableDisableButtons );
         // ************************************************************************************************** //
         // EXPENSES
         CMD_EXPENSE_EDIT : actCtrl_ExpenseList_Edit.Enabled := ( formControl.Expense_EnableDisableButtons );
         CMD_EXPENSE_VIEW : actCtrl_ExpenseList_View.Enabled := ( formControl.Expense_EnableDisableButtons );
         CMD_EXPENSE_PRINT : actCtrl_ExpenseList_Print.Enabled := ( formControl.Expense_EnableDisableButtons );
         CMD_EXPENSE_LOAD_BY_CYCLE : actCtrl_ExpenseList_LoadByCycle.Enabled := ( formControl.Expense_EnableDisableButtons );
         CMD_EXPENSE_QUICKADD : actCtrl_Expense_QuickAdd.Enabled := ( formControl.Expense_EnableDisableButtons );
         // ************************************************************************************************** //
         // EARNINGS
         CMD_Earning_EDIT : actCtrl_EarningList_Edit.Enabled := ( formControl.Earning_EnableDisableButtons );
         CMD_Earning_VIEW : actCtrl_EarningList_View.Enabled := ( formControl.Earning_EnableDisableButtons );
         CMD_Earning_PRINT : actCtrl_EarningList_Print.Enabled := ( formControl.Earning_EnableDisableButtons );
         CMD_Earning_LOAD_BY_CYCLE : actCtrl_EarningList_LoadByCycle.Enabled := ( formControl.Earning_EnableDisableButtons );
         CMD_EARNING_QUICKADD : actCtrl_Earning_QuickAdd.Enabled := ( formControl.Earning_EnableDisableButtons );
      end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
// All SMALLRIBBON Action Items
procedure tMainForm.RibbonActionExecuteSmall(Sender: TObject);
begin
	with Sender as tAction do
   begin
   	case Tag of
         CMD_PREF_GENERALSETTINGS : formControl.CreatePreferences( tPrefAreaTypes.GeneralSettings );
         CMD_PREF_REPSETTINGS : formControl.CreatePreferences( tPrefAreaTypes.RepSettings );
         CMD_PREF_EMAILSETTINGS : formControl.CreatePreferences( tPrefAreaTypes.EmailSettings);
         CMD_PREF_ORGANIZATIONS : formControl.CreatePreferences( tPrefAreaTypes.Organizations);
         CMD_PREF_ORDERFEES : formControl.CreatePreferences( tPrefAreaTypes.OrderFees);
         CMD_PREF_TAXRATES : formControl.CreatePreferences( tPrefAreaTypes.TaxRates);
         CMD_PREF_SHIPPINGRATES : formControl.CreatePreferences( tPrefAreaTypes.ShippingRates);
         CMD_PREF_EARNINGTYPES : formControl.CreatePreferences( tPrefAreaTypes.EarningTypes);
         CMD_PREF_EXPENSETYPES : formControl.CreatePreferences( tPrefAreaTypes.ExpenseTypes);
         CMD_PREF_INVOICESETTINGS : formControl.CreatePreferences( tPrefAreaTypes.InvoiceSettings);
         CMD_PREF_PRODUCTSETTINGS : formControl.CreatePreferences( tPrefAreaTypes.ProductSettings);

         CMD_ORDER_PAYMENT : formControl.OrderPayment();
         CMD_ORDER_VOIDPAYMENT : formControl.OrderVoidPayment();
         CMD_CUST_PAYMENT : formControl.CustomerPayment();
         CMD_CUST_VOIDPAYMENT : formControl.CustomerVoidPayment();
         CMD_ORDER_CANCEL : formControl.OrderCancel();
         CMD_ORDER_UNCANCEL : formControl.OrderUnCancel();
         CMD_ORDER_CHANGEORDERCYCLE : formControl.OrderChangeCycle();
         CMD_PRINT_ALL_CYCLE_INVOICES: formControl.PrintAllCycleInvoices();
         CMD_EMAIL_ALL_CYCLE_INVOICES: formControl.EmailAllCycleInvoices();
         CMD_ORDER_PRINTINVOICE: formControl.OrderPrintInvoice();
         CMD_EMAIL_SINGLEINVOICE : formControl.OrderEmailInvoice();

         // take these out for this release.
         CMD_CUST_IMPORT : formControl.ImportCustomer();
         CMD_CUST_EXPORT : formControl.ExportCustomer();

         CMD_PRODUCT_IMPORT : AvoBaseDialog('Product Import', 'Product Import Functionality is still being worked on.', mtInformation, [mbOk], 0);
         CMD_PRODUCT_EXPORT : AvoBaseDialog('Product Export', 'Product Export Functionality is still being worked on.', mtInformation, [mbOk], 0);

         // Reports
         //
         CMD_REPORT_CUSTOMER_ESCROW:
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_CustomerEscrow();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTING_ORDERAMOUNTBREAKDOWNBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_Accounting_CycleBreakDown();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_CUSTOMER_LIST :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_Customer_CustomerList();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_CUSTOMER_TOPCUSTBYORD  :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_Customer_CustomerTopCustByOrd();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_CUSTOMER_TOPCUSTBYMONEY  :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_Customer_CustomerTopCustByMoney();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ORDER_LIST :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_Order_OrderList();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_EARNING_TYPES :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_EarningTypes();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_EARNINGBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_EarningByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_EARNINGLISTBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_EarningListByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_EXPENSETYPE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_ExpenseType();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_EXPENSEBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_ExpenseByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_EXPENSELISTBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_ExpenseListByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_EARNINGVSEXPENSEBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_EarningVsExpenseByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ORDERLABELS :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_OrderLabels();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_PRODUCTPRODUCTLIST :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_ProductList();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_PRODUCTQUANTITYONHAND :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_ProductQuantityOnHand();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_CUSTOMERORDERHISTORY :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_CustomerOrderHistory();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ORDERBACKORDERLIST :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_OrderBackOrderList();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGFEESCOLLECTEDBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingFeesCollectedByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGSHIPPINGCOLLECTEDBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingShippingCollectedByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGTAXESCOLLECTEDBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_TaxesCollectedByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGTAXEXEMPTBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingTaxExemptByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGDEPOSITSLIPBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingDepositSlipByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGVOIDNSFBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingVoidNSFByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGRETURNSBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingReturnsByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGTRANSACTIONLOGBYCYCLE :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingTransactionLogByCycle();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_CUSTOMERORDERTRANSACTIONHISTORY :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_CustomerOrderTransactionHistory();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_CYCLE_CYCLELISTBYORG :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_CycleListByOrg();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_CUSTOMER_LABELS :
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_CustomerLabels();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ORDER_ORDERPRODUCTLIST:
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_OrderProductList();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ORDER_PRODUCTRETURNLIST:
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_ProductReturnList();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGSHIPPINGRETURNED:
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingShippingReturned();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_ACCOUNTINGFEESRETURNED:
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_AccountingFeesReturned();
            formControl.ShowReportForm();
         end;
         CMD_REPORT_CUSTOMEROUTSTANDINGBALANCE:
         begin
            ChangeRibbonIndex( tRibbonGroups.RibbonGroupReport );
            formControl.Report_CustomerOutstandingBalance();
            formControl.ShowReportForm();
         end;
      end;
   end;
end;

// All LARGERIBBON Action Items
procedure tMainForm.RibbonActionExecuteLarge(Sender: TObject);
begin
	with Sender as tControlAction do
   begin
   	case Tag of
      	// Standard
         //
      	CMD_CLOSE : CloseAvoBase();
         CMD_MAIN_HELP : formControl.MainHelp();
         CMD_MAIN_FORUMS : formControl.Forums();
         CMD_MAIN_CONTACTUS : formControl.ContactUs();
         CMD_MAIN_SETTINGS : formControl.CreatePreferences( tPrefAreaTypes.GeneralSettings );
         CMD_MAIN_CHECKUPDATES : CheckForUpdates();
         CMD_MAIN_DONATE : formControl.RegisterAvoBase();
         CMD_BLOG : formControl.BlogButton();
         CMD_HOME : formControl.HomeButton();
         CMD_VIEWUPDATES : formControl.ViewUpdates();

         // Orders
         //
         CMD_ORDER_HELP : formControl.OrderHelp();
         CMD_ORDER_LIST : formControl.OrderList();
         CMD_ORDER_NEW : formControl.OrderNew();
         CMD_ORDER_RETURN : formControl.OrderReturn();
         CMD_ORDER_LOAD : formControl.OrderLoad();
         CMD_ORDER_VIEWINVOICE : formControl.OrderViewInvoice();
         CMD_ORDER_PRINTINVOICE : formControl.OrderPrintInvoice();
         CMD_ORDER_REPORT : formControl.OrderReport();
         CMD_ORDER_FINALIZE : formControl.OrderFinalize();
         CMD_ORDER_LOAD_NUM : formControl.OrderLoadNum();
         CMD_ORDER_CANCEL: formControl.OrderCancel();
         CMD_ORDER_UNCANCEL: formControl.OrderUnCancel();
         CMD_ORDER_BACKORDER : formControl.OrderBackOrderManager();
         CMD_ORDER_RETURN_MANAGER : formControl.OrderReturnManager();
			CMD_ORDER_SAVE_INVOICE : formControl.OrderSaveInvoice();
         CMD_ORDER_CUSTPROD : formControl.OrderCustomerProduct();
         // DON'T DO THIS. WE DONT DO THIS. CMD_ORDER_EMAILINVOICE : formControl.OrderEmailInvoice();

         // Preferences
         //
//         CMD_PREF : formControl.CreatePreferences( tPrefAreaTypes.GeneralSettings );

         // Customers
         //
         CMD_CUSTOMER : formControl.CreateItem(FORM_CUSTOMERS, 0, MAIN_DOCK_PANEL );
         CMD_CUST_NEW : formControl.CustomerNew();
         CMD_CUST_EDIT : formControl.CustomerEdit();
         CMD_CUST_VIEW : formControl.CustomerView();
         CMD_CUSTACTIVEINACTIVE : formControl.CustomerActivateDeactivate();
         CMD_CUST_EMAIL : formControl.CustomerEmail();
         CMD_CUST_PRINT : formControl.CustomerPrint();
         CMD_CUST_HELP : formControl.CustomerHelp();
         CMD_CUST_REPORT_ONE : formControl.CustomerReport();
         CMD_CUST_NEWORDER : formControl.CustomerNewOrder();
         CMD_CUST_NEWRETURN : formControl.CustomerNewREturn();
         CMD_CUST_VIEWACCOUNT: formControl.CustomerViewAccount();
         CMD_CUSTNOTES : formControl.CustomerNotes();
         CMD_CUST_ORDPROD : formControl.CustomerOrderProd;

         // Products
         //
         CMD_PRODUCT_NEW : formControl.ProductNew();
         CMD_PRODUCT_EDIT : formControl.ProductEdit();
         CMD_PRODUCT_HELP : formControl.ProductHelp();
         CMD_PRODUCT_REPORTS : formControl.ProductReports();
         CMD_PRODUCT_PRINT : formControl.ProductPrint();
         CMD_PRODUCT_DELETE : formControl.ProductDelete();
         CMD_PRODUCT_VIEW : formControl.ProductView();
         CMD_PRODUCT_VIEWBACKORDER : formControl.BackOrderManager();


         {
         CMD_PRODUCT_IMPORT : formControl.ProductImport();
         CMD_PRODUCT_EXPORT : formControl.ProductExport();
         }



         // Cycles
         //
         CMD_CYCLE_HELP : formControl.CycleHelp();
         CMD_CYCLE_NEW : formControl.CycleNew();
         CMD_CYCLE_EDIT : formControl.CycleEdit();
         CMD_CYCLE_GENERATE : formControl.CycleGenerate();
         CMD_CYCLE_REPORTS : formControl.CycleReports();
         CMD_CYCLE_VIEW : formControl.CycleView();
         CMD_CYCLE_VIEWORDERS : formControl.CycleViewOrders();

         // Brochures
         //
         {
         CMD_BROCHURE_LIST : formControl.BrochureList();
         CMD_BROCHURE_NEW : formControl.BrochureNew();
         CMD_BROCHURE_EDIT : formControl.BrochureEdit();
         CMD_BROCHURE_DELETE : formControl.BrochureDelete();
         CMD_BROCHURE_VIEW : formControl.BrochureView();
         CMD_BROCHURE_REPORTS : formControl.BrochureReports;
         CMD_BROCHURE_HELP : formControl.BrochureHelp();
         }

         // Expenses
         //
         CMD_EXPENSE_NEW : formControl.ExpenseNew();
         CMD_EXPENSE_EDIT : formControl.ExpenseEdit();
         CMD_EXPENSE_VIEW : formControl.ExpenseView();
         CMD_EXPENSE_PRINT : formControl.ExpensePrint();
         CMD_EXPENSE_HELP : formControl.ExpenseHelp();
         CMD_EXPENSE_REPORTS : formControl.ExpenseReports();
         CMD_EXPENSE_LOAD_BY_CYCLE : formControl.ExpenseLoadByCycle();
         CMD_EXPENSE_QUICKADD: formControl.ExpenseQuickAdd();
         CMD_EXPENSE_EDIT_TYPES : formControl.EditExpenseTypes();

         // Earnings
         //
         CMD_Earning_NEW : formControl.EarningNew();
         CMD_Earning_EDIT : formControl.EarningEdit();
         CMD_Earning_VIEW : formControl.EarningView();
         CMD_Earning_PRINT : formControl.EarningPrint();
         CMD_Earning_HELP : formControl.EarningHelp();
         CMD_Earning_REPORTS : formControl.EarningReports();
         CMD_Earning_LOAD_BY_CYCLE : formControl.EarningLoadByCycle();
         CMD_EARNING_QUICKADD: formControl.EarningQuickAdd();
         CMD_EARNING_EDIT_TYPES : formControl.EditEarningTypes();

         // Email
         //
         CMD_EMAIL_REQUEUE : formControl.EmailRequeue();
         CMD_EMAIL_SEND : formControl.EmailSend();
         CMD_EMAIL_SENDALL : formControl.EmailSendAll();
         CMD_EMAIL_DELETE : formControl.EmailDelete();
         CMD_EMAIL_DELETEALL : formControl.EmailDeleteAll();
         CMD_EMAIL_SETTING : formControl.EmailSetting();
         CMD_EMAIL_HELP : formControl.EmailHelp();
         CMD_EMAIL_CLEAN : formControl.EmailClean();
         CMD_EMAIL_REQUEUE_ALL : formControl.EmailRequeueAll();

         // Accounting
         //
         CMD_ACCOUNT_ESCROW : formControl.AccountingEscrow();
         CMD_ACCOUNT_TRANS : formControl.AccountingTransactions();
         CMD_ACCOUNT_HELP: formControl.AccountingHelp();
      end;
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

// all RIBBON tAction Items are funneled through THIS method (small actions)
procedure tMainForm.ActionListExecute(Sender: TObject);
begin
	with Sender as tAction do
   begin
   	case Tag of
      	CMD_CLOSE : CloseAvoBase();
         CMD_ORDER : ShowMessage('Regular Order Screen.');
         CMD_NEW_ORDER : ShowMessage('New Order');
      end;
   end;

end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{ tab key pressed elsewhere }
procedure tMainForm.CMDialogKey(var Message: TCMDialogKey);
var
   handled : boolean;
begin
   handled := false;
   if ( Message.CharCode = VK_TAB) then
   begin
      if ( ActiveControl.Name = 'sellAtCostEdit') then
      begin
         //formControl.frm_OrderControl.InvoiceLineItem_TabPressed();
         handled := true;
      end;
   end;
   if NOT( Handled ) then
      inherited;
end;


end.



