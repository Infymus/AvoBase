 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

UNIT  constantsunit;

INTERFACE

CONST
   VER_NUM = '2.126';
   //
   // THIS NUMBER MATCHES THE AVOBASE.COM VERSION2.URI FILE! IF IT IS < THEN IT WILL UPDATE FOREVER!!
   VER_NUM_INTERNAL = 126; { keep at 3 digits, 000, increment this only once per version increase }

   //
   VER_COPY = '(C)2005-2017 AvoBase LLC';
   AVO_VER_URI = 'http://www.avobase.com/avobase_version2.uri';
   AVO_UPDATE_URI = 'http://www.avobase.com/files/';
   APP_WIDTH = 1024;
   APP_HEIGHT = 768;
   AVOBASE_NAME = 'AvoBase';
   AVOBASE_INI = 'AvoBase.ini';
   AVOBASE_FORUMS = 'http://forums.avobase.com';
   AVOBASE_DONATE = 'http://avobase.com/purchase_avobase.html';
   AVOBASE_KEYS = 'i like boogers';
   AVOBASE_FACEBOOK = 'http://www.facebook.com/groups/60640488831/';
   AVOBASE_PURCHASE = #104 + #116 + #116 + #112 + #58 + #47 + #47 + #97 + #118 + #111 + #98 + #97 +
   #115 + #101 + #46 + #99 + #111 + #109 + #47 + #112 + #117 + #114 + #99 + #104 + #97 + #115 +
   #101 + #95 + #97 + #118 + #111 + #98 + #97 + #115 + #101 + #46 + #104 +
   #116 + #109 + #108; {http://avobase.com/purchase_avobase.html}

   AVOBASE_COPYRIGHT = #67 + #111 + #112 + #121 + #114 + #105 + #103 + #104 + #116 + #32 + #40 + #67 + #41 + #32 +
      #50 + #48 + #48 + #53 + #45 + #50 + #48 + #49 + #55 + #32 + #45 + #32 + #65 + #108 + #108 + #32 + #82 + #105 +
      #103 + #104 + #116 + #115 + #32 + #82 + #101 + #115 + #101 + #114 + #118 + #101 + #100; {Copyright (C) 2005-2017 - All Rights Reserved}

   AVOBASE_WEBSITE =  #104 + #116 + #116 + #112 + #58 + #47 + #47 + #119 + #119 + #119 + #46 + #97 + #118 +
   #111 + #98 + #97 + #115 + #101 + #46 + #99 + #111 + #109; {http://www.avobase.com}

   AVOBASE_SESSION_NAME = 'AvoSession';
   AVOBASE_MAX_ORDERS = 10;
   MAX_SALES_CYCLES = 30;
   UPDATE_RUNTIMES = 10;
   DONATE_NAG_TIME = 30;
   AVOBASE_UPDATER = 'AvoAutoUpdater.exe';
   AVOBASE_UPDATER_NEW = 'AvoAutoUpdaterNew.exe';
   AVOBASE_MANIFEST = 'AvoUpdateManifest.abu';
   AVOBASE_UPDATER_WORKER = 'AutoUpdaterWorker.exe';
   AVOBASE_UPDATE_DIR = 'updates';
   AVOBASE_BACKPU_DIR = 'backups';
   AVOBASE_DATABASE_DIR = 'database';

{$REGION 'Types'}

type
   tRegions = (
      RegionUS = 0,
      RegionUK = 1,
      RegionCAN = 2
      );

	tActiveStates = (
      stateActive,
      stateInactive,
      stateAll
      );

   tFormActions = (
      actionCancel,
      actionSave,
      actionConfirm,
      actionOK
      );

	tCustEditTypes = (
      custTypeNew,
      custTypeOld
      );

   tSortProdTypes = (
      ProdOrg,
      ProdCycle,
      ProdNum,
      ProdName,
      ProdQTY,
      ProdAmount,
      ProdOrder
      );

   tSortCycleTypes = (
      SortCycleTypesByOrg
      );

   tOrderTypes = (
      OrdTypeNone = 0,
      OrdTypeOrder = 1,
      OrdTypeReturn = 2
      );

   tOrderStatusTypes = (
      OrderStatusNone = 0,
      OrderStatusOpen = 1,
      OrderStatusClosed = 2,
      OrderStatusCancelled = 3,
      OrderStatusDelinquent = 4
      );

   tVoidTypes = (
      Void = 1,
      VoidNSF = 2,
      VoidRetCheck = 3,
      VoidCardDeclined = 4
      );

   tBackOrderTypes = (
      BONone = 0,
      BOOrdered = 1,
      BONotShipped = 2,
      BONoLongerAvail = 3
      );

   tBackOrderStatus = (
      BOSPending = 0,
      BOSDelivered = 1,
      BOSNotAvail = 2
      );

   tRibbonGroups = (
      RibbonGroupHome = 0,
      RibbonGroupOrder = 1,
      RibbonGroupCustomer = 2,
      RibbonGroupProduct = 3,
      RibbonGroupCycle = 4,
      RibbonGroupExpense = 5,
      RibbonGroupEarning = 6,
      RibbonGroupEmail = 7,
      RibbonGroupAccounting = 8,
      RibbonGroupReport = 9
      );

	tInvoiceTypes = (
      InvoiceTypeOrder = 0,
      InvoiceTypeReport = 1
      );

   tInvoiceLineItemStyles = (
      liGeneric = 0,
      liQuick = 1
      );

   tLoadOrderTypes = (
      LoadOrderTypeNewOrder = 0,
      LoadOrderTypeNewReturn = 1,
      LoadOrderTypeLoadOrder = 2);

   tShippingTypes = (
      ShipRate = 1,
      ShipPcnt = 2
      );

   tInvoiceLineDisplayItems = (
      InvLineBlank = 0,
      InvLineSalesRepName = 1,
      InvLineAddr1 = 2,
      InvLineAddr2 = 3,
      InvLineEmail = 4,
      InvLineCityStateZip = 5,
      InvLinePhone = 6,
      InvLineCell = 7
      );

   tMethodOfPaymentTypes = (
      PayTypeCash = 1,
      PayTypeCreditCard = 2,
      PayTypeCheck = 3,
      PayTypeCashierCheck = 4,
      PayTypeMoneyOrder = 5,
      PayTypeDebitCard = 6,
      PayTypeEscrow = 7,
      PayTypePayPal = 8
      );

   tCreditTypes = (
      CredTypeCash = 1,
      CredTypeCheck = 2,
      CredTypeCredit = 3
      );

   tCreditCardTypes = (
      CCTNone = 0,
      CCTVisa = 1,
      CCTAmex = 2,
      CCTBankcard = 3,
      CCTDiners = 4,
      CCTDiscover = 5,
      CCTMasterCard = 6);

   tTaxTypes = (
      taxTypeSimple = 1,
      taxTypeCompound = 2
      );

   tCanceLtypes = (
      CancelOrders,
      CancelUnCancel
      );

   tEmailAuthTypes = (
      EmailAuthDefault = 0,
      EmailAuthSASL = 1,
      EmailAuthNone = 2
      );

   tEmailStatusTypes = (
      EmailPending = 1,
      EmailSent = 2,
      EmailFailed = 3,
      EmailError = 4,
      EmailDeleted = 5,
      EmailNonExist = 6
      );

   tEmailTypes = (
      EmailTypeOrder = 1
      );

   tTransTypes = (
      TransCredit = 1,
      TransDebit = 2
      );

   tTransPayTypes = (
      transPayCash = 1,
      TransPayCheck = 2,
      TransPayCredit = 3
      );

   tReportViewTypes = (
      RepTypeView = 1,
      RepTypePDF = 2,
      RepTypeRTF = 3,
      RepTypeXLS = 4
      );

   tFormTypes = (
      formTypeOk,
      formTypeError
      );

   tProdReturnStatus = (
      prodRetPending = 0,
      prodRetOEM = 1,
      prodRetInv = 2
      );

   tCprodTypes = (
      cprodNone = 0,
      cprodCurrent = 1,
      cprodAll = 2
      );

   tTaxDefaultTypes = (
      taxDefaultNone = 0,
      taxDefaultProduct = 1,
      taxDefaultFee = 2,
      taxDefaultShipping = 3,
      taxDefaultOrder = 4
      );

   tReportSelectType =  (
      ReportSelectTypeView,
      ReportSelectTypeSave,
      ReportSelectTypePrint
      );

   tPrintLabelTypes = (
      type5160 = 0,
      type5161 = 1,
      type18160 = 2
      );

   tHelpTopicTypes = (
      helpSetting = 1,
      helpMain = 2,
      helpOrder = 3,
      helpCustomer = 4,
      helpProduct = 5,
      helpCycle = 6,
      helpExpense = 7,
      helpEarning = 8,
      helpEmail = 9,
      helpAccounting = 10,
      helpReport = 11
      );

   tCheckUpdateTypes = (
      checkUpdateNormal,
      checkUpdateSilent,
      checkUpdateFound,
      checkUpdateError,
      checkUpdateNone
      );

   tInvoiceCustPhoneTypes = (
      ICPTNone = 0,
      ICPTHome = 1,
      ICPTCell = 2,
      ICPTWork = 3,
      ICPTAll = 4
      );

   TOrderListHeaderTypes = (
      OlistNone = 0,
      OListLineItemCount = 1,
      OlistBackOrderItemCount = 2,
      OlistInvoiceTotalAmount = 3,
      OlistInvoiceMOPTotal = 4,
      OlistInvoiceAmountDue = 5
      );

   tPrefAreaTypes = (
      Registration,
      GeneralSettings,
      RepSettings,
      EmailSettings,
      Organizations,
      OrderFees,
      TaxRates,
      ShippingRates,
      EarningTypes,
      ExpenseTypes,
      InvoiceSettings,
      ProductSettings
      );

   tPrefTaxRounding = (
      rmUp = 1,
      rmDown = 2,
      rmNearest = 3,
      rmTruncate = 4
      );

	tAvoBaseExportTypes = (
   	None = 0,
   	Text_CommaDelimited,
      Text_CommaDelimitedQuotes,
      Text_CommaDelimitedSingleQuotes
      );

{$ENDREGION}

(*** EVENTS ************************************************************************************ *)

{$REGION 'Events'}

type
	tPrefChange = Procedure( Sender : Tobject ) OF Object;
	tLoadOrderEvent = procedure( sender : tObject; inOrderID : string ) of object;
   tNewOrderWithCustomerEvent = procedure( inCustID : string ) of object;
   eSomeKindOfEvent = procedure( sender : tobject; prodNum : string) of object;
   tPrintInvoiceEvent = procedure( sender : tObject; inOrderID : string ) of object;
   tViewInvoiceEvent = procedure( sender : tObject; inOrderID : string ) of object;
   tViewInvoiceClosed = procedure( inOrderID : string ) of object;
   tDeleteLineEvent = Procedure( lineNum : Integer ) OF Object;
	tRecalculateInvoiceEvent = Procedure of Object;
   tEditorHandlerEvent = Procedure( Sender : tObject; WorkStr : String ) OF Object;
   tInvoiceLineItemClickedEvent = Procedure( Sender : tObject; LineNum : integer ) of object;
   tInvoiceUpdatedEvent = procedure of object;
   tInvoiceFeeItemClickedEvent = Procedure( Sender : tObject; LineNum : integer ) of object;
   tInvoiceMOPItemClickedEvent = Procedure( Sender : tObject; LineNum : integer ) of object;
   tEventHandler = Procedure( Sender : tObject ) OF Object;
   tHelpEvent = procedure( helpID : string ) of object;
   tFinalizeOrderEvent = procedure( InOrderID : string ) of object;
   tTakeMethodOfPaymentEvent = procedure( inOrderID : string ) of object;
   tTakeMethodOfPaymentCustomerEvent = procedure( inCustID : string ) of object;
   tVoidMethodOfPaymentCustomerEvent = procedure( inCustID : string ) of object;
   tVoidPaymentEvent = procedure( inOrderID : string ) of object;
   tEvent_LineItem_LineDelete = procedure( sender : tObject; lineNum : integer ) of Object;
   tEvent_LineItem_LineUpdate = procedure( sender : tObject; lineNum : integer ) of Object;
   tEvent_MOPItem_LineDelete = procedure( sender : tObject; lineNum : integer ) of Object;
   tEvent_MOPItem_LineUpdate = procedure( sender : tObject; lineNum : integer ) of Object;
   tEvent_FEEItem_LineDelete = procedure( sender : tObject; lineNum : integer ) of Object;
   tEvent_FEEItem_LineUpdate = procedure( sender : tObject; lineNum : integer ) of Object;
   tCancelEvent = procedure( CancelType : tCanceLtypes; InorderID : string ) of Object;
   tReturnEvent = procedure( inOrderID : string ) of Object;
   tBackOrderNotAvailableEvent  = procedure( InProdID,InBOProdID : string ) of Object;
   tBackOrderDeliveredEvent  = procedure( InProdID,InBOProdID : string ) of Object;
   tEmailOrderEvent = procedure( inOrderID : string ) of Object;
   tEmailUpdateEvent = procedure() of Object;
   tChangeOrderCycleEvent = procedure() of Object;
   tUseEscrowEvent = procedure( inLineNum : integer ) of Object;
   tViewOrderAccount = procedure() of Object;
   tCloseOrderEvent = procedure() of object;
   tInvoiceLineItemProductLookupEvent = procedure( inLineNumber : integer; inProdNum : string ) of Object;
   tEmailEvent = procedure( inOrderID : string ) of Object;
   tViewPrintCustomerEvent = procedure( inCustID : string ) of Object;
   tWelcomeEvent = procedure( sender : tObject; actionID : integer) of object;
 	tRibbonChangeEvent = procedure( sender : tObject; inRibbon : tRibbonGroups );
 	tCheckForUpdatesEvent = procedure( sender : tObject );
   tInvoiceLineItemExit = procedure( LineNum : integer ) of object;
   tOrderListEditCustomerEvent = procedure( inCustID : string ) of object;
   tEmailCycleEvent = procedure( inCycleID : string ) of object;
   tEmailCustomerEvent = procedure() of Object;
   tLineItemEvent = procedure( lineNum : integer ) of object;

(** * FORM UPDATE EVENTS TO CAUSE RECALCULATIONS BETWEEN FORMS **************************************** *)

type
   tOrderRefreshEvent = procedure() of Object;
   tCustomerRefreshEvent = procedure() of Object;
   tProductRefreshEvent = procedure() of Object;
   tCycleRefreshEvent = procedure() of Object;
   tExpenseRefreshEvent = procedure() of Object;
   tEarningRefreshEvent = procedure() of Object;
   tEmailRefreshEvent = procedure() of Object;
   tPrefRefreshEvent = procedure() of Object;

{$ENDREGION}

implementation

end.

