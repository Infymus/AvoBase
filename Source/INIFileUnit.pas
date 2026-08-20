 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

 UNIT  INIFileUnit;

INTERFACE

USES
   sysutils,
   classes,
   constantsunit,
   inifiles;

Procedure AvoINIWriteString( INIKey, INIItem : String; INIValue : String);
Procedure AvoINIWriteInteger( INIKey, INIItem : String; INIValue : Integer);
Procedure AvoINIWriteBoolean( INIKey, INIItem : String; INIValue : Boolean);
Procedure AvoINIWriteFloat( INIKey, INIItem : String; INIValue : Double);

 Function AvoINIReadString( INIKey, INIItem : String; DefValue : String ) : String;
 Function AvoINIReadInteger( INIKey, INIItem : String; DefValue : Integer) : Integer;
 Function AvoINIReadBoolean( INIKey, INIItem : String; DefValue : Boolean) : Boolean;
 Function AvoINIReadFloat( INIKey, INIItem : String; DefValue : Double) : Double;


IMPLEMENTATION

(* ************************************************************************************************** *)

Procedure AvoINIWriteString( INIKey, INIItem : String; INIValue : String);
var
  AvoINIFile : tIniFile;
begin
   AvoINIFile := tINIFile.Create( ExtractFilePath(ParamStr(0)) + AVOBASE_INI);
   AvoINIFile.WriteString( INIKey, INIItem, INIValue);
   AvoINIFile.Free;
end;

Function AvoINIReadString( INIKey, INIItem : String; DefValue : String ) : String;
var
  AvoINIFile : tIniFile;
begin
  Result := DefValue;
  AvoINIFile := tINIFile.Create( ExtractFilePath(ParamStr(0))  + AVOBASE_INI);
  Result := AvoINIFile.ReadString( INIKey, INIItem, DefValue);
  AvoINIFile.Free;
end;

(* ************************************************************************************************** *)

Procedure AvoINIWriteInteger( INIKey, INIItem : String; INIValue : Integer);
var
  AvoINIFile : tIniFile;
begin
  AvoINIFile := tINIFile.Create( ExtractFilePath(ParamStr(0)) + AVOBASE_INI);
  AvoINIFile.WriteInteger( INIKey, INIItem, INIValue);
  AvoINIFile.Free;
end;

Function AvoINIReadInteger( INIKey, INIItem : String; DefValue : Integer) : Integer;
var
  AvoINIFile : tIniFile;
begin
  Result := DefValue;
  AvoINIFile := tINIFile.Create( ExtractFilePath(ParamStr(0)) + AVOBASE_INI);
  Result := AvoINIFile.ReadInteger( INIKey, INIItem, DefValue);
  AvoINIFile.Free;
end;

(* ************************************************************************************************** *)

Procedure AvoINIWriteBoolean( INIKey, INIItem : String; INIValue : Boolean);
var
  AvoINIFile : tIniFile;
begin
   AvoINIFile := tINIFile.Create( ExtractFilePath(ParamStr(0)) + AVOBASE_INI);
   AvoINIFile.WriteBool( INIKey, INIItem, INIValue);
   AvoINIFile.Free;
end;

Function AvoINIReadBoolean( INIKey, INIItem : String; DefValue : Boolean) : Boolean;
var
  AvoINIFile : tIniFile;
begin
  Result := DefValue;
  AvoINIFile := tINIFile.Create( ExtractFilePath(ParamStr(0)) + AVOBASE_INI);
  Result := AvoINIFile.ReadBool( INIKey, INIItem, DefValue);
  AvoINIFile.Free;
end;

(* ************************************************************************************************** *)

Procedure AvoINIWriteFloat( INIKey, INIItem : String; INIValue : Double);
var
  AvoINIFile : tIniFile;
begin
  AvoINIFile := tINIFile.Create( ExtractFilePath(ParamStr(0)) + AVOBASE_INI);
  AvoINIFile.WriteFloat( INIKey, INIItem, INIValue);
  AvoINIFile.Free;
end;

Function AvoINIReadFloat( INIKey, INIItem : String; DefValue : Double) : Double;
var
  AvoINIFile : tIniFile;
begin
  Result := DefValue;
  AvoINIFile := tINIFile.Create( ExtractFilePath(ParamStr(0)) + AVOBASE_INI);
  Result := AvoINIFile.ReadFloat( INIKey, INIItem, DefValue);
  AvoINIFile.Free;
end;

end.




