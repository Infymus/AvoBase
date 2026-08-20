 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_FeeListUnit;

interface uses
	sysutils,
   classes,
   constantsunit,
   toolboxunit,
   recordstructureunit,
   db,
   dbtables,
   bde,
   dateutils,
   inifileunit,
   masterdataunit,
   ErrorResultUnit,
   toolbox_preferencetoolboxunit,
   toolbox_orgtoolboxunit;

type
   tMasterDataFeeList = class(tQuery)
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

constructor tMasterDataFeeList.Create(inMasterData : tMasterData);
var
   errResult : tErrorResult;
begin
	// create and assign
   inherited create( owner );
   //
   fOrgID := '';
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   fSQL := 'SELECT * FROM ' + fMasterData.GetTable_Fee + ' ORDER BY NAME, AMOUNT';
   self.SQL.Clear();
   self.SQL.Text := fSQL;
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'ORG', 120, ftString);
   Self.Open();
end;

procedure tMasterDataFeeList.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('ORG').Value := Org_GetOrgNameByOrgID( self.FieldByname('ORG_ID').AsString );
end;

procedure tMasterDataFeeList.Update;
begin
   self.Close();
   //
   fSQL := 'SELECT * FROM ' + fMasterData.GetTable_Fee;
   if ( fOrgID <> '' ) then
      fSQL := fSQL + ' WHERE ORG_ID = ' + masterData.WrapDBID( fOrgID );
   //
   fSQL := fSQL + ' ORDER BY NAME, AMOUNT';
   //
   self.SQL.Text := fSQL;
   self.Open();
end;

end.
