 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportVoidNSFByCycleUnit;

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
   toolbox_paymenttoolboxunit,
   recordstructureunit,
   toolbox_ordertoolboxunit,
   toolbox_customertoolboxunit,
   toolbox_ProductToolBoxUnit,
   Toolbox_CycleToolBoxUnit,
   masterdataunit,
   AvoBase_PercentFormUnit,
   encryptunit,
   ErrorResultUnit;

type
   tMasterDataReportVoidNSFByCycle = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      constructor Create(inMasterData: tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportVoidNSFByCycle.Create(inMasterData: tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   errResult : tErrorResult;
   sqlText : string;
   sqlWhere : string;
   cnt : integer;
   count : integer;
   fWriteQuery : tQuery;
   fQuery : tQuery;
   fREVQuery : tQuery;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;

   //
   PercentForm_Create('Gathering Report Data - One Moment Please ...', 0, 0);

   //
   fWriteQuery := masterData.GetQuery();
   fQuery := masterData.GetQuery();
   fREVQuery := masterData.GetQuery();

   // First get rid of it. Just so that we never have to worry about it.
   masterData.RemoveTable( table_report );

   // First, build the table if it doesn't exist
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'ID VARCHAR(40), ' +
         'ORDER_ID VARCHAR(40), ' +
         'C_ID VARCHAR(40), ' + // customer ID
         'ORG_ID VARCHAR(40), ' +
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
         {----------------}
         'ID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;

   //
   fWriteQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report;
   fWriteQuery.Open();

   // build the sql for the data we are going to need
	sqlText := 'SELECT O.* FROM ' + masterData.GetTable_Order + ' O' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C ON C.ID = O.C_ID';
   // Now we have to build the years selected.
   sqlWhere := '';
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30 ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND ((STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + ') ' +
         ' OR (STATUS = ' + IntToSTr(integer(OrderStatusDelinquent)) + ')))';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
      begin
         sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( cnt ) + ' ) ' +
         ' AND (NUM BETWEEN 1 AND 30 ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND ((STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + ') ' +
         ' OR (STATUS = ' + IntToSTr(integer(OrderStatusDelinquent)) + ')))';
      end;
      //
      sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( inEndYear ) + ' ) ' +
         ' AND (NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND ((STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + ') ' +
         ' OR (STATUS = ' + IntToSTr(integer(OrderStatusDelinquent)) + ')))';
   end;
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (O_TYPE = ' + IntToStr(integer(OrdTypeOrder)) + ') ' +
         ' AND (ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ') ' +
         ' AND ((STATUS = ' + IntToSTr(integer(OrderStatusClosed)) + ') ' +
         ' OR (STATUS = ' + IntToSTr(integer(OrderStatusDelinquent)) + ')))';
   end;
   // Combine
   sqlText := sqlText + sqlWhere;
   fQuery.SQL.Text := sqlText;

   //
   fQuery.Open;
   if ( fQuery.RecordCount <> 0 ) then
   repeat
      fREVQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Reversal +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( fQuery.FieldByName('ID').AsString );
      fREVQuery.Open();
      if ( fREVQuery.RecordCount <> 0 ) then
      repeat
         fWriteQuery.Append();
         //
         fWriteQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
         fWriteQuery.FieldByName('ORDER_ID').AsString := fREVQuery.FieldByName('ORDER_ID').AsString;
         fWriteQuery.FieldByName('C_ID').AsString := fREVQuery.FieldByName('C_ID').AsString;
         fWriteQuery.FieldByName('ORG_ID').AsString := fREVQuery.FieldByName('ORG_ID').AsString;
         fWriteQuery.FieldByName('PAY_ID').AsString := fREVQuery.FieldByName('PAY_ID').AsString;
         fWriteQuery.FieldByName('RDATE').AsDateTime := fREVQuery.FieldByName('RDATE').AsDateTime;
         fWriteQuery.FieldByName('RTYPE').AsInteger := fREVQuery.FieldByName('RTYPE').AsInteger;
         fWriteQuery.FieldByName('MOPDATE').AsDateTime := fREVQuery.FieldByName('MOPDATE').AsDateTime;
         fWriteQuery.FieldByName('MOPTYPE').AsInteger := fREVQuery.FieldByName('MOPTYPE').AsInteger;
         fWriteQuery.FieldByName('MOPVALUE').AsString := fREVQuery.FieldByName('MOPVALUE').AsString;
         fWriteQuery.FieldByName('MOPCCEXPM').AsInteger := fREVQuery.FieldByName('MOPCCEXPM').AsInteger;
         fWriteQuery.FieldByName('MOPCCEXPY').AsInteger := fREVQuery.FieldByName('MOPCCEXPY').AsInteger;
         fWriteQuery.FieldByName('MOPNOC').AsString := fREVQuery.FieldByName('MOPNOC').AsString;
         fWriteQuery.FieldByName('MOPCVV').AsString := fREVQuery.FieldByName('MOPCVV').AsString;
         fWriteQuery.FieldByName('MOPCCT').AsInteger := fREVQuery.FieldByName('MOPCCT').AsInteger;
         fWriteQuery.FieldByName('AMOUNT').AsCurrency := fREVQuery.FieldByName('AMOUNT').AsCurrency;
         { retVal := masterData.AddTable(masterData.dbPath + table_reversal,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer ID
            'ORG_ID VARCHAR(40), ' +
            'PAY_ID VARCHAR(40), ' + // original method of payment ID
            'RDATE DATE, ' + // reversal date
            'RTYPE INTEGER, ' + // reversal type - see tVoidTypes
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY INTEGER, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'MOPCCT INTEGER, ' + // credit card type ( see tCreditCardTypes );
            'AMOUNT MONEY', }
         //
         fWriteQuery.Post();
         //
         fREVQuery.Next();
      until fREVQuery.EOF;
      fREVQuery.Close();
      //
      fQuery.Next();
   until fQuery.Eof;

   //
   fQuery.Close();
   fWriteQuery.Close();
   fREVQuery.Close();

   //
   FreeAndNil(fWriteQuery);
   FreeAndNil(fQuery);
   FreeAndNil(fREVQuery);


   self.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report;
   //
   errResult := fMasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CUSTNAME', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'MOPTYPEDISP', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'REVTYPE', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 7, ftString);
   masterData.QueryAddCalculatedField( self, 'ONUM', 7, ftString);

   //
   PercentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportVoidNSFByCycle.destroy;
begin
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportVoidNSFByCycle.HandleCalculated(DataSet: TDataSet);
var
   CycleID : string;
begin
   CycleID := Cycle_GetCycleIDByOrderID( self.FieldByName('ORDER_ID').AsString );
   //
   DataSet.FieldByName('CUSTNAME').AsString := Customer_GetCustomerNameByCustID( self.FieldByName('C_ID').AsString );
   DataSet.FieldByName('CYCLE').AsString := Cycle_GetCycleNameByCycleID( CycleID );
   DataSet.FieldByName('ONUM').AsString := Order_GetOrderNumberByOrderID( self.FieldByName('ORDER_ID').AsString );
   //
   case Self.FieldByName('MOPTYPE').AsInteger of
      integer(PayTypeCreditCard) : DataSet.FieldByName('MOPTYPEDISP').AsString := 'Credit Card';
      integer(PayTypeCheck) : DataSet.FieldByName('MOPTYPEDISP').AsString := 'Check #' + Self.FieldByName('MOPVALUE').AsString;
      integer(PayTypeCashierCheck) : DataSet.FieldByName('MOPTYPEDISP').AsString := 'Cashier Check #' + Self.FieldByName('MOPVALUE').AsString;
      integer(PayTypeMoneyOrder) : DataSet.FieldByName('MOPTYPEDISP').AsString := 'Money Order #' + Self.FieldByName('MOPVALUE').AsString;
      integer(PayTypeDebitCard) : DataSet.FieldByName('MOPTYPEDISP').AsString := 'Debit Card';
   end;
   //
   case Self.FieldByName('RTYPE').AsInteger of
      integer(Void): DataSet.FieldByName('REVTYPE').AsString := 'Void Not Specified';
      integer(VoidNSF): DataSet.FieldByName('REVTYPE').AsString := 'Non Sufficient Funds';
      integer(VoidRetCheck): DataSet.FieldByName('REVTYPE').AsString := 'Returned Check';
      integer(VoidCardDeclined): DataSet.FieldByName('REVTYPE').AsString := 'Card Declined';
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.

{

            SELECT O.* FROM "c:\temp\ord.db" O
INNER JOIN "c:\temp\cycle.db" C
ON C.ID = O.C_ID
WHERE (
( CYEAR = 2011 )
AND (NUM BETWEEN 1 AND 17 )
AND (O_TYPE = 2)
AND (ORG_ID = "625B9380-3AD4-40E2-9B94-0EC69F70E2D3")
AND (STATUS = 2) )
}