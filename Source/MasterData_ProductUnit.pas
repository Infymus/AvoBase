 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit MasterData_ProductUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  recordstructureunit,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  ErrorResultUnit;


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

type
   tMasterDataProductList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      constructor Create(owner : tComponent; inMasterData : tMasterData; inOrderBy : string; inSortOpt : string);  overload;
   end;

   {%%% implementation %%%}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

implementation

// CUSTOMER LIST ################################################# //

{$REGION 'Product List'}

constructor tMasterDataProductList.Create(owner: tComponent; inMasterData: tMasterData; inOrderBy : string; inSortOpt : string);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( owner );
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Product;
   if (inOrderBy <> '') then
      sql := sql + ' ORDER BY ' + inOrderBy;
   if (inSortOpt <> '') then
   	sql := sql + ' ' + inSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // masterData.QueryAddCalculatedField( self, 'TotOrd', 'TotOrd', 10, ftInteger );
   Self.Open();
end;

procedure tMasterDataProductList.HandleCalculated(DataSet: TDataSet);
var
	fQuery : tQuery;
begin
	fQuery := masterData.GetQuery;
   try
   	fQuery.SessionName := fMasterData.AvoBaseSession.SessionName;
      //
      // Total Orders
      fQuery.Close();
      //fQuery.SQL.Text := 'SELECT COUNT(*) FROM ' + fMasterData.GetTable_Order + ' WHERE SOLD_TO = ' + DataSet.FieldByName('CUST_ID').AsString;
      fQuery.Open();
      //DataSet.FieldByName('TotOrd').Value := fQuery.FieldByName('COUNT(*)').AsInteger;
      fQuery.Close();
      //
      // finish
   finally
   	FreeAndNil(fQuery);
   end;
end;

{$ENDREGION}

end.
