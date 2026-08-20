 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_ViewAccountFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_percentformunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   MasterData_TransactionListUnit,
   AvoBase_ToolBarUnit,
   toolbox_ordertoolboxunit,
   toolbox_PreferenceToolBoxUnit,
   ToolBox_EscrowToolBoxUnit,
   Report_Customer_OrderTransactionHistoryFormUnit,
   avobase_dialogformunit,
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
   tCustomer_ViewAccount_Types = (
      CustViewAcc_Close,
      CustViewAcc_Print,
      CustViewAcc_View,
      CustViewAcc_Load,
      CustViewAcc_Void,
      CustViewAcc_Pay,
      CustViewAcc_Return);

type
  TCustomer_AccountViewForm = class(TAvoBase_BaseForm_Menu)
      VIEWGRID_DOCK_PANEL: TPanel;
      BASE_NAVBAR_PANEL: TPanel;
      BASE_NAVBAR_DOCK_PANEL: TPanel;
      addresGroupBox: TGroupBox;
      addr1Label: TLabel;
      db_totorders: TLabel;
      Label2: TLabel;
      db_returns: TLabel;
      Label4: TLabel;
      db_cancel: TLabel;
    DB_AmountVoid: TLabel;
    DB_AmountMOP: TLabel;
      db_totowed: TLabel;
      SalesTaxLabel: TLabel;
      InvoiceTotalLabel: TLabel;
      PaymentsLabel: TLabel;
      AmountDueLabel: TLabel;
    GroupBox1: TGroupBox;
    SortViewComboBox: TComboBox;
    sortLabel: TLabel;
    Label1: TLabel;
    db_AmountReturn: TLabel;
    Label3: TLabel;
    DB_AmountEscrow: TLabel;
    Label5: TLabel;
    DB_AmountTransCredit: TLabel;
    Label7: TLabel;
    DB_AmountTransDebit: TLabel;
    db_AmountOrder: TLabel;
    procedure SortViewComboBoxChange(Sender: TObject);
   private
      fCustQuery : tMasterData_BaseDataClass;
   	custOrderDetailListGrid : tAvoBaseDBGrid;
      custOrderDetailListQuery : tMasterDataCustomerAccountList;
      dbNavTool : tAvoBaseDBNavigationTool;
      //
      fCustID : string;
      fOrderID : string;
      fMOPID : string;
      fCloseAction : tCustomer_ViewAccount_Types;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure StartUpForm();
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      function fGetCustID : string;
   public
      procedure PrintList();
      property OrderID : string read fOrderID;
      property CustID : string read fGetCustID;
      property MOPID : string read fMOPID;
      property OnCloseAction : tCustomer_ViewAccount_Types read fCloseAction;
   	procedure StatBarUpdate();
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TCustomer_AccountViewForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inQuery: tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   PercentForm_Create('Generating Transactions - One Moment Please...', 0, 0);
   fCustQuery := inQuery;
   //
   custOrderDetailListQuery := tMasterDataCustomerAccountList.Create( masterData, inQuery.ID);
   custorderdetaillistquery.open;
   //
   custOrderDetailListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, custOrderDetailListQuery, 'FNAME' );
   custOrderDetailListGrid.Clear;
   //
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('TDATE'), 'TRANS DATE', 80, clBlue, [], taRightJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('TRANSTYPE'), 'TRANS TYPE', 90, clRed, [], taLeftJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('ORDNUM'), 'ORDER #', 60, clBlack, [], taLeftJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('TRANSTAT'), 'TRAN STATUS', 150, clGreen, [], taLeftJustify);
   custOrderDetailListGrid.Add(custOrderDetailListQuery.FieldByName('TAMT'), 'AMOUNT', 120, clRed, [], taRightJustify);
   //
   custOrderDetailListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, custOrderDetailListQuery);
   //
  //
	StartUpForm();
   StatBarUpdate();
   PercentForm_Free();
end;

function TCustomer_AccountViewForm.fGetCustID: string;
begin
   result := fCustQuery.GetFieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomer_AccountViewForm.CloseForm;
begin
	FreeAndNil(custOrderDetailListGrid);
   FreeAndNil(dbNavTool);
   freeAndNil(custOrderDetailListQuery);
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomer_AccountViewForm.StartUpForm;
var
   fEscrow : currency;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
   CreateButtonSep();
   CreateButton( CMD_PRINT_LIST );
   CreateButtonSep();
   CreateButton( CMD_ORDER_VIEWINVOICE );
   CreateButtonSep();
   CreateButton( CMD_VOID_PAYMENT );
   CreateButton( CMD_ORDER_PAYMENT );
   CreateButtonSep();
   CreateButton( CMD_ORDER_RETURN );
   CreateButton( CMD_ORDER_LOAD );
   //
   if ( SortViewComboBox.ItemIndex = 0 ) then
      custOrderDetailListQuery.Update( 'DESC' )
   else
      custOrderDetailListQuery.Update( '' );
   //
   db_totorders.Caption := IntToStr( custOrderDetailListQuery.TotalOrders );
	db_returns.Caption := IntToStr( custOrderDetailListQuery.TotalReturns );
	db_cancel.Caption := IntToStr( custOrderDetailListQuery.TotalCancels );
   //
   db_AmountOrder.Caption := Pref_GetCashSymbol + FormatCurrency(custOrderDetailListQuery.AmountOrder);
   DB_AmountMOP.Caption := Pref_GetCashSymbol + FormatCurrency(custOrderDetailListQuery.AmountMOP);
   db_AmountReturn.Caption := Pref_GetCashSymbol + FormatCurrency(custOrderDetailListQuery.AmountReturn);
   DB_AmountTransDebit.Caption := Pref_GetCashSymbol + FormatCurrency( custOrderDetailListQuery.AmountTransDebit );
   DB_AmountTransCredit.Caption := Pref_GetCashSymbol + FormatCurrency( custOrderDetailListQuery.AmountTransCredit );
   DB_AmountVoid.Caption := Pref_GetCashSymbol + FormatCurrency(custOrderDetailListQuery.AmountVoid);
   DB_AmountEscrow.Caption := Pref_GetCashSymbol + FormatCurrency( custOrderDetailListQuery.AmountEscrow );
   //
   if ( custOrderDetailListQuery.AmountDue > 0 ) then
   begin
      AmountDueLabel.caption := 'OUTSTANDING BALANCE:';
      AmountDueLabel.Color := clRed;
      db_totowed.Caption := Pref_GetCashSymbol + FormatCurrency(custOrderDetailListQuery.AmountDue);
   end;
   if ( custOrderDetailListQuery.AmountDue <= 0 ) then
   begin
      AmountDueLabel.caption := 'NO OUTSTANDING BALANCE:';
      AmountDueLabel.Color := clBlack;
      db_totowed.Caption := Pref_GetCashSymbol + FormatCurrency(0.00);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomer_AccountViewForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_CLOSE :
      begin
         fCloseAction := CustViewAcc_Close;
         CloseForm();
      end;
      CMD_ORDER_LOAD:
      begin
         fOrderID := custOrderDetailListQuery.FieldByName('OID').AsString;
         fCloseAction := CustViewAcc_Load;
         Close();
      end;
      CMD_ORDER_VIEWINVOICE :
      begin
         fOrderID := custOrderDetailListQuery.FieldByName('OID').AsString;
         fCloseAction := CustViewAcc_View;
         Close();
      end;
      CMD_VOID_PAYMENT:
      begin
         fMOPID := custOrderDetailListQuery.FieldByName('PID').AsString;
         fCloseAction := CustViewAcc_Void;
         Close();
      end;
      CMD_ORDER_PAYMENT:
      begin
         fOrderID := custOrderDetailListQuery.FieldByName('OID').AsString;
         fCloseAction := CustViewAcc_Pay;
         Close();
      end;
      CMD_ORDER_RETURN:
      begin
         fOrderID := custOrderDetailListQuery.FieldByName('OID').AsString;
         fCloseAction := CustViewAcc_Return;
         Close();
      end;
      CMD_PRINT_LIST: PrintList();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomer_AccountViewForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_ORDER_LOAD : enabled := (custOrderDetailListQuery.FieldByName('TTYPE').AsInteger = 1) AND
            (custOrderDetailListQuery.FieldByName('TSTAT').AsInteger = integer(OrderStatusOpen));
         //
         CMD_ORDER_PAYMENT: enabled := (custOrderDetailListQuery.FieldByName('TTYPE').AsInteger = 1) AND
            (custOrderDetailListQuery.FieldByName('TSTAT').AsInteger = integer(OrderStatusOpen));
         //
         CMD_ORDER_VIEWINVOICE : enabled := (custOrderDetailListQuery.FieldByName('TTYPE').AsInteger = 1) AND
            (custOrderDetailListQuery.FieldByName('TSTAT').AsInteger <> integer(OrderStatusCancelled));
         //
         CMD_VOID_PAYMENT  : enabled := (custOrderDetailListQuery.FieldByName('TTYPE').AsInteger = 3) AND
            (custOrderDetailListQuery.FieldByName('TSTAT').AsInteger = integer(OrderStatusOpen));
         //
         CMD_ORDER_RETURN: enabled := (custOrderDetailListQuery.FieldByName('TTYPE').AsInteger = 1) AND
            ( Order_GetOrderStatusByOrderID( custOrderDetailListQuery.FieldByName('OID').AsString) = OrderStatusClosed );
         CMD_CLOSE : enabled := true;
      end;

//         'TSTAT INTEGER, ' + // transaction order status - ( 1 = open, 2 = closed , 3 = cancelled )

   // overall, if there isn't anything, then fwak that shat
{
   if (custOrderDetailListQuery.RecordCount = 0) then
      enabled := false;
}
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomer_AccountViewForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomer_AccountViewForm.SortViewComboBoxChange( Sender: TObject);
begin
   if ( SortViewComboBox.ItemIndex = 0 ) then
      custOrderDetailListQuery.Update( 'DESC' )
   else
      custOrderDetailListQuery.Update( '' );
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomer_AccountViewForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(custOrderDetailListQuery.RecNo) + ' of ' + IntToStr(custOrderDetailListQuery.RecordCount);
end;

procedure TCustomer_AccountViewForm.PrintList;
var
   rpt_Customer_OrderTransactionHistory : TReport_Customer_OrderTransactionHistory;
   errMsg : string;
begin
   rpt_Customer_OrderTransactionHistory := TReport_Customer_OrderTransactionHistory.Create( Application );
   // Setup Options
   rpt_Customer_OrderTransactionHistory.SetOptions( CustID );
   // Check for Errors
   errMsg := rpt_Customer_OrderTransactionHistory.CanPrint;
   if ( errMsg = '' ) then
   begin
      // Display it
      rpt_Customer_OrderTransactionHistory.QReport.Preview();
   end else
      AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
   // Free it
   if (rpt_Customer_OrderTransactionHistory <> NIL) then
      FreeAndNil(rpt_Customer_OrderTransactionHistory);
end;


end.
