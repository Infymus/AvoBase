 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit MasterData_TransactionQueryUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  recordstructureunit,
  masterdataunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  Order_InvoiceObjectUnit,
  Return_InvoiceObjectUnit,
  toolbox_escrowtoolboxunit,
  encryptunit,
  ErrorResultUnit;

type
   SQLAreas = (
      ByCustomer,
      ByPeriod,
      None
      );
   QueryAreas = (
      OrdTotal,
      OrdAmount,
      RetTotal,
      RetAmount,
      RevAmount,
      CancelTotal,
      CancelAmount
      );
   TranStatTypes = (
      Open,
      Closed,
      Cancelled,
      Paid,
      CreditCard,
      Delinquent,
      CashPayment,
      Debit,
      Credit,
      Check,
      CashierCheck,
      MoneyOrder,
      DebitCard,
      EscrowCreated,
      EscrowUsed,
      PayPal
      );

type
   tMasterDataTransactionQuery = class(tQuery)
   private
      fSQLArea : SQLAreas;
      fStartYear : integer;
      fEndYear : integer;
      fStartCycleNumber : integer;
      fEndCycleNumber : integer;
      fOrgID : string;
      fCustID : string;
      //
      fAmount_OrderAmountTotal : currency; // Total of ALL Order Sums
      fAmount_ReturnAmountTotal : currency; // Total of alL Return Sums
      fAmount_TransCreditTotal : currency; // Total of all Transaction Credits
      fAmount_TransDebitTotal : currency; // Total of all Transaction Debits
      fAmount_EscrowAmountTotal : currency; // Total Escrow Amount (by customer)
      fAmount_ReversalAmountTotal : currency; // Total of alL Reversal Amounts
      fAmount_MOPAmountTotal : currency; // Total of all Payments made
      //
      fCount_OrderTotal : integer;
      fCount_ReturnTotal : integer;
      fCount_CancelTotal : integer;
      //
      orderInvoice : tInvoice;
      returnInvoice : tReturnInvoice;
      //
      fMasterData : tMasterData;
      fTransQuery : tQuery;
      //
      procedure HandleCalculated(DataSet: TDataSet);
      //
      function SQL_GetOrderCountByAreaByType( inOrderType : tOrderTypes; inStatusType : tOrderStatusTypes ) : string;
      function SQL_GetSQLByArea( inQueryArea : QueryAreas ) : string;
      //
      procedure GetTotalOrders();
      procedure GetTotalReturns();
      procedure GetTotalCancels();
      //
      procedure GetAmountOrderAmountTotal();
      procedure GetAmountReversalTotal();
   public
      procedure Load();
      //
      property Amount_OrderAmount : currency read fAmount_OrderAmountTotal;
      property Amount_ReturnAmountTotal : currency read fAmount_ReturnAmountTotal;
      property Amount_TransCreditTotal : currency read fAmount_TransCreditTotal;
      property Amount_TransDebitTotal : currency read fAmount_TransDebitTotal;
      property Amount_EscrowAmountTotal : currency read fAmount_EscrowAmountTotal;
      property Amount_ReversalAmountTotal : currency read fAmount_ReversalAmountTotal;
      property Amount_MOPAmountTotal : currency read fAmount_MOPAmountTotal;
      //
      property StartYear : integer read fStartYear write fStartyear;
      property EndYear : integer read fEndYear write fEndYear;
      property StartCycleNumber : integer read fStartCycleNumber write fStartCycleNumber;
      property EndCycleNumber : integer read fEndCycleNumber write fEndCycleNumber;
      property OrgID : string read fOrgID write fOrgID;
      property CustID : string read fCustID write fCustID;
      property Area : SQLAreas read fSQLArea write fSQLArea;
      //
      constructor Create( inMasterData : tMasterData); virtual;
      destructor destroy; overload;
   end;

implementation

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

constructor tMasterDataTransactionQuery.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
begin
   inherited create( nil );
   //
   fMasterData := inMasterData;
   //
   self.SessionName := fMasterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;

   // First get rid of it. Just so that we never have to worry about it.
   masterData.RemoveTable( table_report );

   // First, build the table if it doesn't exist
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'ID VARCHAR(40), ' + // simple ID
         'OID VARCHAR(40), ' + // order ID
         'ORDNUM VARCHAR(20), ' + // order number
         'PID  VARCHAR(40), ' + // payment ID
         'VID VARCHAR(40), ' + // void ID
         'TDATE DATE, ' + // transaction date
         'TVALUE VARCHAR(80), ' + // check #, etc
         'TTYPE INTEGER, ' + // transaction type -
         'TSTAT INTEGER, ' + // transaction order status - ( 1 = open, 2 = closed , 3 = cancelled )
         'TAMT MONEY', // transaction amount
         {----------------}
         'ID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
   end;
   //
   fTransQuery := fMasterData.GetQuery();
   fTransQuery.SQL.Text := 'SELECT * FROM ' + fMasterData.GetTable_Report;
   fTransQuery.Open();

   // Invoices
   returnInvoice := tReturnInvoice.Create( InvoiceTypeReport, NIL, NIL );
   orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL );

   // Initialize
   fAmount_OrderAmountTotal := 0;
   fAmount_ReturnAmountTotal := 0;
   fAmount_TransCreditTotal := 0;
   fAmount_TransDebitTotal := 0;
   fAmount_EscrowAmountTotal := 0;
   fAmount_ReversalAmountTotal := 0;
   fAmount_MOPAmountTotal := 0;
   //
   fStartYear := 0;
   fEndYear := 0;
   fStartCycleNumber := 0;
   fEndCycleNumber := 0;
   fOrgID := '';
   fCustID := '';
   fSQLArea := SQLAreas.None;

   //
   fCount_OrderTotal := 0;
   fCount_ReturnTotal := 0;
   fCount_CancelTotal := 0;
end;

destructor tMasterDataTransactionQuery.destroy;
begin
   fTransQuery.Close();
   //
   FreeAndNil(fTransQuery);
   FreeAndNil(orderINvoice);
   FreeAndNil(returnInvoice);
   //
   inherited;
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

function tMasterDataTransactionQuery.SQL_GetOrderCountByAreaByType( inOrderType : tOrderTypes; inStatusType : tOrderStatusTypes ) : string;
var
   sqlText : string;
   sqlWhere : string;
   cnt : integer;
begin
   sqlText := '';
   sqlWhere := '';
   cnt := 0;
   //
   case fSQLArea of
      ByCustomer:
      begin
         sqlText := 'SELECT COUNT(*) AS TOT FROM ' + fMasterData.GetTable_Order +
            ' WHERE C_STID = ' + fmasterData.WrapDBID( fCustID ) +
            ' AND O_TYPE = ' + IntToStr(integer( inOrderType )) +
            ' AND STATUS = ' + IntToSTr(integer( inStatusType ));
      end;
      // ------------------------------------------------------------------------
      ByPeriod:
      begin
         sqlText := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order + ' O' +
            ' INNER JOIN ' + masterData.GetTable_Cycle + ' C ON C.ID = O.C_ID';
         sqlWhere := '';
         if ( fStartYear < fEndYear ) then
         begin
            sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( fStartYear ) + ' ) ' +
               ' AND (NUM BETWEEN ' + IntToStr( fStartCycleNumber ) + ' AND 30) ' +
               ' AND (O_TYPE = ' + IntToStr(integer( inOrderType )) + ') ' +
               ' AND (ORG_ID = ' + masterData.WrapDBID( fOrgID ) + ') ' +
               ' AND (STATUS = ' + IntToStr(integer( inStatusType )) + '))';
            //
            for cnt := fStartYear + 1 to fEndYear - 1 do
            begin
               sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( cnt ) + ' ) ' +
               ' AND (NUM BETWEEN 1 AND 30) ' +
               ' AND (O_TYPE = ' + IntToStr(integer( inOrderType )) + ') ' +
               ' AND (ORG_ID = ' + masterData.WrapDBID( fOrgID ) + ') ' +
               ' AND (STATUS = ' + IntToStr(integer( inStatusType )) + '))';
            end;
            //
            sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( fEndYear ) + ' ) ' +
               ' AND (NUM BETWEEN ' + IntToStr( fStartCycleNumber ) + ' AND ' + IntToStr( fEndCycleNumber ) + ' ) ' +
               ' AND (O_TYPE = ' + IntToStr(integer( inOrderType )) + ') ' +
               ' AND (ORG_ID = ' + masterData.WrapDBID( fOrgID ) + ') ' +
               ' AND (STATUS = ' + IntToStr(integer( inStatusType )) + '))';
         end;
         if ( fStartYear = fEndYear ) then
         begin
            sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( fStartYear ) + ' ) ' +
               ' AND (NUM BETWEEN ' + IntToStr( fStartCycleNumber ) + ' AND ' + IntToStr( fEndCycleNumber ) + ' ) ' +
               ' AND (O_TYPE = ' + IntToStr(integer( inOrderType )) + ') ' +
               ' AND (ORG_ID = ' + masterData.WrapDBID( fOrgID ) + ') ' +
               ' AND (STATUS = ' + IntToSTr(integer( inStatusType )) + '))';
         end;
         sqlText := sqlText + sqlWhere;
      end;
   end;
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

function tMasterDataTransactionQuery.SQL_GetSQLByArea( inQueryArea : QueryAreas ) : string;
var
   sqlText : string;
   sqlWhere : string;
   cnt : integer;
begin
   sqlText := '';
   sqlWhere := '';
   cnt := 0;
   //
   case inQueryArea of
      // ********************************************************************************
      OrdAmount:
      begin
         case fSQLArea of
            ByCustomer:
            begin
               sqlText := 'SELECT * FROM ' + MasterData.GetTable_Order +
                  ' WHERE C_STID = ' + masterData.WrapDBID( fCustID );
            end;
            // ------------------------------------------------------------------------
            ByPeriod:
            begin
               sqlText := 'SELECT O.* FROM ' + masterData.GetTable_Order + ' O' +
                  ' INNER JOIN ' + masterData.GetTable_Cycle + ' C ON C.ID = O.C_ID';
               sqlWhere := '';
               if ( fStartYear < fEndYear ) then
               begin
                  sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( fStartYear ) + ' ) ' +
                     ' AND (NUM BETWEEN ' + IntToStr( fStartCycleNumber ) + ' AND 30 ) ' +
                     ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
                  //
                  for cnt := fStartYear + 1 to fEndYear - 1 do
                  begin
                     sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( cnt ) + ' ) ' +
                     ' AND (NUM BETWEEN 1 AND 30 ) ' +
                     ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
                  end;
                  //
                  sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( fEndYear ) + ' ) ' +
                     ' AND ( NUM BETWEEN ' + IntToStr( fStartCycleNumber ) + ' AND ' + IntToStr( fEndCycleNumber ) + ' ) ' +
                     ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
               end;
               if ( fStartYear = fEndYear ) then
               begin
                  sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( fStartYear ) + ' ) ' +
                     ' AND (NUM BETWEEN ' + IntToStr( fStartCycleNumber ) + ' AND ' + IntToStr( fEndCycleNumber ) + ' ) ' +
                     ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
               end;
               sqlText := sqlText + sqlWhere;
            end;
         end;
      end;
      // ********************************************************************************
      RevAmount:
      begin
         case fSQLArea of
            ByCustomer:
            begin
               sqlText := 'SELECT * FROM ' + MasterData.GetTable_Reversal +
                  ' WHERE C_ID = ' + masterData.WrapDBID( fCustID );
            end;
            // ------------------------------------------------------------------------
            ByPeriod:
            begin
            end;
         end;
      end;
      // ********************************************************************************
      // ********************************************************************************
      // ********************************************************************************
      // ********************************************************************************
      // ********************************************************************************
      // ********************************************************************************
{
      RetTotal:
      begin
         case fSQLArea of
            ByCustomer:
            begin
            end;
            // ------------------------------------------------------------------------
            ByPeriod:
            begin
            end;
         end;
      end;
}
      // ********************************************************************************
   end;
   //
   result := sqlText;
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tMasterDataTransactionQuery.GetTotalOrders();
var
   fQuery : tQuery;
begin
   fQuery := fMasterData.GetQuery();
   //
   fQuery.SQL.Text := SQL_GetOrderCountByAreaByType( tOrderTypes.OrdTypeOrder, tOrderStatusTypes.OrderStatusClosed );

   fQuery.Open();
   fCount_OrderTotal := fQuery.FieldByName('TOT').AsInteger;
   //
   fQuery.Close();
   FreeAndNil(fQuery);
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tMasterDataTransactionQuery.GetTotalReturns();
var
   fQuery : tQuery;
begin
   fQuery := fMasterData.GetQuery();
   //
   fQuery.SQL.Text := SQL_GetOrderCountByAreaByType( tOrderTypes.OrdTypeReturn, tOrderStatusTypes.OrderStatusClosed );
   fQuery.Open();
   fCount_ReturnTotal := fQuery.FieldByName('TOT').AsInteger;
   //
   fQuery.Close();
   FreeAndNil(fQuery);
end;


// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tMasterDataTransactionQuery.GetTotalCancels();
var
   fQuery : tQuery;
begin
   fQuery := fMasterData.GetQuery();
   //
   fQuery.SQL.Text := SQL_GetOrderCountByAreaByType( tOrderTypes.OrdTypeOrder, tOrderStatusTypes.OrderStatusCancelled );
   fQuery.Open();
   fCount_CancelTotal := fQuery.FieldByName('TOT').AsInteger;
   //
   fQuery.Close();
   FreeAndNil(fQuery);
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tMasterDataTransactionQuery.GetAmountOrderAmountTotal();
var
   fQuery : tQuery;
begin
   fQuery := fMasterData.GetQuery();
   //
   fQuery.SQL.Text := SQL_GetSQLByArea( QueryAreas.OrdAmount );
   fQuery.Open();
   //
   if ( fQuery.RecordCount <> 0) then
   repeat
      fTransQuery.Append();
      fTransQuery.FieldByName('ID').AsString := fmasterData.NewDBGuid;
      fTransQuery.FieldByName('OID').AsString := fQuery.FieldByName('ID').AsString;
      fTransQuery.FieldByName('ORDNUM').AsString := fQuery.FieldByName('ONUM').AsString;
      fTransQuery.FieldByName('TDATE').AsDateTime := fQuery.FieldByName('ODATE').AsDateTime;
      case fQuery.FieldByName('STATUS').AsInteger of
         integer(tOrderStatusTypes.OrderStatusOpen) : fTransQuery.FieldByname('TSTAT').AsInteger := integer(TranStatTypes.Open);
         integer(tOrderStatusTypes.OrderStatusClosed) : fTransQuery.FieldByname('TSTAT').AsInteger := integer(TranStatTypes.Closed);
         integer(tOrderStatusTypes.OrderStatusCancelled) : fTransQuery.FieldByname('TSTAT').AsInteger := integer(TranStatTypes.Cancelled);
         integer(tOrderStatusTypes.OrderStatusDelinquent) : fTransQuery.FieldByname('TSTAT').AsInteger := integer(TranStatTypes.Delinquent);
      end;
      case fQuery.FieldByName('O_TYPE').AsInteger of
         integer(tOrderTypes.OrdTypeOrder):
         begin
            orderInvoice.Load( fQuery.FieldByName('ID').AsString);
            //
            fTransQuery.FieldByName('TAMT').AsCurrency := orderInvoice.Amount_Total;
            fAmount_OrderAmountTotal := fAmount_OrderAmountTotal + orderInvoice.Amount_Total;
            self.FieldByName('TTYPE').AsInteger := 1;
         end;
         integer(tOrderTypes.OrdTypeReturn):
         begin
            returnInvoice.Load( fQuery.FieldByName('ID').AsString);
            //
            fTransQuery.FieldByName('TAMT').AsCurrency := returnInvoice.Amount_TotalRefund;
            fAmount_ReturnAmountTotal := fAmount_ReturnAmountTotal + returnInvoice.Amount_TotalRefund;
            fTransQuery.FieldByName('TTYPE').AsInteger := 2;
         end;
      end;
      fTransQuery.Post();
      fQuery.Next();
   until fQuery.EOF;
   //
   fQuery.Close();
   FreeAndNil(fQuery);
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tMasterDataTransactionQuery.GetAmountReversalTotal;
var
   fQuery : tQuery;
begin
   fQuery := fMasterData.GetQuery();
   //
   fQuery.SQL.Text := SQL_GetSQLByArea( QueryAreas.RevAmount );
   fQuery.Open();
   //
   if ( fQuery.RecordCount <> 0) then
   repeat
      //
      //

      fQuery.Next();
   until fQuery.EOF;
   //
   fQuery.Close();
   FreeAndNil(fQuery);
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tMasterDataTransactionQuery.HandleCalculated(DataSet: TDataSet);
var
   retVal : string;
begin
   Case Self.FieldByname('TTYPE').AsInteger of
      1 : DataSet.FieldByName('TRANSTYPE').Value := 'Order';
      2 : DataSet.FieldByName('TRANSTYPE').Value := 'Return';
      3 : DataSet.FieldByName('TRANSTYPE').Value := 'Payment';
      4 : DataSet.FieldByName('TRANSTYPE').Value := 'Void Payment';
      5 : DataSet.FieldByName('TRANSTYPE').Value := 'Credited';
      6 : DataSet.FieldByName('TRANSTYPE').Value := 'Debited';
   end;
   // The Transaction Status
   Case Self.FieldByname('TSTAT').AsInteger of
      integer(TranStatTypes.Open) : retVal := 'Open';
      integer(TranStatTypes.Closed) : retVal := 'Closed';
      integer(TranStatTypes.Cancelled) : retVal := 'Cancelled';
      integer(TranStatTypes.Delinquent) : retVal := 'Delinquent';
   end;
   // Set It
   DataSet.FieldByName('TRANSTAT').Value := retVal;

{
      0 : DataSet.FieldByName('TRANSTAT').Value := 'OPEN';
      1 : DataSet.FieldByName('TRANSTAT').Value := 'CLOSED';
      2 : DataSet.FieldByName('TRANSTAT').Value := 'CANCELLED';
      3 : DataSet.FieldByName('TRANSTAT').Value := self.FieldByName('TVALUE').AsString;
      4 : DataSet.FieldByName('TRANSTAT').Value := 'Paid';
      5 : DataSet.FieldByName('TRANSTAT').Value := 'Credit Card';
      6 : DataSet.FieldByName('TRANSTAT').Value := 'Cash Payment';
      7 : DataSet.FieldByName('TRANSTAT').Value := 'Debit';
      8 : DataSet.FieldByName('TRANSTAT').Value := 'Credit';
      9 : DataSet.FieldByName('TRANSTAT').Value := 'Check #' + self.FieldByName('TVALUE').AsString;
     10 : DataSet.FieldByName('TRANSTAT').Value := 'Cashier Check Issued';
     11 : DataSet.FieldByName('TRANSTAT').Value := 'Money Order Issued';
     12 : DataSet.FieldByName('TRANSTAT').Value := 'Debit Card';
     13 : DataSet.FieldByName('TRANSTAT').Value := 'Escrow Created';
     14 : DataSet.FieldByName('TRANSTAT').Value := self.FieldByName('TVALUE').AsString;
     15 : DataSet.FieldByName('TRANSTAT').Value := 'Escrow Used';
     16 : DataSet.FieldByName('TRANSTAT').Value := 'Money Order #' + self.FieldByName('TVALUE').AsString;
     17 : DataSet.FieldByName('TRANSTAT').Value := 'Cashier Check #' + self.FieldByName('TVALUE').AsString;
     18 : DataSet.FieldByName('TRANSTAT').Value := 'Credit Card';
     19 : DataSet.FieldByName('TRANSTAT').Value := 'Escrow Adjustment';
     20 : DataSet.FieldByName('TRANSTAT').Value := 'PayPal #' + self.FieldByName('TVALUE').AsString;
   end;
   }
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tMasterDataTransactionQuery.Load();
var
   errMsg : string;
begin
   errMsg := '';
   //
   if ( fSQLArea = SQLAreas.ByCustomer ) then
      if ( fCustID = '' ) then
         errMsg := 'No Customer Selected';
   //
   if ( fSQLArea = SQLAreas.ByPeriod ) then
   begin
      if ( fStartYear = 0 ) then
         errMsg := 'Start Year cannot be 0';
      if ( fEndYear = 0 ) then
         errMsg := 'End Year cannot be 0';
      if ( fStartCycleNumber = 0 ) then
         errMsg := 'Starting Cycle Number cannot be 0';
      if ( fEndCycleNumber = 0 ) then
         errMsg := 'Ending Cycle Number cannot be 0';
      if ( fOrgID = '' ) then
         errMsg := 'OrgID cannot be blank';
   end;
   //
   if ( fSQLArea = SQLAreas.None ) then
      errMsg := 'No Area Selected in SQLArea';
   //
   if ( errMsg = '' ) then
   begin

      GetTotalOrders();
      GetTotalReturns();
      GetTotalCancels();
      GetAmountOrderAmountTotal();
   end else
      Raise Exception.Create( errMsg );
end;



end.


