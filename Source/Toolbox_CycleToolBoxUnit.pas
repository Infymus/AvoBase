 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_CycleToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  recordstructureunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  toolbox_orgtoolboxunit,
  Toolbox_PreferenceToolBoxUnit,
  //
  db,
  dbtables,
  bde,
  sysutils,
  classes,
  forms,

  dateutils,
  inifiles,
  stdctrls;



function Cycle_InitCycleRecord : tCycleRec;
//
function Cycle_GetCycleNameByDateAndNum( inCycleDate : tDateTime; inCycleNum : integer ) : string;
function Cycle_GetCycleNameByCycleID( inCycleId : string ) : string;
function Cycle_GetTotalOrdersByCycleID( inOrdStatus : tOrderStatusTypes; inCycleID : string ) : integer; overload;
function Cycle_GetTotalOrdersByCycleID( inCycleID : string ) : integer; overload;
function Cycle_GetOrgIDByCycleID( inCycleID : string ) : string;
function Cycle_GetAllActiveCycles : tStringList;
function Cycle_GetCycleIDByDateAndNum( inCycleDate : tDateTime; inCycleNum : integer ) : string;
function Cycle_CycleExists( inCycle : tCycleRec ) : boolean;
function Cycle_CycleSalesPeriodExists( inCycle : tCycleRec ) : boolean;
function Cycle_GetCycleIDByOrgYearNum( inOrg : string; inYear : integer; inNum : integer) : string;
function Cycle_GetCycleByCycleID( inID : string ) : tCycleRec;
function Cycle_GetCycleEndDateByCycleID( inID : string ) : tDateTime;
function Cycle_GetCycleCount : integer;
function Cycle_GetCycleIDByOrderID( inID : string ) : string;
function Cycle_GetCycleMessageByCycleID( inID : string ) : string;
function Cycle_ReturnCurrentCycleNumber_ByOrgIDCycleYear( inOrgID : string; inYear : integer ) : integer;
// Fill methods
procedure Cycle_ComboBox_FillCycleNumbers( inOrgID : string; VAR inComboBox : tComboBox );
procedure Cycle_ComboBox_FillCycleNumbersExist( inOrgID : string; inCycleYear : Integer; VAR inComboBox : tComboBox );
procedure Cycle_ComboBox_FillCycleNumbersLineItem( inOrgID : string; inCycleYear : Integer; VAR inComboBox : tComboBox );
procedure Cycle_ComboBox_FillCycleYears( inOrgID : string; VAR inComboBox : tComboBox );
procedure Cycle_ComboBox_FillCycleYearsExist( inOrgID : string; VAR inComboBox : tComboBox );

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_InitCycleRecord : tCycleRec;
begin
   with result do
   begin
      org_id := '';
      org_name := '';
      id := '';
      year := 0;
      num := 0;
      sdate := Now;
      edate := Now;
      isactive := false;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleNameByDateAndNum( inCycleDate : tDateTime; inCycleNum : integer ) : string;
var
   dateRec : tDateRecord;
begin
   dateRec := Date_GetDateRecord( inCycleDate );
   if (inCycleNum < 10) then
   	result := IntToStr( dateRec.fYear ) + '/0' + IntToStr( inCycleNum )
   else
   	result := IntToStr( dateRec.fYear ) + '/' + IntToStr( inCycleNum );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleNameByCycleID( inCycleId : string ) : string;
var
   fCycleQuery : tQuery;
begin
   result := '0000/00';
   if ( inCycleID <> '') then
   begin
      fCycleQuery := masterData.GetQuery;
      try
         fCycleQuery.SQL.text := 'SELECT ID, NUM, CYEAR FROM ' + masterData.GetTable_Cycle +
            ' WHERE ID = ' + masterData.WrapDBID( inCycleID);
         fCycleQuery.Open();
         //
         if ( fCycleQuery.FieldByName('NUM').AsInteger < 10) then
            result := fCycleQuery.FieldByName('CYEAR').AsString + '/0' + fCycleQuery.FieldByName('NUM').AsString
         else
            result := fCycleQuery.FieldByName('CYEAR').AsString + '/' + fCycleQuery.FieldByName('NUM').AsString;
         //
         fCycleQuery.Close();
      finally
         FreeAndNil( fCycleQuery );
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetTotalOrdersByCycleID( inOrdStatus : tOrderStatusTypes; inCycleID : string ) : integer;
var
   fCycleQuery : tQuery;
begin
   result := 0;
   fCycleQuery := masterData.GetQuery();
   try
      fCycleQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order +
         ' WHERE C_ID = ' + masterData.WrapDBID( inCycleID ) +
         ' AND STATUS = ' + IntToStr(integer( inOrdStatus ));
      fCycleQuery.Open();
      result := fCycleQuery.FieldByName('TOT').AsInteger;
      fCycleQuery.Close();
   finally
      FreeAndNil(fCycleQuery);
   end;
end;
        // '687B936A-5B8A-4E2B-8348-7FFAABD90B84'

function Cycle_GetTotalOrdersByCycleID( inCycleID : string ) : integer;
var
   fCycleQuery : tQuery;
begin
   result := 0;
   fCycleQuery := masterData.GetQuery();
   try
      fCycleQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Order +
         ' WHERE C_ID = ' + masterData.WrapDBID( inCycleID );
      fCycleQuery.Open();
      result := fCycleQuery.FieldByName('TOT').AsInteger;
      fCycleQuery.Close();
   finally
      FreeAndNil(fCycleQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetOrgIDByCycleID( inCycleID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, ORG_ID FROM ' + masterData.GetTable_Cycle +
         ' WHERE ID = ' + masterData.WrapDBID( inCycleID );
      fQuery.Open();
      result := fQuery.FieldByName('ORG_ID').AsString;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetAllActiveCycles : tStringList;
begin
   result := tStringList.Create;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Cycle_ComboBox_FillCycleNumbers( inOrgID : string; VAR inComboBox : tComboBox);
var
   fQuery : tQuery;
   cnt : integer;
begin
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, CYCLES FROM ' + masterData.GetTable_Org
         + ' WHERE ID = ' + masterData.WrapDBID( inOrgID );
      fQuery.Open();
      //
      for cnt := 1 to fQuery.FieldByName('CYCLES').AsInteger do
         inComboBox.Items.Add( IntToStr(cnt) );
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Cycle_ComboBox_FillCycleNumbersExist( inOrgID : string; inCycleYear : Integer; VAR inComboBox : tComboBox );
var
   fQuery : tQuery;
   fCycleNum : integer;
begin
   { this routine like the one above ONLY brings in numbers that exist within the scope of an org and YEAR }
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT NUM, CYEAR, ORG_ID FROM ' + masterData.GetTable_Cycle +
         ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID ) + ' AND CYEAR = ' + IntToStr( inCycleYear ) +
         ' ORDER BY NUM';
      fQuery.Open();
      //
      repeat
         inComboBox.Items.Add( fQuery.FieldByName('NUM').AsString );
         fQuery.Next();
      until fQuery.EOF;
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := inComboBox.Items.Count - 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Cycle_ComboBox_FillCycleNumbersLineItem( inOrgID : string; inCycleYear : integer; VAR inComboBox : tComboBox );
var
   fQuery : tQuery;
begin
   { this routine like the one above ONLY brings in numbers that exist within the scope of an org and YEAR }
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT NUM, CYEAR, ORG_ID FROM ' + masterData.GetTable_Cycle +
         ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID ) +
         ' AND CYEAR = ' + IntToStr( inCycleYear ) +
         ' ORDER BY NUM';
      fQuery.Open();
      //
      repeat
         inComboBox.Items.Add( fQuery.FieldByName('NUM').AsString );
         fQuery.Next();
      until fQuery.EOF;
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := inComboBox.Items.Count - 1;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleIDByDateAndNum( inCycleDate : tDateTime; inCycleNum : integer ) : string;
var
   fQuery : tQuery;
begin
{
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, EDAFROM ' + masterData.GetTable_Org
         + ' WHERE ID = ' + masterData.WrapDBID( inOrgID );
      fQuery.Open();
      //
      for cnt := 1 to fQuery.FieldByName('CYCLES').AsInteger do
         inComboBox.Items.Add( IntToStr(cnt) );
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
}
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Cycle_ComboBox_FillCycleYears( inOrgID : string; VAR inComboBox : tComboBox );
var
   fQuery : tQuery;
   cnt : integer;
   dateRec : tDateRecord;
begin
   inComboBox.Items.Clear;
   // first, we have to fill in all the years they already have
   // second, we have to add one year PRIOR to any year they don't have it
   // third, we have to add one year CURRENT if they don't have it
   // fourth, we have to add one year AFTER if they don't have it
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT DISTINCT CYEAR FROM ' + masterData.GetTable_Cycle +
         ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID ) +
         ' ORDER BY CYEAR ';
      fQuery.Open();
      //
      if (fQuery.RecordCount <> 0) then
      begin
         fQuery.First;
         cnt := fQuery.FieldByName('CYEAR').AsInteger;
         inComboBox.Items.Add( IntToStr(cnt - 1) );

         repeat
            cnt := fQuery.FieldByName('CYEAR').AsInteger;
            inComboBox.Items.Add( IntToStr(cnt) );
            fQuery.Next;
         until fQuery.EOF;

         fQuery.Last;
         cnt := fQuery.FieldByName('CYEAR').AsInteger;
         inComboBox.Items.Add( IntToStr(cnt + 1) );
      end;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;

   // was there ANYTHING? If not, we add
   if (inComboBox.Items.Count = 0) then
   begin
      dateRec := Date_GetDateRecord( NOW );
      inComboBox.Items.Add( IntToStr( dateRec.fYear -1 ) );
      inComboBox.Items.Add( IntToStr(dateRec.fYear) );
      inComboBox.Items.Add( IntToStr(dateRec.fYear + 1) );
   end;
   inComboBox.ItemIndex := InComboBox.Items.Count - 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Cycle_ComboBox_FillCycleYearsExist( inOrgID : string; VAR inComboBox : tComboBox );
var
   fQuery : tQuery;
   cnt : integer;
   fDateRecord : tDateRecord;
   fYear : integer;
   sql : string;
begin
   { this routine like the one above ONLY brings in years that exist. It does NOT add any additional years }
   fDateRecord := Date_GetDateRecord( Now );
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
   	sql := 'SELECT DISTINCT CYEAR FROM ' + masterData.GetTable_Cycle +
         ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID ) +
         ' ORDER BY CYEAR ';
      fQuery.SQL.Text := sql;
      fQuery.Open();
      //
      if (fQuery.RecordCount <> 0) then
      repeat
         cnt := fQuery.FieldByName('CYEAR').AsInteger;
         inComboBox.Items.Add( IntToStr(cnt) );
         fQuery.Next;
      until fQuery.EOF;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;

   // was there ANYTHING? If not, we add
   if (inComboBox.Items.Count = 0) then
   begin
      inComboBox.Items.Add( IntToStr( fDateRecord.fYear -1 ) );
      inComboBox.Items.Add( IntToStr( fDateRecord.fYear) );
      inComboBox.Items.Add( IntToStr( fDateRecord.fYear + 1) );
   end;

   inComboBox.ItemIndex := InComboBox.Items.Count - 1;
   (*
   if ( Pref_GetBoolean( 'NEWORDCURCYCLE' )) then
   begin
      // go through the inComboBox items and see if any of the years match the fDateRecord.fYear and if so, set it
      for cnt := 0 to inComboBox.Items.Count - 1 do
      begin
         fYear := StrToInt( inComboBox.Items.Strings[cnt] );
         if ( fYear = fDateRecord.fYear ) then
            inComboBox.ItemIndex := cnt;
      end
   end;
   *)
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_ReturnCurrentCycleNumber_ByOrgIDCycleYear( inOrgID : string; inYear : integer ) : integer;
var
   fQuery : tQuery;
begin
{
v

select org_id, isactive, num, cyear, sdate, edate from cycle
where org_id = "7FB9C701-73B9-4B5A-9C70-37F015035B51"
and "8/16/2007" between sdate and edate
order by num  desc


select distinct cyear from cycle
where org_id = "7FB9C701-73B9-4B5A-9C70-37F015035B51"
order by cyear


}
   { so. in this method, we get sent an ORG ID and a cycleNum and CycleYear combo boxes.
   we have to go to the cycle table and pull down the cyclces that match the orgasm }
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT DISTINCT CYEAR FROM ' + masterData.GetTable_Cycle +
         ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID ) +
         ' ORDER BY CYEAR ';
      fQuery.Open();
      //
      if (fQuery.RecordCount <> 0) then
      begin
      end;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_CycleExists( inCycle : tCycleRec ) : boolean;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Cycle +
         ' WHERE ORG_ID = ' + masterData.WrapDBID(inCycle.org_id) +
         ' AND NUM = ' + IntToStr( inCycle.num ) +
         ' AND CYEAR = ' + IntToStr( inCycle.year );
      fQuery.Open();
      //
      if (fQuery.FieldByName('TOT').AsInteger <> 0) then
         result := true
      else
         result := false;
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// todo: Cycle_CycleSalesPeriodExists needs to be completed.
function Cycle_CycleSalesPeriodExists( inCycle : tCycleRec ) : boolean;
begin
	result := false;
{
* Finish "Cycle_CycleSalesPeriodExists" inm toolbox_cycletoolboxunit. this method looks through the cycle rec to know by
        org, date from - date to - and ensures that a sales cycle doesn't overlap.

}
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleIDByOrgYearNum( inOrg : string; inYear : integer; inNum : integer) : string;
var
	fQuery : tQuery;
   orgID : string;
begin
   result := '';
   orgID := Org_GetOrgIDByOrgName( inOrg );

   if (orgID <> '') then
   begin
      fQuery := masterData.GetQuery();
      try
         fQuery.Close();
         fQuery.SQL.Text := 'SELECT ID, NUM, CYEAR, ORG_ID FROM ' + masterData.gettable_cycle +
            ' WHERE ORG_ID = ' + masterData.WrapDBID( orgID ) +
            ' AND CYEAR = ' + IntToStr( inYear) +
            ' AND NUM = ' + IntToStr( inNum );
         fQuery.Open();
         if ( fQuery.RecordCount <> 0) then
            result := fQuery.FieldByName('ID').AsString;
         fQuery.Close();
      finally
         FreeAndNil(fQuery);
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleByCycleID( inID : string ) : tCycleRec;
var
	fQuery : tQuery;
begin
   result := Cycle_InitCycleRecord();
   fQuery := masterData.GetQuery();
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.gettable_cycle +
         ' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
      begin
         result.id := fQuery.FieldByName('ID').AsString;
         result.org_id := fQuery.FieldByName('ORG_ID').AsString;
         result.year := fQuery.FieldByName('CYEAR').AsInteger;
         result.num := fQuery.FieldByName('NUM').AsInteger;
         result.sdate := fQuery.FieldByName('SDATE').AsDateTime;
         result.edate := fQuery.FieldByName('EDATE').AsDateTime;
         result.isactive := fQuery.FieldByName('ISACTIVE').AsBoolean;
         result.cname := fQuery.FieldByName('CYEAR').AsString + '/' + fQuery.FieldByName('NUM').AsString;
      end;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleEndDateByCycleID( inID : string ) : tDateTime;
var
	fQuery : tQuery;
begin
   result := NOW;
   fQuery := masterData.GetQuery();
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, EDATE FROM ' + masterData.gettable_cycle +
         ' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
      begin
         result := fQuery.FieldByName('EDATE').AsDateTime;
      end;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleCount : integer;
var
	fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery();
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.gettable_cycle;
      fQuery.Open();
      result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleIDByOrderID( inID : string ) : string;
var
	fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, C_ID FROM ' + masterData.GetTable_Order +
         ' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('C_ID').AsString;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Cycle_GetCycleMessageByCycleID( inID : string ) : string;
var
	fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT ID, IMSG FROM ' + masterData.gettable_cycle +
         ' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      result := fQuery.FieldByName('IMSG').AsString;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.


{
'ID VARCHAR(40), ' +
'ORG_ID VARCHAR(40), ' +
'ISACTIVE BOOLEAN, ' +
'NUM INTEGER, ' + // Cycle Number
'CYEAR INTEGER, ' + // cycle year
'IMSG BLOB(240, 1), ' + // specific invoice message for cycle
'SDATE DATE, ' + // start date
'EDATE DATE ',  // end date
}

