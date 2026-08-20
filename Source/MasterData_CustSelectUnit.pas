 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_CustSelectUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  recordstructureunit,
  db,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  avobase_percentformunit,
  masterdataunit,
  ErrorResultUnit;

// This is the main Customer List. It is only used for displaying the customer list in different fashions.
type
   tMasterDataCustomerSelectList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      constructor Create( inMasterData : tMasterData);  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{ tMasterDataCustomerList }

// CUSTOMER LIST ################################################# //

constructor tMasterDataCustomerSelectList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( nil );
   PercentForm_Create('Generating Customer List', 0, 0);
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Customer;
   sql := sql + ' WHERE ISACTIVE = TRUE';
   sql := sql + ' ORDER BY FNAME';
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
   masterData.QueryAddCalculatedField( self, 'TotOrd', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'FullName', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'FullAddr', 120, ftString);
   // even if we add active := true here, it won't activate within the create methodology.
   PercentForm_Free();
   Self.Open;
end;

procedure tMasterDataCustomerSelectList.HandleCalculated(DataSet: TDataSet);
var
	fQuery : tQuery;
   tempStr : String;
begin
	// Field: TotOrd
	fQuery := masterData.GetQuery;
   try
      //
      // Total Orders
      fQuery.Close();
      fQuery.SQL.Text := 'SELECT COUNT(*) FROM ' + fMasterData.GetTable_Order +
      	' WHERE C_ID = "' + DataSet.FieldByName('ID').AsString + '"';
      fQuery.Open();
      DataSet.FieldByName('TotOrd').Value := fQuery.FieldByName('COUNT(*)').AsInteger;
      fQuery.Close();
      //
      // finish
   finally
   	FreeAndNil(fQuery);
   end;

   // Field: FullName
   DataSet.FieldByName('FullName').Value := Self.FieldByName('FNAME').AsString + #32 +
		Self.FieldByName('LNAME').AsString;
   if (NOT DataSet.FieldByName('ISACTIVE').AsBoolean) then
   	Dataset.FieldByName('FullName').Value := '* ' + Dataset.FieldByName('FullName').Value;

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
end;


end.