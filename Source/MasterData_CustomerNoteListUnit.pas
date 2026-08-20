 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_CustomerNoteListUnit;

interface uses
  sysutils,
  classes,
  Order_InvoiceObjectUnit,
  recordstructureunit,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataCustNoteListQuery = class(tQuery)
   private
      fCustID : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update;
      procedure Load( inCustID : string );
      constructor Create(inMasterData : tMasterData; inCustID : string); virtual;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataCustNoteListQuery.Create(inMasterData : tMasterData; inCustID : string);
var
   errResult : tErrorResult;
   sql : string;
begin
   inherited create( owner );
   RequestLive := true;
   fCustID := inCustID;
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.GetTable_CustomerNotes +
      ' WHERE C_ID = ' + masterData.WrapDBID( inCustID ) +
      ' ORDER BY NDATE DESC';
   self.SQL.Clear();
   self.SQL.Text := sql;
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
   Self.Open();
end;

procedure tMasterDataCustNoteListQuery.HandleCalculated(DataSet: TDataSet);
begin
	// do nothing at this momento.
end;

procedure tMasterDataCustNoteListQuery.Load(inCustID: string);
begin
   fCustID := inCustID;
   self.Close();
   sql.text := 'SELECT * FROM ' + fMasterData.GetTable_CustomerNotes +
      ' WHERE C_ID = ' + masterData.WrapDBID( inCustID ) +
      ' ORDER BY NDATE DESC';

   self.Open();
end;

procedure tMasterDataCustNoteListQuery.Update;
begin
   self.Close();
   self.Open();
end;

end.