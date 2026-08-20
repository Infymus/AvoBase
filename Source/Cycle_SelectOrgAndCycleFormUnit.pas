 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Cycle_SelectOrgAndCycleFormUnit;

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
   recordstructureunit,
   MasterData_ExpenseListUnit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   AvoBase_BaseForm_MenuUnit,
   toolbox_cycletoolboxunit,
   Toolbox_PreferenceToolBoxUnit,
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
   tOrgSelectOrgAndCycleForm = class(TAvoBase_BaseForm_Menu)
      CycleNumLabel: TLabel;
      CycleNumComboBox: TComboBox;
      campYearLabel: TLabel;
      CycleYearComboBox: TComboBox;
      orgLabel: TLabel;
      orgCombo: TComboBox;
      info_label: TLabel;
      Label1: TLabel;
      procedure orgComboChange(Sender: TObject);
      procedure CycleYearComboBoxChange(Sender: TObject);
      procedure FormShow(Sender: TObject);
   private
      function fGetCycleID : string;
      function fGetOrgID : string;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      property CycleID : string read fGetCycleID;
      property OrgID : string read fGetOrgID;
      //
      constructor create( inOwner : tComponent); override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tOrgSelectOrgAndCycleForm.create(inOwner: tComponent);
begin
	inherited create( owner, 'Sales Organization/Cycle Selection', true, false );
   //
   Org_ComboBox_FillActiveOrgs_WithCycles( orgCombo );
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SELECT_OK );
   //
   info_label.Caption := 'First select a Sales Organization - then, select a ' +
      'Sales Cycle Year and Sales Cycle Number within that Sales Organization.';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrgSelectOrgAndCycleForm.CycleYearComboBoxChange( Sender: TObject );
begin
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tOrgSelectOrgAndCycleForm.fGetCycleID: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( CycleYearComboBox.Text );
   cycleRec.Num := StrToInt( CycleNumComboBox.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( orgCombo.Text, cycleRec.Year, cycleRec.Num );
   //
   result := C_ID;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tOrgSelectOrgAndCycleForm.fGetOrgID: string;
begin
   result := Org_GetOrgIDByOrgName( orgCombo.Text );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrgSelectOrgAndCycleForm.FormShow(Sender: TObject);
begin
   orgCombo.SetFocus();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrgSelectOrgAndCycleForm.HandleActionExecute(sender: tObject; actionID: integer);
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrgSelectOrgAndCycleForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;
   // We have nothing to handle in this particular form. So we do nothing here.
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tOrgSelectOrgAndCycleForm.orgComboChange(Sender: TObject);
begin
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
