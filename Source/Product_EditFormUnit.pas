 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Product_EditFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
  recordstructureunit,
   avobase_dialogformunit,
   masterdata_BaseDataClassUnit,
   toolbox_orgtoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_cycletoolboxunit,
   toolbox_taxtoolboxunit,
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
   Mask;

type
  TProductEditForm = class(TAvoBase_BaseForm_Menu)
    db_name: TLabeledEdit;
    Label1: TLabel;
    orgCombo: TComboBox;
    Label5: TLabel;
    CycleNumComboBox: TComboBox;
    campYearLabel: TLabel;
    CycleYearComboBox: TComboBox;
    db_num: TMaskEdit;
    Label2: TLabel;
    db_descr: TLabeledEdit;
    db_PRODN1: TLabeledEdit;
    db_PRODN3: TLabeledEdit;
    amountLabel: TLabel;
    db_amount: TMaskEdit;
    db_isactive: TCheckBox;
    db_qty: TMaskEdit;
    Label3: TLabel;
    db_PRODN2: TLabeledEdit;
    db_PRODN4: TLabeledEdit;
    db_taxclass: TComboBox;
    Label4: TLabel;
    db_noprodlabel: TLabel;
    db_sellat: TMaskEdit;
    Label6: TLabel;
    Label7: TLabel;
    db_ycost: TMaskEdit;
    procedure orgComboChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CycleYearComboBoxChange(Sender: TObject);
   private
      fIsNew : boolean;
   	fCloseAction : tFormActions;
      fProdQuery : tMasterData_BaseDataClass;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      function fGetOrgID : string;
      function fGetProductYear : integer;
   public
      function Save : boolean;
      procedure CloseForm();
      procedure StartUpForm();
      procedure Fill_Cycle_Years;
      procedure Fill_Cycle_Numbers;
      procedure SetProductSpecialFields();
      //
   	property CloseAction : tFormActions read fCloseAction;
      property IsNew : boolean read fIsNew write fIsNew;
      property OrgID : string read fGetOrgID;
      property pYear : integer read fGetProductYear;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble, isNew : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TProductEditForm.Create( owner: TComponent; InCaption : string; isTopBarVisble, isNew : boolean; inQuery : tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fIsNew := isNew;
   //
   fProdQuery := inQuery;
   //
	StartUpForm();
end;



function TProductEditForm.fGetOrgID: string;
begin
   result := Org_GetOrgIDByOrgName( orgCombo.Text );
end;

function TProductEditForm.fGetProductYear: integer;
begin
   result := StrToInt( CycleYearComboBox.Text );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
         retVal := masterData.AddTable(masterData.dbPath + table_product,
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'NUM VARCHAR(20), ' +
            'TAXE BOOLEAN, ' +
            'QTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PRODN1 VARCHAR(40), ' + // product table field name 1
            'PRODN2 VARCHAR(40), ' + // product table field name 2
            'PRODN3 VARCHAR(40), ' + // product table field name 3
            'PRODN4 VARCHAR(40), ' + // product table field name 4
            'AMOUNT MONEY',
}

procedure tProductEditForm.StartUpForm;
var
   cnt : integer;
   orgName : string;
   cycleRec : tCycleRec;
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
{
   db_PRODN1.EditLabel.Caption := 'User Defined Field #1 - "'+ Pref_GetString('PRODN1') + '"';
   db_PRODN2.EditLabel.Caption := 'User Defined Field #2 - "'+ Pref_GetString('PRODN2') + '"';
   db_PRODN3.EditLabel.Caption := 'User Defined Field #3 - "'+ Pref_GetString('PRODN3') + '"';
   db_PRODN4.EditLabel.Caption := 'User Defined Field #4 - "'+ Pref_GetString('PRODN4') + '"';

   db_PRODN1.Text := Org_GetOrgProductSpecialField( OrgID, 'PRODN1');
   db_PRODN2.Text := Org_GetOrgProductSpecialField( OrgID, 'PRODN2');
   db_PRODN3.Text := Org_GetOrgProductSpecialField( OrgID, 'PRODN3');
   db_PRODN4.Text := Org_GetOrgProductSpecialField( OrgID, 'PRODN4');
}


   //
   Org_ComboBox_FillActiveOrgs( orgCombo );
   orgName := Org_GetOrgNameByOrgID( fProdQuery.GetFieldByName('ORG_ID').AsString);
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;

   // now transfer ALL of the Product record into the visible fields on the form.
   // this shit really shouldn't be here unless !fIsNew, but i fucking digress
   db_isactive.Checked := fProdQuery.GetFieldByName('ISACTIVE').AsBoolean;
   db_num.Text := fProdQuery.GetFieldByName('NUM').AsString;
	db_name.Text := fProdQuery.GetFieldByName('NAME').AsString;
   db_DESCR.Text := fProdQuery.GetFieldByName('DESCR').AsString;
   db_qty.Text := fProdQuery.GetFieldByName('QTY').AsString;
   db_ycost.Text := FormatFloat('#0.00', fProdQuery.GetFieldByName('YCOST').AsCurrency);
   db_amount.Text := FormatFloat('#0.00', fProdQuery.GetFieldByName('AMOUNT').AsCurrency);
   db_sellat.Text := FormatFloat('#0.00', fProdQuery.GetFieldByName('SELLAT').AsCurrency);
   db_PRODN1.Text := fProdQuery.GetFieldByName('PRODN1').AsString;
   db_PRODN2.Text := fProdQuery.GetFieldByName('PRODN2').AsString;
   db_PRODN3.Text := fProdQuery.GetFieldByName('PRODN3').AsString;
   db_PRODN4.Text := fProdQuery.GetFieldByName('PRODN4').AsString;
   // '000\-000;1; ';

   // yes these are duplicates from below
   if NOT (fisNew) then
   begin
      cycleRec := Cycle_GetCycleByCycleID( fProdQuery.GetFieldByName('C_ID').AsString );
      Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
      Cycle_ComboBox_FillCycleNumbersExist( cycleRec.org_id, cycleRec.year, CycleNumComboBox );
      Fill_Cycle_Numbers();
      Fill_Cycle_Years();
   end else
   	begin
      	Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
			CycleYearComboBox.ItemIndex := CycleYearComboBox.ItemIndex;
         Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
	      CycleNumComboBox.ItemIndex := CycleNumComboBox.ItemIndex;
      end;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, fProdQuery.GetFieldByName('TAXID').AsString);
   //
   SetProductSpecialFields();
   // Set up event
   CycleYearComboBox.OnChange := CycleYearComboBoxChange;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TProductEditForm.Save: boolean;
var
   errMsg : string;
   C_ID : string;
   cycleRec : tCycleRec;
begin
   errMsg := '';
   // validate here
   if (db_name.text = '') then
      errMsg := 'Product Name cannot be blank.';

   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( CycleYearComboBox.Text );
   cycleRec.Num := StrToInt( CycleNumComboBox.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( orgCombo.Text, cycleRec.Year, cycleRec.Num );

   if ( C_ID = '') then
      errMsg := 'There is no sales cycle in ' + CycleYearComboBox.Text + '/ ' + CycleNumComboBox.Text +' for ' +
         orgCombo.Text;

   if (errMsg = '') then
   begin
      // transfer all of the field values into the query and save it.
      //
      if (NOT fIsNew) then
         fProdQuery.Edit();
      //
      fProdQuery.SetFieldByName('ISACTIVE', db_isactive.Checked);
      fProdQuery.SetFieldByName('AMOUNT', Return_MaskEdit_Curr(db_amount.text));
      fProdQuery.SetFieldByName('YCOST', Return_MaskEdit_Curr(db_ycost.text));
      fProdQuery.SetFieldByName('SELLAT', Return_MaskEdit_Curr(db_sellat.text));
      fProdQuery.SetFieldByName('ORG_ID', Org_GetOrgIDByOrgName( orgCombo.Text ));
      fProdQuery.SetFieldByName('C_ID', C_ID);
      fProdQuery.SetFieldByName('NUM', db_num.Text);
      if (db_qty.text <> '') then
         fProdQuery.SetFieldByName('QTY', Return_MaskEdit_Int( db_qty.text ));
      fProdQuery.SetFieldByName('NAME', ProperCase(db_name.Text, true));
      fProdQuery.SetFieldByName('DESCR', ProperCase(db_descr.Text, true));
      fProdQuery.SetFieldByName('PRODN1', ProperCase(db_prodn1.Text, true));
      fProdQuery.SetFieldByName('PRODN2', ProperCase(db_prodn2.Text, true));
      fProdQuery.SetFieldByName('PRODN3', ProperCase(db_prodn3.Text, true));
      fProdQuery.SetFieldByName('PRODN4', ProperCase(db_prodn4.Text, true));
      fProdQuery.SetFieldByName('TAXID', Tax_GetMasterTaxIDByName( db_taxclass.Text ));
      //
      fProdQuery.Post();
   end else
      AvoBaseDialog('Unable To Save', errMsg, mtWarning, [mbOk], 0);
   result := (errMsg = '');
end;

procedure TProductEditForm.SetProductSpecialFields;
begin
      db_prodn1.visible := false;
      db_prodn2.visible := false;
      db_prodn3.visible := false;
      db_prodn4.visible := false;


   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN1') <> '' ) then
   begin
      db_prodn1.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN1');
      db_prodn1.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN2') <> '' ) then
   begin
      db_prodn2.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN2');
      db_prodn2.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN3') <> '' ) then
   begin
      db_prodn3.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN3');
      db_prodn3.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN4') <> '' ) then
   begin
      db_prodn4.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN4');
      db_prodn4.visible := true;
   end;

   db_noprodlabel.Visible := false;

   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN1') = '' ) AND
      ( Org_GetOrgProductSpecialField( OrgID, 'PRODN2') = '' ) AND
      ( Org_GetOrgProductSpecialField( OrgID, 'PRODN3') = '' ) AND
      ( Org_GetOrgProductSpecialField( OrgID, 'PRODN4') = '' ) then
   begin
      db_noprodlabel.Top := 203;
      db_noprodlabel.Left := 6;
      db_noprodlabel.Height := 131;
      db_noprodlabel.Width := 410;
      db_noprodlabel.Visible := true;
      db_noprodlabel.caption := 'You currently have no User Defined Product Fields. User Defined ' +
         'Fields allow you to specify any type of field you want - such as Color, Size, Ounce, Bin ' +
         'and more. These can then be used and printed on your Invoices. You can create User Defined ' +
         'Product Fields in AvoBase Settings under Product Settings.';
   end else
      db_noprodlabel.Visible := false;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TProductEditForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TProductEditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SAVE :
      begin
         if (Save) then
         begin
            fCloseAction := actionSave;
            fProdQuery.Post();
            CloseForm();
         end;
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel Product Changes', 'Are you sure you want to Cancel changes to this Product?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
				fProdQuery.Cancel();
            CloseForm();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('ProductEditForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TProductEditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TProductEditForm.orgComboChange(Sender: TObject);
begin
   Cycle_ComboBox_FillCycleNumbers( Org_GetOrgIDByOrgName(orgCombo.Text), CycleNumComboBox );
   Cycle_ComboBox_FillCycleYears( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   SetProductSpecialFields();
end;

procedure TProductEditForm.CycleYearComboBoxChange(Sender: TObject);
begin
	Cycle_ComboBox_FillCycleNumbersExist( OrgID, pYear, CycleNumComboBox );
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TProductEditForm.Fill_Cycle_Numbers;
var
   cnt : integer;
   cNum : integer;
   cycleRec : tCycleRec;
begin
   if NOT (fisNew) then
   begin
      cycleRec := Cycle_GetCycleByCycleID( fProdQuery.GetFieldByName('C_ID').AsString );
      for cnt := 0 to CycleNumComboBox.Items.Count - 1 do
      begin
         cNum := StrToInt( CycleNumComboBox.Items.Strings[ cnt ] );
         if ( cNum = cycleRec.num )  then
            CycleNumComboBox.ItemIndex := cnt;
      end;
   end else
      CycleNumComboBox.ItemIndex := CycleNumComboBox.ItemIndex -1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TProductEditForm.Fill_Cycle_Years;
var
   cnt : integer;
   cYear : integer;
   cycleRec : tCycleRec;
begin
   if NOT (fisNew) then
   begin
      cycleRec := Cycle_GetCycleByCycleID( fProdQuery.GetFieldByName('C_ID').AsString );
      for cnt := 0 to CycleYearComboBox.Items.Count - 1 do
      begin
         cYear := StrToInt( CycleYearComboBox.Items.Strings[ cnt ] );
         if ( cYear = cycleRec.year )  then
            CycleYearComboBox.ItemIndex := cnt;
      end;
   end else
      CycleYearComboBox.ItemIndex := CycleYearComboBox.ItemIndex -1;
end;

procedure TProductEditForm.FormShow(Sender: TObject);
begin
   db_isactive.SetFocus();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
