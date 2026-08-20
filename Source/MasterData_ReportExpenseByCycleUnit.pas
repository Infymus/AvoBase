 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportExpenseByCycleUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
   recordstructureunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  avobase_percentformunit,
  toolbox_cycletoolboxunit,
  toolbox_orgtoolboxunit,
  toolbox_earningtoolboxunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataReportEarningByCycle = class(tQuery)
   public
      fMasterData : tMasterData;
      constructor Create( inMasterData : tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
   end;

implementation

constructor tMasterDataReportEarningByCycle.Create( inMasterData : tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   errResult : tErrorResult;
   sqlWhere : string;
   cnt : integer;
   sqlText : string;
   sqlOpt : string;
begin
	// create and assign
   inherited create( nil );
   //
   self.RequestLive := true;
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   //
   sqlText := 'SELECT E.*, C.ID, C.NUM, C.CYEAR, C.ORG_ID ' +
      ' FROM ' + masterData.GetTable_Expense + ' E' +
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
   sqlText := sqlText + ' ORDER BY E.C_ID DESC, E.MOPDATE DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sqlText;
   errResult := fMasterData.QueryAddFields( self );
end;

end.