 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_EmailDialogFormUnit;

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
   TEmailDialogForm = class(TForm)
      PCNT_DOCK_PANEL: TPanel;
      PCNT_BACK_PANEL: TPanel;
      HeaderLabel: TLabel;
      imgAvoIcon: TImage;
      ProgressBar: TProgressBar;
    BOT_PANEL: TPanel;
    imgAvoName: TImage;
    Image1: TImage;
    MOPButtonBar: TToolBar;
    OkButton: TToolButton;
    dbMemo: TMemo;
   procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   public
   end;

var
  EmailDialogForm: TEmailDialogForm;

Procedure EmailPercentForm_Create( InString : String; InMinVal, InMaxVal : Integer);
Procedure EmailPercentForm_Memo( InString : String);
procedure EmailPercentForm_IncreaseTotal( inInc : integer );
procedure EmailPercentForm_Finished();
Procedure EmailPercentForm_Update;
Procedure EmailPercentForm_Free;

IMPLEMENTATION

{$R *.DFM}

(* *************************************************************************************************** *)

procedure TEmailDialogForm.FormCreate(Sender: TObject);
begin
   Self.Caption := AVOBASE_NAME;
end;

procedure TEmailDialogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
end;

(* *************************************************************************************************** *)

Procedure EmailPercentForm_Memo( InString : String);
begin
   if ( EmailDialogForm <> NIL ) then
   begin
      emailDialogForm.dbMemo.Lines.Add( inString );
      Application.ProcessMessages;
   end;
end;

(* *************************************************************************************************** *)

procedure EmailPercentForm_Create(InString: String; InMinVal, InMaxVal: Integer);
begin
   if (EmailDialogForm = Nil) then
   	EmailDialogForm := TEmailDialogForm.Create(Application);
   EmailDialogForm.HeaderLabel.Caption := InString;
   if (InMaxVal = 0) then
   begin
      EmailDialogForm.ProgressBar.Visible := false;
      EmailDialogForm.Height := 66;
   end else
   	begin
         emailDialogForm.dbMemo.Text := '';
         emailDialogForm.OkButton.Enabled := false;
         EmailDialogForm.ProgressBar.Max := InMaxVal;
         EmailDialogForm.ProgressBar.Min := InMinVal;
         EmailDialogForm.ProgressBar.position := 0;
      end;
   EmailDialogForm.Show;
   Application.ProcessMessages;
end;

(* *************************************************************************************************** *)

procedure EmailPercentForm_Finished;
begin
   emailDialogForm.HeaderLabel.Caption := 'Email Processing Finished - Please Review.';
   emailDialogForm.OkButton.Enabled := true;
   EmailDialogForm.ProgressBar.Visible := false;
end;

(* *************************************************************************************************** *)

procedure EmailPercentForm_Free;
begin
   if (EmailDialogForm <> Nil) then
      EmailDialogForm.Free;
   EmailDialogForm := Nil;
end;

(* *************************************************************************************************** *)

Procedure EmailPercentForm_Update;
var
  _skunk : integer;
begin
   if (EmailDialogForm <> Nil) AND (EmailDialogForm.Visible = true) then
   begin
      _skunk := EmailDialogForm.ProgressBar.position;
      Inc(_skunk);
      EmailDialogForm.ProgressBar.position := 200;
      Application.ProcessMessages;
      EmailDialogForm.ProgressBar.position := _skunk;
      Application.ProcessMessages;
   end;
end;

(* *************************************************************************************************** *)

procedure EmailPercentForm_IncreaseTotal( inInc : integer );
var
   _skunk : integer;
begin
   if (EmailDialogForm <> Nil) AND (EmailDialogForm.Visible = true) then
   begin
      _skunk := EmailDialogForm.ProgressBar.max; {EmailDialogForm.Progress.MaxValue;}
      Inc(_skunk, inInc);
      EmailDialogForm.ProgressBar.max := _skunk;
      Application.ProcessMessages;
   end;
end;

(* *************************************************************************************************** *)


procedure TEmailDialogForm.OkButtonClick(Sender: TObject);
begin

   Close();
end;

end.