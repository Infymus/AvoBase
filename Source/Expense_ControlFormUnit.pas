 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Expense_ControlFormUnit;

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   img_storageformunit,
   EncryptUnit,
   VerificationUnit,
   AvoBase_PercentFormUnit,
   Avobase_RegisterDialogFormUnit,
   avobase_dialogformunit,
   avobase_helpformunit,
   avobase_baseform_menuunit,
   avobase_baseform_standardunit,
   RecordStructureUnit,
   //
   Expense_ListFormUnit,
   Report_Expense_ByCycleFormUnit,
   masterdata_BaseDataClassUnit,
   masterDataUnit,
   Preference_ExpenseTypeFormUnit,
	//
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs;

const
	EXPENSE_LIST = 1000;
   EXPENSE_EDIT = 1001;

type
	tControlForm_Expense = class(TForm)
   	MAIN_DOCK_PANEL: TScrollBox;
      procedure HandleCloseForm(Sender: TObject);
   private
      function tygHjehtU88jge: vEnResultRec;
   public
   	frm_ExpenseList : TExpenseListForm;
      function Expense_EnableDisableButtons : boolean;
      //
      procedure ExpenseNew();
      procedure ExpenseEdit();
      procedure ExpenseView();
      procedure ExpensePrint();
      procedure ExpenseHelp();
      procedure ExpenseReports();
      procedure ExpenseLoadByCycle();
      procedure GlobalRefreshEvent();
      procedure ExpenseQuickAdd();
      procedure EditExpenseTypes();
      //
   	procedure StartForm;
      procedure StopForm;
      procedure DockForm(inForm: tForm; inFormType : integer);
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Expense.DockForm(inForm: tForm; inFormType: integer);
begin
	inForm.ManualDock(MAIN_DOCK_PANEL, nil, alClient);
   inForm.BorderStyle := bsNone;
   inForm.Left := (MAIN_DOCK_PANEL.Width - MAIN_DOCK_PANEL.Width) div 2;
   inForm.Top := (MAIN_DOCK_PANEL.Height - MAIN_DOCK_PANEL.Height) div 2;
   inForm.WindowState := wsMaximized;
   inForm.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
   inForm.BorderIcons := [];
   inForm.Position := poDefault;
   inForm.OnDestroy := HandleCloseForm;
   inForm.Tag := inFormType;
end;


procedure tControlForm_Expense.ExpenseEdit;
begin
   frm_ExpenseList.Edit();
end;

procedure tControlForm_Expense.ExpenseHelp;
begin
   AvoBaseHelp_Execute('ControlForm_Expense');
end;

procedure tControlForm_Expense.ExpenseLoadByCycle;
begin
   frm_ExpenseList.LoadByCycle();
end;

procedure tControlForm_Expense.ExpenseNew;
begin
   frm_ExpenseList.New();
end;

procedure tControlForm_Expense.ExpensePrint;
var
   rpt_Expense_ByCycle : TReport_Expense_ByCycle;
   errMsg : string;
begin
   rpt_Expense_ByCycle := TReport_Expense_ByCycle.Create( Application );
   // Setup Options
   rpt_Expense_ByCycle.SetOptions(
      frm_ExpenseList.ExpenseListOrgID,
      frm_ExpenseList.ExpenseListCycleID,
      frm_ExpenseList.ExpenseListCycleID );
   // Check for Errors
   errMsg := rpt_Expense_ByCycle.CanPrint;
   if ( errMsg = '' ) then
   begin
      rpt_Expense_ByCycle.QReport.Preview();
   end else
      AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
   // Free it
   if (rpt_Expense_ByCycle <> NIL) then
      FreeAndNil(rpt_Expense_ByCycle);
end;


procedure tControlForm_Expense.ExpenseReports;
begin
   ShowMessage('EXPENSECONTROL : REPORTS');
end;

procedure tControlForm_Expense.ExpenseView;
begin
   frm_ExpenseList.View();
end;

function tControlForm_Expense.Expense_EnableDisableButtons: boolean;
begin
   result := true;
   if ( frm_ExpenseList <> NIL ) then
      if ( frm_ExpenseList.Count = 0 ) then
         result := false;
end;

procedure tControlForm_Expense.GlobalRefreshEvent;
begin
   if ( frm_ExpenseList <> NIL ) then
      frm_ExpenseList.GlobalRefreshEvent();
end;

procedure tControlForm_Expense.HandleCloseForm(Sender: TObject);
begin
  case tForm(Sender).Tag of
    EXPENSE_LIST: frm_ExpenseList := Nil;
  end;
end;

procedure tControlForm_Expense.StartForm;
begin
	if (frm_ExpenseList = NIL) then
   begin
   	frm_ExpenseList := TExpenseListForm.Create(Application);
      //
      DockForm( frm_ExpenseList, EXPENSE_LIST );
   end;
   //
   if (frm_ExpenseList <> NIL) then
   	frm_ExpenseList.Show();
end;

procedure tControlForm_Expense.StopForm;
begin
	if (frm_ExpenseList <> NIL) then
   	frm_ExpenseList.Close();
end;

function tControlForm_Expense.tygHjehtU88jge: vEnResultRec;
//var ty345Gt : tKeyVerif;
begin
   result.noKey := false;
   result.exKey := false;
   (*
   //
   ty345Gt := tKeyVerif.Create;
   //
   if NOT(ty345Gt.Tk4726TuI) then
      result.noKey := true;
	if (ty345Gt.Tk4726TuI) AND NOT(ty345Gt.Tk4726Tu1) then
      result.exKey := true;
   //
   FreeAndNil(ty345Gt);
   *)
end;

procedure tControlForm_Expense.ExpenseQuickAdd;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#65 + #100 + #100 + #105 + #110 + #103 + #32 + #69 + #120 + #112 + #101 +
         #110 + #115 + #101 + #115 + #32 + #111 + #114 + #32 + #69 + #97 + #114 + #110 + #105 + #110 +
         #103 + #115 + #32 + #111 + #117 + #116 + #115 + #105 + #100 + #101 + #32 + #116 + #104 +
         #101 + #32 + #101 + #100 + #105 + #116 + #111 + #114 + #32 + #105 + #115 + #32 + #114 +
         #101 + #115 + #101 + #114 + #118 + #101 + #100 + #32 + #102 + #111 + #114 + #32 + #114 +
         #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 + #32 + #65 + #118 + #111 +
         #66 + #97 + #115 + #101 + #32 + #67 + #117 + #115 + #116 + #111 + #109 + #101 + #114 +
         #115 + #32 + #111 + #110 + #108 + #121 + #46); {Adding Expenses or Earnings outside the
         editor is reserved for registered AvoBase Customers only.}
   end else
      if ( frm_ExpenseList <> NIL ) then
         frm_ExpenseList.ExpenseQuickAdd();
end;

procedure tControlForm_Expense.EditExpenseTypes;
begin
   Preference_EditExpenseTypes();
end;



end.
