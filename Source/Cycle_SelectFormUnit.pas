 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Cycle_SelectFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   AvoBase_ToolBarUnit,
   toolbox_orgtoolboxunit,
   toolbox_cycletoolboxunit,
   AvoBase_BaseForm_SelectUnit,
   MasterData_CycleSelectUnit,
   //
   windows,
   messages,
   sysutils,
   variants,
   classes,
   ActnList,
   graphics,
   controls,
   forms,
   dialogs,
   stdctrls,
   extctrls,
   ComCtrls,
   ToolWin,
   Mask,
   DB,
   jpeg;


type
   tCycle_SelectForm = class(TAvoBase_BaseForm_Select)
    selectLabel: TLabel;
    OrgCombo: TComboBox;
    procedure OrgComboChange(Sender: TObject);
   private
      fLoadOrderEvent : tLoadOrderEvent;
      CycleOrderDetailListQuery : tMasterDataCycleSelect;
      function fGetCycleID : string;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure HandleDoubleClick( sender : tObject );
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   public
      procedure StartUpForm();
      procedure UpdateQuery();
      procedure StatBarUpdate();
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property CycleID : string read fGetCycleID;
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tCycle_SelectForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   CycleOrderDetailListQuery := tMasterDataCycleSelect.Create( masterData);
   //
   dataListGrid.Init( CycleOrderDetailListQuery, 'ORGNAME');
   gridDataSource.DataSet := CycleOrderDetailListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   dataListGrid.Clear;
   //
   dataListGrid.Add(CycleOrderDetailListQuery.FieldByName('ORGNAME'), 'ORG', 180, clNavy, [fsBold], taLeftJustify);
   dataListGrid.Add(CycleOrderDetailListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clBlue, [fsBold], taRightjustify);
   dataListGrid.Add(CycleOrderDetailListQuery.FieldByName('SDATE'), 'START DATE', 90, clBlack, [fsBold], taRightjustify);
   dataListGrid.Add(CycleOrderDetailListQuery.FieldByName('EDATE'), 'END DATE', 90, clBlack, [fsBold], taRightjustify);
   //
   dataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( CycleOrderDetailListQuery );
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
	StartUpForm();
   StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCycle_SelectForm.StartUpForm;
begin
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Select Sales Cycle';
   //
   orgCombo.OnChange := nil;
   Org_ComboBox_FillActiveOrgs ( 'ALL', orgCombo );
   orgCombo.OnChange := OrgComboChange;
   //
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tCycle_SelectForm.fGetCycleID: string;
begin
   result := CycleOrderDetailListQuery.FieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCycle_SelectForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_SELECT_OK :
      begin
         fFormEvent := mrOk;
         Close();
      end;
      CMD_SELECT_CANCEL :
      begin
         fFormEvent := mrCancel;
         Close();
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCycle_SelectForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCycle_SelectForm.HandleDoubleClick(sender: tObject);
begin
   fFormEvent := mrOk;
   Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCycle_SelectForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCycle_SelectForm.OrgComboChange(Sender: TObject);
begin
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCycle_SelectForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(CycleOrderDetailListQuery.RecNo) + ' of ' + IntToStr(CycleOrderDetailListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCycle_SelectForm.UpdateQuery;
begin
	CycleOrderDetailListQuery.Update( OrgCombo.Text );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
