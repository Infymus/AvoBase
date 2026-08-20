 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_EmailQueueUnit;

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
   inifileunit,
   masterdataunit,
   ErrorResultUnit;

type
   tMasterDataEmailList = class(tQuery)
   private
   	fSQLString : string;
      fMasterData : tMasterData;
   public
      constructor Create( inMasterData : tMasterData);  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataEmailList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
begin
   inherited create(nil);
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   //
	fSQLString := 'SELECT * FROM ' + fMasterData.GetTable_Email +
      ' WHERE STATUS = ' + IntToStr(integer(EmailPending));
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   //
   errResult := fMasterData.QueryAddFields( self );
   //
   self.RequestLive := true;
end;

end.