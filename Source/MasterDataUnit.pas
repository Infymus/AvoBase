 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

{ bde paradox 7.0 implementation }
 
unit	MasterDataUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  RecordStructureUnit,
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

// Tables
const
   table_main = 'main.db';
   table_preference = 'prefs.db';
   // brochures
   table_brochure = 'book.db';
   table_customer_brochure = 'custbook.db';
   // customers
   table_customer = 'cust.db';
   // cycles
   table_cycle = 'cycle.db';
   // email
   table_email = 'email.db';
   // expenses
   table_expenselist = 'expl.db';
   table_expense = 'exp.db';
   table_expense_type = 'expt.db';
   // earnings
   table_earninglist = 'ernl.db';
   table_earning = 'ern.db';
   table_earning_type = 'ernt.db';
   // fees
   table_fee = 'fee.db';
   // orgs
   table_org = 'org.db';
   // products
   table_product = 'prod.db';
   // shipping
   table_shipping = 'ship.db';
   // payments, credits and transactions
   table_escrow = 'escrow.db';
   table_mop = 'mop.db';
   table_reversal = 'rev.db';
   table_trans = 'tran.db';
   // orders
   table_order = 'ord.db';
   table_order_product = 'ordprod.db';
   table_order_fee = 'ofee.db';
   // Taxes
   table_tax_master = 'mtax.db';
   table_tax = 'tax.db';
   // Temporary Tables for reports
   table_report = 'cacc.db';
   table_report2 = 'cacc2.db';
   // back ordered tables
   table_backordered = 'bo.db';
   // Return Manager
   table_returntable = 'rt.db';
   // Table Help
   table_helptable = 'help.db';
   table_helpmaketable = 'helpmake.db';
   // Table AvoReps
   table_avoreps = 'avobase_reps.db';
   // Table Customer Notes
   table_custnotes = 'cnotes.db';
   // Table Customer Product
   table_custproduct = 'prod.db';

// The Master Data Record
type
  tMasterData = class(tObject)
   	Constructor Create; virtual;
      Destructor Destroy; override;
   private
   	fdbPath : string;
      fAvoBaseSession: TSession;
      //
      function fGetDatabasePath() : string;
      function fGetDatabaseVersion() : integer;
      function fGetApplicationRunPath() : string;
      //
      function fGetTableName_Cust : string;
      function fGetTableName_Main : string;
      function fGetTableName_Order : string;
      function fGetTableName_Product : string;
      function fGetTableName_Preference : string;
      function fGetTableName_Cycle : string;
      function fGetTableName_Mop : string;
      function fGetTableName_OrderFee : string;
      function fGetTableName_Fee : string;
      function fGetTableName_Org : string;
      function fGetTableName_Tax : string;
      function fGetTableName_Brochure : string;
      function fGetTableName_Customer_Brochure : string;
      function fGetTableName_Email : string;
      function fGetTableName_Earning : string;
      function fGetTableName_Expense : string;
      function fGetTableName_Expense_Type : string;
      function fGetTableName_Earning_Type : string;
      function fGetTableName_Order_Product : string;
      function fGetTableName_Order_Fee : string;
      function fGetTableName_Shipping : string;
      function fGetTableName_Reversal : string;
      function fGetTableName_Escrow : string;
      function fGetTableName_CustAcc : string;
      function fGetTableName_EarningList : string;
      function fGetTableName_ExpenseList : string;
      function fGetTableName_BackOrdered : string;
      function fGetTableName_Trans : string;
      function fGetTableName_Returns : string;
      function fGetTableName_Tax_Master : string;
      function fGetTableName_Report2 : string;
      function fGetTableName_Help : string;
      function fGetTableName_AvoReps : string;
      function fGetTableName_HelpMake : string;
      function fGetTableName_CustNotes : string;
      function fGetTableName_CustProd  : string;
      //
      procedure fSetDatabasePath( inPath : string);
      //
      function CreateAvoBaseINIFile() : tErrorResult;
   public
   	// CRUD methods
      function AddField(inTableName : string; inFieldName : string; inFieldType : string ) : tErrorResult;
      function AddIndex(inTableName, inIndexName, inIndexFields : string; inIndexOptions : TIndexOptions ) : tErrorResult;
      function AddTable(inTableName : string; inFields : string; inPrimaryKey : string ) : tErrorResult;
      function RemoveField(inTableName : string; inFieldName : string ) : tErrorResult;
      function RemoveIndex(inTableName : string; inIndexName : string ) : tErrorResult;
      function RemoveTable(inTableName : string ) : tErrorResult;
      function TableExists(inTableName : string ) : boolean;
      //
      function SetDataBaseVersion(  inDBVersion : integer ) : tErrorResult;
      function CompareVersion( inDbVersion : integer ) : boolean;
      function GetDataSet( inTableName : string ) : tDataSet;
      function GetQuery : tQuery;
      function GetTable : tTable;
      function NewDBGuid : String;
      function QueryAddFields( inQuery : tQuery) : tErrorResult;
      function QueryAddCalculatedField( inQuery : tQuery; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
      function WrapDBID( inID : string ) : string;
      function QueryExecute( inQuery : string ) : tErrorResult;
      //
      property AvoBaseSession: TSession read fAvoBaseSession;
      property dbPath : string read fGetDatabasePath write fSetDatabasepath;
      property dbVersion : integer read fGetDatabaseVersion;
      property runPath : string read fGetApplicationRunPath;
      //
      // Tables
      property Gettable_Customer : string read fGetTableName_Cust;
      property Gettable_Main : string read fGetTableName_Main;
      property GetTable_Order : string read fGetTableName_Order;
      property GetTable_Product : string read fGetTableName_Product;
      property GetTable_Preference : string read fGettablename_Preference;
      property GetTable_Cycle : string read fGetTableName_Cycle;
      property GetTable_Mop : string read fGetTableName_Mop;
      property GetTable_OrderFee : string read fGetTableName_OrderFee;
      property GetTable_Fee : string read fGetTableName_Fee;
      property GetTable_Org : string read fGetTableName_Org;
      property GetTable_Tax : string read fGetTableName_Tax;
      property GetTable_Tax_Master : string read fGetTableName_Tax_Master;
      property GetTable_Brochure : string read fGetTableName_Brochure;
      property GetTable_Customer_Brochure : string read fGetTableName_Customer_Brochure;
      property GetTable_Email : string read fGetTableName_Email;
      property GetTable_Earning_List : string read fGetTableName_EarningList;
      property GetTable_Earning : string read fGetTableName_Earning;
      property GetTable_Expense : string read fGetTableName_Expense;
      property GetTable_Expense_Type : string read fGetTableName_Expense_Type;
      property GetTable_Earning_Type : string read fGetTableName_Earning_Type;
      property GetTable_Order_Product : string read fGetTableName_Order_Product;
      property GetTable_Order_Fee : string read fGetTableName_Order_Fee;
      property GetTable_Shipping : string read fGetTableName_Shipping;
      property GetTable_Reversal : string read fGetTableName_Reversal;
      property GetTable_Escrow : string read fGetTableName_Escrow;
      property GetTable_Report : string read fGetTableName_CustAcc;
      property GetTable_Report2 : string read fGetTableName_Report2;
      property GetTable_Expense_List : string read fGetTableName_ExpenseList;
      property GetTable_BackOrdered : string read fGetTableName_BackOrdered;
      property GetTable_Transactions : string read fGetTableName_Trans;
      property GetTable_Returns : string read fGetTableName_Returns;
      property GetTable_Help : string read fGetTableName_Help;
      property GetTable_HelpMake : string read fGetTableName_HelpMake;
      property GetTable_AvoReps : string read fGetTableName_AvoReps;
      property GetTable_CustomerNotes : string read fGetTableName_CustNotes;
      property GetTable_CustomerProducts : string read fGetTableName_CustProd;
   end;

var   masterData : tMasterData; { YES this is here. NO don't delete it. }

IMPLEMENTATION

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.CompareVersion(inDbVersion: integer): boolean;
var
   dbVer : integer;
begin
   dbVer := dbVersion;
   //
   if ( dbVer > inDbVersion ) then
      result := false
   else
      result := true;
   // Is the database brand new? 0 = Yes.
   if ( dbVer = 0 ) then
      result := True;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

Constructor TMasterData.Create;
begin
   Inherited Create();
   //
   if (NOT FileExists(runPath + AVOBASE_INI)) then
      CreateAvoBaseINIFile();
   //
   DBPath := AvoINIReadString(AVOBASE_NAME, 'DBPath', 'ERROR');
   //
   // The trick here is to NOT use the BDE "DataBaseName", otherwise you get trapped in the BDE
   // Configuration. You can set your DB path the way you want by using the PrivateDir and NetFileDir.
   fAvoBaseSession := TSession.Create(nil);
   fAvoBaseSession.Active := False;
   fAvoBaseSession.SessionName := AVOBASE_SESSION_NAME;
   fAvoBaseSession.PrivateDir := DBPath;
   fAvoBaseSession.NetFileDir := DBPath;
   fAvoBaseSession.Active := True;
   fAvoBaseSession.Open();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

Destructor TMasterData.Destroy;
begin
  if Assigned(fAvoBaseSession) then
  begin
    if (fAvoBaseSession.Active) then
      fAvoBaseSession.Close();
    FreeAndNil(fAvoBaseSession);
  end;
  //
  Inherited Destroy;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.fGetApplicationRunPath : string;
begin
   result := IncludeTrailingBackSlash(ExtractFilePath(ParamStr(0)));
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.TableExists(inTableName : string ) : boolean;
begin
   result := FileExists(dbPath + inTableName);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// this wraps any string in quotes. we're not using integers anymore for ids, this makes less work in string manipulation.
function tMasterData.WrapDBID(inID: string): string;
begin
	result := #34 + inId + #34;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.CreateAvoBaseINIFile() : tErrorResult;
var
   avoINIFile : tIniFile;
begin
   result := Error_Init();
   try
      avoINIFile := tIniFile.Create(runPath + AVOBASE_INI);
      avoINIFile.WriteString(AVOBASE_NAME,'RunPath',runPath);
      avoINIFile.WriteString(AVOBASE_NAME,'DBPath',runPath + 'DataBase\');
      dbPath := AvoINIFile.ReadString(AVOBASE_NAME, 'DBPath', 'ERROR');
      FreeAndNil(avoINIFile);
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log(result, false);
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.fGetDatabasePath() : string;
begin
  result := fdbPath;
end;

procedure tMasterData.fSetDatabasePath(inPath: string);
begin
   fdbPath := inPath;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ Get and Set the Database Versions }

function tMasterData.fGetDatabaseVersion : integer;
var
  versionTable : tTable;
begin
  result := 0;
  if (TableExists(table_main)) then
  begin
    try
      versionTable := GetTable();
      versionTable.tableName := dbpath + table_main;
      //
      versionTable.Open();
      versionTable.First();
      result := versionTable.FieldByName('DBID').AsInteger;
    finally
      versionTable.Close();
      FreeAndNil(versionTable);
    end;
  end;
end;

function tMasterData.SetDataBaseVersion(  inDBVersion : integer ) : tErrorResult;
var
  versionTable : tTable;
begin
   result := Error_Init;
   try
      versionTable := GetTable();
      versionTable.tableName := dbpath + table_Main;
      //
      versionTable.Open();
      versionTable.First();
      versionTable.Edit();
      versionTable.FieldByName('DBID').Value := inDBVersion;
      versionTable.Post();
   finally
      versionTable.Close();
      FreeAndNil(versionTable);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.fGetTableName_Escrow: string;
begin
   result := '"' + fdbPath + table_escrow + '"';
end;

function tMasterData.fGetTableName_Cust: string;
begin
   result := '"' + fdbPath + table_customer + '"';
end;

function tMasterData.fGetTableName_CustAcc: string;
begin
   result := '"' + dbPath + table_report + '"';
end;

function tMasterData.fGetTableName_CustNotes: string;
begin
   result := '"' + dbPath + table_custnotes + '"';
end;

function tMasterData.fGetTableName_Main: string;
begin
   result := '"' + dbPath + table_main + '"';
end;

function tMasterData.fGetTableName_Mop: string;
begin
   result := '"' + dbPath + table_mop + '"';
end;

function tMasterData.fGetTableName_Order: string;
begin
   result := '"' + dbPath + table_order + '"';
end;

function tMasterData.fGetTableName_OrderFee: string;
begin
   result := '"' + dbPath + table_order_fee + '"';
end;

function tMasterData.fGetTableName_Org: string;
begin
   result := '"' + dbPath + table_org + '"';
end;

function tMasterData.fGetTableName_Shipping : string;
begin
   result := '"' + dbPath + table_shipping + '"';
end;

function tMasterData.fGetTableName_Cycle : string;
begin
   result := '"' + dbPath + table_cycle + '"';
end;

function tMasterData.fGetTableName_Fee: string;
begin
   result := '"' + dbPath + table_fee + '"';
end;

function tMasterData.fGetTableName_Help: string;
begin
   result := '"' + dbPath + table_helptable + '"';
end;

function tMasterData.fGetTableName_HelpMake: string;
begin
   result := '"' + dbPath + table_helpmaketable + '"';
end;

function tMasterData.fGetTableName_Preference: string;
begin
   result := '"' + dbPath + table_preference + '"';
end;

function tMasterData.fGetTableName_Product: string;
begin
   result := '"' + dbPath + table_product + '"';
end;

function tMasterData.fGetTableName_Tax: string;
begin
   result := '"' + dbPath + table_tax + '"';
end;

function tMasterData.fGetTableName_Tax_Master: string;
begin
   result := '"' + dbPath + table_tax_master + '"';
end;

function tMasterData.fGetTableName_Trans: string;
begin
   result := '"' + dbPath + table_trans + '"';
end;

function tMasterData.fGetTableName_AvoReps: string;
begin
   result := '"' + dbPath + table_avoreps + '"';
end;

function tMasterData.fGetTableName_BackOrdered: string;
begin
   result := '"' + dbPath + table_backordered + '"';
end;

function tMasterData.fGetTableName_Brochure : string;
begin
   result := '"' + dbPath + table_Brochure + '"';
end;

function tMasterData.fGetTableName_Customer_Brochure : string;
begin
   result := '"' + dbPath + table_customer_brochure+ '"';
end;

function tMasterData.fGetTableName_CustProd: string;
begin
   result := '"' + dbPath + table_custproduct + '"';
end;

function tMasterData.fGetTableName_Email : string;
begin
   result := '"' + dbPath + table_email+ '"';
end;

function tMasterData.fGetTableName_Earning : string;
begin
   result := '"' + dbPath + table_earning+ '"';
end;

function tMasterData.fGetTableName_EarningList: string;
begin
   result := '"' + dbPath + table_earninglist + '"';
end;

function tMasterData.fGetTableName_Expense : string;
begin
   result := '"' + dbPath + table_expense+ '"';
end;

function tMasterData.fGetTableName_ExpenseList: string;
begin
   result := '"' + dbPath + table_expenselist + '"';
end;

function tMasterData.fGetTableName_Expense_Type : string;
begin
   result := '"' + dbPath + table_expense_type+ '"';
end;

function tMasterData.fGetTableName_Earning_Type : string;
begin
   result := '"' + dbPath + table_earning_type+ '"';
end;

function tMasterData.fGetTableName_Order_Product : string;
begin
   result := '"' + dbPath + table_order_product+ '"';
end;

function tMasterData.fGetTableName_Order_Fee : string;
begin
   result := '"' + dbPath + table_order_fee + '"';
end;

function tMasterData.fGetTableName_Report2: string;
begin
   result := '"' + dbPath + table_report2 + '"';
end;

function tMasterData.fGetTableName_Returns: string;
begin
   result := '"' + dbPath + table_returntable + '"';
end;

function tMasterData.fGetTableName_Reversal: string;
begin
   result := '"' + dbPath + table_reversal + '"';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.GetDataSet(inTableName: string): tDataSet;
begin
  result := tDataSet.Create(nil);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.GetQuery: tQuery;
begin
	result := tQuery.Create(nil);
   with result do
   begin
      SessionName := AvoBaseSession.SessionName;
      RequestLive := true;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.GetTable: tTable;
begin
   result := tTable.create(nil);
   result.active := false;
   result.sessionName := AVOBASE_SESSION_NAME;
   result.tableType := tTParadox;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.NewDBGuid: String;
var
   Guid : tGuid;
   tempStr : string;
begin
   CreateGuid( Guid );
   tempStr := GUIDToString( Guid );
   System.Delete(tempStr, 1, 1);
   System.Delete(tempStr, Length(TempStr), 1);
   result := tempStr;
end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.RemoveField(inTableName, inFieldName: string): tErrorResult;
var
  fQuery : tQuery;
begin
   result := Error_Init;
   try
      fQuery := GetQuery;
      fQuery.SQL.Clear();
      fQuery.SQL.Add('ALTER TABLE ' + inTableName);
      fQuery.SQL.Add('DROP COLUMN ' + inFieldName);
      fQuery.ExecSQL;
      fQuery.Close();
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log(result, false);
      end;
   end;
   FreeAndNil(fQuery);
end;
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.RemoveIndex(inTableName, inIndexName: string): tErrorResult;
begin
   result := Error_Init;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.RemoveTable(inTableName: string): tErrorResult;
begin
   try
      if ( FileExists( dbPath + inTableName ) ) then
         if (NOT DeleteFile( dbPath + inTableName )) then
         begin
            result.errorResult := true;
            result.errorMessage := 'Unable to delete temporary data table!';
            Error_Log(result, true);
         end;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log(result, true);
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.AddField(inTableName : string; inFieldName : string; inFieldType : string ) : tErrorResult;
var
  fQuery : tQuery;
begin
   result := Error_Init;
   try
      fQuery := GetQuery;
      fQuery.SQL.Clear();
      fQuery.SQL.Add('ALTER TABLE ' + inTableName);
      fQuery.SQL.Add('ADD ' + inFieldName + ' ' + inFieldType + ';');
      fQuery.ExecSQL;
      fQuery.Close();
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log(result, false);
      end;
   end;
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.AddIndex(inTableName, inIndexName, inIndexFields : string; inIndexOptions : TIndexOptions ) : tErrorResult;
var
   fIndexTable : tTable;
   index : integer;
begin
   fIndexTable := tTable.Create( nil );
   try
      fIndexTable.SessionName := AvoBaseSession.SessionName;
      fIndexTable.TableName := inTableName;
      fIndexTable.FieldDefs.Updated := False;
      FIndexTable.FieldDefs.Update();
      //
      index := fIndexTable.IndexDefs.IndexOf( inIndexName );
      if ( index = -1 ) then
         fIndexTable.AddIndex( inIndexName, inIndexFields, inIndexOptions);
      //
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log(result, false);
      end;
   end;
   FreeAndNil( fIndexTable );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.AddTable(inTableName : string; inFields : string; inPrimaryKey : string ) : tErrorResult;
var
   fQuery : tQuery;
   SQLText : String;
begin
   result := Error_Init;
   SQLText := 'CREATE TABLE "' + inTableName + '" ';
   if (inPrimaryKey <> '') then
      SQLText := SQLText + '(' + inFields + ', PRIMARY KEY (' + inPrimaryKey + '));'
   else
      SQLText := SQLText + '(' + inFields + ')';
   try
      fQuery := GetQuery;
      fQuery.SQL.Clear;
      fQuery.SQL.Text := SQLText;
      fQuery.ExecSQL;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log(result, false);
      end;
   end;
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This creates a custom calculated field and adds it to the passed in dataset. This way
// we can create them on the fly.
function tMasterData.QueryAddCalculatedField( inQuery : tQuery; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
var
  tStrField : tStringField;
  tIntField : tIntegerField;
  tBoolField : TBooleanField;
  tCurrField : TCurrencyField;
  tDtTField : TDateTimeField;
begin
   result := Error_Init;
   if (inFieldType = ftString) then
   begin
   	tStrField := tStringField.Create( inQuery );
      tStrField.fieldKind := fkCalculated;
      tStrField.fieldName := inFieldName;
      tStrField.name := inFieldName;
      tStrField.Size := inSize;
      tStrField.dataSet := inQuery;
   end;
   if (inFieldType = ftInteger) then
   begin
   	tIntField := tIntegerField.Create( inQuery );
      tIntField.fieldKind := fkCalculated;
      tIntField.fieldName := inFieldName;
      tIntField.name := inFieldName;
      tIntField.dataSet := inQuery;
   end;
   if (inFieldType = ftBoolean) then
   begin
   	tBoolField := TBooleanField.Create( inQuery );
      tBoolField.fieldKind := fkCalculated;
      tBoolField.fieldName := inFieldName;
      tBoolField.name := inFieldName;
      tBoolField.dataSet := inQuery;
   end;
   if (inFieldType = ftCurrency) then
   begin
   	tCurrField := TCurrencyField.Create( inQuery );
      tCurrField.fieldKind := fkCalculated;
      tCurrField.fieldName := inFieldName;
      tCurrField.name := inFieldName;
      tCurrField.dataSet := inQuery;
   end;
   if (inFieldType = ftDateTime ) then
   begin
   	tDtTField := TDateTimeField.Create( inQuery );
      tDtTField.fieldKind := fkCalculated;
      tDtTField.fieldName := inFieldName;
      tDtTField.name := inFieldName;
      tDtTField.dataSet := inQuery;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.QueryAddFields( inQuery : tQuery) : tErrorResult;
var
   fCount : integer;
begin
   result := Error_Init;
   try
      inQuery.FieldDefs.Update();
      for fCount := 0 to inQuery.FieldDefList.Count -1 do
      with inQuery.FieldDefList[fCount] do
      begin
         if (DataType <> ftUnknown) and not (DataType in ObjectFieldTypes) and
            not ((faHiddenCol in Attributes) and not inQuery.FIeldDefs.HiddenFields) then
               CreateField(inQuery, nil, inQuery.FieldDefList.Strings[fCount]);
      end;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log(result, true);
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tMasterData.QueryExecute(inQuery: string): tErrorResult;
var
   fQuery : tQuery;
   SQLText : String;
begin
   result := Error_Init;
   SQLText := inQuery;
   try
      fQuery := GetQuery;
      fQuery.SQL.Clear;
      fQuery.SQL.Text := SQLText;
      fQuery.ExecSQL;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log(result, false);
      end;
   end;
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



end.




