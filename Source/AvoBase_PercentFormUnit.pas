 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit	AvoBase_PercentFormUnit;

interface uses
   windows,
   messages,
   sysutils,
   classes,
   graphics,
   controls,
   forms,
   dialogs,
   constantsunit,
   gauges,
   stdctrls,
   jpeg,
   toolboxunit,
   extctrls,
   buttons,
   comctrls,
   toolwin, ShellAnimations;


type
  TPercentForm = class(TForm)
    PCNT_DOCK_PANEL: TPanel;
    PCNT_BACK_PANEL: TPanel;
    Progress: TProgressBar;
    HeaderLabel: TLabel;
    PercentImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure HeaderLabelClick(Sender: TObject);
  end;

Var
  PercentForm: TPercentForm;
  PercentFormCancel : Boolean;

Procedure PercentForm_Create( InString : String; InMinVal, InMaxVal : Integer);
Procedure PercentForm_UpdateHeader( InString : String);
procedure PercentForm_IncreaseTotal( inInc : integer );
Procedure PercentForm_Update;
Procedure PercentForm_Free;

IMPLEMENTATION

{$R *.DFM}

(* *************************************************************************************************** *)

procedure TPercentForm.FormCreate(Sender: TObject);
begin
  Self.Caption := AVOBASE_NAME;
end;

procedure TPercentForm.HeaderLabelClick(Sender: TObject);
begin

end;

(* *************************************************************************************************** *)

Procedure PercentForm_UpdateHeader( InString : String);
begin
   if ( PercentForm <> NIL ) then
   begin
      PercentForm.HeaderLabel.Caption := InString;
      Application.ProcessMessages;
   end;
end;

(* *************************************************************************************************** *)

procedure PercentForm_Create(InString: String; InMinVal, InMaxVal: Integer);
begin
	PercentFormCancel := False;
   if (PercentForm = Nil) then
   	PercentForm := tPercentForm.Create(Application);
   PercentForm.HeaderLabel.Caption := InString;
   if (InMaxVal = 0) then
   begin
      PercentForm.Progress.Visible := false;
      PercentForm.Height := 66;
   end else
   	begin
      	PercentForm.Progress.Min := InMinVal;
         PercentForm.Progress.Max := InMaxVal;
         PercentForm.Progress.Position := 0;
      end;
   PercentForm.Show;
   Application.ProcessMessages;
end;

(* *************************************************************************************************** *)

procedure PercentForm_Free;
begin
  if (Percentform <> Nil) then
    PercentForm.Free;
  PercentForm := Nil;
end;

(* *************************************************************************************************** *)

Procedure PercentForm_Update;
var
  _skunk : integer;
begin
  if (Percentform <> Nil) AND (PercentForm.Visible = true) then
  begin
    _skunk := PercentForm.Progress.Position;
    Inc(_skunk);
    PercentForm.Progress.Position := _skunk;
//    PercentForm.Progress.Repaint();
    Application.ProcessMessages;
  end;
end;

(* *************************************************************************************************** *)

procedure PercentForm_IncreaseTotal( inInc : integer );
var
  _skunk : integer;
begin
  if (Percentform <> Nil) AND (PercentForm.Visible = true) then
  begin
    _skunk := PercentForm.Progress.Max;
    Inc(_skunk, inInc);
    PercentForm.Progress.Max := _skunk;
    Application.ProcessMessages;
  end;
end;

(* *************************************************************************************************** *)

procedure TPercentForm.CancelButtonClick(Sender: TObject);
begin
  PercentFormCancel := True;
end;

end.
