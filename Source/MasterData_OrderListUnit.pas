 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_OrderListUnit;

interface uses
   inifileunit,
   masterdata_BaseDataClassUnit,
   Order_InvoiceObjectUnit,
   Return_InvoiceObjectUnit,
   masterdataunit,
  recordstructureunit,
   ErrorResultUnit,
   constantsunit,
   toolboxunit,
   //
	sysutils,
   classes,
   db,
   dbtables,
   bde,
   dateutils;


type
   tMasterDataOrderList = class(tQuery)
   private
      InvoiceObj : tInvoice;
      ReturnObj : tReturnInvoice;
      //
   	procedure HandleCalculated(DataSet: TDataSet);
   public
   	fSQLString : string;
      procedure UpdateByOrderList( inSortStatusType : tOrderStatusTypes; inFieldSort : string; inSortOpt : string);
      procedure UpdateByCustIDAndStatus( inCustID : string; OrdStat: tOrderStatusTypes );
      constructor Create( inMasterData : tMasterData);  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataOrderList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
   inherited create( nil );
   //
   self.RequestLive := true;
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fSQLString := 'SELECT O.*, C.ID, C.FNAME, C.LNAME, S.ID, S.CNAME FROM ' + MasterData.Gettable_Order + ' O ' +
      ' LEFT JOIN ' + MasterData.Gettable_Customer + ' C ON O.C_STID = C.ID ' +
      ' LEFT JOIN ' + MasterData.GetTable_Cycle + ' S ON O.C_ID = S.ID ';
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   errResult := MasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CUSTNAME', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 30, ftString);
   masterData.QueryAddCalculatedField( self, 'OTYPE', 10, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 7, ftString);
   masterData.QueryAddCalculatedField( self, 'ITEMS', 1, ftInteger);
   masterData.QueryAddCalculatedField( self, 'TOTAL', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'DUE', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'PAID', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'BOI', 1, ftInteger);
   masterData.QueryAddCalculatedField( self, 'DISPSTATUS', 30, ftString);
   //
	InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
	ReturnObj := tReturnInvoice.Create( InvoiceTypeReport, nil, nil);
end;

{

SELECT O.*, C.ID, C.FNAME, C.LNAME FROM ORD O
LEFT JOIN CUST C ON O.C_STID = C.ID
WHERE STATUS = 1
ORDER BY C.FNAME DESC
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

destructor tMasterDataOrderList.destroy;
begin
   FreeAndNil(InvoiceObj);
   FreeAndNil(ReturnObj);
   //
   inherited destroy;
end;

procedure tMasterDataOrderList.HandleCalculated(DataSet: TDataSet);
var
   errResult : tErrorResult;
begin
   case Self.FieldByname('O_TYPE').AsInteger of
      integer(OrdTypeOrder):
      begin
         errResult := InvoiceObj.Load( Self.FieldByname('ID').AsString );
         DataSet.FieldByName('CUSTNAME').AsString := InvoiceObj.Customer_GetSoldToName;
         DataSet.FieldByName('ORGNAME').AsString := InvoiceObj.Org_GetOrgName;
         DataSet.FieldByName('OTYPE').AsString := 'ORDER';
         DataSet.FieldByName('CYCLE').AsString := InvoiceObj.Cycle_GetCycleName;
         DataSet.FieldByName('ITEMS').asInteger := InvoiceObj.LineItemCount;
         DataSet.FieldByName('TOTAL').AsCurrency := InvoiceObj.Amount_Total;
         DataSet.FieldByName('PAID').AsCurrency := InvoiceObj.Amount_TotalMOP - invoiceObj.Amount_VoidNSF;
         DataSet.FieldByName('DUE').AsCurrency := InvoiceObj.Amount_TotalDue;
         DataSet.FieldByname('BOI').AsInteger := InvoiceObj.BackOrderCount;
         DataSet.FieldByName('DISPSTATUS').AsString := InvoiceObj.Order_GetOrderStatusName;
      end;
      integer(OrdTypeReturn):
      begin
         ReturnObj.Load( Self.FieldByname('ID').AsString );
         DataSet.FieldByName('CUSTNAME').AsString := ReturnObj.Customer_GetSoldToName;
         DataSet.FieldByName('ORGNAME').AsString := ReturnObj.OrgName;
         DataSet.FieldByName('OTYPE').AsString := 'RETURN';
         DataSet.FieldByName('CYCLE').AsString := ReturnObj.Cycle_GetCycleName;
         DataSet.FieldByName('ITEMS').asInteger := ReturnObj.LineItemCount;
         DataSet.FieldByName('TOTAL').AsCurrency := ReturnObj.Amount_TotalRefund;
         DataSet.FieldByName('PAID').AsCurrency := ReturnObj.Amount_TotalRefund;
         DataSet.FieldByname('BOI').AsInteger := 0;
         DataSet.FieldByName('DISPSTATUS').AsString := ReturnObj.Order_GetOrderStatusName;
      end;
   end;
end;

{ For the Order List Only }
procedure tMasterDataOrderList.UpdateByOrderList( inSortStatusType : tOrderStatusTypes; inFieldSort : string; inSortOpt : string);
var
   sql : string;
begin
	self.Close();
   //
   sql := fSQLString;
   //
   case inSortStatusType of
      OrderStatusOpen : sql := sql + ' WHERE STATUS = ' + IntToStr(integer(OrderStatusOpen)) + ' OR STATUS = ' +
      	IntToStr(integer(OrderStatusDelinquent));
      OrderStatusClosed : sql := sql + ' WHERE STATUS = ' + IntToStr(integer(OrderStatusClosed)) + ' OR STATUS = ' +
      	IntToStr(integer(OrderStatusDelinquent));
      OrderStatusCancelled : sql := sql + ' WHERE STATUS = ' + IntToStr(integer(OrderStatusCancelled)) + ' OR STATUS = ' +
      	IntToStr(integer(OrderStatusDelinquent));
   end;
   //
   sql := sql + ' ORDER BY ' + inFieldSort;
   //
   sql := sql + ' ' + inSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   self.Open()
end;

{ For the Order Select Order By CUst ID Form Unit for OPEN ORDERS ONLY }
procedure tMasterDataOrderList.UpdateByCustIDAndStatus(inCustID: string; OrdStat: tOrderStatusTypes);
var
   sql : string;
   ordStatString : string;
begin
//	self.Refresh();
   //
{
   tOrderTypes = (OrdTypeOrder = 1, OrdTypeReturn = 2);
   tOrderStatusTypes = (OrderStatusNone = 0, OrderOpen = 1, OrderClosed = 2, OrderCancelled = 3, Delinquen = 4);
}
   ordStatString := IntToStr(integer(ordStat));
   sql := fSQLString + ' WHERE (STATUS = ' + ordStatString + ' OR STATUS = ' + IntToStr(integer(OrderStatusDelinquent)) +
   	') AND C_STID = ' + masterData.WrapDBID( inCustID) + ' ORDER BY ONUM DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
//   Self.Open();
end;

end.
