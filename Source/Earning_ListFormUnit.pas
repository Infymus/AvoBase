 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Earning_ListFormUnit;

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
   MasterData_EarningListUnit,
   toolbox_orgtoolboxunit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   Cycle_SelectOrgAndCycleFormUnit,
   toolbox_EarningToolBoxUnit,
   toolbox_cycletoolboxunit,
   Earning_ListEditFormUnit,
   Earning_ViewEarningsFormUnit,
   Earning_ItemEditFormUnit,
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
   jpeg;

type
  TEarningListForm = class(TAvobase_BaseForm_List)
    Label2: TLabel;
    OrgCombo: TComboBox;
    procedure OrgComboChange(Sender: TObject);
  private
      ernListQuery : tMasterDataEarningList;
      ernViewForm : tEarning_ViewEarningsForm;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleDoubleClick( sender : tObject );
      function fGetEarningListID : string;
      function Check_CanCreate: boolean;
      function fGetEarningListCycleID : string;
      function fGetEarningListOrgID : string;
      function fGetCount : integer;
      function fGetORG_ID : string;
      function fGetC_ID : string;
      function fGetEL_ID : string;
   public
      //
      procedure UpdateQuery();
      //
      procedure New();
      procedure Edit();
      procedure View();
      procedure LoadByCycle();
      procedure Recalculate();
      procedure GlobalRefreshEvent();
      procedure EarningQuickAdd();
      //
      property EarningListID : string read fGetEarningListID;
      property EarningListCycleID : string read fGetEarningListCycleID;
      property EarningListOrgID : string read fGetEarningListOrgID;
      property Count : integer read fGetCount;
      property ORG_ID : string read fGetORG_ID;
      property C_ID : string read fGetC_ID;
      property EL_ID : string read fGetEL_ID;
      //
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TEarningListForm.create(owner : TComponent);
begin
	inherited create( Nil, 'Earnings', false, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   ernListQuery := tMasterDataEarningList.Create( masterData);
   //
   gridDataSource.DataSet := ernListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( ernListQuery, 'FNAME' );
   DataListGrid.Clear;
   DataListGrid.Add(ernListQuery.FieldByName('ORGNAME'), 'ORG', 100, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(ernListQuery.FieldByName('CYCLENAME'), 'CYCLE', 100, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(ernListQuery.FieldByName('TOTITEMS'), 'ITEMS', 100, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(ernListQuery.FieldByName('TOTAMT'), 'AMOUNT', 100, clBlack, [fsBold], taRightJustify);
   DataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( ernListQuery );
   //
   Org_ComboBox_FillActiveOrgs( 'All', OrgCombo );
   //
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

destructor TEarningListForm.Destroy;
begin
	ernListQuery.Close();
   freeAndNil(ernListQuery);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



function TEarningListForm.fGetEarningListCycleID: string;
begin
   result := ernListQuery.FieldByName('C_ID').AsString;
end;

function TEarningListForm.fGetEarningListID: string;
begin
   result := ernListQuery.FieldByName('ID').AsString;
end;

function TEarningListForm.fGetEarningListOrgID: string;
begin
   result := ernListQuery.FieldByName('ORG_ID').AsString;
end;

function TEarningListForm.fGetEL_ID: string;
begin
   result := ernListQuery.FieldByName('ID').AsString;
end;

function TEarningListForm.fGetORG_ID: string;
begin
   result := ernListQuery.FieldByName('ORG_ID').AsString;
end;

function TEarningListForm.fGetCount: integer;
begin
   result := ernListQuery.RecordCount;
end;

function TEarningListForm.fGetC_ID: string;
begin
   result := ernListQuery.FieldByName('C_ID').AsString;
end;

procedure TEarningListForm.GlobalRefreshEvent;
begin
   Recalculate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TEarningListForm.HandleDoubleClick(sender: tObject);
begin
	Edit();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TEarningListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(ernListQuery.RecNo) + ' of ' + IntToStr(ernListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TEarningListForm.LoadByCycle;
var
   orgSelectForm : TOrgSelectOrgAndCycleForm;
   cycleID : string;
   orgID : string;
   elID : string;
   EarningEdit : tEarningList_EditForm;
begin
   orgSelectForm := TOrgSelectOrgAndCycleForm.Create( Application );
   orgSelectForm.ShowModal;
   if ( orgSelectForm.FormResult = mrOk ) then
   begin
      cycleID := orgSelectForm.CycleID;
      orgID := orgSelectForm.OrgID;
      //
      elID := Earning_GetEarningIDByCycleID( cycleID );
      //
      if ( elID <> '' ) then
      begin
         EarningEdit := tEarningList_EditForm.Create( Application, elID);
         EarningEdit.ShowModal;
         // do NOT FREE HERE, it is ALREADY DONE via caFREE.
         UpdateQuery();
         ernListQuery.Locate('ID', elID, [loCaseInsensitive]);
      end else
         AvoBaseDialog('Unable to locate Earning List',
            'There is no Earning List for ' + Org_GetOrgNameByOrgID( orgID ) +
            ' Sales Cycle ' + Cycle_GetCycleNameByCycleID( cycleID ), mtInformation, [mbok], 0);
   end;
   // DONT DO THIS ---> IT IS DONE FOR US IN THE INHERITED FORM: FreeAndNil(orgSelectForm);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TEarningListForm.UpdateQuery;
begin
   if ( OrgCombo.Text = 'All' ) then
      ernListQuery.Update()
   else
      ernListQuery.Update( Org_GetOrgIDByOrgName( OrgCombo.Text ));
   //
   PercentForm_Free();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TEarningListForm.View;
begin
   ernViewForm := tEarning_ViewEarningsForm.Create( Application, 'Earning', True, ernListQuery.FieldByName('ID').AsString);
   ernViewForm.ShowModal();
   FreeAndNil(ernViewForm);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



procedure TEarningListForm.Edit;
var
   EarningEdit : tEarningList_EditForm;
   edID : string;
begin
   if ( ernListQuery.RecordCount <> 0 ) then
   begin
      EarningEdit := tEarningList_EditForm.Create( Application, ernListQuery.FieldByName('ID').AsString);
      edID := ernListQuery.FieldByName('ID').AsString;
      EarningEdit.ShowModal;
      // do NOT FREE HERE, it is ALREADY DONE via caFREE.
      UpdateQuery();
      ernListQuery.Locate('ID', edID, [loCaseInsensitive]);
   end else
      AvoBaseDialog('Cannot Edit Earning List', 'You must first create an Earning List for a ' +
         ' Sales Organization, Sales Cycle and Sales Cycle Number. ', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TEarningListForm.Check_CanCreate: boolean;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if ( Cycle_GetCycleCount = 0 ) then
   	errMsg := 'You must first create a Sales Cycle.';
   //
   if ( Org_GetOrgCount = 0 ) then
   	errMsg := 'You must first create a Sales Organization.';
   //
   if ( Earning_EarningTypeCount = 0 ) THEN
      errMsg := 'You must first create an Earning Type.';
   //
   if ( errMsg <> '' ) then
   	AvoBaseDialog('Unable To Proceed', errMsg, mtError, [mbOk], 0);
   //
   result := ( errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TEarningListForm.New;
var
   orgSelectForm : TOrgSelectOrgAndCycleForm;
   cycleID : string;
   orgID : string;
   cycleName : string;
   errMsg : string;
   fNewID : string;
   fExpListQuery : tMasterData_BaseDataClass;
   EarningEdit : tEarningList_EditForm;
begin
	if ( Check_CanCreate ) then
   begin
      orgSelectForm := TOrgSelectOrgAndCycleForm.Create( Application );
      orgSelectForm.ShowModal;
      if ( orgSelectForm.FormResult = mrOk ) then
      begin
         cycleID := orgSelectForm.CycleID;
         orgID := orgSelectForm.OrgID;
         cycleName := Cycle_GetCycleNameByCycleID( cycleID );
         //
         errMsg := '';
         //
         if Earning_EarningListExistsByCycleID( cycleID ) then
            errMsg := 'A Sales Cycle Earning List already exists with that Organization, Sales Cycle Year and ' +
               'Sales Cycle Number.';
         //
         if ( errMsg <> '' ) then
         begin
            AvoBaseDialog('Unable to Create Earning List', errMsg, mtError, [mbOk], 0);
         end else
            begin
               PercentForm_Create('Creating New Earning List - One Moment Please...', 0, 0);
               //
               fExpListQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Earning_List );
               //
               fExpListQuery.Append();
               fNewID := fExpListQuery.GetFieldByName('ID').AsString;
               fExpListQuery.SetFieldByName('ORG_ID', orgID);
               fExpListQuery.SetFieldByName('CYCLENAME', cycleName);
               fExpListQuery.SetFieldByName('C_ID', cycleID);
               fExpListQuery.Post();
               //
               FreeAndNil(fExpListQuery);
               //
               Earning_AddAutoEarningTypesToEarningList( fNewID, orgID, cycleID );
               //
               PercentForm_Free();
               //
               ernListQuery.Close();
               ernListQuery.Open();
               ernListQuery.Locate('ID', fNewID, [loCaseInsensitive]);
               // now put them into edit mode
               // mhoenie 7/18/2012
               EarningEdit := tEarningList_EditForm.Create( Application, fNewID);
               EarningEdit.ShowModal;
               // do NOT FREE HERE, it is ALREADY DONE via caFREE.
               UpdateQuery();
               ernListQuery.Locate('ID', fNewID, [loCaseInsensitive]);
            end;
      end;
   end;
   // DONT DO THIS ---> IT IS DONE FOR US IN THE INHERITED FORM: FreeAndNil(orgSelectForm);
end;

procedure TEarningListForm.OrgComboChange(Sender: TObject);
begin
   UpdateQuery();
end;

procedure TEarningListForm.Recalculate;
var
   ID : string;
begin
   ID := ernListQuery.FieldByName('ID').AsString;
   ernListQuery.Close();
   ernListQuery.Open();
   ernListQuery.Locate('ID', ID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


procedure TEarningListForm.EarningQuickAdd;
var
   editForm : TEarning_EditForm;
   ernQuery : tMasterData_BaseDataClass;
begin
	if ( Check_CanCreate ) then
   if ( Count <> 0 ) then
   begin
      editForm := tEarning_EditForm.Create( Application, NIL );
      editForm.Clear();
      //
      ernQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Earning);
      ernQuery.Append();
      ernQuery.SetFieldByName('ID', masterData.NewDBGuid);
      ernQuery.SetFieldByName('ORG_ID', ORG_ID);
      ernQuery.SetFieldByName('C_ID', C_ID);
      ernQuery.SetFieldByName('E_ID', EL_ID);
      editForm.CycleID := C_ID;
      editForm.OrgID := ORG_ID;
      editForm.ID := ernQuery.GetFieldByName('ID').AsString;
      editForm.ShowModal();
      //
      if ( editForm.CloseAction = mrCancel ) then
         ernQuery.Cancel();
      if ( editForm.CloseAction = mrOk ) then
      begin
         ernQuery.SetFieldByName('ID', editForm.ID);
         ernQuery.SetFieldByName('ORG_ID', editForm.OrgID);
         ernQuery.SetFieldByName('E_ID', EarningListID);
         ernQuery.SetFieldByName('C_ID', editForm.CycleID);
         ernQuery.SetFieldByName('ET_ID', editForm.ExpTypeID);
         ernQuery.SetFieldByName('MOPDATE', editForm.MopDate);
         ernQuery.SetFieldByName('MOPTYPE', editForm.MopType);
         ernQuery.SetFieldByName('MOPVALUE', editForm.OrgID);
         ernQuery.SetFieldByName('AMOUNT', editForm.Amount);
         ernQuery.SetFieldByName('EDESC', editForm.Edesc);
         //
         ernQuery.Post();
      end;
      //
      ernQuery.Close();
      FreeAndNil(ernQuery);
      FreeAndNil(editForm);
      Recalculate();
   end else
      AvoBaseDialog('Cannot Edit Expense List', 'You must first create an Earning List for a ' +
         ' Sales Organization, Sales Cycle and Sales Cycle Number. ', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
