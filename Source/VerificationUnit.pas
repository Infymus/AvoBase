 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

{

## THIS UNIT CANNOT BE USED UNTIL THE NEW LBCIPHER IS PUT INTO PLACE.
## AND EVEN THEN IT DOES NOT GUARANTEE THAT THE OLD KEY WILL WORK
## WITH THE NEW KEY.

The way the old system worked is that the pieces of the key are strewn throughout 16 sections of source code. Those sections
are only objects that have an imbedded ORDINAL message portion of the key. so each area had to create all of those sections
of the key, combine them together into one, and then call this object "tKeyVerf.Tk4726TuI" to see if the key was valid or not.
the drawback to this is that Tk4726TuI returns a boolean, which broken down through dissassembly is TRUE/FALSE situation and all
someone has to do to break it is change that return value of Tk4726TuI or Tk4726Tu1 set to always true - and the program is pertually
unlocked. however, this doesn't get past the fact that their key is still encrypted and they don't have the key to do so. it still requires
that a key is present and it WILL read the information out of that key.

1. so for future, just wrap the key into several objects, which can all be stored in te KeysUnit file..
2. change the response to constant stored in constants, and not a boolean validation
3. no more requirement for each area to create their own area of huge purportions to create the key.

}

unit  VerificationUnit;

interface uses
  constantsunit,
  toolboxunit,
  inifileunit,
  //
  messages,
  sysutils,
  classes,
  EncryptUnit;


type
   tKeyVerif_Disabled = class( tObject )
   protected
      fLAST_NAME : String;        {  0 }
      fFIRST_NAME : String;       {  1 }
      fMIDDLE_INITIAL : String;   {  2 }
      fADDRESS1 : String;         {  3 }
      fADDRESS2 : String;         {  4 }
      fCITY : String;             {  5 }
      fSTATE : String;            {  6 }
      fZIP : String;              {  7 }
      fCODE_WORD : String;        {  8 }
      fSTART_M : String;  			 {  9 }
      fSTART_D : String;			 { 10 }
      fSTART_Y : String;          { 11 }
      fEND_M : String;            { 12 }
      fEND_D : String;            { 13 }
      fEND_Y : String;            { 14 }
   private
      FileVar : TextFile;
      KeyStr : UnicodeString;
      DecKeyStr : UnicodeString;
      KeyValues : tStringList;
      //
      Function GetLastName : String;
      Function GetFirstName : String;
      Function GetMiddleInitial : String;
      Function GetAddress1 : String;
      Function GetAddress2 : String;
      Function GetCity : String;
      Function GetState : String;
      Function GetZip : String;
		Function GetCodeWord : String;
		Function GetValid : Boolean;
		Function GetValid2 : Boolean;
		Function GetKeyFile : String;
      function GetEndD: String;
      function GetEndM: String;
      function GetEndY: String;
      function GetStartD: String;
      function GetStartM: String;
      function GetStartY: String;
      function GetExp : Boolean;
      function GetExpDate : tDateTime;
      function GetStartDate : tDateTime;
      //
      Procedure ParseKey;
      Procedure UnRegKey;
      procedure LoadKey();
      function GetEndDate: String;
   public
      CONSTRUCTOR Create; OVERLOAD;
      DESTRUCTOR Destroy; OVERRIDE;
      PROPERTY LAST_NAME : String READ GetLastName;
      PROPERTY FIRST_NAME : String READ GetFirstName;
      PROPERTY MIDDLE_INITIAL : String READ GetMiddleInitial;
      PROPERTY ADDRESS1 : String READ GetAddress1;
      PROPERTY ADDRESS2 : String READ GetAddress2;
      PROPERTY CITY : String READ GetCity;
      PROPERTY STATE : String READ GetState;
      PROPERTY ZIP : String READ GetZip;
      PROPERTY Tk4726TuI : Boolean READ GetValid;
      PROPERTY Tk4726Tu1 : Boolean READ GetValid2;
      PROPERTY CODE_WORD : String READ GetCodeWord;
      PROPERTY START_M : String READ GetStartM;
      PROPERTY START_D : String READ GetStartD;
      PROPERTY START_Y : String READ GetStartY;
      PROPERTY END_M : String READ GetEndM;
      PROPERTY END_D : String READ GetEndD;
      PROPERTY END_Y : String READ GetEndY;
      PROPERTY END_DATE : String READ GetEndDate;
      PROPERTY EXP : Boolean READ GetExp;
      PROPERTY ExpDate : tDateTime READ GetExpDate;
      PROPERTY StrtDate : tDateTime READ GetStartDate;
   end;

   function UnEncryptData( inString : string ) : string;
   function EncryptData( inString : string ) : string;

IMPLEMENTATION

function EncryptData(inString: string): string;
begin
   result := inString;
end;

function UnEncryptData(inString: string): string;
begin
   result := inString;
end;

(* ************************************************************************************** *)

CONSTRUCTOR tKeyVerif_Disabled.Create;
begin
   inherited Create;
   //
	KeyValues := tStringList.Create;
	If (FileExists(GetKeyFile)) then
	begin
		AssignFile(FileVar, GetKeyFile);
		Reset(FileVar);
		Read(FileVar,KeyStr);
		CloseFile(FileVar);
	end;
end;

DESTRUCTOR tKeyVerif_Disabled.Destroy;
begin
	KeyValues.Free;
	inherited;
end;

(* ************************************************************************************** *)

function tKeyVerif_Disabled.GetAddress1: String;
begin
	Result := '';
	if KeyStr = '' then
		Exit;
	ParseKey;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[3];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetAddress2: String;
begin
	Result := '';
	if KeyStr = '' then
		Exit;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[4];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetCity: String;
begin
  Result := '';
	if KeyStr = '' then
		Exit;
	ParseKey;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[5];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetCodeWord: String;
begin
	Result := '';
	if KeyStr = '' then
		Exit;
	ParseKey;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[8];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetFirstName: String;
begin
	Result := '';
	if KeyStr = '' then
		Exit;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[1];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetLastName: String;
begin
	Result := '';
	if KeyStr = '' then
		Exit;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[0];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetMiddleInitial: String;
begin
	Result := '';
	if KeyStr = '' then
		Exit;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[2];
	end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetState: String;
begin
	Result := '';
	if KeyStr = '' then
		Exit;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[6];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetZip: String;
begin
	Result := '';
	if KeyStr = '' then
		Exit;
	if KeyValues.Count -1 < 1 then
		Exit;
	Result := KeyValues.Strings[7];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetEndD: String;
begin
  Result := '';
  if (KeyStr = '') OR (KeyValues.Count -1 < 1) then
    Exit;
  Result := KeyValues.Strings[13];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetEndM: String;
begin
  Result := '';
  if (KeyStr = '') OR (KeyValues.Count -1 < 1) then
    Exit;
  Result := KeyValues.Strings[12];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetEndY: String;
begin
  Result := '';
  if (KeyStr = '') OR (KeyValues.Count -1 < 1) then
    Exit;
  Result := KeyValues.Strings[14];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetStartD: String;
begin
  Result := '';
  if (KeyStr = '') OR (KeyValues.Count -1 < 1) then
    Exit;
  Result := KeyValues.Strings[10];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetStartM: String;
begin
  Result := '';
  if (KeyStr = '') OR (KeyValues.Count -1 < 1) then
    Exit;
  Result := KeyValues.Strings[9];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetStartY: String;
begin
  Result := '';
  if (KeyStr = '') OR (KeyValues.Count -1 < 1) then
    Exit;
  Result := KeyValues.Strings[11];
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetEndDate: String;
begin
  Result := '';
  if (KeyStr = '') OR (KeyValues.Count -1 < 1) then
    Exit;
  if END_M = '1' then
    Result := Result + 'January';
  if END_M = '2' then
    Result := Result + 'February';
  if END_M = '3' then
    Result := Result + 'March';
  if END_M = '4' then
    Result := Result + 'April';
  if END_M = '5' then
    Result := Result + 'May';
  if END_M = '6' then
    Result := Result + 'June';
  if END_M = '7' then
    Result := Result + 'July';
  if END_M = '8' then
    Result := Result + 'August';
  if END_M = '9' then
    Result := Result + 'September';
  if END_M = '10' then
    Result := Result + 'October';
  if END_M = '11' then
    Result := Result + 'November';
  if END_M = '12' then
    Result := Result + 'December';
  Result := Result + ' ' + END_D + ', ' + END_Y;
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetExpDate: tDateTime;
begin
  if (END_Y = '') OR (END_M = '') OR (END_D = '') then
    Result := -999
  else
    Result := EncodeDate(StrToInt(END_Y),StrToInt(END_M),StrToInt(END_D));
end;

{-------------------------------------------------}

function tKeyVerif_Disabled.GetStartDate: tDateTime;
begin
   // TODO: finish the start date
end;

(* ************************************************************************************** *)

// This is used to validate if the key is valid. It does not check the expiration of the key.

function tKeyVerif_Disabled.GetValid: Boolean;
Var
   CheckStr : String;
   Codevalue : String;
   Roll : Integer;
   X : Integer;
   Y : Integer;
   year : word;
   month : word;
   day : word;
   dT : tDateTime;
   dE : tDateTime;
begin
   result := False;
   //
   If NOT (FileExists(GetKeyFile)) then
      Exit;
   //
   LoadKey();
   if (KeyStr = '') then
      Exit;
   //
   ParseKey;
   //
   if ( CODE_WORD = #65 + #86 + #79 + #66 + #65 + #83 + #69 + #53 + #54 + #55 + #74 + #84 + #50 + #49 + #70 ) then
      result := true;
end;

(* ************************************************************************************** *)

function tKeyVerif_Disabled.GetExp: Boolean;
var
   year : word;
   month : word;
   day : word;
   dT : tDateTime;
   de : tDateTime;
begin
   Result := False;
   dT := NOW;
   dE := EncodeDate(StrToInt(END_Y),StrToInt(END_M),StrToInt(END_D));
   if (dT > dE) then
      Result := TRUE;
end;

(* ************************************************************************************** *)

{ THIS IS USED ONLY TO VALIDATE THAT THE KEY IS GOOD, BUT THE KEY HAS EXPIRED }

function tKeyVerif_Disabled.GetValid2: Boolean;
Var
   CheckStr : String;
   Codevalue : String;
   Roll : Integer;
   X : Integer;
   Y : Integer;
   year : word;
   month : word;
   day : word;
   dT : tDateTime;
   de : tDateTime;
begin
   result := False;
   //
   If NOT (FileExists(GetKeyFile)) then
      Exit;
   //
   LoadKey();
   if (KeyStr = '') then
      Exit;
   //
   ParseKey;
   //
   if ( CODE_WORD = #65 + #86 + #79 + #66 + #65 + #83 + #69 + #53 + #54 + #55 + #74 + #84 + #50 + #49 + #70 ) then
      result := true;
   dT := NOW;
   dE := EncodeDate(StrToInt(END_Y),StrToInt(END_M),StrToInt(END_D));
   if (dT > dE) then
      Result := FALSE;
end;

(* ************************************************************************************** *)

function tKeyVerif_Disabled.GetKeyFile: String;
var
   varRec : tSearchRec;
   Path : String;
   DidFind : Boolean;
begin
   DidFind := False;
   Path := ExtractFileDir(ParamStr(0)) + '\';
   if (FindFirst(Path + '*.abk', faAnyFile + faDirectory, varRec) = 0) then
   begin
      Result := varRec.Name;
      DidFind := True;
   end;
   if (AvoINIReadString('AvoBase', 'KeyFile', 'X_X') <> 'X_X') then
   begin
      if FileExists(AvoINIReadString('AvoBase', 'KeyFile', 'X_X')) then
         Result := AvoINIReadString('AvoBase', 'KeyFile', 'X_X');
   end;
   if (NOT(DidFind)) then
      UnRegKey;
end;

(* ************************************************************************************** *)

procedure tKeyVerif_Disabled.ParseKey;
var
   X : Integer;
   Y : Integer;
   WorkStr : UnicodeString;
   K4TY6gt3JFEj89TO : string;
   CodeKey : string;
begin
   KeyValues.Clear;
   if (KeyStr = '') then
      exit;
   DecKeyStr := EncryptObj.Encryption_DecryptStringTF( KeyStr );
   if (Pos(#148, DecKeyStr) = 0) then
      Exit; // Malformed
   WorkStr := DecKeyStr;
   While length(WorkStr) >= 1 do
   begin
      x := pos(#148, WorkStr);
      CodeKey := Copy(WorkStr, 1, X - 1);
      System.Delete(WorkStr, 1, X);
      KeyValues.Add(CodeKey);
   end;
end;

(* ************************************************************************************** *)

procedure tKeyVerif_Disabled.UnRegKey;
begin
   fLAST_NAME := '';
   fFIRST_NAME := '';
   fMIDDLE_INITIAL := '';
   fADDRESS1 := '';
   fADDRESS2 := '';
   fCITY := '';
   fSTATE := '';
   fZIP := '';
   fCODE_WORD := '';
   fSTART_M := '';
   fSTART_D := '';
   fSTART_Y := '';
   fEND_M := '';
   fEND_D := '';
   fEND_Y := '';
end;

(* ************************************************************************************** *)

procedure tKeyVerif_Disabled.LoadKey;
begin
   if ( FileExists(GetKeyFile)) then
      KeyStr := EncryptObj.ReadKeyFile( GetKeyFile );
end;


end.


