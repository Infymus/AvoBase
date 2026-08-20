 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_TaxListUnit;

interface uses
  sysutils,
  classes,
  Order_InvoiceObjectUnit,
  constantsunit,
  toolboxunit,
  recordstructureunit,
  db,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataTaxList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update();
      constructor Create(inMasterData : tMasterData; inMasterTaxID : string ); virtual;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataTaxList.Create(inMasterData : tMasterData; inMasterTaxID : string);
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
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Tax +
   	' WHERE TAXID = ' + fMasterData.WrapDBID( inMasterTaxID ) +
      ' ORDER BY ISACTIVE, NAME';
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'TAXTYPE', 8, ftString);
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
   Self.Open();
end;

procedure tMasterDataTaxList.HandleCalculated(DataSet: TDataSet);
begin
   case self.FieldByName('TTYPE').AsInteger of
      integer(tTaxTypes.taxTypeSimple) : DataSet.FieldByName('TAXTYPE').Value := 'Simple';
      integer(tTaxTypes.taxTypeCompound) : DataSet.FieldByName('TAXTYPE').Value := 'Compound';
   end;
end;

procedure tMasterDataTaxList.Update;
begin
   self.Close();
   self.Open();
end;

end.