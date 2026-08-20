 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_EarningTypeFormUnit;

interface uses
   preference_Earningtypeeditformunit,
   MasterData_EarningTypeListUnit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   inifileunit,
	actionunit,
   masterdata_BaseDataClassUnit,
   AvoBase_HelpFormUnit,
   masterdata_basegridunit,
   recordstructureunit,
   errorresultunit,
   masterdata_navigationtoolunit,
   avobase_toolbarunit,
   Avobase_BaseForm_ListUnit,
   preference_baseformunit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   toolbox_orgtoolboxunit,
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
  TPref_EarningTypesForm = class(TPrefBaseForm)
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
   	EarningTypeEditForm : TPref_EarningTypeEditForm;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn;State: TGridDrawState);
      procedure HandleDoubleClick( sender : tObject );
   public
   	fEarningTypeQuery : tMasterData_BaseDataClass;
      EarningTypeListQuery : tMasterDataEarningTypeList;
      EarningTypeListGrid : tAvoBaseDBGrid;
      dbNavTool : tAvoBaseDBNavigationTool;
      ExpenseTypeGridToolBar : tAvoBaseToolBar;
   	procedure StatBarUpdate();
      procedure New();
      procedure Edit();
      procedure Recalculate;
      procedure GlobalRefreshEvent();
   end;

Procedure Preference_EditEarningTypes;

implementation

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

Procedure Preference_EditEarningTypes;
var
   PrefForm_EarningTypes : TPref_EarningTypesForm;
begin
   PrefForm_EarningTypes := TPref_EarningTypesForm.Create(nil, PREF_EarningTYPES);
   PrefForm_EarningTypes.ExpenseTypeGridToolBar.CreateButtonSep();
   PrefForm_EarningTypes.ExpenseTypeGridToolBar.CreateButton( CMD_CLOSE );
   PrefForm_EarningTypes.Border := 1;
   PrefForm_EarningTypes.ShowModal();
   FreeAndNil(PrefForm_EarningTypes);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.FormCreate(Sender: TObject);
begin
	inherited;
   //
   fEarningTypeQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Earning_Type);
   //
   EarningTypeListQuery := tMasterDataEarningTypeList.Create( masterData );
   //
   EarningTypeListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, EarningTypeListQuery, 'NAME' );
   //
   EarningTypeListGrid.Clear;
   EarningTypeListGrid.Add(EarningTypeListQuery.FieldByName('ORG'), 'ORG', 120, clRed, [fsBold], taLeftJustify);
   EarningTypeListGrid.Add(EarningTypeListQuery.FieldByName('NAME'), 'NAME', 340, clBlack, [fsBold], taLeftJustify);
   //
   EarningTypeListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   EarningTypeListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;
   EarningTypeListGrid.OnDblClick := HandleDoubleClick;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, EarningTypeListQuery);
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

procedure TPref_EarningTypesForm.GlobalRefreshEvent;
begin
   Org_ComboBox_FillActiveOrgs('ALL', OrgCombo);
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FreeAndNil(fEarningTypeQuery);
   FreeAndNil(EarningTypeListGrid);
   FreeAndNil(EarningTypeListQuery);
   FreeAndNil(dbNavTool);
   FreeAndNil(ExpenseTypeGridToolBar);
   //
   inherited;
end;


(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)


procedure TPref_EarningTypesForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
   	CMD_EDIT: Edit();
      CMD_NEW: New();
      CMD_CLOSE: Close();
      CMD_HELP: AvoBaseHelp_Execute('Pref_EarningTypesForm');
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_EDIT : enabled := (EarningTypeListQuery.RecordCount <> 0) AND ( Org_GetOrgCount <> 0 );
      end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.HandleDoubleClick(sender: tObject);
begin
   Edit();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
	if (NOT EarningTypeListQuery.FieldByName('ISACTIVE').AsBoolean) then
   begin
      EarningTypeListGrid.Canvas.Font.Color := clGrayText;
      EarningTypeListGrid.Canvas.Font.Style := [fsItalic];
      EarningTypeListGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.New;
var
	errRec : tErrorResult;
begin
   if ( Org_GetOrgCount = 0 ) then
   begin
      AvoBaseDialog('No Sales Organizations', 'A Sales Organization must exist before adding Earning Types.', mtError,
      [mbOk], 0);
   end else
      begin
         errRec := fEarningTypeQuery.Append();
         if NOT (errRec.errorResult) then
         begin
            fEarningTypeQuery.SetFieldByname('ISACTIVE', true);
            fEarningTypeQuery.SetFieldByName('ORG_ID', Org_GetFirstActiveOrg);
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
            EarningTypeEditForm := TPref_EarningTypeEditForm.Create( Application, 'New Earning Type', true, fEarningTypeQuery);
            EarningTypeEditForm.IsNew := true;
            try
               EarningTypeEditForm.ShowModal();
            finally
               FreeAndNil(EarningTypeEditForm);
            end
         end else
            Error_Log(errRec, true);
         Recalculate();
      end;
end;

procedure TPref_EarningTypesForm.OrgComboChange(Sender: TObject);
begin
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.Edit;
var
	errRec : tErrorResult;
begin
	errRec := fEarningTypeQuery.Load( EarningTypeListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
   	EarningTypeEditForm := TPref_EarningTypeEditForm.Create( Application, 'Edit Earning Type', true, fEarningTypeQuery);
      EarningTypeEditForm.IsNew := false;
      try
      	EarningTypeEditForm.ShowModal();
      finally
      	FreeAndNil(EarningTypeEditForm);
      end
   end else
   	Error_Log(errRec, true);
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(EarningTypeListQuery.RecNo) + ' of ' + IntToStr(EarningTypeListQuery.RecordCount);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_EarningTypesForm.Recalculate;
var
   findID : string;
begin
   findID := EarningTypeListQuery.FieldByName('ID').AsString;
   if ( OrgCombo.Text = 'ALL' ) then
      EarningTypeListQuery.OrgID := ''
   else
      EarningTypeListQuery.OrgID := Org_GetOrgIDByOrgName( OrgCombo.Text );
   //
   EarningTypeListQuery.Update();
   EarningTypeListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;


(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.

