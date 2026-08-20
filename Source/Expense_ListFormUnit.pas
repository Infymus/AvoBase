 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Expense_ListFormUnit;

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
      Expense_ItemEditFormUnit,

   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   MasterData_ExpenseListUnit,
   toolbox_orgtoolboxunit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   Cycle_SelectOrgAndCycleFormUnit,
   toolbox_ExpenseToolBoxUnit,
   toolbox_cycletoolboxunit,
   Expense_ListEditFormUnit,
   Expense_ViewExpensesFormUnit,
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
   jpeg;

type
  TExpenseListForm = class(TAvobase_BaseForm_List)
    Label2: TLabel;
    OrgCombo: TComboBox;
    procedure OrgComboChange(Sender: TObject);
  private
      expListQuery : tMasterDataExpenseList;
      expViewForm : tExpense_ViewExpensesForm;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleDoubleClick( sender : tObject );
      function fGetExpenseListID : string;
      function Check_CanCreate: boolean;
      function fGetExpenseListCycleID: string;
      function fGetExpenseListOrgID: string;
      function fGetCount : integer;
      function fGetORG_ID : string;
      function fGetC_ID : string;
      function fGetEL_ID : string;
   public
      //
      procedure UpdateQuery();
      //
      procedure New();
      procedure Edit();
      procedure View();
      procedure LoadByCycle();
      procedure GlobalRefreshEvent();
      procedure Recalculate();
      procedure ExpenseQuickAdd();
      //
      property ExpenseListID : string read fGetExpenseListID;
      property ExpenseListCycleID : string read fGetExpenseListCycleID;
      property ExpenseListOrgID : string read fGetExpenseListOrgID;
      property Count : integer read fGetCount;
      property ORG_ID : string read fGetORG_ID;
      property C_ID : string read fGetC_ID;
      property EL_ID : string read fGetEL_ID;
      //
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Destroy }

constructor TExpenseListForm.create(owner : TComponent);
begin
	inherited create( Nil, 'Expenses', false, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   expListQuery := tMasterDataExpenseList.Create( masterData);
   //
   gridDataSource.DataSet := expListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( expListQuery, 'FNAME' );
   DataListGrid.Clear;
   DataListGrid.Add(expListQuery.FieldByName('ORGNAME'), 'ORG', 100, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(expListQuery.FieldByName('CYCLENAME'), 'CYCLE', 100, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(expListQuery.FieldByName('TOTITEMS'), 'ITEMS', 100, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(expListQuery.FieldByName('TOTAMT'), 'AMOUNT', 100, clBlack, [fsBold], taRightJustify);
   DataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( expListQuery );
   //
   Org_ComboBox_FillActiveOrgs( 'All', OrgCombo );
   //
   UpdateQuery();
end;

destructor TExpenseListForm.Destroy;
begin
	expListQuery.Close();
   freeAndNil(expListQuery);
   //
	inherited
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'PROPERTIES'}

function TExpenseListForm.fGetCount: integer;
begin
   result := expListQuery.RecordCount;
end;

function TExpenseListForm.fGetExpenseListCycleID: string;
begin
   result := expListQuery.FieldByName('C_ID').AsString;
end;

function TExpenseListForm.fGetExpenseListID: string;
begin
   result := expListQuery.FieldByName('ID').AsString;
end;

function TExpenseListForm.fGetExpenseListOrgID: string;
begin
   result := expListQuery.FieldByName('ORG_ID').AsString;
end;

function TExpenseListForm.fGetEL_ID: string;
begin
   result := expListQuery.FieldByName('ID').AsString;
end;

function TExpenseListForm.fGetORG_ID: string;
begin
   result := expListQuery.FieldByName('ORG_ID').AsString;
end;

function TExpenseListForm.fGetC_ID: string;
begin
   result := expListQuery.FieldByName('C_ID').AsString;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


procedure TExpenseListForm.GlobalRefreshEvent;
begin
   Recalculate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.HandleDoubleClick(sender: tObject);
begin
	Edit();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(expListQuery.RecNo) + ' of ' + IntToStr(expListQuery.RecordCount);
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.UpdateQuery;
begin
   if ( OrgCombo.Text = 'All' ) then
      expListQuery.Update()
   else
      expListQuery.Update( Org_GetOrgIDByOrgName( OrgCombo.Text ));
   //
   PercentForm_Free();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.View;
begin
   expViewForm := tExpense_ViewExpensesForm.Create( Application, 'Expense', True, expListQuery.FieldByName('ID').AsString);
   expViewForm.ShowModal();
   FreeAndNil(expViewForm);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.Edit;
var
   ExpenseEdit : tExpenseList_EditForm;
   edID : string;
begin
   if ( expListQuery.RecordCount <> 0 ) then
   begin
      ExpenseEdit := tExpenseList_EditForm.Create( Application, expListQuery.FieldByName('ID').AsString);
      edID := expListQuery.FieldByName('ID').AsString;
      ExpenseEdit.ShowModal;
      // do NOT FREE HERE, it is ALREADY DONE via caFREE.
      UpdateQuery();
      expListQuery.Locate('ID', edID, [loCaseInsensitive]);
   end else
      AvoBaseDialog('Cannot Edit Expense List', 'You must first create an Expense List for a ' +
         ' Sales Organization, Sales Cycle and Sales Cycle Number. ', mtError, [mbok], 0);
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TExpenseListForm.Check_CanCreate: boolean;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if ( Cycle_GetCycleCount = 0 ) then
   	errMsg := 'You must first create a Sales Cycle.';
   //
   if ( Org_GetOrgCount = 0 ) then
   	errMsg := 'You must first create a Sales Organization.';
   //
   if ( Expense_ExpenseTypeCount = 0 ) THEN
      errMsg := 'You must first create an Expense Type.';
   //
   if ( errMsg <> '' ) then
   	AvoBaseDialog('Unable To Proceed', errMsg, mtError, [mbOk], 0);
   //
   result := ( errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.New;
var
   orgSelectForm : TOrgSelectOrgAndCycleForm;
   cycleID : string;
   orgID : string;
   cycleName : string;
   errMsg : string;
   fNewID : string;
   fExpListQuery : tMasterData_BaseDataClass;
   ExpenseEdit : tExpenseList_EditForm;
begin
	if ( Check_CanCreate ) then
   begin
      orgSelectForm := TOrgSelectOrgAndCycleForm.Create( Application );
      orgSelectForm.ShowModal;
      if ( orgSelectForm.FormResult = mrOk ) then
      begin
         cycleID := orgSelectForm.CycleID;
         orgID := orgSelectForm.OrgID;
         cycleName := Cycle_GetCycleNameByCycleID( cycleID );
         //
         errMsg := '';
         //
         if Expense_ExpenseListExistsByCycleID( cycleID ) then
            errMsg := 'A Sales Cycle Expense List already exists with that Organization, Sales Cycle Year and ' +
               'Sales Cycle Number.';
         //
         if ( errMsg <> '' ) then
         begin
            AvoBaseDialog('Unable to Create Expense List', errMsg, mtError, [mbOk], 0);
         end else
            begin
               PercentForm_Create('Creating New Expense List - One Moment Please...', 0, 0);
               //
               fExpListQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Expense_List );
               //
               fExpListQuery.Append();
               fNewID := fExpListQuery.GetFieldByName('ID').AsString;
               fExpListQuery.SetFieldByName('ORG_ID', orgID);
               fExpListQuery.SetFieldByName('CYCLENAME', cycleName);
               fExpListQuery.SetFieldByName('C_ID', cycleID);
               fExpListQuery.Post();
               //
               FreeAndNil(fExpListQuery);
               //
               Expense_AddAutoExpenseTypesToExpenseList( fNewID, orgID, cycleID );
               //
               PercentForm_Free();
               //
               expListQuery.Close();
               expListQuery.Open();
               expListQuery.Locate('ID', fNewID, [loCaseInsensitive]);
               // now put them into edit mode
               // mhoenie 7/18/2012
               ExpenseEdit := tExpenseList_EditForm.Create( Application, fNewID);
               ExpenseEdit.ShowModal;
               // do NOT FREE HERE, it is ALREADY DONE via caFREE.
               UpdateQuery();
               expListQuery.Locate('ID', fNewID, [loCaseInsensitive]);
            end;
      end;
   end;
   // DONT DO THIS ---> IT IS DONE FOR US IN THE INHERITED FORM: FreeAndNil(orgSelectForm);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.OrgComboChange(Sender: TObject);
begin
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.Recalculate;
var
   ID : string;
begin
   ID := expListQuery.FieldByName('ID').AsString;
   expListQuery.Close();
   expListQuery.Open();
   expListQuery.Locate('ID', ID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.LoadByCycle;
var
   orgSelectForm : TOrgSelectOrgAndCycleForm;
   cycleID : string;
   orgID : string;
   elID : string;
   ExpenseEdit : tExpenseList_EditForm;
begin
   orgSelectForm := TOrgSelectOrgAndCycleForm.Create( Application );
   orgSelectForm.ShowModal;
   if ( orgSelectForm.FormResult = mrOk ) then
   begin
      cycleID := orgSelectForm.CycleID;
      orgID := orgSelectForm.OrgID;
      //
      elID := Expense_GetExpenseIDByCycleID( cycleID );
      //
      if ( elID <> '' ) then
      begin
         ExpenseEdit := tExpenseList_EditForm.Create( Application, elID);
         ExpenseEdit.ShowModal;
         // do NOT FREE HERE, it is ALREADY DONE via caFREE.
         UpdateQuery();
         expListQuery.Locate('ID', elID, [loCaseInsensitive]);
      end else
         AvoBaseDialog('Unable to locate Expense List',
            'There is no Expense List for ' + Org_GetOrgNameByOrgID( orgID ) +
            ' Sales Cycle ' + Cycle_GetCycleNameByCycleID( cycleID ), mtInformation, [mbok], 0);
   end;
   // DONT DO THIS ---> IT IS DONE FOR US IN THE INHERITED FORM: FreeAndNil(orgSelectForm);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TExpenseListForm.ExpenseQuickAdd;
var
   editForm : tExpense_EditForm;
   expQuery : tMasterData_BaseDataClass;
begin
	if ( Check_CanCreate ) then
   if ( Count <> 0 ) then
   begin
      editForm := tExpense_EditForm.Create( Application, NIL );
      editForm.Clear();
      //
      expQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Expense);
      expQuery.Append();
      expQuery.SetFieldByName('ID', masterData.NewDBGuid);
      expQuery.SetFieldByName('ORG_ID', ORG_ID);
      expQuery.SetFieldByName('C_ID', C_ID);
      expQuery.SetFieldByName('E_ID', EL_ID);
      expQuery.SetFieldByName('TAXDED', false);
      editForm.ID := expQuery.GetFieldByName('ID').AsString;
      editForm.CycleID := C_ID;
      editForm.OrgID := ORG_ID;
      editForm.ShowModal();
      //
      if ( editForm.CloseAction = mrCancel ) then
         expQuery.Cancel();
      if ( editForm.CloseAction = mrOk ) then
      begin
         expQuery.SetFieldByName('ID', editForm.ID);
         expQuery.SetFieldByName('ORG_ID', editForm.OrgID);
         expQuery.SetFieldByName('E_ID', ExpenseListID);
         expQuery.SetFieldByName('C_ID', editForm.CycleID);
         expQuery.SetFieldByName('ET_ID', editForm.ExpTypeID);
         expQuery.SetFieldByName('TAXDED', editForm.Taxed);
         expQuery.SetFieldByName('MOPTYPE', editForm.MopType);
         expQuery.SetFieldByName('MOPVALUE', editForm.OrgID);
         expQuery.SetFieldByName('AMOUNT', editForm.Amount);
         expQuery.SetFieldByName('MOPDATE', editForm.MopDate);
         expQuery.SetFieldByName('EDESC', editForm.Edesc);
         //
         expQuery.Post();
      end;
      //
      expQuery.Close();
      FreeAndNil(expQuery);
      FreeAndNil(editForm);
      Recalculate();
   end else
      AvoBaseDialog('Cannot Edit Expense List', 'You must first create an Expense List for a ' +
         ' Sales Organization, Sales Cycle and Sales Cycle Number. ', mtError, [mbok], 0);
end;


end.


