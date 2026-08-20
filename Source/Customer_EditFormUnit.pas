 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_EditFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   ToolBox_PreferenceToolBoxUnit,
   masterdata_BaseDataClassUnit,
   encryptunit,
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
   Mask;

type
	tCustomerEditForm = class(TAvoBase_BaseForm_Menu)
    Label1: TLabel;
    db_active: TCheckBox;
    db_fname: TLabeledEdit;
    db_mname: TLabeledEdit;
    db_lname: TLabeledEdit;
    Label2: TLabel;
    db_addr1: TLabeledEdit;
    db_addr2: TLabeledEdit;
    db_city: TLabeledEdit;
    db_state: TLabeledEdit;
    db_zip: TLabeledEdit;
    db_phoneh: TLabeledEdit;
    db_phonec: TLabeledEdit;
    db_phonew: TLabeledEdit;
    db_taxexempt: TCheckBox;
    db_email: TLabeledEdit;
    db_TAXEXID: TLabeledEdit;
    bDayEdit: TDateTimePicker;
    procedure FormShow(Sender: TObject);
   private
      fIsNew : boolean;
   	fCloseAction : tFormActions;
      fCustQuery : tMasterData_BaseDataClass;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      function Save() : boolean;
      procedure StartUpForm();
      procedure fSetIsNew( inVal : boolean );
   public
   	property CloseAction : tFormActions read fCloseAction;
      property IsNew : boolean read fIsNew write fSetIsNew;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tCustomerEditForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fCustQuery := inQuery;
   //
	StartUpForm();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerEditForm.FormShow(Sender: TObject);
begin
   db_fname.SetFocus();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerEditForm.fSetIsNew(inVal: boolean);
begin
   fIsNew := inVal;
   if ( fIsNew ) then
      db_active.checked := true;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tCustomerEditForm.Save : boolean;
var
   errMsg : string;
begin
   errMsg := '';

   // validate here
   if (db_fname.text = '') then
      errMsg := 'First Name cannot be blank.';
   if (fCustQuery.GetFieldByName('ID').AsString = '' ) then
      errMsg := 'Invalid ID Table:CUST';

   if (errMsg = '') then
   begin
      if ( NOT fIsNew ) then
         fCustQuery.Edit();
      //
      fCustQuery.SetFieldByName('FNAME', ProperCase(db_fname.Text, true));
      fCustQuery.SetFieldByName('MNAME', ProperCase(db_mname.Text, true));
      fCustQuery.SetFieldByName('LNAME', ProperCase(db_lname.Text, true));
      fCustQuery.SetFieldByName('ADDR1', ProperCase(db_addr1.Text));
      fCustQuery.SetFieldByName('ADDR2', ProperCase(db_addr2.Text));
      fCustQuery.SetFieldByName('CITY', ProperCase(db_city.Text));
      fCustQuery.SetFieldByName('STATE', ProperCase(db_state.Text));
      fCustQuery.SetFieldByName('ZIP', ProperCase(db_zip.Text));
      fCustQuery.SetFieldByName('PHONEH', ProperCase(db_phoneh.Text));
      fCustQuery.SetFieldByName('PHONEC', ProperCase(db_phonec.Text));
      fCustQuery.SetFieldByName('PHONEW', ProperCase(db_phonew.Text));
      fCustQuery.SetFieldByName('EMAIL', LowerCase(db_email.Text));
      fCustQuery.SetFieldByName('TAXE', db_taxexempt.Checked);
      fCustQuery.SetFieldByName('ISACTIVE', db_active.Checked);
      fCustQuery.SetFieldByName('BDAY', bDayEdit.Date);
      fCustQuery.SetFieldByName('TAXEXID', ProperCase(db_TAXEXID.Text));
      //
      fCustQuery.Post();
   end;
   if ( errMsg <> '') then
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);
   result := (errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerEditForm.StartUpForm;
var
	bDay : tDateTime;
begin
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SAVE );
   //
   if ( NOT fIsNew ) then
   begin
      db_fname.Text := fCustQuery.GetFieldByname('FNAME').AsString;
      db_mname.Text := fCustQuery.GetFieldByname('MNAME').AsString;
      db_lname.Text := fCustQuery.GetFieldByname('LNAME').AsString;
      db_addr1.Text := fCustQuery.GetFieldByname('ADDR1').AsString;
      db_addr2.Text := fCustQuery.GetFieldByname('ADDR2').AsString;
      db_city.Text := fCustQuery.GetFieldByname('CITY').AsString;
      db_state.Text := fCustQuery.GetFieldByname('STATE').AsString;
      db_zip.Text := fCustQuery.GetFieldByname('ZIP').AsString;
      db_phoneh.Text := fCustQuery.GetFieldByname('PHONEH').AsString;
      db_phonec.Text := fCustQuery.GetFieldByname('PHONEC').AsString;
      db_phonew.Text := fCustQuery.GetFieldByname('PHONEW').AsString;
      db_email.Text := fCustQuery.GetFieldByname('EMAIL').AsString;
      db_taxexempt.Checked := fCustQuery.GetFieldByname('TAXE').AsBoolean;
      db_active.checked := fCustQuery.GetFieldByname('ISACTIVE').AsBoolean;
      bDayEdit.Date := fCustQuery.GetFieldByName('BDAY').AsDateTime;
      db_zip.EditLabel.Caption := Pref_GetZipRegionName;
      db_TAXEXID.Text := fCustQuery.GetFieldByname('TAXEXID').AsString;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerEditForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerEditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SAVE :
      begin
         if ( Save() ) then
         begin
            fCloseAction := actionSave;
            CloseForm();
         end;
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel Customer Changes', 'Are you sure you want to Cancel changes to this Customer?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fCustQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('CustomerEditForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
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



