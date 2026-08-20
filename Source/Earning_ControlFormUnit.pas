 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Earning_ControlFormUnit;

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   img_storageformunit,
   avobase_dialogformunit,
   avobase_helpformunit,
   avobase_baseform_menuunit,
   avobase_baseform_standardunit,
   //
   EncryptUnit,
   VerificationUnit,
   AvoBase_PercentFormUnit,
   Avobase_RegisterDialogFormUnit,
  recordstructureunit,
   Earning_ListFormUnit,
   Report_Earning_EarningByCycleFormUnit,
   Preference_EarningTypeFormUnit,
	//
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs;

const
	Earning_LIST = 1000;
   Earning_EDIT = 1001;

type
	tControlForm_Earning = class(TForm)
    MAIN_DOCK_PANEL: TScrollBox;
      procedure HandleCloseForm(Sender: TObject);
   private
      function tygHjehtU88jge: vEnResultRec;
   public
   	frm_EarningList : TEarningListForm;
      function Earning_EnableDisableButtons : boolean;
      //
      procedure EarningNew();
      procedure EarningEdit();
      procedure EarningView();
      procedure EarningPrint();
      procedure EarningHelp();
      procedure EarningReports();
      procedure EarningLoadByCycle();
      procedure GlobalRefreshEvent();
      procedure EarningQuickAdd();
      procedure EditEarningTypes();
      //
   	procedure StartForm;
      procedure StopForm;
      procedure DockForm(inForm: tForm; inFormType : integer);
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Earning.DockForm(inForm: tForm; inFormType: integer);
begin
	inForm.ManualDock(MAIN_DOCK_PANEL, nil, alClient);
   inForm.BorderStyle := bsNone;
   inForm.Left := (MAIN_DOCK_PANEL.Width - MAIN_DOCK_PANEL.Width) div 2;
   inForm.Top := (MAIN_DOCK_PANEL.Height - MAIN_DOCK_PANEL.Height) div 2;
   inForm.WindowState := wsMaximized;
   inForm.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
   inForm.BorderIcons := [];
   inForm.Position := poDefault;
   inForm.OnDestroy := HandleCloseForm;
   inForm.Tag := inFormType;
end;

procedure tControlForm_Earning.EarningEdit;
begin
   frm_EarningList.Edit();
end;

function tControlForm_Earning.Earning_EnableDisableButtons: boolean;
begin
   result := true;
   if ( frm_EarningList <> NIL ) then
      if ( frm_EarningList.Count = 0 ) then
         result := false;
end;


procedure tControlForm_Earning.EarningHelp;
begin
   AvoBaseHelp_Execute('ControlForm_Earning');
end;

procedure tControlForm_Earning.EarningLoadByCycle;
begin
   frm_EarningList.LoadByCycle();
end;

procedure tControlForm_Earning.EarningNew;
begin
   frm_EarningList.New();
end;

procedure tControlForm_Earning.EarningPrint;
var
   rpt_Earning_EarningByCycle : TReport_Earning_EarningByCycle;
   errMsg : string;
begin
   rpt_Earning_EarningByCycle := TReport_Earning_EarningByCycle.Create( Application );
   // Setup Options
   rpt_Earning_EarningByCycle.SetOptions(
      frm_EarningList.EarningListOrgID,
      frm_EarningList.EarningListCycleID,
      frm_EarningList.EarningListCycleID );
      // Check for Errors
      errMsg := rpt_Earning_EarningByCycle.CanPrint;
      if ( errMsg = '' ) then
      begin
         rpt_Earning_EarningByCycle.QReport.Preview();
      end else
         AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
      // Free it
      if (rpt_Earning_EarningByCycle <> NIL) then
         FreeAndNil(rpt_Earning_EarningByCycle);
end;

procedure tControlForm_Earning.EarningQuickAdd;
begin
   if ( frm_EarningList <> NIL ) then
      frm_EarningList.EarningQuickAdd();
end;

procedure tControlForm_Earning.EarningReports;
begin
   ShowMessage('EarningCONTROL : REPORTS');
end;

procedure tControlForm_Earning.EarningView;
begin
   frm_EarningList.View();

end;


procedure tControlForm_Earning.GlobalRefreshEvent;
begin
   if ( frm_EarningList <> NIL ) then
      frm_EarningList.GlobalRefreshEvent();
end;

procedure tControlForm_Earning.HandleCloseForm(Sender: TObject);
begin
  case tForm(Sender).Tag of
    Earning_LIST: frm_EarningList := Nil;
  end;
end;

procedure tControlForm_Earning.StartForm;
begin
	if (frm_EarningList = NIL) then
   begin
   	frm_EarningList := TEarningListForm.Create(Application);
      //
      DockForm( frm_EarningList, Earning_LIST );
   end;
   //
   if (frm_EarningList <> NIL) then
   	frm_EarningList.Show();
end;

function tControlForm_Earning.tygHjehtU88jge: vEnResultRec;
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

procedure tControlForm_Earning.StopForm;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#65 + #100 + #100 + #105 + #110 + #103 + #32 + #69 + #120 + #112 + #101 +
         #110 + #115 + #101 + #115 + #32 + #111 + #114 + #32 + #69 + #97 + #114 + #110 + #105 + #110 +
         #103 + #115 + #32 + #111 + #117 + #116 + #115 + #105 + #100 + #101 + #32 + #116 + #104 +
         #101 + #32 + #101 + #100 + #105 + #116 + #111 + #114 + #32 + #105 + #115 + #32 + #114 +
         #101 + #115 + #101 + #114 + #118 + #101 + #100 + #32 + #102 + #111 + #114 + #32 + #114 +
         #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 + #32 + #65 + #118 + #111 +
         #66 + #97 + #115 + #101 + #32 + #67 + #117 + #115 + #116 + #111 + #109 + #101 + #114 +
         #115 + #32 + #111 + #110 + #108 + #121 + #46); {Adding Expenses or Earnings outside the
         editor is reserved for registered AvoBase Customers only.}
   end else
      if (frm_EarningList <> NIL) then
         frm_EarningList.Close();
end;

procedure tControlForm_Earning.EditEarningTypes;
begin
   Preference_EditEarningTypes();
end;


end.
