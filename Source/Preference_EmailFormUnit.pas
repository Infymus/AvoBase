 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_EmailFormUnit;


interface uses
   preference_baseformunit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   toolbox_preferencetoolboxunit,
   inifileunit,
   avobase_toolbarunit,
	actionunit,
   AvoBase_HelpFormUnit,
   AvoBase_CodeTextEditorFormUnit,
   //
   windows,
   messages,
   sysutils,
   variants,
   classes,
   graphics,
   controls,
   forms,
   dialogs,
   db,
   extctrls,
   stdctrls,
   FileCtrl,
   mask,
   jpeg,
   buttons,
   ComCtrls,
   TabNotBk;

type
   tPref_EmailSettingsForm = class(TPrefBaseForm)
      BASE_NAVBAR_PANEL: TPanel;
      NoteBook: TNotebook;
      MAIN_DOCK_PANEL: TPanel;
      SettingsGroupBox: TGroupBox;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label6: TLabel;
      Label8: TLabel;
      db_remail: TEdit;
      db_smtpuser: TEdit;
      db_smtps: TEdit;
      db_smtppw: TEdit;
      db_smtpf: TEdit;
      db_smtport: TMaskEdit;
      db_smtpauthtype: TComboBox;
      showPWText: TCheckBox;
    GroupBox1: TGroupBox;
    ORDER_DOCK_PANEL: TPanel;
    GroupBox2: TGroupBox;
    RETURN_DOCK_PANEL: TPanel;
      procedure FormCreate(Sender: TObject);
      procedure showPWTextClick(Sender: TObject);
   private
      OrdTextEditor : TAvoBase_CodeTextEditor;
      RetTextEditor : TAvoBase_CodeTextEditor;

      procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      ExpenseTypeGridToolBar : tAvoBaseToolBar;
      //
      procedure GlobalRefreshEvent();
      procedure Save();
      destructor destroy; override;
  end;

Procedure Preference_EmailSettings;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

Procedure Preference_EmailSettings;
var
   PrefForm : TPref_EmailSettingsForm;
begin
   PrefForm := TPref_EmailSettingsForm.Create(nil, PREF_EMAILSETTINGS );
   //
   with PrefForm do
   begin
      BASE_NAVBAR_PANEL.Visible := true;
      height := height + BASE_NAVBAR_PANEL.Height;
      // just so the menu always is at the top
      SettingsGroupBox.Align := albottom;
      SettingsGroupBox.Align := altop;
      // now make the menu
      ExpenseTypeGridToolBar.CreateButtonSep();
      ExpenseTypeGridToolBar.CreateButton( CMD_CLOSE );
      Border := 1;
   end;
   PrefForm.ShowModal();
   PrefForm.Save();
   FreeAndNil(PrefForm);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_EmailSettingsForm.FormCreate(Sender: TObject);
begin
   inherited;
   //
   {
   height := height - BASE_NAVBAR_PANEL.Height;
   BASE_NAVBAR_PANEL.Visible := false;
   }
   db_smtps.Text := Pref_GetString(tPrefConstants.SMTPS, '');
   db_smtpuser.Text := Pref_GetString(tPrefConstants.SMTPUSER, '');
   db_SMTPPW.Text := Pref_GetString(tPrefConstants.SMTPPW,'');
   db_SMTPF.Text := Pref_GetString(tPrefConstants.SMTPF,'');
   db_REMAIL.Text := Pref_GetString(tPrefConstants.RepEmail,'');
   db_SMTPORT.Text := IntToStr(Pref_GetInteger(tPrefConstants.SMTPORT,0));
   // tIDSMTP_AuthType ( 0 = satDefault, 1 = None, 2 = satSASL );
   db_smtpauthtype.ItemIndex := Pref_GetInteger(tPrefConstants.SMTPAUTHTYPE,0);
   //
   NoteBook.ActivePage := 'MAIN';
   ExpenseTypeGridToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   ExpenseTypeGridToolBar.actionList.OnUpdate := HandleActionListUpdate;
   ExpenseTypeGridToolBar.actionList.onActionEvent := HandleActionExecute;
   ExpenseTypeGridToolBar.Align := alClient;
   ExpenseTypeGridToolBar.CreateButton( CMD_HELP );
   ExpenseTypeGridToolBar.CreateButtonSep();
   ExpenseTypeGridToolBar.CreateButton( CMD_PREF_EMAIL_RETURN );
   ExpenseTypeGridToolBar.CreateButton( CMD_PREF_EMAIL_ORDER );
   ExpenseTypeGridToolBar.CreateButton( CMD_PREF_EMAIL_MAIN );
   //
   OrdTextEditor := TAvoBase_CodeTextEditor.Create(nil, ORDER_DOCK_PANEL);
   RetTextEditor := TAvoBase_CodeTextEditor.Create(nil, RETURN_DOCK_PANEL);
   OrdTextEditor.Text := Pref_GetMemo(tPrefConstants.SMTPORDMSG,'');
   RetTextEditor.Text := Pref_GetMemo(tPrefConstants.SMTPRETMSG,'');
end;

destructor tPref_EmailSettingsForm.destroy;
begin
   FreeAndNil(OrdTextEditor);
   FreeAndNil(RetTextEditor);
   FreeAndNil(ExpenseTypeGridToolBar);
   inherited;
end;

procedure TPref_EmailSettingsForm.GlobalRefreshEvent;
begin
   //
end;

procedure TPref_EmailSettingsForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
   	CMD_HELP : AvoBaseHelp_Execute('Pref_EmailSettingsForm');
      CMD_CLOSE: Close();
      CMD_PREF_EMAIL_MAIN: NoteBook.ActivePage := 'MAIN';
      CMD_PREF_EMAIL_ORDER: NoteBook.ActivePage := 'ORDER';
      CMD_PREF_EMAIL_RETURN: NoteBook.ActivePage := 'RETURN';
   end;
end;

procedure TPref_EmailSettingsForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;
end;

procedure TPref_EmailSettingsForm.Save;
begin
   Pref_Set(tPrefConstants.SMTPS, db_smtps.text);
   Pref_Set(tPrefConstants.SMTPUSER, db_smtpuser.text);
   Pref_Set(tPrefConstants.SMTPPW, db_SMTPPW.text);
   Pref_Set(tPrefConstants.SMTPF, db_SMTPF.text);
   Pref_Set(tPrefConstants.RepEmail, db_REMAIL.text);
   Pref_Set(tPrefConstants.SMTPORT, Return_MaskEdit_Int(db_SMTPORT.text));
   Pref_Set(tPrefConstants.SMTPAUTHTYPE, db_smtpauthtype.ItemIndex);
   Pref_SetMemo(tPrefConstants.SMTPORDMSG, OrdTextEditor.Text );
   Pref_SetMemo(tPrefConstants.SMTPRETMSG, RetTextEditor.Text );
end;

{
            'SMTPORDMSG BLOB(240,1), ' + // smtp ORDER message
            'SMTPRETMSG BLOB(240,1), ' + // smtp RETURN message
}

procedure tPref_EmailSettingsForm.showPWTextClick(Sender: TObject);
begin
   if ( showPWText.Checked ) then
      db_smtppw.PasswordChar := #0
   else
      db_smtppw.PasswordChar := #42;
end;

end.


