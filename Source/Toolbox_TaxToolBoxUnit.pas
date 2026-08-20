 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_TaxToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  recordstructureunit,
  errorresultunit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  //
  toolbox_preferencetoolboxunit,
  db,
  dbtables,
  bde,
  sysutils,
  math,
  classes,
  forms,
  dateutils,
  inifiles,
  stdctrls;



procedure InitTaxRounding();

// rewrites

function Tax_TaxRateTotalByMasterTaxClassID( inAmount : currency; inTCID : string ) : Currency;
function Tax_TaxRateTotalCompoundTaxByMasterTaxClassID( inAmount : currency; inTCID : string ) : Currency;
procedure Tax_FillTaxSubClassesByTaxClass( VAR inCombo : TComboBox; inTCID : string );

// these are OK

function Tax_PerformTaxCalculation( inRate : Currency ) : currency;
function Tax_GetMasterTaxNameByID( inID : string ) : string;
function Tax_GetMasterTaxIDByName( inName : string ) : string;
function Tax_TaxExitsByName( inName : string ) : boolean;
function Tax_MasterTaxExitsByName( inName : string ) : boolean;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
      if (NOT masterData.TableExists(table_tax_master)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_tax_master,
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200)',

         retVal := masterData.AddTable(masterData.dbPath + table_tax,
            'ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'TTYPE INTEGER, ' + // see tTaxTypes for details
            'RATE FLOAT',


   tTaxDefaultTypes = (
      taxDefaultNone = 0,
      taxDefaultProduct = 1,
      taxDefaultFee = 2,
      taxDefaultShipping = 3
      );

         DFEETAXID := Pref_GetPrefGUID('DFEETAXID');
   DSHIPTAXID := Pref_GetPrefGUID('DSHIPTAXID');
   DPRODTAXID := Pref_GetPrefGUID('DPRODTAXID');

}


implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Tax_InitRecord : tTaxRecord2;
begin
   result.taxID := '';
   result.Name := '';
   result.Descr := '';
   result.Samt := 0.0;
   result.Eamt := 0.0;
   result.Rate := 0.0;
   result.isactive := false;
   result.ttype := 0;
end;

procedure InitTaxRounding();
var
   TaxPref : integer;
begin
	TaxPref := Pref_GetInteger(tPrefConstants.TaxRounding, 0);
   case TaxPref of
   	integer(tPrefTaxRounding.rmUp) : SetRoundMode( rmUp );
   	integer(tPrefTaxRounding.rmDown) : SetRoundMode( rmDown );
   	integer(tPrefTaxRounding.rmNearest) : SetRoundMode( rmNearest );
   	integer(tPrefTaxRounding.rmTruncate) : SetRoundMode( rmTruncate );
      else
			SetRoundMode( rmUp );
   end;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Tax_PerformTaxCalculation(inRate: Currency): Currency;
begin
	try
      result := inRate / 100;
   except
   	result := 0;
   end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Tax_GetTaxRecord( inTaxID : string ) : tTaxRecord2;
var
   fTaxQuery : tQuery;
begin
   result := Tax_InitRecord;
   fTaxQuery := masterData.GetQuery;
   try
      fTaxQuery.Close();
      fTaxQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Tax +
         ' WHERE ID = ' + masterData.WrapDBID( inTaxID );
      ftaxQuery.Open();
      if ( fTaxQuery.RecordCount <> 0 ) then
      begin
         result.ID := fTaxQuery.FieldByName('ID').AsString;
         result.taxID := fTaxQuery.FieldByName('TAXID').AsString;
         result.Name := fTaxQuery.FieldByName('NAME').AsString;
         result.Descr := fTaxQuery.FieldByName('DESCR').AsString;
         result.Samt := fTaxQuery.FieldByName('SAMT').AsCurrency;
         result.Eamt := fTaxQuery.FieldByName('EAMT').AsCurrency;
         result.Rate := fTaxQuery.FieldByName('RATE').AsFloat;
         result.tType := fTaxQuery.FieldByName('TTYPE').AsInteger;
         result.isactive := fTaxQuery.FieldByName('ISACTIVE').AsBoolean;
      end;
      //
      fTaxQuery.Close();
   finally
      FreeAndNil(fTaxQuery);
   end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Tax_TaxExitsByName( inName : string ) : boolean;
var
   fQuery : tQuery;
begin
	result := false;
   if ( inName <> '') then
   begin
   	inName := ProperCase( inName, true );
   	fQuery := masterData.GetQuery();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Tax +
      	'WHERE NAME = "' + inName + '"';
      fQuery.Open();
      if (fQuery.FieldByName('TOT').AsInteger <> 0) then
      	result := true;
      fQuery.Close();
      //
      FreeAndNil( fQuery );
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Tax_MasterTaxExitsByName( inName : string ) : boolean;
var
   fQuery : tQuery;
begin
	result := false;
   if ( inName <> '') then
   begin
   	inName := ProperCase( inName, true );
   	fQuery := masterData.GetQuery();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Tax_Master +
      	'WHERE NAME = "' + inName + '"';
      fQuery.Open();
      if (fQuery.FieldByName('TOT').AsInteger <> 0) then
      	result := true;
      fQuery.Close();
      //
      FreeAndNil( fQuery );
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Tax_GetMasterTaxNameByID( InID : string ) : string;
var
   fQuery : tQuery;
begin
	result := '';
   fQuery := masterData.GetQuery();
   fQuery.SQL.Text := 'SELECT ID, NAME FROM ' + masterData.GetTable_Tax_Master +
      	' WHERE ID = ' + masterData.WrapDBID( InID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0 ) then
      result := fQuery.FieldByName('NAME').AsString;
   fQuery.Close();
   //
   FreeAndNil( fQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Tax_GetMasterTaxIDByName( inName : string ) : string;
var
   fQuery : tQuery;
begin
	result := '';
   fQuery := masterData.GetQuery();
   fQuery.SQL.Text := 'SELECT ID, NAME FROM ' + masterData.GetTable_Tax_Master +
      	' WHERE NAME = ' + masterData.WrapDBID( inName );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0 ) then
      result := fQuery.FieldByName('ID').AsString;
   fQuery.Close();
   //
   FreeAndNil( fQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Tax_TaxRateTotalByMasterTaxClassID( inAmount : currency; inTCID : string ) : Currency;
var
   fTaxQuery : tQuery;
   sAmt : currency;
   eAmt : currency;
   Rate : double;
begin
	InitTaxRounding();
   result := 0.00;
   if ( inTCID <> '' ) then
   begin
      fTaxQuery := masterData.GetQuery;
      try
         fTaxQuery.Close();
         fTaxQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Tax +
            ' WHERE TAXID = ' + masterData.WrapDBID( inTCID );
         fTaxQuery.Open();
         while not fTaxQuery.EOF do
         begin
            if (fTaxQuery.FieldByName('ISACTIVE').AsBoolean)
               AND (fTaxQuery.FieldByName('TTYPE').AsInteger = Integer(tTaxTypes.taxTypeSimple)) then
            begin
               sAmt := fTaxQuery.FieldByName('SAMT').AsCurrency;
               eAmt := fTaxQuery.FieldByName('EAMT').AsCurrency;
               Rate := fTaxQuery.FieldByName('RATE').AsFloat;
               if ( inAmount >= sAmt) AND ( inAmount <= eAmt ) then
                  result := result + Rate;
            end;
            fTaxQuery.Next();
         end;
         //
         fTaxQuery.Close();
      finally
         FreeAndNil(fTaxQuery);
      end;
      //
//      result := RoundTo( result, -2 );
     // result := RoundCurrency( result );
result := RoundTo2dp( result );
   end;
end;

function Tax_TaxRateTotalCompoundTaxByMasterTaxClassID( inAmount : currency; inTCID : string ) : Currency;
var
   fTaxQuery : tQuery;
   sAmt : currency;
   eAmt : currency;
   Rate : double;
begin
	InitTaxRounding();
   result := 0.00;
   if ( inTCID <> '' ) then
   begin
      fTaxQuery := masterData.GetQuery;
      try
         fTaxQuery.Close();
         fTaxQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Tax +
            ' WHERE TAXID = ' + masterData.WrapDBID( inTCID );
         fTaxQuery.Open();
         while not fTaxQuery.EOF do
         begin
            if (fTaxQuery.FieldByName('ISACTIVE').AsBoolean)
               AND (fTaxQuery.FieldByName('TTYPE').AsInteger = Integer(tTaxTypes.taxTypeCompound)) then
            begin
               sAmt := fTaxQuery.FieldByName('SAMT').AsCurrency;
               eAmt := fTaxQuery.FieldByName('EAMT').AsCurrency;
               Rate := fTaxQuery.FieldByName('RATE').AsFloat;
               if ( inAmount >= sAmt) AND ( inAmount <= eAmt ) then
                  result := result + Rate;
            end;
            fTaxQuery.Next();
         end;
         //
         fTaxQuery.Close();
      finally
         FreeAndNil(fTaxQuery);
      end;
      //
      //result := RoundTo( result, -2 );
//      result := HumanRound( result );
result := RoundTo2dp( result );
//      result := RoundCurrency( result );
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// The inTCID is the one you want to set it to while filling
procedure Tax_FillTaxSubClassesByTaxClass( VAR inCombo : TComboBox; inTCID : string );
var
   fTaxQuery : tQuery;
   idx : integer;
begin
   inCombo.Clear;
   idx := -1;
   //
   try
      fTaxQuery := masterData.GetQuery;
      fTaxQuery.Close();
      fTaxQuery.SQL.Text := 'SELECT ID, ISACTIVE, NAME FROM ' + masterData.GetTable_Tax_Master;
      fTaxQuery.Open();
      while not fTaxQuery.EOF do
      begin
         if ( fTaxQuery.FieldByName('ISACTIVE').AsBoolean ) then
         begin
            inCombo.Items.Add( fTaxQuery.FieldByName('NAME').AsString );
            if ( fTaxQuery.FieldByName('ID').AsString = inTCID ) then
               idx := inCombo.Items.Count - 1;
         end;
         fTaxQuery.Next();
      end;
      //
      fTaxQuery.Close();
   finally
      FreeAndNil(fTaxQuery);
   end;
   //
   if ( idx > -1 ) then
      inCombo.ItemIndex := idx;
   //
   if ( inTCID = '' ) AND ( inCombo.Items.Count -1 <> -1 ) then
      inCombo.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.


{
      if (NOT masterData.TableExists(table_tax_master)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_tax_master,
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200)',

         retVal := masterData.AddTable(masterData.dbPath + table_tax,
            'ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'TTYPE INTEGER, ' + // see tTaxTypes for details
            'RATE FLOAT',


   tTaxDefaultTypes = (
      taxDefaultNone = 0,
      taxDefaultProduct = 1,
      taxDefaultFee = 2,
      taxDefaultShipping = 3
      );

   DFEETAXID := Pref_GetPrefGUID('DFEETAXID');
   DSHIPTAXID := Pref_GetPrefGUID('DSHIPTAXID');
   DPRODTAXID := Pref_GetPrefGUID('DPRODTAXID');
   DORDTAXID  := Pref_GetPrefGUID('DORDTAXID');

}

