 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_AccountingEscrowListUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
   recordstructureunit,
  dateutils,
  inifileunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_ProductToolBoxUnit,
  ToolBox_EscrowToolBoxUnit,
  masterdataunit,
  Order_InvoiceObjectUnit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataAccountingEscrowList = class(tQuery)
   private
   	fQuery : tQuery;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
      constructor Create( inMasterData : tMasterData);  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataAccountingEscrowList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Customer;
   self.SQL.Clear();
   self.SQL.Text := sql;
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'TotO', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'TotC', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'FullName', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'FullAddr', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'ESCROW', 1, ftCurrency);
   //
	fQuery := masterData.GetQuery;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataAccountingEscrowList.destroy;
begin
	FreeAndNil(fQuery);
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataAccountingEscrowList.HandleCalculated(DataSet: TDataSet);
var
   tempStr : String;
begin
   DataSet.FieldByName('TOTO').Value := Order_GetTotalOpenOrdersByCustID( DataSet.FieldByName('ID').AsString );
   DataSet.FieldByName('TOTC').Value := Order_GetTotalClosedOrdersByCustID( DataSet.FieldByName('ID').AsString );
   DataSet.FieldByName('ESCROW').Value := Escrow_GetCustomerEscrowByCustomerID( DataSet.FieldByName('ID').AsString );
   // Field: FullName
   DataSet.FieldByName('FullName').Value := Self.FieldByName('FNAME').AsString + #32 +
		Self.FieldByName('LNAME').AsString;
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
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataAccountingEscrowList.Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
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

end.
