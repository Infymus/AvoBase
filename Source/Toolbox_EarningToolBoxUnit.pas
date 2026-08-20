 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_EarningToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  encryptunit,
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_EarningListExistsByCycleID( inID : string ) : boolean;
function Earning_EarningTypeRecordCount : integer;
function Earning_RecordCount : integer;
function Earning_GetOrgIDByEarningListID( inEID : string ) : string;
function Earning_GetCycleIDByEarningListID( inEID : string ) : string;
function Earning_GetEarningTypeNameByID( inETID : string ) : string;
function Earning_GetEarningTypeIDByEarningTypeName( inName : string ) : string;
function Earning_EarningTypeCount : integer;
function Earning_GetEarningIDByCycleID( inCycleID : string ) : string;

procedure Earning_DeleteEarningByEarningID( inEID : string );
procedure Earning_AddAutoEarningTypesToEarningList( inID, inOrgID, inCycleID : string );
procedure Earning_ComboBox_FillActiveEarningTypes( VAR inComboBox : tComboBox);


implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
         retVal := masterData.AddTable(masterData.dbPath + table_Earninglist,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'C_ID VARCHAR(40)', // cycle id
}

function Earning_EarningListExistsByCycleID( inID : string ) : boolean;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Earning_List +
         ' WHERE C_ID = ' + masterData.WrapDBID( inID );
      fQuery.Open();
      //
      result := ( fQuery.FieldByName('TOT').AsInteger <> 0);
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This pulls all the Earning types and adds them to an Earning list automatically when one is created. It should
// only be called once.

procedure Earning_AddAutoEarningTypesToEarningList( inID, inOrgID, inCycleID : string );
var
   fExpTypeQuery : tQuery;
   fEarningQuery : tQuery;
begin
   fExpTypeQuery := masterData.GetQuery();
   fEarningQuery := masterData.GetQuery();
   //
   try
{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40),' + // organization
            'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
            'DESCR VARCHAR(40)',
}
      fExpTypeQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Earning_Type + ' WHERE AUTOA = TRUE';
      fExpTypeQuery.Open();
      //
      fEarningQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Earning;
      fEarningQuery.Open();
      //
      if ( fExpTypeQuery.RecordCount <> 0 ) then
      begin
         repeat
            fEarningQuery.Append();
{
         retVal := masterData.AddTable(masterData.dbPath + table_Earning,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'E_ID VARCHAR(40), ' + // Earning ID
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // Earning type ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
}

            fEarningQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
            fEarningQuery.FieldByName('ORG_ID').AsString := inOrgID;
            fEarningQuery.FieldByName('C_ID').AsString := inCycleID;
            fEarningQuery.FieldByName('E_ID').AsString := inID;
            fEarningQuery.FieldByName('AMOUNT').AsCurrency := 0;
            fEarningQuery.FieldByName('MOPDATE').AsDateTime := Now;
            fEarningQuery.FieldByName('MOPTYPE').AsInteger := 1;
            fEarningQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
            fEarningQuery.FieldByName('ET_ID').AsString := fExpTypeQuery.FieldByName('ID').AsString;
            fEarningQuery.Post();
            //
            fExpTypeQuery.Next;
         until fExpTypeQuery.Eof;
      end;
      //
      fExpTypeQuery.Close();
      fEarningQuery.Close();

   finally
      FreeAndNil(fExpTypeQuery);
      FreeAndNil(fEarningQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_RecordCount : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Earning_List;
      fQuery.Open();
      //
      result := ( fQuery.FieldByName('TOT').AsInteger );
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_EarningTypeRecordCount : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Earning_Type;
      fQuery.Open();
      //
      result := ( fQuery.FieldByName('TOT').AsInteger );
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_GetOrgIDByEarningListID( inEID : string ) : string;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, ORG_ID FROM ' + masterData.GetTable_Earning_List +
         ' WHERE ID = ' + masterData.WrapDBID( inEID );
      fQuery.Open();
      //
      result := ( fQuery.FieldByName('ORG_ID').AsString );
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_GetCycleIDByEarningListID( inEID : string ) : string;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, C_ID FROM ' + masterData.GetTable_Earning_List +
         ' WHERE ID = ' + masterData.WrapDBID( inEID );
      fQuery.Open();
      //
      result := ( fQuery.FieldByName('C_ID').AsString );
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_GetEarningTypeNameByID( inETID : string ) : string;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, NAME FROM ' + masterData.GetTable_Earning_Type +
         ' WHERE ID = ' + masterData.WrapDBID( inETID );
      fQuery.Open();
      //
      result := ( fQuery.FieldByName('NAME').AsString );
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Earning_ComboBox_FillActiveEarningTypes( VAR inComboBox : tComboBox);
var
   fQuery : tQuery;
begin
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT NAME, ISACTIVE FROM ' + masterData.GetTable_Earning_Type + ' ORDER BY NAME';
      fQuery.Open();
      //
      repeat
         if ( fQuery.FieldByName('ISACTIVE').AsBoolean ) then
            inComboBox.Items.Add(fQuery.FieldByName('NAME').AsString);
         fQuery.Next();
      until fQuery.Eof;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_GetEarningTypeIDByEarningTypeName( inName : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, NAME FROM ' + masterData.GetTable_Earning_Type;
      fQuery.Open();
      //
      repeat
         if ( fQuery.FieldByName('NAME').AsString = inName) then
            result := fQuery.FieldByName('ID').AsString;
         fQuery.Next();
      until fQuery.Eof;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Earning_DeleteEarningByEarningID( inEID : string );
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_Earning +
         ' WHERE ID = ' + masterData.WrapDBID( inEID );
      //
      fQuery.ExecSQL();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_EarningTypeCount : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Earning_Type;
      fQuery.Open();
      result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Earning_GetEarningIDByCycleID( inCycleID : string ) : string;
 var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, C_ID FROM ' + masterData.GetTable_Earning_List +
         ' WHERE C_ID = ' + masterData.WrapDBID( inCycleID );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName('ID').AsString;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

{
         retVal := masterData.AddTable(masterData.dbPath + table_earninglist,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'C_ID VARCHAR(40)', // cycle id
}

{
         retVal := masterData.AddTable(masterData.dbPath + table_Earning_type,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40),' + // organization
            'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
            'DESCR VARCHAR(40)',

}

{
         retVal := masterData.AddTable(masterData.dbPath + table_Earning,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'E_ID VARCHAR(40), ' + // Earning ID
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // Earning type ID
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
}
