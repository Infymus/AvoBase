 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit	MasterData_PreferenceUnit;

interface uses
	// our units
  constantsunit,
  toolboxunit,
  inifileunit,
  ErrorResultUnit,
  masterdataunit,
  verificationunit,
  //
  sysutils,
  classes,
  db,
  forms,
  dbtables,
  bde,
  dateutils;

{ This object is more complex in that it allows full control over the preference table by way of properties. }

type
	tMasterDataPreference = class(tObject)
   private
   	fPrefQuery : tQuery;
      //
      function fGetUserName : string;
      function fGetPassword : string;
      function fGetRepPhone : string;
      function fGetRepFax : string;
      function fGetRepCell : string;
      function fGetSmtpServer : string;
      function fGetSmtpUserName : string;
      function fGetSmtpPassword : string;
      function fGetSmtpPort : integer;
      function fGetSmtpFrom : string;
      function fGetRegion : integer;
      //
      procedure fSetUserName( inStr : string );
      procedure fSetPassword( inStr : string );
      procedure fSetRepPhone( inStr : string );
      procedure fSetRepFax( inStr : string );
      procedure fSetRepCell( inStr : string );
      procedure fSetSmtpServer( inStr : string );
      procedure fSetSmtpUserName( inStr : string );
      procedure fSetSmtpPassword( inStr : string );
      procedure fSetSmtpPort( inInt : integer );
      procedure fSetSmtpFrom( inStr : string );
      procedure fSetRegion( inInt : integer );
   public
   	DataSource : tDataSource;
      //
      function Save() : tErrorResult;
      function Load() : tErrorResult;
      function Cancel() : tErrorResult;
      //
      property userName : string read fGetUserName write fSetUserName;
      property password : string read fGetPassword write fSetPassword;
      property repPhone : string read fGetRepPhone write fSetRepPhone;
      property repFax : string read fGetRepFax write fSetRepFax;
      property repCell : string read fGetRepCell write fSetRepCell;
      property smtpServer : string read fGetSmtpServer write fSetSmtpServer;
      property smtpUserName : string read fGetSmtpUserName write fSetSmtpUserName;
      property smtpPassword : string read fGetSmtpPassword write fSetSmtpPassword;
      property smtpPort : integer read fGetSmtpPort write fSetSmtpPort;
      property smtpFrom : string read fGetSmtpFrom write fSetSmtpFrom;
      property region : integer read fGetRegion write fSetRegion;
      //
      Constructor Create; virtual;
      Destructor Destroy; override;
   end;

type
	tPrefTypes = (	userName,
   					password,
                  repphone,
                  repFax,
                  repCell,
                  smtpServer,
                  smtpPort,
                  smtpFrom,
                  region,
                  smptUserName,
                  smtpPassword );

	function Pref_GetPref( inPref : tPrefTypes ) : tField;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ the following is used outside the scope of this object, to grab a preference at any given time. }

	function Pref_GetPref( inPref : tPrefTypes ) : tField;
   var
   	fPrefQuery : tQuery;
	begin
   	result := tField.Create(nil);
   	fPrefQuery := MasterData.GetQuery;
      try
      	fPrefQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Preference;
         fPrefQuery.Active := true;
         fPrefQuery.First();
			case inPref of
         	userName : result := fPrefQuery.FieldByName('UN');
         	password : result := fPrefQuery.FieldByName('PW');
            repphone : result := fPrefQuery.FieldByName('RPHONE');
            repFax : result := fPrefQuery.FieldByName('RFAX');
            repCell : result := fPrefQuery.FieldByName('RCELL');
            smtpServer : result := fPrefQuery.FieldByName('SMTPS');
            smtpPort : result := fPrefQuery.FieldByName('SMTPORT');
            smtpFrom : result := fPrefQuery.FieldByName('SMTPF');
            region : result := fPrefQuery.FieldByName('REGION');
            smptUserName : result := fPrefQuery.FieldByName('SMTPUSER');
            smtpPassword : result := fPrefQuery.FieldByName('SMTPPW');
         end;
      finally
         fPrefQuery.Close();
      	FreeAndNil(fPrefQuery);
      end;
   end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tMasterDataPreference.Create;
begin
   inherited create();
   //
   fPrefQuery := MasterData.GetQuery;
   DataSource := tDataSource.Create( nil );
   //
   DataSource.DataSet := fPrefQuery;
end;

destructor tMasterDataPreference.Destroy;
begin
   if (fPrefQuery.State in [dsEdit, dsInsert]) then
      fPrefQuery.Cancel();
   fPrefQuery.Close();
   FreeAndNil(DataSource);
   FreeAndNil(fPrefQuery);
   //
   Inherited Destroy;
end;

function tMasterDataPreference.Load: tErrorResult;
begin
   result := InitError();
   if (fPrefQuery.State in [dsEdit, dsInsert]) then
      fPrefQuery.Cancel();
   fPrefQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Preference;
   fPrefQuery.Active := true;
   fPrefQuery.First();
end;

function tMasterDataPreference.Cancel: tErrorResult;
begin
   result := InitError();
   if (fPrefQuery.State in [dsEdit, dsInsert]) then
      fPrefQuery.Cancel();
end;

function tMasterDataPreference.Save: tErrorResult;
begin
   result := InitError();
   if (fPrefQuery.State in [dsEdit, dsInsert]) then
      fPrefQuery.Post();
end;

// ******************************** GET ************************************
// ******************************** GET ************************************
// ******************************** GET ************************************

function tMasterDataPreference.fGetPassword: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('PW').AsString);
end;

function tMasterDataPreference.fGetUserName: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('UN').AsString);
end;

function tMasterDataPreference.fGetRegion: integer;
begin
   result := fPrefQuery.FieldByName('REGION').AsInteger;
end;

function tMasterDataPreference.fGetRepCell: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('RCELL').AsString);
end;

function tMasterDataPreference.fGetRepFax: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('RFAX').AsString);
end;

function tMasterDataPreference.fGetRepPhone: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('RPHONE').AsString);
end;

function tMasterDataPreference.fGetSmtpFrom: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('SMTPF').AsString);
end;

function tMasterDataPreference.fGetSmtpPassword: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('SMTPPW').AsString);
end;

function tMasterDataPreference.fGetSmtpPort: integer;
begin
   result := fPrefQuery.FieldByName('SMTPORT').AsInteger;
end;

function tMasterDataPreference.fGetSmtpServer: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('SMTPS').AsString);
end;

function tMasterDataPreference.fGetSmtpUserName: string;
begin
   result := UnEncryptData(fPrefQuery.FieldByName('SMTPUSER').AsString);
end;

// ******************************** SET ************************************
// ******************************** SET ************************************
// ******************************** SET ************************************

procedure tMasterDataPreference.fSetPassword(inStr: string);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('PW').AsString := EncryptData( inStr );
end;

procedure tMasterDataPreference.fSetUserName(inStr: string);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('UN').AsString := EncryptData( inStr );
end;

procedure tMasterDataPreference.fSetRegion(inInt: integer);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('REGION').AsInteger;
end;

procedure tMasterDataPreference.fSetRepCell(inStr: string);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('RCELL').AsString := EncryptData( inStr );
end;

procedure tMasterDataPreference.fSetRepFax(inStr: string);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('RFAX').AsString := EncryptData( inStr );
end;

procedure tMasterDataPreference.fSetRepPhone(inStr: string);
begin
   fPrefQuery.FieldByName('RPHONE').AsString := EncryptData( inStr );
end;

procedure tMasterDataPreference.fSetSmtpFrom(inStr: string);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('SMTPF').AsString := EncryptData( inStr );
end;

procedure tMasterDataPreference.fSetSmtpPassword(inStr: string);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('SMTPPW').AsString := EncryptData( inStr );
end;

procedure tMasterDataPreference.fSetSmtpPort(inInt: integer);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('SMTPORT').AsInteger := inInt;
end;

procedure tMasterDataPreference.fSetSmtpServer(inStr: string);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('SMTPS').AsString  := EncryptData( inStr );
end;

procedure tMasterDataPreference.fSetSmtpUserName(inStr: string);
begin
   if (fPrefQuery.State in [dsBrowse]) then
      fPrefQuery.Edit();
   fPrefQuery.FieldByName('SMTPUSER').AsString := EncryptData( inStr );
end;

end.


