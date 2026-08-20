 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit MasterData_EarningListEditUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  dateutils,
  recordstructureunit,
  inifileunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_orgtoolboxunit,
  toolbox_cycletoolboxunit,
  toolbox_Earningtoolboxunit,
  masterdataunit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataEarningListEdit = class(tQuery)
   private
   	fQuery : tQuery;
      fID : string;
   	procedure HandleCalculated(DataSet: TDataSet);
      function fGetTotAmount : currency;
   public
      fMasterData : tMasterData;
      procedure Update; overload;
      procedure Update( inOrgID : string ); overload;
      property totAmount : currency read fGetTotAmount;
      constructor Create( inMasterData : tMasterData; inID : string );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataEarningListEdit.Create(inMasterData: tMasterData; inID : string);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( nil );
   //
   self.RequestLive := true;
   //
   fID := inID;
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Earning +
      ' WHERE E_ID = ' + masterData.WrapDBID( fID );
   self.SQL.Clear();
   self.SQL.Text := sql;
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'EXPTYPE', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 120, ftString);
	fQuery := masterData.GetQuery;
end;

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

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataEarningListEdit.destroy;
begin
	FreeAndNil(fQuery);
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

function tMasterDataEarningListEdit.fGetTotAmount: currency;
var
   totQuery : tQuery;
begin
   totQuery := fMasterData.GetQuery();
   totQuery.SQL.Text := 'SELECT E_ID, SUM(AMOUNT) AS TOTAMT FROM ' + fmasterdata.GetTable_Earning +
      ' WHERE E_ID = ' + masterData.WrapDBID( fID ) +
      ' GROUP BY E_ID';
   totQuery.Open();
   result := totQuery.FieldByName('TOTAMT').AsCurrency;
   totQuery.Close();
   freeandnil(TotQuery);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataEarningListEdit.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByname('ORG_ID').AsString );
   DataSet.FieldByName('EXPTYPE').Value := Earning_GetEarningTypeNameByID( self.FieldByname('ET_ID').AsString )
   //
end;

procedure tMasterDataEarningListEdit.Update(inOrgID: string);
var
   sql : string;
begin
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Earning +
      ' WHERE E_ID = ' + masterData.WrapDBID( fID ) +
      ' AND ORG_ID = ' + masterData.WrapDBID( inORGID );
   sql := sql + ' ORDER BY MOPDATE DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataEarningListEdit.Update();
var
   sql : string;
begin
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Earning +
      ' WHERE E_ID = ' + masterData.WrapDBID( fID );
   sql := sql + ' ORDER BY MOPDATE DESC';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.
