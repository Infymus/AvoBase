 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_ProductListUnit;

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
  avobase_percentformunit,
  toolbox_cycletoolboxunit,
  toolbox_orgtoolboxunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataProductList = class(tQuery)
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

{
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'TAXE BOOLEAN, ' +
            'QTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PPAGE VARCHAR(8), ' +
            'AMOUNT MONEY',
}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataProductList.Create(inMasterData: tMasterData);
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
   fSQL := 'SELECT * FROM ' + fMasterData.Gettable_Product;
   self.SQL.Clear();
   self.SQL.Text := fSQL;
   //
   errResult := fMasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CYCLE', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 120, ftString);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataProductList.HandleCalculated(DataSet: TDataSet);
begin
	DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
	DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByName('ORG_ID').AsString );
   Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataProductList.Update;
var
   workSql : string;
begin
	self.Close();
   workSql := fSQL;
   //
   if (fSearchText <> '') then
   begin
      workSql := workSQL + ' WHERE (NAME LIKE "%' + fSearchText + '%"' + ') ';
      workSql := workSQL + ' OR (NUM LIKE "%' + fSearchText + '%"' + ') ';
   end;
   //
   case fSortProdType of
      ProdOrg : workSql := workSql + ' ORDER BY ORG_ID';
   	ProdCycle : workSql := workSql + ' ORDER BY C_ID';
   	ProdNum : workSql := workSql + ' ORDER BY NUM';
   	ProdName : workSql := workSql + ' ORDER BY NAME';
   	ProdQTY : workSql := workSql + ' ORDER BY QTY';
   	ProdAmount : workSql := workSql + ' ORDER BY AMOUNT';
   end;
   //
   if (fSortOpt <> '') then
   	workSql := workSql + ' ' + fSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := workSql;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.
