 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportEarningVsExpenseByCycleUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  dateutils,
  inifileunit,
   recordstructureunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_orgtoolboxunit,
  toolbox_cycletoolboxunit,
  AvoBase_PercentFormUnit,
  masterdataunit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataReportEarningVsExpenseByCycle = class(tQuery)
   private
      fMasterData : tMasterData;
   public
      constructor Create( inMasterData : tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportEarningVsExpenseByCycle.Create( inMasterData : tMasterData; inOrgID : string; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   errResult : tErrorResult;
   cnt : integer;
  	fQuery : tQuery;
   fWriteQuery : tQuery;
   count : integer;
   fTotalAmount: currency;
   sqlText : string;
   sqlOrdType : string;
   sqlWhere : string;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   //
   fQuery := masterData.GetQuery();
   fWriteQuery := masterData.GetQuery();

   //
   PercentForm_Create('Gathering Report Data - One Moment Please ...', 0, 1);

   // Build the Report Table
   masterData.RemoveTable( table_report );
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'ID VARCHAR(40), ' + // JunkID for this report
         'DESCR VARCHAR(40), ' + // name
         'AMT_TOTAL MONEY', // total amount
         'ID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;
   //
   sqlText := 'SELECT * FROM ' + masterData.GetTable_Report;
   fWriteQuery.SQL.text := sqlText;
   fWriteQuery.Open();

   // *************************************************************************************************** //
   // EXPENSES
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
         ' AND (C.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ')) ';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
         sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( cnt ) + ' ) AND (NUM BETWEEN 1 AND 30)' +
            '  AND (C.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
      //
      sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( inEndYear ) + ') AND (NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' )' +
         ' AND (C.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
   end;
   //
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND '  + IntToStr( InEndNum) + ')' +
         ' AND (C.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
   end;
   //
   sqlText := sqlText + sqlWhere;
   sqlText := sqlText + ' ORDER BY E.C_ID DESC';
   //
   fQuery.SQL.Text := sqlText;
   fQuery.Open();
   //
   // Now, build the data to get an amount
   fTotalAmount := 0;
   PercentForm_IncreaseTotal( fQuery.RecordCount );
   count := 0;
   if ( fQuery.RecordCount <> 0 ) then
   repeat
      PercentForm_Update();
      if ( fQuery.FieldByName('E_ID').AsString <> '' ) then
         fTotalAmount := fTotalAmount + fQuery.FieldByName('AMOUNT').AsCurrency;
      fQuery.Next();
   until fQuery.EOF;
   //
   // Now write the total, but only add the expense total
   fWriteQuery.Append();
   fWriteQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
   fWriteQuery.FieldByName('DESCR').AsString := 'Expenses';
   fWriteQuery.FieldByName('AMT_TOTAL').AsCurrency := fTotalAmount;
   fWriteQuery.Post();
   fQuery.Close();

   // *************************************************************************************************** //
   // EARNINGS
   sqlText := 'SELECT E.*, C.ID, C.NUM, C.CYEAR, C.ORG_ID ' +
      ' FROM ' + masterData.GetTable_Earning + ' E' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C' +
      ' ON C.ID = E.C_ID';
   //
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30)' +
         ' AND  (C.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ')) ';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
         sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( cnt ) + ' ) AND (NUM BETWEEN 1 AND 30)' +
            '  AND (C.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
      //
      sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( inEndYear ) + ') AND (NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' )' +
         '  AND (C.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
   end;
   //
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND '  + IntToStr( InEndNum) + ')' +
         '  AND (C.ORG_ID = ' + masterData.WrapDBID(InOrgID) + '))';
   end;
   //
   sqlText := sqlText + sqlWhere;
   sqlText := sqlText + ' ORDER BY E.C_ID DESC';
   //
   fQuery.SQL.Text := sqlText;
   fQuery.Open();
   //
   // Now, build the data to get an amount
   fTotalAmount := 0;
   PercentForm_IncreaseTotal( fQuery.RecordCount );
   count := 0;
   if ( fQuery.RecordCount <> 0 ) then
   repeat
      PercentForm_Update();
      if ( fQuery.FieldByName('E_ID').AsString <> '' ) then
         fTotalAmount := fTotalAmount + fQuery.FieldByName('AMOUNT').AsCurrency;
      fQuery.Next();
   until fQuery.EOF;
   //
   // Now write the total
   fWriteQuery.Append();
   fWriteQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
   fWriteQuery.FieldByName('DESCR').AsString := 'Earnings';
   fWriteQuery.FieldByName('AMT_TOTAL').AsCurrency := fTotalAmount;
   fWriteQuery.Post();
   fQuery.Close();



   // *************************************************************************************************** //
   // Done!
   fWriteQuery.Close();

   // now we get our data from THAT report
   sqlText := 'SELECT * FROM ' + masterData.GetTable_Report;
   self.SQL.Clear();
   self.SQL.Text := sqlText;

   errResult := fMasterData.QueryAddFields( self );
   //
   FreeAndNil(fQuery);
   FreeAndNil(fWriteQuery);
   //
   PercentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportEarningVsExpenseByCycle.destroy;
begin
   inherited;
end;


end.