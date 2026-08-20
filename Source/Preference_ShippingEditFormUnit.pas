 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_ShippingEditFormUnit;

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
  TPref_ShippingEditForm = class(TAvoBase_BaseForm_Menu)
      db_samt: TMaskEdit;
      samtLabel: TLabel;
      db_eamt: TMaskEdit;
      eamtLabel: TLabel;
      db_rate: TMaskEdit;
      rateLabel: TLabel;
      db_name: TLabeledEdit;
      db_active: TCheckBox;
      db_desc: TLabeledEdit;
      orgCombo: TComboBox;
      Label1: TLabel;
      Label2: TLabel;
      shippingTypeCombo: TComboBox;
      db_amount: TMaskEdit;
      shippingAmountLabel: TLabel;
      pcntLabel: TLabel;
      db_taxclass: TComboBox;
      Label3: TLabel;
      procedure shippingTypeComboChange(Sender: TObject);
   private
   	fIsNew : boolean;
   	fCloseAction : tFormActions;
      fShippingQuery : tMasterData_BaseDataClass;
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

constructor TPref_ShippingEditForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fShippingQuery := inQuery;
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
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ShippingEditForm.StartUpForm;
var
	cCount : integer;
   orgName : string;
   cnt : integer;
begin
	db_name.Text := fShippingQuery.GetFieldByname('NAME').AsString;
	db_active.checked := fShippingQuery.GetFieldByname('ISACTIVE').AsBoolean;
   db_desc.Text := fShippingQuery.GetFieldByname('DESCR').AsString;
   db_samt.Text := FormatFloat('#####0.00', fShippingQuery.GetFieldByName('SAMT').AsCurrency);
   db_eamt.Text := FormatFloat('#####0.00', fShippingQuery.GetFieldByName('EAMT').AsCurrency);
   db_rate.Text := FormatFloat('#0.00', fShippingQuery.GetFieldByName('PCNT').AsCurrency);
   db_amount.Text := FormatFloat('#####0.00', fShippingQuery.GetFieldByName('RATE').AsCurrency);
   //
   Org_ComboBox_FillActiveOrgs( orgCombo );
   orgName := Org_GetOrgNameByOrgID( fShippingQuery.GetFieldByName('ORG_ID').AsString);
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;
   //
   shippingTypeCombo.Items.Clear;
   shippingTypeCombo.Items.Add('Rate');
   shippingTypeCombo.Items.Add('Percent');
   //
   if fShippingQuery.GetFieldByName('STYPE').AsInteger = integer(tShippingTypes.ShipRate) then
      shippingTypeCombo.ItemIndex := 0;
   if fShippingQuery.GetFieldByName('STYPE').AsInteger = integer(tShippingTypes.ShipPcnt ) then
      shippingTypeCombo.ItemIndex := 1;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, fShippingQuery.GetFieldByName('TAXID').AsString);
   //
   refresh_form();
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.


tShippingTypes = ( Rate = 1, Pcnt = 2);

         retVal := masterData.AddTable(masterData.dbPath + table_shipping,
            'ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'PCNT FLOAT, ' + // PERCENT if STYPE = 2
            'RATE MONEY, ' + // RATE if STYPE = 1
            'STYPE INTEGER, ' + // TYPE - 1 = $RATE$ - 2 = %PCNT%
}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPref_ShippingEditForm.Save : boolean;
var
	errMsg : string;
begin
	errMsg := '';

   // check for stuff
   if (db_name.Text = '') then
      errMsg := 'Shipping Name cannot be blank.';
   if ( Return_MaskEdit_Curr( db_samt.Text ) = 0 ) then
      errMsg := 'Starting Amount cannot be 0.';
   if ( Return_MaskEdit_Curr( db_eamt.Text ) = 0 ) then
      errMsg := 'Ending Amount cannot be 0.';

   if (errMsg = '') then
   begin
      // transfer all of the field values into the query and save it.
      //
      if (NOT fIsNew) then
         fShippingQuery.Edit();
      //
      if (shippingTypeCombo.ItemIndex = 0) then
         fShippingQuery.SetFieldByName('STYPE', 1);
      if (shippingTypeCombo.ItemIndex = 1) then
         fShippingQuery.SetFieldByName('STYPE', 2);
      fShippingQuery.SetFieldByName('NAME', ProperCase(db_name.Text, true));
      fShippingQuery.SetFieldByName('ISACTIVE', db_active.checked);
      fShippingQuery.SetFieldByName('ORG_ID', Org_GetOrgIDByOrgName( orgCombo.Text ));
      fShippingQuery.SetFieldByName('DESCR', ProperCase(db_desc.Text, true));
      fShippingQuery.SetFieldByName('SAMT', Return_MaskEdit_Curr(db_samt.text));
      fShippingQuery.SetFieldByName('EAMT', Return_MaskEdit_Curr(db_eamt.text));
      fShippingQuery.SetFieldByName('PCNT', Return_MaskEdit_Float(db_rate.text));
      fShippingQuery.SetFieldByName('RATE', Return_MaskEdit_Curr(db_amount.text));
      fShippingQuery.SetFieldByName('TAXID', Tax_GetMasterTaxIDByName( db_taxclass.Text ));

      Org_GetOrgIDByOrgName( orgCombo.Text );
      //
      fShippingQuery.Post();
   end else
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);

   //
	result := (errMsg = '');
end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ShippingEditForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ShippingEditForm.HandleActionExecute(sender: tObject; actionID: integer);
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
      	if AvoBaseDialog('Cancel Shipping Rate Changes', 'Are you sure you want to Cancel changes to this Shipping Rate?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fShippingQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('Pref_ShippingEditForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ShippingEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

procedure TPref_ShippingEditForm.refresh_form;
begin
   if (shippingTypeCombo.ItemIndex = 1) then
   begin
      ratelabel.Visible := true;
      db_rate.visible := true;
      pcntLabel.visible := true;
      //
      shippingAmountLabel.Visible := false;
      db_amount.visible := false;
   end else
      begin
         ratelabel.visible := false;
         db_rate.visible := false;
         pcntLabel.visible := false;
         //
         shippingAmountLabel.Visible := true;
         db_amount.visible := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPref_ShippingEditForm.fGetIsNew: boolean;
begin
	result := fIsNew;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ShippingEditForm.fSetIsNew(inValue: boolean);
begin
   fIsNew := inValue;
//   if (NOT fIsNew) then db_name.Enabled := false;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_ShippingEditForm.shippingTypeComboChange(Sender: TObject);
begin
   refresh_form();
end;

end.
