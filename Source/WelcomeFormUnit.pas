 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit  WelcomeFormUnit;

interface uses
   img_storageformunit,
   actionunit,
   masterdata_navigationtoolunit,
   MasterData_BaseGridUnit,
   MasterData_OrgWelcomeFormListUnit,
   MasterDataunit,
   constantsunit,
   toolboxunit,
   avobase_percentformunit,
   avobase_dialogformunit,
   AvoBase_StartupFormUnit,
   VerificationUnit,
   INIFileUnit,
   EncryptUnit,
   avobase_registerdialogformunit,
   //
   Windows,
   db,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   ComCtrls,
   ToolWin,
   ExtCtrls,
   StdCtrls,
   jpeg,
   Grids,
   DBGrids,
   ActnList,
   themes,
   Menus,
   Buttons,
   pngimage,
   OleCtrls,
   SHDocVw;


type
   tWelcomeForm = class(TForm)
      ActionList: TActionList;
      actHelp: TAction;
      actForums: TAction;
      actContactUs: TAction;
      actSettings: TAction;
      actUpdates: TAction;
      actOrgs: TAction;
      SettingsMenu: TPopupMenu;
      actKey: TAction;
      RegistrationSettings1: TMenuItem;
    NoteBook: TNotebook;
    WELCOME_BACK_PANEL: TPanel;
    imgAvoIcon: TImage;
    imgAvoName: TImage;
    labelAvobaseName: TLabel;
    labelCopyright: TLabel;
    labelVersion: TLabel;
    splitter6: TPanel;
    Panel2: TPanel;
    ORG_CYCLE_DOCK_PANEL: TPanel;
    org_list_header: TPanel;
    Label20: TLabel;
    splitter7: TPanel;
    blog_back_panel: TPanel;
    Browser: TWebBrowser;
    Panel1: TPanel;
    SettingsButton: TSpeedButton;
    Label13: TLabel;
    Label12: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel30: TPanel;
    HelpButton: TSpeedButton;
    ForumButton: TSpeedButton;
    UpdatesButton: TSpeedButton;
    Label2: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    actFB: TAction;
    lb_expiredcycle: TLabel;
    Label1: TLabel;
      procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure ActionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
   protected
      fActionEvent : tWelcomeEvent;
   private
   	HasBlogged : boolean;
      procedure HandleActionExecute(Sender: TObject);
      procedure Set_Encrypt_Vars();
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn;State: TGridDrawState);
   public
      dataListGrid : tAvoBaseDBGrid;
      gridDataSource : tDataSource;
      OrgListQuery : tMasterDataOrgWelcomeList;
      //
      procedure UpdateCycleListQuery();
      procedure RefreshAllData();
      procedure GlobalRefreshEvent();
      procedure BlogButton();
      procedure HomeButton();
      procedure StartupForm();
      //
      property onActionEvent : tWelcomeEvent read fActionEvent write fActionEvent;
      constructor Create(); virtual;
  end;

implementation

{$R *.dfm}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

constructor TWelcomeForm.Create;
begin
   inherited create(nil);
   //
   HasBlogged := False;
   //
   actHelp.tag := CMD_MAIN_HELP;
   actForums.tag := CMD_MAIN_FORUMS;
   actContactUs.tag := CMD_MAIN_CONTACTUS;
   actSettings.tag := CMD_MAIN_SETTINGS;
   actUpdates.tag := CMD_MAIN_CHECKUPDATES;
   actKey.tag := CMD_MAIN_DONATE;
   actFB.Tag := CMD_WELCOME_FB;
   //
	gridDataSource := tDataSource.Create(nil);
   dataListGrid := tAvoBaseDBGrid.Create( nil, ORG_CYCLE_DOCK_PANEL );
   dataListGrid.Options := [];
   //
   //
   orgListQuery := tMasterDataOrgWelcomeList.Create( masterData);
   //
   gridDataSource.DataSet := orgListQuery;
   //
   DataListGrid.Init( orgListQuery, 'NAME' );
   DataListGrid.Clear;
   DataListGrid.Add(orgListQuery.FieldByName('NAME'), 'Organization', 130, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(orgListQuery.FieldByName('CYCLE'), 'Cycle', 70, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(orgListQuery.FieldByName('ORGEND'), 'End Date', 70, clBlue, [fsBold], taRightJustify);
   DataListGrid.Add(orgListQuery.FieldByName('OPEN'), 'Open', 60, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(orgListQuery.FieldByName('CLOSED'), 'Closed', 60, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(orgListQuery.FieldByName('CANCELLED'), 'Cancel', 60, clBlack, [fsBold], taRightJustify);
   DataListGrid.OnDrawColumnCell := HandleOnDrawCellEvent;
   //
   DataListGrid.Options := [dgTitles,dgRowLines,dgTabs,dgRowSelect,dgConfirmDelete,dgCancelOnExit];
   //
   orgListQuery.Open();
   //
   labelVersion.Caption := VER_NUM;
	labelCopyright.Caption := AVOBASE_COPYRIGHT;
   lb_expiredcycle.Visible := false;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tWelcomeForm.FormShow(Sender: TObject);
begin
   PercentForm_Free(); // DO NOT REMOVE THIS!!! IT IS DONE BY AVOBASE AS A "STARTING UP"
   StartPercentForm_Update();
   StartPercentForm_Update();
   FreeAndNil(StartPercentForm);
end;

procedure tWelcomeForm.GlobalRefreshEvent;
begin
   UpdateCycleListQuery();
   Set_Encrypt_Vars();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TWelcomeForm.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;
   case action.Tag of
      CMD_SAVE : ; // should be CMD_SAVE
   end;
end;

procedure tWelcomeForm.BlogButton;
begin
	NoteBook.ActivePage := 'Blog';
   if (NOT HasBlogged) then
   	Browser.Navigate('http://www.avobase.com/blog/index.html');
   HasBlogged := True;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TWelcomeForm.ActionExecute(Sender: TObject);
begin
   if Assigned(fActionEvent) then
      fActionEvent(Self, tAction(Sender).Tag);
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure TWelcomeForm.HandleActionExecute(Sender: TObject);
begin
   // the action event has fired, so we want to fire the response back to the form where it can be processed.
   // we pass back the action type, so the method that created this object knows what button was pressed.
   // the .tag contains the action type as we're not using a custom wrapper.
   with Sender as tAction do
   begin
      if Assigned(fActionEvent) then
         fActionEvent(Self, tAction(Sender).Tag);
   end;
end;


procedure tWelcomeForm.HomeButton;
begin
	NoteBook.ActivePage := 'Home';
end;

procedure tWelcomeForm.RefreshAllData;
begin
   UpdateCycleListQuery();
   Set_Encrypt_Vars();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tWelcomeForm.UpdateCycleListQuery;
begin
	orgListQuery.Refresh();
//   orgListQuery.Close();
//   orgListQuery.Open();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tWelcomeForm.Set_Encrypt_Vars;
var
//	ObjVerf : tKeyVerif;
   WorkStr, St31, St32 : String;
   CheckDays : Integer;
begin
   (*
	ObjVerf := tKeyVerif.Create;
	if NOT(ObjVerf.Tk4726TuI) then
	begin
      {UNREGISTERED! Visit AVOBASE.COM to Register and Unlock Features!}
      AvoRegisterLabel.Caption := #85 + #78 + #82 + #69 + #71 + #73 + #83 + #84 + #69 + #82 + #69 + #68 + #33 +
      #32 + #86 + #105 + #115 + #105 + #116 + #32 + #65 + #86 + #79 + #66 + #65 + #83 + #69 + #46 + #67 + #79 +
      #77 + #32 + #116 + #111 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #32 + #97 + #110 +
      #100 + #32 + #85 + #110 + #108 + #111 + #99 + #107 + #32 + #70 + #101 + #97 + #116 + #117 + #114 + #101 +
      #115 + #33;

      {AvoBase is not Registered.}
      St31 := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #105 + #115 + #32 + #110 + #111 + #116 + #32 + #82 +
      #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 + #46;
      RegAvoWeb.Caption := St31;
      RegAvoWeb.Font.Color := clRed;
      RegAvoWeb.Font.Style := [fsBold];

      {Unregistered versions of AvoBase are limited in the number of Orders, Customers, Credits, Expenses and extended Reports.}
      st32 := #85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 + #32 + #118 + #101 +
         #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 + #65 + #118 + #111 + #66 + #97 + #115 +
         #101 + #32 + #97 + #114 + #101 + #32 + #108 + #105 + #109 + #105 + #116 + #101 + #100 + #32 + #105 +
         #110 + #32 + #116 + #104 + #101 + #32 + #110 + #117 + #109 + #98 + #101 + #114 + #32 + #111 + #102 +
         #32 + #79 + #114 + #100 + #101 + #114 + #115 + #44 + #32 + #67 + #117 + #115 + #116 + #111 + #109 + #101 +
         #114 + #115 + #44 + #32 + #67 + #114 + #101 + #100 + #105 + #116 + #115 + #44 + #32 + #69 + #120 + #112 + #101 +
         #110 + #115 + #101 + #115 + #32 + #97 + #110 + #100 + #32 + #101 + #120 + #116 + #101 + #110 + #100 + #101 +
         #100 + #32 + #82 + #101 + #112 + #111 + #114 + #116 + #115 + #46 + #13 + #13;

      {You may continue to use AvoBase unregistered in a limited capacity.}
      st32 := st32 + #89 + #111 + #117 + #32 + #109 + #97 + #121 + #32 + #99 + #111 + #110 + #116 + #105 + #110 + #117 +
      #101 + #32 + #116 + #111 + #32 + #117 + #115 + #101 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 +
      #117 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 + #32 + #105 + #110 + #32 +
      #97 + #32 + #108 + #105 + #109 + #105 + #116 + #101 + #100 + #32 + #99 + #97 + #112 + #97 + #99 + #105 + #116 +
      #121 + #46 + #13 + #13;

      AvoRegisterLabel.Caption := st32;
      AvoRegisterLabel.Font.Color := clRed;

      {Please visit http://www.avobase.com to learn how to Register AvoBase.}
      st32 := st32 + #80 + #108 + #101 + #97 + #115 + #101 + #32 + #118 + #105 + #115 + #105 + #116 + #32 + #104 + #116 +
      #116 + #112 + #58 + #47 + #47 + #119 + #119 + #119 + #46 + #97 + #118 + #111 + #98 + #97 + #115 + #101 + #46 +
      #99 + #111 + #109 + #32 + #116 + #111 + #32 + #108 + #101 + #97 + #114 + #110 + #32 + #104 + #111 + #119 + #32 +
      #116 + #111 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #32 + #65 + #118 + #111 + #66 + #97 +
      #115 + #101 + #46;


      if NOT(ObjVerf.Tk4726Tu1) then
      begin
         { Nag them only once every 10 times they run AvoBase }
         CheckDays := AvoINIReadInteger(AVOBASE_NAME, 'TK7', 100);
         Inc(CheckDays);
         if (CheckDays >= 10) then
         begin
            CheckDays := 0;
            //AvoBaseDialog(St31, St32, mtinformation, [mbok], 0);
            AvoBaseRegisterDialog( st32 );
         end;
         AvoINIWriteInteger(AVOBASE_NAME, 'TK7', CheckDays);
      end;
   end else
      begin
         st32 := #84 + #104 + #105 + #115 + #32 + #99 + #111 + #112 + #121 + #32 + #111 + #102 + #32 + #65 + #118 +
            #111 + #66 + #97 + #115 + #101 + #32 + #105 + #115 + #32 + #114 + #101 + #103 + #105 + #115 + #116 +
            #101 + #114 + #101 + #100 + #32 + #116 + #111; {This copy of AvoBase is registered to}
         st32 := st32 + ' ' + ObjVerf.FIRST_NAME + ' ' + ObjVerf.MIDDLE_INITIAL + ' ' + ObjVerf.LAST_NAME + '.';
         st32 := st32 + ' ' + #82 + #101 + #103 + #105 + #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 +
            #32 + #101 + #120 + #112 + #105 + #114 + #101 + #115 + #32 + #105 + #110; {Registration expires in}
         WorkStr := FloatToStr( ObjVerf.ExpDate - NOW );
         Delete(WorkStr,Pos('.', WorkStr), Length(WorkStr));
         CheckDays := StrToInt(WorkStr);
         st32 := st32 + ' ' + IntToStr( CheckDays );
         st32 := st32 + ' ' + #100 + #97 + #121 + #40 + #115 + #41; {day(s)}
         st32 := st32 + ' ' + #79 + #110; {On}
         st32 := st32 + ' ' + DateToStr( ObjVerf.ExpDate ) + '.';
         AvoRegisterLabel.Caption := st32;
         AvoRegisterLabel.Font.Color := clBlue;
         //
         st32 := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #105 + #115 + #32 + #70 + #85 + #76 + #76 +
            #89 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 + #46 + #32 + #84 +
            #104 + #97 + #110 + #107 + #32 + #121 + #111 + #117 + #32 + #102 + #111 + #114 + #32 + #121 + #111 +
            #117 + #114 + #32 + #115 + #117 + #112 + #112 + #111 + #114 +
            #116 + #33; {AvoBase is FULLY Registered. Thank you for your support!}
         RegAvoWeb.Caption := st32;
         //
         RegisterButton.Visible := False;
		end;

	{ *** NOW CHECK EXPIRATION DATES FOR WARNINGS *** }

	if (ObjVerf.Tk4726TuI) AND NOT(ObjVerf.Tk4726Tu1) then
	begin
      { THIS VERSION OF AVOBASE IS REGISTERED CORRECTLY - BUT THE KEY HAS EXPIRED }
      { ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** }
      if (OBJVerf.EXP) then
      begin
         st32 := #84 + #104 + #105 + #115 + #32 + #99 + #111 + #112 + #121 + #32 + #111 + #102 + #32 + #65 + #118 +
            #111 + #66 + #97 + #115 + #101 + #32 + #105 + #115 + #32 + #114 + #101 + #103 + #105 + #115 + #116 +
            #101 + #114 + #101 + #100 + #32 + #116 + #111; {This copy of AvoBase is registered to}
         st32 := st32 + ' ' + ObjVerf.FIRST_NAME + ' ' + ObjVerf.MIDDLE_INITIAL + ' ' + ObjVerf.LAST_NAME + '.';
         st32 := st32 + ' ' + #82 + #101 + #103 + #105 + #115 + #116 + #114 + #97 + #116 + #105 + #111 +
            #110 + #32 + #69 + #88 + #80 + #73 + #82 + #69 + #68 + #32 + #111 + #110; {Registration EXPIRED on}
         st32 := st32 + ' ' + DateToStr( ObjVerf.ExpDate ) + '.';
         AvoRegisterLabel.Caption := st32;
         AvoRegisterLabel.Font.Color := clRED;
         AvoRegisterLabel.Font.Style := [fsBold];

         RegAvoWeb.Caption := #82 + #101 + #45 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 +
            #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #84 + #111 + #100 + #97 + #121 +
            #32 + #84 + #111 + #32 + #67 + #111 + #110 + #116 + #105 + #110 + #117 + #101 + #32 + #87 +
            #105 + #116 + #104 + #32 + #70 + #117 + #108 + #108 + #32 + #70 + #101 + #97 + #116 + #117 +
            #114 + #101 + #115 + #33; {Re-Register AvoBase Today To Continue With Full Features!}
         RegisterButton.Visible := TRUE;

         {AvoBase Registration Expired}
         St31 := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #82 + #101 + #103 + #105 +
            #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 + #32 + #69 + #120 + #112 + #105 + #114 + #101 + #100;
         RegAvoWeb.Caption := st31;

         {Your Registration of AvoBase expired on}
         St32 :=	#89 + #111 + #117 + #114 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #114 +
            #97 + #116 + #105 + #111 + #110 + #32 + #111 + #102 + #32 + #65 + #118 + #111 + #66 + #97 +
            #115 + #101 + #32 + #101 + #120 + #112 + #105 + #114 + #101 + #100 + #32 + #111 + #110 + #32;
         St32 := St32 + (ObjVerf.END_DATE) + #46 + #32;
         St32 := St32 + #13 + #13;
         {To continue using AvoBase in fully Registered Mode, you will need to purchase an additional Registration License.}
         St32 := St32 + #84 + #111 + #32 + #99 + #111 + #110 + #116 + #105 + #110 + #117 + #101 + #32 +
            #117 + #115 + #105 + #110 + #103 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 +
            #105 + #110 + #32 + #102 + #117 + #108 + #108 + #121 + #32 + #82 + #101 + #103 + #105 + #115 +
            #116 + #101 + #114 + #101 + #100 + #32 + #77 + #111 + #100 + #101 + #44 + #32 + #121 + #111 +
            #117 + #32 + #119 + #105 + #108 + #108 + #32 + #110 + #101 + #101 + #100 + #32 + #116 + #111 +
            #32 + #112 + #117 + #114 + #99 + #104 + #97 + #115 + #101 + #32 + #97 + #110 + #32 + #97 +
            #100 + #100 + #105 + #116 + #105 + #111 + #110 + #97 + #108 + #32 + #82 + #101 + #103 + #105 +
            #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 + #32 + #76 + #105 + #99 + #101 + #110 +
            #115 + #101 + #46;
         St32 := St32 + #13 + #13;
         St32 := St32 + #87 + #101 + #32 + #103 + #114 + #101 + #97 + #116 + #108 + #121 + #32 + #97 + #112 +
            #112 + #114 + #101 + #99 + #105 + #97 + #116 + #101 + #32 + #121 + #111 + #117 + #114 + #32 +
            #98 + #117 + #115 + #105 + #110 + #101 + #115 + #115 + #32 + #97 + #110 + #100 + #32 + #104 +
            #111 + #112 + #101 + #32 + #116 + #104 + #97 + #116 + #32 + #121 + #111 + #117 + #32 + #104 +
            #97 + #118 + #101 + #32 + #102 + #111 + #117 + #110 + #100 + #32 + #65 + #118 + #111 + #66 +
            #97 + #115 + #101 + #32 + #116 + #111 + #32 + #98 + #101 + #32 + #111 + #102 + #32 + #118 +
            #97 + #108 + #117 + #101 + #46 + #32 + #89 + #111 + #117 + #114 + #32 + #99 + #111 + #110 +
            #116 + #105 + #110 + #117 + #101 + #100 + #32 + #114 + #101 + #103 + #105 + #115 + #116 +
            #114 + #97 + #116 + #105 + #111 + #110 + #32 + #104 + #101 + #108 + #112 + #115 + #32 + #116 +
            #111 + #32 + #109 + #97 + #107 + #101 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 +
            #32 + #98 + #101 + #116 + #116 + #101 + #114 + #46 + #32 + #84 + #104 + #97 + #110 + #107 +
            #32 + #121 + #111 + #117 + #32 + #102 + #111 + #114 + #32 + #117 + #115 + #105 + #110 + #103 +
            #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #33; {We greatly appreciate your business and
            hope that you have found AvoBase to be of value. Your continued registration helps to make AvoBase
            better. Thank you for using AvoBase!}

         CheckDays := AvoINIReadInteger(AVOBASE_NAME, 'TK12', 100);
         Inc(CheckDays);
         if (CheckDays >= 10) then
         begin
            CheckDays := 0;
            //AvoBaseDialog(St31, St32, mtinformation, [mbok], 0);
            AvoBaseRegisterDialog( st32 );
         end;
         AvoINIWriteInteger(AVOBASE_NAME, 'TK12', CheckDays);
      end;
   end else
      begin
         if (OBJVerf.ExpDate - NOW <= 30) AND (OBJVerf.ExpDate <> -999) then
         begin
            { THIS VERSION OF AVOBASE IS REGISTERED CORRECTLY - KEY WILL SOON EXPIRE }
            { ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** }
            st32 := #84 + #104 + #105 + #115 + #32 + #99 + #111 + #112 + #121 + #32 + #111 + #102 + #32 + #65 + #118 +
               #111 + #66 + #97 + #115 + #101 + #32 + #105 + #115 + #32 + #114 + #101 + #103 + #105 + #115 + #116 +
               #101 + #114 + #101 + #100 + #32 + #116 + #111; {This copy of AvoBase is registered to}
            st32 := st32 + ' ' + ObjVerf.FIRST_NAME + ' ' + ObjVerf.MIDDLE_INITIAL + ' ' + ObjVerf.LAST_NAME + '.';
            st32 := st32 + ' ' + #82 + #101 + #103 + #105 + #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 +
               #32 + #101 + #120 + #112 + #105 + #114 + #101 + #115 + #32 + #105 + #110; {Registration expires in}
            WorkStr := FloatToStr( ObjVerf.ExpDate - NOW );
            Delete(WorkStr,Pos('.', WorkStr), Length(WorkStr));
            CheckDays := StrToInt(WorkStr);
            st32 := st32 + ' ' + IntToStr( CheckDays );
            st32 := st32 + ' ' + #100 + #97 + #121 + #40 + #115 + #41; {day(s)}
            st32 := st32 + ' ' + #79 + #110; {On}
            st32 := st32 + ' ' + DateToStr( ObjVerf.ExpDate ) + '.';
            AvoRegisterLabel.Caption := st32;
            AvoRegisterLabel.Font.Color := clRed;

            {AvoBase Registration Soon To Expire!}
            St31 := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #82 + #101 + #103 + #105 + #115 +
               #116 + #114 + #97 + #116 + #105 + #111 + #110 + #32 + #83 + #111 + #111 + #110 + #32 + #84 +
               #111 + #32 + #69 + #120 + #112 + #105 + #114 + #101 + #33;

            St32 := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #82 + #101 + #103 + #105 + #115 +
               #116 + #114 + #97 + #116 + #105 + #111 + #110 + #32 + #101 + #120 + #112 + #105 + #114 +
               #101 + #115 + #32 + #111 + #110; {AvoBase Registration expires on}
            St32 := St32 + ' ' + ObjVerf.END_DATE + #46 + #32;
            RegAvoWeb.Caption := st32;
            RegAvoWeb.Font.Color := clRed;

            {Purchase an additional year of Registration now to avoid restricted AvoBase use when your Registration Expires! Visit AvoBase.COM today!}
            St32 := St32 + #80 + #117 + #114 + #99 + #104 + #97 + #115 + #101 + #32 + #97 + #110 + #32 +
               #97 + #100 + #100 + #105 + #116 + #105 + #111 + #110 + #97 + #108 + #32 + #121 + #101 +
               #97 + #114 + #32 + #111 + #102 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #114 +
               #97 + #116 + #105 + #111 + #110 + #32 + #110 + #111 + #119 + #32 + #116 + #111 + #32 +
               #97 + #118 + #111 + #105 + #100 + #32 + #114 + #101 + #115 + #116 + #114 + #105 + #99 +
               #116 + #101 + #100 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #117 +
               #115 + #101 + #32 + #119 + #104 + #101 + #110 + #32 + #121 + #111 + #117 + #114 + #32 +
               #82 + #101 + #103 + #105 + #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 + #32 +
               #69 + #120 + #112 + #105 + #114 + #101 + #115 + #33 + #32 + #86 + #105 + #115 + #105 +
               #116 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #46 + #67 + #79 + #77 + #32 +
               #116 + #111 + #100 + #97 + #121 + #33;

            { Nag them only once very 10 times that they have expired but can continue }
            CheckDays := AvoINIReadInteger(AVOBASE_NAME, 'TK8', 100);
            Inc(CheckDays);
            if (CheckDays >= 10) then
            begin
               CheckDays := 0;
               //AvoBaseDialog(St31, St32, mtinformation, [mbok], 0);
               AvoBaseRegisterDialog( st32 );
            end;
            AvoINIWriteInteger(AVOBASE_NAME, 'TK8', CheckDays);
         end;
      end;

   { END }
	FreeAndNil(ObjVerf);
   *)
end;

procedure tWelcomeForm.StartupForm;
begin
   Set_Encrypt_Vars();
end;

// draw state
procedure tWelcomeForm.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
	if (orgListQuery.FieldByName('EXPIRED').AsBoolean) then
   begin
      DataListGrid.Canvas.Font.Color := clRed;
      DataListGrid.Canvas.Font.Style := [fsBold];
      DataListGrid.Canvas.Brush.Color := $00EBE2FE;
      DataListGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      lb_expiredcycle.Visible := true;
   end;
end;

end.






