 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_FeeToolboxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  recordstructureunit,
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Fee_MarkPriorFeeAsReturned( inOrderID, inPriorOrderID : string ) : tErrorResult;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ this has to mark the prior order's fees as sold so they can't come back on the return }

function Fee_MarkPriorFeeAsReturned( inOrderID, inPriorOrderID : string ) : tErrorResult;
var
   pOrdFeeQuery : tQuery; // prior
   cOrdFeeQuery : tQuery; // current
   prQTY : integer;
   rQTY : integer;
   trQTY : integer;
begin
   result := Error_Init;
   //
   pOrdFeeQuery := masterData.GetQuery;
   cOrdFeeQuery := masterData.GetQuery;
   //
   cOrdFeeQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Fee +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   cOrdFeeQuery.Open();
   if ( cOrdFeeQuery.RecordCount >= 1 ) then
   repeat
      // go find prior
      pOrdFeeQuery.Close();
      pOrdFeeQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Fee +
         ' WHERE ID = ' + masterData.WrapDBID( cOrdFeeQuery.FieldByName('R_ID').AsString );
      pOrdFeeQuery.Open();
      //
      if ( cOrdFeeQuery.RecordCount >= 1 ) then
      begin
         // post them out
         pOrdFeeQuery.Edit();
         pOrdFeeQuery.FieldByName('RET').AsBoolean := True;
         pOrdFeeQuery.Post();
         pOrdFeeQuery.Close();
      end;
      //
      cOrdFeeQuery.Next();
   until cOrdFeeQuery.EOF;
   //
   cOrdFeeQuery.Close();
   pOrdFeeQuery.Close();
   //
   FreeAndNil(pOrdFeeQuery);
   FreeAndNil(cOrdFeeQuery);
end;


end.


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
            'RETADD BOOLEAN, ' + // applies only to returns, is a fee that can be added or subtracted
            'AMOUNT MONEY',
}
