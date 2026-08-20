 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportEarningListByCycleUnit;

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
  masterdataunit,
  Order_InvoiceObjectUnit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataReportEarningListByCycle = class(tQuery)
   private
   	fQuery : tQuery;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      constructor Create( inMasterData : tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportEarningListByCycle.Create( inMasterData : tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   errResult : tErrorResult;
   sqlWhere : string;
   cnt : integer;
   sqlText : string;
   sqlOpt : string;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   //
   sqlText := 'SELECT E.*, C.ID, C.NUM, C.CYEAR, C.ORG_ID ' +
      ' FROM ' + masterData.GetTable_Earning_List + ' E' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C' +
      ' ON C.ID = E.C_ID';
   //
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30)' +
         ' AND (E.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ')) ';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
         sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( cnt ) + ' ) AND (NUM BETWEEN 1 AND 30)' +
            ' AND (E.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
      //
      sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( inEndYear ) + ') AND (NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' )' +
         ' AND (E.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
   end;
   //
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND ' +
         IntToStr( InEndNum) + ') AND (E.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
   end;
   //
   sqlText := sqlText + sqlWhere;
   sqlText := sqlText + ' ORDER BY E.C_ID DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sqlText;
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'TOTITEMS', 40, ftInteger);
   masterData.QueryAddCalculatedField( self, 'TOTAMT', 40, ftCurrency);
	fQuery := masterData.GetQuery;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportEarningListByCycle.destroy;
begin
	FreeAndNil(fQuery);
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportEarningListByCycle.HandleCalculated(DataSet: TDataSet);
var
   tempStr : String;
begin
   DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByname('ORG_ID').AsString );
   //
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Earning +
      ' WHERE E_ID = ' + masterData.WrapDBID( Self.FieldByName('ID').AsString );
   fQuery.Open();
   DataSet.FieldByname('TOTITEMS').AsInteger := fQuery.FieldByName('TOT').AsInteger;
   fQuery.Close();
   //
   fQuery.SQL.Text := 'SELECT SUM(AMOUNT) AS AMT FROM ' + masterData.GetTable_Earning +
      ' WHERE E_ID = ' + masterData.WrapDBID( Self.FieldByName('ID').AsString );
   fQuery.Open();
   DataSet.FieldByname('TOTAMT').AsCurrency := fQuery.FieldByName('AMT').AsCurrency;
   fQuery.Close();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)


end.
