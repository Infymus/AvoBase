 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_EarningTypeListUnit;

Interface Uses
   Classes,
   Constantsunit,
   Dateutils,
   Db,
   Dbtables,
   Errorresultunit,
   Inifileunit,
   Masterdataunit,
   Recordstructureunit,
   Sysutils,
   Toolbox_Orgtoolboxunit,
   Toolbox_Preferencetoolboxunit,
   Toolboxunit;

type
   tMasterDataEarningTypeList = class(tQuery)
   private
      fOrgID : string;
      fSQL : string;
      //
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update;
      //
      property OrgID : string read fOrgID write fOrgID;
      //
      constructor Create(inMasterData : tMasterData); virtual;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataEarningTypeList.Create(inMasterData : tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( owner );
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Earning_Type + ' ORDER BY NAME';
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'ORG', 120, ftString);
{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40),' + // organization
            'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
            'DESCR VARCHAR(40)',
 }
   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
end;

procedure tMasterDataEarningTypeList.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('ORG').Value := Org_GetOrgNameByOrgID( self.FieldByname('ORG_ID').AsString );
end;

procedure tMasterDataEarningTypeList.Update;
begin
   self.Close();
   //
   fSQL := 'SELECT * FROM ' + fMasterData.GetTable_Earning_Type;
   if ( fOrgID <> '' ) then
      fSQL := fSQL + ' WHERE ORG_ID = ' + masterData.WrapDBID( fOrgID );
   //
   fSQL := fSQL + ' ORDER BY NAME';
   //
   self.SQL.Text := fSQL;
   self.Open();
end;


end.