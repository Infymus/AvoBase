 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_OrganizationsEditFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   toolbox_PreferenceToolBoxUnit,
   masterdata_BaseDataClassUnit,
   errorresultunit,
   AvoBase_TextEditorFormUnit,
   toolbox_orgtoolboxunit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
   dbtables,
   sysutils,
   variants,
   classes,
   ActnList,
   graphics,
   controls,
   forms,
   dialogs,
   stdctrls,
   extctrls,
   ComCtrls,
   ToolWin,
   Mask,
   Buttons,
   Tabs,
   TabNotBk;

type
	tPreference_OrgEditForm = class(TAvoBase_BaseForm_Menu)
    db_active: TCheckBox;
    db_name: TLabeledEdit;
    db_desc: TLabeledEdit;
    db_acc: TLabeledEdit;
    db_iheadd: TLabeledEdit;
    db_cycles: TComboBox;
    Label2: TLabel;
    InvMsgNoteBook: TTabbedNotebook;
    INVOICE_MSG_DOCK_PANEL: TPanel;
    INVOICE_CANCEL_MSG_DOCK_PANEL: TPanel;
    prod_dock: TPanel;
    InvoiceLineSettings: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    db_PRODN1: TMaskEdit;
    Label3: TLabel;
    db_PRODN2: TMaskEdit;
    Label4: TLabel;
    db_PRODN3: TMaskEdit;
    Label6: TLabel;
    db_PRODN4: TMaskEdit;
    db_CNAME: TLabeledEdit;
   private
   	fIsNew : boolean;
   	fCloseAction : tFormActions;
      fOrgQuery : tMasterData_BaseDataClass;
      InvMsgTextEditor : tAvoBaseTextEditor;
      InvCancelMsgTextEditor : tAvoBaseTextEditor;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure SaveData();
      procedure StartUpForm();
      procedure fSetIsNew( inValue : boolean );
      function fGetIsNew : boolean;
      function Save : boolean;
   public
   	property CloseAction : tFormActions read fCloseAction;
      property IsNew : boolean read fGetIsNew write fSetIsNew;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;


implementation

{$R *.dfm}

{ tPreferenceEditForm }

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tPreference_OrgEditForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fOrgQuery := inQuery;
   //
	StartUpForm();
end;

function tPreference_OrgEditForm.fGetIsNew: boolean;
begin
	result := fIsNew;
end;

procedure tPreference_OrgEditForm.fSetIsNew(inValue: boolean);
begin
   fIsNew := inValue;
{
   if (NOT fIsNew) then
   	db_name.Enabled := false;
   if (fIsNew) then
   	db_name.SetFocus()
}
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPreference_OrgEditForm.SaveData;
begin
   // transfer all of the field values into the query and save it.
   //
   if (NOT fIsNew) then
      fOrgQuery.Edit();

   //
{ old way with proper casing:
	fOrgQuery.SetFieldByName('NAME', ProperCase(db_name.Text, true));
	fOrgQuery.SetFieldByName('ACC', ProperCase(db_acc.Text, true));
	fOrgQuery.SetFieldByName('DESCR', ProperCase(db_desc.Text, true));
	fOrgQuery.SetFieldByName('IHEADD', ProperCase(db_iheadd.Text, true));
	fOrgQuery.SetFieldByName('ISACTIVE', db_active.checked);
	fOrgQuery.SetFieldByName('IMSG', InvMsgTextEditor.Text);
	fOrgQuery.SetFieldByName('CYCLES', db_cycles.ItemIndex + 1);
	fOrgQuery.SetFieldByName('ICNCLMSG', InvCancelMsgTextEditor.Text);
}
	fOrgQuery.SetFieldByName('NAME', db_name.Text);
	fOrgQuery.SetFieldByName('ACC', db_acc.Text);
	fOrgQuery.SetFieldByName('DESCR', db_desc.Text);
	fOrgQuery.SetFieldByName('IHEADD', db_iheadd.Text);
	fOrgQuery.SetFieldByName('ISACTIVE', db_active.checked);
	fOrgQuery.SetFieldByName('IMSG', InvMsgTextEditor.Text);
	fOrgQuery.SetFieldByName('CYCLES', db_cycles.ItemIndex + 1);
	fOrgQuery.SetFieldByName('ICNCLMSG', InvCancelMsgTextEditor.Text);
	fOrgQuery.SetFieldByName('PRODN1', db_PRODN1.Text);
	fOrgQuery.SetFieldByName('PRODN2', db_PRODN2.Text);
	fOrgQuery.SetFieldByName('PRODN3', db_PRODN3.Text);
	fOrgQuery.SetFieldByName('PRODN4', db_PRODN4.Text);
   fOrgQuery.SetFieldByName('CNAME', db_CNAME.Text );

   //
	fOrgQuery.Post();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.
          'ID VARCHAR(40), ' +
          'ISACTIVE BOOLEAN, ' +
          'NAME VARCHAR(50), ' +
          'INAME VARCHAR(50), ' +
          'DESCR VARCHAR(200), ' +
          'ACC VARCHAR(50), ' +
          'IHEADD VARCHAR(50), ' + // invoice header display
          'CYCLES INTEGER, ' + // # of cycles per year
          'IMSG VARCHAR(200), ' + // specific invoice message
          'ICNCLMSG BLOB(240,1)', // cancellation message
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPreference_OrgEditForm.StartUpForm;
var
	cCount : integer;
begin
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SAVE );
   //
   //Self.Width := 1024;
   //Self.Height := 768;
   //
	db_name.Text := fOrgQuery.GetFieldByname('NAME').AsString;
   db_desc.Text := fOrgQuery.GetFieldByname('DESCR').AsString;
	db_iheadd.Text := fOrgQuery.GetFieldByname('IHEADD').AsString;
   db_acc.Text := fOrgQuery.GetFieldByname('ACC').AsString;
	db_active.checked := fOrgQuery.GetFieldByname('ISACTIVE').AsBoolean;

   db_PRODN1.Text := fOrgQuery.GetFieldByname('PRODN1').AsString;
   db_PRODN2.Text := fOrgQuery.GetFieldByname('PRODN2').AsString;
   db_PRODN3.Text := fOrgQuery.GetFieldByname('PRODN3').AsString;
   db_PRODN4.Text := fOrgQuery.GetFieldByname('PRODN4').AsString;
   db_CNAME.Text := fOrgQuery.GetFieldByName('CNAME').AsString;
   //
   InvMsgTextEditor := tAvoBaseTextEditor.Create(nil, INVOICE_MSG_DOCK_PANEL);
   InvMsgTextEditor.Text := fOrgQuery.GetFieldByName('IMSG').AsString;
   //
   InvCancelMsgTextEditor := tAvoBaseTextEditor.Create(nil, INVOICE_CANCEL_MSG_DOCK_PANEL);
   InvCancelMsgTextEditor.Text := fOrgQuery.GetFieldByName('ICNCLMSG').AsString;
   //
   db_cycles.Clear();
   for cCount := 1 to MAX_SALES_CYCLES do
   	db_cycles.Items.Add( IntToStr(cCount) );
   db_cycles.ItemIndex := (fOrgQuery.GetFieldByName('CYCLES').AsInteger - 1);
   if ( db_cycles.ItemIndex = -1 ) then
      db_cycles.ItemIndex := 0;
   //
   InvMsgNoteBook.ActivePage := 'Invoice Message';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPreference_OrgEditForm.CloseForm;
begin
	FreeAndNil(InvCancelMsgTextEditor);
	FreeAndNil(InvMsgTextEditor);
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tPreference_OrgEditForm.Save : boolean;
var
   errMsg : string;
begin
   errMsg := '';
   if (fIsNew) then
      if (Org_OrgExitsByName(db_name.text)) then
         errMsg := 'The Organization Name already exists. Please choose a different Name.';
   if (db_iheadd.text = '') then
      errMsg := 'The Invoice Header Caption cannot be blank.';
   if (db_name.text = '') then
      errMsg := 'The Organization Name cannot be blank.';
   //
   if (errMsg <> '') then
      AvoBaseDialog('Unable To Save', errMsg, mtError, [mbOk], 0);
   result := ( errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPreference_OrgEditForm.HandleActionExecute(sender: tObject; actionID: integer);
var
	canSave : boolean;
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SAVE :
      begin
         if (Save) then
         begin
            SaveData();
         	fCloseAction := actionSave;
            CloseForm();
         end;
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel Organization Changes', 'Are you sure you want to Cancel changes to this Organization?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fOrgQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('Preference_OrgEditForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPreference_OrgEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
