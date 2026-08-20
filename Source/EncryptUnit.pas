 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit EncryptUnit;

interface uses
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   DECUtil,
   DECCipher,
   DECHash,
   DECFmt,
   StdCtrls;

const
   bktkobj711f = #88 + #90 + #120 + #112 + #115 + #121 + #97 + #117 + #75 + #110 +
      #101 + #84 + #57 + #90 + #101 + #84 + #104 + #51 + #100 + #119 +
      #99 + #120 + #114 + #106 + #116 + #110 + #68 + #117 + #81 + #114 +
      #114 + #71 + #110 + #114 + #97 + #102; {XZxpsyauKneT9ZeTh3dwcxrjtnDuQrrGnraf}



type
   tEncryptObj = class(TDataModule)
      procedure DataModuleCreate(Sender: TObject);
      procedure DataModuleDestroy(Sender: TObject);
   private

    public
      function Encryption_EncryptStringTF( inString : WideString ) : WideString;
      function Encryption_DecryptStringTF( inString : WideString ) : WideString;
      function EncryptString( inString : string ) : string;
      function DecryptString( inString : string ) : string;
      procedure WriteKeyFile( inFileName, inKey : string );
      function ReadKeyFile( inFileName : string ) : string;
   end;

var
   EncryptObj: TEncryptObj; { YES THIS IS HERE, NO DO NOT REMOVE IT }
   ACipherClass: TDECCipherClass = TCipher_Rijndael;
   ACipherMode: TCipherMode = cmCBCx;
   AHashClass: TDECHashClass = THash_Whirlpool;
   ATextFormat: TDECFormatClass = TFormat_Mime64;
   AKDFIndex: LongWord = 1;

implementation

{$R *.dfm}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure TEncryptObj.DataModuleCreate(Sender: TObject);
begin
   // do nothing.
end;

procedure tEncryptObj.DataModuleDestroy(Sender: TObject);
begin
   // do nothing.
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

function tEncryptObj.Encryption_EncryptStringTF(inString: WideString): WideString;
var
  ASalt: Binary;
  AData: Binary;
  APass: Binary;
begin
   with ValidCipher(ACipherClass).Create, Context do
   try
      ASalt := RandomBinary(16);
      APass := ValidHash(AHashClass).KDFx(bktkobj711f[1], Length(bktkobj711f) * SizeOf(bktkobj711f[1]), ASalt[1], Length(ASalt), KeySize, TFormat_Copy, AKDFIndex);
      Mode := ACipherMode;
      Init(APass);
      SetLength(AData, Length(inString) * SizeOf(inString[1]));
      Encode(inString[1], AData[1], Length(AData));
      Result := ValidFormat(ATextFormat).Encode(ASalt + AData + CalcMAC);
   finally
      Free;
      ProtectBinary(ASalt);
      ProtectBinary(AData);
      ProtectBinary(APass);
   end;
end;

function tEncryptObj.Encryption_DecryptStringTF(inString: WideString): WideString;
var
  ASalt: Binary;
  AData: Binary;
  ACheck: Binary;
  APass: Binary;
  ALen: Integer;
begin
  with ValidCipher(ACipherClass).Create, Context do
  try
    ASalt := ValidFormat(ATextFormat).Decode(inString);
    ALen := Length(ASalt) - 16 - BufferSize;
    AData := System.Copy(ASalt, 17, ALen);
    ACheck := System.Copy(ASalt, ALen + 17, BufferSize);
    SetLength(ASalt, 16);
    APass := ValidHash(AHashClass).KDFx(bktkobj711f[1], Length(bktkobj711f) * SizeOf(bktkobj711f[1]), ASalt[1], Length(ASalt), KeySize, TFormat_Copy, AKDFIndex);
    Mode := ACipherMode;
    Init(APass);
    SetLength(Result, ALen div SizeOf(inString[1]));
    Decode(AData[1], Result[1], ALen);
    { if ACheck <> CalcMAC then }

  finally
    Free;
    ProtectBinary(ASalt);
    ProtectBinary(AData);
    ProtectBinary(ACheck);
    ProtectBinary(APass);
  end;
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

{ AvoBase Non Encryption Rolling Schematic }

function tEncryptObj.EncryptString(inString: string): string;
var
   workStr : string;
   x : integer;
   r : integer;
   w : integer;
   c : char;
begin
   workStr := '';
   if ( inString <> '' ) then
   begin
      Randomize();
      r := Random(10) + 1;
      w := r;
      for x := 1 to Length( inString ) do
      begin
         c := inString[x];
         case w of
            1 : inc(c, 1);
            2 : inc(c, 2);
            3 : inc(c, 3);
            4 : inc(c, 4);
            5 : inc(c, 5);
            6 : dec(c, 5);
            7 : dec(c, 4);
            8 : dec(c, 3);
            9 : dec(c, 2);
            10 : dec(c, 1);
         end;
         workStr := workStr + Char(c);
         inc( w );
         if ( w > 10 ) then
            w := 1;
      end;
      insert( Char(r + 63), workStr, 1);
   end;
   result := workStr;
end;


function tEncryptObj.DecryptString(inString: string): string;
var
   workStr : string;
   x : integer;
   r : integer;
   w : integer;
   c : char;
begin
   workStr := '';
   if ( inString <> '' ) then
   begin
      w := ord( inString[1] ) - 63;
      for x := 2 to Length( inString ) do
      begin
         c := inString[x];
         case w of
            1 : dec(c, 1);
            2 : dec(c, 2);
            3 : dec(c, 3);
            4 : dec(c, 4);
            5 : dec(c, 5);
            6 : inc(c, 5);
            7 : inc(c, 4);
            8 : inc(c, 3);
            9 : inc(c, 2);
            10 : inc(c, 1);
         end;
         workStr := workStr + Char(c);
         inc( w );
         if ( w > 10 ) then
            w := 1;
      end;
   end;
   result := workStr;
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

procedure tEncryptObj.WriteKeyFile( inFileName, inKey : string );
var
   fSave : tStringList;
begin
   fSave := tStringList.Create();
   try
      fSave.Text := inKey;
      fSave.SaveToFile( inFileName );
   finally
      FreeAndNil(fSave);
   end;
end;

function tEncryptObj.ReadKeyFile( inFileName : string ) : string;
var
   fSave : tStringList;
begin
   fSave := tStringList.Create();
   try
      fSave.LoadFromFile( inFileName );
      result := fSave.Text;
   finally
      FreeAndNil(fSave);
   end;
end;

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //


end.




(*
var
	ObjVerf : tKeyVerif;
   CheckDays : Integer;
begin
	ObjVerf := tKeyVerif.Create;
	if NOT(ObjVerf.Tk4726TuI) then
	begin
      { NOT REGISTERED AT ALL }
   end else
      begin
         { THEY ARE REGISTERED }
		end;
	{ *** NOW CHECK EXPIRATION DATES FOR WARNINGS *** }
	if (ObjVerf.Tk4726TuI) AND NOT(ObjVerf.Tk4726Tu1) then
	begin
      { THIS VERSION OF AVOBASE IS REGISTERED CORRECTLY - BUT THE KEY HAS EXPIRED }
      if (OBJVerf.EXP) then
      begin
      { REGISTERED, BUT KEY HAS EXPIRED }
      end;
   end else
      begin
         if (OBJVerf.ExpDate - NOW <= 30) AND (OBJVerf.ExpDate <> -999) then
         begin
            { THIS VERSION OF AVOBASE IS REGISTERED CORRECTLY - KEY WILL SOON EXPIRE }
         end;
      end;
	FreeAndNil(ObjVerf);
end;

*)
