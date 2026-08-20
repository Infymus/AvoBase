 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_ExpenseToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
   recordstructureunit,
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

function Expense_InitExpenseRecord : tExpenseTypeRecord;
function Expense_ExpenseListExistsByCycleID( inID : string ) : boolean;
function Expense_ExpenseTypeRecordCount : integer;
function Expense_RecordCount : integer;
function Expense_GetOrgIDByExpenseListID( inEID : string ) : string;
function Expense_GetCycleIDByExpenseListID( inEID : string ) : string;
function Expense_GetExpenseTypeNameByID( inETID : string ) : string;
function Expense_GetExpenseTypeIDByExpenseTypeName( inName : string ) : string;
function Expense_ExpenseTypeCount : integer;
function Expense_GetExpenseIDByCycleID( inCycleID : string ) : string;
function Expense_GetExpenseTypeRecordByID( inETID : string ) : tExpenseTypeRecord;
procedure Expense_DeleteExpenseByExpenseID( inEID : string );
procedure Expense_AddAutoExpenseTypesToExpenseList( inID, inOrgID, inCycleID : string );
procedure Expense_ComboBox_FillActiveExpenseTypes( VAR inComboBox : tComboBox);


implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Expense_InitExpenseRecord : tExpenseTypeRecord;
begin
   with result do
   begin
      id := '';
      org_id := '';
      name := '';
      descr := '';
      isactive := false;
      autoa := false;
      taxded := false;
   end;
end;

{
         retVal := masterData.AddTable(masterData.dbPath + table_expenselist,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'C_ID VARCHAR(40)', // cycle id
}

function Expense_ExpenseListExistsByCycleID( inID : string ) : boolean;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Expense_List +
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

// This pulls all the expense types and adds them to an expense list automatically when one is created. It should
// only be called once.

procedure Expense_AddAutoExpenseTypesToExpenseList( inID, inOrgID, inCycleID : string );
var
   fExpTypeQuery : tQuery;
   fExpenseQuery : tQuery;
begin
   fExpTypeQuery := masterData.GetQuery();
   fExpenseQuery := masterData.GetQuery();
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
      fExpTypeQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Expense_Type + ' WHERE AUTOA = TRUE';
      fExpTypeQuery.Open();
      //
      fExpenseQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Expense;
      fExpenseQuery.Open();
      //
      if ( fExpTypeQuery.RecordCount <> 0 ) then
      begin
         repeat
            fExpenseQuery.Append();
{
         retVal := masterData.AddTable(masterData.dbPath + table_expense,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'E_ID VARCHAR(40), ' + // expense ID
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // expense type ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
}

            fExpenseQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
            fExpenseQuery.FieldByName('ORG_ID').AsString := inOrgID;
            fExpenseQuery.FieldByName('C_ID').AsString := inCycleID;
            fExpenseQuery.FieldByName('E_ID').AsString := inID;
            fExpenseQuery.FieldByName('AMOUNT').AsCurrency := 0;
            fExpenseQuery.FieldByName('MOPDATE').AsDateTime := Now;
            fExpenseQuery.FieldByName('MOPTYPE').AsInteger := 1;
            fExpenseQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
            fExpenseQuery.FieldByName('ET_ID').AsString := fExpTypeQuery.FieldByName('ID').AsString;
            fExpenseQuery.Post();
            //
            fExpTypeQuery.Next;
         until fExpTypeQuery.Eof;
      end;
      //
      fExpTypeQuery.Close();
      fExpenseQuery.Close();

   finally
      FreeAndNil(fExpTypeQuery);
      FreeAndNil(fExpenseQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Expense_RecordCount : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Expense_List;
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

function Expense_ExpenseTypeRecordCount : integer;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Expense_Type;
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

function Expense_GetOrgIDByExpenseListID( inEID : string ) : string;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, ORG_ID FROM ' + masterData.GetTable_Expense_List +
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

function Expense_GetCycleIDByExpenseListID( inEID : string ) : string;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, C_ID FROM ' + masterData.GetTable_Expense_List +
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

function Expense_GetExpenseTypeNameByID( inETID : string ) : string;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, NAME FROM ' + masterData.GetTable_Expense_Type +
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

procedure Expense_ComboBox_FillActiveExpenseTypes( VAR inComboBox : tComboBox);
var
   fQuery : tQuery;
begin
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT NAME, ISACTIVE FROM ' + masterData.GetTable_Expense_Type + ' ORDER BY NAME';
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

function Expense_GetExpenseTypeIDByExpenseTypeName( inName : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, NAME FROM ' + masterData.GetTable_Expense_Type;
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

procedure Expense_DeleteExpenseByExpenseID( inEID : string );
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_Expense +
         ' WHERE ID = ' + masterData.WrapDBID( inEID );
      //
      fQuery.ExecSQL();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Expense_ExpenseTypeCount : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Expense_Type;
      fQuery.Open();
      result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Expense_GetExpenseIDByCycleID( inCycleID : string ) : string;
 var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, C_ID FROM ' + masterData.GetTable_Expense_List +
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

function Expense_GetExpenseTypeRecordByID( inETID : string ) : tExpenseTypeRecord;
var
   fQuery : tQuery;
begin
   result := Expense_InitExpenseRecord();
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Expense_Type +
         ' WHERE ID = ' + masterData.WrapDBID( inETID );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
      begin
         result.id := fQuery.FieldByName('ID').AsString;
         result.org_id := fQuery.FieldByName('ORG_ID').AsString;
         result.name := fQuery.FieldByName('NAME').AsString;
         result.descr := fQuery.FieldByName('DESCR').AsString;
         result.isactive := fQuery.FieldByName('ISACTIVE').AsBoolean;
         result.autoa := fQuery.FieldByName('AUTOA').AsBoolean;
         result.taxded := fQuery.FieldByName('TAXDED').AsBoolean;
      end;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

end.


{
         retVal := masterData.AddTable(masterData.dbPath + table_expense_type,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40),' + // organization
            'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
            'DESCR VARCHAR(40)',

}

{
         retVal := masterData.AddTable(masterData.dbPath + table_expense,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'E_ID VARCHAR(40), ' + // expense ID
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // expense type ID
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
}
