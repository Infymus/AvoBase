 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_CustomerListUnit;

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
  toolbox_ProductToolBoxUnit,
  toolbox_customerToolboxunit,
  masterdataunit,
  Order_InvoiceObjectUnit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataCustomerList = class(tQuery)
   private
   	fQuery : tQuery;
      fMasterData : tMasterData;
   	procedure HandleCalculated(DataSet: TDataSet);
		function ExportText(fName: string; quoteType : string )  : tErrorResult;
	public
      //
      function Export( fName : string; fType : tAvoBaseExportTypes) : tErrorResult;
      procedure Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
      //
      constructor Create( inMasterData : tMasterData);  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataCustomerList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Customer;
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
   masterData.QueryAddCalculatedField( self, 'TotO', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'TOTN', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'TotC', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'FullName', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'FullAddr', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'BOT', 1, ftInteger);
   // even if we add active := true here, it won't activate within the create methodology.
	fQuery := masterData.GetQuery;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataCustomerList.destroy;
begin
	FreeAndNil(fQuery);
   inherited;
end;


(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataCustomerList.HandleCalculated(DataSet: TDataSet);
var
   tempStr : String;
begin
   DataSet.FieldByName('TOTO').Value := Order_GetTotalOpenOrdersByCustID( DataSet.FieldByName('ID').AsString );
   DataSet.FieldByName('TOTC').Value := Order_GetTotalClosedOrdersByCustID( DataSet.FieldByName('ID').AsString );
   DataSet.FieldByName('TOTN').Value := Customer_GetTotalNoteCountByCustID( DataSet.FieldByName('ID').AsString );
   // Field: FullName
   DataSet.FieldByName('FullName').Value := Self.FieldByName('FNAME').AsString + #32 +
		Self.FieldByName('LNAME').AsString;
{
   if (NOT DataSet.FieldByName('ISACTIVE').AsBoolean) then
   	Dataset.FieldByName('FullName').Value := '* ' + Dataset.FieldByName('FullName').Value;
}
   // Field: FullAddr
   tempStr := Self.FieldByName('ADDR1').AsString;
   if (Self.FieldByname('ADDR2').AsString <> '') then
   	tempStr := tempStr + ', ' + Self.FieldByname('ADDR2').AsString;
   if (Self.FieldByname('CITY').AsString <> '') then
   	tempStr := tempStr + ', ' + Self.FieldByname('CITY').AsString;
   if (Self.FieldByname('STATE').AsString <> '') then
   	tempStr := tempStr + ', ' + Self.FieldByname('STATE').AsString;
   if (Self.FieldByname('ZIP').AsString <> '') then
   	tempStr := tempStr + ', ' + Self.FieldByname('ZIP').AsString;
   DataSet.FieldByName('FullAddr').Value := tempStr;
   //
   DataSet.FieldByName('BOT').Value := Product_GetBackOrderItemCountByCustomerID( DataSet.FieldByName('ID').AsString );
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataCustomerList.Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
var
   errResult : tErrorResult;
   sql : string;
begin
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Customer;
   if (inActiveState in [stateActive]) then
      sql := sql + ' WHERE ISACTIVE = TRUE';
   if (inActiveState in [stateInactive]) then
   	sql := sql + ' WHERE ISACTIVE = FALSE';
   if (inOrderBy <> '') then
      sql := sql + ' ORDER BY ' + inOrderBy;
   if (inSortOpt <> '') then
   	sql := sql + ' ' + inSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

// Export the query
function tMasterDataCustomerList.Export(fName: string; fType: tAvoBaseExportTypes) : tErrorResult;
begin
	result := Error_Init();
	//
   case fType of
      tAvoBaseExportTypes.Text_CommaDelimited : ExportText( fName, '' );
     	tAvoBaseExportTypes.Text_CommaDelimitedQuotes : ExportText( fName, '"' );
      tAvoBaseExportTypes.Text_CommaDelimitedSingleQuotes : ExportText( fName, '''' );
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'FNAME VARCHAR(30), ' +
            'MNAME VARCHAR(30), ' +
            'LNAME VARCHAR(30), ' +
            'ADDR1 VARCHAR(100), ' +
            'ADDR2 VARCHAR(100), ' +
            'CITY VARCHAR(50), ' +
            'STATE VARCHAR(50), ' +
            'ZIP VARCHAR(30), ' +
            'PHONEH VARCHAR(30), ' +
            'PHONEC VARCHAR(30), ' +
            'PHONEW VARCHAR(30), ' +
            'BDAY DATE, ' +
            'EMAIL VARCHAR(60), ' +
            'TAXEXID VARCHAR(40), ' + // tax exempt ID
            'TAXE BOOLEAN',
   masterData.QueryAddCalculatedField( self, 'TotO', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'TOTN', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'TotC', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'FullName', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'FullAddr', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'BOT', 1, ftInteger);
}

// Text Output
function tMasterDataCustomerList.ExportText(fName: string; quoteType : string )  : tErrorResult;
var
   exportFile : TextFile;
   outString : string;
begin
	try
   	AssignFile( exportFile, fName );
      Rewrite( exportFile );
      //
      Self.First();
      Repeat
			outString :=
         	quoteType + Self.FieldByName('FNAME').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('MNAME').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('LNAME').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('ADDR1').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('ADDR2').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('CITY').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('STATE').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('ZIP').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('PHONEH').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('PHONEC').AsString + quoteType + ',' +
				quoteType + Self.FieldByName('PHONEW').AsString + quoteType;
				//
         Writeln( exportFile, outString );
         //
      	Self.Next;
      Until Self.Eof;
      //
      CloseFile( exportFile );
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
         CloseFile( exportFile );
      end;
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.
