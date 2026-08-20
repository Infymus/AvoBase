 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportOrderProductListUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
   RecordStructureUnit,
  dateutils,
  inifileunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_ProductToolBoxUnit,
  masterdataunit,
  AvoBase_PercentFormUnit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataReportOrderProductList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update();
      constructor Create( inMasterData : tMasterData; InCycleID : String );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportOrderProductList.Create( inMasterData : tMasterData; InCycleID : String);
var
   errResult : tErrorResult;
   sql : string;
   orderQuery : tQuery;
   ProdQuery : tQuery;
   canSave : boolean;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   self.RequestLive := true;
   fMasterData := inMasterData;
   //
   PercentForm_Create('Gathering Report Data - One Moment Please ...', 0, 0);

   //
   orderQuery := masterData.GetQuery();
   ProdQuery := masterData.GetQuery();


   // First get rid of it. Just so that we never have to worry about it.
   masterData.RemoveTable( table_report );

   // First, build the table if it doesn't exist
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'ID VARCHAR(40), ' +
         'C_ID VARCHAR(40), ' + // camp id
         'ORG_ID VARCHAR(40), ' +
         'ORDER_ID VARCHAR(40), ' +
         'NUM VARCHAR(20), ' +
         'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
         'SQTY INTEGER, ' +
         'NAME VARCHAR(40), ' +
         'DESCR VARCHAR(40), ' +
         'SCOST MONEY, ' + // sell at cost
         'YCOST MONEY, ' + // Your Cost
         'RCOST MONEY',  // retail cost
         {----------------}
         'ID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;
//   masterData.AddIndex( masterData.dbPath + table_report, 'SIDX', 'C_ID', [ixCaseInsensitive]);

   //
   self.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report;
   errResult := fMasterData.QueryAddFields( self );
   self.Open();

   //
   orderQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order +
      ' WHERE C_ID = ' + masterData.WrapDBID( InCycleID );
   orderQuery.Open();
   //
   if ( orderQuery.RecordCount <> 0 ) then
   repeat
      prodQuery.Close();
      prodQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
         ' WHERE ORDER_ID = ' + masterData.WrapDBID( orderQuery.FieldByName('ID').AsString );
      prodQuery.Open();
      if ( prodQuery.RecordCount <> 0 ) then
      repeat
         // we'll do combining, later... for now, let's make the whole list...
         canSave := true;
         //
         if ( canSave ) then
         begin
            self.Append();
            //
            self.FieldByName('ID').AsString := prodQuery.FieldByName('ID').AsString;
            self.FieldByName('C_ID').AsString := prodQuery.FieldByName('C_ID').AsString;
            self.FieldByName('ORG_ID').AsString := prodQuery.FieldByName('ORG_ID').AsString;
            self.FieldByName('ORDER_ID').AsString := prodQuery.FieldByName('ORDER_ID').AsString;
            self.FieldByName('NUM').AsString := prodQuery.FieldByName('NUM').AsString;
            self.FieldByName('LIFREE').AsBoolean := prodQuery.FieldByName('LIFREE').AsBoolean;
            self.FieldByName('SQTY').AsInteger := prodQuery.FieldByName('SQTY').AsInteger;
            self.FieldByName('NAME').AsString := prodQuery.FieldByName('NAME').AsString;
            self.FieldByName('DESCR').AsString := prodQuery.FieldByName('DESCR').AsString;
            self.FieldByName('SCOST').AsCurrency := prodQuery.FieldByName('SCOST').AsCurrency;
            self.FieldByName('YCOST').AsCurrency := prodQuery.FieldByName('YCOST').AsCurrency;
            self.FieldByName('RCOST').AsCurrency := prodQuery.FieldByName('RCOST').AsCurrency;
           //
            self.Post();
         end;
         //
         prodQuery.Next();
      until prodQuery.EOF;
      prodQuery.Close();
      //
      orderQuery.Next();
   until orderQuery.EOF;
   orderQuery.Close();

   // ======================================================================
   // build the sql for the data we are going to need
   Self.Close();
	sql := 'SELECT * FROM ' + masterData.GetTable_Report;
   sql := sql + ' ORDER BY C_ID';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   //
   FreeAndNil(orderQuery);
   FreeAndNil(ProdQuery);
   //
   PercentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportOrderProductList.destroy;
begin
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportOrderProductList.HandleCalculated(DataSet: TDataSet);
begin
	// We have none yere.
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportOrderProductList.Update();
begin
	self.Close();
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.

{


   INSTRUCTIONS:


   * Create a temp table that contains the following fields from table_order_product:
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // camp id
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'SQTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost

   * Get all of the orders in a tempquery for the cycle specified

   * Loop through that tempquery and grab all the products matching the order_id

         retVal := masterData.AddTable(masterData.dbPath + table_order_product,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'R_ID VARCHAR(40), ' + // return prior order_product_ID
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAXEX BOOLEAN, ' + // tax exempt
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'RQTY INTEGER, ' + // return qty (if RQTY = SQTY + FQTY then this line CANNOT be returned!!! )
            'FQTY INTEGER, ' + // free quantity (for by X get X free)
            'PQTY INTEGER, ' + // prior returned quantity
            'SO INTEGER, ' + // integer sort, only on save for bringing back into the invoice.
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PRODN1 VARCHAR(40), ' + // product table field name 1
            'PRODN2 VARCHAR(40), ' + // product table field name 2
            'PRODN3 VARCHAR(40), ' + // product table field name 3
            'PRODN4 VARCHAR(40), ' + // product table field name 4
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
}
