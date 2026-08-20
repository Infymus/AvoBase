 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_OrgListUnit;

interface uses
  sysutils,
  classes,
  Order_InvoiceObjectUnit,
  constantsunit,
  toolboxunit,
  db,
  recordstructureunit,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataOrgList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update;
      constructor Create(inMasterData : tMasterData); virtual;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{
          'ID VARCHAR(40), ' +
          'ISACTIVE BOOLEAN, ' +
          'NAME VARCHAR(50), ' +
          'INAME VARCHAR(50), ' +
          'DESCR VARCHAR(200), ' +
          'ACC VARCHAR(50), ' +
          'IHEADD VARCHAR(50), ' + // invoice header display
          'CYCLES INTEGER, ' + // # of cycles per year
          'IMSG VARCHAR(200), ' + // specific invoice message
          'ICNCLMSG BLOB(240,1)', // cancellation message
}

constructor tMasterDataOrgList.Create(inMasterData : tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( owner );
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Org +
      ' ORDER BY ISACTIVE, NAME';
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
{
   masterData.QueryAddCalculatedField( self, 'ORDTYPE', 20, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 10, ftString );
   masterData.QueryAddCalculatedField( self, 'ORDITEMS', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'TOTALINVAMOUNT', 10, ftCurrency );
   masterData.QueryAddCalculatedField( self, 'TOTPAID', 10, ftCurrency );
   masterData.QueryAddCalculatedField( self, 'ORDSTATUS', 10, ftString );
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 40, ftString );
   }
   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
end;

procedure tMasterDataOrgList.HandleCalculated(DataSet: TDataSet);
begin
	// do nothing at this momento.
end;

procedure tMasterDataOrgList.Update;
begin
   self.Close();
   self.Open();
end;

end.
