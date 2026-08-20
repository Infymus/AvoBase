 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit	Preference_OrganizationsFormUnit;

interface uses
   preference_baseformunit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   inifileunit,
	actionunit,
  recordstructureunit,
   masterdata_BaseDataClassUnit,
   verificationunit,
   masterdata_basegridunit,
   errorresultunit,
   EncryptUnit,
   masterdata_navigationtoolunit,
   avobase_toolbarunit,
   Preference_OrganizationsEditFormUnit,
   MasterData_OrgListUnit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   toolbox_orgtoolboxunit,
   AvoBase_HelpFormUnit,
   avobase_registerdialogformunit,
   //
   windows,
   messages,
   sysutils,
   variants,
   classes,
   graphics,
   controls,
   forms,
   dialogs,
   actnlist,
   db,
   extctrls,
   stdctrls,
   mask,
   dbgrids,
   grids,
   jpeg,
   ComCtrls;


type
	tPref_OrganizationsForm = class(TPrefBaseForm)
      BASE_NAVBAR_PANEL: TPanel;
      BASE_NAVBAR_DOCK_PANEL: TPanel;
      VIEWGRID_DOCK_PANEL: TPanel;
      StatusBar: TStatusBar;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormCreate(Sender: TObject);
   private
   	orgEdit : tPreference_OrgEditForm;
      fPrefRefreshEvent : tPrefRefreshEvent;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn;State: TGridDrawState);
      procedure HandleDoubleClick( sender : tObject );
      function tygHjehtU88jge: vEnResultRec;
   public
   	fOrgQuery : tMasterData_BaseDataClass;
      orgListQuery : tMasterDataOrgList;
      orgListGrid : tAvoBaseDBGrid;
      dbNavTool : tAvoBaseDBNavigationTool;
      orgGridToolBar : tAvoBaseToolBar;
   	procedure StatBarUpdate();
      procedure NewOrg();
      procedure EditOrg();
      procedure DeleteOrg();
      procedure GlobalRefreshEvent();
      //
      property OnPreferenceRefreshEvent : tPrefRefreshEvent read fPrefRefreshEvent write fPrefRefreshEvent;
   end;

implementation

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tPref_OrganizationsForm.FormCreate(Sender: TObject);
begin
	inherited;
   //
   fOrgQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Org);
   //
   orgListQuery := tMasterDataOrgList.Create( masterData );
   //
   orgListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, orgListQuery, 'NAME' );
   //         Constructor Create( owner: TComponent; inParent : tWinControl; inDataSet : tDataSet; inFieldName : String ); overload;
   orgListGrid.Clear;
   orgListGrid.Add(orgListQuery.FieldByName('ISACTIVE'), 'ACTIVE', 60, clRed, [fsBold], taLeftJustify);
   orgListGrid.Add(orgListQuery.FieldByName('NAME'), 'NAME', 120, clRed, [fsBold], taLeftJustify);
   orgListGrid.Add(orgListQuery.FieldByName('DESCR'), 'DESC', 200, clGreen, [], taLeftJustify);
   orgListGrid.Add(orgListQuery.FieldByName('CYCLES'), 'CYCLES', 60, clGreen, [], taLeftJustify);
   orgListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   orgListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;
   orgListGrid.OnDblClick := HandleDoubleClick;

   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, orgListQuery);
   //
{ This only reflects what was at design time, may not be what exists now. should probably be gotten rid of.
          'ID VARCHAR(40), ' +
          'ISACTIVE BOOLEAN, ' +
          'NAME VARCHAR(50), ' +
          'INAME VARCHAR(50), ' +
          'DESCR VARCHAR(200), ' +
          'ACC VARCHAR(50), ' +
          'IHEADD VARCHAR(50), ' + // invoice header display
          'CYCLES INTEGER, ' + // # of cycles per year
          'IMSG VARCHAR(200), ' + // specific invoice message
          'ICNCLMSG BLOB(240,1)', // cancellation message
}
   //
   orgGridToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   orgGridToolBar.actionList.OnUpdate := HandleActionListUpdate;
   orgGridToolBar.actionList.onActionEvent := HandleActionExecute;
   orgGridToolBar.Align := alClient;
//   orgGridToolBar.CreateButton( CMD_HELP);
//   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_DELETE );
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_EDIT );
   orgGridToolBar.CreateButtonSep();
   orgGridToolBar.CreateButton( CMD_NEW );
   //
   StatBarUpdate();
end;

procedure tPref_OrganizationsForm.GlobalRefreshEvent;
begin
   //
end;

procedure tPref_OrganizationsForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
   	CMD_EDIT:
      begin
      	EditOrg();
      end;
      CMD_NEW:
      begin
      	NewOrg();
      end;
      CMD_DELETE:
      begin
      	DeleteOrg();
      end;
//      CMD_HELP: AvoBaseHelp_Execute('Pref_OrganizationsForm');
   end;
end;

procedure tPref_OrganizationsForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_EDIT, CMD_DELETE : enabled := (orgListQuery.RecordCount <> 0);
      end;
end;

procedure tPref_OrganizationsForm.HandleDoubleClick(sender: tObject);
begin
   EditOrg();
end;

procedure tPref_OrganizationsForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
	if (NOT orgListQuery.FieldByName('ISACTIVE').AsBoolean) then
   begin
      orgListGrid.Canvas.Font.Color := clGrayText;
      orgListGrid.Canvas.Font.Style := [fsItalic];
      orgListGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure tPref_OrganizationsForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

procedure tPref_OrganizationsForm.NewOrg;
var
	errRec : tErrorResult;
begin
   if ( orgListQuery.RecordCount >= 1 ) then
      if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
      begin
         AvoBaseRegisterDialog(#85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 +
          #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 + #65 + #118 + #111
           + #66 + #97 + #115 + #101 + #32 + #97 + #114 + #101 + #32 + #108 + #105 + #109 + #105 + #116 + #101 +
            #100 + #32 + #116 + #111 + #32 + #111 + #110 + #108 + #121 + #32 + #49 + #32 + #83 + #97 + #108 + #101
             + #115 + #32 + #79 + #114 + #103 + #97 + #110 + #105 + #122 + #97 + #116 + #105 + #111 + #110 + #46);
         {Unregistered versions of AvoBase are limited to only 1 Sales Organization.}
         Exit;
      end;
	errRec := fOrgQuery.Append();
   if NOT (errRec.errorResult) then
   begin
      fOrgQuery.SetFieldByName('ISACTIVE', true);
   	orgEdit := tPreference_OrgEditForm.Create( Application, 'Edit Organization', true, fOrgQuery);
      fOrgQuery.SetFieldByName('CNAME', 'Sales Cycles');
      orgEdit.IsNew := true;
      try
      	orgEdit.ShowModal();
      finally
      	FreeAndNil(orgEdit);
      end
   end else
   	AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0);
   if Assigned( fPrefRefreshEvent ) then
      fPrefRefreshEvent();
   orgListQuery.Update();
end;

procedure tPref_OrganizationsForm.DeleteOrg;
var
	errRec : tErrorResult;
begin
   if (Org_GetOrgDependantsByOrgID(orgListQuery.FieldByName('ID').AsString)) then
   begin
   	AvoBaseDialog('Organization Data Dependancies', 'This Organization has data dependancies in AvoBase.' + #13 + #13 +
      'This means that' +
      ' this Organization is being used by an Order, Customer, Method of Payment, Brochure,' +
      ' Credit, Expense - or other. ' + #13 + #13 + 'You cannot delete an Organization that has data' +
      ' dependancies.', mtError, [mbOk], 0);
   end else
   	begin
      	if AvoBaseDialog('Confirm Organization Delete', 'Deleting an Organization cannot be undone.' + #13 + #13 +
         'Are you sure you want to delete the Organization named "' + orgListQuery.FieldByName('NAME').AsString + '"?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
         begin
         	errRec := fOrgQuery.Delete( orgListQuery.FieldByName('ID').AsString );
            orgListQuery.Update();
            if (errRec.errorResult) then
            	AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0)
         end;
      end;
   if Assigned( fPrefRefreshEvent ) then
      fPrefRefreshEvent();
end;

procedure tPref_OrganizationsForm.EditOrg;
var
	errRec : tErrorResult;
begin
	errRec := fOrgQuery.Load( orgListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
   	orgEdit := tPreference_OrgEditForm.Create( Application, 'Edit Organization', true, fOrgQuery);
      orgEdit.IsNew := false;
      try
      	orgEdit.ShowModal();
      finally
      	FreeAndNil(orgEdit);
      end
   end else
   	AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0);
   if Assigned( fPrefRefreshEvent ) then
      fPrefRefreshEvent();
   orgListQuery.Update();
end;

procedure tPref_OrganizationsForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(orgListQuery.RecNo) + ' of ' + IntToStr(orgListQuery.RecordCount);
end;

function tPref_OrganizationsForm.tygHjehtU88jge: vEnResultRec;
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

procedure tPref_OrganizationsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FreeAndNil(fOrgQuery);
   FreeAndNil(orgListGrid);
   FreeAndNil(orgListQuery);
   FreeAndNil(dbNavTool);
   FreeAndNil(orgGridToolBar);
   //
   inherited;
end;

{
this does the locate necessary.

var
   findID : string;
begin
   findID := custListQuery.FieldByName('ID').AsString;
   custListQuery.Close();
   custListQuery.Open();
   custListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;
}
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)





end.

