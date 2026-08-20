 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_ProductToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  toolbox_cycletoolboxunit,
  Toolbox_TaxToolBoxUnit,
  RecordStructureUnit,
  //
  db,
  dbtables,
  bde,
  sysutils,
  math,
  classes,
  forms,
  dateutils,
  inifiles,
  stdctrls;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetBackOrderItemCountByCustomerID( inCustID : string ) : integer;
function Product_GetBackOrderItemCountByCustomerIDAndOrgID( inCustID, InORGID : string ) : integer;
function Product_GetBackOrderProdNameByID( inBOID : string ) : string;
function Product_GetBackOrderProdNumByID( inBOID : string ) : string;
function Product_GetCycleIDByOrderProductID( inID : string ) : string;
function Product_GetLineItemFreeByID( inProdID : string ) : boolean;
function Product_GetOrderIDByBackOrderProductID( inProdID : string ) : string;
function Product_GetOrderNumberByOrderID( inID : string ) : integer;
function Product_GetOrderProductAmountById( inID : string ) : currency;
function Product_GetPBOStatusTypeByID( inID : string ) : Integer;
function Product_GetProductByProdNumCycleID( inProdNum, inCycleID : string) : tProdRec;
function Product_GetProductByProductID( inID : string ) : tProdRec;
function Product_GetProductIDByNumCycleOrg( inNum, inCycleID, inOrgID : string ): string;
function Product_InitProdRec : tProdRec;
function Product_MarkOrderProductDelivered( InProdID,InBOProdID : string; InOrderStatus : tOrderStatusTypes ) : tErrorResult;
function Product_MarkOrderProductNotAvailable( InProdID,InBOProdID : string; InOrderStatus : tOrderStatusTypes ) : tErrorResult;
function Product_MarkPBOReturnedToStatus( inPBOId : string; inStatus : tProdReturnStatus ) : tErrorResult;
function Product_MarkPriorProductAsReturned( cOrderID, pOrderID : string ) : tErrorResult;
function Product_MoveBackOrderedProduct( inOrderID, inCustID : string ) : tErrorResult;
function Product_MoveOrderProductToProduct( inOrderID : string ) : tErrorResult;
function Product_MoveOrderProductToReturnManager( inOrderID : string ) : boolean;
function Product_MovePBOToProductInventory( inPBOId : string ): tErrorResult;
function Product_ReduceQTYONHANDByProductID( inOrgID, inCID, inProdNum : String; qtySold : integer ) : tErrorResult;
function Product_RecordCount : integer;
function Product_ReturnProductRecordCount : integer;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_InitProdRec : tProdRec;
begin
   result.id := '';
   result.isactive := false;
   result.c_id := '';
   result.org_id := '';
   result.num := '';
   result.qty := 0;
   result.name := '';
   result.descr := '';
   result.prodn1 := '';
   result.prodn2 := '';
   result.prodn3 := '';
   result.prodn4 := '';
   result.amount := 0.00;
   result.rcost := 0.00;
   result.scost := 0.00;
   result.sellat := 0.00;
   result.ycost := 0.00;
   result.mTaxID := '';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetProductByProductID( inID : string ) : tProdRec;
var
   fQuery : tQuery;
begin
   result := Product_InitProdRec;
   //
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Product +
      ' WHERE ID = ' + masterData.WrapDBID( inID );
   fquery.Open();
   if ( fQuery.RecordCount <> 0 ) then
   begin
      result.id := fQuery.FieldByName('ID').AsString;
      result.isactive := fQuery.FieldByName('ISACTIVE').AsBoolean;
      result.c_id := fQuery.FieldByName('C_ID').AsString;
      result.org_id := fQuery.FieldByName('ORG_ID').AsString;
      result.num := fQuery.FieldByName('NUM').AsString;
      result.qty := fQuery.FieldByName('QTY').AsInteger;
      result.name := fQuery.FieldByName('NAME').AsString;
      result.descr := fQuery.FieldByName('DESCR').AsString;
      result.prodn1 := fQuery.FieldByName('PRODN1').AsString;
      result.prodn2 := fQuery.FieldByName('PRODN2').AsString;
      result.prodn3 := fQuery.FieldByName('PRODN3').AsString;
      result.prodn4 := fQuery.FieldByName('PRODN4').AsString;
      result.amount := fQuery.FieldByName('AMOUNT').AsCurrency;
      result.sellat := fQuery.FieldByName('SELLAT').AsCurrency;
      result.ycost := fQuery.FieldByName('YCOST').AsCurrency;
      if ( result.sellAt = 0 ) then
         result.sellAt := result.amount;
      result.mTaxID := fQuery.FieldByName('TAXID').AsString;
   end;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

function Product_GetProductByProdNumCycleID( inProdNum, inCycleID : string) : tProdRec;
var
   fQuery : tQuery;
begin
   result := Product_InitProdRec;
   //
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Product +
      ' WHERE NUM = ' + masterData.WrapDBID( inProdNum ) +
      ' AND C_ID = '  + masterData.WrapDBID( inCycleID );
   fquery.Open();
   if ( fQuery.RecordCount <> 0 ) then
   begin
      result.id := fQuery.FieldByName('ID').AsString;
      result.isactive := fQuery.FieldByName('ISACTIVE').AsBoolean;
      result.c_id := fQuery.FieldByName('C_ID').AsString;
      result.org_id := fQuery.FieldByName('ORG_ID').AsString;
      result.num := fQuery.FieldByName('NUM').AsString;
      result.qty := fQuery.FieldByName('QTY').AsInteger;
      result.name := fQuery.FieldByName('NAME').AsString;
      result.descr := fQuery.FieldByName('DESCR').AsString;
      result.prodn1 := fQuery.FieldByName('PRODN1').AsString;
      result.prodn2 := fQuery.FieldByName('PRODN2').AsString;
      result.prodn3 := fQuery.FieldByName('PRODN3').AsString;
      result.prodn4 := fQuery.FieldByName('PRODN4').AsString;
      result.amount := fQuery.FieldByName('AMOUNT').AsCurrency;
      result.sellat := fQuery.FieldByName('SELLAT').AsCurrency;
      result.ycost := fQuery.FieldByName('YCOST').AsCurrency;
      if ( result.sellAt = 0 ) then
         result.sellAt := result.amount;
      result.mTaxID := fQuery.FieldByName('TAXID').AsString;
   end;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This moves products OUT of the OrderProduct table once the order is closed and into Products

function Product_MoveOrderProductToProduct( inOrderID : string ) : tErrorResult;
var
   ordProdQuery : tQuery;
   prodQuery : tQuery;
   erResult : tErrorResult;
   totProdSold : integer;
begin
   result := Error_Init;
   //
   ordProdQuery := masterData.GetQuery();
   prodQuery := masterData.GetQuery();
   //
   ordProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   ordProdQuery.Open();
   //
   repeat
   	// Some first calculations
      totProdSold := 0;
      totProdSold := ordProdQuery.FieldByName('SQTY').AsInteger +
      	ordProdQuery.FieldByname('FQTY').AsInteger;
      // first, make sure the same product doesn't already exist
      prodQuery.Close();
      prodQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Product +
         ' WHERE ORG_ID = ' + masterData.WrapDBID( ordProdQuery.FieldByName('ORG_ID').AsString ) +
         ' AND C_ID = ' + masterData.WrapDBID( ordProdQuery.FieldByName('C_ID').AsString ) +
         ' AND NUM = ' + masterData.WrapDBID( ordProdQuery.FieldByName('NUM').AsString );
      prodQuery.Open();
      if ( prodQuery.RecordCount = 0 ) then
      begin
         prodQuery.Close();
         prodQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Product;
         prodQuery.Open();
         //
         prodQuery.Append();
         //
         prodQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
         prodQuery.FieldByName('ISACTIVE').AsBoolean := true;
         prodQuery.FieldByName('C_ID').AsString := ordProdQuery.FieldByName('C_ID').AsString;
         prodQuery.FieldByName('ORG_ID').AsString := ordProdQuery.FieldByName('ORG_ID').AsString;
         prodQuery.FieldByName('CYCLENAME').AsString := Cycle_GetCycleNameByCycleID( ordProdQuery.FieldByName('C_ID').AsString );
         prodQuery.FieldByName('NUM').AsString := ordProdQuery.FieldByName('NUM').AsString;
         prodQuery.FieldByName('QTY').AsInteger := 0;
         prodQuery.FieldByName('NAME').AsString := ordProdQuery.FieldByName('NAME').AsString;
         prodQuery.FieldByName('DESCR').AsString := ordProdQuery.FieldByName('DESCR').AsString;
         prodQuery.FieldByName('PRODN1').AsString := ordProdQuery.FieldByName('PRODN1').AsString;
         prodQuery.FieldByName('PRODN2').AsString := ordProdQuery.FieldByName('PRODN2').AsString;
         prodQuery.FieldByName('PRODN3').AsString := ordProdQuery.FieldByName('PRODN3').AsString;
         prodQuery.FieldByName('PRODN4').AsString := ordProdQuery.FieldByName('PRODN4').AsString;
         prodQuery.FieldByName('TAXID').AsString := ordProdQuery.FieldByName('TAXID').AsString;
         prodQuery.FieldByName('AMOUNT').AsCurrency := ordProdQuery.FieldByName('RCOST').AsCurrency;
         prodQuery.FieldByName('SELLAT').AsCurrency := ordProdQuery.FieldByName('RCOST').AsCurrency;
         prodQuery.FieldByName('YCOST').AsCurrency := ordProdQuery.FieldByName('YCOST').AsCurrency;
         //
         prodQuery.Post();
      end else
      	begin
         	// the product DID actually exist. So we need to see what the QTY of the product was
            // and reduce that QTY ON HAND.
            erResult := Product_ReduceQTYONHANDByProductID(
               ordProdQuery.FieldByName('ORG_ID').AsString,
               ordProdQuery.FieldByName('C_ID').AsString,
               ordProdQuery.FieldByName('NUM').AsString,
               totProdSold);
            if ( erResult.errorResult ) then
            begin
               Error_Log( erResult, false);
            end;
         end;
      ordProdQuery.Next();
   until ordProdQuery.Eof;
   //
   prodQuery.Close();
   ordProdQuery.Close();
   //
   FreeAndNil( ordProdQuery );
   FreeAndNil( prodQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// The passed in Product ID is from the OrderProduct not the Product. Since those IDs are
// different, we have to try and match them some fucking how. Brilliant forward thinking Hoenie.

{
THIS HAS TO BE FIXED BEFORE YOU CAN MOVE ON.

YOU EITHER TWO TWO THINGS:

1. YOU CHANGE THIS METHOD TO BE A HACK - IT GOES TO THE PRODUCT TABLE AND SEARCHS BY NAME, ORG_ID, CYCLE_ID AND IF IT
   MATCHES, THAT'S THE ONE YOU HAVE.

2. YOU ADD A NEW FIELD TO ORDERPRODUCTS.DB CALLED PRODUCT_ID (OR SOMETHING). WHEN A PRODUCT IS PULLED FROM THE
	PRODUCT DATABASE INTO THE ORDERPRODUCT.DB - THIS FIELD IS FILLED OUT. THEN WHEN YOU DO THIS FIELD BELOW
   YOU DON'T HAVE TO SEARCH, YOU SIMPLY SELECT * FROM WHERE ID = .

   THINK ABOUT IT.

   fuck.


   the issue is that
}

function Product_ReduceQTYONHANDByProductID( inOrgID, inCID, inProdNum : String; qtySold : integer ) : tErrorResult;
var
   prodQTYQuery : tQuery;
   qty : integer;
   prodRec : tProdRec;
begin
   result := Error_Init;
   //
	//   prodRec := Product_FindProductByProductRecord( prodRec );

   prodQTYQuery := masterData.GetQuery();
   //
   prodQTYQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Product +
      ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID ) +
      ' AND C_ID = '  + masterData.WrapDBID( inCID ) +
      ' AND NUM = ' + masterData.WrapDBID( inProdNum );
   prodQTYQuery.Open();
   if ( prodQTYQuery.RecordCount <> 0 ) then
   begin
      if ( prodQTYQuery.RecordCount = 1 ) then
      begin
         qty := prodQTYQuery.FieldByName('QTY').AsInteger;
         if ( qty >= 1 ) then
         begin
            dec( qty, qtySold );
            if ( qty < 0 ) then
            	qty := 0;
            prodQTYQuery.Edit();
            prodQTYQuery.FieldByName('QTY').AsInteger := qty;
            prodQTYQuery.Post();
         end;
      end else
         begin
            result.errorMessage := 'Multiple Result Sets Returned';
            result.errorResult := true;
         end;
   end else
   	begin
      	result.errorMessage := 'Unable to find Product to update QTY';
         result.errorResult := true;
      end;
   //
   prodQTYQuery.Close();
   //
   FreeAndNil( prodQTYQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_MoveBackOrderedProduct( inOrderID, inCustID : string ) : tErrorResult;
var
   ordProdQuery : tQuery;
   backOrderQuery : tQuery;
begin
   result := Error_Init;
   //
   ordProdQuery := masterData.GetQuery();
   backOrderQuery := masterData.GetQuery();
   //
   ordProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   ordProdQuery.Open();
   //
   backOrderQuery.Close();
   backOrderQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_BackOrdered +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   backOrderQuery.ExecSQL();
   //
   backOrderQuery.Close();
   backOrderQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_BackOrdered;
   backOrderQuery.Open();
   //
   repeat
      // We only care about items that are BOT types 1 and 2.
      // tBackOrderTypes = ( BONone = 0, BOOrdered = 1, BONotShipped = 2, BONoLongerAvail = 3);
      if (ordProdQuery.FieldByName('BOT').AsInteger = 1) OR (ordProdQuery.FieldByName('BOT').AsInteger = 2) then
      begin
         backOrderQuery.Append();
         //
         backOrderQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
         backOrderQuery.FieldByName('OPT_ID').AsString := ordProdQuery.FieldByName('ID').AsString;
         backOrderQuery.FieldByName('ORDER_ID').AsString := ordProdQuery.FieldByName('ORDER_ID').AsString;
         backOrderQuery.FieldByName('C_STID').AsString := inCustID;
         backOrderQuery.FieldByName('C_ID').AsString := ordProdQuery.FieldByName('C_ID').AsString;
         backOrderQuery.FieldByName('ORG_ID').AsString := ordProdQuery.FieldByName('ORG_ID').AsString;
         backOrderQuery.FieldByName('NUM').AsString := ordProdQuery.FieldByName('NUM').AsString;
         backOrderQuery.FieldByName('BOT').AsInteger := ordProdQuery.FieldByName('BOT').AsInteger;
         backOrderQuery.FieldByName('LIFREE').AsBoolean := ordProdQuery.FieldByName('LIFREE').AsBoolean;
         backOrderQuery.FieldByName('TAX').AsFloat := ordProdQuery.FieldByName('TAX').AsFloat;
         backOrderQuery.FieldByName('SQTY').AsInteger := ordProdQuery.FieldByName('SQTY').AsInteger;
         backOrderQuery.FieldByName('NAME').AsString := ordProdQuery.FieldByName('NAME').AsString;
         backOrderQuery.FieldByName('STATUS').AsInteger := integer(tBackOrderStatus.BOSPending);
         backOrderQuery.FieldByName('ONUM').AsInteger := Product_GetOrderNumberByOrderID( inOrderID );
         backOrderQuery.FieldByName('DESCR').AsString := ordProdQuery.FieldByName('DESCR').AsString;
         backOrderQuery.FieldByName('PRODN1').AsString := ordProdQuery.FieldByName('PRODN1').AsString;
         backOrderQuery.FieldByName('PRODN2').AsString := ordProdQuery.FieldByName('PRODN2').AsString;
         backOrderQuery.FieldByName('PRODN3').AsString := ordProdQuery.FieldByName('PRODN3').AsString;
         backOrderQuery.FieldByName('PRODN4').AsString := ordProdQuery.FieldByName('PRODN4').AsString;
         backOrderQuery.FieldByName('TAXID').AsString := ordProdQuery.FieldByName('TAXID').AsString;
         backOrderQuery.FieldByName('SCOST').AsCurrency := ordProdQuery.FieldByName('SCOST').AsCurrency;
         backOrderQuery.FieldByName('RCOST').AsCurrency := ordProdQuery.FieldByName('RCOST').AsCurrency;
         backOrderQuery.FieldByName('YCOST').AsCurrency := ordProdQuery.FieldByName('YCOST').AsCurrency;
         //
         backOrderQuery.Post();
      end;
      ordProdQuery.Next();
   until ordProdQuery.Eof;
   //
   backOrderQuery.Close();
   ordProdQuery.Close();
   //
   FreeAndNil( ordProdQuery );
   FreeAndNil( backOrderQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetBackOrderItemCountByCustomerID( inCustID : string ) : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_BackOrdered  +
      ' WHERE C_STID = ' + masterData.WrapDBID( inCustID );
   fquery.Open();
   result := fQuery.FieldByName('TOT').AsInteger;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_RecordCount : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Product;
   fquery.Open();
   result := fQuery.FieldByName('TOT').AsInteger;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_ReturnProductRecordCount : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Returns;
   fquery.Open();
   result := fQuery.FieldByName('TOT').AsInteger;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetBackOrderItemCountByCustomerIDAndOrgID( inCustID, InORGID : string ) : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_BackOrdered  +
      ' WHERE C_STID = ' + masterData.WrapDBID( inCustID ) +
      ' AND ORG_ID = ' + masterData.WrapDBID( InORGID );
   fquery.Open();
   result := fQuery.FieldByName('TOT').AsInteger;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetOrderIDByBackOrderProductID( inProdID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   //
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT ID, ORDER_ID FROM ' + masterData.GetTable_BackOrdered +
      ' WHERE ID = ' + masterData.WrapDBID( inProdID );
   fquery.Open();
   if ( fQuery.RecordCount <> 0 ) then
      result := fQuery.FieldByName('ORDER_ID').AsString;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{

   tBackOrderTypes = ( BONone = 0, BOOrdered = 1, BONotShipped = 2, BONoLongerAvail = 3);

   tBackOrderStatus = ( BOSPending = 0, BOSDelivered = 1, BOSNotAvail = 2);


   1. if the order status is closed, the back order item is flagged as BOSNotAvail, the original order is not
      touched.
   2. if the order status is OPEN, then the order_product back order item
   3. if the order status is OPEN, change the "No Charge" to "Charge".
}
function Product_MarkOrderProductNotAvailable( InProdID,InBOProdID : string; InOrderStatus : tOrderStatusTypes ) : tErrorResult;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery;
   //
   if ( inOrderStatus = OrderStatusOpen ) then
   begin
      // First the GetTable_Order_Product
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Order_Product +
         ' SET BOT = 3, LIFREE = TRUE ' +
         ' WHERE ID = ' + masterData.WrapDBID( inProdID );
      fquery.ExecSQL();
      // Second the GetTable_BackOrdered
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_BackOrdered +
         ' SET STATUS = 2' +
         ' WHERE ID = ' + masterData.WrapDBID( InBOProdID );
      fquery.ExecSQL();
   end;
   //
   if ( inOrderStatus = OrderStatusClosed) then
   begin
      // First the GetTable_Order_Product
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Order_Product +
         ' SET BOT = 3' +
         ' WHERE ID = ' + masterData.WrapDBID( inProdID );
      fquery.ExecSQL();
      // Second the GetTable_BackOrdered
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_BackOrdered +
         ' SET STATUS = 2' +
         ' WHERE ID = ' + masterData.WrapDBID( InBOProdID );
      fquery.ExecSQL();
   end;
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

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
            'PQTY INTEGER, ' + // prioer re
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
}

function Product_GetLineItemFreeByID( inProdID : string ) : boolean;
var
   fQuery : tQuery;
begin
   result := false;
   //
   fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'SELECT ID, LIFREE FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ID = ' + masterData.WrapDBID( inProdID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0 ) then
      result := fQuery.FieldByname('LIFREE').AsBoolean;
   fQuery.Close();
   //
   FreeAndNil(fQuery);
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
   1. If the order status is CLOSED, then ONLY the Back Order Item is flagged as BOSDelivered, the original order is
      not touched.
   2. If the order status is OPEN, then the order_product back order is removed.
   3. if the order status is OPEN, change the "No Charge" to "Charge".
}
function Product_MarkOrderProductDelivered( InProdID,InBOProdID : string; InOrderStatus : tOrderStatusTypes ) : tErrorResult;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery;
   //
   if ( inOrderStatus = OrderStatusOpen ) then
   begin
      // First the GetTable_Order_Product
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Order_Product +
         ' SET BOT = 0, LIFREE = FALSE' +
         ' WHERE ID = ' + masterData.WrapDBID( inProdID );
      fquery.ExecSQL();
      // Second the GetTable_BackOrdered
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_BackOrdered +
         ' SET STATUS = 1' +
         ' WHERE ID = ' + masterData.WrapDBID( InBOProdID );
      fquery.ExecSQL();
   end;
   //
   if ( inOrderStatus = OrderStatusClosed) then
   begin
      // First the GetTable_Order_Product
      // --> WE DO NOTHING THE ORDER IS FINALIZED <--
      // Second the GetTable_BackOrdered
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_BackOrdered +
         ' SET STATUS = 2' +
         ' WHERE ID = ' + masterData.WrapDBID( InBOProdID );
      fquery.ExecSQL();
   end;
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetBackOrderProdNumByID( inBOID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   //
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT ID, NUM, NAME FROM ' + masterData.GetTable_BackOrdered +
      ' WHERE ID = ' + masterData.WrapDBID( inBOID );
   fquery.Open();
   if ( fQuery.RecordCount <> 0 ) then
      result := fQuery.FieldByName('NUM').AsString;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetBackOrderProdNameByID( inBOID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   //
   fQuery := masterData.GetQuery;
   fQuery.SQL.Text := 'SELECT ID, NUM, NAME FROM ' + masterData.GetTable_BackOrdered +
      ' WHERE ID = ' + masterData.WrapDBID( inBOID );
   fquery.Open();
   if ( fQuery.RecordCount <> 0 ) then
      result := fQuery.FieldByName('NAME').AsString;
   fQuery.Close();
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ OK:

   1. open the table_order_product by inOrderID
   2. go through each item, and pull out the R_ID (the return prior order_product_id)
   3. take the R_ID, and open ANOTHER query to the table_order_product and pull that record
      -> take that record, take the RQTY field and add it with the RQTY of your first record
      -> save that record out. now the prior product's RQTY is incremented.
}
function Product_MarkPriorProductAsReturned( cOrderID, pOrderID : string ) : tErrorResult;
var
   pOrdProdQuery : tQuery; // prior
   cOrdProdQuery : tQuery; // current
   prQTY : integer;
   rQTY : integer;
   trQTY : integer;
begin
   result := Error_Init;
   //
   pOrdProdQuery := masterData.GetQuery;
   cOrdProdQuery := masterData.GetQuery;
   //
   cOrdProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( cOrderID );
   cOrdProdQuery.Open();
   if ( cOrdProdQuery.RecordCount >= 1 ) then
   repeat
      // total returned
      rQTY := cOrdProdQuery.FieldByName('RQTY').AsInteger;
      // go find prior order product from prior order
      pOrdProdQuery.Close();
      pOrdProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
         ' WHERE ID = ' + masterData.WrapDBID( cOrdProdQuery.FieldByName('R_ID').AsString );
      pOrdProdQuery.Open();
      //
      if ( cOrdProdQuery.RecordCount >= 1 ) then
      begin
         prQTY := pOrdProdQuery.FieldByName('RQTY').AsInteger;
         // add them up
         trQTY := ( prQTY + rQTY );
         // post them out
         pOrdProdQuery.Edit();
         pOrdProdQuery.FieldByName('PQTY').AsInteger := trQTY;
         pOrdProdQuery.Post();
         pOrdProdQuery.Close();
      end;
      //
      cOrdProdQuery.Next();
   until cOrdProdQuery.EOF;
   //
   cOrdProdQuery.Close();
   pOrdProdQuery.Close();
   //
   FreeAndNil(pOrdProdQuery);
   FreeAndNil(cOrdProdQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetOrderNumberByOrderID( inID : string ) : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, ONUM FROM ' + masterData.GetTable_Order +
      	' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();

      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('ONUM').AsInteger;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//    tBackOrderTypes = ( BONone = 0, BOOrdered = 1, BONotShipped = 2, BONoLongerAvail = 3);

function Product_MoveOrderProductToReturnManager( inOrderID : string ) : boolean;
var
   ordProdQuery : tQuery;
   returnOrderQuery : tQuery;
   boType : integer;
begin
   result := false;
   //
   ordProdQuery := masterData.GetQuery();
   returnOrderQuery := masterData.GetQuery();
   //
   ordProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   ordProdQuery.Open();
   //
   returnOrderQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Returns;
   returnOrderQuery.Open();
   //
   repeat
      boType := ordProdQuery.FieldByName('BOT').AsInteger;
      //
      if ( boType = 0 ) then
      begin
         returnOrderQuery.Append();
         //
         returnOrderQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
         returnOrderQuery.FieldByName('C_ID').AsString := ordProdQuery.FieldByName('C_ID').AsString;
         returnOrderQuery.FieldByName('ORG_ID').AsString := ordProdQuery.FieldByName('ORG_ID').AsString;
         returnOrderQuery.FieldByName('NUM').AsString := ordProdQuery.FieldByName('NUM').AsString;
         returnOrderQuery.FieldByName('QTY').AsInteger := ordProdQuery.FieldByName('RQTY').AsInteger;
         returnOrderQuery.FieldByName('NAME').AsString := ordProdQuery.FieldByName('NAME').AsString;
         returnOrderQuery.FieldByName('DESCR').AsString := ordProdQuery.FieldByName('DESCR').AsString;
         returnOrderQuery.FieldByName('PRODN1').AsString := ordProdQuery.FieldByName('PRODN1').AsString;
         returnOrderQuery.FieldByName('PRODN2').AsString := ordProdQuery.FieldByName('PRODN2').AsString;
         returnOrderQuery.FieldByName('PRODN3').AsString := ordProdQuery.FieldByName('PRODN3').AsString;
         returnOrderQuery.FieldByName('PRODN4').AsString := ordProdQuery.FieldByName('PRODN4').AsString;
         returnOrderQuery.FieldByName('TAXID').AsString := ordProdQuery.FieldByName('TAXID').AsString;
         returnOrderQuery.FieldByName('RCOST').AsCurrency := ordProdQuery.FieldByName('RCOST').AsCurrency;
         returnOrderQuery.FieldByName('YCOST').AsCurrency := ordProdQuery.FieldByName('YCOST').AsCurrency;
         returnOrderQuery.FieldByName('STATUS').AsInteger := integer(tProdReturnStatus.prodRetPending );
         //
         returnOrderQuery.Post();
         result := true;
      end;
      //
      ordProdQuery.Next();
   until ordProdQuery.Eof;
   //
   returnOrderQuery.Close();
   ordProdQuery.Close();
   //
   FreeAndNil( ordProdQuery );
   FreeAndNil( returnOrderQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This will move a product out of table_returntable - and into table_product
function Product_MovePBOToProductInventory( inPBOId : string ): tErrorResult;
var
   PBOQuery : tQuery;
   ProdQuery : tQuery;
   prodID : string;
   pQTY : integer;
   nQTY : integer;
begin
   result := Error_Init;
   //
   PBOQuery := masterData.GetQuery();
   ProdQuery := masterData.GetQuery();
   //
   PBOQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Returns +
      ' WHERE ID = ' + masterData.WrapDBID( inPBOId );
   PBOQuery.Open();
   //
   if ( PBOQuery.RecordCount <> 0 ) then
   begin
      // things to watch for: does the product already exist by NUM/CYCLE/ORG? If so, update the quantities, else, add it.
      prodID := Product_GetProductIDByNumCycleOrg( PBOQuery.FieldByname('NUM').AsString, PBOQuery.FieldByname('C_ID').AsString,
         PBOQuery.FieldByname('ORG_ID').AsString);
      if ( prodID <> '' ) then
      begin
         ProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Product +
            ' WHERE ID = ' + masterData.WrapDBID( prodID );
         ProdQuery.Open();
         // Product already exists, so let's pull it, ADD QTY to it and save it.
         pQTY := ProdQuery.FieldByname('QTY').AsInteger;
         nQTY := PBOQuery.FieldByname('QTY').AsInteger;
         //
         ProdQuery.Edit();
         ProdQuery.FieldByName('QTY').AsInteger := ( pQTY + nQTY );
         ProdQuery.Post();
         //
         ProdQuery.CLose();
      end else
         begin
            // Product DOES NOT exist, let's add it.
            ProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Product;
            ProdQuery.Open();
            ProdQuery.Append();
            //
            ProdQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
            //
            ProdQuery.FieldByName('C_ID').AsString := PBOQuery.FieldByname('C_ID').AsString;
            ProdQuery.FieldByName('ISACTIVE').AsBoolean := True;
            ProdQuery.FieldByName('C_ID').AsString := PBOQuery.FieldByname('C_ID').AsString;
            ProdQuery.FieldByName('ORG_ID').AsString := PBOQuery.FieldByname('ORG_ID').AsString;
            ProdQuery.FieldByName('CYCLENAME').AsString := Cycle_GetCycleNameByCycleID( PBOQuery.FieldByname('C_ID').AsString );
            ProdQuery.FieldByName('NUM').AsString := PBOQuery.FieldByname('NUM').AsString;
            ProdQuery.FieldByName('QTY').AsInteger := PBOQuery.FieldByname('QTY').AsInteger;
            ProdQuery.FieldByName('NAME').AsString := PBOQuery.FieldByname('NAME').AsString;
            ProdQuery.FieldByName('DESCR').AsString := PBOQuery.FieldByname('DESCR').AsString;
            ProdQuery.FieldByName('PRODN1').AsString := PBOQuery.FieldByname('PRODN1').AsString;
            ProdQuery.FieldByName('PRODN2').AsString := PBOQuery.FieldByname('PRODN2').AsString;
            ProdQuery.FieldByName('PRODN3').AsString := PBOQuery.FieldByname('PRODN3').AsString;
            ProdQuery.FieldByName('PRODN4').AsString := PBOQuery.FieldByname('PRODN4').AsString;
            ProdQuery.FieldByName('TAXID').AsString := PBOQuery.FieldByname('TAXID').AsString;
            //ProdQuery.FieldByName('PPAGE').AsString := PBOQuery.FieldByname('PPAGE').AsString;
            ProdQuery.FieldByName('AMOUNT').AsCurrency := PBOQuery.FieldByname('RCOST').AsCurrency;
            ProdQuery.FieldByName('SELLAT').AsCurrency := PBOQuery.FieldByname('RCOST').AsCurrency;
            ProdQuery.FieldByName('YCOST').AsCurrency := PBOQuery.FieldByname('YCOST').AsCurrency;
{
         retVal := masterData.AddTable(masterData.dbPath + table_returntable,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // campaign ID
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' + // total quantity returned
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'STATUS INTEGER, ' + // status see - tProdReturnStatus
            'RCOST MONEY',  // retail cost

         retVal := masterData.AddTable(masterData.dbPath + table_product,
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'AMOUNT MONEY',
}
            //
            ProdQuery.Post();
         end;

      // Now, mark product finished
      Product_MarkPBOReturnedToStatus( inPBOId, prodRetInv );
   end;

   //
   PBOQuery.Close();
   ProdQuery.Close();
   //
   FreeAndNil( PBOQuery );
   FreeAndNil( ProdQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_MarkPBOReturnedToStatus( inPBOId : string; inStatus : tProdReturnStatus ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Returns +
         ' SET STATUS = ' + IntToStr( integer( tProdReturnStatus.prodRetOEM )) +
      	' WHERE ID = ' + masterData.WrapDBID( inPBOId );
      fQuery.ExecSQL();
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetProductIDByNumCycleOrg( inNum, inCycleID, inOrgID : string ): string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, C_ID, ORG_ID, NUM FROM ' + masterData.GetTable_Product +
      	' WHERE NUM = ' + masterData.WrapDBID( inNum ) +
      	' AND C_ID = ' + masterData.WrapDBID( inCycleID ) +
         ' AND ORG_ID = ' + masterData.WrapDBID( inOrgID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName('ID').AsString;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetPBOStatusTypeByID( inID : string ) : Integer;
var
   fQuery : tQuery;
begin
   // tProdReturnStatus = ( prodRetPending = 0, prodRetOEM = 1, prodRetInv = 2 );
   result := integer(prodRetPending);
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, STATUS FROM ' + masterData.GetTable_Returns +
      	' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName('STATUS').AsInteger;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetCycleIDByOrderProductID( inID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, C_ID FROM ' + masterData.GetTable_Order_Product +
      	' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName('C_ID').AsString;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Product_GetOrderProductAmountById( inID : string ) : currency;
var
   fQuery : tQuery;
   qtySold : integer;
   taxRate : double;
   cost : currency;
   subTotal : currency;
   totalTax : currency;
   qtyTotal : currency;
begin
   result := 0.00;
   fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, SQTY, TAX, SCOST FROM ' + masterData.GetTable_Order_Product +
      	' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
      begin
         qtySold := fQuery.FieldByName('SQTY').AsInteger;
         cost := fQuery.FieldByName('SCOST').AsCurrency;
         taxRate  := fQuery.FieldByName('TAX').AsCurrency;
         // do the math
         subTotal := ( qtySold * cost );
         totalTax := ( subTotal * Tax_PerformTaxCalculation(taxRate));
         totalTax := RoundTo( totalTax, -2);
         //
         result := ( subTotal + totalTax );
      end;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

{

         retVal := masterData.AddTable(masterData.dbPath + table_returntable,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // campaign ID
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' + // total quantity returned
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'STATUS INTEGER, ' + // status see - tProdReturnStatus
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost

         retVal := masterData.AddTable(masterData.dbPath + table_backordered,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // campaign ID
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' + // total quantity returned
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'RCOST MONEY',  // retail cost

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
            'PQTY INTEGER, ' + // prioer re
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost


         retVal := masterData.AddTable(masterData.dbPath + table_backordered,
            'ID VARCHAR(40), ' +
            'OPT_ID VARCHAR(40),' + // order_product_table product_id
            'ORDER_ID VARCHAR(40), ' +
            'C_STID VARCHAR(40), ' + // sold to id
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'STATUS INTEGER, ' + // status : see tBackOrderStatus
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost


         retVal := masterData.AddTable(masterData.dbPath + table_product,
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
 /           'AMOUNT MONEY',
}
