 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Avobase_RegisterDialogFormUnit;

interface uses
	img_storageformunit,
   constantsunit,
   toolboxunit,
   //
   avobase_percentformunit,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   Buttons,
   ExtCtrls,
   ComCtrls,
   ToolWin,
   jpeg,
   themes,
   ShellAPI,
   pngimage;

type
   tAvoBaseRegisterDialogForm = class(TForm)
      BackPanel: TPanel;
      BOT_PANEL: TPanel;
      imgAvoName: TImage;
      imgAvoIcon: TImage;
      MOPButtonBar: TToolBar;
      VisitAvoBaseButton: TToolButton;
      RegisterAvoBaseButton: TToolButton;
      CancelButton: TToolButton;
      STATUS_MESSAGE_BACK_PANEL: TPanel;
    ToolButton1: TToolButton;
    Panel2: TPanel;
    HeaderLabel: TLabel;
    lockImage: TImage;
    text_back_panel: TPanel;
    Panel1: TPanel;
    StatusMsg: TLabel;
      //
      procedure VisitAvoBaseButtonClick(Sender: TObject);
      procedure RegisterAvoBaseButtonClick(Sender: TObject);
      procedure CancelButtonClick(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure MOPButtonBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
   private
   	iResult : Integer;
   end;

// outside the scope of this object so it can be called anywhere.

Function AvoBaseNagDonate() : tmsgDlgBtn;
Function AvoBaseRegisterDialog( inMsg : string ) : tmsgDlgBtn;

implementation

{$R *.dfm}

(******************************************************************************************* *)

Function AvoBaseRegisterDialog( inMsg : string ) : tmsgDlgBtn;
begin
end;

Function AvoBaseNagDonate() : tmsgDlgBtn;
Var
  AvoDialog : tAvoBaseRegisterDialogForm;
  formatMsg : string;
  strCnt : integer;
CONST
  Img_Top = 1;
  Img_Left = 1;
  Img_Size = 50;
begin
   PercentForm_Free();
   // format the string
   formatMsg := 'I appreciate that you have taken the time to download, install and use AvoBase.\n\nDonations help to ' +
      'ensure that AvoBase is properly maintained, updated and as bug-free as possible.\n\nPlease visit AvoBase.com ' +
      'to view more information on AvoBase and donation options.\n\nAgain, thank you for using AvoBase!';

   while POS('\n', formatMsg) > 0 do
   begin
      strCnt := POS('\n', formatMsg);
      delete( formatMsg, strCnt, 2);
      insert( #13, formatMsg, strCnt );
   end;
   //
   AvoDialog := tAvoBaseRegisterDialogForm.Create(nil);
   Try
      AvoDialog.iResult := 0;
      AvoDialog.StatusMsg.WordWrap := False;
      AvoDialog.StatusMsg.Caption := formatMsg;
      AvoDialog.StatusMsg.WordWrap := True;
      AvoDialog.HeaderLabel.Caption := 'Donate To AvoBase';

      { Show the Form }
      AvoDialog.ShowModal;
      { Figure Out the Result of the Modal }
      if AvoDialog.iResult = 1 then
         Result := mbYes;
      if AvoDialog.iResult = 3 then
         Result := mbNo;
      if AvoDialog.iResult = 2 then
         Result := mbOk;
      if AvoDialog.iResult = 4 then
         Result := mbCancel;
      { Free And Go Away }
   Finally
      FreeAndNil(AvoDialog);
   end;
end;

(******************************************************************************************* *)

procedure tAvoBaseRegisterDialogForm.VisitAvoBaseButtonClick(Sender: TObject);
   function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
   begin
     Result := ShellExecute(Application.MainForm.Handle, nil, PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
   end;
begin
   ExecuteFile(AVOBASE_WEBSITE, '', '', 0);
   Self.iResult := 1;
   Close;
end;

procedure tAvoBaseRegisterDialogForm.RegisterAvoBaseButtonClick(Sender: TObject);
   function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
   begin
     Result := ShellExecute(Application.MainForm.Handle, nil, PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
   end;
begin
   ExecuteFile(AVOBASE_PURCHASE, '', '', 0);
   Self.iResult := 2;
   Close;
end;

procedure tAvoBaseRegisterDialogForm.CancelButtonClick(Sender: TObject);
begin
  Self.iResult := 4;
  Close;
end;

(******************************************************************************************* *)

procedure tAvoBaseRegisterDialogForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  X : Integer;
begin
  x := Ord(KEY);
  case ORD(KEY) of
    { YES }
    89,121:
    begin
      Self.iResult := 1;
      Close;
    end;
    { NO }
    78,110:
    begin
      Self.iResult := 3;
      Close;
    end;
    { CANCEL }
    67,99:
    begin
      Self.iResult := 4;
      Close;
    end;
    { OK }
    79,111,13:
    begin
      Self.iResult := 2;
      Close;
    end;
  end;
end;

procedure tAvoBaseRegisterDialogForm.MOPButtonBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
var
	eleDetail : tThemedElementDetails;
begin
   exit;
	if (ThemeServices.ThemesEnabled) then
   begin
   	eleDetail := ThemeServices.GetElementDetails(trRebarRoot);
      ThemeServices.DrawElement(Sender.Canvas.Handle, eleDetail, Sender.ClientRect);
      ThemeServices.DrawElement(Self.Canvas.Handle, eleDetail, Sender.ClientRect);
   end;
end;



end.
