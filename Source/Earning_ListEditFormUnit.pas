 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Earning_ListEditFormUnit;

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
   MasterData_EarningListEditUnit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   Cycle_SelectOrgAndCycleFormUnit,
   toolbox_orgtoolboxunit,
   toolbox_EarningToolBoxUnit,
   toolbox_cycletoolboxunit,
   AvoBase_ToolBarUnit,
   Earning_ItemEditFormUnit,
   Preference_EarningTypeFormUnit,
   AvoBase_HelpFormUnit,
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
   tEarningList_EditForm = class(TAvobase_BaseForm_List)
    edit_panel: TPanel;
   private
      expListQuery : tMasterDataEarningListEdit;
      toolBar : tAvoBaseToolBar;
      fExpID : string;
      fOrgID: string;
      fCycleID : string;
      ernQuery : tMasterData_BaseDataClass;
      ernEditForm : TEarning_EditForm;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleDoubleClick( sender : tObject );
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure HandleGridUpdateData(Sender: TObject; Field: TField);
      procedure PutEditFormData;
      function Check_CanCreate: boolean;
      function CanSave : string;
   public
      //
      procedure UpdateQuery();
      //
      procedure New();
      procedure Edit();
      procedure View();
      procedure Save();
      procedure Cancel();
      procedure Delete();
      procedure EditEarningTypes();
      //
      constructor Create(owner : tComponent; inEID : string);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tEarningList_EditForm.create(owner : TComponent; inEID : string);
begin
	inherited create( Nil, 'Earnings', true, True);
   //
   Self.ShowBorder := True;
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   ernQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Earning);
   //
   fExpID := inEID;
   fOrgID := Earning_GetOrgIDByEarningListID( inEID );
   fCycleID := Earning_GetCycleIDByEarningListID( inEID );
   //
   ernEditForm := TEarning_EditForm.Create( Application, edit_panel);
   ernEditForm.Clear;
   //
   BASE_FORM_LABEL.Caption := 'Earning List For ' + Org_GetOrgNameByOrgID( fOrgID ) +
      ' | Sales Cycle ' + Cycle_GetCycleNameByCycleID( fCycleID );
   //
   expListQuery := tMasterDataEarningListEdit.Create( masterData, fExpID );
   //
   gridDataSource.DataSet := expListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( expListQuery, '' );
   DataListGrid.Clear;
   DataListGrid.Add(expListQuery.FieldByName('MOPDATE'), 'DATE', 80, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(expListQuery.FieldByName('EXPTYPE'), 'Earning TYPE', 160, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(expListQuery.FieldByName('EDESC'), 'Description', 190, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(expListQuery.FieldByName('AMOUNT'), 'AMOUNT', 100, clBlack, [fsBold], taRightJustify);

   {
         retVal := masterData.AddTable(masterData.dbPath + table_Earning,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'E_ID VARCHAR(40), ' + // Earning ID
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // Earning type ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
}
   DataListGrid.OnDblClick := HandleDoubleClick;
   DataListGrid.DataSource.OnDataChange := HandleGridUpdateData;
   //
   dbNavTool.Init( expListQuery );
   //
   toolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   toolBar.actionList.OnUpdate := HandleActionListUpdate;
   toolBar.actionList.onActionEvent := HandleActionExecute;
   toolBar.Align := alClient;
   toolbar.CreateButton( CMD_CLOSE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_HELP );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_Earning_EDIT_TYPES );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_DELETE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_CANCEL);
   toolBar.CreateButton( CMD_SAVE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_EDIT);
   toolBar.CreateButton( CMD_NEW);
   //
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

destructor tEarningList_EditForm.Destroy;
begin
	expListQuery.Close();
   FreeAndNil(ernQuery);
   freeAndNil(expListQuery);
   FreeAndNil(toolBar);
   FreeAndNil(ernEditForm);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.HandleDoubleClick(sender: tObject);
begin
	Edit();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.HandleGridUpdateData(Sender: TObject; Field: TField);
begin
   PutEditFormData();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(expListQuery.RecNo) + ' of ' + IntToStr(expListQuery.RecordCount);
   StatusBar.Panels[1].Text := 'Total Earnings: ' + Pref_GetCashSymbol + FormatFloat('####0.00', expListQuery.totAmount);
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.UpdateQuery;
begin
   expListQuery.Update();
   PercentForm_Free();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.View;
begin
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.Save;
var
   errMsg : string;
begin
   errMsg := CanSave();
   if ( errMsg = '' ) then
   begin
      ernEditForm.Enabled := false;
      //
      ernQuery.SetFieldByName('AMOUNT', ernEditForm.Amount);
      ernQuery.SetFieldByName('MOPDATE', ernEditForm.MopDate);
      ernQuery.SetFieldByName('MOPTYPE', ernEditForm.MopType);
      ernQuery.SetFieldByName('MOPVALUE', ernEditForm.MopValue);
      ernQuery.SetFieldByName('ET_ID', ernEditForm.ExpTypeID);
      ernQuery.SetFieldByName('EDESC', ernEditForm.Edesc);
      //
      ernQuery.Post();
      //
      DataListGrid.Enabled := True;
      DataListGrid.Repaint();
      expListQuery.Update();
      expListQuery.Locate('ID', ernQuery.GetFieldByName('ID').AsString, [loCaseInsensitive]);
   end else
      AvoBaseDialog('Unable to Save', errMsg, mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.Delete;
begin
   if AvoBaseDialog('Delete Earning', 'Earning Date ' + DateToStr(expListQuery.FieldByName('MOPDATE').AsDateTime) +
      ' Amount ' + Pref_GetCashSymbol + expListQuery.FieldByName('AMOUNT').AsString + #13 + #13 +
      'Are you sure you want to Delete this Earning?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      Earning_DeleteEarningByEarningID( expListQuery.FieldByName('ID').AsString );
      expListQuery.Update();
      PutEditFormData();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.Edit;
begin
   ernQuery.Load(expListQuery.FieldByName('ID').AsString);
   ernQuery.Edit();
   //
   ernEditForm.Enabled := True;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.EditEarningTypes;
begin
   Preference_EditEarningTypes();
   PutEditFormData();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tEarningList_EditForm.CanSave: string;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if ( ernEditForm.Amount = 0 ) then
   	errMsg := 'Earning Amount cannot be a 0 amount.';
   //
   result := errMsg;
end;

function tEarningList_EditForm.Check_CanCreate: boolean;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if (  Earning_EarningTypeCount = 0 ) then
   	errMsg := 'You must first create at least one Earning Type.';
   //
   if ( errMsg <> '' ) then
   	AvoBaseDialog('Unable To Proceed', errMsg, mtError, [mbOk], 0);
   //
   result := ( errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.New;
begin
	if ( Check_CanCreate ) then
   begin
      ernEditForm.Enabled := true;
      ernQuery.Append();
      ernQuery.SetFieldByName('ID', masterData.NewDBGuid);
      ernQuery.SetFieldByName('ORG_ID', fOrgID);
      ernQuery.SetFieldByName('C_ID', fCycleID);
      ernQuery.SetFieldByName('E_ID', fExpID);
      ernEditForm.Clear();
      ernEditForm.ID := ernQuery.GetFieldByName('ID').AsString;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.Cancel;
begin
   if AvoBaseDialog('Cancel Earning Edit', 'Cancel changes to this Earning?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      ernQuery.Cancel();
      PutEditFormData();
      DataListGrid.Enabled := True;
      DataListGrid.Repaint();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.PutEditFormData;
begin
   ernEditForm.Enabled := false;
   ernEditForm.Clear();
   ernEditForm.ID := expListQuery.FieldByName('ID').AsString;
   ernEditForm.Amount := expListQuery.FieldByName('AMOUNT').AsCurrency;
   ernEditForm.MopDate := expListQuery.FieldByName('MOPDATE').AsDateTime;
   ernEditForm.MopType := expListQuery.FieldByName('MOPTYPE').AsInteger;
   ernEditForm.MopValue := expListQuery.FieldByName('MOPVALUE').AsString;
   ernEditForm.ExpTypeID := expListQuery.FieldByName('ET_ID').AsString;
   ernEditForm.Edesc := expListQuery.FieldByName('EDESC').AsString;
   ernEditForm.OrgID := fOrgID;
   ernEditForm.CycleID := fCycleID;
end;

{
         retVal := masterData.AddTable(masterData.dbPath + table_Earning,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'E_ID VARCHAR(40), ' + // Earning ID
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // Earning type ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_CLOSE : Close();
      CMD_EDIT: Edit();
      CMD_SAVE: Save();
      CMD_CANCEL: Cancel();
      CMD_NEW: New();
      CMD_DELETE: Delete();
      CMD_Earning_EDIT_TYPES: EditEarningTypes();
      CMD_HELP: AvoBaseHelp_Execute('EarningList_EditForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarningList_EditForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_SAVE,CMD_CANCEL : Enabled := ( ernQuery.State in [dsEdit, dsInsert]);
         CMD_NEW,CMD_CLOSE : Enabled := ( ernQuery.State in [dsBrowse] );
         CMD_EDIT, CMD_DELETE : Enabled := ( ernQuery.State in [dsBrowse]) AND ( expListQuery.RecordCount <> 0);
      end;
   if ( ernQuery.State in [dsEdit, dsInsert] ) then
      dataListGrid.Enabled := False
   else
      dataListGrid.Enabled := true;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

