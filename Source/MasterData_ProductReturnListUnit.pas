 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit MasterData_ProductReturnListUnit;

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
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_orgtoolboxunit,
  toolbox_cycletoolboxunit,
  toolbox_customertoolboxunit,
  masterdataunit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterData_ProductBOTempList = class(tQuery)
   private
      fSQL : string;
      fSortProdType : tSortProdTypes;
      fSortOpt : string;
      fSortOrg : string;
      fSearchText : string;
      fMasterData : tMasterData;
      fStatusType : tProdReturnStatus;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      procedure Update();
      //
      property SortType : tSortProdTypes read fSortProdType write fSortProdType;
      property SortOption : string read fSortOpt write fSortOpt;
      property SearchText : string read fSearchText write fSearchText;
      property SearchOrg : string read fSortOrg write fSortOrg;
      property StatusType : tProdReturnStatus read fStatusType write fStatusType;
      //
      constructor Create( inMasterData : tMasterData);  overload;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterData_ProductBOTempList.Create(inMasterData: tMasterData);
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
   fSQL := 'SELECT * FROM ' + fMasterData.GetTable_Returns;
   self.SQL.Clear();
   self.SQL.Text := fSQL;
   //
   errResult := fMasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CYCLE', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'STAT', 120, ftString);
   //
   fStatusType := prodRetPending;
end;

{
         retVal := masterData.AddTable(masterData.dbPath + table_returntable,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // campaign ID
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' + // total quantity returned
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'STATUS INTEGER, ' + // status see - tProdReturnStatus
            'RCOST MONEY',  // retail cost

   tProdReturnStatus = ( prodRetPending = 0, prodRetOEM = 1, prodRetInv = 2 );


}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterData_ProductBOTempList.HandleCalculated(DataSet: TDataSet);
begin
	DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
	DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByName('ORG_ID').AsString );
   case Self.FieldByname('STATUS').AsInteger of
      integer(prodRetPending) : DataSet.FieldByname('STAT').AsString := 'Pending';
      integer(prodRetOEM) : DataSet.FieldByname('STAT').AsString := 'Returned to OEM';
      integer(prodRetInv) : DataSet.FieldByname('STAT').AsString := 'Restocked';
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterData_ProductBOTempList.Update;
var
   workSql : string;
begin
	self.Close();
   workSql := fSQL;
   //
   workSql := workSQL + ' WHERE STATUS = ' + IntToStr(integer(fStatusType));
   if (fSearchText <> '') then
   begin
      workSql := workSQL + ' AND (NAME LIKE "%' + fSearchText + '%"' + ') ';
      workSql := workSQL + ' OR (NUM LIKE "%' + fSearchText + '%"' + ') ';
   end;
   //
   case fSortProdType of
      ProdOrg : workSql := workSql + ' ORDER BY ORG_ID';
   	ProdCycle : workSql := workSql + ' ORDER BY C_ID';
   	ProdNum : workSql := workSql + ' ORDER BY NUM';
   	ProdName : workSql := workSql + ' ORDER BY NAME';
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

end.d.
