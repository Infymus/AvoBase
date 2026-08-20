 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

 unit MasterData_BrochureListUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  RecordStructureUnit,
  bde,
  dateutils,
  inifileunit,
  avobase_percentformunit,
  toolbox_cycletoolboxunit,
  toolbox_orgtoolboxunit,
  toolbox_brochuretoolboxunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataBrochureList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
      constructor Create( inMasterData : tMasterData);  overload;
   end;

type
	tMasterDataBrochureOrderDetailsList = class( tQuery )
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
      constructor Create( inMasterData : tMasterData);  overload;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{ tMasterDataBrochureList }

// Brochure LIST ################################################# //

constructor tMasterDataBrochureList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( nil );
   PercentForm_Create('Generating Brochure List', 0, 0);
   self.SessionName := inMasterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Brochure;
   self.SQL.Clear();
   self.SQL.Text := sql;
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'CYCLE', 7, ftString);
   masterData.QueryAddCalculatedField( self, 'ORG', 25, ftString);
   masterData.QueryAddCalculatedField( self, 'BORDER', 0, ftInteger);

{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'TBO INTEGER, ' + // total books ordered
            'AMOUNT MONEY, ' + // Total Cost of all books
            'DESCR VARCHAR(40)',
}
   // even if we add active := true here, it won't activate within the create methodology.
   PercentForm_Free();
end;

procedure tMasterDataBrochureList.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('CYCLE').AsString :=
      Cycle_GetCycleNameByCycleID(DataSet.FieldByName('C_ID').AsString);
   DataSet.FieldByName('ORG').AsString :=
      Org_GetOrgNameByOrgID( DataSet.FieldByName('ORG_ID').AsString);
   DataSet.FieldByName('BORDER').Value :=
      Brochure_GetBrochureCount( DataSet.FieldByName('ID').AsString );
end;

procedure tMasterDataBrochureList.Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
var
   errResult : tErrorResult;
   sql : string;
begin
   PercentForm_Create('Refreshing Brochure List', 0, 0);
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Brochure;
   {
   if (inActiveState in [stateActive]) then
      sql := sql + ' WHERE ISACTIVE = TRUE';
   if (inActiveState in [stateInactive]) then
   	sql := sql + ' WHERE ISACTIVE = FALSE';
   if (inOrderBy <> '') then
      sql := sql + ' ORDER BY ' + inOrderBy;
   if (inSortOpt <> '') then
   	sql := sql + ' ' + inSortOpt;
      }
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
   PercentForm_Free();
end;



{ tMasterDataBrochureOrderDetailsList }

constructor tMasterDataBrochureOrderDetailsList.Create( inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Brochure;
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
   masterData.QueryAddCalculatedField( self, 'TotOrd', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'FullName', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'FullAddr', 120, ftString);
   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
end;

procedure tMasterDataBrochureOrderDetailsList.HandleCalculated(DataSet: TDataSet);
begin

end;

procedure tMasterDataBrochureOrderDetailsList.Update(inOrderBy, inSortOpt: string; inActiveState: tActiveStates);
begin

end;

end.
