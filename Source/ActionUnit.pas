 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit  ActionUnit;

interface uses
   constantsunit,
   img_storageformunit,
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

// WARNING: THESE ARE IN DECIMAL ORDER. DO NOT RESET THEIR NUMBERS.
// in some cases, these are stored as physical properties on visual components as TAG variables.

CONST
CMD_SAVE = 1;
CMD_CANCEL = 2;
CMD_DELETE = 3;
CMD_NEW = 4;
CMD_LIST = 5;
CMD_SEARCH = 6;
CMD_SEARCH_ALL = 7;
CMD_OK = 8;
CMD_LOAD_CUSTOMER = 9;
CMD_PRODUCT = 10;
CMD_PICK_TICKET = 11;
CMD_CASHIER = 12;
CMD_EDIT = 13;
CMD_LOAD = 14;
CMD_FIRST = 15;
CMD_PREV = 16;
CMD_NEXT = 17;
CMD_LAST = 18;
CMD_MOVEUP = 19;
CMD_MOVEDOWN = 20;
CMD_LOADFROMFILE = 21;
CMD_WRITE = 22;
CMD_NEWS = 23;
CMD_CLOSE = 24;
CMD_SAVETOFILE = 25;
CMD_FILE = 26;
CMD_PRIMARY = 27;
CMD_SECONDARY = 28;
CMD_CONFIG = 29;
CMD_THEMES = 30;
CMD_HELP = 31;
CMD_CODE = 32;
CMD_SELECT_OK = 33;
CMD_SELECT_CANCEL = 34;
CMD_ORDER_OPTIONS = 35;
CMD_SELECT = 36;
CMD_MAKEKEY = 37;
CMD_PRINT_INVOICE = 38;
CMD_EMAIL = 39;
CMD_REPORT = 40;
CMD_CLOSE_ORDER = 41;
CMD_NEW_RETURN = 42;
CMD_GENERATE = 43;
CMD_PRINT = 44;
CMD_YES = 45;
CMD_NO = 46;
CMD_EDITEARNING = 47;
CMD_SAVEEARNING = 48;
CMD_CANCELEARNING = 49;
CMD_DELETEEARNING = 50;
CMD_CLOSEEARNING = 51;
CMD_NEWEARNING = 52;
CMD_CALC = 53;
CMD_EMAIL_SEND = 54;
CMD_EMAIL_SENDALL = 55;
CMD_EMAIL_CLEARLIST = 56;
CMD_EMAIL_DELETE = 57;
CMD_EMAIL_SETTING = 58;
CMD_EMAIL_CLOSE = 59;
CMD_EMAIL_DELETEALL = 60;
CMD_EMAIL_REQUEUE = 61;
CMD_EMAIL_HELP = 62;
CMD_EMAIL_CLEAN = 63;
CMD_CLEAR = 64;
CMD_MOPNEW = 65;
CMD_MOPEDIT = 66;
CMD_MOPSAVE = 67;
CMD_MOPCANCEL = 68;
CMD_FINALIZE = 69;
CMD_MOPDELETE = 70;
CMD_CUSTOMER = 71;
CMD_LINEITEM = 72;
CMD_MESSAGE = 73;
CMD_PAYMENTS = 74;
CMD_CUSTACTIVEINACTIVE = 75;
CMD_LABELS = 76;
CMD_ORDER_REPORT = 77;
CMD_ORDER = 78;
CMD_NEW_ORDER = 79;
CMD_PREF = 80;
CMD_CUST_NEW = 81;
CMD_CUST_EDIT = 82;
CMD_CUST_EMAIL = 83;
CMD_CUST_PRINT = 84;
CMD_CUST_REPORT_ONE = 85;
CMD_CUST_VIEW = 86;
CMD_CUST_HELP = 87;
CMD_ORDER_LIST = 88;
CMD_ORDER_NEW = 89;
CMD_ORDER_RETURN = 90;
CMD_ORDER_LOAD = 91;
CMD_ORDER_VIEWINVOICE = 92;
CMD_ORDER_PRINTINVOICE = 93;
CMD_ORDER_EMAILINVOICE = 94;
CMD_ORDER_EMAILALL = 95;
CMD_ORDER_PAYMENT = 96;
CMD_ORDER_VOIDPAYMENT = 97;
CMD_MAIN_HELP = 98;
CMD_MAIN_FORUMS = 99;
CMD_MAIN_CONTACTUS = 100;
CMD_MAIN_SETTINGS = 101;
CMD_MAIN_CHECKUPDATES = 102;
CMD_MAIN_DONATE = 103;
CMD_PRODUCT_LIST = 104;
CMD_PRODUCT_NEW = 105;
CMD_PRODUCT_EDIT = 106;
CMD_PRODUCT_HELP = 107;
CMD_PRODUCT_REPORTS = 108;
CMD_PRODUCT_PRINT = 109;
CMD_PRODUCT_DELETE = 110;
CMD_PRODUCT_VIEW = 111;
CMD_CYCLE_LIST = 112;
CMD_CYCLE_NEW = 113;
CMD_CYCLE_EDIT = 114;
CMD_CYCLE_GENERATE = 115;
CMD_CYCLE_REPORTS = 116;
CMD_CYCLE_VIEW = 117;
CMD_BROCHURE_LIST = 118;
CMD_BROCHURE_NEW = 119;
CMD_BROCHURE_EDIT = 120;
CMD_BROCHURE_DELETE = 121;
CMD_BROCHURE_VIEW = 122;
CMD_BROCHURE_REPORTS = 123;
CMD_BROCHURE_HELP = 124;
CMD_CUST_NEWORDER = 125;
CMD_CUST_NEWRETURN = 126;
CMD_CUST_PAYMENT = 127;
CMD_CUST_VOIDPAYMENT = 128;
CMD_ORDER_MESSAGE = 129;
CMD_ORDER_LINEITEMS = 130;
CMD_ORDER_CUSTOMERS = 131;
CMD_CYCLE_VIEWORDERS = 132;
CMD_ORDER_EDIT_CUSTOMER = 133;
CMD_ORDER_EDIT_MESSAGE = 134;
CMD_ORDER_EDIT_LINEITEMS = 135;
CMD_ORDER_EDIT_MOP = 136;
CMD_ORDER_EDIT_FEES = 137;
CMD_ORDER_EDIT_FINALIZE = 138;
CMD_ORDER_EDIT_PAYMENT = 139;
CMD_ORDER_FINALIZE = 140;
CMD_ORDER_LOAD_NUM = 141;
CMD_VOID_PAYMENT = 142;
CMD_CUST_VIEWACCOUNT = 143;
CMD_ORDER_CANCEL = 144;
CMD_ORDER_UNCANCEL = 145;
CMD_CUST_CANCEL_ORDER = 146;
CMD_CUST_UNCANCEL_ORDER = 147;
CMD_EXPENSE_NEW = 148;
CMD_EXPENSE_EDIT = 149;
CMD_EXPENSE_VIEW = 150;
CMD_EXPENSE_PRINT = 151;
CMD_EXPENSE_HELP = 152;
CMD_EXPENSE_REPORTS = 153;
CMD_EXPENSE_LOAD_BY_CYCLE = 154;
CMD_EXPENSE_EDIT_TYPES = 155;
CMD_EARNING_NEW = 156;
CMD_EARNING_EDIT = 157;
CMD_EARNING_VIEW = 158;
CMD_EARNING_PRINT = 159;
CMD_EARNING_HELP = 160;
CMD_EARNING_REPORTS = 161;
CMD_EARNING_LOAD_BY_CYCLE = 162;
CMD_EARNING_EDIT_TYPES = 163;
CMD_PRODUCT_VIEWBACKORDER = 164;
CMD_ORDEREDIT_LINEITEM_BLANK = 165;
CMD_ORDEREDIT_LINEITEM_PRODUCT = 166;
CMD_ORDEREDIT_LINEITEM_BACKORDER = 167;
CMD_ORDEREDIT_LINEITEM_DELETE = 168;
CMD_BO_DELIVER = 169;
CMD_BO_NOTAVAIL = 170;
CMD_ORDER_BACKORDER = 171;
CMD_ORDER_CHANGEORDERCYCLE = 172;
CMD_ORDER_RETURN_MANAGER = 173;
CMD_ORDER_SAVE_INVOICE = 174;
CMD_ESCROW_CASH = 175;
CMD_ESCROW_CHECK = 176;
CMD_ESCROW_ESCROW = 177;
CMD_PBO_RETURNED = 178;
CMD_PBO_INVENTORY = 179;
CMD_CUST_MAINFORM_TAKEPAYMENT = 180;
CMD_TAX_EDIT = 181;
CMD_TAX_EDITCLASS = 182;
CMD_TAX_SETDEFAULT = 183;
CMD_BLOG = 184;
CMD_HOME = 185;
CMD_ACCOUNT_ESCROW = 186;
CMD_ACCOUNT_TRANS = 187;
CMD_ESCROW_ADD = 188;
CMD_ESCROW_SUBTRACT = 189;
CMD_REPORT_CUSTOMER_LIST = 190;
CMD_PRINT_SETUP = 191;
CMD_PRINT_PREVIEW = 192;
CMD_PRINT_PRINT = 193;
CMD_REPORT_CUSTOMER_TOPCUSTBYORD = 194;
CMD_REPORT_CUSTOMER_TOPCUSTBYMONEY = 195;
CMD_REPORT_ORDER_LIST = 196;
CMD_PREF_EMAIL_MAIN = 197;
CMD_PREF_EMAIL_ORDER = 198;
CMD_PREF_EMAIL_RETURN = 199;
CMD_REPORT_EARNING_TYPES = 200;
CMD_REPORT_EARNINGBYCYCLE = 201;
CMD_REPORT_EARNINGLISTBYCYCLE = 202;
CMD_REPORT_EXPENSETYPE = 203;
CMD_REPORT_EXPENSEBYCYCLE = 204;
CMD_REPORT_EXPENSELISTBYCYCLE = 205;
CMD_REPORT_EARNINGVSEXPENSEBYCYCLE = 206;
CMD_REPORT_ORDERLABELS = 207;
CMD_REPORT_CUSTOMERSINGLECUSTOMER = 208;
CMD_REPORT_PRODUCTSINGLEPRODUCT = 209;
CMD_REPORT_PRODUCTQUANTITYONHAND = 210;
CMD_REPORT_CUSTOMERORDERHISTORY = 211;
CMD_REPORT_ORDERBACKORDERLIST = 212;
CMD_REPORT_ACCOUNTINGFEESCOLLECTEDBYCYCLE = 213;
CMD_REPORT_ACCOUNTINGSHIPPINGCOLLECTEDBYCYCLE = 214;
CMD_REPORT_ACCOUNTINGTAXESCOLLECTEDBYCYCLE = 215;
CMD_REPORT_ACCOUNTINGTAXEXEMPTBYCYCLE = 216;
CMD_REPORT_ACCOUNTINGDEPOSITSLIPBYCYCLE = 217;
CMD_REPORT_ACCOUNTINGVOIDNSFBYCYCLE = 218;
CMD_REPORT_ACCOUNTINGRETURNSBYCYCLE = 219;
CMD_REPORT_ACCOUNTINGTRANSACTIONLOGBYCYCLE = 220;
CMD_REPORT_CUSTOMERORDERTRANSACTIONHISTORY = 221;
CMD_REPORT_PRODUCTPRODUCTLIST = 222;
CMD_REPORT_CYCLE_CYCLELISTBYORG = 223;
CMD_REPORT_CUSTOMER_LABELS = 224;
CMD_REPORT_ORDER_ORDERPRODUCTLIST = 225;
CMD_REPORT_ORDER_PRODUCTRETURNLIST = 226;
CMD_PRINT_LIST = 227;
CMD_REPORT_ACCOUNTINGSHIPPINGRETURNED = 228;
CMD_REPORT_ACCOUNTINGFEESRETURNED = 229;
CMD_ORDER_HELP = 230;
CMD_CYCLE_HELP = 231;
CMD_ACCOUNT_HELP = 232;
CMD_FIND_KEY = 233;
CMD_REGISTER = 234;
CMD_KEYMAKER_NEW_ORDER = 235;
CMD_KEYMAKER_NEW_REGISTRATION = 236;
CMD_KEYMAKER_EMAIL = 237;
CMD_PRINT_ALL_CYCLE_INVOICES = 238;
CMD_EMAIL_ALL_CYCLE_INVOICES = 239;
CMD_EXPENSE_QUICKADD = 240;
CMD_EARNING_QUICKADD = 241;
CMD_CONTINUE = 242;
CMD_CUSTNOTES = 243;
CMD_WELCOME_FB = 244;
CMD_REPORT_CUSTOMEROUTSTANDINGBALANCE = 245;
CMD_REPORT_ACCOUNTING_ORDERAMOUNTBREAKDOWNBYCYCLE = 246;
CMD_EMAIL_SINGLEINVOICE = 247;
CMD_CUST_ORDPROD = 248;
CMD_ORDER_CUSTPROD = 249;
CMD_ESCROW_TAKEPAYMENT = 250;
CMD_VIEWUPDATES = 251;
CMD_REPORT_CUSTOMER_ESCROW = 252;
CMD_EMAIL_REQUEUE_ALL = 253;
CMD_FIND_KEY_WEB = 254;
CMD_PRODUCT_IMPORT = 255;
CMD_PRODUCT_EXPORT = 256;
CMD_PREF_GENERALSETTINGS = 257;
CMD_PREF_REPSETTINGS = 258;
CMD_PREF_EMAILSETTINGS = 259;
CMD_PREF_ORDERFEES = 260;
CMD_PREF_TAXRATES = 261;
CMD_PREF_SHIPPINGRATES = 262;
CMD_PREF_EARNINGTYPES = 263;
CMD_PREF_EXPENSETYPES = 264;
CMD_PREF_INVOICESETTINGS = 265;
CMD_PREF_PRODUCTSETTINGS = 266;
CMD_PREF_ORGANIZATIONS = 267;
CMD_TAX_SET_ROUNDING = 268;
CMD_CUST_IMPORT = 269;
CMD_CUST_EXPORT = 270;



// place the following code in your form declaration, and create a method the same to handle it:
{
   // Goes in the PRIVATE area of the form
   private
      formActionList : tAvoActionList;
      procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);

   // assign ANY button to an action
   SOMEBUTTON.Action := formActionList.AssignAction( CMD_SAVE )

   // goes in the create method of the form
   formActionList := tAvoActionList.Create(Application);
   formActionList.OnUpdate := HandleActionListUpdate;

   // actually handles the method
   procedure YOURFORMNAME.HandleActionExecute(sender: tObject; actionID: integer);
   begin
      // this handles whether an item was clicked
      case actionID of
         CMD_SAVE : showmessage('you pressed the button CMD_SAVE');
      end;
   end;

   procedure YOURFORMNAME.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
   begin
      // this handles the action list being updated to determine if tActions are enabled or not
      handled := true;
      with Action as tAction do
         case tag of
            CMD_SAVE : enabled := true;
         end;
   end;
}

type
   tActionEvent = procedure( sender : tObject; actionID : integer) of object;

type
	tAvoActionList = class( tActionList )
   protected
      fActionEvent : tActionEvent;
   private
      procedure HandleActionExecute(Sender: TObject);
      function AddNewAction( inActionType : integer; inName : string; inCaption : string; inImageIndex : integer ) : boolean;
   public
      function AssignAction( inType : integer ) : tAction;
      //
      property onActionEvent : tActionEvent read fActionEvent write fActionEvent;
      //
      constructor Create( owner: TComponent); override;
      destructor Destroy; OVERRIDE;
   end;

implementation

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

constructor tAvoActionList.Create( Owner: TComponent );
begin
   Inherited Create( owner );
   //
   // do wot you need to do
   with Self do
   begin
      // OnUpdate := DO NOT ASSIGN THIS... It *MUST* be assigned by the form that creates this so the action is handled THERE.
      name := 'actList';
      Images := img_StorageForm.Avobase_ToolBar_Img;
   end;
   // Add ALL of the standard actions
   // These will NOT fire until they are assigned outside the scope of this wrapper.
   AddNewAction( CMD_SAVE, 'actSave', 'Save', IMG_SAVE);
   AddNewAction( CMD_CANCEL, 'actCancel', 'Cancel', IMG_CANCEL);
   AddNewAction( CMD_DELETE, 'actDelete', 'Delete', IMG_DELETE);
   AddNewAction( CMD_NEW, 'actNew', 'New', IMG_NEW);
   AddNewAction( CMD_LIST, 'actList', 'List', IMG_IDEA);
   AddNewAction( CMD_SEARCH, 'actSearch', 'Search', IMG_IDEA);
   AddNewAction( CMD_SEARCH_ALL, 'actSearchAll', 'Search All', IMG_IDEA);
   AddNewAction( CMD_OK, 'actOk', 'Ok', IMG_OK);
   AddNewAction( CMD_ORDER_LOAD, 'actLoadOrder', 'Load Order', IMG_EDIT);
   AddNewAction( CMD_LOAD_CUSTOMER, 'actLoadCustomer', 'Load Customer', IMG_IDEA);
   AddNewAction( CMD_PRODUCT, 'actProduct', 'Product', IMG_IDEA);
   AddNewAction( CMD_PICK_TICKET, 'actPickTicket', 'Pick Ticket', IMG_IDEA);
   AddNewAction( CMD_CASHIER, 'actCashier', 'Cashier', IMG_IDEA);
   AddNewAction( CMD_EDIT, 'actEdit', 'Edit', IMG_EDIT);
   AddNewAction( CMD_LOAD, 'actLoad', 'Load', IMG_EDIT);
   AddNewAction( CMD_FIRST, 'actFirst', 'First', IMG_IDEA);
   AddNewAction( CMD_PREV, 'actPrev', 'Prev', IMG_IDEA);
   AddNewAction( CMD_NEXT, 'actNext', 'Next', IMG_NAV_NEXT);
   AddNewAction( CMD_LAST, 'actLast', 'Last', IMG_IDEA);
   AddNewAction( CMD_MOVEUP, 'actMoveUp', 'Move Up', IMG_IDEA);
   AddNewAction( CMD_MOVEDOWN, 'actMoveDown', 'Move Down', IMG_IDEA);
   AddNewAction( CMD_LOADFROMFILE, 'actLoadFromFile', 'Load From File', IMG_IDEA);
   AddNewAction( CMD_WRITE, 'actWrite', 'Write', IMG_IDEA);
   AddNewAction( CMD_NEWS, 'actNews', 'News', IMG_IDEA);
   AddNewAction( CMD_CLOSE, 'actClose', 'Close', IMG_CLOSE);
   AddNewAction( CMD_SAVETOFILE, 'actSaveToFile', 'Save To File', IMG_IDEA);
   AddNewAction( CMD_FILE, 'actFile', 'File', IMG_IDEA);
   AddNewAction( CMD_PRIMARY, 'actPrimary', 'Primary', IMG_IDEA);
   AddNewAction( CMD_SECONDARY, 'actSecondary', 'Secondary', IMG_IDEA);
   AddNewAction( CMD_CONFIG, 'actConfig', 'Config', IMG_IDEA);
   AddNewAction( CMD_THEMES, 'actThemes', 'Themes', IMG_IDEA);
   AddNewAction( CMD_HELP, 'actHelp', 'Help', IMG_HELP);
   AddNewAction( CMD_CODE, 'actCode', 'Code', IMG_IDEA);
   AddNewAction( CMD_SELECT_OK, 'actSelectOK', 'Select', IMG_CHECK);
   AddNewAction( CMD_SELECT_CANCEL, 'actSelectCancel', 'Cancel', IMG_CANCEL);
   AddNewAction( CMD_ORDER_OPTIONS, 'actOrderOptions', 'Options', IMG_IDEA);
   AddNewAction( CMD_SELECT, 'actSelect', 'Select', IMG_IDEA);
   AddNewAction( CMD_MAKEKEY, 'actMakeKey', 'Make Key', IMG_KEYS );
   AddNewAction( CMD_PRINT_INVOICE, 'actPrintInvoice', 'Print Invoice', IMG_PRINT );
   AddNewAction( CMD_EMAIL, 'actEmail', 'Email', IMG_EMAIL );
   AddNewAction( CMD_REPORT, 'actReport', 'Report', IMG_IDEA);
   AddNewAction( CMD_CLOSE_ORDER, 'actCloseOrder', 'Close Order', IMG_IDEA);
   AddNewAction( CMD_NEW_RETURN, 'actNewReturn', 'New Return', IMG_IDEA);
   AddNewAction( CMD_GENERATE, 'actGenerate', 'Generate', IMG_IDEA);
   AddNewAction( CMD_PRINT, 'actPrint', 'Print', IMG_PRINT);
   AddNewAction( CMD_YES, 'actYes', 'Yes', IMG_YES );
   AddNewAction( CMD_NO, 'actNo', 'No', IMG_NO );
   AddNewAction( CMD_EDITEARNING, 'actEditEarning', 'Edit Earning', IMG_IDEA);
   AddNewAction( CMD_SAVEEARNING, 'actSaveEarning', 'Save Earning', IMG_IDEA);
   AddNewAction( CMD_CANCELEARNING, 'actCancelEarning', 'Cancel Earning', IMG_IDEA);
   AddNewAction( CMD_DELETEEARNING, 'actDeleteEarning', 'Delete Earning', IMG_IDEA);
   AddNewAction( CMD_CLOSEEARNING, 'actCloseEarning', 'Close Earning', IMG_IDEA);
   AddNewAction( CMD_NEWEARNING, 'actNewEarning', 'New Earning', IMG_IDEA);
   AddNewAction( CMD_CALC, 'actCalc', 'Calculate', IMG_IDEA);
   AddNewAction( CMD_EMAIL_SEND, 'actEmailSend', 'Send', IMG_IDEA);
   AddNewAction( CMD_EMAIL_SENDALL, 'actEmailSendAll', 'Send All', IMG_IDEA);
   AddNewAction( CMD_EMAIL_CLEARLIST, 'actEmailClearList', 'Clear Email List', IMG_IDEA);
   AddNewAction( CMD_EMAIL_DELETE, 'actEmailDelete', 'Delete Email', IMG_IDEA);
   AddNewAction( CMD_EMAIL_CLOSE, 'actEmailClose', 'Close', IMG_IDEA);
   AddNewAction( CMD_EMAIL_REQUEUE, 'actEmailLogRequeue', 'Requeue', IMG_IDEA);
   AddNewAction( CMD_CLEAR, 'actClear', 'Clear', IMG_IDEA);
   AddNewAction( CMD_MOPNEW, 'actMopNew', 'New', IMG_IDEA);
   AddNewAction( CMD_MOPEDIT, 'actMopEdit', 'Edit', IMG_IDEA);
   AddNewAction( CMD_MOPSAVE, 'actMopSave', 'Save', IMG_IDEA);
   AddNewAction( CMD_MOPCANCEL, 'actMopCancel', 'Cancel', IMG_IDEA);
   AddNewAction( CMD_FINALIZE, 'actFinalize', 'Finalize', IMG_IDEA);
   AddNewAction( CMD_MOPDELETE, 'actMopDelete', 'Delete', IMG_IDEA);
   AddNewAction( CMD_CUSTOMER, 'actCustomer', 'Customer', IMG_IDEA);
   AddNewAction( CMD_LINEITEM, 'actLineItem', 'Line Item', IMG_IDEA);
   AddNewAction( CMD_MESSAGE, 'actMessage', 'Message', IMG_IDEA);
   AddNewAction( CMD_PAYMENTS, 'actPayments', 'Payments', IMG_IDEA);
   AddNewAction( CMD_CUSTACTIVEINACTIVE, 'actCustActiveInactive', 'Inactive', IMG_CUST_ACTIVE);
   AddNewAction( CMD_LABELS, 'actLabels', 'Labels', IMG_IDEA);
   AddNewAction( CMD_ORDER_VIEWINVOICE, 'actViewInvoice', 'View Invoice', IMG_SEARCH);
   AddNewAction( CMD_NEW_ORDER, 'actNewOrder', 'New Order', IMG_NEW);
   AddNewAction( CMD_ORDER_EDIT_CUSTOMER, 'actOrderEditCustomer', 'Customers', IMG_CUST_DOUBLE );
   AddNewAction( CMD_ORDER_EDIT_MESSAGE, 'actOrderEditMessage', 'Message', IMG_PAGE);
   AddNewAction( CMD_ORDER_EDIT_LINEITEMS, 'actOrderEditLineItems', 'Line Items', IMG_PRODUCT);
   AddNewAction( CMD_ORDER_EDIT_MOP, 'actOrderEditMOP', 'Payments', IMG_TAKE_PAYMENT);
   AddNewAction( CMD_ORDER_EDIT_FEES, 'actOrderEditFees',  'Fees', IMG_EXPENSE);
   AddNewAction( CMD_ORDER_EDIT_FINALIZE, 'actOrderEditFinalize', 'Close Order', IMG_ORDER_FINALIZE );
   AddNewAction( CMD_ORDER_EDIT_PAYMENT, 'actOrderEditPayment', 'Take Payment', IMG_CREDIT);
   AddNewAction( CMD_ORDER_LOAD_NUM, 'actCtrl_Order_LoadNum', 'Load Order Number', IMG_EDIT);
   AddNewAction( CMD_VOID_PAYMENT, 'actVoidPayment', 'Void Payment', IMG_VOID);
   AddNewAction( CMD_ORDER_PAYMENT, 'actOrderPayment', 'Take Payment', IMG_TAKE_PAYMENT);
   AddNewAction( CMD_CUST_CANCEL_ORDER, 'actCustCancelOrder', 'Cancel', IMG_CANCEL);
   AddNewAction( CMD_CUST_UNCANCEL_ORDER, 'actCustUnCancelOrder', 'Un-Cancel', IMG_REDO_WHITE);
   AddNewAction( CMD_ORDER_RETURN, 'actOrderReturn', 'Create Return', IMG_REDO_BOX );
   AddNewAction( CMD_EXPENSE_EDIT_TYPES, 'actExpenseEditTypes', 'Types', IMG_EXP_TYPE);
   AddNewAction( CMD_EARNING_EDIT_TYPES, 'actEarningEditTypes', 'Types', IMG_EXPENSE);
   AddNewAction( CMD_ORDEREDIT_LINEITEM_BLANK, 'actOrdEditLIBlank', 'Blank', IMG_PAGE_BLANK );
   AddNewAction( CMD_ORDEREDIT_LINEITEM_PRODUCT, 'actOrdEditLIProduct', 'Product', IMG_PRODUCT);
   AddNewAction( CMD_ORDEREDIT_LINEITEM_BACKORDER, 'actOrdEditLIBO', 'Back Order', IMG_REDO_BOX );
   AddNewAction( CMD_ORDEREDIT_LINEITEM_DELETE, 'actOrdEditLIDel', 'Delete', IMG_DELETE );
   AddNewAction( CMD_BO_DELIVER, 'actBODeliver', 'BO Delivered', IMG_CUST_ACTIVE);
   AddNewAction( CMD_BO_NOTAVAIL, 'actBoNotAvail', 'BO Not Avail', IMG_REDO_BOX);
   AddNewAction( CMD_ESCROW_TAKEPAYMENT, 'actEscrowTakePayment', 'Use Escrow', IMG_TAKE_PAYMENT);
   AddNewAction( CMD_ESCROW_CASH, 'actEscrowCash', 'Return Cash', IMG_TAKE_PAYMENT);
   AddNewAction( CMD_ESCROW_CHECK, 'actEscrowCheck', 'Return Check', IMG_REDO_BOX);
   AddNewAction( CMD_ESCROW_ESCROW, 'actEscrowEscrow', 'Return Escrow', IMG_CREDIT);
   AddNewAction( CMD_PBO_RETURNED, 'actPboReturned', 'Return To OEM', IMG_PO_RETURN );
   AddNewAction( CMD_PBO_INVENTORY, 'actPboInventory', 'Re-Stock Product', IMG_PO_RESTOCK);
   AddNewAction( CMD_TAX_EDIT, 'actTaxClassEdit', 'Edit Rates', IMG_REPORT3  );
   AddNewAction( CMD_TAX_EDITCLASS, 'actEditTaxClass', 'Edit Group',  IMG_EXP_TYPE );
   AddNewAction( CMD_TAX_SETDEFAULT, 'actDefaultTaxClass', 'Set Defaults',  56 );
   AddNewAction( CMD_ACCOUNT_ESCROW, 'actAccountEscrow', 'Modify Escrow',  IMG_TAKE_PAYMENT );
   AddNewAction( CMD_PRINT_SETUP, 'actPrintSetup', 'Setup Printer',  IMG_TOOLS );
   AddNewAction( CMD_PRINT_PREVIEW, 'actPrintPreview', 'Preview Report',  IMG_SEARCH );
   AddNewAction( CMD_PRINT_PRINT, 'actPrintPrint', 'Print Report',  IMG_PRINT );
   AddNewAction( CMD_PREF_EMAIL_MAIN, 'actPrefEmailMain', 'Email Settings',  IMG_EMAIL );
   AddNewAction( CMD_PREF_EMAIL_ORDER, 'actPrefEmailOrder', 'Order Email Body',  IMG_CART );
   AddNewAction( CMD_PREF_EMAIL_RETURN, 'actPrefEmailReturn', 'Return Email Body',  IMG_PO_RETURN );
   AddNewAction( CMD_PRINT_LIST, 'actPrintList', 'Print List',  IMG_PRINT );
   AddNewAction( CMD_BROCHURE_LIST, 'actBrocureList', 'Email Message',  IMG_PAGE);
   AddNewAction( CMD_FIND_KEY, 'actFindKey', 'Find Key Local', IMG_KEYS );
   AddNewAction( CMD_FIND_KEY_WEB, 'actFindKeyWeb', 'Find Key Web', IMG_WEB );
   AddNewAction( CMD_REGISTER, 'actRegister', 'Register', IMG_REGISTER );
   AddNewAction( CMD_KEYMAKER_NEW_ORDER, 'actKeyNewOrder', 'New Order', IMG_REGISTER );
   AddNewAction( CMD_KEYMAKER_NEW_REGISTRATION, 'actKeyNewReg', 'Upgrade Registration', IMG_REGISTER );
   AddNewAction( CMD_KEYMAKER_EMAIL, 'actKeyEmail', 'Email Registration', IMG_EMAIL );
   AddNewAction( CMD_CONTINUE, 'actContinue', 'Continue', IMG_NAV_LAST );
   AddNewAction( CMD_CUST_EMAIL, 'actCustEmail', 'Email Customer', IMG_EMAIL2);
   AddNewAction( CMD_TAX_SET_ROUNDING, 'actTaxRounding', 'Tax Rounding', IMG_CASH );
	AddNewAction( CMD_CUST_EXPORT, 'actCustExport', 'Export', IMG_FILE );
end;

destructor tAvoActionList.Destroy;
begin
   // do wot you need to do
   //
   inherited Destroy;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tAvoActionList.AddNewAction( inActionType : integer; inName : string; inCaption : string; inImageIndex : integer ) : boolean;
var
   action : tAction;
begin
   result := true;
   action := tAction.Create( Self );
   action.OnExecute := HandleActionExecute;
   action.Tag := inActionType;
   action.Caption := inCaption;
   action.Name := inName;
   action.Enabled := true;
   action.ImageIndex := inImageIndex;
   self.AddAction(action);
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoActionList.HandleActionExecute(Sender: TObject);
begin
   // the action event has fired, so we want to fire the response back to the form where it can be processed.
   // we pass back the action type, so the method that created this object knows what button was pressed.
   // the .tag contains the action type as we're not using a custom wrapper.
   with Sender as tAction do
   begin
      if Assigned(fActionEvent) then
         fActionEvent(Self, tAction(Sender).Tag);
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tAvoActionList.AssignAction(inType: integer): tAction;
var
   x : integer;
begin
   result := nil;
   for x := 0 to Self.ActionCount -1 do
      if Self.Actions[ x ].Tag = inType then
         result := Self.Actions[x] as tAction;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

end.

{
NOTE: it is very important that any time a ribbon tab is clicked that the appropriate dock_panel is created and/or shown.
That way you can't be editing something, then click order, and can't get back to what you
were previously doing. The selection of any particular thing must be removed and placed into a showmodal.

tActionManagerList Items: - these are LARGE items for 50x50 images for the main ribbon buttons

act_Order_Cancel
act_Order_UnCancel
act_Order_ViewInvoice
act_Order_PrintInvoice
act_Order_EmailInvoice
act_Order_ChangeOrderCampaign

MAIN BUTTONS:
===================
actCtrl_Main_Help
actCtrl_Main_Forums
actCtrl_Main_Contactus
actCtrl_Main_Settings
actCtrl_Main_CheckUpdates
actCtrl_Main_Register
actCtrl_Main_Close
actCtrl_Main_Home
actCtrl_Main_Blog

ORDER:
===================
actCtrl_Order_List
actCtrl_Order_New
actCtrl_Order_New_Return
actCtrl_Order_Load
actCtrl_Order_LoadNum
actCtrl_Order_ViewInvoice
actCtrl_Order_PrintInvoice
actCtrl_Order_EmailInvoice
actCtrl_Order_EmailAllInvoicesInCycle
actCtrl_Order_Reports
actCtrl_Order_Payment
actCtrl_Order_VoidPayment
act_Ctrl_Order_BackOrder
actCtrl_Order_Help
actCtrl_Order_Finalize
actCtrl_Cancel
act_Order_TakePayment
act_Order_Cust_TakePayment
act_Order_Cust_NSFPayment
act_Order_Cust_VoidPayment
act_Order_Cancel
act_Order_UnCancel
act_Order_SaveInvoice
act_Order_PrintAllCycleInvoices
act_Order_EmailAllCycleInvoices
act_Order_CustProd CMD_ORDER_CUSTPROD

CUSTOMER:
===================
actCtrl_Cust_List
actCtrl_Cust_New
actCtrl_Cust_Edit
actCtrl_Cust_View
actCtrl_Cust_ViewAccount
actCtrl_Cust_Activity
actCtrl_Cust_Email
actCtrl_Cust_Print
actCtrl_Cust_Help
actCtrl_Cust_Reports
actCtrl_Cust_NewOrder
actCtrl_Cust_NewReturn
actCtrl_Cust_Payment
actCtrl_Cust_BackOrder
actCtrl_Cust_Notes CMD_CUSTNOTES
actCtrl_Cust_OrdProd CMD_CUST_ORDPROD

PRODUCT:
===================
actCtrl_Product_List
actCtrl_Product_New
actCtrl_Product_Edit
actCtrl_Product_Help
actCtrl_Product_Reports
actCtrl_Product_Print
actCtrl_Product_Delete
actCtrl_Product_View

CYCLE:
===================
actCtrl_Cycle_List
actCtrl_Cycle_New
actCtrl_Cycle_Edit
actCtrl_Cycle_SetActive
actCtrl_Cycle_Generate
actCtrl_Cycle_Reports
actCtrl_Cycle_View
actCtrl_Cycle_ViewOrders
actCtrl_Cycle_Help

EXPENSES:
===================
-from the list area-
actCtrl_ExpenseList_New
actCtrl_ExpenseList_Edit
actCtrl_ExpenseList_LoadByCycle
actCtrl_ExpenseList_View
actCtrl_ExpenseList_Print
actCtrl_ExpenseList_Help
actCtrl_Expense_Reports
-within the editor-
actCtrl_Expense_New
actCtrl_Expense_Edit
actCtrl_Expense_Delete
actCtrl_Expense_QuickAdd
actCtrl_Expense_EditTypes

EARNINGS:
===================
-from the list area-
actCtrl_EarningList_New
actCtrl_EarningList_Edit
actCtrl_EarningList_LoadByCycle
actCtrl_EarningList_View
actCtrl_EarningList_Print
actCtrl_EarningList_Help
actCtrl_Earning_Reports
-within the editor-
actCtrl_Earning_New
actCtrl_Earning_Edit
actCtrl_Earning_Delete
actCtrl_Earning_QuickAdd
actCtrl_Earning_EditTypes

BROCHURES:
===================
actCtrl_Brochure_List
actCtrl_Brochure_New
actCtrl_Brochure_Edit
actCtrl_Brochure_Delete
actCtrl_Brochure_View
actCtrl_Brochure_Reports
actCtrl_Brochure_Help

EMAIL
===================
actCtrl_Email_Send
actCtrl_Email_SendAll
actCtrl_Email_Delete
actCtrl_Email_DeleteAll
actCtrl_Email_ReQueue
actCtrl_Email_Setting
actCtrl_Email_Help
actCtrl_Email_Clean
actCtrl_Email_Settings
actCtrl_Email_RequeueAll

ACCOUNTING:
===================
actCtrl_Account_Escrow
actCtrl_Account_Transaction
actCtrl_Accounting_Help

REPORTS: [ Top Level Ribbon Reports ]
===================
actCtrl_Reports_Customer
actCtrl_Reports_Product
actCtrl_Reports_Cycle
actCtrl_Reports_Org
actCtrl_Reports_Accounting
actCtrl_Reports_Order
actCtrl_Report_Earning
actCtrl_Report_Expense
actCtrl_Report_Help

REPORTS: [ Sub-Level Ribbon Dropdown Reports ]
===================
act_Report_CustomerList
act_Report_CustomerTopCustByOrder
act_Report_CustomerTopCustByMoney
act_Report_OrderList
act_Report_Earning_Types,
act_Report_Earning_EarningByCycle
act_Report_Earning_ListByCycle
act_Report_Expense_Type
act_Report_Expense_ByCycle
act_Report_Expense_ListByCycle
act_Report_EarningVsExpenseByCycle
act_Report_Order_Labels
act_Report_Customer_SingleCustomer
act_Report_Product_SingleProduct
act_Report_Product_QuantityOnHand
act_Report_Customer_OrderHistory
act_Report_Order_BackOrderList
act_Report_Accounting_FeesCollectedByCycle
act_Report_Accounting_ShippingCollectedByCycle
act_Report_Accounting_TaxesCollectedByCycle
act_Report_Accounting_TaxExemptByCycle
act_Report_Accounting_DepositSlipByCycle
act_Report_Accounting_VoidNSFByCycle
act_Report_Accounting_ReturnsByCycle
act_Report_Accounting_TransactionLogByCycle
act_Report_Customer_OrderTransactionHistory
act_Report_Product_ProductList
act_Report_Cycle_CycleListByOrg
act_Report_Customer_Labels
act_Report_ORder_OrderProductList
act_Report_Order_ProductReturnList
act_Report_Accounting_ShippingReturned
act_Report_Accounting_FeesReturned
act_Report_Customer_OustandingBalance
act_Report_Accounting_CycleBreakDown
act_Report_CustomerEscrowBalance

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tActionList items: - these are SMALL items for 25x25 that fit into sub menus and so forth.

ORDER SMALL BUTTONS:
===================
act_Order_Report_ListByCycle
act_Order_Report_OrderPerCycleYear
act_Order_VoidPayment
act_Order_TakePayment
act_Order_EmailSingleInvoice    CMD_EMAIL_SINGLEINVOICE
act_Order_EmailCycleInvoices     CMD_EMAIL_ALL_CYCLE_INVOICES

CUSTOMER SMALL BUTTONS:
===================
act_Cust_Report_CustomerList
act_Cust_Report_ByOrdersPlaced
act_Cust_Report_ByInvoiceAmount

PRODUCT SMALL BUTTONS:
===================
act_Product_Report_OnHand
act_Product_Report_ProductCost
act_Product_Report_OrderProduct

SETTINGS SMALL BUTTONS:
===================
act_Settings_Representative
act_Settings_Tax
act_Settings_Orgs
act_Settings_Invoice
act_settings_Registration
act_settings_General
act_settings_ExpenseTypes
act_settings_EarningTypes
act_settings_Email
act_settings_Fees

SUPPORT:
===================
act_Support_AvoBaseWebsite
act_Support_AvoBaseForums
act_Support_AvoBaseForums_General
act_Support_AvoBaseForums_FAQ
act_Support_AvoBaseForums_Tech
act_Support_SendFeedBack
act_Support_CheckUpdates
act_Support_AboutAvoBase

CYCLES:
===================
act_Cycle_Report_Finalization
act_Cycle_Report_Summary

BROCHURES:
===================
act_Brochure_Report_Labels
act_Brochure_Report_BrochureList

//******************************************************************//
//******************************************************************//
//******************************************************************//


********* REPORTS ********


ORDER:
===================

CUSTOMER:
===================

PRODUCT:
===================

CYCLE:
===================

EXPENSES:
===================

EARNINGS:
===================

EMAIL
===================

TRANSACTIONS
===================

MISCELLANEOUS
===================


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}





