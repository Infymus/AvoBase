 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_Report_ProductListUnit;

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
      fMasterData : tMasterData;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      procedure Update();
      property SortType : tSortProdTypes read fSortProdType write fSortProdType;
      constructor Create( inMasterData : tMasterData; inOrgID: string; inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
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

SELECT P.*, FROM PROD P
INNER JOIN CYCLE C
ON C.ID = P.C_ID
}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportProductList.Create( inMasterData : tMasterData; inOrgID: string; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   errResult : tErrorResult;
   sqlWhere : string;
   cnt : integer;
begin
   inherited create(nil);
   //
   PercentForm_Create('Generating Report Data - One Moment Please...', 0, 0);
   fMasterData := inMasterData;
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   //
   // build the sql for the data we are going to need
	fSQL := 'SELECT P.*, C.NUM, C.CYEAR FROM ' + masterData.GetTable_Product + ' P ' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C' +
      ' ON C.ID = P.C_ID';
   // Now we have to build the years selected.
   sqlWhere := '';
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE (( C.CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (C.NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30 ) ' +
         ' AND (P.ORG_ID = ' + masterData.WrapDBID( inOrgID ) + '))';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
      begin
         sqlWhere := sqlWhere + ' OR (( C.CYEAR = ' + IntToStr( cnt ) + ' ) ' +
         ' AND (C.NUM BETWEEN 1 AND 30 ) ' +
         ' AND (P.ORG_ID = ' + masterData.WrapDBID( inOrgID ) + '))';
      end;
      //
      sqlWhere := sqlWhere + ' OR (( C.CYEAR = ' + IntToStr( inEndYear ) + ' ) ' +
         ' AND (C.NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (P.ORG_ID = ' + masterData.WrapDBID( inOrgID ) + '))';
   end;
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE (( C.CYEAR = ' + IntToStr( inStartYear ) + ' ) ' +
         ' AND (C.NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ) ' +
         ' AND (P.ORG_ID = ' + masterData.WrapDBID( inOrgID ) + '))';
   end;
   // Combine
   fSQL := fSQL + sqlWhere;
   //
   self.SQL.Text := fSQL;
   errResult := fMasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CYCLE', 120, ftString);
   PercentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportProductList.HandleCalculated(DataSet: TDataSet);
begin
	DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
end;

procedure tMasterDataReportProductList.Update;
var
   workSql : string;
begin
	self.Close();
   workSql := fSQL;
   //
   case fSortProdType of
      ProdOrg : workSql := workSql + ' ORDER BY P.ORG_ID';
   	ProdCycle : workSql := workSql + ' ORDER BY P.CYCLENAME';
   	ProdNum : workSql := workSql + ' ORDER BY P.NUM';
   	ProdName : workSql := workSql + ' ORDER BY P.NAME';
   	ProdQTY : workSql := workSql + ' ORDER BY P.QTY';
   	ProdAmount : workSql := workSql + ' ORDER BY P.AMOUNT';
   end;
   //
//   workSql := workSql + ' DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := workSql;
   Self.Open();
end;


end.


