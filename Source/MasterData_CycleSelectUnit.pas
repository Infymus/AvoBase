 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_CycleSelectUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  recordstructureunit,
  dateutils,
  inifileunit,
  toolbox_cycletoolboxunit,
  toolbox_orgtoolboxunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataCycleSelect = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
   	fSQLString : string;
      fMasterData : tMasterData;
      procedure Update( InOrgName : string);
      constructor Create( inMasterData : tMasterData);  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataCycleSelect.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create(nil);
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   // build the sql
	fSQLString := 'SELECT ID, ORG_ID, ISACTIVE, NUM, SDATE, EDATE FROM ' + fMasterData.Gettable_Cycle;
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'CYCLE', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 120, ftString);
   // even if we add active := true here, it won't activate within the create methodology.
   self.OnCalcFields := HandleCalculated;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NUM INTEGER, ' + // Cycle Number
            'CYEAR INTEGER, ' + // Cycle Year
            'IMSG BLOB(240, 1), ' + // specific invoice message for cycle
            'SDATE DATE, ' + // start date
            'EDATE DATE ',  // end date
}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataCycleSelect.HandleCalculated(DataSet: TDataSet);
begin
	DataSet.FieldByName('CYCLE').Value :=
      Cycle_GetCycleNameByDateAndNum( self.FieldByName('SDATE').AsDateTime, self.FieldByName('NUM').AsInteger );
   DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByname('ORG_ID').AsString);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataCycleSelect.Update( inOrgName : string);
var
   errResult : tErrorResult;
   sql : string;
   orgID : string;
begin
	self.Close();
   sql := fSQLString;
   if (inOrgName <> 'ALL') then
   begin
		orgID := Org_GetOrgIDByOrgName( inOrgName );
      sql := sql + ' WHERE ORG_ID = ' + masterData.WrapDBID( orgID );
   end;
	sql := sql + ' ORDER BY EDATE DESC';
   self.SQL.Clear();
   self.SQL.Text := sql;
   self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.
