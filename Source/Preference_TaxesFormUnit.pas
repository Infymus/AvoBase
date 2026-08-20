 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit	Preference_TaxesFormUnit;

interface uses
   preference_baseformunit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   inifileunit,
	actionunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
  recordstructureunit,
   errorresultunit,
   masterdata_navigationtoolunit,
   avobase_toolbarunit,
   Preference_TaxesEditFormUnit,
   MasterData_TaxListUnit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   toolbox_taxtoolboxunit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
   actnlist,
   sysutils,
   variants,
   classes,
   graphics,
   controls,
   forms,
   dialogs,
   db,
   extctrls,
   stdctrls,
   mask,
   dbgrids,
   grids,
   jpeg,
   ComCtrls;

type
	tPref_TaxesForm = class(TPrefBaseForm)
   	ScrollBox1: TScrollBox;
      BASE_NAVBAR_PANEL: TPanel;
      BASE_NAVBAR_DOCK_PANEL: TPanel;
      StatusBar: TStatusBar;
      VIEWGRID_DOCK_PANEL: TPanel;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
   	taxEditForm : TPref_TaxEditForm;
      fMasterTaxID : string;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn;State: TGridDrawState);
      procedure HandleDoubleClick( sender : tObject );
   public
   	fTaxQuery : tMasterData_BaseDataClass;
      taxListQuery : tMasterDataTaxList;
      taxListGrid : tAvoBaseDBGrid;
      dbNavTool : tAvoBaseDBNavigationTool;
      orgGridToolBar : tAvoBaseToolBar;
   	procedure StatBarUpdate();
      procedure New();
      procedure Edit();
      procedure Delete();
      procedure GlobalRefreshEvent();
      procedure Recalculate( inID : string );
      //
      constructor Create( inMasterTaxID : string ); overload;
   end;

implementation

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tPref_TaxesForm.Create( inMasterTaxID: string );
begin
	inherited create( owner, PREF_TAXRATES );
   //
   fMasterTaxID := inMasterTaxID;
   self.PREF_HEADER_LABEL.Caption := 'Tax Rates For Tax Group - ' + Tax_GetMasterTaxNameByID( fMasterTaxID );
   //
   fTaxQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Tax);
   //
   taxListQuery := tMasterDataTaxList.Create( masterData, fMasterTaxID );
   //
   taxListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, taxListQuery, 'NAME' );
   //         Constructor Create( owner: TComponent; inParent : tWinControl; inDataSet : tDataSet; inFieldName : String ); overload;
   taxListGrid.Clear;
   taxListGrid.Add(taxListQuery.FieldByName('ISACTIVE'), 'ACTIVE', 60, clRed, [fsBold], taLeftJustify);
   taxListGrid.Add(taxListQuery.FieldByName('NAME'), 'NAME', 120, clRed, [fsBold], taLeftJustify);
   taxListGrid.Add(taxListQuery.FieldByName('SAMT'), 'START AMT', 100, clGreen, [], taRightJustify);
   taxListGrid.Add(taxListQuery.FieldByName('EAMT'), 'END AMT', 100, clGreen, [], taRightJustify);
   taxListGrid.Add(taxListQuery.FieldByName('TAXTYPE'), 'TAX TYPE', 100, clPurple, [], taRightJustify);
   taxListGrid.Add(taxListQuery.FieldByName('RATE'), 'RATE', 80, clRed, [], taRightJustify);
   taxListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   taxListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;
   TaxListGrid.OnDblClick := HandleDoubleClick;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, taxListQuery);
   //
{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.

            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'RATE FLOAT',
}
   //
   orgGridToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   orgGridToolBar.actionList.OnUpdate := HandleActionListUpdate;
   orgGridToolBar.actionList.onActionEvent := HandleActionExecute;
   orgGridToolBar.Align := alClient;

   orgGridToolBar.CreateButton( CMD_HELP);
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_CLOSE );
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_DELETE );
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_EDIT );
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_NEW );
   //
   StatBarUpdate();
end;

procedure TPref_TaxesForm.GlobalRefreshEvent;
begin
   //
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
   	CMD_EDIT: Edit();
      CMD_NEW: New();
      CMD_DELETE: Delete();
      CMD_CLOSE: Close();
      CMD_HELP: AvoBaseHelp_Execute('Pref_TaxesForm');
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_EDIT, CMD_DELETE : enabled := (taxListQuery.RecordCount <> 0);
      end;
end;

procedure TPref_TaxesForm.HandleDoubleClick(sender: tObject);
begin
   Edit();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
	if (NOT taxListQuery.FieldByName('ISACTIVE').AsBoolean) then
   begin
      taxListGrid.Canvas.Font.Color := clGrayText;
      taxListGrid.Canvas.Font.Style := [fsItalic];
      taxListGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.New;
var
	errRec : tErrorResult;
   id : string;
begin
	errRec := fTaxQuery.Append();
   if NOT (errRec.errorResult) then
   begin
   	fTaxQuery.SetFieldByname('ISACTIVE', true);
   	taxEditForm := tPref_TaxEditForm.Create( Application, 'New Tax Rate', true, fTaxQuery, fMasterTaxID);
      taxEditForm.IsNew := true;
      taxEditForm.db_samt.Text := '0.01';
      taxEditForm.db_eamt.Text := '99999.99';
      try
         taxEditForm.ShowModal();
         id := taxEditForm.ID;
      finally
      	FreeAndNil(taxEditForm);
      end;
      Recalculate( id );
   end else
   	Error_Log(errRec, true);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesForm.Recalculate(inID: string);
var
	id : string;
begin
   if ( inID <> '' ) then
      id := inID
   else
      id := taxListQuery.FieldByName('ID').AsString;
   taxListQuery.Update();
   taxListQuery.Locate('ID', id, [loCaseInsensitive]);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.Delete;
var
	errRec : tErrorResult;
   delMsg : string;
begin
   delMsg := 'Non-Closed Orders may be affected by deleting this tax rate. You will need to open the Order and then save the Order to make the tax change effective.' + #13 + #13 +
      'Orders that are already closed will not be affected by deleted tax rates.' + #13 + #13 +
      'Are you sure you want to delete this tax rate?';
   if AvoBaseDialog('Delete Tax Rate', delMsg, mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      fTaxQuery.Delete( taxListQuery.FieldByName('ID').AsString );
      taxListQuery.Update();
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.Edit;
var
	errRec : tErrorResult;
begin
	errRec := fTaxQuery.Load( taxListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
   	taxEditForm := tPref_TaxEditForm.Create( Application, 'Edit Tax Rate', true, fTaxQuery, fMasterTaxID);
      taxEditForm.IsNew := false;
      try
      	taxEditForm.ShowModal();
      finally
      	FreeAndNil(taxEditForm);
      end
   end else
   	Error_Log(errRec, true);
   taxListQuery.Update();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(taxListQuery.RecNo) + ' of ' + IntToStr(taxListQuery.RecordCount);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_TaxesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FreeAndNil(fTaxQuery);
   FreeAndNil(taxListGrid);
   FreeAndNil(taxListQuery);
   FreeAndNil(dbNavTool);
   FreeAndNil(orgGridToolBar);
   //
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.


