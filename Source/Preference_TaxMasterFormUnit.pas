 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_TaxMasterFormUnit;

interface uses
   preference_baseformunit,
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
   Avobase_BaseForm_StandardUnit,
   AvoBase_HelpFormUnit,
   AvoBase_DialogFormUnit,
   //
   MasterData_TaxMasterListUnit,
   Preference_TaxMasterEditFormUnit,
   Preference_TaxesFormUnit,
   Toolbox_PreferenceToolBoxUnit,
   Preference_Taxes_SetDefaultRoundingFormUnit,
   Preference_TaxMasterSetDefaultFormUnit,
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
	tPref_TaxesMasterForm = class(TPrefBaseForm)
   	BASE_NAVBAR_PANEL: TPanel;
      StatusBar: TStatusBar;
      VIEWGRID_DOCK_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormCreate(Sender: TObject);
   private
   	taxEditForm : TPref_TaxMasterEditForm;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn;State: TGridDrawState);
      procedure HandleDoubleClick( sender : tObject );
   public
   	fTaxQuery : tMasterData_BaseDataClass;
      taxListQuery : tMasterDataMasterTaxList;
      taxListGrid : tAvoBaseDBGrid;
      dbNavTool : tAvoBaseDBNavigationTool;
      orgGridToolBar : tAvoBaseToolBar;
   	procedure StatBarUpdate();
      procedure New();
      procedure Edit();
      procedure GlobalRefreshEvent();
      procedure EditTaxClass();
      procedure Recalculate( inID : string );
      procedure SetDefaultTaxClass();
      procedure TaxSetRounding();
   end;

implementation

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.FormCreate(Sender: TObject);
begin
	inherited;
   //
   fTaxQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Tax_Master);
   //
   taxListQuery := tMasterDataMasterTaxList.Create( masterData );
   //
   taxListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, taxListQuery, 'NAME' );
   taxListGrid.Clear;
   taxListGrid.Add(taxListQuery.FieldByName('ISACTIVE'), 'ACTIVE', 60, clRed, [fsBold], taLeftJustify);
   taxListGrid.Add(taxListQuery.FieldByName('NAME'), 'NAME', 240, clRed, [fsBold], taLeftJustify);
   taxListGrid.Add(taxListQuery.FieldByName('DEF'), 'DEFAULT TYPE', 240, clGreen, [], taRightJustify);
   taxListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   taxListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;
   TaxListGrid.OnDblClick := HandleDoubleClick;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, taxListQuery);
   //
   orgGridToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   orgGridToolBar.actionList.OnUpdate := HandleActionListUpdate;
   orgGridToolBar.actionList.onActionEvent := HandleActionExecute;
   orgGridToolBar.Align := alClient;
   orgGridToolBar.CreateButton( CMD_HELP);
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_TAX_SETDEFAULT );
   orgGridToolBar.CreateButton( CMD_TAX_SET_ROUNDING );
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_TAX_EDIT );
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_TAX_EDITCLASS  );
   orgGridToolBar.CreateButton( CMD_NEW );
   //
   StatBarUpdate();
end;

procedure tPref_TaxesMasterForm.GlobalRefreshEvent;
begin
   //
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
   	CMD_TAX_EDITCLASS: Edit();
      CMD_NEW: New();
      CMD_TAX_EDIT: EditTaxClass();
      CMD_TAX_SETDEFAULT : SetDefaultTaxClass();
      CMD_HELP: AvoBaseHelp_Execute('Pref_TaxesMasterForm');
      CMD_TAX_SET_ROUNDING : TaxSetRounding();
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_TAX_SETDEFAULT, CMD_TAX_EDITCLASS, CMD_TAX_EDIT : enabled := (taxListQuery.RecordCount <> 0);
      end;
end;

procedure tPref_TaxesMasterForm.HandleDoubleClick(sender: tObject);
begin
   Edit();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure tPref_TaxesMasterForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.New;
var
	errRec : tErrorResult;
   id : string;
begin
	errRec := fTaxQuery.Append();
   if NOT (errRec.errorResult) then
   begin
   	fTaxQuery.SetFieldByname('ISACTIVE', true);
   	taxEditForm := TPref_TaxMasterEditForm.Create( Application, 'New Tax Group', true, fTaxQuery);
      taxEditForm.IsNew := true;
      try
      	taxEditForm.ShowModal();
         id := taxEditForm.ID;
      finally
      	FreeAndNil(taxEditForm);
      end;
   end else
   	Error_Log(errRec, true);
   Recalculate(id);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.Recalculate( inID : string );
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

procedure tPref_TaxesMasterForm.Edit;
var
	errRec : tErrorResult;
begin
	errRec := fTaxQuery.Load( taxListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
   	taxEditForm := TPref_TaxMasterEditForm.Create( Application, 'Edit Tax Group', true, fTaxQuery);
      taxEditForm.IsNew := false;
      try
      	taxEditForm.ShowModal();
      finally
      	FreeAndNil(taxEditForm);
      end
   end else
   	Error_Log(errRec, true);
   Recalculate('');
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(taxListQuery.RecNo) + ' of ' + IntToStr(taxListQuery.RecordCount);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure tPref_TaxesMasterForm.EditTaxClass;
var
	taxListForm : tPref_TaxesForm;
begin
	taxListForm := tPref_TaxesForm.Create( taxListQuery.FieldByName('ID').AsString );
   try
   	taxListForm.ShowModal();
   finally
   	FreeAndNil(taxListForm);
   end
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.SetDefaultTaxClass;
var
   prefDefForm : tPref_TaxesMasterSetDefaultForm;
begin
   prefDefForm := tPref_TaxesMasterSetDefaultForm.Create( Application );
   prefDefForm.ShowModal();
   //
   if ( prefDefForm.FormResult = mrOK ) then
   begin

      if ( prefDefForm.DefaultFee ) then
         Pref_SetGuid(tPrefConstants.DFEETAXID, taxListQuery.FieldByName('ID').AsString);
      //
      if ( prefDefForm.DefaultShip ) then
         Pref_SetGuid(tPrefConstants.DSHIPTAXID, taxListQuery.FieldByName('ID').AsString);
      //
      if ( prefDefForm.DefaultProd ) then
         Pref_SetGuid(tPrefConstants.DPRODTAXID, taxListQuery.FieldByName('ID').AsString);
      //
      if ( prefDefForm.DefaultOrd ) then
         Pref_SetGuid(tPrefConstants.DORDTAXID, taxListQuery.FieldByName('ID').AsString);

      if ( prefDefForm.DefaultNone ) then
      begin
         if ( Pref_GetPrefGUID(tPrefConstants.DFEETAXID) = taxListQuery.FieldByName('ID').AsString ) then
            Pref_SetGuid(tPrefConstants.DFEETAXID, '');
         if ( Pref_GetPrefGUID(tPrefConstants.DFEETAXID) = taxListQuery.FieldByName('ID').AsString ) then
            Pref_SetGuid(tPrefConstants.DFEETAXID, '');
         if ( Pref_GetPrefGUID(tPrefConstants.DFEETAXID) = taxListQuery.FieldByName('ID').AsString ) then
            Pref_SetGuid(tPrefConstants.DFEETAXID, '');
         if ( Pref_GetPrefGUID(tPrefConstants.DFEETAXID) = taxListQuery.FieldByName('ID').AsString ) then
            Pref_SetGuid(tPrefConstants.DFEETAXID, '');
      end;
{
      if ( prefDefForm.DefaultFee ) then
         PrefSetGuid('DFEETAXID', taxListQuery.FieldByName('ID').AsString)
      else
         PrefSetGuid('DFEETAXID', '');
      //
      if ( prefDefForm.DefaultShip ) then
         PrefSetGuid('DSHIPTAXID', taxListQuery.FieldByName('ID').AsString)
      else
         PrefSetGuid('DSHIPTAXID', '');
      //
      if ( prefDefForm.DefaultProd ) then
         PrefSetGuid('DPRODTAXID', taxListQuery.FieldByName('ID').AsString)
      else
         PrefSetGuid('DPRODTAXID', '');
      //
      if ( prefDefForm.DefaultOrd ) then
         PrefSetGuid('DORDTAXID', taxListQuery.FieldByName('ID').AsString)
      else
         PrefSetGuid('DORDTAXID', '');

}
      // don't free/nil - it is a caFree Form.
{
   tTaxDefaultTypes = (
      taxDefaultNone = 0,
      taxDefaultProduct = 1,
      taxDefaultFee = 2,
      taxDefaultShipping = 3
      );

}
      Recalculate('');
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_TaxesMasterForm.TaxSetRounding;
var
	Pref_TaxRoundingForm : tPref_Taxes_SetDefaultRoundingForm;
begin
	Pref_TaxRoundingForm := tPref_Taxes_SetDefaultRoundingForm.Create( Application );
   try
   	Pref_TaxRoundingForm.ShowModal();
   finally
   	// WE don't free it's a caFree Form
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)


end.

