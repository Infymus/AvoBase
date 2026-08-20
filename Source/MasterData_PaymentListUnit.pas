 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
 
 unit MasterData_PaymentListUnit;

interface uses
   inifileunit,
   masterdata_BaseDataClassUnit,
   Order_InvoiceObjectUnit,
   masterdataunit,
   ErrorResultUnit,
   avobase_percentformunit,
   constantsunit,
  recordstructureunit,
   toolbox_ordertoolboxunit,
   toolboxunit,
   EncryptUnit,
   //
	sysutils,
   classes,
   db,
   dbtables,
   bde,
   dateutils;


type
   tMasterDataPaymentList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
   	fSQLString : string;
      fMasterData : tMasterData;
      procedure UpdateStatus( inOrderID : string );
      constructor Create( inMasterData : tMasterData);  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataPaymentList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( nil );
   PercentForm_Create('One Moment Please...', 0, 0);
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   fSQLString := 'SELECT * FROM ' + fMasterData.GetTable_Mop;
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'ONUM', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'PTYPE', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'PSTAT', 50, ftString);
   PercentForm_Free();
end;

{
   tMethodOfPaymentTypes = ( PayTypeCash = 1, PayTypeCreditCard = 2, PayTypeCheck = 3, PayTypeCashierCheck = 4,
      PayTypeMoneyOrder = 5, PayTypeDebitCard = 6 );


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

procedure tMasterDataPaymentList.HandleCalculated(DataSet: TDataSet);
var
   unEnc : string;
begin
	DataSet.FieldByName('ONUM').Value := Order_GetOrderNumberByOrderID( Self.FieldByname('ORDER_ID').AsString );
   //
   unEnc := EncryptObj.DecryptString( Self.FieldByName('MOPVALUE').AsString );
   case Self.FieldByname('MOPTYPE').AsInteger of
      integer(PayTypeCash): DataSet.FieldByname('PTYPE').Value := 'Cash';
      integer(PayTypeCreditCard): DataSet.FieldByname('PTYPE').Value := 'Credit Card';
      integer(PayTypeCheck): DataSet.FieldByname('PTYPE').Value := 'Check #' + unEnc;
      integer(PayTypeCashierCheck): DataSet.FieldByname('PTYPE').Value := 'Cashier Check #' + unEnc;
      integer(PayTypeMoneyOrder): DataSet.FieldByname('PTYPE').Value := 'Money Order #' + unEnc;
      integer(PayTypeDebitCard): DataSet.FieldByname('PTYPE').Value := 'Debit Card';
   end;
   //
   if (Self.FieldByname('MOP_REV').AsBoolean) then
      DataSet.FieldByName('PSTAT').Value := 'Payment Voided'
   else
      DataSet.FieldByName('PSTAT').Value := '';
end;

{ For the Order List Only }
procedure tMasterDataPaymentList.UpdateStatus( inOrderID : string );
var
   sql : string;
begin
	self.Close();
   //
   // only show methods of payments that match the order and haven't already been reversed.
   sql := fSQLString + ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;


end.
