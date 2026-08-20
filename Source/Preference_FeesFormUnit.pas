 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_FeesFormUnit;

interface uses
   preference_feeeditformunit,
   MasterData_feeListUnit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   inifileunit,
	actionunit,
   recordstructureunit,
   masterdata_BaseDataClassUnit,
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
  TPref_FeesForm = class(TPrefBaseForm)
    BASE_NAVBAR_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    OrgCombo: TComboBox;
    VIEWGRID_DOCK_PANEL: TPanel;
    StatusBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OrgComboChange(Sender: TObject);
   private
   	FeeEditForm : TPref_FeeEditForm;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn;State: TGridDrawState);
      procedure HandleDoubleClick( sender : tObject );
   public
   	fFeeQuery : tMasterData_BaseDataClass;
      FeeListQuery : tMasterDataFeeList;
      FeeListGrid : tAvoBaseDBGrid;
      dbNavTool : tAvoBaseDBNavigationTool;
      FeeGridToolBar : tAvoBaseToolBar;
   	procedure StatBarUpdate();
      procedure New();
      procedure Edit();
      procedure Delete();
      procedure Recalculate;
      procedure GlobalRefreshEvent();
   end;

implementation

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)


procedure TPref_FeesForm.FormCreate(Sender: TObject);
begin
	inherited;
   //
   fFeeQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Fee);
   //
   FeeListQuery := tMasterDataFeeList.Create( masterData );
   //
   FeeListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, FeeListQuery, 'NAME' );
   //
   FeeListGrid.Clear;
   FeeListGrid.Add(FeeListQuery.FieldByName('ORG'), 'ORG', 120, clRed, [fsBold], taLeftJustify);
   FeeListGrid.Add(FeeListQuery.FieldByName('NAME'), 'NAME', 140, clBlack, [fsBold], taLeftJustify);
   FeeListGrid.Add(FeeListQuery.FieldByName('AUTOINV'), 'AUTO INV', 70, clBlack, [fsBold], taLeftJustify);
   FeeListGrid.Add(FeeListQuery.FieldByName('AMOUNT'), 'AMOUNT', 60, clGreen , [fsBold], taRightJustify);
   //
   FeeListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   FeeListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;
   FeeListGrid.OnDblClick := HandleDoubleClick;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, FeeListQuery);
   //
{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'AUTOINV BOOLEAN, ' + // auto-add to invoice
            'TAX BOOLEAN, ' +  // whether this is a line item taxation on the invoice
            'AMOUNT MONEY',
}
   //
   FeeGridToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   FeeGridToolBar.actionList.OnUpdate := HandleActionListUpdate;
   FeeGridToolBar.actionList.onActionEvent := HandleActionExecute;
   FeeGridToolBar.Align := alClient;
   FeeGridToolBar.CreateButton( CMD_HELP);
   FeeGridToolBar.CreateButtonSep();
   FeeGridToolBar.CreateButton( CMD_DELETE );
   FeeGridToolBar.CreateButtonSep();
   FeeGridToolBar.CreateButton( CMD_EDIT );
   FeeGridToolBar.CreateButtonSep();
   FeeGridToolBar.CreateButton( CMD_NEW );
   //
   StatBarUpdate();
   //
   Org_ComboBox_FillActiveOrgs( 'ALL', OrgCombo);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.GlobalRefreshEvent;
begin
   Org_ComboBox_FillActiveOrgs( 'ALL', OrgCombo);
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FreeAndNil(fFeeQuery);
   FreeAndNil(FeeListGrid);
   FreeAndNil(FeeListQuery);
   FreeAndNil(dbNavTool);
   FreeAndNil(FeeGridToolBar);
   //
   inherited;
end;


(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
   	CMD_EDIT:
      begin
      	Edit();
      end;
      CMD_NEW:
      begin
      	New();
      end;
      CMD_DELETE:
      begin
      	Delete();
      end;
      CMD_HELP: AvoBaseHelp_Execute('Pref_FeesForm');
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_EDIT, CMD_DELETE : enabled := (FeeListQuery.RecordCount <> 0);
      end;
end;

procedure TPref_FeesForm.HandleDoubleClick(sender: tObject);
begin
   Edit();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
	if (NOT FeeListQuery.FieldByName('ISACTIVE').AsBoolean) then
   begin
      FeeListGrid.Canvas.Font.Color := clGrayText;
      FeeListGrid.Canvas.Font.Style := [fsItalic];
      FeeListGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.New;
var
	errRec : tErrorResult;
begin
   if ( Org_GetOrgCount = 0 ) then
   begin
      AvoBaseDialog('No Sales Organizations', 'A Sales Organization must exist before adding Fees.', mtError,
      [mbOk], 0);
   end else
   begin
      errRec := fFeeQuery.Append();
      if NOT (errRec.errorResult) then
      begin
         fFeeQuery.SetFieldByname('ISACTIVE', true);
         fFeeQuery.SetFieldByName('ORG_ID', Org_GetFirstActiveOrg);
   //      fFeeQuery.SetFieldByName('TAX', true);
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
         FeeEditForm := TPref_FeeEditForm.Create( Application, 'New Fee Rate', true, fFeeQuery);
         FeeEditForm.IsNew := true;
         try
            FeeEditForm.ShowModal();
         finally
            FreeAndNil(FeeEditForm);
         end
      end else
         Error_Log(errRec, true);
      Recalculate();
   end;
end;

procedure TPref_FeesForm.OrgComboChange(Sender: TObject);
begin
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.Delete;
var
	errRec : tErrorResult;
   delMsg : string;
begin
   delMsg := 'Open Orders may be affected by deleting this fee rate. You will need to open the Order, remove any existing fees and then save the Order.' + #13 + #13 +
      'Orders that are already closed will not be affected by deleted fee rates.' + #13 + #13 +
      'Are you sure you want to delete this fee rate?';
   if AvoBaseDialog('Delete Fee Rate', delMsg, mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      fFeeQuery.Delete( FeeListQuery.FieldByName('ID').AsString );
      Recalculate();
   end;
end;


(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.Edit;
var
	errRec : tErrorResult;
begin
	errRec := fFeeQuery.Load( FeeListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
   	FeeEditForm := TPref_FeeEditForm.Create( Application, 'Edit Fee Rate', true, fFeeQuery);
      FeeEditForm.IsNew := false;
      try
      	FeeEditForm.ShowModal();
      finally
      	FreeAndNil(FeeEditForm);
      end
   end else
   	Error_Log(errRec, true);
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(FeeListQuery.RecNo) + ' of ' + IntToStr(FeeListQuery.RecordCount);
end;


(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_FeesForm.Recalculate;
var
   findID : string;
begin
   findID := FeeListQuery.FieldByName('ID').AsString;
   if ( OrgCombo.Text = 'ALL' ) then
      FeeListQuery.OrgID := ''
   else
      FeeListQuery.OrgID := Org_GetOrgIDByOrgName( OrgCombo.Text );
   //
   FeeListQuery.Update();
   FeeListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;

end.

