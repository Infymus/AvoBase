 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Cycle_SelectOrgAndMultipleCycleFormUnit;

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
  recordstructureunit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   MasterData_ExpenseListUnit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   AvoBase_BaseForm_MenuUnit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
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
   TOrgSelectOrgAndMultieCycleForm = class(TAvoBase_BaseForm_Menu)
      GroupBox1: TGroupBox;
      info_label: TLabel;
      Label1: TLabel;
      GroupBox_SalesOrgs: TGroupBox;
      orgLabel: TLabel;
      SelectOrgCycle_Org: TComboBox;
      GroupBox_StartSalesCycle: TGroupBox;
      campYearLabel: TLabel;
      CycleNumLabel: TLabel;
      SelectOrgCycle_CycleStartNum: TComboBox;
      SelectOrgCycle_CycleStartYear: TComboBox;
      GroupBox_EndSalesCycle: TGroupBox;
      Label8: TLabel;
      Label9: TLabel;
      SelectOrgCycle_CycleEndNum: TComboBox;
      SelectOrgCycle_CycleEndYear: TComboBox;
      procedure SelectOrgCycle_OrgChange(Sender: TObject);
   private
      function fGetCycleStartID : string;
      function fGetCycleEndID : string;
      function fGetCycleOrgID : string;
      procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      property CycleOrgID : string read fGetCycleOrgID;
      property Cycle_StartID : string read fGetCycleStartID;
      property Cycle_EndID : string read fGetCycleEndID;
      //
      constructor create( inOwner : tComponent; inHeader : string ); overload;
   end;

implementation

{$R *.dfm}

constructor TOrgSelectOrgAndMultieCycleForm.create( inOwner : tComponent; inHeader : string);
begin
	inherited create( owner, inHeader, true, false );
   //
   // Org Start/End Cycle Selection
   Org_ComboBox_FillActiveOrgs_WithCycles( SelectOrgCycle_Org );
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), SelectOrgCycle_CycleStartYear );
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), SelectOrgCycle_CycleEndYear );
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleStartYear.Text), SelectOrgCycle_CycleStartNum );
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleEndYear.Text), SelectOrgCycle_CycleEndNum );
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SELECT_OK );
   //
   info_label.Caption := 'First select a Sales Organization - then, select a ' +
      'Sales Cycle Year and Sales Cycle Number within that Sales Organization.';
end;

function TOrgSelectOrgAndMultieCycleForm.fGetCycleEndID: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( SelectOrgCycle_CycleStartYear.Text );
   cycleRec.Num := StrToInt( SelectOrgCycle_CycleStartNum.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( SelectOrgCycle_Org.Text, cycleRec.Year, cycleRec.Num );
   //
   result := C_ID;
end;

function TOrgSelectOrgAndMultieCycleForm.fGetCycleOrgID: string;
begin
   result := Org_GetOrgIDByOrgName( SelectOrgCycle_Org.Text );
end;

function TOrgSelectOrgAndMultieCycleForm.fGetCycleStartID: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( SelectOrgCycle_CycleStartYear.Text );
   cycleRec.Num := StrToInt( SelectOrgCycle_CycleStartNum.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( SelectOrgCycle_Org.Text, cycleRec.Year, cycleRec.Num );
   //
   result := C_ID;
end;


procedure TOrgSelectOrgAndMultieCycleForm.HandleActionExecute(sender: tObject;
  actionID: integer);
begin
   case actionID of
      CMD_SELECT_OK :
      begin
         fFormEvent := mrOk;
         Close();
      end;
      CMD_CANCEL :
      begin
         fFormEvent := mrCancel;
         Close();
      end;
   end;
end;

procedure TOrgSelectOrgAndMultieCycleForm.HandleActionListUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;

end;

procedure TOrgSelectOrgAndMultieCycleForm.SelectOrgCycle_OrgChange(
  Sender: TObject);
begin
  inherited;
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), SelectOrgCycle_CycleStartYear );
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), SelectOrgCycle_CycleEndYear );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleStartYear.Text), SelectOrgCycle_CycleStartNum );
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(SelectOrgCycle_Org.Text), StrToInt(SelectOrgCycle_CycleEndYear.Text), SelectOrgCycle_CycleEndNum );

end;

end.
