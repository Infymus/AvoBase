 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportProductReturnListUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  recordstructureunit,
  bde,
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
      constructor Create( inMasterData : tMasterData; PrintPend, PrintReturned, PrintRestocked : Boolean);  overload;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterData_ProductBOTempList.Create(inMasterData: tMasterData; PrintPend, PrintReturned, PrintRestocked : Boolean);
var
   errResult : tErrorResult;
   statSQL : string;
begin
   inherited create(nil);
   //
   fMasterData := inMasterData;
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   //
   fSQL := 'SELECT * FROM ' + fMasterData.GetTable_Returns;
   //
   statSQL := '';
   if ( PrintPend ) then
      statSQL := ' WHERE STATUS = ' + IntToSTr(integer(prodRetPending));
   if ( PrintReturned ) then
   begin
      if ( statSQL <> '' ) then
         statSQL := statSQL + ' OR STATUS = ' + IntToStr(integer(prodRetOEM))
      else
         statSQL := ' WHERE STATUS = ' + IntToStr(integer(prodRetOEM));
   end;
   if ( PrintRestocked ) then
   begin
      if ( statSQL <> '' ) then
         statSQL := statSQL + ' OR STATUS = ' + IntToStr(integer(prodRetInv))
      else
         statSQL := ' WHERE STATUS = ' + IntToStr(integer(prodRetInv));
   end;
   if ( statSQL <> '' ) then
      fSQL := fSQL + statSQL;
   //
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
begin
	self.Close();
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.d.