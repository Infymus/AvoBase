 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


unit Preference_FeeEditFormUnit;

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
   toolbox_taxtoolboxunit,
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
  TPref_FeeEditForm = class(TAvoBase_BaseForm_Menu)
    db_amount: TMaskEdit;
    samtLabel: TLabel;
    db_desc: TLabeledEdit;
    db_name: TLabeledEdit;
    orgCombo: TComboBox;
    Label1: TLabel;
    db_active: TCheckBox;
    db_autoinv: TCheckBox;
    db_autoret: TCheckBox;
    Label3: TLabel;
    db_taxclass: TComboBox;
    procedure FeeTypeComboChange(Sender: TObject);
   private
   	fIsNew : boolean;
   	fCloseAction : tFormActions;
      fFeeQuery : tMasterData_BaseDataClass;
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

constructor TPref_FeeEditForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fFeeQuery := inQuery;
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

procedure TPref_FeeEditForm.StartUpForm;
var
	cCount : integer;
   orgName : string;
   cnt : integer;
begin
	db_name.Text := fFeeQuery.GetFieldByname('NAME').AsString;
	db_desc.Text := fFeeQuery.GetFieldByname('DESCR').AsString;
	db_active.checked := fFeeQuery.GetFieldByname('ISACTIVE').AsBoolean;
	db_autoinv.checked := fFeeQuery.GetFieldByname('AUTOINV').AsBoolean;
	db_autoret.checked := fFeeQuery.GetFieldByname('AUTORET').AsBoolean;
   db_amount.Text := FormatFloat('#####0.00', fFeeQuery.GetFieldByName('AMOUNT').AsCurrency);
   //
   Org_ComboBox_FillActiveOrgs( orgCombo );
   orgName := Org_GetOrgNameByOrgID( fFeeQuery.GetFieldByName('ORG_ID').AsString);
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, fFeeQuery.GetFieldByName('TAXID').AsString);
   //
   refresh_form();
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'AUTOINV BOOLEAN, ' + // auto-add to invoice
            'TAX BOOLEAN, ' +  // whether this is a line item taxation on the invoice
            'AMOUNT MONEY',
}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPref_FeeEditForm.Save : boolean;
var
	errMsg : string;
begin
	errMsg := '';

   // check for stuff
   if (db_name.Text = '') then
      errMsg := 'Fee Name cannot be blank.';
   if ( Return_MaskEdit_Curr( db_amount.text)  = 0 ) then
      errMsg := 'Amount cannot be 0.';

   if (errMsg = '') then
   begin
      // transfer all of the field values into the query and save it.
      //
      if (NOT fIsNew) then
         fFeeQuery.Edit();

      //
      fFeeQuery.SetFieldByName('NAME', ProperCase(db_name.Text, true));
      fFeeQuery.SetFieldByName('ISACTIVE', db_active.checked);
      fFeeQuery.SetFieldByName('AUTOINV', db_autoinv.checked);
      fFeeQuery.SetFieldByName('AUTORET', db_autoret.checked);
      fFeeQuery.SetFieldByName('ORG_ID', Org_GetOrgIDByOrgName( orgCombo.Text ));
      fFeeQuery.SetFieldByName('DESCR', ProperCase(db_desc.Text, true));
      fFeeQuery.SetFieldByName('AMOUNT', Return_MaskEdit_Curr(db_amount.text));
      fFeeQuery.SetFieldByName('TAXID', Tax_GetMasterTaxIDByName( db_taxclass.Text ));

      Org_GetOrgIDByOrgName( orgCombo.Text );
      //
      fFeeQuery.Post();
   end else
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);
   //
	result := (errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_FeeEditForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_FeeEditForm.HandleActionExecute(sender: tObject; actionID: integer);
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
      	if AvoBaseDialog('Cancel Fee Changes', 'Are you sure you want to Cancel changes to this Fee?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fFeeQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('Pref_FeeEditForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_FeeEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

procedure TPref_FeeEditForm.refresh_form;
begin
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPref_FeeEditForm.fGetIsNew: boolean;
begin
	result := fIsNew;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_FeeEditForm.fSetIsNew(inValue: boolean);
begin
   fIsNew := inValue;
//   if (NOT fIsNew) then db_name.Enabled := false;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_FeeEditForm.FeeTypeComboChange(Sender: TObject);
begin
   refresh_form();
end;

end.
