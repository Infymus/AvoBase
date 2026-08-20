 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Earning_ViewEarningsFormUnit;

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
   AvoBase_BaseForm_MenuUnit,
   Preference_EarningTypeFormUnit,
   Report_Earning_EarningByCycleFormUnit,
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
  TEarning_ViewEarningsForm = class(TAvoBase_BaseForm_Menu)
    db_nav_dock: TPanel;
   private
      fELID : string;
      fOrgID : string;
      fCycleID : string;
   	EarningListGrid : tAvoBaseDBGrid;
      EarninglListQuery : tMasterDataEarningListEdit;
      dbNavTool : tAvoBaseDBNavigationTool;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure StartUpForm();
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      function fGetOrgID : string;
      function fGetCycleStartID : string;
      function fGetCycleEndID : string;
   public
      property OrgID : string read fGetOrgID;
      property CycleStartID : string read fGetCycleStartID;
      property CycleEndID : string read fGetCycleEndID;

      procedure PrintList();
   	procedure StatBarUpdate();
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inELID : string); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tEarning_ViewEarningsForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inELID : string);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   fELID := inELID;
   //
   EarninglListQuery := tMasterDataEarningListEdit.Create( masterData, fELID);
   //
   EarningListGrid := tAvoBaseDBGrid.Create( nil, BASE_DOCK_PANEL, EarninglListQuery, '' );
   EarningListGrid.Clear;
   EarningListGrid.Add(EarninglListQuery.FieldByName('MOPDATE'), 'DATE', 70, clRed, [fsBold], taLeftJustify);
   EarningListGrid.Add(EarninglListQuery.FieldByName('EXPTYPE'), 'Earning TYPE', 160, clBlack, [fsBold], taLeftJustify);
   EarningListGrid.Add(EarninglListQuery.FieldByName('EDESC'), 'Description', 190, clBlue, [fsBold], taLeftJustify);
   EarningListGrid.Add(EarninglListQuery.FieldByName('AMOUNT'), 'AMOUNT', 100, clBlack, [fsBold], taRightJustify);
   EarningListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, db_nav_dock, EarninglListQuery);
   dbNavTool.Align := alRight;
   //
   fOrgID := Earning_GetOrgIDByEarningListID( inELID );
   fCycleID := Earning_GetCycleIDByEarningListID( inELID );
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Earning List For ' + Org_GetOrgNameByOrgID( fOrgID ) +
      ' | Sales Cycle ' + Cycle_GetCycleNameByCycleID( fCycleID );
   //
	StartUpForm();
   StatBarUpdate();
end;

function TEarning_ViewEarningsForm.fGetCycleEndID: string;
begin
   result := EarninglListQuery.FieldByName('C_ID').AsString;
end;

function TEarning_ViewEarningsForm.fGetCycleStartID: string;
begin
   result := EarninglListQuery.FieldByName('C_ID').AsString;
end;

function TEarning_ViewEarningsForm.fGetOrgID: string;
begin
   result := EarninglListQuery.FieldByName('ORG_ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarning_ViewEarningsForm.CloseForm;
begin
	FreeAndNil(EarningListGrid);
   FreeAndNil(dbNavTool);
   freeAndNil(EarninglListQuery);
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarning_ViewEarningsForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_CLOSE : CloseForm();
      CMD_PRINT_LIST : PrintList();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarning_ViewEarningsForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   // we do absollutely nothing here because there isn't anything to do, this is a  modal, read only form.
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarning_ViewEarningsForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarning_ViewEarningsForm.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
   CreateButtonSep;
   CreateButton( CMD_PRINT_LIST );
   //
   EarninglListQuery.Update();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEarning_ViewEarningsForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(EarninglListQuery.RecNo) + ' of ' + IntToStr(EarninglListQuery.RecordCount);
   StatusBar.Panels[1].Text := 'Total Earnings: ' + Pref_GetCashSymbol + FormatFloat('####0.00', EarninglListQuery.totAmount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TEarning_ViewEarningsForm.PrintList;
var
   rpt_Earning_EarningByCycle : TReport_Earning_EarningByCycle;
   errMsg : string;
begin
   rpt_Earning_EarningByCycle := TReport_Earning_EarningByCycle.Create( Application );
   // Setup Options
   rpt_Earning_EarningByCycle.SetOptions( OrgID, CycleStartID, CycleEndID );
   // Check for Errors
   errMsg := rpt_Earning_EarningByCycle.CanPrint;
   if ( errMsg = '' ) then
   begin
      // Display it
      rpt_Earning_EarningByCycle.QReport.Preview();
   end else
      AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
   // Free it
   if (rpt_Earning_EarningByCycle <> NIL) then
      FreeAndNil(rpt_Earning_EarningByCycle);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
