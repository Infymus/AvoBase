 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_OrderToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  RecordStructureUnit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  toolbox_preferencetoolboxunit,
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

function Init_OrderRec : tOrderRec;
function Init_CustOrderREc : tCustOrderRec;
function Order_GetOrderStatusByOrderID( inID : string ) : tOrderStatusTypes;
function Order_GetNextOrderNumber : integer;
function Order_GetCustomerOrderRecord( inID : string ) : tCustORderRec;
function Order_GetOrderIDByOrderNumber( inID : string ) : string;
function Order_GetTotalOpenOrdersByCustID( inID : string ) : integer;
function Order_GetTotalClosedOrdersByCustID( inID : string ) : integer;
function Order_GetTotalReturnedOrdersByCustID( inID : string ) : integer;
function Order_GetOrderNumberByOrderID( inID : string ) : string;
function Order_DeleteOrderByOrderID( inID : string ) : tErrorResult;
function Order_CancelOrderByOrderID( inID : string ) : tErrorResult;
function Order_UnCancelOrderByOrderID( inID : string ) : tErrorResult;
function Order_GetOrderTypeByOrderID( inID : string ) : tOrderTypes;
function Order_GetCustomerIdByOrderID( inID : string ) : string;
function Order_ChangeSalesCycleByOrderID( inOrderID, inCycleID, inOrgID : string ) : tErrorResult;
function Order_GetOrgIDByOrderID( inOrderID : string ) : string;
function Order_GetReturnProductAvailableCountByOrderID( inOrderID : string ) : integer;
function Order_MarkShippingRefundedByOrderID( inOrderID : string ) : tErrorResult;
function Order_GetReturnFeeAvailableCountByOrderID( inOrderID : string ) : integer;
function Order_GetReturnShippingAvailableByOrderID( inOrderID : string ) : currency;
function Order_IsReturnOpenByPriorOrderID( inOrderID : string ) : boolean;
function Order_MarkOrderDelinquent( inOrderID : string ) : tErrorResult;
function Order_CloseDelinquentOrder( inOrderID : string ) : tErrorResult;
function Order_GetOrderCount() : integer;
function Order_GetOrderTypeNameByOrderID( inOrderID : string ) : string;
function Order_GetOrderNumberNameByOrderID( inOrderID : string ) : string;
function Order_GetOrderDateByOrderID( inOrderID : string ) : tDateTime;
function Order_GetOrderCountByCycleTypeStatus( inCycleID : string; inOrderType : tOrderTypes; inStatusType : tOrderStatusTypes ) : integer;
function Order_GetOrderQueryByCycleTypeStatus( inCycleID : string; inOrderType : tOrderTypes; inStatusType : tOrderStatusTypes ) : tQuery;
function Order_GetOrderCountByCycleID( inCycleID : string ) : integer;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Init_OrderRec : tOrderRec;
begin
   result.id := '';
end;

function Init_CustOrderREc : tCustOrderRec;
begin
   result.total_orders := 0;
   result. total_amount_owed := 0;
   result.total_amount_paid := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderStatusByOrderID( inID : string ) : tOrderStatusTypes;
var
   fQuery : tQuery;
   Status : integer;
begin
   result := OrderStatusNone;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, STATUS FROM ' + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID(inID);
      fQuery.Open();

      Status := fQuery.FieldByName('STATUS').AsInteger;
      fQuery.Close();
      case Status of
         integer(tOrderStatusTypes.OrderStatusOpen) : result := OrderStatusOpen;
         integer(tOrderStatusTypes.OrderStatusClosed) : result := OrderStatusClosed;
         integer(tOrderStatusTypes.OrderStatusCancelled) : result := OrderStatusCancelled;
         integer(tOrderStatusTypes.OrderStatusDelinquent) : result := OrderStatusDelinquent;
      end;
      //
      // finish
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetNextOrderNumber : integer;
var
   fQuery : tQuery;
   LastOrdNum : Integer;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT MAX(ONUM) AS ORDNUM FROM ' + masterData.GetTable_Order;
      fQuery.Open();
      LastOrdNum := fQuery.FieldByName('ORDNUM').AsInteger;
      if ( LastOrdNum < Pref_GetInteger(tPrefConstants.SONUM, 1)-1 ) then
         LastOrdNum := Pref_GetInteger(tPrefConstants.SONUM, 1)-1;
      fQuery.Close();
      result := LastOrdNum + 1;
      //
      // finish
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetCustomerOrderRecord( inID : string ) : tCustORderRec;
begin
{ at this point, nobody is calling this... }
   result := Init_CustORderRec;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderIDByOrderNumber( inID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, ONUM FROM ' + masterData.GetTable_Order +
      	' WHERE ONUM = ' + masterData.WrapDBID( inID );
      fQuery.Open();

      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('ID').AsString;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetTotalOpenOrdersByCustID( inID : string ) : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order +
      	' WHERE C_STID = ' + masterData.WrapDBID( inID ) +
         ' AND STATUS = 1';
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetTotalClosedOrdersByCustID( inID : string ) : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order +
      	' WHERE C_STID = ' + masterData.WrapDBID( inID ) +
         ' AND STATUS = 2';
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetTotalReturnedOrdersByCustID( inID : string ) : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order +
      	' WHERE C_STID = ' + masterData.WrapDBID( inID ) +
         ' AND STATUS = 3';
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderNumberByOrderID( inID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, ONUM FROM ' + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();

      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('ONUM').AsString;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ MOST LIKELY WE WILL NOT DO THIS }
function Order_DeleteOrderByOrderID( inID : string ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   //
   fQuery := masterData.GetQuery;
   try
      // ORDERS
      // ORDER FEES
      // METHOD OF PAYMENT
      // ORDER PRODUCT
      // REVERSALS SHOULD NOT GO HERE! ONLY OPEN CAN BE DELETED
      //
{
      SQL.Text := 'DELETE FROM ORDERS WHERE ORDER_ID = ' + IntToStr( DelOrderId );
      ExecSQL();
}


   finally
   	FreeAndNil(fQuery);
   end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//    tOrderStatusTypes = (OrderStatusNone = 0, OrderOpen = 1, OrderClosed = 2, OrderCancelled = 3);

function Order_CancelOrderByOrderID( inID : string ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   //
   fQuery := masterData.GetQuery;
   try
      // ORDERS
      fQuery.sql.Text := 'UPDATE ' + masterData.GetTable_Order +
         ' SET STATUS = ' + IntToStr(Integer(OrderStatusCancelled)) +
         ' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.ExecSQL();
      // METHOD OF PAYMENT - we delete because we don't want it out standing. they should NOT have
      // taken any payments on an open order, then cancelled the order. they should cancel the order, THEN
      // do a return.
      fquery.sql.Text := 'DELETE FROM ' + masterData.GetTable_Mop +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( inID );
      fQuery.ExecSQL();
      // Back Order Products must also go
      fquery.sql.Text := 'DELETE FROM ' + masterData.GetTable_BackOrdered +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( inID );
      fQuery.ExecSQL();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_UnCancelOrderByOrderID( inID : string ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   //
   fQuery := masterData.GetQuery;
   try
      // ORDERS
      fQuery.sql.Text := 'UPDATE ' + masterData.GetTable_Order +
         ' SET STATUS = ' + IntToStr(Integer(OrderStatusOpen)) +
         ' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.ExecSQL();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderTypeByOrderID( inID : string ) : tOrderTypes;
var
   fQuery : tQuery;
begin
   result := OrdTypeNone;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, O_TYPE FROM ' + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
      begin
         if fQuery.FieldByName('O_TYPE').AsInteger = integer(OrdTypeOrder) then
            result := OrdTypeOrder;
         if fQuery.FieldByName('O_TYPE').AsInteger = integer(OrdTypeReturn) then
            result := OrdTypeReturn;
      end;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetCustomerIdByOrderID( inID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, C_STID FROM ' + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('C_STID').AsString;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_ChangeSalesCycleByOrderID( inOrderID, inCycleID, inOrgID : string ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   fQuery := masterData.GetQuery;
   try
      fQuery.SQL.Text := 'UPDATE '  + masterData.GetTable_Order +
         ' SET C_ID = '  + masterData.WrapDBID( inCycleID ) + ', ' +
         ' ORG_ID = '  + masterData.WrapDBID( inOrgID ) +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.ExecSQL();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrgIDByOrderID( inOrderID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, ORG_ID FROM ' + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('ORG_ID').AsString;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetReturnProductAvailableCountByOrderID( inOrderID : string ) : integer;
var
   OrdProdQuery : tQuery; // prior
   qtySold : integer;
   qtyFree : integer;
   qtyPrior : integer;
   //
   qtyTotalSold : integer;
   qtyTotalReturned : integer;
   qtySubTotal : integer;
begin
   result := 0;
   //
   OrdProdQuery := masterData.GetQuery;
   //
   OrdProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   OrdProdQuery.Open();
   //
   if ( OrdProdQuery.RecordCount >= 1 ) then
   repeat
      qtySold := OrdProdQuery.FieldByName('SQTY').AsInteger;
      qtyFree := OrdProdQuery.FieldByName('FQTY').AsInteger;
      qtyPrior := OrdProdQuery.FieldByName('PQTY').AsInteger;
      //
      qtyTotalSold := ( qtySold + qtyFree );
      qtyTotalReturned := ( qtyPrior ); //
      //
      // check for back-ordered here, if it IS, we want to ensure it isn't counted...
      if ( OrdProdQuery.FieldByname('BOT').AsInteger <> 0) then
         qtyTotalReturned := qtyTotalSold + 1;
      //
      qtySubTotal := ( qtyTotalSold - qtyTotalReturned );
      //
      result := result + qtySubTotal;
      //
      OrdProdQuery.Next();
   until OrdProdQuery.EOF;
   //
   OrdProdQuery.Close();
   //
   FreeAndNil(OrdProdQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_MarkShippingRefundedByOrderID( inOrderID : string ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   fQuery := masterData.GetQuery;
   try
      fQuery.SQL.Text := 'UPDATE '  + masterData.GetTable_Order +
         ' SET REFSHIP = TRUE' +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.ExecSQL();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetReturnFeeAvailableCountByOrderID( inOrderID : string ) : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   //
   try
      fQuery.SQL.Text := 'SELECT ORDER_ID, RET FROM '  + masterData.GetTable_OrderFee +
      	' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
      repeat
         if (NOT fQuery.FieldByName('RET').AsBoolean ) then
            result := result + 1;
         //
         fQuery.Next();
      until fQuery.EOF;
      //
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

{
         retVal := masterData.AddTable(masterData.dbPath + table_order_fee,
            'ID VARCHAR(40), ' +
            'R_ID VARCHAR(40), ' + // return prior order_product_ID
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'TAX FLOAT, ' + // tax rate
            'RET BOOLEAN, ' + // fee has been refunded? (returned)? if so, don't bring back on RETURN invoice
            'RETFLAG BOOLEAN, ' + // only for returns, flagged as required for return
            'RETADD BOOLEAN, '
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetReturnShippingAvailableByOrderID( inOrderID : string ) : currency;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.SQL.Text := 'SELECT ID, REFSHIP, SHIPAMT, WSHIP FROM '  + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
         if ( NOT fQuery.FieldByName('REFSHIP').AsBoolean ) then
         begin
            result := fQuery.FieldByName('SHIPAMT').AsCurrency;
            if ( fQuery.FieldByName('WSHIP').AsBoolean ) then
               result := 0;
         end;
      //
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

{
            'ID VARCHAR(40), ' +
            'RET_ID VARCHAR(40), ' + // The prior order ID only for returns
}


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_IsReturnOpenByPriorOrderID( inOrderID : string ) : boolean;
var
   fQuery : tQuery;
begin
   result := false;
   fQuery := masterData.GetQuery;
   //
   try
      fQuery.SQL.Text := 'SELECT ID, RET_ID, STATUS FROM '  + masterData.GetTable_Order +
      	' WHERE RET_ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
         if ( fQuery.FieldByName('STATUS').AsInteger = integer(OrderStatusOpen)) then
            result := true;
      //
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_MarkOrderDelinquent( inOrderID : string ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   fQuery := masterData.GetQuery;
   try
      fQuery.SQL.Text := 'UPDATE '  + masterData.GetTable_Order +
         ' SET STATUS = ' + IntToStr(integer(OrderStatusDelinquent)) +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.ExecSQL();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_CloseDelinquentOrder( inOrderID : string ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   fQuery := masterData.GetQuery;
   try
      fQuery.SQL.Text := 'UPDATE '  + masterData.GetTable_Order +
         ' SET STATUS = ' + IntToStr(integer(OrderStatusClosed)) +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.ExecSQL();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderCount() : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order;
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderTypeNameByOrderID( inOrderID : string ) : string;
var
   fQuery : tQuery;
begin
   result := 'None';
   fQuery := masterData.GetQuery;
   //
   try
      fQuery.SQL.Text := 'SELECT ID, O_TYPE FROM '  + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
         case fQuery.FieldByName('O_TYPE').AsInteger of
            integer(OrdTypeNone) : result := 'None';
            integer(OrdTypeOrder) : result := 'Order';
            integer(OrdTypeReturn) : result := 'Return';
         end;
      //
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderNumberNameByOrderID( inOrderID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '0';
   fQuery := masterData.GetQuery;
   //
   try
      fQuery.SQL.Text := 'SELECT ID, ONUM FROM '  + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName('ONUM').AsString;
      //
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function order_GetOrderDateByOrderID( inOrderID : string ) : tDateTime;
var
   fQuery : tQuery;
begin
   result := Now;
   fQuery := masterData.GetQuery;
   //
   try
      fQuery.SQL.Text := 'SELECT ID, ODATE FROM '  + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inOrderID );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName('ODATE').AsDateTime;
      //
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderCountByCycleTypeStatus( inCycleID : string; inOrderType : tOrderTypes; inStatusType : tOrderStatusTypes ) : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order +
         ' WHERE C_ID = ' + masterData.WrapDBID( inCycleID ) +
         ' AND O_TYPE = ' + IntToStr(Integer( inOrderType )) +
         ' AND STATUS = ' + IntToStr(Integer( inStatusType ));
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderQueryByCycleTypeStatus( inCycleID : string; inOrderType : tOrderTypes; inStatusType : tOrderStatusTypes ) : tQuery;
begin
   result := masterData.GetQuery();
   result.Close();
   result.SQL.Text := 'SELECT ID, C_ID, O_TYPE, STATUS FROM ' + masterData.GetTable_Order +
      ' WHERE C_ID = ' + masterData.WrapDBID( inCycleID ) +
      ' AND O_TYPE = ' + IntToStr(Integer( inOrderType )) +
      ' AND STATUS = ' + IntToStr(Integer( inStatusType ));
   result.Open();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Order_GetOrderCountByCycleID( inCycleID : string ) : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order +
         ' WHERE C_ID = ' + masterData.WrapDBID( inCycleID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;


end.


{

problem:

An order has a line item that is back ordered. AvoBase finalizes that back ordered item. There are now no other
items on the invoice that can be returned due to already being returned OR marked as back-ordered NOT AVAIL. If that
happens, any shipping and fees are then stuck in limbo.

go through


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
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost



}
