 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


unit Toolbox_PreferenceToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  //
  db,
  dbtables,
  bde,
  sysutils,
  classes,
  forms,
  TypInfo,
  dateutils,
  inifiles,
  stdctrls;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

TYPE
   tPrefConstants = (
      CProdType,
      CheckForUpdates,
      dbGridColorGridLines,
      DFEETAXID,
      DORDTAXID,
      DPRODTAXID,
      DSHIPTAXID,
      EDITSL,
      INV1,
      INV2,
      INV3,
      INV4,
      INV5,
      INV6,
      INVCPH,
      INVLIST1,
      INVLIST2,
      INVLIST3,
      INVLIST4,
      INVLIST5,
      InvoiceShowDiscount,
      InvHead,
      NEWORDCURCYCLE,
      ORGONINVLAB,
      Password,
      RComp,
      RegionCode,
      RepAddress1,
      RepAddress2,
      RepName,
      RepCell,
      RepCity,
      RepEmail,
      RepFax,
      RepPhone,
      RepState,
      RepZip,
      SMTPAUTHTYPE,
      SMTPF,
      SMTPORDMSG,
      SMTPORT,
      SMTPPW,
      SMTPRETMSG,
      SMTPS,
      SMTPUSER,
      SPI,
      Sonum,
      TaxRounding,
      UserName,
      InvoiceLineItemStyle
      );

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// Internal Preference Functions
function PrefInternal_PrefName( inPrefName : tPrefConstants ) : string;
function PrefInternal_PrefExists( inPrefName : tPrefConstants ) : boolean;

// Preference Getters for Boolean, String, Guid, Integer and Memo
function Pref_GetBoolean( inSetting : tPrefConstants; defValue : boolean ) : boolean;
function Pref_GetString( inSetting : tPrefConstants; defValue : string ) : string;
function Pref_GetPrefGUID( inSetting : tPrefConstants ) : string;
function Pref_GetInteger( inSetting : tPrefConstants; defValue : integer ) : integer;
function Pref_GetMemo( inSetting : tPrefConstants; defValue : string ) : string;

// Preference Setters for Boolean, String, Guid, Integer and Memo
procedure Pref_SetGuid( inSetting : tPrefConstants; inValue : string );
procedure Pref_Set( inSetting : tPrefConstants; inValue : string ); overload;
procedure Pref_Set( inSetting : tPrefConstants; inValue : integer ); overload;
procedure Pref_Set( inSetting : tPrefConstants; inValue : boolean ); overload;
procedure Pref_SetMemo( inSetting : tPrefConstants; inValue : String);

// other Preferences that do not include database

function Pref_GetZipRegionName : string;
function Pref_GetDateRegionMask : string;
function Pref_GetCashSymbol : string;
function Pref_CheckEmailSettings : string;
function Pref_GetEmailDir : string;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function PrefInternal_PrefName( inPrefName : tPrefConstants ) : string;
begin
   result := GetEnumName( TypeInfo( tPrefConstants ), integer( inPrefName ));
end;

function PrefInternal_PrefExists( inPrefName : tPrefConstants ) : boolean;
var
	fQuery : tQuery;
begin
	fQuery := masterData.GetQuery;
   try
   	fQuery.Close();
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Preference +
         ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inPrefName) );
      fQuery.Open();
      result := ( fQuery.RecordCount <> 0 );
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Pref_GetBoolean(inSetting: tPrefConstants; defValue : boolean ): boolean;
var
	fQuery : tQuery;
   defaultValue : boolean;
begin
   defaultValue := defValue;
	fQuery := masterData.GetQuery;
   try
   	fQuery.Close();
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT ASBOOL FROM ' + masterData.GetTable_Preference +
         ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName( 'ASBOOL' ).AsBoolean
      else
         result := defaultValue;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Pref_GetInteger(inSetting: tPrefConstants; defValue : integer): integer;
var
	fQuery : tQuery;
   defaultValue : integer;
begin
   defaultValue := defValue;
	fQuery := masterData.GetQuery;
   try
   	fQuery.Close();
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT ASINT FROM ' + masterData.GetTable_Preference +
         ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName( 'ASINT' ).AsInteger
      else
         result := defaultValue;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Pref_GetMemo(inSetting: tPrefConstants; defValue : string): string;
var
	fQuery : tQuery;
   defaultValue : string;
begin
   defaultValue := defValue;
	fQuery := masterData.GetQuery;
   try
   	fQuery.Close();
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT ASMEMO FROM ' + masterData.GetTable_Preference +
         ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName( 'ASMEMO' ).AsString
      else
         result := defaultValue;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Pref_GetPrefGUID( inSetting : tPrefConstants ) : string;
var
	fQuery : tQuery;
   defaultValue : string;
begin
   defaultValue := '';
	fQuery := masterData.GetQuery;
   try
   	fQuery.Close();
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT ASGUID FROM ' + masterData.GetTable_Preference +
         ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName( 'ASGUID' ).AsString
      else
         result := defaultValue;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Pref_GetString(inSetting: tPrefConstants; defValue : string): string;
var
	fQuery : tQuery;
   defaultValue : string;
begin
   defaultValue := defValue;
	fQuery := masterData.GetQuery;
   try
   	fQuery.Close();
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT ASSTR FROM ' + masterData.GetTable_Preference +
         ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) );
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName( 'ASSTR' ).AsString
      else
         result := defaultValue;
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Pref_SetGuid( inSetting : tPrefConstants; inValue : string );
var
	fQuery : tQuery;
begin
	fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Clear;
      if ( PrefInternal_PrefExists( inSetting ) ) then
         fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Preference +
            ' SET ASGUID = ' + masterData.WrapDBID( inValue ) +
            ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) )
         //
         ELSE
         //
         fQuery.SQL.Text := 'INSERT INTO ' + masterData.GetTable_Preference +
            ' (ID, PNAME, ASSTR, ASBOOL, ASGUID, ASMEMO, ASINT, ASCURR) ' +
            ' VALUES ( ' +
            masterData.WrapDBID(masterData.NewDBGuid) + ', ' + // ID
            masterData.WrapDBID(PrefInternal_PrefName(inSetting)) + ', ' + // PNAME
            masterData.WrapDBID('') + ', ' + // ASSTR
            'False' + ', ' + // ASBOOL
            masterData.WrapDBID( inValue ) + ', ' + // ASGUID
            masterData.WrapDBID('') + ', ' + // ASMEMO
            '0' + ', ' + // ASINT
            '0' + // AS CURRENCY
            ')';
      // execute
      fQuery.ExecSQL();
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Pref_Set( inSetting : tPrefConstants; inValue : string );
var
	fQuery : tQuery;
begin
	fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Clear;
      if ( PrefInternal_PrefExists( inSetting ) ) then
         fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Preference +
            ' SET ASSTR = ' + masterData.WrapDBID( inValue ) +
            ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) )
         //
         ELSE
         //
         fQuery.SQL.Text := 'INSERT INTO ' + masterData.GetTable_Preference +
            ' (ID, PNAME, ASSTR, ASBOOL, ASGUID, ASMEMO, ASINT, ASCURR) ' +
            ' VALUES ( ' +
            masterData.WrapDBID(masterData.NewDBGuid) + ', ' + // ID
            masterData.WrapDBID(PrefInternal_PrefName(inSetting)) + ', ' + // PNAME
            masterData.WrapDBID( inValue ) + ', ' + // ASSTR
            'False' + ', ' + // ASBOOL
            masterData.WrapDBID( '' ) + ', ' + // ASGUID
            masterData.WrapDBID( '' ) + ', ' + // ASMEMO
            '0' + ', ' + // ASINT
            '0' + // AS CURRENCY
            ')';
      // execute
      fQuery.ExecSQL();
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Pref_SetMemo( inSetting : tPrefConstants; inValue : String );
var
	fQuery : tQuery;
begin
	fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Clear;
      if ( PrefInternal_PrefExists( inSetting ) ) then
         fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Preference +
            ' SET ASMEMO = ' + masterData.WrapDBID( inValue ) +
            ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) )
         //
         ELSE
         //
         fQuery.SQL.Text := 'INSERT INTO ' + masterData.GetTable_Preference +
            ' (ID, PNAME, ASSTR, ASBOOL, ASGUID, ASMEMO, ASINT, ASCURR) ' +
            ' VALUES ( ' +
            masterData.WrapDBID(masterData.NewDBGuid) + ', ' + // ID
            masterData.WrapDBID(PrefInternal_PrefName(inSetting)) + ', ' + // PNAME
            masterData.WrapDBID( '' ) + ', ' + // ASSTR
            'False' + ', ' + // ASBOOL
            masterData.WrapDBID( '' ) + ', ' + // ASGUID
            masterData.WrapDBID( inValue ) + ', ' + // ASMEMO
            '0' + ', ' + // ASINT
            '0' + // AS CURRENCY
            ')';
      // execute
      fQuery.ExecSQL();
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Pref_Set( inSetting : tPrefConstants; inValue : integer);
var
	fQuery : tQuery;
begin
	fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Clear;
      if ( PrefInternal_PrefExists( inSetting ) ) then
         fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Preference +
            ' SET ASINT = ' + masterData.WrapDBID( IntToStr(inValue) ) +
            ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) )
         //
         ELSE
         //
         fQuery.SQL.Text := 'INSERT INTO ' + masterData.GetTable_Preference +
            ' (ID, PNAME, ASSTR, ASBOOL, ASGUID, ASMEMO, ASINT, ASCURR) ' +
            ' VALUES ( ' +
            masterData.WrapDBID(masterData.NewDBGuid) + ', ' + // ID
            masterData.WrapDBID(PrefInternal_PrefName(inSetting)) + ', ' + // PNAME
            masterData.WrapDBID( '' ) + ', ' + // ASSTR
            'False' + ', ' + // ASBOOL
            masterData.WrapDBID( '' ) + ', ' + // ASGUID
            masterData.WrapDBID( '' ) + ', ' + // ASMEMO
            IntToStr( inValue ) + ', ' + // ASINT
            '0' + // AS CURRENCY
            ')';
      // execute
      fQuery.ExecSQL();
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Pref_Set( inSetting : tPrefConstants; inValue : Boolean );
var
	fQuery : tQuery;
   bolValue : string;
begin
   if ( inValue ) then
      bolValue := 'True'
   else
      bolValue := 'False';
	fQuery := masterData.GetQuery;
   try
      fQuery.Close();
      fQuery.SQL.Clear;
      if ( PrefInternal_PrefExists( inSetting ) ) then
         fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Preference +
            ' SET ASBOOL = ' + bolValue +
            ' WHERE PNAME = ' + masterData.WrapDBID( PrefInternal_PrefName(inSetting) )
         //
         ELSE
         //
         fQuery.SQL.Text := 'INSERT INTO ' + masterData.GetTable_Preference +
            ' (ID, PNAME, ASSTR, ASBOOL, ASGUID, ASMEMO, ASINT, ASCURR) ' +
            ' VALUES ( ' +
            masterData.WrapDBID(masterData.NewDBGuid) + ', ' + // ID
            masterData.WrapDBID(PrefInternal_PrefName(inSetting)) + ', ' + // PNAME
            masterData.WrapDBID( '' ) + ', ' + // ASSTR
            bolValue + ', ' + // ASBOOL
            masterData.WrapDBID( '' ) + ', ' + // ASGUID
            masterData.WrapDBID( '' ) + ', ' + // ASMEMO
            '0' + ', ' + // ASINT
            '0' + // AS CURRENCY
            ')';
      // execute
      fQuery.ExecSQL();
      fQuery.Close();
   finally
   	FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// other settings

function Pref_GetDateRegionMask : string;
begin
   case Pref_GetInteger(tPrefConstants.RegionCode, integer(tRegions.RegionUS)) of
   	integer(tRegions.RegionUS) : result := '!99/99/0000;1;_';
   	integer(tRegions.RegionUK) : result := '!90/90/0000;1;_';
   	integer(tRegions.RegionCAN) : result := '!90/90/0000;1;_';
   end;
end;

function Pref_GetZipRegionName : string;
begin
   case Pref_GetInteger(tPrefConstants.RegionCode, integer(tRegions.RegionUS)) of
   	integer(tRegions.RegionUS) : result := 'Zip Code';
   	integer(tRegions.RegionUK) : result := 'Postcode';
   	integer(tRegions.RegionCAN) : result := 'Postal Code';
   end;
end;

function Pref_GetCashSymbol : string;
begin
   case Pref_GetInteger(tPrefConstants.RegionCode, integer(tRegions.RegionUS)) of
   	integer(tRegions.RegionUS) : result := '$';
   	integer(tRegions.RegionUK) : result := '£';
   	integer(tRegions.RegionCAN) : result := '$';
   end;
end;

function Pref_CheckEmailSettings : string;
begin
   result := '';
   if ( Pref_GetString(tPrefConstants.SMTPS, '') = '' ) then
      result := 'SMTP Server not set.';

   if ( Pref_GetString(tPrefConstants.SMTPUSER, '') = '' ) then
      result := 'SMTP UserName not set.';

   if ( Pref_GetString(tPrefConstants.SMTPPW, '') = '' ) then
      result := 'SMTP Password not set.';

   if ( Pref_GetString(tPrefConstants.SMTPF, '') = '' ) then
      result := 'SMTP From-Email Address not set (Should be yourname@youremail.com).';

   if ( Pref_GetString(tPrefConstants.SMTPS, '') = '' ) then
      result := 'SMTP Server not set.';

   if ( Pref_GetInteger(tPrefConstants.SMTPORT, 0) = 0 ) then
      result := 'SMTP Port not set correctly';
end;

function Pref_GetEmailDir : string;
begin
   result := ExtractFilePath(ParamStr(0)) + 'email\';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
