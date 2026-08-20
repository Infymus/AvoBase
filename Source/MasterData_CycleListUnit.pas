 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit MasterData_CycleListUnit;

interface uses
	sysutils,
   classes,
   constantsunit,
   toolboxunit,
   db,
   recordstructureunit,
   dbtables,
   bde,
   dateutils,
   inifileunit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   masterdataunit,
   ErrorResultUnit;

type
   tMasterDataCycleList = class(tQuery)
   private
      fSortDir : string;
      fSortOrgID : string;
      fSortField : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
   	fSQLString : string;
      fMasterData : tMasterData;
      //
      procedure Update();
      //
      property SortDir : string read fSortDir write fSortDir;
      property SortOrgID : string read fSortOrgID write fSortOrgID;
      property SortField : string read fSortField write fSortField;
      //
      constructor Create( inMasterData : tMasterData);  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{
         retVal := masterData.AddTable(masterData.dbPath + table_cycle,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NUM INTEGER, ' + // Cycle Number
            'CYEAR INTEGER, ' + // Cycle Year
            'IMSG BLOB(240, 1), ' + // specific invoice message for cycle
            'SDATE DATE, ' + // start date
            'EDATE DATE ',  // end date

}

constructor tMasterDataCycleList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
begin
   inherited create(nil);
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   //
	fSQLString := 'SELECT ID, ORG_ID, ISACTIVE, CNAME, NUM, CYEAR, SDATE, EDATE FROM ' + masterData.GetTable_Cycle;
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'OOPEN', 120, ftInteger);
   masterData.QueryAddCalculatedField( self, 'OCLOSED', 120, ftInteger);
   masterData.QueryAddCalculatedField( self, 'OCANCELLED', 120, ftInteger);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 120, ftString);
   // even if we add active := true here, it won't activate within the create methodology.
   self.OnCalcFields := HandleCalculated;
   Self.Open();
end;

procedure tMasterDataCycleList.HandleCalculated(DataSet: TDataSet);
var
	fQuery : tQuery;
   oStat : integer;
begin
   DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( Self.FieldByname('ORG_ID').AsString );
   //
   fQuery := masterData.GetQuery();
   try
      fQuery.Close();
      oStat := integer(tOrderStatusTypes.OrderStatusOpen);
      fQuery.SQL.Text := 'SELECT COUNT(*) FROM ' + masterData.GetTable_Order +
         ' WHERE C_ID = ' + masterData.WrapDBID( DataSet.FieldByName('ID').AsString ) +
         ' AND STATUS = ' + IntToStr( oStat );
      fQuery.Open();
      DataSet.FieldByName('OOPEN').Value := fQuery.FieldByName('COUNT(*)').AsInteger;
      fQuery.Close();
      //
      oStat := integer(tOrderStatusTypes.OrderStatusClosed);
      fQuery.SQL.Text := 'SELECT COUNT(*) FROM ' + masterData.GetTable_Order +
         ' WHERE C_ID = ' + masterData.WrapDBID( DataSet.FieldByName('ID').AsString ) +
         ' AND STATUS = ' + IntToStr( oStat );
      fQuery.Open();
      DataSet.FieldByName('OCLOSED').Value := fQuery.FieldByName('COUNT(*)').AsInteger;
      fQuery.Close();
      //
      oStat := integer(tOrderStatusTypes.OrderStatusCancelled);
      fQuery.SQL.Text := 'SELECT COUNT(*) FROM ' + masterData.GetTable_Order +
         ' WHERE C_ID = ' + masterData.WrapDBID( DataSet.FieldByName('ID').AsString ) +
         ' AND STATUS = ' + IntToStr( oStat );
      fQuery.Open();
      DataSet.FieldByName('OCANCELLED').Value := fQuery.FieldByName('COUNT(*)').AsInteger;
      fQuery.Close();
      //
      // finish
   finally
   	FreeAndNil(fQuery);
   end;
end;

procedure tMasterDataCycleList.Update();
var
   sql : string;
begin
	self.Close();
   sql := fSQLString;


   // fSortOrgID : string;
   if ( fSortORGID <> '' ) then
      sql := sql + ' WHERE ORG_ID = ' + masterData.WrapDBID( fSortOrgID );


   // fSortField : string;
   sql := sql + ' ORDER BY ' + fSortField;

   // fSortDir : string;
   if ( fSortDIR <> '' ) then
      sql := sql + ' ' + fSortDIR;

   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   self.Open();
end;




end.
