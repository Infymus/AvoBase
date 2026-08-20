 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_TaxMasterListUnit;

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
  Toolbox_PreferenceToolBoxUnit,
  inifileunit,
  masterdataunit,
  ErrorResultUnit;

type
   tMasterDataMasterTaxList = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update;
      constructor Create(inMasterData : tMasterData); virtual;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataMasterTaxList.Create(inMasterData : tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
   inherited create( owner );
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Tax_Master + ' ORDER BY ISACTIVE, NAME';
   self.SQL.Clear();
   self.SQL.Text := sql;
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'DEF', 120, ftString);
   self.Open();
end;

procedure tMasterDataMasterTaxList.HandleCalculated(DataSet: TDataSet);
var
   DFEETAXID : string;
   DSHIPTAXID : string;
   DPRODTAXID : string;
   DORDTAXID : string;
   subStr : string;
begin
   DFEETAXID := Pref_GetPrefGUID(tPrefConstants.DFEETAXID);
   DSHIPTAXID := Pref_GetPrefGUID(tPrefConstants.DSHIPTAXID);
   DPRODTAXID := Pref_GetPrefGUID(tPrefConstants.DPRODTAXID);
   DORDTAXID := Pref_GetPrefGUID(tPrefConstants.DORDTAXID);
   //
   subStr := '';
   //
   if ( self.FieldByName('ID').AsString = DFEETAXID ) then
      subStr := 'Fee';
   //
   if ( self.FieldByName('ID').AsString = DSHIPTAXID ) then
      if ( subStr = '' ) then
         subStr := 'Shipping'
      else
         subStr := subStr + ', Shipping';
   //
   if ( self.FieldByName('ID').AsString = DPRODTAXID ) then
      if ( subStr = '' ) then
         subStr := 'Product'
      else
         subStr := subStr + ', Product';
   //
   if ( self.FieldByName('ID').AsString = DORDTAXID ) then
      if ( subStr = '' ) then
         subStr := 'Order'
      else
         subStr := subStr + ', Order';
   //
   DataSet.FieldByName('DEF').AsString := SubStr;
end;

procedure tMasterDataMasterTaxList.Update;
begin
   self.Close();
   self.Open();
end;

end.
