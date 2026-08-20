 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_StartupFormUnit;

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
   toolwin,
   ShellAnimations,
   pngimage;

type
  TStartupForm = class(TForm)
    PCNT_DOCK_PANEL: TPanel;
    PCNT_BACK_PANEL: TPanel;
    ProgressBar1: TProgressBar;
    imgAvoIcon: TImage;
    imgAvoName: TImage;
    labelCopyright: TLabel;
    labelVersion: TLabel;
    labelAvobaseName: TLabel;
    HeaderLabel: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  end;

Var
   StartPercentForm : TStartupForm;
   StartupFormCancel : Boolean;

Procedure StartPercentForm_Create( InString : String; InMinVal, InMaxVal : Integer);
Procedure StartPercentForm_UpdateHeader( InString : String);
procedure StartPercentForm_IncreaseTotal( inInc : integer );
Procedure StartPercentForm_Update;
Procedure StartPercentForm_Free;

IMPLEMENTATION

{$R *.DFM}

(* *************************************************************************************************** *)

procedure TStartupForm.FormCreate(Sender: TObject);
begin
   Self.Caption := AVOBASE_NAME;
   labelVersion.Caption := VER_NUM;
	labelCopyright.Caption := AVOBASE_COPYRIGHT;
end;

(* *************************************************************************************************** *)

Procedure StartPercentForm_UpdateHeader( InString : String);
begin
   if ( StartPercentForm <> NIL ) then
   begin
      StartPercentForm.HeaderLabel.Caption := InString;
      Application.ProcessMessages;
   end;
end;

(* *************************************************************************************************** *)

procedure StartPercentForm_Create(InString: String; InMinVal, InMaxVal: Integer);
begin
   if (StartPercentForm = Nil) then
   	StartPercentForm := TStartupForm.Create(Application);
   StartPercentForm.HeaderLabel.Caption := InString;
   if (InMaxVal = 0) then
   begin
      StartPercentForm.ProgressBar1.Visible := false;
      StartPercentForm.Height := 66;
   end else
   	begin
      	{StartPercentForm.Progress.MinValue := InMinVal;
         StartPercentForm.Progress.MaxValue := InMaxVal;
         StartPercentForm.Progress.Progress := 0;}
         // you have to do this or it won't refresh properly
         startpercentform.ProgressBar1.Max := InMaxVal;
         startpercentform.ProgressBar1.Min := InMinVal;
         startpercentform.ProgressBar1.position := 0;
      end;
   StartPercentForm.Show;
   Application.ProcessMessages;
end;

(* *************************************************************************************************** *)

procedure StartPercentForm_Free;
begin
  if (StartPercentForm <> Nil) then
    StartPercentForm.Free;
  StartPercentForm := Nil;
end;

(* *************************************************************************************************** *)

Procedure StartPercentForm_Update;
var
  _skunk : integer;
begin
  if (StartPercentForm <> Nil) AND (StartPercentForm.Visible = true) then
  begin
    _skunk := StartPercentForm.ProgressBar1.position;
    Inc(_skunk);
    {StartPercentForm.Progress.Progress := _skunk;}
    startpercentform.ProgressBar1.position := 200;
    Application.ProcessMessages;
    startpercentform.ProgressBar1.position := _skunk;
    Application.ProcessMessages;
//    Sleep( 450 );
  end;
end;

(* *************************************************************************************************** *)

procedure StartPercentForm_IncreaseTotal( inInc : integer );
var
  _skunk : integer;
begin
  if (StartPercentForm <> Nil) AND (StartPercentForm.Visible = true) then
  begin
    _skunk := startpercentform.ProgressBar1.max; {StartPercentForm.Progress.MaxValue;}
    Inc(_skunk, inInc);
    startpercentform.ProgressBar1.max := _skunk;
    Application.ProcessMessages;
  end;
end;

(* *************************************************************************************************** *)

end.
