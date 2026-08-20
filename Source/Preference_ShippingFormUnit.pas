 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_ShippingFormUnit;

interface uses
   preference_shippingeditformunit,
   MasterData_ShippingListUnit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   inifileunit,
	actionunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   errorresultunit,
   masterdata_navigationtoolunit,
   avobase_toolbarunit,
  recordstructureunit,
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
  TPref_ShippingForm = class(TPrefBaseForm)
    BASE_NAVBAR_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
    StatusBar: TStatusBar;
    VIEWGRID_DOCK_PANEL: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    OrgCombo: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OrgComboChange(Sender: TObject);
   private
   	ShipEditForm : TPref_ShippingEditForm;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn;State: TGridDrawState);
      procedure HandleDoubleClick( sender : tObject );
   public
   	fShippingQuery : tMasterData_BaseDataClass;
      ShippingListQuery : tMasterDataShippingList;
      ShippingListGrid : tAvoBaseDBGrid;
      dbNavTool : tAvoBaseDBNavigationTool;
      shippingGridToolBar : tAvoBaseToolBar;
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

procedure TPref_ShippingForm.FormCreate(Sender: TObject);
begin
	inherited;
   //
   fShippingQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Shipping);
   //
   ShippingListQuery := tMasterDataShippingList.Create( masterData );
   //
   ShippingListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, ShippingListQuery, 'NAME' );
   //
   ShippingListGrid.Clear;
   ShippingListGrid.Add(ShippingListQuery.FieldByName('ORG'), 'ORG', 120, clRed, [fsBold], taLeftJustify);
   ShippingListGrid.Add(ShippingListQuery.FieldByName('NAME'), 'NAME', 120, clRed, [fsBold], taLeftJustify);
   ShippingListGrid.Add(ShippingListQuery.FieldByName('SHIPTYPE'), 'TYPE', 60, clRed, [fsBold], taLeftJustify);
   ShippingListGrid.Add(ShippingListQuery.FieldByName('SAMT'), 'START AMT', 80, clGreen, [], taRightJustify);
   ShippingListGrid.Add(ShippingListQuery.FieldByName('EAMT'), 'END AMT', 80, clGreen, [], taRightJustify);
   ShippingListGrid.Add(ShippingListQuery.FieldByName('SHIPDATA'), 'VALUE', 80, clRed, [], taRightJustify);
   //
   ShippingListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   ShippingListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;
   ShippingListGrid.OnDblClick := HandleDoubleClick;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, ShippingListQuery);
   //
{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'PCNT FLOAT, ' + // PERCENT if STYPE = 2
            'RATE MONEY, ' + // RATE if STYPE = 1
            'STYPE INTEGER', // TYPE - 1 = $RATE$ - 2 = %PCNT%
}
   //
   shippingGridToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   shippingGridToolBar.actionList.OnUpdate := HandleActionListUpdate;
   shippingGridToolBar.actionList.onActionEvent := HandleActionExecute;
   shippingGridToolBar.Align := alClient;
   shippingGridToolBar.CreateButton( CMD_HELP);
   shippingGridToolBar.CreateButtonSep();
   shippingGridToolBar.CreateButton( CMD_DELETE );
   shippingGridToolBar.CreateButtonSep();
   shippingGridToolBar.CreateButton( CMD_EDIT );
   shippingGridToolBar.CreateButtonSep();
   shippingGridToolBar.CreateButton( CMD_NEW );
   //
   StatBarUpdate();
   //
   Org_ComboBox_FillActiveOrgs( 'ALL', OrgCombo);
end;

procedure TPref_ShippingForm.GlobalRefreshEvent;
begin
   Org_ComboBox_FillActiveOrgs( 'ALL', OrgCombo );
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.HandleActionExecute(sender: tObject; actionID: integer);
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
      CMD_HELP: AvoBaseHelp_Execute('Pref_ShippingForm');
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_EDIT, CMD_DELETE : enabled := (ShippingListQuery.RecordCount <> 0);
      end;
end;

procedure TPref_ShippingForm.HandleDoubleClick(sender: tObject);
begin
   Edit();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
	if (NOT ShippingListQuery.FieldByName('ISACTIVE').AsBoolean) then
   begin
      ShippingListGrid.Canvas.Font.Color := clGrayText;
      ShippingListGrid.Canvas.Font.Style := [fsItalic];
      ShippingListGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.New;
var
	errRec : tErrorResult;
begin
   if ( Org_GetOrgCount = 0 ) then
   begin
      AvoBaseDialog('No Sales Organizations', 'A Sales Organization must exist before adding Shipping.', mtError,
      [mbOk], 0);
   end else
   begin
      errRec := fShippingQuery.Append();
      if NOT (errRec.errorResult) then
      begin
         fShippingQuery.SetFieldByname('ISACTIVE', true);
         fShippingQuery.SetFieldByName('ORG_ID', Org_GetFirstActiveOrg);
         fShippingQuery.SetFieldByName('STYPE', 1);
         fShippingQuery.SetFieldByName('TAXID', '');
   {
            retVal := masterData.AddTable(masterData.dbPath + table_shipping,
               'ID VARCHAR(40), ' +
               'TAXID VARCHAR(40), ' +
               'ORG_ID VARCHAR(40), ' +
               'ISACTIVE BOOLEAN, ' +
               'NAME VARCHAR(50), ' +
               'DESCR VARCHAR(200), ' +
               'SAMT MONEY, ' + // start amount
               'EAMT MONEY, ' + // end amount
               'PCNT FLOAT, ' + // PERCENT if STYPE = 2
               'RATE MONEY, ' + // RATE if STYPE = 1
               'STYPE INTEGER, ' + // TYPE - 1 = $RATE$ - 2 = %PCNT%
   }
         ShipEditForm := tPref_ShippingEditForm.Create( Application, 'New Shipping Rate', true, fShippingQuery);
         ShipEditForm.IsNew := true;
         try
            ShipEditForm.ShowModal();
         finally
            FreeAndNil(ShipEditForm);
         end
      end else
         Error_Log(errRec, true);
      Recalculate();
   end;
end;

procedure TPref_ShippingForm.OrgComboChange(Sender: TObject);
begin
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.Delete;
var
	errRec : tErrorResult;
   delMsg : string;
begin
   delMsg := 'Open Orders may be affected by deleting this shipping rate. You will need to open the Order and then save the Order to make the shipping change effective.' + #13 + #13 +
      'Orders that are already closed will not be affected by deleted shipping rates.' + #13 + #13 +
      'Are you sure you want to delete this shipping rate?';
   if AvoBaseDialog('Delete Shipping Rate', delMsg, mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      fShippingQuery.Delete( ShippingListQuery.FieldByName('ID').AsString );
      Recalculate();
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.Edit;
var
	errRec : tErrorResult;
begin
	errRec := fShippingQuery.Load( ShippingListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
   	ShipEditForm := tPref_ShippingEditForm.Create( Application, 'Edit Shipping Rate', true, fShippingQuery);
      ShipEditForm.IsNew := false;
      try
      	ShipEditForm.ShowModal();
      finally
      	FreeAndNil(ShipEditForm);
      end
   end else
   	Error_Log(errRec, true);
   Recalculate();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(ShippingListQuery.RecNo) + ' of ' + IntToStr(ShippingListQuery.RecordCount);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FreeAndNil(fShippingQuery);
   FreeAndNil(ShippingListGrid);
   FreeAndNil(ShippingListQuery);
   FreeAndNil(dbNavTool);
   FreeAndNil(shippingGridToolBar);
   //
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure TPref_ShippingForm.Recalculate;
var
   findID : string;
begin
   findID := ShippingListQuery.FieldByName('ID').AsString;
   if ( OrgCombo.Text = 'ALL' ) then
      ShippingListQuery.OrgID := ''
   else
      ShippingListQuery.OrgID := Org_GetOrgIDByOrgName( OrgCombo.Text );
   //
   ShippingListQuery.Update();
   ShippingListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;


end.

