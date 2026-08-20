 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_PaymentToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  RecordStructureUnit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  EncryptUnit,
  //
  toolbox_escrowtoolboxunit,
  //
  db,
  dbtables,
  bde,
  sysutils,
  classes,
  forms,
  dateutils,
  inifiles,
  stdctrls;




function Payment_InitializePaymentRecord : tPaymentRec;
function Payment_InitializeReversalRecord : tReversalRec;
function Payment_InitializeTranRecord : tTransRec;

function Payment_GetPaymentTypeByPaymentName( inName : string ) : integer;
function Payment_GetPaymentIntegerByName( inName : string ) : integer;
function Payment_GetTotalPaymentCountByOrderID( inID : string ) : integer;
function Payment_GetPaymentRecordByID( inID : string ) : tPaymentRec;
function Payment_GetVoidTypeByName( inName : string ) : tVoidTypes;
function Payment_GetAmountVoidedByCustomerID( inID : string ) : currency;
function Payment_MovePaymentToTransactions( inOrderID : string ) : tErrorResult;
function Payment_MakeTransactionPayment( inTransRec : tTransRec ) : tErrorResult;
function Payment_GetAmountVoidedByOrderID( inOrderID : string ) : currency;
function Payment_SubtractEscrowByOrderID( inOrderID, inCustID : string ) : tErrorResult;
function Payment_GetAmountPaidMinusVoidByOrderID( inOrderID : string ) : currency;
function Payment_GetAmountPaidByOrderID( inOrderID : string ) : currency;
function Payment_GetAmountTransCreditByOrderID( inOrderID : string ) : currency;
function Payment_VoidPaymentEscrowByOrderID( inCustID, inOrderID : string ) : currency;

procedure Payment_FillPaymentTypes( VAR inComboBox : tComboBox );
procedure Payment_FillCreditCardTypes( VAR inComboBox : tComboBox );
procedure Payment_FillVoidTypes( VAR inComboBox : tComboBox );

procedure Payment_MakePaymentByPaymentRecord( inPayment : tPaymentRec );
procedure Payment_ReversePayment( inOrderID : string; InMOPID : String; VoidType : tVoidTypes; VoidDate : tDateTime );

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Payment_InitializePaymentRecord : tPaymentRec;
begin
   result.id := '';
   result.org_id := '';
   result.order_id := '';
   result.c_id := '';
   result.mopdate := Now;
   result.moptype := 0;
   result.mopvalue := '';
   result.mopccexpm := 0;
   result.mopccexpy := 0;
   result.mopnoc := '';
   result.mopcvv := '';
   result.mopcct := 0;
   result.mop_rev := false;
   result.amount := 0.0;
end;

function Payment_InitializeReversalRecord : tReversalRec;
begin
   result.id := '';
   result.org_id := '';
   result.order_id := '';
   result.c_id := '';
   result.rdate := now;
   result.rtype := 0;
   result.mopdate := Now;
   result.moptype := 0;
   result.mopvalue := '';
   result.mopccexpm := 0;
   result.mopccexpy := 0;
   result.mopnoc := '';
   result.mopcvv := '';
   result.mopcct := 0;
   result.mop_rev := false;
   result.amount := 0.0;
end;

function Payment_InitializeTranRecord : tTransRec;
begin
   with result do
   begin
      id := '';
      tDate := now;
      tTime := now;
      c_stid := '';
      c_id := '';
      org_id := '';
      order_id := '';
      ttype := 0;
      tmopvalue := '';
      tmoptype := 0;
      amount := 0.00;
      disp_msg := '';
   end;
end;

{
   tMethodOfPaymentTypes = ( Cash = 1, CreditCard = 2, Check = 3, CashierCheck = 4, MoneyOrder = 5, DebitCard = 6 );
   tCreditCardTypes = ( CCTNone = 0, CCTVisa = 1, CCTAmex = 2, CCTBankcard = 3, CCTDiners = 4, CCTDiscover = 5, CCTMasterCard = 6);
}

function Payment_GetPaymentTypeByPaymentName( inName : string ) : integer;
begin
   result := 0;
   if (inName = 'Cash') then
      result := integer(tMethodOfPaymentTypes.PayTypeCash);
   if (inName = 'Credit Card') then
      result := integer(tMethodOfPaymentTypes.PayTypeCreditCard);
   if (inName = 'Check') then
      result := integer(tMethodOfPaymentTypes.PayTypeCheck);
   if (inName = 'Cashier Check') then
      result := integer(tMethodOfPaymentTypes.PayTypeCashierCheck);
   if (inName = 'Money Order') then
      result := integer(tMethodOfPaymentTypes.PayTypeMoneyOrder);
   if (inName = 'Debit Card') then
      result := integer(tMethodOfPaymentTypes.PayTypeDebitCard);
   if (inName = 'Escrow') then
      result := integer(tMethodOfPaymentTypes.PayTypeEscrow);
   if (inName = 'PayPal') then
      result := integer(tMethodOfPaymentTypes.PayTypePayPal);
end;

procedure Payment_FillPaymentTypes( VAR inComboBox : tComboBox );
begin
   inComboBox.Items.Clear;
   inComboBox.Items.Add('Cash');
   inComboBox.Items.Add('Credit Card');
   inComboBox.Items.Add('Check');
   inComboBox.Items.Add('Cashier Check');
   inComboBox.Items.Add('Money Order');
   inComboBox.Items.Add('Debit Card');
   inComboBox.Items.Add('Escrow');
   inComboBox.Items.Add('PayPal');
   inComboBox.ItemIndex := 0;
end;

function Payment_GetPaymentIntegerByName( inName : string ) : integer;
begin
{
   tMethodOfPaymentTypes = ( PayTypeCash = 1, PayTypeCreditCard = 2, PayTypeCheck = 3, PayTypeCashierCheck = 4,
      PayTypeMoneyOrder = 5, PayTypeDebitCard = 6 );
}

   if (inName = 'Cash') then
      result := integer(tMethodOfPaymentTypes.PayTypeCash);

   if (inName = 'Credit Card') then
      result := integer(tMethodOfPaymentTypes.PayTypeCreditCard);

   if (inName = 'Debit Card') then
      result := integer(tMethodOfPaymentTypes.PayTypeDebitCard);

   if (inName = 'Check') then
      result := integer(tMethodOfPaymentTypes.PayTypeCheck);

   if (inName = 'Cashier Check') then
      result := integer(tMethodOfPaymentTypes.PayTypeCashierCheck);

   if (inName = 'Money Order') then
      result := integer(tMethodOfPaymentTypes.PayTypeMoneyOrder);

   if (inName = 'Escrow') then
      result := integer(tMethodOfPaymentTypes.PayTypeEscrow);

   if (inName = 'PayPal') then
      result := integer(tMethodOfPaymentTypes.PayTypePayPal);

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Payment_FillCreditCardTypes( VAR inComboBox : tComboBox );
begin
   inComboBox.Items.Clear;
   inComboBox.Items.Add('None');
   inComboBox.Items.Add('Visa');
   inComboBox.Items.Add('American Express');
   inComboBox.Items.Add('Bankcard');
   inComboBox.Items.Add('Diners Club');
   inComboBox.Items.Add('Discover');
   inComboBox.Items.Add('MasterCard');
   inComboBox.Items.Add('Visa');
   inComboBox.ItemIndex := 0;
end;
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Payment_FillVoidTypes( VAR inComboBox : tComboBox );
begin
   // see:    tVoidTypes = ( Void = 1, VoidNSF = 2, VoidRetCheck = 3, VoidCardDeclined = 4 );
   inComboBox.Items.Clear;
   inComboBox.Items.Add('Void - No Reason');
   inComboBox.Items.Add('Non Sufficient Funds');
   inComboBox.Items.Add('Returned Check');
   inComboBox.Items.Add('Card Declined');
   inComboBox.ItemIndex := 0;
end;

{ THESE TWO MUST GO TOGETHER! CHANGE ONE YOU GOTTA CHANGE THE OTHER! }

function Payment_GetVoidTypeByName( inName : string ) : tVoidTypes;
begin
   result := Void;
   if ( inName = 'Void - No Reason' ) then
      result := Void;
   if ( inName = 'Non Sufficient Funds' ) then
      result := VoidNSF;
   if ( inName = 'Non Sufficient Funds' ) then
      result := VoidNSF;
   if ( inName = 'Card Declined' ) then
      result := VoidCardDeclined;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//    tReversalTypes = ( PayReversalNSF = 1, PayReversalVoid = 2 );

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

         retVal := masterData.AddTable(masterData.dbPath + table_mop,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer ID
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Payment_GetTotalPaymentCountByOrderID( inID : string ) : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Mop +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inID );
   fQuery.Open;
   result := fQuery.FieldByName('TOT').AsInteger;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Payment_GetPaymentRecordByID( inID : string ) : tPaymentRec;
var
   fQuery : tQuery;
begin
   result := Payment_InitializePaymentRecord;
   //
   fQuery := masterData.GetQuery();
   fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Mop + ' WHERE ID = ' + masterData.WrapDBID( inID );
   fQuery.Open;
   //
   result.id := fQuery.FieldByName('ID').AsString;
   result.org_id := fQuery.FieldByName('ORG_ID').AsString;
   result.order_id := fQuery.FieldByName('ORDER_ID').AsString;
   result.c_id := fQuery.FieldByName('C_ID').AsString;
   result.mopdate := fQuery.FieldByName('MOPDATE').AsDateTime;
   result.moptype := fQuery.FieldByName('MOPTYPE').AsInteger;
   result.mopvalue := EncryptObj.DecryptString( fQuery.FieldByName('MOPVALUE').AsString );
   result.mopccexpm := fQuery.FieldByName('MOPCCEXPM').AsInteger;
   result.mopccexpy := fQuery.FieldByName('MOPCCEXPY').AsInteger;
   result.mopnoc := fQuery.FieldByName('MOPNOC').AsString;
   result.mopcvv := fQuery.FieldByName('MOPCVV').AsString;
   result.mopcct := fQuery.FieldByName('MOPCCT').AsInteger;
   result.mop_rev := fQuery.FieldByName('MOP_REV').AsBoolean;
   result.amount := fQuery.FieldByName('AMOUNT').AsCurrency;
   //
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Payment_MakePaymentByPaymentRecord( inPayment : tPaymentRec );
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery;
   try
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Mop;
      fQuery.Open();
      fQuery.Append();
      //
      fQuery.FieldByName('ID').AsString := inPayment.id;
      fQuery.FieldByName('ORG_ID').AsString := inPayment.org_id;
      fQuery.FieldByName('ORDER_ID').AsString := inPayment.order_id;
      fQuery.FieldByName('C_ID').AsString := inPayment.c_id;
      fQuery.FieldByName('MOPDATE').AsDateTime := inPayment.mopdate;
      fQuery.FieldByName('MOPTYPE').AsInteger := inPayment.moptype;
      fQuery.FieldByName('MOPVALUE').AsString := inPayment.mopvalue;
      fQuery.FieldByName('MOPCCEXPM').AsInteger := inPayment.mopccexpm;
      fQuery.FieldByName('MOPCCEXPY').AsInteger := inPayment.mopccexpy;
      fQuery.FieldByName('MOPCCT').AsInteger := inPayment.mopcct;
      fQuery.FieldByName('MOPNOC').AsString := inPayment.mopnoc;
      fQuery.FieldByName('MOPCVV').AsString := inPayment.mopcvv;
      fQuery.FieldByName('AMOUNT').AsCurrency := inPayment.amount;
      fQuery.FieldByname('MOP_REV').AsBoolean := inPayment.mop_rev;
      //
      fQuery.Post();
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Payment_ReversePayment( inOrderID : string; InMOPID : String; VoidType : tVoidTypes; VoidDate : tDateTime );
var
   fMOPQuery : tQuery;
   fRETQuery : tQuery;
begin
   fMOPQuery := masterData.GetQuery;
   fRETQuery := masterData.GetQuery;
   try
      // first, mark the old one as voided.
      fMOPQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Mop +
         ' SET MOP_REV = TRUE ' +
         ' WHERE ID = ' + masterData.WrapDBID( inMOPID );
      fMOPQuery.ExecSQL();
      // now insert the new record
      fMOPQuery.SQL.Text := 'SELECT * FROM '  + masterData.GetTable_Mop +
         ' WHERE ID  = ' + masterData.WrapDBID( inMOPID );
      fMOPQuery.Open();
      //
      fRETQuery.SQL.Text := 'SELECT * FROM '  + masterData.GetTable_Reversal;
      fRETQuery.Open();
      //
      fRETQuery.Append();
      //
      fRETQuery.FieldByName('RDATE').AsDateTime := VoidDate;
      fRETQuery.FieldByName('RTYPE').AsInteger := integer( VoidType );
      //
      fRETQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
      fRETQuery.FieldByName('ORG_ID').AsString := fMOPQuery.FieldByName('ORG_ID').AsString;
      fRETQuery.FieldByName('ORDER_ID').AsString := fMOPQuery.FieldByName('ORDER_ID').AsString;
      fRETQuery.FieldByName('C_ID').AsString := fMOPQuery.FieldByName('C_ID').AsString;
      fRETQuery.FieldByName('PAY_ID').AsString := fMOPQuery.FieldByName('ID').AsString;
      fRETQuery.FieldByName('MOPDATE').AsDateTime := fMOPQuery.FieldByName('MOPDATE').AsDateTime;
      fRETQuery.FieldByName('MOPTYPE').AsInteger := fMOPQuery.FieldByName('MOPTYPE').AsInteger;
      fRETQuery.FieldByName('MOPVALUE').AsString := EncryptObj.DecryptString( fMOPQuery.FieldByName('MOPVALUE').AsString );
      fRETQuery.FieldByName('MOPCCEXPM').AsInteger := fMOPQuery.FieldByName('MOPCCEXPM').AsInteger;
      fRETQuery.FieldByName('MOPCCEXPY').AsInteger := fMOPQuery.FieldByName('MOPCCEXPY').AsInteger;
      fRETQuery.FieldByName('MOPNOC').AsString := fMOPQuery.FieldByName('MOPNOC').AsString;
      fRETQuery.FieldByName('MOPCVV').AsString := fMOPQuery.FieldByName('MOPCVV').AsString;
      fRETQuery.FieldByName('MOPCCT').AsInteger := fMOPQuery.FieldByName('MOPCCT').AsInteger;
      fRETQuery.FieldByName('AMOUNT').AsCurrency := fMOPQuery.FieldByName('AMOUNT').AsCurrency;
      //
      fRETQuery.Post();
      //
      fMOPQuery.Close();
      fRETQuery.Close();
   finally
      FreeAndNil(fMOPQuery);
      FreeAndNil(fRETQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

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

function Payment_GetAmountVoidedByCustomerID( inID : string ) : currency;
var
   fRETQuery : tQuery;
begin
   result := 0;
   fRETQuery := masterData.GetQuery;
   try
      fRETQuery.SQL.Text := 'SELECT C_ID, SUM(AMOUNT) AS TOT FROM '  + masterData.GetTable_Reversal +
         ' WHERE C_ID = ' + masterData.WrapDBID( inID ) +
         ' GROUP BY C_ID, AMOUNT';
      fRETQuery.Open();
      //
      if (fRETQuery.RecordCount <> 0) then
         result := fRETQuery.FieldByName('TOT').AsCurrency;
      //
      fRETQuery.Close();
   finally
      FreeAndNil(fRETQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


function Payment_MovePaymentToTransactions( inOrderID : string ) : tErrorResult;
begin
{ We are NOT going to do this. The Transaction table is ONLY for transactions that are
  outside of an order. Payments are in MOP and need to stay there. }
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

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

function Payment_MakeTransactionPayment( inTransRec : tTransRec ) : tErrorResult;
var
   transQuery : tQuery;
begin
   result := Error_Init;
   transQuery := masterData.GetQuery;
   try
      transQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Transactions;
      transQuery.Open();
      transQuery.Append();
      //
      transQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
      //
      transQuery.FieldByName('TDATE').AsDateTime := inTransRec.tdate;
      transQuery.FieldByName('TTIME').AsDateTime := inTransRec.ttime;
      transQuery.FieldByName('C_STID').AsString := inTransRec.c_stid;
      transQuery.FieldByName('C_ID').AsString := inTransRec.c_id;
      transQuery.FieldByName('ORG_ID').AsString := inTransRec.org_id;
      transQuery.FieldByName('ORDER_ID').AsString := inTransRec.order_id;
      transQuery.FieldByName('TTYPE').AsInteger := inTransRec.ttype;
      transQuery.FieldByName('TMOPTYPE').AsInteger := inTransRec.tmoptype;
      transQuery.FieldByName('TMOPVALUE').AsString := inTransRec.tmopvalue;
      transQuery.FieldByName('AMOUNT').AsCurrency := inTransRec.amount;
      //
      transQuery.Post();
      transQuery.Close();
   finally
      FreeAndNil(transQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Payment_GetAmountVoidedByOrderID( inOrderID : string ) : currency;
var
   fRETQuery : tQuery;
begin
   result := 0;
   if ( inOrderID <> '' ) then
   begin
      fRETQuery := masterData.GetQuery;
      try
         fRETQuery.SQL.Text := 'SELECT ORDER_ID, SUM(AMOUNT) AS TOT FROM '  + masterData.GetTable_Reversal +
            ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID ) +
            ' GROUP BY ORDER_ID, AMOUNT';
         fRETQuery.Open();
         //
         if (fRETQuery.RecordCount <> 0) then
            result := fRETQuery.FieldByName('TOT').AsCurrency;
         //
         fRETQuery.Close();
      finally
         FreeAndNil(fRETQuery);
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ this has to go through EACH of the order products by the order id. any of them that are set to type
   of use escrow - that amount of escrow has to be deducted from the customer's escrow. }

function Payment_SubtractEscrowByOrderID( inOrderID, inCustID : string ) : tErrorResult;
var
   fOrdMOPQuery : tQuery;
   fEscrowUsed : currency;
begin
   result := Error_Init;
   fOrdMOPQuery := masterData.GetQuery;
   try

      fOrdMOPQuery.SQL.Text := 'SELECT ID, ORDER_ID, C_ID, MOPTYPE, AMOUNT FROM ' + masterData.GetTable_Mop +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
      fOrdMOPQuery.Open();
      //
      fEscrowUsed := 0;
      if (fOrdMOPQuery.RecordCount <> 0) then
      repeat
         if ( fOrdMOPQuery.FieldByName('MOPTYPE').AsInteger = integer(PayTypeEscrow) ) then
            Escrow_RemoveEscrowByCustomerID( inCustID, fOrdMOPQuery.FieldByName('AMOUNT').AsCurrency );
         fOrdMOPQuery.Next();
      until fOrdMOPQuery.Eof;
      //
      fOrdMOPQuery.Close();
   finally
      FreeAndNil(fOrdMOPQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Payment_GetAmountPaidMinusVoidByOrderID( inOrderID : string ) : currency;
var
   fMOPQuery : tQuery;
begin
   result := 0;
   fMOPQuery := masterData.GetQuery;
   try
      fMOPQuery.SQL.Text := 'SELECT C_ID, SUM(AMOUNT) AS TOT FROM '  + masterData.GetTable_Mop +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID ) +
         ' AND MOP_REV = FALSE ' +
         ' GROUP BY C_ID, AMOUNT';
      fMOPQuery.Open();
      //
      //if (fMOPQuery.RecordCount <> 0) then result := fMOPQuery.FieldByName('TOT').AsCurrency;
      if (fMOPQuery.RecordCount <> 0) then
      repeat
         result := result + fMOPQuery.FieldByName('TOT').AsCurrency;
         fMOPQuery.Next();
      until fMOPQuery.Eof;
      //
      fMOPQuery.Close();
   finally
      FreeAndNil(fMOPQuery);
   end;
end;

function Payment_GetAmountPaidByOrderID( inOrderID : string ) : currency;
var
   fMOPQuery : tQuery;
begin
   result := 0;
   fMOPQuery := masterData.GetQuery;
   try
      fMOPQuery.SQL.Text := 'SELECT C_ID, SUM(AMOUNT) AS TOT FROM '  + masterData.GetTable_Mop +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID ) +
         ' GROUP BY C_ID, AMOUNT';
      fMOPQuery.Open();
      //
      if (fMOPQuery.RecordCount <> 0) then
      repeat
         result := result + fMOPQuery.FieldByName('TOT').AsCurrency;
         fMOPQuery.Next();
      until fMOPQuery.Eof;
      //
      fMOPQuery.Close();
   finally
      FreeAndNil(fMOPQuery);
   end;
end;
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
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ this has to go through the TRANS table to find out if any money was credited OUT to the person }
function Payment_GetAmountTransCreditByOrderID( inOrderID : string ) : currency;
var
   fTransQuery : tQuery;
begin
   result := 0;
   fTransQuery := masterData.GetQuery;
   try
      fTransQuery.SQL.Text := 'SELECT ID, ORDER_ID, TTYPE, TMOPTYPE, AMOUNT FROM ' + masterData.GetTable_Transactions +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID ) +
         ' AND TTYPE = ' + IntToStr(Integer(TransCredit));
      fTransQuery.Open();
      //
      if (fTransQuery.RecordCount <> 0) then
      repeat
         result := result + fTransQuery.FieldByName('AMOUNT').AsCurrency;
         fTransQuery.Next();
      until fTransQuery.Eof;
      //
      fTransQuery.Close();
   finally
      FreeAndNil(fTransQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ ok... this method has to go through the transaction table and see if ANY escrow was given to the customer
   by this order id. if so, any of those amounts must be removed from the esrow }

function Payment_VoidPaymentEscrowByOrderID( inCustID, inOrderID : string ) : currency;
var
   fTransQuery : tQuery;
   fEscrowAmount : currency;
begin
   result := 0;
   fEscrowAmount := 0;
   fTransQuery := masterData.GetQuery;
   try
      fTransQuery.SQL.Text := 'SELECT ID, ORDER_ID, TTYPE, TMOPTYPE, AMOUNT FROM ' + masterData.GetTable_Transactions +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID ) +
         ' AND TTYPE = ' + IntToStr(Integer(TransCredit)) +
         ' AND TMOPTYPE = ' + IntTOSTr(integer(tMethodOfPaymentTypes.PayTypeEscrow));
      fTransQuery.Open();
      //
      if (fTransQuery.RecordCount <> 0) then
      repeat
         fEscrowAmount := fEscrowAmount + fTransQuery.FieldByName('AMOUNT').AsCurrency;
         fTransQuery.Next();
      until fTransQuery.Eof;
      //
      fTransQuery.Close();
   finally
      FreeAndNil(fTransQuery);
   end;
   //
   if ( fEscrowAmount > 0 ) then
   begin
      result := fEscrowAmount;
      Escrow_RemoveEscrowByCustomerID( inCustID, fEscrowAmount );
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{


      case fQuery.FieldByName('TTYPE').AsInteger of
         integer( tTransTypes.TransCredit ):
         begin
            fAmountTransCredit := fAmountTransCredit + fQuery.FieldByName('AMOUNT').AsCurrency;
            //
            case fQuery.FieldByname('TMOPTYPE').AsInteger of
               integer(tMethodOfPaymentTypes.PayTypeCash): self.FieldByname('TSTAT').AsInteger := 7;
               integer(tMethodOfPaymentTypes.PayTypeCheck): self.FieldByname('TSTAT').AsInteger := 9;
               integer(tMethodOfPaymentTypes.PayTypeCashierCheck): self.FieldByname('TSTAT').AsInteger := 10;
               integer(tMethodOfPaymentTypes.PayTypeMoneyOrder): self.FieldByname('TSTAT').AsInteger := 11;
               integer(tMethodOfPaymentTypes.PayTypeEscrow): self.FieldByname('TSTAT').AsInteger := 13;
            end;

   tTransTypes = (
      TransCredit = 1,
      TransDebit = 2
      );


         5 = Escrow

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

end.


