 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_UpdateFormUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  avobase_percentformunit,
  avobase_dialogformunit,
  //
  sysutils,
  classes,
  dialogs,
  forms,
  dateutils,
  urlmon,
  stdctrls;

  // http://blog.marcocantu.com/blog/auto_updating_programs.html

type
  tUpdateAvoBase = class( tObject )
  public
    function CheckUpdates( runType : tCheckUpdateTypes ) : tCheckUpdateTypes;
    // may wish to add something here that automatically downloads that version and upgrades it.
    // but for now, this will suffice.
  end;

implementation

function tUpdateAvoBase.CheckUpdates(  runType : tCheckUpdateTypes ) : tCheckUpdateTypes;
var
  DLOK : Boolean;
  saveFile : String;
  VerData : String;
  verDataNum : Integer;
  VerFile : textFile;
  checkDays : Integer;
begin
   result := checkUpdateNone;

   // We check every UPDATE_RUNTIMES days ( see constants )
   checkDays := AvoINIReadInteger(AVOBASE_NAME, 'CheckUpdate', 100);
   Inc(checkDays);
   if ( runType = checkUpdateNormal ) then
      checkDays := UPDATE_RUNTIMES + 100;
   //
   if ( checkDays >= UPDATE_RUNTIMES ) then
   begin
      checkDays := 0;
      //
      saveFile := ExtractFileDir(ParamStr(0))+'\dl_ver2.uri';
      if FileExists(saveFile) then
         DeleteFile( saveFile );
      //
      if ( runType = checkUpdateNormal ) then
         PercentForm_Create('Checking Version - One Moment Please', 0, 0);

      //
      try

         DLOK := URLDownloadToFile(NIL, PChar(AVO_VER_URI), PChar(SaveFile), 0, NIL) = 0;
      except
         PercentForm_Free;
         result := checkUpdateError;
         AvoBaseDialog('Error Checking For AvoBase Upgrade!',
            'Unable to connect to AVOBASE.COM. Check Firewall? Check Internet Connectivity?\n\n' +
            'Updates can be turned off in Preferences ~ General Preferences.', mtError, [mbOk], 0);
         exit;
      end;

      if ( runType = checkUpdateNormal ) then
         PercentForm_Free();

      if ( FileExists(SaveFile) ) then
      begin
         try
            System.AssignFile(VerFile, SaveFile);
            System.Reset(VerFile);
            System.Readln(VerFile,VerData);
            System.CloseFile(VerFile);
         except
            PercentForm_Free();
            result := checkUpdateError;
            AvoBaseDialog('Error Checking For AvoBase Upgrade!',
               'Unable to access or read the upgrade information file locally.\n\n' +
               'Updates can be turned off in Preferences ~ General Preferences.', mtError, [mbOk], 0);
            exit;
         end;
         verDataNum := StrToInt( VerData );
         if ( verDataNum > VER_NUM_INTERNAL ) then
            Result := checkUpdateFound
         else
            result := checkUpdateNone;
      end else
         begin
            PercentForm_Free();
            result := checkUpdateError;
            AvoBaseDialog('Error Checking For AvoBase Upgrade!',
               'Upgrade information file was not retrievable.\n\n' +
               'Updates can be turned off in Preferences ~ General Preferences.', mtError, [mbOk], 0);
            exit;
         end;

   end;

      if ( runType = checkUpdateNormal ) then
         if ( result = checkUpdateNone ) then
            AvoBaseDialog('AvoBase is up to Date!',
               'AvoBase is up to date, there is no need to upgrade.', mtInformation, [mbOk], 0);

   //
   AvoINIWriteInteger('AvoBase','CheckUpdate', CheckDays);
end;
  
end.
