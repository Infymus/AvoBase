 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_FindKeyWebDialogFormUnit;

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
  TAvoBaseWebKeyDialogForm = class(TForm)
    BackPanel: TPanel;
    BOT_PANEL: TPanel;
    imgAvoName: TImage;
    imgAvoIcon: TImage;
    MOPButtonBar: TToolBar;
    OkButton: TToolButton;
    CancelButton: TToolButton;
    STATUS_MESSAGE_BACK_PANEL: TPanel;
    HeaderMsgPanel: TPanel;
    ConfirmImg: TImage;
    InfoImg: TImage;
    ErrorImg: TImage;
    HeaderLabel: TLabel;
    Panel1: TPanel;
    StatusMsg: TLabel;
    Label1: TLabel;
    db_keyfile: TLabeledEdit;
    Label2: TLabel;
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
   private
   	iResult : Integer;
   end;

Function AvoBaseWebKeyDialog() : string;

implementation

{$R *.dfm}

(******************************************************************************************* *)

Function AvoBaseWebKeyDialog() : string;
Var
  AvoDialog : TAvoBaseWebKeyDialogForm;
  formatMsg : string;
  strCnt : integer;
CONST
  Img_Top = 1;
  Img_Left = 1;
  Img_Size = 50;
begin
   AvoDialog := TAvoBaseWebKeyDialogForm.Create(nil);
   Try
      AvoDialog.iResult := 0;
      { Show the Form }
      AvoDialog.ShowModal;
      { Figure Out the Result of the Modal }
      if AvoDialog.iResult = 2 then
         Result := AvoDialog.db_keyfile.Text
      else
         Result := '';
      { Free And Go Away }
   Finally
      FreeAndNil(AvoDialog);
   end;
end;


procedure TAvoBaseWebKeyDialogForm.CancelButtonClick(Sender: TObject);
begin
   Self.iResult := 4;
   Close;
end;

procedure TAvoBaseWebKeyDialogForm.OkButtonClick(Sender: TObject);
begin
   Self.iResult := 2;
   Close;
end;

end.
