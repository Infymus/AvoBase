 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_OrderSelectClosedOnlyListUnit;

interface uses
   inifileunit,
   masterdata_BaseDataClassUnit,
   masterdataunit,
   toolbox_CustomerToolBoxUnit,
   ErrorResultUnit,
   constantsunit,
  recordstructureunit,
   toolboxunit,
   //
	sysutils,
   classes,
   db,
   dbtables,
   bde,
   dateutils;


type
   tMasterDataReturnOrderList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
   	fSQLString : string;
      procedure UpdateByOrderList( inOrderBy : tOrderStatusTypes; inFieldSort : string; inSortOpt : string);
      procedure UpdateByCustIDAndStatus( inCustID : string; OrdStat: tOrderStatusTypes );
      constructor Create( inMasterData : tMasterData);  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReturnOrderList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   // build the sql
   fSQLString := 'SELECT * FROM ' + MasterData.Gettable_Order;
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   // Add the fields from the above SQL string
   errResult := MasterData.QueryAddFields( self );
   // Add the calculated fields
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
   masterData.QueryAddCalculatedField( self, 'CUSTNAME', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 30, ftString);
   masterData.QueryAddCalculatedField( self, 'OTYPE', 10, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 7, ftString);
   masterData.QueryAddCalculatedField( self, 'DISPSTATUS', 30, ftString);
   // even if we add active := true here, it won't activate within the create methodology.
end;

{
            'ID VARCHAR(40), ' +
            'RET_ID VARCHAR(40), ' + // The prior order ID only for returns
            'C_ID VARCHAR(40), ' + // cycle id
            'C_STID VARCHAR(40), ' + // sold to id
            'C_SHID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ONUM INTEGER, ' + // order number
            'ODATE DATE, ' +
            'OTIME TIME, ' +
            'SHIPAMT MONEY, ' +
            'SHIPTAXAMT MONEY, ' +
            'STATUS INTEGER, ' +
            'WTAX BOOLEAN, ' +
            'WSHIP BOOLEAN, ' +
            'WSHIPTAX BOOLEAN, ' + // wave shipping?
            'SHIPTAX FLOAT, ' + // shipping tax rate
            'SHOW_DISC BOOLEAN, ' +
            'O_TYPE INTEGER, ' +
            'I_MSG BLOB(240,1)',
}

procedure tMasterDataReturnOrderList.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('CUSTNAME').AsString := Customer_GetCustomerNameByCustID( Self.FieldByname('C_STID').AsString );
   //
   case Self.FieldByname('O_TYPE').AsInteger of
      integer(OrdTypeOrder) : DataSet.FieldByName('OTYPE').AsString := 'ORDER';
      integer(OrdTypeReturn) : DataSet.FieldByName('OTYPE').AsString := 'RETURN';
   end;
   //
{
      DataSet.FieldByName('CYCLE').AsString := InvoiceObj.CycleName;
      DataSet.FieldByName('ITEMS').asInteger := InvoiceObj.InvoiceLines;
      DataSet.FieldByName('TOTAL').AsCurrency := InvoiceObj.AmountTotal;
      DataSet.FieldByName('PAID').AsCurrency := InvoiceObj.AmountPaid;
      DataSet.FieldByName('DISPSTATUS').AsString := InvoiceObj.OrderStatusName;
   }
end;

{ For the Order List Only }
procedure tMasterDataReturnOrderList.UpdateByOrderList( inOrderBy : tOrderStatusTypes; inFieldSort : string; inSortOpt : string);
var
   sql : string;
begin
	self.Close();
   //
   sql := fSQLString;
   //
   case inOrderBy of
      OrderStatusOpen : sql := sql + ' WHERE STATUS = 1';
      OrderStatusClosed : sql := sql + ' WHERE STATUS = 2';
      OrderStatusCancelled : sql := sql + ' WHERE STATUS = 3';
   end;
   //
   sql := sql + ' ORDER BY ' + inFieldSort;
   //
   sql := sql + ' ' + inSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

{ For the Order Select Order By CUst ID Form Unit for OPEN ORDERS ONLY }
procedure tMasterDataReturnOrderList.UpdateByCustIDAndStatus(inCustID: string; OrdStat: tOrderStatusTypes);
var
   sql : string;
   ordStatString : string;
begin
	self.Close();
   //
{
   tOrderTypes = (OrdTypeOrder = 1, OrdTypeReturn = 2);
   tOrderStatusTypes = (OrderStatusNone = 0, OrderOpen = 1, OrderClosed = 2, OrderCancelled = 3);
}
   ordStatString := IntToStr(integer(ordStat));
   sql := fSQLString + ' WHERE STATUS = ' + ordStatString + ' AND C_STID = ' + masterData.WrapDBID( inCustID) +
      ' ORDER BY ONUM DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

end.