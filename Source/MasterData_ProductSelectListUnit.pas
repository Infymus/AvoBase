 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ProductSelectListUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  dateutils,
  RecordStructureUnit,
  inifileunit,
  toolbox_cycletoolboxunit,
  toolbox_orgtoolboxunit,
  AvoBase_PercentFormUnit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataProducSelectList = class(tQuery)
   private
      fSQL : string;
      fSortProdType : tSortProdTypes;
      fSortOpt : string;
      fSearchText : string;
      fMasterData : tMasterData;
      fSearchOH : boolean;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      procedure Update();
      //
      property SortType : tSortProdTypes read fSortProdType write fSortProdType;
      property SortOption : string read fSortOpt write fSortOpt;
      property SearchText : string read fSearchText write fSearchText;
      property SearchOH : boolean read fSearchOH write fSearchOH;
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
            'QTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'AMOUNT MONEY',
}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataProducSelectList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
begin
   PercentForm_Create('Refreshing Product List - One Moment Please...', 0, 0);
   inherited create(nil);
   //
   fSearchOH := false;
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
   percentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataProducSelectList.HandleCalculated(DataSet: TDataSet);
begin
	DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
	DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByName('ORG_ID').AsString );
   Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataProducSelectList.Update;
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
   if (fSearchText <> '') AND ( fSearchOH ) then
      workSql := workSQL + ' AND QTY > 0'
   else
      if ( fSearchOH ) then
         workSql := workSQL + ' WHERE QTY > 0';
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