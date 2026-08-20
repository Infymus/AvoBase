 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

{ ug. this is such a fucking mess. i can't believe i wrote this. }

unit MasterData_TransactionListUnit;

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
   tMasterDataCustomerAccountList = class(tQuery)
   private
      ftotOrders : integer;
      ftotReturns : integer;
      ftotCancels : integer;
      //
      fAmountReturn : currency;
      fAmountOrder : currency;
      fAmountEscrow : currency;
      fAmountTransCredit : currency;
      fAmountTransDebit : currency;
      fAmountVoid : currency;
      fAmountMOP : currency;
      //
      fAmountDue : currency;
      //
      fCustID : string;
      orderInvoice : tInvoice;
      returnInvoice : tReturnInvoice;
   	fQuery : tQuery;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update( SortDir : string );
      //
      property TotalOrders : integer read fTotOrders;
      property TotalReturns : integer read fTotReturns;
      property TotalCancels : integer read fTotCancels;
      //
      property AmountReturn : currency read fAmountReturn;
      property AmountOrder : currency read fAmountOrder;
      property AmountEscrow : currency read fAmountEscrow;
      property AmountTransCredit : currency read fAmountTransCredit;
      property AmountTransDebit : currency read fAmountTransDebit;
      property AmountVoid : currency read fAmountVoid;
      property AmountMOP : currency read fAmountMOP;
      //
      property AmountDue : currency read fAmountDue;
      //
      constructor Create( inMasterData : tMasterData; inCustID : string);  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataCustomerAccountList.Create(inMasterData: tMasterData; inCustID : string);
var
   errResult : tErrorResult;
   sql : string;
   fQuery : tQuery;
   workQuery : tQuery;
   fAmtDue : currency;
   fAmtPaid : currency;
   fAmtRefund : currency;
   fAmtCredits : currency;
begin
   inherited create( nil );
   //
   fCustID := inCustID;
   self.SessionName := masterData.AvoBaseSession.SessionName;
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
         'ORDNUM VARCHAR(20), ' + // order #
         'PID  VARCHAR(40), ' + // payment ID
         'VID VARCHAR(40), ' + // void ID
         'TDATE DATE, ' + // transaction date
         'TVALUE VARCHAR(80), ' + // check #, etc
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
   fAmountEscrow := 0.00;
   fAmountTransCredit := 0.00;
   fAmountTransDebit := 0.00;
   fAmountVoid := 0.00;
   fAmountMOP := 0.00;

   // setup the SQL initially
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Report;
   self.SQL.Clear();
   self.SQL.Text := sql;
   //
   Self.RequestLive := true;

   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );

   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'TRANSTYPE', 40, ftString); // display Type
   masterData.QueryAddCalculatedField( self, 'TRANSTAT', 40, ftString); // display Type

   Self.Open();

   // create the invoice object we'll need for this
   orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL );
   returnInvoice := tReturnInvoice.Create( InvoiceTypeReport, NIL, NIL );
   fQuery := masterData.GetQuery();
   workQuery := masterData.GetQuery();

	// lets get record counts...
   fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + MasterData.GetTable_Order +
      	' WHERE C_STID = ' + masterData.WrapDBID( fCustID ) +
         ' AND O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) +
         ' AND STATUS = ' + IntToSTr(integer(OrderStatusClosed));
   fQuery.Open();
   ftotOrders := fQuery.FieldByName('TOT').AsInteger;
	fQuery.Close;
   //
   fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + MasterData.GetTable_Order +
      	' WHERE C_STID = ' + masterData.WrapDBID( fCustID ) +
         ' AND O_TYPE = ' + IntToStr(integer(OrdTypeReturn)) +
         ' AND STATUS = ' + IntToSTr(integer(OrderStatusClosed));
   fQuery.Open();
   ftotReturns := fQuery.FieldByName('TOT').AsInteger;
	fQuery.Close;
   //
   fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + MasterData.GetTable_Order +
      	' WHERE C_STID = ' + masterData.WrapDBID( fCustID ) +
         ' AND STATUS = ' + IntToStr(integer(OrderStatusCancelled));
   fQuery.Open();
   ftotCancels := fQuery.FieldByName('TOT').AsInteger;
	fQuery.Close;

   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // ORDERS
   //
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT * FROM ' + MasterData.GetTable_Order +
      ' WHERE C_STID = ' + masterData.WrapDBID( fCustID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0) then
   repeat
//      if (fQuery.FieldByName('STATUS').AsInteger = integer(OrderStatusClosed)) then
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
      end;
      fQuery.Next();
   until fQuery.EOF;
   fQuery.Close();

   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // PAYMENTS - METHOD OF PAYMENTS
   //
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT * FROM ' + MasterData.GetTable_Mop +
      ' WHERE C_ID = ' + masterData.WrapDBID( fCustID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0) then
   repeat
//      if ( Order_GetOrderStatusByOrderID( fQuery.FieldByName('ORDER_ID').AsString ) = tOrderStatusTypes.OrderStatusClosed ) then
      begin
         self.Append();
         self.FieldByName('ID').AsString := masterData.NewDBGuid;
         self.FieldByName('OID').AsString := fQuery.FieldByName('ORDER_ID').AsString;
         self.FieldByName('PID').AsString := fQuery.FieldByName('ID').AsString;
         self.FieldByName('TDATE').AsDateTime := fQuery.FieldByName('MOPDATE').AsDateTime;
         self.FieldByName('TTYPE').AsInteger := 3;
         self.FieldByName('ORDNUM').AsString := Order_GetOrderNumberByOrderID( fQuery.FieldByName('ORDER_ID').AsString );
         self.FieldByName('TAMT').AsCurrency := fQuery.FieldByName('AMOUNT').AsCurrency;

{

            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.

   tMethodOfPaymentTypes = ( PayTypeCash = 1, PayTypeCreditCard = 2, PayTypeCheck = 3, PayTypeCashierCheck = 4,
      PayTypeMoneyOrder = 5, PayTypeDebitCard = 6, PayTypeEscrow = 7 );

}

         self.FieldByName('TVALUE').AsString := EncryptObj.DecryptString( fQuery.FieldByName('MOPVALUE').AsString );
         case fQuery.FieldByName('MOPTYPE').AsInteger of
            integer(PayTypeCash): self.FieldByname('TSTAT').AsInteger := 6;
            integer(PayTypeCreditCard): self.FieldByname('TSTAT').AsInteger := 8;
            integer(PayTypeCheck): self.FieldByname('TSTAT').AsInteger := 9;
            integer(PayTypeCashierCheck): self.FieldByname('TSTAT').AsInteger := 17;
            integer(PayTypeMoneyOrder): self.FieldByname('TSTAT').AsInteger := 16;
            integer(PayTypeDebitCard): self.FieldByname('TSTAT').AsInteger := 12;
            integer(PayTypeEscrow): self.FieldByname('TSTAT').AsInteger := 15;
            integer(PayTypePaypal): self.FieldByName('TSTAT').AsInteger := 20;
         end;

         Self.Post();
         //
         fAmountMOP := fAmountMOP + fQuery.FieldByName('AMOUNT').AsCurrency;
      end;
      fQuery.Next();
   until fQuery.EOF;
   fQuery.Close();

   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // REVERSALS
   //
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT * FROM ' + MasterData.GetTable_Reversal +
      ' WHERE C_ID = ' + masterData.WrapDBID( fCustID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0) then
   repeat
      self.Append();
      self.FieldByName('ID').AsString := masterData.NewDBGuid;
      self.FieldByName('OID').AsString := fQuery.FieldByName('ORDER_ID').AsString;
      self.FieldByName('ORDNUM').AsString := Order_GetOrderNumberByOrderID( fQuery.FieldByName('ORDER_ID').AsString );
      self.FieldByName('VID').AsString := fQuery.FieldByName('ID').AsString;
      self.FieldByName('TDATE').AsDateTime := fQuery.FieldByName('RDATE').AsDateTime;
      self.FieldByName('TAMT').AsCurrency := fQuery.FieldByName('AMOUNT').AsCurrency;
      fAmountVoid := fAmountVoid + fQuery.FieldByName('AMOUNT').AsCurrency;
      self.FieldByName('TTYPE').AsInteger := 4;
      self.FieldByname('TSTAT').AsInteger := 14;
      //
      case fQuery.FieldByName('MOPTYPE').AsInteger of
         integer(PayTypeCreditCard) : self.FieldByName('TVALUE').AsString := 'Credit Card';
         integer(PayTypeCheck) : self.FieldByName('TVALUE').AsString := 'Check #' + fQuery.FieldByName('MOPVALUE').AsString;
         integer(PayTypeCashierCheck) : self.FieldByName('TVALUE').AsString := 'Cashier Check #' + fQuery.FieldByName('MOPVALUE').AsString;
         integer(PayTypeMoneyOrder) : self.FieldByName('TVALUE').AsString := 'Money Order #' + fQuery.FieldByName('MOPVALUE').AsString;
         integer(PayTypeDebitCard) : self.FieldByName('TVALUE').AsString := 'Debit Card';
         integer(PayTypePayPal) : self.FieldByName('TVALUE').AsString := 'PayPal #' + fQuery.FieldByName('MOPVALUE').AsString;
      end;

{
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #

   tMethodOfPaymentTypes = ( PayTypeCash = 1, PayTypeCreditCard = 2, PayTypeCheck = 3, PayTypeCashierCheck = 4,
      PayTypeMoneyOrder = 5, PayTypeDebitCard = 6, PayTypeEscrow = 7 );
}

      Self.Post();
      fQuery.Next();
   until fQuery.EOF;
   fQuery.Close();

   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // TRANSACTIONS
   //
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT * FROM ' + MasterData.GetTable_Transactions +
      ' WHERE C_STID = ' + masterData.WrapDBID( fCustID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0) then
   repeat
      self.Append();
      self.FieldByName('ID').AsString := masterData.NewDBGuid;
      self.FieldByName('OID').AsString := fQuery.FieldByName('ORDER_ID').AsString;
      self.FieldByName('ORDNUM').AsString := Order_GetOrderNumberByOrderID( fQuery.FieldByName('ORDER_ID').AsString );
      self.FieldByName('VID').AsString := fQuery.FieldByName('ID').AsString;
      self.FieldByName('TDATE').AsDateTime := fQuery.FieldByName('TDATE').AsDateTime;
      self.FieldByName('TAMT').AsCurrency := fQuery.FieldByName('AMOUNT').AsCurrency;
      self.FieldByname('TVALUE').AsString := fQuery.FieldByName('TMOPVALUE').AsString;
      //
      case fQuery.FieldByName('TTYPE').AsInteger of
         integer( tTransTypes.TransCredit ):
         begin
            fAmountTransCredit := fAmountTransCredit + fQuery.FieldByName('AMOUNT').AsCurrency;
            //
            case fQuery.FieldByname('TMOPTYPE').AsInteger of
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
            fAmountTransDebit := fAmountTransDebit + fQuery.FieldByName('AMOUNT').AsCurrency;
            self.FieldByName('TTYPE').AsInteger := 5;
            self.FieldByname('TSTAT').AsInteger := 6;
         end;
         //
      end;

      Self.Post();
      fQuery.Next();
   until fQuery.EOF;
   fQuery.Close();

   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // ESCROW
   //
   fAmountEscrow := Escrow_GetCustomerEscrowByCustomerID( inCustID );


   // @@@@@@@@@@@@@@@@ FINAL @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   fAmountDue := 0;

{
   fAmtDue : currency;
   fAmtPaid : currency;
   fAmtRefund : currency;
   fAmtCredits : currency;

}
   fAmtDue := ( fAmountOrder );
   fAmtPaid := ( fAmountMOP - fAmountVoid );
   fAmtRefund := ( fAmountReturn );
   fAmtCredits := fAmtRefund;

   // Totals

   //fAmtDue - fAmtPaid );


// 3/8/2012: try this again
   fAmountDue := ( fAmountOrder );
   fAmountDue := fAmountDue - ( fAmtRefund );
   fAmountDue := fAmountDue - ( fAmountMOP );
   fAmountDue := fAmountDue + ( fAmountVoid );




   if ( fAmountDue < 0 ) then fAmountDue := fAmountDue - fAmountDue - fAmountDue;

   {
         fAmountReturn : currency;
      fAmountOrder : currency;
      fAmountEscrow : currency;
      fAmountTransCredit : currency;
      fAmountTransDebit : currency;
      fAmountVoid : currency;
      fAmountMOP : currency;
}


	// Amount Out Standing

   // Done
   Self.Close();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataCustomerAccountList.destroy;
begin
	FreeAndNil(fQuery);
   FreeAndNil(orderINvoice);
   FreeAndNil(returnInvoice);
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataCustomerAccountList.HandleCalculated(DataSet: TDataSet);
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

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataCustomerAccountList.Update( SortDir : String);
var
   errResult : tErrorResult;
   sql : string;
begin
	self.Close();
   //
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Report;
   sql := sql + ' ORDER BY TDATE ' + sortDir + ', ORDNUM DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)


end.

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
