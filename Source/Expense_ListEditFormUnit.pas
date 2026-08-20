 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Expense_ListEditFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   actionunit,
   masterdata_basegridunit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   toolbox_PreferenceToolBoxUnit,
   MasterData_ExpenseListEditUnit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   Cycle_SelectOrgAndCycleFormUnit,
   toolbox_orgtoolboxunit,
   toolbox_ExpenseToolBoxUnit,
   toolbox_cycletoolboxunit,
   AvoBase_ToolBarUnit,
   Expense_ItemEditFormUnit,
   Preference_ExpenseTypeFormUnit,
   Expense_ViewExpensesFormUnit,
   AvoBase_HelpFormUnit,
   //
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   ExtCtrls,
   ComCtrls,
   ToolWin,
   ActnList,
   jpeg,
   Mask;

type
   tExpenseList_EditForm = class(TAvobase_BaseForm_List)
    edit_panel: TPanel;
   private
      expListQuery : tMasterDataExpenseListEdit;
      toolBar : tAvoBaseToolBar;
      fExpID : string;
      fOrgID: string;
      fCycleID : string;
      expQuery : tMasterData_BaseDataClass;
      expEditForm : TExpense_EditForm;
      expViewForm : tExpense_ViewExpensesForm;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleDoubleClick( sender : tObject );
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure HandleGridUpdateData(Sender: TObject; Field: TField);
      procedure PutEditFormData;
      function Check_CanCreate: boolean;
      function CanSave : string;
   public
      //
      procedure UpdateQuery();
      //
      procedure New();
      procedure Edit();
      procedure View();
      procedure Save();
      procedure Cancel();
      procedure Delete();
      procedure EditExpenseTypes();
      //
      constructor Create(owner : tComponent; inEID : string);  overload;
      destructor Destroy; override;
  end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Destroy'}

constructor tExpenseList_EditForm.create(owner : TComponent; inEID : string);
begin
	inherited create( Nil, 'Expenses', true, True);
   //
   Self.ShowBorder := True;
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   expQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Expense);
   //
   fExpID := inEID;
   fOrgID := Expense_GetOrgIDByExpenseListID( inEID );
   fCycleID := Expense_GetCycleIDByExpenseListID( inEID );
   //
   expEditForm := TExpense_EditForm.Create( Application, edit_panel);
   expEditForm.Clear;
   //
   BASE_FORM_LABEL.Caption := 'Expense List For ' + Org_GetOrgNameByOrgID( fOrgID ) +
      ' | Sales Cycle ' + Cycle_GetCycleNameByCycleID( fCycleID );
   //
   expListQuery := tMasterDataExpenseListEdit.Create( masterData, fExpID );
   //
   gridDataSource.DataSet := expListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( expListQuery, '' );
   DataListGrid.Clear;
   DataListGrid.Add(expListQuery.FieldByName('MOPDATE'), 'DATE', 80, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(expListQuery.FieldByName('EXPTYPE'), 'EXPENSE TYPE', 160, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(expListQuery.FieldByName('EDESC'), 'DESCRIPTION', 190, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(expListQuery.FieldByName('AMOUNT'), 'AMOUNT', 100, clBlack, [fsBold], taRightJustify);

   {
         retVal := masterData.AddTable(masterData.dbPath + table_expense,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'E_ID VARCHAR(40), ' + // expense ID
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // expense type ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
}
   DataListGrid.OnDblClick := HandleDoubleClick;
   DataListGrid.DataSource.OnDataChange := HandleGridUpdateData;
   //
   dbNavTool.Init( expListQuery );
   //
   toolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   toolBar.actionList.OnUpdate := HandleActionListUpdate;
   toolBar.actionList.onActionEvent := HandleActionExecute;
   toolBar.Align := alClient;
   toolbar.CreateButton( CMD_CLOSE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_HELP );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_EXPENSE_EDIT_TYPES );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_DELETE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_CANCEL);
   toolBar.CreateButton( CMD_SAVE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_EDIT);
   toolBar.CreateButton( CMD_NEW);
   //
   UpdateQuery();
end;

destructor tExpenseList_EditForm.Destroy;
begin
	expListQuery.Close();
   FreeAndNil(expQuery);
   freeAndNil(expListQuery);
   FreeAndNil(toolBar);
   FreeAndNil(expEditForm);
   //
	inherited
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties'}
{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

procedure tExpenseList_EditForm.HandleDoubleClick(sender: tObject);
begin
	Edit();
end;

procedure tExpenseList_EditForm.HandleGridUpdateData(Sender: TObject; Field: TField);
begin
   PutEditFormData();
end;

procedure tExpenseList_EditForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(expListQuery.RecNo) + ' of ' + IntToStr(expListQuery.RecordCount);
   StatusBar.Panels[1].Text := 'Total Earnings: ' + Pref_GetCashSymbol + FormatFloat('####0.00', expListQuery.totAmount);
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Handle Action Execute'}

procedure tExpenseList_EditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_CLOSE : Close();
      CMD_EDIT: Edit();
      CMD_SAVE: Save();
      CMD_CANCEL: Cancel();
      CMD_NEW: New();
      CMD_DELETE: Delete();
      CMD_EXPENSE_EDIT_TYPES: EditExpenseTypes();
      CMD_HELP: AvoBaseHelp_Execute('ExpenseList_EditForm');
   end;
end;

procedure tExpenseList_EditForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_SAVE,CMD_CANCEL : Enabled := ( expQuery.State in [dsEdit, dsInsert]);
         CMD_NEW,CMD_CLOSE : Enabled := ( expQuery.State in [dsBrowse] );
         CMD_EDIT, CMD_DELETE : Enabled := ( expQuery.State in [dsBrowse]) AND ( expListQuery.RecordCount <> 0);
      end;
   if ( expQuery.State in [dsEdit, dsInsert] ) then
      dataListGrid.Enabled := False
   else
      dataListGrid.Enabled := true;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Methods and Procedures'}

procedure tExpenseList_EditForm.UpdateQuery;
begin
   expListQuery.Update();
   PercentForm_Free();
end;

function tExpenseList_EditForm.CanSave: string;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if ( expEditForm.Amount = 0 ) then
   	errMsg := 'Expense Amount cannot be a 0 amount.';
   //
   result := errMsg;
end;

function tExpenseList_EditForm.Check_CanCreate: boolean;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if (  Expense_ExpenseTypeCount = 0 ) then
   	errMsg := 'You must first create at least one Expense Type.';
   //
   if ( errMsg <> '' ) then
   	AvoBaseDialog('Unable To Proceed', errMsg, mtError, [mbOk], 0);
   //
   result := ( errMsg = '');
end;

procedure tExpenseList_EditForm.View;
begin
end;

procedure tExpenseList_EditForm.Save;
var
   errMsg : string;
begin
   errMsg := CanSave();
   if ( errMsg = '' ) then
   begin
      expEditForm.Enabled := false;
      //
      expQuery.SetFieldByName('AMOUNT', expEditForm.Amount);
      expQuery.SetFieldByName('MOPDATE', expEditForm.MopDate);
      expQuery.SetFieldByName('MOPTYPE', expEditForm.MopType);
      expQuery.SetFieldByName('MOPVALUE', expEditForm.MopValue);
      expQuery.SetFieldByName('ET_ID', expEditForm.ExpTypeID);
      expQuery.SetFieldByName('TAXDED', expEditForm.db_taxded.Checked);
      expQuery.SetFieldByName('EDESC', expEditForm.Edesc);
      //
      expQuery.Post();
      //
      DataListGrid.Enabled := True;
      DataListGrid.Repaint();
      expListQuery.Update();
      expListQuery.Locate('ID', expQuery.GetFieldByName('ID').AsString, [loCaseInsensitive]);
   end else
      AvoBaseDialog('Unable to Save', errMsg, mtError, [mbok], 0);
end;

procedure tExpenseList_EditForm.Delete;
begin
   if AvoBaseDialog('Delete Expense', 'Expense Date ' + DateToStr(expListQuery.FieldByName('MOPDATE').AsDateTime) +
      ' Amount ' + Pref_GetCashSymbol + expListQuery.FieldByName('AMOUNT').AsString + #13 + #13 +
      'Are you sure you want to Delete this Expense?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      Expense_DeleteExpenseByExpenseID( expListQuery.FieldByName('ID').AsString );
      expListQuery.Update();
      PutEditFormData();
   end;
end;

procedure tExpenseList_EditForm.Edit;
begin
   expQuery.Load(expListQuery.FieldByName('ID').AsString);
   expQuery.Edit();
   //
   expEditForm.Enabled := True;
end;

procedure tExpenseList_EditForm.EditExpenseTypes;
begin
   Preference_EditExpenseTypes();
   PutEditFormData();
end;

procedure tExpenseList_EditForm.New;
begin
	if ( Check_CanCreate ) then
   begin
      expEditForm.Enabled := true;
      expQuery.Append();
      expQuery.SetFieldByName('ID', masterData.NewDBGuid);
      expQuery.SetFieldByName('ORG_ID', fOrgID);
      expQuery.SetFieldByName('C_ID', fCycleID);
      expQuery.SetFieldByName('E_ID', fExpID);
      expQuery.SetFieldByName('TAXDED', false);
      expEditForm.Clear();
      expEditForm.ID := expQuery.GetFieldByName('ID').AsString;
   end;
end;

procedure tExpenseList_EditForm.Cancel;
begin
   if AvoBaseDialog('Cancel Expense Edit', 'Cancel changes to this Expense?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      expQuery.Cancel();
      PutEditFormData();
      DataListGrid.Enabled := True;
      DataListGrid.Repaint();
   end;
end;

procedure tExpenseList_EditForm.PutEditFormData;
begin
   expEditForm.Enabled := false;
   expEditForm.Clear();
   expEditForm.ID := expListQuery.FieldByName('ID').AsString;
   expEditForm.Amount := expListQuery.FieldByName('AMOUNT').AsCurrency;
   expEditForm.MopDate := expListQuery.FieldByName('MOPDATE').AsDateTime;
   expEditForm.MopType := expListQuery.FieldByName('MOPTYPE').AsInteger;
   expEditForm.MopValue := expListQuery.FieldByName('MOPVALUE').AsString;
   expEditForm.ExpTypeID := expListQuery.FieldByName('ET_ID').AsString;
   expEditForm.db_taxded.Checked := expListQuery.FieldByName('TAXDED').AsBoolean;
   expEditForm.Edesc := expListQuery.FieldByName('EDESC').AsString;
   expEditForm.OrgID := fOrgID;
   expEditForm.CycleID := fCycleID;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



end.

