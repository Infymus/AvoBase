 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

 UNIT  CalculatorFormUnit;

INTERFACE

USES  Windows,
      Messages,
      SysUtils,
      Variants,
      Classes,
      Graphics,
      ToolBoxunit,
      constantsunit,
      Controls,
      Forms,
      Dialogs,
      IMG_StorageFormUnit,
      ComCtrls,
      ToolWin,
      StdCtrls,
      ExtCtrls,
      Menus,
      Buttons;

TYPE
  TCalculatorForm = class(TForm)
    BACK_COLOR_PANEL: TPanel;
    BACK_PANEL: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Panel1: TPanel;
    ButtonBS: TSpeedButton;
    Panel4: TPanel;
    ButtonC: TSpeedButton;
    Panel5: TPanel;
    Button7: TSpeedButton;
    Panel6: TPanel;
    Button8: TSpeedButton;
    Panel7: TPanel;
    Button9: TSpeedButton;
    Panel8: TPanel;
    ButtonDIV: TSpeedButton;
    Panel9: TPanel;
    Button4: TSpeedButton;
    Panel10: TPanel;
    Button5: TSpeedButton;
    Panel11: TPanel;
    Button6: TSpeedButton;
    Panel12: TPanel;
    ButtonTimes: TSpeedButton;
    Panel13: TPanel;
    Button1: TSpeedButton;
    Panel14: TPanel;
    Button2: TSpeedButton;
    Panel15: TPanel;
    Button3: TSpeedButton;
    Panel16: TPanel;
    ButtonMinus: TSpeedButton;
    Panel17: TPanel;
    Button0: TSpeedButton;
    Panel18: TPanel;
    ButtonPeriod: TSpeedButton;
    Panel19: TPanel;
    ButtonPlus: TSpeedButton;
    Panel20: TPanel;
    ButtonEquals: TSpeedButton;
    CALC_TEXT: TLabel;
    Panel21: TPanel;
    SaveButton: TSpeedButton;
    Panel22: TPanel;
    SpeedButton1: TSpeedButton;
    procedure ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  PRIVATE
    Procedure Calc_Values;
    Procedure Do_Calc( InNum : Integer );
    Procedure Close_Calc;
    Procedure Close_Accept;
    Function Get_Calc : Currency;
  PUBLIC
    CALC_FIRST : Currency;
    CALC_SECOND : Currency;
    CALC_VALUE : Currency;
    CALC_TYPE : Integer;
    Calc_On : Boolean;
  end;

CONST
  CALC_ADD = 1;
  CALC_DIV = 2;
  CALC_MINUS = 3;
  CALC_TIMES = 4;

  Function Disp_Calculator( InCurr : String ) : Currency;

IMPLEMENTATION

{$R *.DFM}

(* ****************************************************************************************************************************** *)

Function Disp_Calculator( InCurr : String ) : Currency;
var
  CalcForm : TCalculatorForm;
begin
  TrimCurr(InCurr);
  if InCurr = '0.00' then
    InCurr := '';
  CalcForm := tCalculatorForm.Create(Application);
  try
    if (InCurr <> '.') AND (InCurr <> '') then
      CalcForm.CALC_TEXT.Caption := Return_MaskEdit_Str(InCurr);
    CalcForm.ShowModal;
    Result := CalcForm.CALC_VALUE;
  finally
    FreeAndNil(CalcForm);
  end;
end;

(* ****************************************************************************************************************************** *)

procedure TCalculatorForm.FormCreate(Sender: TObject);
begin
  inherited;
  CALC_TEXT.Caption := '';
  CALC_FIRST := 0.00;
  CALC_SECOND := 0.00;
  CALC_VALUE := 0.00;
  CALC_TYPE := 0;
  Calc_ON := False;
end;

(* ****************************************************************************************************************************** *)

procedure TCalculatorForm.ButtonClick(Sender: TObject);
Var
  S : String;
begin
  case (Sender AS tSpeedButton).Tag of
    1..9:Do_Calc((Sender AS tSpeedButton).Tag);
    30:Do_Calc(0);
    //
    20:
    begin
      if Calc_Text.Caption <> '' then
      begin
        S := Calc_Text.Caption;
        Delete(S,Length(S),1);
        Calc_Text.Caption := S;
      end;
    end;
    21:
    begin
      CALC_TEXT.Caption := '';
      CALC_FIRST := 0.00;
      CALC_SECOND := 0.00;
      CALC_VALUE := 0.00;
      CALC_TYPE := 0;
      Calc_ON := False;
    end;
    22:
    begin
      CALC_FIRST := Get_Calc;
      CALC_TYPE := CALC_DIV;
      if CALC_SECOND <> 0 then
        Calc_Values;
      Calc_ON := True;
    end;
    23:
    begin
      CALC_FIRST := Get_Calc;
      CALC_TYPE := CALC_TIMES;
      if CALC_SECOND <> 0 then
        Calc_Values;
      Calc_ON := True;
    end;
    24:
    begin
      CALC_FIRST := Get_Calc;
      CALC_TYPE := CALC_MINUS;
      if CALC_SECOND <> 0 then
        Calc_Values;
      Calc_ON := True;
    end;
    25:
    begin
      CALC_SECOND := Get_Calc;
      Calc_Values;
      CALC_SECOND := 0;
    end;
    26:
    begin
      CALC_FIRST := Get_Calc;
      CALC_TYPE := CALC_ADD;
      if CALC_SECOND <> 0 then
        Calc_Values;
      Calc_ON := True;
    end;
    27:CALC_TEXT.Caption := CALC_TEXT.Caption + '.';
    28:Close_Calc;
    29:Close_Accept;
  end;
end;

procedure TCalculatorForm.SpeedButton1Click(Sender: TObject);
begin
  Close_Calc;
end;

procedure TCalculatorForm.Calc_Values;
begin
  if (CALC_TYPE <> 0) then
  begin
    case CALC_TYPE of
      CALC_DIV:
      begin
        try
          CALC_VALUE := CALC_FIRST / CALC_SECOND;
        except
          CALC_VALUE := 0;
        end;
      end;
      CALC_TIMES:
      begin
        try
          CALC_VALUE := CALC_FIRST * CALC_SECOND;
        except
          CALC_VALUE := 0;
        end;
      end;
      CALC_MINUS:
      begin
        try
          CALC_VALUE := CALC_FIRST - CALC_SECOND;
        except
          CALC_VALUE := 0;
        end;
      end;
      CALC_ADD:
      begin
        try
          CALC_VALUE := CALC_FIRST + CALC_SECOND;
        except
          CALC_VALUE := 0;
        end;
      end;
    end;
  end else
    CALC_VALUE := Get_Calc;
  CALC_SECOND := 0;
  CALC_TEXT.Caption := CurrToStr(CALC_VALUE);
end;

procedure TCalculatorForm.Do_Calc( InNum : Integer );
begin
  if (Calc_On) then
    Calc_Text.Caption := '';
  Calc_On := False;
  CALC_TEXT.Caption := CALC_TEXT.Caption + IntToStr(InNum);
end;

procedure TCalculatorForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  S : String;
begin
  Case Key of
    VK_RETURN:
    begin
      CALC_SECOND := Get_Calc;
      Calc_Values;
      Close_Accept;
    end;
    VK_ESCAPE:
    begin
      CALC_TEXT.Caption := '';
      CALC_FIRST := 0.00;
      CALC_SECOND := 0.00;
      CALC_VALUE := 0.00;
      CALC_TYPE := 0;
      Calc_ON := False;
    end;
    187:
    begin
      if NOT(ssShift in Shift) then
      begin
        // = pressed
        CALC_SECOND := Get_Calc;
        Calc_Values;
        CALC_SECOND := 0;
      end else
        begin
          // + Pressed with Shift
          CALC_TYPE := CALC_ADD;
          CALC_FIRST := Get_Calc;
          if CALC_SECOND <> 0 then
            Calc_Values;
          Calc_ON := True;
        end;
    end;
    61:
    begin
      CALC_SECOND := Get_Calc;
      Calc_Values;
      CALC_SECOND := 0;
    end;
    56:
    begin
      if NOT(ssShift in Shift) then
        Do_Calc(7)
      else
        begin
          CALC_TYPE := CALC_TIMES;
          CALC_FIRST := Get_Calc;
          if CALC_SECOND <> 0 then
            Calc_Values;
          Calc_ON := True;
        end;
    end;
    48,VK_NUMPAD0,VK_INSERT: Do_Calc(0);
    49,VK_NUMPAD1,VK_END: Do_Calc(1);
    50,VK_NUMPAD2,VK_DOWN: Do_Calc(2);
    51,VK_NUMPAD3,VK_NEXT: Do_Calc(3);
    52,VK_NUMPAD4,VK_LEFT: Do_Calc(4);
    53,VK_NUMPAD5,12 : Do_Calc(5);
    54,VK_NUMPAD6,VK_RIGHT: Do_Calc(6);
    55,VK_NUMPAD7,VK_HOME: Do_Calc(7);
    VK_NUMPAD8,VK_UP: Do_Calc(8);
    57,VK_NUMPAD9,VK_PRIOR: Do_Calc(9);
    58,VK_MULTIPLY:
    begin
      CALC_TYPE := CALC_TIMES;
      CALC_FIRST := Get_Calc;
      if CALC_SECOND <> 0 then
        Calc_Values;
      Calc_ON := True;
    end;
    VK_ADD:
    begin
      CALC_TYPE := CALC_ADD;
      CALC_FIRST := Get_Calc;
      if CALC_SECOND <> 0 then
        Calc_Values;
      Calc_ON := True;
    end;
    189,VK_SUBTRACT:
    begin
      CALC_TYPE := CALC_MINUS;
      CALC_FIRST := Get_Calc;
      if CALC_SECOND <> 0 then
        Calc_Values;
      Calc_ON := True;
    end;
    VK_DECIMAL,VK_DELETE: CALC_TEXT.Caption := CALC_TEXT.Caption + '.';
    191,VK_DIVIDE:
    begin
      CALC_TYPE := CALC_DIV;
      CALC_FIRST := Get_Calc;
      if CALC_SECOND <> 0 then
        Calc_Values;
      Calc_ON := True;
    end;
    VK_BACK:
    begin
      if Calc_Text.Caption <> '' then
      begin
        S := Calc_Text.Caption;
        Delete(S,Length(S),1);
        Calc_Text.Caption := S;
      end;
    end;
    190:CALC_TEXT.Caption := CALC_TEXT.Caption + '.';
  end;
end;

procedure TCalculatorForm.Close_Calc;
begin
  CALC_VALUE := -1;
  Close;
end;

procedure TCalculatorForm.Close_Accept;
begin
  Try
    CALC_VALUE := StrToCurr(CALC_TEXT.Caption);
  Except
    CALC_VALUE := -1;
  End;
  Close;
end;

Function TCalculatorForm.Get_Calc : Currency;
Var
  S : String;
begin
  S := CALC_TEXT.Caption;
  while Copy(S,1,1) = '0' do
    Delete(s,1,1);
  Try
    Result := StrToCurr(S);
  Except
    Result := 0.00;
  end;
end;

end.
