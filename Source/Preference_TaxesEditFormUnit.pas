 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_TaxesEditFormUnit;

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
	tPref_TaxEditForm =  class(TAvoBase_BaseForm_Menu)
   	db_name: TLabeledEdit;
      db_active: TCheckBox;
      db_desc: TLabeledEdit;
      db_samt: TMaskEdit;
      db_eamt: TMaskEdit;
      db_rate: TMaskEdit;
      samtLabel: TLabel;
      eamtLabel: TLabel;
      rateLabel: TLabel;
      pcntLabel: TLabel;
    taxTypeCombo: TComboBox;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
   private
   	fIsNew : boolean;
      fMasterTaxID : string;
   	fCloseAction : tFormActions;
      fTaxQuery : tMasterData_BaseDataClass;
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
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass; inMasterTaxID : string ); overload;
   end;


implementation

{$R *.dfm}

{ tPreferenceEditForm }

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TPref_TaxEditForm.Create(
	owner: TComponent;
   InCaption : string;
   isTopBarVisble : boolean;
   inQuery : tMasterData_BaseDataClass;
   inMasterTaxID : string );
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fTaxQuery := inQuery;
   fMasterTaxID := inMasterTaxID;
   //
   taxTypeCombo.Clear;
   taxTypeCombo.Items.Add('Simple');
   taxTypeCombo.Items.Add('Compound');
   taxTypeCombo.ItemIndex := 0;
   //
	StartUpForm();
end;

function tPref_TaxEditForm.fGetID: string;
begin
   result := fTaxQuery.GetFieldByName('ID').AsString;
end;

function TPref_TaxEditForm.fGetIsNew: boolean;
begin
	result := fIsNew;
end;

procedure tPref_TaxEditForm.FormShow(Sender: TObject);
begin
   inherited;
   db_name.SetFocus();
end;

procedure TPref_TaxEditForm.fSetIsNew(inValue: boolean);
begin
   fIsNew := inValue;
{
   if (NOT fIsNew) then
   	db_name.Enabled := false;
}
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxEditForm.SaveData;
begin
   // transfer all of the field values into the query and save it.
   //
   if (NOT fIsNew) then
      fTaxQuery.Edit()
   else
   	begin
      	fTaxQuery.Append();
         fTaxQuery.SetFieldByName('TAXID', fMasterTaxID);
      end;
   //
	fTaxQuery.SetFieldByName('NAME', ProperCase(db_name.Text, true));
	fTaxQuery.SetFieldByName('ISACTIVE', db_active.checked);
	fTaxQuery.SetFieldByName('DESCR', ProperCase(db_desc.Text, true));
   fTaxQuery.SetFieldByName('SAMT', Return_MaskEdit_Curr(db_samt.text));
   fTaxQuery.SetFieldByName('EAMT', Return_MaskEdit_Curr(db_eamt.text));
   fTaxQuery.SetFieldByName('RATE', Return_MaskEdit_Float(db_rate.text));
   if ( taxTypeCombo.ItemIndex = 0 ) then
      fTaxQuery.SetFieldByName('TTYPE', integer(tTaxTypes.taxTypeSimple));
   if ( taxTypeCombo.ItemIndex = 1 ) then
      fTaxQuery.SetFieldByName('TTYPE', integer(tTaxTypes.taxTypeCompound));
   //
	fTaxQuery.Post();
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'RATE FLOAT',
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxEditForm.StartUpForm;
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
	db_name.Text := fTaxQuery.GetFieldByname('NAME').AsString;
	db_active.checked := fTaxQuery.GetFieldByname('ISACTIVE').AsBoolean;
   db_desc.Text := fTaxQuery.GetFieldByname('DESCR').AsString;
   db_samt.Text := FormatFloat('#####0.00', fTaxQuery.GetFieldByName('SAMT').AsCurrency);
   db_eamt.Text := FormatFloat('#####0.00', fTaxQuery.GetFieldByName('EAMT').AsCurrency);
   db_rate.Text := FormatFloat('#0.00', fTaxQuery.GetFieldByName('RATE').AsCurrency);
   case fTaxQuery.GetFieldByName('TTYPE').AsInteger of
      1 : taxTypeCombo.ItemIndex := 0; // simple
      2 : taxTypeCombo.ItemIndex := 1; // compound
   end;
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxEditForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPref_TaxEditForm.Save : boolean;
var
	errMsg : string;
begin
	errMsg := '';

   // check for stuff
   if (db_name.Text = '') then
      errMsg := 'Tax Name cannot be blank.';
   if ( Return_MaskEdit_Curr( db_samt.text)  = 0 ) then
      errMsg := 'Starting Amount cannot be 0.';
   if ( Return_MaskEdit_Curr( db_eamt.text)  = 0 ) then
      errMsg := 'Ending Amount cannot be 0.';
   if ( Return_MaskEdit_Float( db_rate.Text ) = 0 ) then
      errMsg := 'Tax Rate cannot be 0%';
   if (fIsNew) AND ( Tax_TaxExitsByName( db_name.text )) then
      errMsg := 'A Tax Rate already exists with that name.';

   if (errMsg <> '') then
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);
   //
	result := (errMsg = '');
end;
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxEditForm.HandleActionExecute(sender: tObject; actionID: integer);
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
      	if AvoBaseDialog('Cancel Tax Rate Changes', 'Are you sure you want to Cancel changes to this Tax Rate?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fTaxQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP :
      begin
      	showmessage('HELP IS NOT YET HERE.');
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPref_TaxEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
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
