 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit  ErrorResultUnit;

interface uses
   constantsunit,
   toolboxunit,
   avobase_dialogformunit,
   sysutils,
   avobase_percentformunit,
   RecordStructureUnit,
   dialogs;

const
   AVO_ERROR_LOG = 'avobase_error.log';

function Error_Init : tErrorResult;
procedure Error_Log( inError : tErrorResult; dispError : boolean );

implementation

function Error_Init : tErrorResult;
begin
   result.errorResult := false;
   result.errorMessage := '';
end;

procedure Error_Log( inError : tErrorResult; dispError : boolean );
var
   errorFile : TextFile;
   logFile : string;
begin
   PercentForm_Free();
   logFile := ExtractFilePath(ParamStr(0)) + AVO_ERROR_LOG;
   System.AssignFile( errorFile, logFile);
   if (FileExists( logFile )) then
      System.Append(errorFile)
   else
      begin
         System.Rewrite(errorFile);
         System.Writeln( errorFile, AVOBASE_NAME + ' ' + VER_NUM + ' Log File Created.');
         System.Writeln( errorFile, '=============================================================');
      end;
   System.Writeln( errorFile, DateToStr( Date ) + ' : (' + AVOBASE_NAME + ' ' + VER_NUM + ') ' + inError.ErrorMessage);
   System.Writeln( errorFile, ''); // give it a space
   System.CloseFile( errorFile );
   if ( dispError ) then
      AvoBaseDialog('AvoBase Internal Error', 'AvoBase has encountered an internal error and may not ' +
         'be able to recover.' + #13 + #13 + 'The Error is as follows: ' + #13 + #13 +
         inError.errorMessage + #13 + #13 +
         'This error has been stored in the "' + AVO_ERROR_LOG + '" ' +
         'file found in the AvoBase directory.', mtError, [mbOk], 0);
end;

end.
