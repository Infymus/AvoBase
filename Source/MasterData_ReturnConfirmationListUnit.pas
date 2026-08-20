 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReturnConfirmationListUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  recordstructureunit,
  toolbox_ordertoolboxunit,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataReturnConfirmationList = class(tQuery)
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

constructor tMasterDataReturnConfirmationList.Create( inOrderID : string);
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
         'RQTY INTEGER, ' + // Quantity
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
      // only bring in line items that are MARKED as returned
      if ( workQuery.FieldByName('RQTY').AsInteger <> 0) then
      begin
         self.Append();
         self.FieldByName('ID').AsString := masterData.NewDBGuid();
         self.FieldByName('TTYPE').AsInteger := 1;
         //
         self.FieldByName('NAME').AsString := workQuery.FieldByName('NAME').AsString;
         self.FieldByName('NUM').AsString := workQuery.FieldByName('NUM').AsString;
         self.FieldByName('TAMT').AsCurrency := ( workQuery.FieldByName('SCOST').AsCurrency * workQuery.FieldByName('RQTY').AsInteger );
         self.FieldByName('RQTY').AsInteger := workQuery.FieldByName('RQTY').AsInteger;
         //
         self.Post();
      end;
      //
      workQuery.Next();
   until workQuery.Eof;

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
      if ( workQuery.FieldByName('RETFLAG').AsBoolean ) OR ( workQuery.FieldByname('RETADD').AsBoolean ) then
      begin
         self.Append();
         self.FieldByName('ID').AsString := masterData.NewDBGuid();
         self.FieldByName('TTYPE').AsInteger := 2;
         //
         self.FieldByName('NAME').AsString := workQuery.FieldByName('NAME').AsString;
         self.FieldByName('TAMT').AsCurrency := workQuery.FieldByName('AMOUNT').AsCurrency;
         //
         self.Post();
      end;
      //
      workQuery.Next();
   until workQuery.Eof;

   // @@@@@@@@@@@@@@@@ FINAL @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

   workQuery.Close();
   FreeAndNil( workQuery );

   // Done
   Self.Close();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReturnConfirmationList.HandleCalculated(DataSet: TDataSet);
begin
   Case Self.FieldByname('TTYPE').AsInteger of
      1 : DataSet.FieldByName('LINETYPE').Value := 'Line Item';
      2 : DataSet.FieldByName('LINETYPE').Value := 'Fee';
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReturnConfirmationList.Update();
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