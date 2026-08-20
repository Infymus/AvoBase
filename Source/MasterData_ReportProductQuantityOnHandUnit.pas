 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportProductQuantityOnHandUnit;

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
  avobase_percentformunit,
  toolbox_cycletoolboxunit,
  toolbox_orgtoolboxunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataReportProductList = class(tQuery)
   private
      fSQL : string;
      fSortProdType : tSortProdTypes;
      fSortOpt : string;
      fSearchText : string;
      fMasterData : tMasterData;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      procedure Update();
      //
      property SortType : tSortProdTypes read fSortProdType write fSortProdType;
      property SortOption : string read fSortOpt write fSortOpt;
      property SearchText : string read fSearchText write fSearchText;
      //
      constructor Create( inMasterData : tMasterData);  overload;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportProductList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
begin
   inherited create(nil);
   //
   fMasterData := inMasterData;
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   //
   fSQL := 'SELECT * FROM ' + fMasterData.Gettable_Product +
      ' WHERE QTY > 0';
   self.SQL.Clear();
   self.SQL.Text := fSQL;
   //
   errResult := fMasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CYCLE', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 120, ftString);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportProductList.HandleCalculated(DataSet: TDataSet);
begin
	DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
	DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByName('ORG_ID').AsString );
   Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportProductList.Update;
begin
	self.Close();
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.
