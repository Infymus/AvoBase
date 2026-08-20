 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportAccountingTransactionLogByCycleUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
   recordstructureunit,
  dateutils,
  AvoBase_PercentFormUnit,
  inifileunit,
  masterdataunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  Order_InvoiceObjectUnit,
  Return_InvoiceObjectUnit,
  toolbox_escrowtoolboxunit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterData_Report_AccountingTransactionLogByCycle = class(tQuery)
   private
      ftotOrders : integer;
      ftotReturns : integer;
      ftotCancels : integer;
      //
      fAmountReturn : currency;
      fAmountOrder : currency;
      fAmountTransCredit : currency;
      fAmountTransDebit : currency;
      fAmountVoid : currency;
      fAmountMOP : currency;
      //
      orderInvoice : tInvoice;
      returnInvoice : tReturnInvoice;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      //
      property TotalOrders : integer read fTotOrders;
      property TotalReturns : integer read fTotReturns;
      property TotalCancels : integer read fTotCancels;
      //
      property AmountReturn : currency read fAmountReturn;
      property AmountOrder : currency read fAmountOrder;
      property AmountTransCredit : currency read fAmountTransCredit;
      property AmountTransDebit : currency read fAmountTransDebit;
      property AmountVoid : currency read fAmountVoid;
      property AmountMOP : currency read fAmountMOP;
      //
      constructor Create(inMasterData: tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterData_Report_AccountingTransactionLogByCycle.Create(inMasterData: tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   sqlWhere : string;
   cnt : integer;
   errResult : tErrorResult;
   sqlText : string;
   fQuery : tQuery;
   fMOPQuery : tQuery;
   fREVQuery : tQuery;
   fTRANSQuery : tQuery;
   fAmtPaid : currency;
   fAmtRefund : currency;
   fAmtCredits : currency;
begin
   inherited create( nil );
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;

   //
   PercentForm_Create('Gathering Report Data - One Moment Please...', 0, 0);

   // First get rid of it. Just so that we never have to worry about it.
   masterData.RemoveTable( table_report );

   // First, build the table if it doesn't exist
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'ID VARCHAR(40), ' + // simple ID
         'OID VARCHAR(40), ' + // order ID
         'ORDNUM VARCHAR(20), ' + // order #
         'PID  VARCHAR(40), ' + // payment ID
         'VID VARCHAR(40), ' + // void ID
         'TDATE DATE, ' + // transaction date
         'TVALUE VARCHAR(40), ' + // check #, etc
         'TTYPE INTEGER, ' + // transaction type -
{ Transaction Types:
  --------------------
   1 = Order
   2 = Return
   3 = Payment
   4 = Reversal
   5 = Escrow
}
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

   // initalize numbers
   ftotOrders := 0;
   ftotReturns := 0;
   ftotCancels := 0;
   //
   fAmountReturn := 0.00;
   fAmountOrder := 0.00;
   fAmountTransCredit := 0.00;
   fAmountTransDebit := 0.00;
   fAmountVoid := 0.00;
   fAmountMOP := 0.00;

   // setup the SQL initially
   sqlText := 'SELECT * FROM ' + fMasterData.GetTable_Report;
   self.SQL.Clear();
   self.SQL.Text := sqlText;
   Self.RequestLive := true;

   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );

   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'TRANSTYPE', 40, ftString); // display Type
   masterData.QueryAddCalculatedField( self, 'TRANSTAT', 40, ftString); // display Type

   // Now open it
   Self.Open();


   // create the invoice object we'll need for this
   orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL );
   returnInvoice := tReturnInvoice.Create( InvoiceTypeReport, NIL, NIL );

   // Our work query for the orders
   fQuery := masterData.GetQuery();

   //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // RECORD COUNTS

   //
   // ORDERS
   // -------------------------------------------------------------
   fQuery.Close();
	sqlText := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order + ' O' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C ON C.ID = O.C_ID';
   // Now we have to build the years selected.
   sqlWhere := '';
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
      begin
         sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( cnt ) + ' ) ' +
         ' AND (NUM BETWEEN 1 AND 30) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
      end;
      //
      sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( inEndYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
   end;
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
   end;
   // Combine
   sqlText := sqlText + sqlWhere;
   fQuery.SQL.Text := sqlText;
   fQuery.Open();
   ftotOrders := fQuery.FieldByName('TOT').AsInteger;
	fQuery.Close;

   //
   // RETURNS
   // -------------------------------------------------------------
   fQuery.Close();
	sqlText := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order + ' O' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C ON C.ID = O.C_ID';
   // Now we have to build the years selected.
   sqlWhere := '';
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30 ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeReturn)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
      begin
         sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( cnt ) + ' ) ' +
         ' AND (NUM BETWEEN 1 AND 30 ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeReturn)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
      end;
      //
      sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( inEndYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeReturn)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
   end;
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeReturn)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
   end;
   // Combine
   sqlText := sqlText + sqlWhere;
   fQuery.SQL.Text := sqlText;
   fQuery.Open();
   ftotReturns := fQuery.FieldByName('TOT').AsInteger;
	fQuery.Close;

   //
   // CANCELS
   // -------------------------------------------------------------
   fQuery.Close();
	sqlText := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order + ' O' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C ON C.ID = O.C_ID';
   // Now we have to build the years selected.
   sqlWhere := '';
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30 ) ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusCancelled)) + '))';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
      begin
         sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( cnt ) + ' ) ' +
         ' AND (NUM BETWEEN 1 AND 30 ) ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusCancelled)) + '))';
      end;
      //
      sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( inEndYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusCancelled)) + '))';
   end;
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusCancelled)) + '))';
   end;
   // Combine
   sqlText := sqlText + sqlWhere;
   fQuery.SQL.Text := sqlText;
   fQuery.Open();
   ftotCancels := fQuery.FieldByName('TOT').AsInteger;
	fQuery.Close;

   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // ORDERS
   //
   fQuery.Close();
	sqlText := 'SELECT O.* FROM ' + masterData.GetTable_Order + ' O' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C ON C.ID = O.C_ID';
   // Now we have to build the years selected.
   sqlWhere := '';
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30 ) ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
      begin
         sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( cnt ) + ' ) ' +
         ' AND (NUM BETWEEN 1 AND 30 ) ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
      end;
      //
      sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( inEndYear ) + ' ) ' +
         ' AND ( NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
   end;
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + '))';
   end;
   // Combine
   sqlText := sqlText + sqlWhere;
   fQuery.SQL.Text := sqlText;
   //
   fQuery.Open();
   fMOPQuery := masterData.GetQuery();
   fREVQuery := masterData.GetQuery();
   fTRANSQuery := masterData.GetQuery();
   if ( fQuery.RecordCount <> 0) then
   repeat
      if (fQuery.FieldByName('STATUS').AsInteger = integer(OrderStatusClosed)) then
      begin
         //
         self.Append();
         self.FieldByName('ID').AsString := masterData.NewDBGuid;
         self.FieldByName('OID').AsString := fQuery.FieldByName('ID').AsString;
         self.FieldByName('ORDNUM').AsString := fQuery.FieldByName('ONUM').AsString;
         self.FieldByName('TDATE').AsDateTime := fQuery.FieldByName('ODATE').AsDateTime;
         self.FieldByname('TSTAT').AsInteger := fQuery.FieldByName('STATUS').AsInteger;
         self.FieldByName('TVALUE').AsString := 'CLOSED';
         case fQuery.FieldByName('O_TYPE').AsInteger of
            integer(tOrderTypes.OrdTypeOrder):
            begin
               orderInvoice.Load( fQuery.FieldByName('ID').AsString);
               //
               self.FieldByName('TAMT').AsCurrency := orderInvoice.Amount_Total;
               fAmountOrder := fAmountOrder + orderInvoice.Amount_Total;
               self.FieldByName('TTYPE').AsInteger := 1;
            end;
            integer(tOrderTypes.OrdTypeReturn):
            begin
               returnInvoice.Load( fQuery.FieldByName('ID').AsString);
               //
               self.FieldByName('TAMT').AsCurrency := returnInvoice.Amount_TotalRefund;
               fAmountReturn := fAmountReturn + returnInvoice.Amount_TotalRefund;
               self.FieldByName('TTYPE').AsInteger := 2;
            end;
         end;
         Self.Post();
         // PAYMENTS - METHOD OF PAYMENTS
         // --------------------------------------------------
         fMOPQuery.Close();
         sqlText := 'SELECT * FROM ' + MasterData.GetTable_Mop +
            ' WHERE ORDER_ID = ' + masterData.WrapDBID( fQuery.FieldByName('ID').AsString );
         fMOPQuery.SQL.Text := sqlText;
         fMOPQuery.Open();
         if ( fMOPQuery.RecordCount <> 0 ) then
         repeat
            self.Append();
            self.FieldByName('ID').AsString := masterData.NewDBGuid;
            self.FieldByName('OID').AsString := fMOPQuery.FieldByName('ORDER_ID').AsString;
            self.FieldByName('PID').AsString := fMOPQuery.FieldByName('ID').AsString;
            self.FieldByName('TDATE').AsDateTime := fMOPQuery.FieldByName('MOPDATE').AsDateTime;
            self.FieldByName('TTYPE').AsInteger := 3;
            self.FieldByName('ORDNUM').AsString := Order_GetOrderNumberByOrderID( fMOPQuery.FieldByName('ORDER_ID').AsString );
            self.FieldByName('TAMT').AsCurrency := fMOPQuery.FieldByName('AMOUNT').AsCurrency;
            self.FieldByName('TVALUE').AsString := EncryptObj.DecryptString( fMOPQuery.FieldByName('MOPVALUE').AsString );
            case fMOPQuery.FieldByName('MOPTYPE').AsInteger of
               integer(PayTypeCash): self.FieldByname('TSTAT').AsInteger := 6;
               integer(PayTypeCreditCard): self.FieldByname('TSTAT').AsInteger := 8;
               integer(PayTypeCheck): self.FieldByname('TSTAT').AsInteger := 9;
               integer(PayTypeCashierCheck): self.FieldByname('TSTAT').AsInteger := 17;
               integer(PayTypeMoneyOrder): self.FieldByname('TSTAT').AsInteger := 16;
               integer(PayTypeDebitCard): self.FieldByname('TSTAT').AsInteger := 12;
               integer(PayTypeEscrow): self.FieldByname('TSTAT').AsInteger := 15;
               integer(PayTypePayPal): self.FieldByname('TSTAT').AsInteger := 20;
            end;
            Self.Post();
            //
            fAmountMOP := fAmountMOP + fMOPQuery.FieldByName('AMOUNT').AsCurrency;
            fMOPQuery.Next();
         until fMOPQuery.EOF;
         fMOPQuery.Close();
         // REVERSALS - REVERSALS
         // --------------------------------------------------
         fREVQuery.Close();
         sqlText := 'SELECT * FROM ' + MasterData.GetTable_Reversal +
            ' WHERE ORDER_ID = ' + masterData.WrapDBID( fQuery.FieldByName('ID').AsString );
         fREVQuery.SQL.Text := sqlText;
         fREVQuery.Open();
         if ( fREVQuery.RecordCount <> 0 ) then
         repeat
            self.Append();
            self.FieldByName('ID').AsString := masterData.NewDBGuid;
            self.FieldByName('OID').AsString := fREVQuery.FieldByName('ORDER_ID').AsString;
            self.FieldByName('ORDNUM').AsString := Order_GetOrderNumberByOrderID( fREVQuery.FieldByName('ORDER_ID').AsString );
            self.FieldByName('VID').AsString := fREVQuery.FieldByName('ID').AsString;
            self.FieldByName('TDATE').AsDateTime := fREVQuery.FieldByName('RDATE').AsDateTime;
            self.FieldByName('TAMT').AsCurrency := fREVQuery.FieldByName('AMOUNT').AsCurrency;
            fAmountVoid := fAmountVoid + fREVQuery.FieldByName('AMOUNT').AsCurrency;
            self.FieldByName('TTYPE').AsInteger := 4;
            self.FieldByname('TSTAT').AsInteger := 14;
            //
            case fREVQuery.FieldByName('MOPTYPE').AsInteger of
               integer(PayTypeCreditCard) : self.FieldByName('TVALUE').AsString := 'Credit Card';
               integer(PayTypeCheck) : self.FieldByName('TVALUE').AsString := 'Check #' + fREVQuery.FieldByName('MOPVALUE').AsString;
               integer(PayTypeCashierCheck) : self.FieldByName('TVALUE').AsString := 'Cashier Check #' + fREVQuery.FieldByName('MOPVALUE').AsString;
               integer(PayTypeMoneyOrder) : self.FieldByName('TVALUE').AsString := 'Money Order #' + fREVQuery.FieldByName('MOPVALUE').AsString;
               integer(PayTypeDebitCard) : self.FieldByName('TVALUE').AsString := 'Debit Card';
               integer(PayTypePayPal) : self.FieldByName('TVALUE').AsString := 'PayPal #' + fREVQuery.FieldByName('MOPVALUE').AsString;
            end;
            Self.Post();
            fREVQuery.Next();
         until fREVQuery.EOF;
         fREVQuery.Close();
         // TRANSACTIONS
         // --------------------------------------------------
         fTRANSQuery.Close();
         sqlText := 'SELECT * FROM ' + MasterData.GetTable_Transactions +
            ' WHERE ORDER_ID = ' + masterData.WrapDBID( fQuery.FieldByName('ID').AsString );
         fTRANSQuery.SQL.Text := sqlText;
         fTRANSQuery.Open();
         if ( fTRANSQuery.RecordCount <> 0 ) then
         repeat
            self.Append();
            self.FieldByName('ID').AsString := masterData.NewDBGuid;
            self.FieldByName('OID').AsString := fTRANSQuery.FieldByName('ORDER_ID').AsString;
            self.FieldByName('ORDNUM').AsString := Order_GetOrderNumberByOrderID( fTRANSQuery.FieldByName('ORDER_ID').AsString );
            self.FieldByName('VID').AsString := fTRANSQuery.FieldByName('ID').AsString;
            self.FieldByName('TDATE').AsDateTime := fTRANSQuery.FieldByName('TDATE').AsDateTime;
            self.FieldByName('TAMT').AsCurrency := fTRANSQuery.FieldByName('AMOUNT').AsCurrency;
            self.FieldByname('TVALUE').AsString := fTRANSQuery.FieldByName('TMOPVALUE').AsString;
            //
            case fTRANSQuery.FieldByName('TTYPE').AsInteger of
               integer( tTransTypes.TransCredit ):
               begin
                  fAmountTransCredit := fAmountTransCredit + fTRANSQuery.FieldByName('AMOUNT').AsCurrency;
                  //
                  case fTRANSQuery.FieldByname('TMOPTYPE').AsInteger of
                     integer(tMethodOfPaymentTypes.PayTypeCash): self.FieldByname('TSTAT').AsInteger := 6;
                     integer(tMethodOfPaymentTypes.PayTypeCheck): self.FieldByname('TSTAT').AsInteger := 9;
                     integer(tMethodOfPaymentTypes.PayTypeCashierCheck): self.FieldByname('TSTAT').AsInteger := 10;
                     integer(tMethodOfPaymentTypes.PayTypeMoneyOrder): self.FieldByname('TSTAT').AsInteger := 11;
                     integer(tMethodOfPaymentTypes.PayTypeEscrow): self.FieldByname('TSTAT').AsInteger := 13;
                     integer(tMethodOfPaymentTypes.PayTypePayPal): self.FieldByname('TSTAT').AsInteger := 20;
                  end;
                  self.FieldByName('TTYPE').AsInteger := 5;
               end;
               integer( tTransTypes.TransDebit ):
               begin
                  fAmountTransDebit := fAmountTransDebit + fTRANSQuery.FieldByName('AMOUNT').AsCurrency;
                  self.FieldByName('TTYPE').AsInteger := 5;
                  self.FieldByname('TSTAT').AsInteger := 6;
               end;
               //
            end;
            Self.Post();
            fTRANSQuery.Next();
         until fTRANSQuery.EOF;
         fTRANSQuery.Close();
      end;
      fQuery.Next();
   until fQuery.EOF;

   //
   // DONE
   fQuery.Close();
   fMOPQuery.Close();
   FreeAndNil(fMOPQuery);
   FreeAndNil(fREVQuery);
   FreeAndNil(fTRANSQuery);
   FreeAndNil(fQuery);

   // Do some totals
   fAmtPaid := ( fAmountMOP );
   fAmtRefund := ( fAmountReturn );
   fAmtCredits := fAmtRefund;

   // Done
   Self.Close();
   sqlText := 'SELECT * FROM ' + fMasterData.GetTable_Report +
      ' ORDER BY TDATE DESC, ORDNUM DESC';
   self.SQL.Text := sqlText;
   //
   PercentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterData_Report_AccountingTransactionLogByCycle.destroy;
begin
   FreeAndNil(orderINvoice);
   FreeAndNil(returnInvoice);
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterData_Report_AccountingTransactionLogByCycle.HandleCalculated(DataSet: TDataSet);
begin
   Case Self.FieldByname('TTYPE').AsInteger of
      1 : DataSet.FieldByName('TRANSTYPE').Value := 'Order';
      2 : DataSet.FieldByName('TRANSTYPE').Value := 'Return';
      3 : DataSet.FieldByName('TRANSTYPE').Value := 'Payment';
      4 : DataSet.FieldByName('TRANSTYPE').Value := 'Void Payment';
      5 : DataSet.FieldByName('TRANSTYPE').Value := 'Credited';
      6 : DataSet.FieldByName('TRANSTYPE').Value := 'Debited';
   end;
   Case Self.FieldByname('TSTAT').AsInteger of
      0 : DataSet.FieldByName('TRANSTAT').Value := '';
      1 : DataSet.FieldByName('TRANSTAT').Value := 'OPEN';
      2 : DataSet.FieldByName('TRANSTAT').Value := self.FieldByName('TVALUE').AsString;
      3 : DataSet.FieldByName('TRANSTAT').Value := 'CANCELLED';
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
end;


end.


{

            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.

   tMethodOfPaymentTypes = ( PayTypeCash = 1, PayTypeCreditCard = 2, PayTypeCheck = 3, PayTypeCashierCheck = 4,
      PayTypeMoneyOrder = 5, PayTypeDebitCard = 6, PayTypeEscrow = 7 );


      0 : DataSet.FieldByName('TRANSTAT').Value := '';
      1 : DataSet.FieldByName('TRANSTAT').Value := 'OPEN';
      2 : DataSet.FieldByName('TRANSTAT').Value := self.FieldByName('TVALUE').AsString;
      3 : DataSet.FieldByName('TRANSTAT').Value := 'CANCELLED';
      4 : DataSet.FieldByName('TRANSTAT').Value := 'Paid';
      5 : DataSet.FieldByName('TRANSTAT').Value := 'Credit Card';
      6 : DataSet.FieldByName('TRANSTAT').Value := 'Cash Payment';
      7 : DataSet.FieldByName('TRANSTAT').Value := 'Debit';
      8 : DataSet.FieldByName('TRANSTAT').Value := 'Credit';
      9 : DataSet.FieldByName('TRANSTAT').Value := 'Check #' + self.FieldByName('TVALUE').AsString + ' Issued';
     10 : DataSet.FieldByName('TRANSTAT').Value := 'Cashier Check Issued';
     11 : DataSet.FieldByName('TRANSTAT').Value := 'Money Order Issued';
     12 : DataSet.FieldByName('TRANSTAT').Value := 'Debit Card';
     13 : DataSet.FieldByName('TRANSTAT').Value := 'Escrow Created';
     14 : DataSet.FieldByName('TRANSTAT').Value := self.FieldByName('TVALUE').AsString;
     15 : DataSet.FieldByName('TRANSTAT').Value := 'Escrow Used';
     16 : DataSet.FieldByName('TRANSTAT').Value := 'Money Order #' + self.FieldByName('TVALUE').AsString + ' Issued';
     17 : DataSet.FieldByName('TRANSTAT').Value := 'Cashier Check #' + self.FieldByName('TVALUE').AsString + ' Issued';
     18 : DataSet.FieldByName('TRANSTAT').Value := 'Credit Card';
}

{ Transaction Types:
  --------------------
   1 = Order
   2 = Return
   3 = Payment
   4 = Void
   5 = Credit
   6 = Debit
   7 = Cash
   8 = Credit Card
   9 = Check
  10 = Cashier Check
  11 = Money Order
  12 = Debit Card
  13 = Escrow

      tMethodOfPaymentTypes = ( PayTypeCash = 1, PayTypeCreditCard = 2, PayTypeCheck = 3, PayTypeCashierCheck = 4,
      PayTypeMoneyOrder = 5, PayTypeDebitCard = 6, PayTypeEscrow = 7 );

}


{
         retVal := masterData.AddTable(masterData.dbPath + table_mop,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // CUSTOMER ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY INTEGER, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'MOPCCT INTEGER, ' + // credit card type ( see tCreditCardTypes );
            'MOP_REV BOOLEAN, ' + // payment reversed?
            'AMOUNT MONEY',
}

{
         retVal := masterData.AddTable(masterData.dbPath + table_trans,
            'ID VARCHAR(40), ' +
            'TDATE DATE, ' + // transaction date
            'TTIME TIME, ' + // ttime
            'C_STID VARCHAR(40), ' + // customer_id
            'C_ID VARCHAR(40), ' + // cycle_ID
            'ORG_ID VARCHAR(40), ' + // orgID
            'ORDER_ID VARCHAR(40), ' + // orderID
            'TTYPE INTEGER, ' + // trans type, see tTransTypes
            'TMOPTYPE INTEGER, ' + // method of payment type, see tMethodOfPaymentTypes
            'TMOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY',

}

{
         retVal := masterData.AddTable(masterData.dbPath + table_escrow,
            'C_ID VARCHAR(40), ' + // customer ID
            'MOPDATE DATE, ' + // date of MOP
            'AMOUNT MONEY',
            }
{
         retVal := masterData.AddTable(masterData.dbPath + table_reversal,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer ID
            'PAY_ID VARCHAR(40), ' + // original method of payment ID
            'RDATE DATE, ' + // reversal date
            'RTYPE INTEGER, ' + // reversal type - see tReversalTypes
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY INTEGER, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'MOPCCT INTEGER, ' + // credit card type ( see tCreditCardTypes );
            'AMOUNT MONEY',
}

{
         retVal := masterData.AddTable(masterData.dbPath + table_order,
            'ID VARCHAR(40), ' +
            'RET_ID VARCHAR(40), ' + // The prior order ID only for returns
            'C_ID VARCHAR(40), ' + // cycle id
            'C_STID VARCHAR(40), ' + // sold to id
            'C_SHID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'ORG_ID VARCHAR(40), ' +
            'ONUM INTEGER, ' + // order number
            'ODATE DATE, ' +
            'OTIME TIME, ' +
            'SHIPAMT MONEY, ' +
            'SHIPTAXAMT MONEY, ' +
            'CTAXAMT MONEY, ' + // compound tax amount
            'STATUS INTEGER, ' +
            'WTAX BOOLEAN, ' +
            'WSHIP BOOLEAN, ' +
            'WSHIPTAX BOOLEAN, ' + // wave shipping?
            'SHIPTAX FLOAT, ' + // shipping tax rate
            'SHOW_DISC BOOLEAN, ' +
            'O_TYPE INTEGER, ' +
            'I_MSG BLOB(240,1)',
   tOrderStatusTypes = (OrderStatusNone = 0, OrderOpen = 1, OrderClosed = 2, OrderCancelled = 3);
}
