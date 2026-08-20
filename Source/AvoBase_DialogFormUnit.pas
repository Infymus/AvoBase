 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

 { EXAMPLES:

if AvoBaseDialog('HEADER_MESSAGE', 'BODY_MESSAGE',
   mtConfirmation, [mbYes, mbNo], 0) = mbyes then

   Types:   mtWarning   mtError   mtInformation   mtConfirmation

   Buttons:   mbYes   mbNo   mbOk   mbCancel
 }

unit avobase_dialogformunit;

interface uses
	img_storageformunit,
   constantsunit,
   toolboxunit,
   //
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
   pngimage;

type
	tAvoBaseDialogForm = class( tForm )
      BackPanel: TPanel;
      BOT_PANEL: TPanel;
      CancelButton: TToolButton;
      MOPButtonBar: TToolBar;
      NoButton: TToolButton;
      OkButton: TToolButton;
      STATUS_MESSAGE_BACK_PANEL: TPanel;
      YesButton: TToolButton;
    HeaderMsgPanel: TPanel;
    ConfirmImg: TImage;
    InfoImg: TImage;
    WarningImg: TImage;
    ErrorImg: TImage;
    imgAvoName: TImage;
    imgAvoIcon: TImage;
    HeaderLabel: TLabel;
    back_panel_spacing: TPanel;
    scroll_box: TScrollBox;
    StatusMsg: TLabel;
    padding_panel: TPanel;
      procedure YesButtonClick(Sender: TObject);
      procedure OkButtonClick(Sender: TObject);
      procedure NoButtonClick(Sender: TObject);
      procedure CancelButtonClick(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure MOPButtonBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
   private
   	iResult : Integer;
   end;

// outside the scope of this object so it can be called anywhere.
Function AvoBaseDialog(InHeader,InMsg:String; DlgType:tMsgDlgType; DlgButtons:tMsgDlgButtons; HelpNum:Integer ) : TMsgDlgBtn;

implementation

{$R *.dfm}

(******************************************************************************************* *)

Function AvoBaseDialog(InHeader,InMsg:String; DlgType:tMsgDlgType; DlgButtons:tMsgDlgButtons; HelpNum:Integer ) : TMsgDlgBtn;
Var
  AvoDialog : tAvoBaseDialogForm;
  formatMsg : string;
  strCnt : integer;
  h : integer;
CONST
  Img_Top = 1;
  Img_Left = 1;
  Img_Size = 50;
begin
   // format the string
   formatMsg := InMsg;
   while POS('\n', formatMsg) > 0 do
   begin
      strCnt := POS('\n', formatMsg);
      delete( formatMsg, strCnt, 2);
      insert( #13, formatMsg, strCnt );
   end;
   //
   AvoDialog := tAvoBaseDialogForm.Create(nil);
   Try
      AvoDialog.iResult := 0;
      { Header Message }
      AvoDialog.HeaderLabel.Caption := InHeader;
      { Set the AvoBase Caption Form }
      Case DlgType of
         mtWarning : AvoDialog.Caption := 'AvoBase - Warning';
         mtError : AvoDialog.Caption := 'AvoBase - Error';
         mtInformation : AvoDialog.Caption := 'AvoBase - Information';
         mtConfirmation : AvoDialog.Caption := 'AvoBase - Confirmation';
      end;
      { Set the Dialog }
      AvoDialog.ErrorImg.Visible := False;
      AvoDialog.WarningImg.Visible := False;
      AvoDialog.InfoImg.Visible := False;
      AvoDialog.ConfirmImg.Visible := False;
      //
      Case DlgType of
         mtWarning :
         begin
            AvoDialog.WarningImg.Visible := True;
            AvoDialog.WarningImg.Top := Img_Top;
            AvoDialog.WarningImg.Left := Img_Left;
            AvoDialog.WarningImg.Width := Img_Size;
            AvoDialog.WarningImg.Height := Img_Size;
         end;
         mtError :
         begin
            AvoDialog.ErrorImg.Visible := True;
            AvoDialog.ErrorImg.Top := Img_Top;
            AvoDialog.ErrorImg.Left := Img_Left;
            AvoDialog.ErrorImg.Width := Img_Size;
            AvoDialog.ErrorImg.Height := Img_Size;
         end;
         mtInformation :
         begin
            AvoDialog.InfoImg.Visible := True;
            AvoDialog.InfoImg.Top := Img_Top;
            AvoDialog.InfoImg.Left := Img_Left;
            AvoDialog.InfoImg.Width := Img_Size;
            AvoDialog.InfoImg.Height := Img_Size;
         end;
         mtConfirmation :
         begin
            AvoDialog.ConfirmImg.Visible := True;
            AvoDialog.ConfirmImg.Top := Img_Top;
            AvoDialog.ConfirmImg.Left := Img_Left;
            AvoDialog.ConfirmImg.Width := Img_Size;
            AvoDialog.ConfirmImg.Height := Img_Size;
         end;
      end;
      { Turn On Whatever Buttons Are Necessary }
      if (mbYes in DlgButtons) then
         AvoDialog.YesButton.Visible := True
      else
         AvoDialog.YesButton.Visible := False;
      //
      if (mbNo in DlgButtons) then
         AvoDialog.NoButton.Visible := True
      else
         AvoDialog.NoButton.Visible := False;
      //
      if (mbCancel in DlgButtons) then
         AvoDialog.CancelButton.Visible := True
      else
         AvoDialog.CancelButton.Visible := False;
      //
      if (mbOK in DlgButtons) then
         AvoDialog.OkButton.Visible := True
      else
         AvoDialog.OkButton.Visible := False;
      { Display the Message in the Caption }
      AvoDialog.StatusMsg.WordWrap := False;
      AvoDialog.StatusMsg.Caption := formatMsg;
      AvoDialog.StatusMsg.WordWrap := True;
      AvoDialog.scroll_box.VertScrollBar.Range := AvoDialog.StatusMsg.BoundsRect.Bottom;
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

procedure TAvoBaseDialogForm.YesButtonClick(Sender: TObject);
begin
  Self.iResult := 1;
  Close;
end;

procedure TAvoBaseDialogForm.OkButtonClick(Sender: TObject);
begin
  Self.iResult := 2;
  Close;
end;

procedure TAvoBaseDialogForm.NoButtonClick(Sender: TObject);
begin
  Self.iResult := 3;
  Close;

end;

procedure TAvoBaseDialogForm.CancelButtonClick(Sender: TObject);
begin
  Self.iResult := 4;
  Close;
end;

(******************************************************************************************* *)

procedure TAvoBaseDialogForm.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TAvoBaseDialogForm.MOPButtonBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
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

