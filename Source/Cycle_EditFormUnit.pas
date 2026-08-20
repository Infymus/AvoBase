 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Cycle_EditFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   masterdata_BaseDataClassUnit,
   avobase_texteditorformunit,
  recordstructureunit,
   toolbox_PreferenceToolBoxUnit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
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
   TabNotBk;

type
   tCycleEditForm = class(TAvoBase_BaseForm_Menu)
   	orgCombo: TComboBox;
      Label1: TLabel;
      db_active: TCheckBox;
      Label2: TLabel;
      Label3: TLabel;
      INVOICE_MSG_DOCK_PANEL: TPanel;
      CycleNumComboBox: TComboBox;
      Label5: TLabel;
      CycleYearComboBox: TComboBox;
      campYearLabel: TLabel;
      isnewLabel: TLabel;
    sDateEdit: TDateTimePicker;
    eDateEdit: TDateTimePicker;
    cycleDescriptPanel: TPanel;
      procedure orgComboChange(Sender: TObject);
   private
      fIsNew : boolean;
   	fCloseAction : tFormActions;
      fCycleQuery : tMasterData_BaseDataClass;
      TextEditor : tAvoBaseTextEditor;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      function Save() : boolean;
      procedure Fill_Cycle_Years;
      procedure Fill_Cycle_Numbers;
      function fGetIsNew : boolean;
      procedure fSetIsNew( inVal : boolean );
   public
      procedure StartUpForm();
   	property CloseAction : tFormActions read fCloseAction;
      property IsNew : boolean read fGetIsNew write fSetIsNew;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TCycleEditForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false);
   //
   fCycleQuery := inQuery;
   TextEditor := tAvoBaseTextEditor.Create(nil, INVOICE_MSG_DOCK_PANEL);
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SAVE );
end;

procedure TCycleEditForm.CloseForm;
begin
   FreeAndNil(TextEditor);
	Close();
end;

// ################################################################################### //

procedure TCycleEditForm.StartUpForm;
var
   orgName : string;
   cnt : integer;
begin
   //
   orgCombo.OnChange := nil;

   // pull down active organizations
   Org_ComboBox_FillActiveOrgs( orgCombo );
   orgName := Org_GetOrgNameByOrgID( fCycleQuery.GetFieldByName('ORG_ID').AsString);
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;

   // org names
//   Fill_Org_Names();
   // cycle numbers
   Fill_Cycle_Numbers();
   // cycle years
   Fill_Cycle_Years();

   db_active.checked := fCycleQuery.GetFieldByname('ISACTIVE').AsBoolean;

   sDateEdit.Date := fCycleQuery.GetFieldByName('SDATE').AsDateTime;
   eDateEdit.Date := fCycleQuery.GetFieldByName('EDATE').AsDateTime;

   TextEditor.Text := fCycleQuery.GetFieldByname('IMSG').AsString;

   // Must always be last
   orgCombo.OnChange := orgComboChange;
end;

// ################################################################################### //

function TCycleEditForm.Save : boolean;
var
   errMsg : string;
   cycleRec : tCycleRec;

begin
   errMsg := '';
   // validate here
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.org_id := Org_GetOrgIDByOrgName( orgCombo.Text );
   cycleRec.num := StrToInt( CycleNumComboBox.Text );
   cycleRec.year := StrToInt( CycleYearComboBox.Text );
	cycleRec.sdate := sDateEdit.Date;
	cycleRec.edate := eDateEdit.Date;
   cycleRec.cname := IntToStr( cycleRec.year ) + '/' + IntToStr( cycleRec.num );

   if (fIsNew) then
   begin
      if (Cycle_CycleExists( cycleRec )) then
         errMsg := 'A Sales Cycle matching the Organization, Cycle Number and Cycle Year already exists.';
      if (Cycle_CycleSalesPeriodExists( cycleRec )) then
         errMsg := 'A Sales Cycle with the same or overlapping Sales Period (Start Date to End Date) already exists.';
   end;

   if (errMsg = '') then
   begin
      // transfer data here - the ID is already set either by NEW or by EDIT through the list.
      fCycleQuery.SetFieldByName('ISACTIVE', db_active.Checked );
      fCycleQuery.SetFieldByName('ORG_ID', cycleRec.org_id );
      fCycleQuery.SetFieldByName('NUM', cycleRec.num);
      fCycleQuery.SetFieldByName('CYEAR', cycleRec.year);
      fCycleQuery.SetFieldByName('IMSG', TextEditor.Text);
      fCycleQuery.SetFieldByName('SDATE', cycleRec.sdate);
      fCycleQuery.SetFieldByName('EDATE', cycleRec.edate);
      fCycleQuery.SetFieldByName('CNAME', cycleRec.cname );
{
'ID VARCHAR(40), ' +
'ORG_ID VARCHAR(40), ' +
'ISACTIVE BOOLEAN, ' +
'NUM INTEGER, ' + // Cycle Number
'IMSG BLOB(240, 1), ' + // specific invoice message for cycle
'SDATE DATE, ' + // start date
'EDATE DATE ',  // end date
}
      fCycleQuery.Post();
   end else
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);
   result := (errMsg = '');
end;


// ################################################################################### //


procedure TCycleEditForm.HandleActionExecute(sender: tObject; actionID: integer);
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
      	if AvoBaseDialog('Cancel Cycle Changes', 'Are you sure you want to Cancel changes to this Cycle?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fCycleQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('CycleEditForm');
   end;
end;

// ################################################################################### //

procedure TCycleEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

procedure TCycleEditForm.orgComboChange(Sender: TObject);
begin
   if (fisNew) then
   begin
      // cycle numbers
      Fill_Cycle_Numbers();
      // cycle years
      Fill_Cycle_Years();
   end;
end;

// ################################################################################### //

procedure TCycleEditForm.Fill_Cycle_Numbers;
var
   cnt : integer;
begin
   Cycle_ComboBox_FillCycleNumbers( Org_GetOrgIDByOrgName(orgCombo.Text), CycleNumComboBox );
   for cnt := 0 to CycleNumComboBox.Items.Count do
      if ( CycleNumComboBox.Items.Strings[ cnt ] = fCycleQuery.GetFieldByName('NUM').AsString ) then
         CycleNumComboBox.ItemIndex := cnt;
end;

procedure tCycleEditForm.Fill_Cycle_Years;
var
   cnt : integer;
begin
   Cycle_ComboBox_FillCycleYears( Org_GetOrgIDByOrgName( orgCombo.Text ), CycleYearComboBox );
   for cnt := 0 to CycleYearComboBox.Items.Count do
      if ( CycleYearComboBox.Items.Strings[ cnt ] = fCycleQuery.GetFieldByName('CYEAR').AsString ) then
         CycleYearComboBox.ItemIndex := cnt;
end;

// ################################################################################### //

function TCycleEditForm.fGetIsNew: boolean;
begin
   result := fIsNew;
end;

procedure TCycleEditForm.fSetIsNew(inVal: boolean);
begin
   fisNew := inVal;
   // are we in edit mode?
   if (NOT isNew) then
   begin
      orgCombo.Enabled := false;
      CycleNumComboBox.Enabled := false;
      CycleYearComboBox.Enabled := false;
      isnewLabel.visible := true;
      isnewLabel.Caption := 'NOTE: Once a Cycle Year, Cycle Number and Cycle Organization have been entered ' +
       'into AvoBase, you cannot change the Number, Year or Organization. Orders and other records are ' +
       'tied to Cycle Year and Numbers therefore changing them will directly affect ' +
       'existing Orders.';
   end else
   	begin
      isnewLabel.visible := true;
         isnewLabel.Caption := 'NOTE: Sales Cycles are sorted by the End Date. Make sure your Sales Cycles have a ' +
         	'proper Start Date and End Date.';
      end;
end;

// ################################################################################### //



// ################################################################################### //

end.
