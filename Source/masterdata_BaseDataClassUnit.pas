 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


{
[12:09] RonH: type
  TSomeClass = class(TObject)
    private
      fQuery: TADOQuery;
    public
      function FieldByName(AFieldName: String): TField;
  end;
implementation

function TSomeClass.FieldByName(AFieldName: String): TField;
begin
  Result := fQuery.FieldByName(AFieldName);
end;
[12:10] Infymus: that will do it?
[12:10] RonH: yup
[12:10] RonH: You expose the TQuery.FieldByName through you own method.
}

unit masterdata_BaseDataClassUnit;

interface uses
   constantsunit,
   masterdataunit,
   toolboxunit,
   inifileunit,
   errorresultunit,
   RecordStructureUnit,
   avobase_dialogformunit,
   //
   bde,
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   DBTables;

type
   tMasterData_BaseDataClass = class( tObject )
   private
      function getQuerySQL : string;
      function getRecordID: string;
      function fGetRecordCount : integer;
      function fGetDataSetState : TDataSetState;
   protected
      fMasterData : tMasterData;
      fTableName : string;
      fQuery : tQuery;
   public
      function Delete( inID : string ) : tErrorResult;
      function Load( inID : string ) : tErrorResult;
      function Post : tErrorResult;
      function Edit : tErrorResult;
      function Cancel : tErrorResult;
      function Append : tErrorResult;
      function Insert : tErrorResult;
      function Close : tErrorResult;
      // properties
      function GetFieldByName( inField : string ) : tErrorResult;
//      function SetFieldByName( inField : string) : tField; overload;
      function SetFieldByName( inField : string; invalue : string ): tErrorResult; overload;
      function SetFieldByName( inField : string; invalue : boolean ): tErrorResult; overload;
      function SetFieldByName( inField : string; invalue : integer ): tErrorResult; overload;
      function SetFieldByName( inField : string; invalue : TDateTime ): tErrorResult; overload;
      function SetFieldByName(inField: string; invalue: TDate): tErrorResult; overload;
      function SetFieldByname( inField : string; invalue : double ) : tErrorResult; overload;
      function SetFieldByName( inField : string; invalue : currency ) : tErrorResult; overload;
      //
      property tableName : string read fTableName;
      property SQL : string read getQuerySQL;
      property ID : string read getRecordID;
      property RecordCount : integer read fGetRecordCount;
      property State : TDataSetState read fGetDataSetState;
      //
      constructor create( inMasterData : tMasterData; inTable : string); virtual;
      destructor destroy; override;
   end;

implementation

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

constructor tMasterData_BaseDataClass.create(inMasterData: tMasterData; inTable : string);
begin
   fMasterData := inMasterData;
   fQuery := inMasterData.GetQuery();
   with fQuery do
   begin
   	SQL.Clear();
      SQL.Text := 'SELECT * FROM ' + inTable;
      Open();
   end;
   fTableName := inTable;
//   fValidateFields := fValidateFields.Create();
end;

destructor tMasterData_BaseDataClass.destroy;
begin
   if (fQuery.State in [dsEdit, dsInsert]) then
      fQuery.Cancel();
   fQuery.Close();
   FreeAndNil(fQuery);
//   FreeAndNil(fValidateFields);
   inherited;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.Edit: tErrorResult;
begin
   result := Error_Init();
	if (fQuery.State in [dsEdit, dsInsert]) then
   begin
   	result.errorResult := true;
      result.errorMessage := 'DATASET ALREADY IN INSERT/EDIT MODE';
   end else
   	fQuery.Edit();
end;

function tMasterData_BaseDataClass.fGetDataSetState: TDataSetState;
begin
   result := fQuery.State;
end;

function tMasterData_BaseDataClass.fGetRecordCount: integer;
begin
   result := fQuery.RecordCount;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.Cancel: tErrorResult;
begin
   result := Error_Init();
   try
      if (fQuery.State in [dsEdit, dsInsert]) then
         fQuery.Cancel();
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.Close: tErrorResult;
begin
   if (fQuery.State in [dsEdit, dsInsert]) then
      fQuery.Cancel();
   fQuery.Close();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.Delete(inID: string): tErrorResult;
begin
   result := Error_Init();
   try
      if (fQuery.State in [dsEdit, dsInsert]) then
         fQuery.Cancel();
      // now do the delete
   with fQuery do
   begin
   	SQL.Clear();
      SQL.Text := 'DELETE FROM ' + fTableName + ' WHERE ID = ' + fMasterData.WrapDBID( inID );
      ExecSQL();
   end;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.Load(inID: string): tErrorResult;
begin
   result := Error_Init();
   try
      with fQuery do
      begin
         SQL.Clear();
         SQL.Text := 'SELECT * FROM ' + fTableName +
            ' WHERE ID = ' + fMasterData.WrapDBID( inID );
         Open();
         if (RecordCount = 0) then
         begin
            result.errorResult := true;
            result.errorMessage := 'RECORD NOT FOUND';
         end;
      end;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.Post : tErrorResult;
var
	errMsg : string;
begin
	errMsg := '';
   // this is where we are going to do some validation that particular fields are.. something
   if ( Self.GetFieldByName('ID').AsString = '' ) then
      errMsg := 'Table cannot have a NULL ID : ' + Self.tableName;
   {
   if (fValidateFields.fieldName.Count <> 0) then
   begin

   end;
   }
	if ( errMsg = '' ) then
   begin
      result := Error_Init();
      try
         if (fQuery.State in [dsEdit, dsInsert]) then
            fQuery.Post();
      except
         on E:Exception do
         begin
            result.errorResult := true;
            result.errorMessage := E.Message;
            Error_Log( result, true );
         end;
      end;
   end else
      begin
         result.errorResult := true;
         result.errorMessage := errMsg;
         Error_Log( result, true );
      end;
end;


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.Append : tErrorResult;
begin
   result := Error_Init();
   try
      if (fQuery.State in [dsEdit, dsInsert]) then
         fQuery.Cancel();
      fQuery.Append();
      fQuery.FieldByName('ID').AsString := fMasterData.NewDBGuid();
      result.AsString := fQuery.FieldByName('ID').AsString;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.Insert: tErrorResult;
begin
   result := Error_Init();
   try
      if (fQuery.State in [dsEdit, dsInsert]) then
         fQuery.Cancel();
      fQuery.Insert();
      fQuery.FieldByName('ID').AsString := fMasterData.NewDBGuid();
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.getQuerySQL: string;
begin
   result := fQuery.SQL.Text;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.getRecordID: string;
begin
   result := fQuery.FieldByName('ID').AsString;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.GetFieldByName( inField: string ): tErrorResult;
begin
   result := Error_Init();
   try
   	// STRING
      if (fQuery.FieldByName( InField ).DataType = ftString) then
         result.AsString := fQuery.FieldByName( InField ).AsString;

      // ftMemo
      if (fQuery.FieldByName( InField ).DataType = ftMemo) then
         result.AsString := fQuery.FieldByName( InField ).AsString;

      // INTEGER
      if (fQuery.FieldByName( InField ).DataType = ftInteger) then
      begin
         result.asInteger := fQuery.FieldByName( InField ).AsInteger;
         result.AsString := fQuery.FieldByName( InField ).AsString;
      end;

      // BOOLEAN
      if (fQuery.FieldByName( InField ).DataType = ftBoolean) then
         result.AsBoolean := fQuery.FieldByName( InField ).AsBoolean;

      // DATETIME
      if (fQuery.FieldByName( InField ).DataType = ftDateTime) then
         result.AsDateTime := fQuery.FieldByName( InField ).asDateTime;

      // DATE
      if (fQuery.FieldByName( InField ).DataType = ftDate) then
         result.AsDateTime := fQuery.FieldByName( InField ).AsDateTime;

      // CURRENCY
      if (fQuery.FieldByName( InField ).DataType = ftCurrency) then
         result.AsCurrency := fQuery.FieldByName( InField ).AsCurrency;

      // FTFLOAT
      if (fQuery.FieldByName( InField ).DataType = ftFloat) then
      begin
         result.AsCurrency := fQuery.FieldByName( InField ).AsCurrency;
         result.AsDouble := fQuery.FieldByName( InField ).AsFloat;
      end;

{
	ftBlob
	ftBytes
	ftCurrency
	ftDate
	ftDateTime
	ftExtended
	ftFloat
	ftFmtMemo
	ftGraphic
	ftGUID
	ftLargeInt
	ftMemo
	ftSmallint
	ftTime
	ftTimeStamp
	ftVarBytes
	ftBlob
	ftWideString
	ftWord
}
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tMasterData_BaseDataClass.SetFieldByName( inField : string; inValue : string ): tErrorResult;
begin
   result := Error_Init();
   try
      fQuery.FieldByName( inField ).AsString := inValue;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

function tMasterData_BaseDataClass.SetFieldByName(inField: string; invalue: boolean): tErrorResult;
begin
   result := Error_Init();
   try
      fQuery.FieldByName( inField ).AsBoolean := inValue;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

function tMasterData_BaseDataClass.SetFieldByName(inField: string; invalue: integer): tErrorResult;
begin
   result := Error_Init();
   try
      fQuery.FieldByName( inField ).asInteger := inValue;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;


function tMasterData_BaseDataClass.SetFieldByName(inField: string; invalue: TDateTime): tErrorResult;
begin
   result := Error_Init();
   try
      fQuery.FieldByName( inField ).AsDateTime := inValue;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

function tMasterData_BaseDataClass.SetFieldByName(inField: string; invalue: TDate): tErrorResult;
begin
   result := Error_Init();
   try
      fQuery.FieldByName( inField ).AsDateTime := inValue;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;


function tMasterData_BaseDataClass.SetFieldByName(inField: string; invalue: double ): tErrorResult;
begin
   result := Error_Init();
   try
      fQuery.FieldByName( inField ).AsFloat := inValue;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

function tMasterData_BaseDataClass.SetFieldByName(inField: string; invalue: currency): tErrorResult;
begin
   result := Error_Init();
   try
      fQuery.FieldByName( inField ).AsCurrency := inValue;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         Error_Log( result, true );
      end;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

end.
