 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportProductSingleProductUnit;

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
  RecordStructureUnit,
   toolbox_cycletoolboxunit,
   toolbox_producttoolboxunit,
   toolbox_orgtoolboxunit,
   toolbox_ordertoolboxunit,
   masterdataunit,
   ErrorResultUnit;

type
   tMasterDataReportSingleProduct = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      constructor Create( inMasterData : tMasterData; InProdNum, inCycleID : string );  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportSingleProduct.Create( inMasterData : tMasterData; InProdNum, inCycleID : string );
var
   errResult : tErrorResult;
   sqlText : string;
begin
   inherited create(nil);
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   //
   sqlText := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE NUM = ' + masterData.WrapDBID( InProdNum ) +
      ' AND C_ID = ' + masterData.WrapDBID( inCycleID );
   //
   self.SQL.Clear();
   self.SQL.Text := sqlText;
   //
   errResult := fMasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'ORDATE', 20, ftDateTime );
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 60, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 60, ftString);
   masterData.QueryAddCalculatedField( self, 'ONUM', 20, ftString);
   //
   self.OnCalcFields := HandleCalculated;
end;

procedure tMasterDataReportSingleProduct.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( Self.FieldByname('ORG_ID').AsString );
   DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByCycleID( Self.FieldByname('C_ID').AsString );
   DataSet.FieldByName('ONUM').Value := Order_GetOrderNumberByOrderID( Self.FieldByname('ORDER_ID').AsString );
   DataSet.FieldByName('ORDATE').Value := Order_GetOrderDateByOrderID( Self.FieldByname('ORDER_ID').AsString );
end;

end.

{
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
