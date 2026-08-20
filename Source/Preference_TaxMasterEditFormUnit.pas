 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_TaxMasterEditFormUnit;

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
   toolbox_taxtoolboxunit,
   errorresultunit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
   dbtables,
   db,
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
  TPref_TaxMasterEditForm = class(TAvoBase_BaseForm_Menu)
    db_active: TCheckBox;
    db_name: TLabeledEdit;
    db_desc: TLabeledEdit;
    procedure FormShow(Sender: TObject);
   private
   	fIsNew : boolean;
   	fCloseAction : tFormActions;
      fTaxMasterQuery : tMasterData_BaseDataClass;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure SaveData();
      procedure StartUpForm();
      procedure fSetIsNew( inValue : boolean );
      function fGetIsNew : boolean;
      function Save : boolean;
      function fGetID : string;
   public
   	property CloseAction : tFormActions read fCloseAction;
      property IsNew : boolean read fGetIsNew write fSetIsNew;
      property ID : string read fGetID;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

{ tPreferenceEditForm }

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TPref_TaxMasterEditForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fTaxMasterQuery := inQuery;
   //
	StartUpForm();
end;

function TPref_TaxMasterEditForm.fGetID: string;
begin
   result := fTaxMasterQuery.GetFieldByName('ID').AsString;
end;

function TPref_TaxMasterEditForm.fGetIsNew: boolean;
begin
	result := fIsNew;
end;

procedure TPref_TaxMasterEditForm.FormShow(Sender: TObject);
begin
   inherited;
   db_name.SetFocus();
end;

procedure TPref_TaxMasterEditForm.fSetIsNew(inValue: boolean);
begin
   fIsNew := inValue;
{
   if (NOT fIsNew) then
   	db_name.Enabled := false;
}
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxMasterEditForm.SaveData;
begin
   // transfer all of the field values into the query and save it.
   //
   if (NOT fIsNew) then
      fTaxMasterQuery.Edit()
   else
      fTaxMasterQuery.Append();
   //
	fTaxMasterQuery.SetFieldByName('NAME', ProperCase(db_name.Text, true));
	fTaxMasterQuery.SetFieldByName('ISACTIVE', db_active.checked);
	fTaxMasterQuery.SetFieldByName('DESCR', ProperCase(db_desc.Text, true));
   //
	fTaxMasterQuery.Post();
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxMasterEditForm.StartUpForm;
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
	db_name.Text := fTaxMasterQuery.GetFieldByname('NAME').AsString;
	db_active.checked := fTaxMasterQuery.GetFieldByname('ISACTIVE').AsBoolean;
   db_desc.Text := fTaxMasterQuery.GetFieldByname('DESCR').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxMasterEditForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPref_TaxMasterEditForm.Save : boolean;
var
	errMsg : string;
begin
	errMsg := '';

   // check for stuff
   if (db_name.Text = '') then
      errMsg := 'Tax Group Name cannot be blank.';
   if (fIsNew) AND ( Tax_MasterTaxExitsByName( db_name.text )) then
      errMsg := 'A Tax Group already exists with that name.';

   if (errMsg <> '') then
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);
   //
	result := (errMsg = '');
end;
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxMasterEditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SAVE :
      begin
         if (Save) then
         begin
         	fCloseAction := actionSave;
            SaveData();
            CloseForm();
         end;
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel Tax Group Changes', 'Are you sure you want to Cancel changes to this Tax Group?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fTaxMasterQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('Pref_TaxMasterEditForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxMasterEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
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
