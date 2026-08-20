 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_ExpenseListUnit;

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
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_orgtoolboxunit,
  toolbox_cycletoolboxunit,
  masterdataunit,
  Order_InvoiceObjectUnit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataExpenseList = class(tQuery)
   private
   	fQuery : tQuery;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update; overload;
      procedure Update( inOrgID : string ); overload;
      constructor Create( inMasterData : tMasterData);  reintroduce; overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataExpenseList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Expense_List;
   self.SQL.Clear();
   self.SQL.Text := sql;
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'TOTITEMS', 40, ftInteger);
   masterData.QueryAddCalculatedField( self, 'TOTAMT', 40, ftCurrency);
	fQuery := masterData.GetQuery;
end;

{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'C_ID VARCHAR(40)', // cycle id
}
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataExpenseList.destroy;
begin
	FreeAndNil(fQuery);
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataExpenseList.HandleCalculated(DataSet: TDataSet);
var
   tempStr : String;
begin
   DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByname('ORG_ID').AsString );
   //
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Expense +
      ' WHERE E_ID = ' + masterData.WrapDBID( Self.FieldByName('ID').AsString );
   fQuery.Open();
   DataSet.FieldByname('TOTITEMS').AsInteger := fQuery.FieldByName('TOT').AsInteger;
   fQuery.Close();
   //
   fQuery.SQL.Text := 'SELECT SUM(AMOUNT) AS AMT FROM ' + masterData.GetTable_Expense +
      ' WHERE E_ID = ' + masterData.WrapDBID( Self.FieldByName('ID').AsString );
   fQuery.Open();
   DataSet.FieldByname('TOTAMT').AsCurrency := fQuery.FieldByName('AMT').AsCurrency;
   fQuery.Close();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataExpenseList.Update(inOrgID: string);
var
   sql : string;
begin
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Expense_List;
   sql := sql + ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID );
   sql := sql + ' ORDER BY CYCLENAME DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataExpenseList.Update();
var
   sql : string;
begin
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Expense_List;
   sql := sql + ' ORDER BY CYCLENAME DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.
