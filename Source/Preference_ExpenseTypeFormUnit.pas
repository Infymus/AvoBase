 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_ExpenseTypeFormUnit;

interface uses
   preference_expensetypeeditformunit,
   MasterData_ExpenseTypeListUnit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   inifileunit,
	actionunit,
   masterdata_BaseDataClassUnit,
  recordstructureunit,
   masterdata_basegridunit,
   errorresultunit,
   masterdata_navigationtoolunit,
   avobase_toolbarunit,
   Avobase_BaseForm_ListUnit,
   preference_baseformunit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   toolbox_orgtoolboxunit,
   AvoBase_HelpFormUnit,
   //
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
   actnlist,
   Buttons,
   INIFiles,
   ExtCtrls,
   ComCtrls,
   DBCtrls,
   Mask,
   Grids,
   DBGrids,
   DB,
   Menus,
   DBTables,
   OleCtrls,
   SHDocVw,
   StdActns,
   jpeg;

type
  TPref_ExpenseTypesForm = class(TPrefBaseForm)
    BASE_NAVBAR_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    OrgCombo: TComboBox;
    StatusBar: TStatusBar;
    VIEWGRID_DOCK_PANEL: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OrgComboChange(Sender: TObject);
   private
   	ExpenseTypeEditForm : TPref_ExpenseTypeEditForm;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn;State: TGridDrawState);
      procedure HandleDoubleClick( sender : tObject );
   public
   	fExpenseTypeQuery : tMasterData_BaseDataClass;
      ExpenseTypeListQuery : tMasterDataExpenseTypeList;
      ExpenseTypeListGrid : tAvoBaseDBGrid;
      dbNavTool : tAvoBaseDBNavigationTool;
      ExpenseTypeGridToolBar : tAvoBaseToolBar;
   	procedure StatBarUpdate();
      procedure New();
      procedure Edit();
      procedure Recalculate;
      procedure GlobalRefreshEvent();
   end;

// the following is so this can be called from anywhere, NOT just inside preferences
Procedure Preference_EditExpenseTypes;

implementation

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

Procedure Preference_EditExpenseTypes;
var
   PrefForm_ExpenseTypes : TPref_ExpenseTypesForm;
begin
   PrefForm_ExpenseTypes := TPref_ExpenseTypesForm.Create(nil, PREF_EXPENSETYPES);
   PrefForm_ExpenseTypes.ExpenseTypeGridToolBar.CreateButtonSep();
   PrefForm_ExpenseTypes.ExpenseTypeGridToolBar.CreateButton( CMD_CLOSE );
   PrefForm_ExpenseTypes.Border := 1;
   PrefForm_ExpenseTypes.ShowModal();
   FreeAndNil(PrefForm_ExpenseTypes);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.FormCreate(Sender: TObject);
begin
	inherited;
   //
   fExpenseTypeQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Expense_Type);
   //
   ExpenseTypeListQuery := tMasterDataExpenseTypeList.Create( masterData );
   //
   ExpenseTypeListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, ExpenseTypeListQuery, 'NAME' );
   //
   ExpenseTypeListGrid.Clear;
   ExpenseTypeListGrid.Add(ExpenseTypeListQuery.FieldByName('ORG'), 'ORG', 120, clRed, [fsBold], taLeftJustify);
   ExpenseTypeListGrid.Add(ExpenseTypeListQuery.FieldByName('NAME'), 'NAME', 340, clBlack, [fsBold], taLeftJustify);
   //
   ExpenseTypeListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   ExpenseTypeListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;
   ExpenseTypeListGrid.OnDblClick := HandleDoubleClick;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, ExpenseTypeListQuery);
   //
{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40),' + // organization
            'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
            'DESCR VARCHAR(40)',

}
   //
   ExpenseTypeGridToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   ExpenseTypeGridToolBar.actionList.OnUpdate := HandleActionListUpdate;
   ExpenseTypeGridToolBar.actionList.onActionEvent := HandleActionExecute;
   ExpenseTypeGridToolBar.Align := alClient;
   ExpenseTypeGridToolBar.CreateButton( CMD_HELP);
   ExpenseTypeGridToolBar.CreateButtonSep();
   ExpenseTypeGridToolBar.CreateButton( CMD_EDIT );
   ExpenseTypeGridToolBar.CreateButtonSep();
   ExpenseTypeGridToolBar.CreateButton( CMD_NEW );
   //
   StatBarUpdate();
   //
   Org_ComboBox_FillActiveOrgs( 'ALL', OrgCombo);
end;

procedure TPref_ExpenseTypesForm.GlobalRefreshEvent;
begin
   Org_ComboBox_FillActiveOrgs( 'ALL', OrgCombo);
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FreeAndNil(fExpenseTypeQuery);
   FreeAndNil(ExpenseTypeListGrid);
   FreeAndNil(ExpenseTypeListQuery);
   FreeAndNil(dbNavTool);
   FreeAndNil(ExpenseTypeGridToolBar);
   //
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
   	CMD_EDIT: Edit();
      CMD_NEW: New();
      CMD_CLOSE: Close();
      CMD_HELP: AvoBaseHelp_Execute('Pref_ExpenseTypesForm');
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_EDIT : enabled := (ExpenseTypeListQuery.RecordCount <> 0) AND ( Org_GetOrgCount <> 0 );
      end;
end;

procedure TPref_ExpenseTypesForm.HandleDoubleClick(sender: tObject);
begin
   Edit();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
	if (NOT ExpenseTypeListQuery.FieldByName('ISACTIVE').AsBoolean) then
   begin
      ExpenseTypeListGrid.Canvas.Font.Color := clGrayText;
      ExpenseTypeListGrid.Canvas.Font.Style := [fsItalic];
      ExpenseTypeListGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.New;
var
	errRec : tErrorResult;
begin
   if ( Org_GetOrgCount = 0 ) then
   begin
      AvoBaseDialog('No Sales Organizations', 'A Sales Organization must exist before adding Expense Types.', mtError,
      [mbOk], 0);
   end else
      begin
         errRec := fExpenseTypeQuery.Append();
         if NOT (errRec.errorResult) then
         begin
            fExpenseTypeQuery.SetFieldByname('ISACTIVE', true);
            fExpenseTypeQuery.SetFieldByName('ORG_ID', Org_GetFirstActiveOrg);
      {
            fFeeQuery.SetFieldByName('AUTOINV', true);
                  'ID VARCHAR(40), ' +
                  'ORG_ID VARCHAR(40), ' +
                  'ISACTIVE BOOLEAN, ' +
                  'NAME VARCHAR(50), ' +
                  'DESCR VARCHAR(200), ' +
                  'AUTOINV BOOLEAN, ' + // auto-add to invoice
                  'TAX BOOLEAN, ' +  // whether this is a line item taxation on the invoice
                  'AMOUNT MONEY',
      }
            ExpenseTypeEditForm := TPref_ExpenseTypeEditForm.Create( Application, 'New Expense Type', true, fExpenseTypeQuery);
            ExpenseTypeEditForm.IsNew := true;
            try
               ExpenseTypeEditForm.ShowModal();
            finally
               FreeAndNil(ExpenseTypeEditForm);
            end
         end else
            Error_Log(errRec, true);
         Recalculate();
      end;
end;

procedure TPref_ExpenseTypesForm.OrgComboChange(Sender: TObject);
begin
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.Edit;
var
	errRec : tErrorResult;
begin
	errRec := fExpenseTypeQuery.Load( ExpenseTypeListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
   	ExpenseTypeEditForm := TPref_ExpenseTypeEditForm.Create( Application, 'Edit Expense Type', true, fExpenseTypeQuery);
      ExpenseTypeEditForm.IsNew := false;
      try
      	ExpenseTypeEditForm.ShowModal();
      finally
      	FreeAndNil(ExpenseTypeEditForm);
      end
   end else
   	Error_Log(errRec, true);
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(ExpenseTypeListQuery.RecNo) + ' of ' + IntToStr(ExpenseTypeListQuery.RecordCount);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ExpenseTypesForm.Recalculate;
var
   findID : string;
begin
   findID := ExpenseTypeListQuery.FieldByName('ID').AsString;
   if ( OrgCombo.Text = 'ALL' ) then
      ExpenseTypeListQuery.OrgID := ''
   else
      ExpenseTypeListQuery.OrgID := Org_GetOrgIDByOrgName( OrgCombo.Text );
   //
   ExpenseTypeListQuery.Update();
   ExpenseTypeListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;


(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.

