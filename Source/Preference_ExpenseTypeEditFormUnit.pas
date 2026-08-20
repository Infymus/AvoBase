 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_ExpenseTypeEditFormUnit;

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
   toolbox_orgtoolboxunit,
   errorresultunit,
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
   Buttons;

type
  TPref_ExpenseTypeEditForm = class(TAvoBase_BaseForm_Menu)
    db_desc: TLabeledEdit;
    db_name: TLabeledEdit;
    orgCombo: TComboBox;
    db_active: TCheckBox;
    Label1: TLabel;
    db_autoinv: TCheckBox;
    db_taxdeduct: TCheckBox;
   private
   	fIsNew : boolean;
   	fCloseAction : tFormActions;
      fExpenseTypeQuery : tMasterData_BaseDataClass;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure StartUpForm();
      procedure fSetIsNew( inValue : boolean );
      function fGetIsNew : boolean;
   public
      function Save : boolean;
   	property CloseAction : tFormActions read fCloseAction;
      property IsNew : boolean read fGetIsNew write fSetIsNew;
      procedure refresh_form;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;


implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TPref_ExpenseTypeEditForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fExpenseTypeQuery := inQuery;
   //
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SAVE );
   //
	StartUpForm();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ExpenseTypeEditForm.StartUpForm;
var
	cCount : integer;
   orgName : string;
   cnt : integer;
begin
	db_name.Text := fExpenseTypeQuery.GetFieldByname('NAME').AsString;
	db_desc.Text := fExpenseTypeQuery.GetFieldByname('DESCR').AsString;
	db_active.checked := fExpenseTypeQuery.GetFieldByname('ISACTIVE').AsBoolean;
	db_autoinv.checked := fExpenseTypeQuery.GetFieldByname('AUTOA').AsBoolean;
   db_taxdeduct.checked := fExpenseTypeQuery.GetFieldByname('TAXDED').AsBoolean;
   //
   Org_ComboBox_FillActiveOrgs( orgCombo );
   orgName := Org_GetOrgNameByOrgID( fExpenseTypeQuery.GetFieldByName('ORG_ID').AsString);
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;
   //
   refresh_form();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
         retVal := masterData.AddTable(masterData.dbPath + table_expense_type,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40),' + // organization
            'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
            'DESCR VARCHAR(40)',
}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPref_ExpenseTypeEditForm.Save : boolean;
var
	errMsg : string;
begin
	errMsg := '';

   // check for stuff
   if (db_name.Text = '') then
      errMsg := 'Expense Type Name cannot be blank.';

   if (errMsg = '') then
   begin
      // transfer all of the field values into the query and save it.
      //
      if (NOT fIsNew) then
         fExpenseTypeQuery.Edit();
      //
      fExpenseTypeQuery.SetFieldByName('NAME', ProperCase(db_name.Text, true));
      fExpenseTypeQuery.SetFieldByName('ISACTIVE', db_active.checked);
      fExpenseTypeQuery.SetFieldByName('AUTOA', db_autoinv.checked);
      fExpenseTypeQuery.SetFieldByName('TAXDED', db_taxdeduct.Checked);
      fExpenseTypeQuery.SetFieldByName('ORG_ID', Org_GetOrgIDByOrgName( orgCombo.Text ));
      fExpenseTypeQuery.SetFieldByName('DESCR', ProperCase(db_desc.Text, true));

      Org_GetOrgIDByOrgName( orgCombo.Text );
      //
      fExpenseTypeQuery.Post();
   end else
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);
   //
	result := (errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ExpenseTypeEditForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ExpenseTypeEditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SAVE :
      begin
         if (Save) then
         begin
         	fCloseAction := actionSave;
            CloseForm();
         end;
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel Expense Type Changes', 'Are you sure you want to Cancel changes to this Expense Type?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fExpenseTypeQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('Pref_ExpenseTypeEditForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ExpenseTypeEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ExpenseTypeEditForm.refresh_form;
begin
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPref_ExpenseTypeEditForm.fGetIsNew: boolean;
begin
	result := fIsNew;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ExpenseTypeEditForm.fSetIsNew(inValue: boolean);
begin
   fIsNew := inValue;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



end.
