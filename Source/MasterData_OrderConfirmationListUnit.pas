 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

{ ug. this is such a fucking mess. i can't believe i wrote this. }

unit MasterData_OrderConfirmationListUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  recordstructureunit,
  db,
  dbtables,
  toolbox_ordertoolboxunit,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataOrderConfirmationList = class(tQuery)
   private
      fOrderID : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      procedure Update;
      //
      constructor Create( inOrderID : string );  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataOrderConfirmationList.Create( inOrderID : string);
var
   errResult : tErrorResult;
   sql : string;
   workQuery : tQuery;
   cnt : integer;
begin
   inherited create( nil );
   //
   fOrderID := inOrderID;

   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;

   // First get rid of it. Just so that we never have to worry about it.
   masterData.RemoveTable( table_report );

   // First, build the table if it doesn't exist
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'ID VARCHAR(40), ' + // simple ID
         'NAME VARCHAR(40), ' + // name
         'NUM VARCHAR(40), ' + // number
         'SQTY INTEGER, ' + // Quantity
         'TTYPE INTEGER, ' + // 1 = Line Item | 2 = Fee
         'TAMT MONEY', // transaction amount
         {----------------}
         'ID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;

   // setup the SQL initially
   sql := 'SELECT * FROM ' + MasterData.GetTable_Report;
   self.SQL.Clear();
   self.SQL.Text := sql;
   //
   Self.RequestLive := true;

   // Add the fields from the above SQL string
   errResult := MasterData.QueryAddFields( self );

   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'LINETYPE', 40, ftString); // display Type
   Self.Open();

   workQuery := masterData.GetQuery();

   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
   // LINE ITEMS
   //

   workQuery.CLose();
   workQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( fOrderID );
   workQuery.Open();
   //
   if ( workQuery.RecordCount > 0 ) then
   repeat
      self.Append();
      self.FieldByName('ID').AsString := masterData.NewDBGuid();
      self.FieldByName('TTYPE').AsInteger := 1;
      //
      self.FieldByName('NAME').AsString := workQuery.FieldByName('NAME').AsString;
      self.FieldByName('NUM').AsString := workQuery.FieldByName('NUM').AsString;
      if ( Order_GetOrderTypeByOrderID( fOrderID ) = OrdTypeOrder ) then
      begin
         self.FieldByName('TAMT').AsCurrency := ( workQuery.FieldByName('SCOST').AsCurrency * workQuery.FieldByName('SQTY').AsInteger );
         self.FieldByName('SQTY').AsInteger := workQuery.FieldByName('SQTY').AsInteger
      end;
      if ( Order_GetOrderTypeByOrderID( fOrderID ) = OrdTypeReturn ) then
      begin
         self.FieldByName('TAMT').AsCurrency := ( workQuery.FieldByName('SCOST').AsCurrency * workQuery.FieldByName('PQTY').AsInteger );
         self.FieldByName('SQTY').AsInteger := workQuery.FieldByName('SQTY').AsInteger;
      end;
      //
      self.Post();
      //
      workQuery.Next();
   until workQuery.Eof;

{
         retVal := masterData.AddTable(masterData.dbPath + table_order_product,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'R_ID VARCHAR(40), ' + // return prior order_product_ID
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'RQTY INTEGER, ' + // return qty (if RQTY = SQTY + FQTY then this line CANNOT be returned!!! )
            'FQTY INTEGER, ' + // free quantity (for by X get X free)
            'PQTY INTEGER, ' + // prior returned quantity
            'SO INTEGER, ' + // integer sort, only on save for bringing back into the invoice.
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
            }

      // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
      // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
      // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
      // FEES
      //
   workQuery.CLose();
   workQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_OrderFee +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( fOrderID );
   workQuery.Open();
   //
   if ( workQuery.RecordCount > 0 ) then
   repeat
      self.Append();
      self.FieldByName('ID').AsString := masterData.NewDBGuid();
      self.FieldByName('TTYPE').AsInteger := 2;
      //
      self.FieldByName('NAME').AsString := workQuery.FieldByName('NAME').AsString;
      self.FieldByName('TAMT').AsCurrency := workQuery.FieldByName('AMOUNT').AsCurrency;
      //
      self.Post();
      //
      workQuery.Next();
   until workQuery.Eof;


{
         retVal := masterData.AddTable(masterData.dbPath + table_order_fee,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'TAX FLOAT, ' + // tax rate
            'RET BOOLEAN, ' + // fee has been refunded? (returned)? if so, don't bring back on RETURN invoice
            'RETFLAG BOOLEAN, ' + // only for returns, flagged as required for return
            'RETADD BOOLEAN, ' + // applies only to returns, is a fee that can be added or subtracted
            'AMOUNT MONEY',

}






   // @@@@@@@@@@@@@@@@ FINAL @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

   workQuery.Close();
   FreeAndNil( workQuery );

   // Done
   Self.Close();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataOrderConfirmationList.HandleCalculated(DataSet: TDataSet);
begin
   Case Self.FieldByname('TTYPE').AsInteger of
      1 : DataSet.FieldByName('LINETYPE').Value := 'Line Item';
      2 : DataSet.FieldByName('LINETYPE').Value := 'Fee';
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataOrderConfirmationList.Update();
var
   sql : string;
begin
	self.Close();
   //
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

   // Go through the Transaction Table
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
