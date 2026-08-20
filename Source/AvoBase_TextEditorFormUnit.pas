 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit  AvoBase_TextEditorFormUnit;

interface uses
      constantsunit,
      toolboxunit,
      avobase_dialogformunit,
      IMG_StorageFormUnit,
      toolbox_PreferenceToolBoxUnit,
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
      inifileunit,
      ExtCtrls,
      ComCtrls,
      Mask,
      ActnList,
      Menus,
      OleCtrls,
      SHDocVw,
      ToolWin,
      ImgList,
      StdActns;

type
	tAvoBaseTextEditor = class( tForm )
   	OpenDialog: TOpenDialog;
      SaveDialog: TSaveDialog;
      FontDialog: TFontDialog;
      HTMLMenu: TPopupMenu;
      Cut1: TMenuItem;
      Copy1: TMenuItem;
      Paste1: TMenuItem;
      ColorDialog: TColorDialog;
      FindDialog: TFindDialog;
      FindReplace: TReplaceDialog;
    back_panel: TPanel;
    DBMemo: TRichEdit;
    StatBar: TStatusBar;
    ToolBar1: TToolBar;
    ClearButton: TToolButton;
    LoadButton: TToolButton;
    SaveButton: TToolButton;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure DBMemoClick(Sender: TObject);
      procedure DBMemoChange(Sender: TObject);
      procedure Cut1Click(Sender: TObject);
      procedure Paste1Click(Sender: TObject);
      procedure Copy1Click(Sender: TObject);
      procedure ClearButtonClick(Sender: TObject);
      procedure LoadButtonClick(Sender: TObject);
      procedure SaveButtonClick(Sender: TObject);
	private
      fReadOnly : boolean;
   	fEditorAction : tEditorHandlerEvent;
      Font_Size : Integer;
      Font_Bold : Integer;
      Font_Italic : Integer;
      Font_Underline : Integer;
      Font_StrikeOUt : Integer;
      FormFieldName : String;
      Search_Line : Integer; { What Line it is on }
      Search_Line_Item : Integer; { What Item On What Line It is On }
      procedure fSetText( invalue : string );
      function fGetText : string;
      procedure fSetReadOnly( inVal : boolean );
   public
   	procedure Refresh_EditForm;
      Procedure ClearAll;
      Procedure Call_DBMemo_Stats;
      procedure LoadFromFile( inFileName : string );
      procedure SaveToFile( inFileName : string );
      //
      property OnEditAction : tEditorHandlerEvent READ fEditorAction WRITE fEditorAction;
      property Text : string read fGetText write fSetText;
      property Readonly : boolean read fReadOnly write fSetReadOnly;
      //
      constructor Create( Owner : TComponent; inDockPanel : tPanel ); virtual;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

(* *************************************************************************************************** *)

Constructor tAvoBaseTextEditor.Create( Owner : TComponent; inDockPanel : tPanel);
begin
	inherited Create( owner );
   //
   with DBMemo do
   begin
      Text := '';
      ScrollBars := ssBoth;
      OnChange := DBMemoChange;
   end;
   with Self do
   begin
      ManualDock(inDockPanel, nil, alClient);
      Show();
      BorderStyle := bsNone;
      Left := (Self.Width - inDockPanel.Width) div 2;
      Top := (Self.Height - inDockPanel.Height) div 2;
      //WindowState := wsMaximized; <--- DO NOT USE IT MAKES THE WINDOW FOOBAR
      Anchors := [AkLeft,AkTop,AkRight,AkBottom];
      BorderIcons := [];
      Position := poDefault;
      Align := alClient;
   end;
   Call_DBMemo_Stats();

   // do we show the save and load buttons?
   if ( NOT Pref_GetBoolean(tPrefConstants.EDITSL, true)) then
   begin
      SaveButton.Visible := false;
      LoadButton.Visible := false;
   end;
end;

(* *************************************************************************************************** *)

Destructor tAvoBaseTextEditor.Destroy;
Var
  TempInt : Integer;
begin
  { Destroy The Oject }
  Inherited Destroy;
end;


(* *************************************************************************************************** *)

Procedure tAvoBaseTextEditor.Call_DBMemo_Stats;
Var
  Row : Integer;
  Col : Integer;

  {------------------------------------------------------------------}
  Function  GetTextCursorLoc (Editor : TRichEdit) : TPoint;
  var
    x, y : integer;
  begin
    with Editor do begin
      FillChar (Result, SizeOf (Result), 0);
      y := Perform (em_LineFromChar, wParam (-1), 0);
      if (y < 0) then y := 0 else inc (y);
      x := Perform (em_LineIndex, wParam (-1), 0);
      if (x < 0) then x := 0;
      x := SelStart - x + 1;
      Result.X := x;
      Result.Y := y;
    end;  { with }
  end;
  {------------------------------------------------------------------}

begin
  Col := GetTextCursorLoc(DBMemo).X;
  Row := GetTextCursorLoc(DBMemo).Y;
  StatBar.Panels[0].Text := ' Row ' + IntToStr(Row);
  StatBar.Panels[1].Text := ' Col ' + IntToStr(Col);
  StatBar.Panels[2].Text := ' Lines : ' + IntToSTr(DBMemo.Lines.Count);
  StatBar.Panels[3].Text := ' Size : ' + IntToStr(Length(DBMemo.Text));
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Must be caFree otherwise you get abstract errors. We want the form to go away
  Action := caFree;
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.fSetReadOnly(inVal: boolean);
begin
   fReadOnly := inval;
   if ( fReadOnly ) then
   begin
      ToolBar1.Enabled := False;
      DBMemo.ReadOnly := True;
   end else
      begin
         ToolBar1.Enabled := True;
         DBMemo.ReadOnly := False;
      end;
end;

procedure tAvoBaseTextEditor.fSetText(invalue: string);
begin
   DBMemo.Text := invalue;
   Call_DBMemo_Stats;
end;

function tAvoBaseTextEditor.fGetText: string;
begin
	result := DBMemo.Text;
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.DBMemoClick(Sender: TObject);
begin
  Call_DBMemo_Stats;
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.DBMemoChange(Sender: TObject);
begin
  { Now send a NOTIFY EVENT that a campaign NUMBER has changed }
  if Assigned(fEditorAction) then
    fEditorAction(Self, DBMemo.Text);
  Call_DBMemo_Stats;
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.Cut1Click(Sender: TObject);
begin
  DBMemo.CutToClipboard;
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.Paste1Click(Sender: TObject);
begin
  DBMemo.PasteFromClipBoard;
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.Copy1Click(Sender: TObject);
begin
  DBMemo.CopyToClipboard;
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.Refresh_EditForm;
begin
  // ONLY CALL THIS IF YOU ARE SWITCHING DATABASE RECORDS
//  DBMemo.Text := FormDataSource.Dataset.FieldByName(FORMFIELDNAME).AsString;
end;

(* *************************************************************************************************** *)

procedure tAvoBaseTextEditor.ClearAll;
begin
  DBMemo.Clear;
end;

procedure tAvoBaseTextEditor.ClearButtonClick(Sender: TObject);
begin
  DBMemo.Clear;
end;

procedure tAvoBaseTextEditor.LoadButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    DBMemo.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure tAvoBaseTextEditor.LoadFromFile(inFileName: string);
begin
   dbmemo.WordWrap := false;
   dbmemo.Lines.LoadFromFile( inFileName );
   dbmemo.WordWrap := true;
end;

procedure tAvoBaseTextEditor.SaveButtonClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    DBMemo.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure tAvoBaseTextEditor.SaveToFile(inFileName: string);
begin
   dbmemo.Lines.SaveToFile( inFileName );
end;

END.










