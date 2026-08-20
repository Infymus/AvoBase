 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit  ToolBoxUnit;

interface uses
   constantsunit,
   inifileunit,
   //
   classes,
   forms,
   DateUtils,
   Math,
   recordstructureunit,
   sysutils;

	Function Return_MaskEdit_Str( InCash : String ) : String;
   Function Return_MaskEdit_Int( InCash : String ) : Integer;
   Function Return_MaskEdit_Curr( InCash : String ) : Currency;
   Function Return_MaskEdit_Float( InFloat : String ) : Double;
   Function RepIntStr( SearchCode, SearchStr, RepStr : String) : String;
   Function CheckFileName( InFileName : String ) : String;
   Function ParseName(const AFullName: string): String;
   Function ProperCase(const AValue: string; ATrim: Boolean = True): string;
   Function ProtectCCNum( InCC : String ) : String;
   Function UnProtectCCNum( InCC : String ) : String;
   Function SetSize( inSize : Integer; InStr : String ) : String;
   Function SpaceToDot( Instr : String ) : String;
   Procedure TrimCurr( VAR InStr : String );
   procedure WindowSizePosition( inForm : tForm; inINIArea : string; inDefaultWidth : integer; inDefaultHeight : integer);
   function Date_GetDateRecord( inDate : tDateTime ) : tDateRecord;
   function FormatCurrency( inCurrency : currency ) : string;
   function Return_MaskEdit_ProductNumber( inStr : string ) : string;
   function DateTime_TrimSpaces( inDateStr : string ) : tDateTime;
	function RoundCurrency(const Value: Currency): Currency;
   function HumanRound(X: Extended): integer;
   function RoundTo2dp(Value: Currency): Currency;
   function GuidToFileName : string;

// ********************************************************************************************* //

implementation

// ********************************************************************************************* //

procedure WindowSizePosition( inForm : tForm; inINIArea : string; inDefaultWidth : integer; inDefaultHeight : integer);
begin
   // Set the Height, Width, Top and Left
   //
   inForm.Width := AvoINIReadInteger(inINIArea, 'FormWidth', inDefaultWidth);
   inForm.Height := AvoINIReadInteger(inINIArea, 'FormHeight', inDefaultHeight);
   inForm.Left:= AvoINIReadInteger(inINIArea, 'FormLeft', 0);
   inForm.Top:= AvoINIReadInteger(inINIArea, 'FormTop', 0);

   // Ensure the screen is NOT off the view area
   //
   if (inForm.Left + inForm.Width > Screen.DeskTopWidth) then
      inForm.Left := Screen.DeskTopWidth - inForm.Width;
   if (inForm.Top + inForm.Height > Screen.DeskTopHeight) then
      inForm.Top := Screen.DeskTopHeight - inForm.Height;
   if (inForm.Width > Screen.DeskTopWidth) then
      inForm.Width := Screen.DeskTopWidth;
   if (inForm.Height > Screen.DeskTopHeight) then
      inForm.Height := Screen.DeskTopHeight;

   // Minimize OR Normalize it
   if (AvoINIReadString(inINIArea,'FormSize','ERR') = 'NORM') then
      inForm.WindowState := wsNormal;
   if (AvoINIReadString(inINIArea,'FormSize','ERR') = 'MAX') then
      inForm.WindowState := wsMaximized;
end;

// ********************************************************************************************* //

{ Written to take the hassle out of the Mask Edit Shit }
Function Return_MaskEdit_Str( InCash : String ) : String;
Var
  _Cash : Currency;
  _CashStr : String;
begin
  _CashStr := Trim(InCash);
  if Copy(_CashStr, 1, 1) = '$' then
    Delete(_CashStr, 1, 1);
  While Pos(#32, _CashStr) >= 1 do
    Delete(_CashStr, Pos(#32, _CashStr), 1);
  if (_CashStr = '') or (_CashStr = '.') then
    _CashStr := '0';
  Result := _CashStr;
end;

// ********************************************************************************************* //

Function Return_MaskEdit_Int( InCash : String ) : Integer;
Var
  _Cash : Currency;
  _CashStr : String;
begin
   _CashStr := Trim(InCash);
   if Copy(_CashStr, 1, 1) = '$' then
      Delete(_CashStr, 1, 1);
   While Pos(#32, _CashStr) >= 1 do
      Delete(_CashStr, Pos(#32, _CashStr), 1);
   if (_CashStr = '') or (_CashStr = '.') then
      _CashStr := '0';
   Result := StrToInt(_CashStr);
end;

// ********************************************************************************************* //

Function Return_MaskEdit_Curr( InCash : String ) : Currency;
Var
  _Cash : Currency;
  _CashStr : String;
begin
  _CashStr := Trim(InCash);
  if Copy(_CashStr, 1, 1) = '$' then
    Delete(_CashStr, 1, 1);
  While Pos(#32, _CashStr) >= 1 do
    Delete(_CashStr, Pos(#32, _CashStr), 1);
  if (_CashStr = '') or (_CashStr = '.') then
    _CashStr := '0';
  Result := StrToCurr(_CashStr);
end;

// ********************************************************************************************* //

// this function is only to pull out anything in an
function Return_MaskEdit_ProductNumber( inStr : string ) : string;
var
   workStr : string;
begin
   workStr := Trim( inStr );
   // remove spaces
   while pos(#32, workStr) >= 1 do
      delete( workStr, pos(#32, workStr), 1);
   // remove dashes
   while pos('-', workStr) >= 1 do
      delete( workStr, pos('-', workStr), 1);
   //
   result := workStr;
end;

// ********************************************************************************************* //

{ This replaces ONE string with ANOTHER string and sends the result back }
Function RepIntStr( SearchCode, SearchStr, RepStr : String) : String;
var
  GlobVar : Integer;
begin
  Repeat
    GlobVar := Pos( SearchCode, SearchStr );
    if GlobVar <> 0 then
    begin
      Delete( SearchStr, GlobVar, Length( SearchCode ));
      Insert( RepStr, SearchStr, GlobVar );
    end;
  until Pos( SearchCode, SearchStr ) = 0;
  Result := SearchStr;
end;

// ********************************************************************************************* //

Function CheckFileName( InFileName : String ) : String;
begin
  Result := '';
  If Copy(InFileName,Length(InFileName),1) = '\' then
    Result := InFileName
  else
    Result := InFileName + '\';
end;

// ********************************************************************************************* //

{ This routine breaks down the full name into First, Last, Middle and Title }
function ParseName(const AFullName: string): String;
var
  sl: TStringList;
begin
  Result := '';
  sl := TStringList.Create();
  try
    sl.Delimiter := ' ';
    sl.QuoteChar := '''';
    sl.DelimitedText := aFullName;
    if sl.Count = 4 then
    begin
      Result := sl[0] + ' ' + sl[1] + ' ' + sl[2] + ' ' + sl[3];
    end else
      if sl.Count = 3 then
      begin     
        Result := sl[0] + ' ' + sl[1] + ' ' + sl[2];
      end else
        if sl.Count = 2 then
        begin
          Result := sl[0] + ' ' + sl[1];
        end else
          if Sl.Count >= 1 then
            Result := sl[0];
  finally
    sl.Free();
  end;
end;

// ********************************************************************************************* //

{ Notes by Hoenie:
  ----------------
  Personally I don't think this statement will ever really work properly. A change request came about
  because this original procedure was converting "Macey" to "MacEy", which is incorrect. The modifications
  I did remedy this situation, but do not take into account "MacErnest" or "MacFookable", etc. In all
  reality, the routine actually needs to check the name, and if said "C" character is found in
  the string in position #2 or #3, it should really ASK the user to decide between the two names
  and then do so. Unfortunatly the code is set up so that it would probably ask the same stupid question
  dozens of times as it ran through processes, AND, it is not scriptable so it'd ask the question
  in places it should not. I digress, this routine is only worth the characters it's typed up to be. }

{ Proper Case Statement }
function ProperCase(const AValue: string; ATrim: Boolean = True): string;
var
  i: Integer;
  cap: Boolean;
const
  TrigChars: array[1..21] of Char = ('"','''','.',',','-','_','\','/',' ','(',':','1','2','3','4','5','6','7','8','9','0');
begin
  Result := LowerCase(AValue);
  if ATrim then
    Result := Trim(Result);
  cap := True;
  for i := 1 to Length(Result) do
  begin
    if cap then
      Result[i] := UpCase(Result[i]);
    // Handle the McMillan, MacMillan and 's cases. If none of those, check for trigger char
      if (Result[i] = '''') and (i < Length(Result)) and (Result[i+1] = 's') then
        cap := False
      else
        cap := (Pos(Result[i],TrigChars) > 0);
  end;
end;

// ********************************************************************************************* //

Function ProtectCCNum( InCC : String ) : String;
begin
  result := InCC;
end;

// ********************************************************************************************* //

Function UnProtectCCNum( InCC : String ) : String;
begin
  result := InCC;
end;

// ********************************************************************************************* //

Function Return_MaskEdit_Float( InFloat : String ) : Double;
Var
  _Cash : Double;
  _CashStr : String;
begin
  _CashStr := Trim(InFloat);
  While Pos(#32, _CashStr) >= 1 do
    Delete(_CashStr, Pos(#32, _CashStr), 1);
  if (_CashStr = '') or (_CashStr = '.') then
    _CashStr := '0';
  Result := StrToFloat(_CashStr);
end;

// ********************************************************************************************* //

Function SetSize( inSize : Integer; InStr : String ) : String;
begin
  While length(InStr) < InSize do
    InStr := Instr + #32;
  Result := InStr;
end;

// ********************************************************************************************* //

Function SpaceToDot( Instr : String ) : String;
Var
  X : Integer;
begin
  for X := 1 to Length(Instr) do
    if Instr[X] = #32 then
      Instr[X] := '.';
  Result := Instr;
end;

// ********************************************************************************************* //

Procedure TrimCurr( VAR InStr : String );
begin
  while (POS(#32,InStr)<>0) do
    Delete(InStr,POS(#32,InStr),1);
end;


{ this stupid ass goddamn function exists because delphi can't fucking change a goddamn fucking stupid ass
	fucking word into an integer, so we have to convert it to a goddamn string and then fucking convwert
   it back into an integer. delphi is a bitch sometimes... mh 6/11/2011 }

function Date_GetDateRecord( inDate : tDateTime ) : tDateRecord;
var
   y, m, d, h, min, sec, mil : word;
   convStr : string;
begin
	DecodeDateTime(inDate,y,m,d,h,min,sec,mil);
   //
   result.fDate := inDate;
   //
   convStr := IntToStr(y);
   result.fYear := StrToInt(convStr);
   //
   convStr := IntToStr(m);
   result.fMonth := StrToInt(convStr);
   //
   convStr := IntToStr(d);
   result.fDay := StrToInt(convStr);
   //
   convStr := IntToStr(h);
   result.fHour := StrToInt(convStr);
   //
   convStr := IntToStr(min);
   result.fMin := StrToInt(convStr);
   //
   convStr := IntToStr(sec);
   result.fSec := StrToInt(convStr);
   //
   convStr := IntToStr(mil);
   result.fMilli := StrToInt(convStr);
end;

// ********************************************************************************************* //

function FormatCurrency( inCurrency : currency ) : string;
begin
   if inCurrency > 0 then
      result := FormatFloat('#####.00', inCurrency)
   else
      result := '.00';
   // let's do a check on this to make sure the currency isn't something like 0.0001
   if ( result = '.00' ) AND ( inCurrency > 0 ) then
   	result := FormatFloat('#####.####', inCurrency);
end;

// ********************************************************************************************* //

function DateTime_TrimSpaces( inDateStr : string ) : tDateTime;
begin
	result := NOW;
	while POS(#32, inDateStr ) >= 1 do
   	Delete(inDateStr, POS(#32, inDateStr), 1);
   result := StrToDate( inDateStr );
end;

// ********************************************************************************************* //

function RoundCurrency(const Value: Currency): Currency;
var
   V64: Int64 absolute Result;
   Decimals: Integer;
begin
	Result := Value;
   Decimals := V64 mod 100;
   Dec(V64, Decimals);
   case Decimals of
   	-99 .. -50 : Dec(V64, 100);
      50 .. 99 : Inc(V64, 100);
   end;
end;

// use this to not get "banker's rounding"
function HumanRound(X: Extended): integer;
// Rounds a number "normally": if the fractional
// part is >= 0.5 the number is rounded up (see RoundUp)
// Otherwise, if the fractional part is < 0.5, the
// number is rounded down
//   RoundN(3.5) = 4     RoundN(-3.5) = -4
//   RoundN(3.1) = 3     RoundN(-3.1) = -3
begin
  // Trunc() does nothing except conv to integer.  needed because return type of Int() is Extended
  Result := Trunc(Int(X) + Int(Frac(X) * 2));
end;

function RoundTo2dp(Value: Currency): Currency;
begin
  Result := Trunc(Value*100+IfThen(Value>0, 0.5, -0.5))/100;
end;


// ********************************************************************************************* //

function GuidToFileName : string;
begin
   result := '';

end;


end.




