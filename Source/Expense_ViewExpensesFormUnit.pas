 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Expense_ViewExpensesFormUnit;

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
   ToolBox_PreferenceToolBoxUnit,
   MasterData_ExpenseListEditUnit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   Cycle_SelectOrgAndCycleFormUnit,
   toolbox_orgtoolboxunit,
   toolbox_ExpenseToolBoxUnit,
   toolbox_cycletoolboxunit,
   AvoBase_ToolBarUnit,
   Expense_ItemEditFormUnit,
   AvoBase_BaseForm_MenuUnit,
   Preference_ExpenseTypeFormUnit,
   Report_Expense_ByCycleFormUnit,
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
   tExpense_ViewExpensesForm = class(TAvoBase_BaseForm_Menu)
    db_nav_dock: TPanel;
   private
      fELID : string;
      fOrgID : string;
      fCycleID : string;
   	ExpenseListGrid : tAvoBaseDBGrid;
      ExpenselListQuery : tMasterDataExpenseListEdit;
      dbNavTool : tAvoBaseDBNavigationTool;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure StartUpForm();
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      function fGetOrgID : string;
      function fGetCycleStartID : string;
      function fGetCycleEndID : string;
   public
      procedure PrintList();
   	procedure StatBarUpdate();
      property OrgID : string read fGetOrgID;
      property CycleStartID : string read fGetCycleStartID;
      property CycleEndID : string read fGetCycleEndID;
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inELID : string); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tExpense_ViewExpensesForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inELID : string);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   fELID := inELID;
   //
   ExpenselListQuery := tMasterDataExpenseListEdit.Create( masterData, fELID);
   //
   ExpenseListGrid := tAvoBaseDBGrid.Create( nil, BASE_DOCK_PANEL, ExpenselListQuery, '' );
   ExpenseListGrid.Clear;
   ExpenseListGrid.Add(ExpenselListQuery.FieldByName('MOPDATE'), 'DATE', 70, clRed, [fsBold], taLeftJustify);
   ExpenseListGrid.Add(ExpenselListQuery.FieldByName('EXPTYPE'), 'EXPENSE TYPE', 160, clBlack, [fsBold], taLeftJustify);
   ExpenseListGrid.Add(ExpenselListQuery.FieldByName('EDESC'), 'DESCRIPTION', 190, clBlue, [fsBold], taLeftJustify);
   ExpenseListGrid.Add(ExpenselListQuery.FieldByName('AMOUNT'), 'AMOUNT', 100, clBlack, [fsBold], taRightJustify);
   ExpenseListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, db_nav_dock, ExpenselListQuery);
   dbNavTool.Align := alRight;
   //
   fOrgID := Expense_GetOrgIDByExpenseListID( inELID );
   fCycleID := Expense_GetCycleIDByExpenseListID( inELID );
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Expense List For ' + Org_GetOrgNameByOrgID( fOrgID ) +
      ' | Sales Cycle ' + Cycle_GetCycleNameByCycleID( fCycleID );
   //
	StartUpForm();
   StatBarUpdate();
end;

function tExpense_ViewExpensesForm.fGetCycleEndID: string;
begin
   result := ExpenselListQuery.FieldByName('C_ID').AsString;
end;

function tExpense_ViewExpensesForm.fGetCycleStartID: string;
begin
   result := ExpenselListQuery.FieldByName('C_ID').AsString;
end;

function tExpense_ViewExpensesForm.fGetOrgID: string;
begin
   result := ExpenselListQuery.FieldByName('ORG_ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExpense_ViewExpensesForm.CloseForm;
begin
	FreeAndNil(ExpenseListGrid);
   FreeAndNil(dbNavTool);
   freeAndNil(ExpenselListQuery);
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExpense_ViewExpensesForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_CLOSE : CloseForm();
      CMD_PRINT_LIST : PrintList();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExpense_ViewExpensesForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   // we do absollutely nothing here because there isn't anything to do, this is a  modal, read only form.
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExpense_ViewExpensesForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExpense_ViewExpensesForm.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
   CreateButtonSep;
   CreateButton( CMD_PRINT_LIST );
   //
   ExpenselListQuery.Update();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExpense_ViewExpensesForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(ExpenselListQuery.RecNo) + ' of ' + IntToStr(ExpenselListQuery.RecordCount);
   StatusBar.Panels[1].Text := 'Total Expenses: ' + Pref_GetCashSymbol + FormatFloat('####0.00', ExpenselListQuery.totAmount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExpense_ViewExpensesForm.PrintList;
var
   rpt_Expense_ByCycle : TReport_Expense_ByCycle;
   errMsg : string;
begin
   rpt_Expense_ByCycle := TReport_Expense_ByCycle.Create( Application );
   // Setup Options
   rpt_Expense_ByCycle.SetOptions( OrgID, CycleStartID, CycleEndID );
   // Check for Errors
   errMsg := rpt_Expense_ByCycle.CanPrint;
   if ( errMsg = '' ) then
   begin
      // Display it
      rpt_Expense_ByCycle.QReport.Preview();
   end else
      AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
   // Free it
   if (rpt_Expense_ByCycle <> NIL) then
      FreeAndNil(rpt_Expense_ByCycle);
end;

end.
