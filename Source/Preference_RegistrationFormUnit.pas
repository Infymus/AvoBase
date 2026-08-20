 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit	Preference_RegistrationFormUnit;

interface uses
   preference_baseformunit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   inifileunit,
   VerificationUnit,
   AvoBase_ToolBarUnit,
   ActionUnit,
   AvoBase_FindKeyWebDialogFormUnit,
   AvoBase_PercentFormUnit,
   avobase_dialogformunit,
   urlmon,
   //
   windows,
   messages,
   sysutils,
   ShellAPI,
   variants,
   classes,
   graphics,
   controls,
   forms,
   dialogs,
   db,
   extctrls,
   stdctrls,
   mask,
   jpeg,
   buttons;

TYPE
   tPref_RegistrationForm = class(TPrefBaseForm)
      OpenDLG: TOpenDialog;
      MENU_DOCK_PANEL: TPanel;
    AvoRegisterLabel: TLabel;
    RegAvoWeb: TLabel;
    RegBox: TGroupBox;
    RepName: TLabel;
    Label20: TLabel;
    Label2: TLabel;
    Addr1: TLabel;
    Addr2: TLabel;
    City: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    State: TLabel;
    Label6: TLabel;
    Zip: TLabel;
      procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
      Procedure RuNReg;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      toolBar : tAvoBaseToolBar;
      procedure GlobalRefreshEvent();
      procedure FindKey();
      procedure FindKeyWeb();
   end;

Procedure Preference_RegistrationPage;

implementation

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

Procedure Preference_RegistrationPage;
var
   PrefForm_Registration : TPref_RegistrationForm;
begin
   PrefForm_Registration := TPref_RegistrationForm.Create(nil, PREF_REGISTRATION);
   PrefForm_Registration.toolbar.CreateButtonSep();
   PrefForm_Registration.toolbar.CreateButton( CMD_CLOSE );
   PrefForm_Registration.Border := 1;
   PrefForm_Registration.ShowModal();
   FreeAndNil(PrefForm_Registration);
end;


procedure tPref_RegistrationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FreeAndNil( toolBar );
   //
   inherited;
end;



procedure TPref_RegistrationForm.FormCreate(Sender: TObject);
begin
   Inherited;
   //
   toolBar := tAvoBaseToolBar.Create( MENU_DOCK_PANEL );
   toolbar.CreateButton( CMD_REGISTER );
   toolbar.CreateButton( CMD_FIND_KEY_WEB );
   toolbar.CreateButton( CMD_FIND_KEY );
   toolBar.actionList.OnUpdate := HandleActionListUpdate;
   toolBar.actionList.onActionEvent := HandleActionExecute;
   toolBar.Align := alLeft;
   toolBar.Wrapable := True;
   toolBar.AutoSize := True;
   //
   RuNReg();
end;

procedure TPref_RegistrationForm.GlobalRefreshEvent;
begin
   //
end;

procedure tPref_RegistrationForm.HandleActionExecute(sender: tObject; actionID: integer);
   function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
   begin
     Result := ShellExecute(Application.MainForm.Handle, nil, PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
   end;
begin
   case actionID of
      CMD_CLOSE: Close();
      CMD_REGISTER : ExecuteFile(AVOBASE_PURCHASE, '', '', 0);
      CMD_FIND_KEY : FindKey();
      CMD_FIND_KEY_WEB : FindKeyWeb();
   end;
end;

procedure tPref_RegistrationForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
   Handled := True;
end;


procedure TPref_RegistrationForm.RuNReg;
var
//	ObjVerf : tKeyVerif;
   WorkStr, St31, St32 : String;
   CheckDays : Integer;
begin
   (*
	ObjVerf := tKeyVerif.Create;
	if NOT(ObjVerf.Tk4726TuI) then
	begin
      RegBox.Visible := False;

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
   end else
      begin
			RepName.Caption := ObjVerf.FIRST_NAME + ' ' + ObjVerf.MIDDLE_INITIAL + ' ' + ObjVerf.LAST_NAME;
			Addr1.Caption := ObjVerf.ADDRESS1;
			Addr2.Caption := ObjVerf.ADDRESS2;
			City.Caption := ObjVerf.CITY;
			State.Caption := ObjVerf.STATE;
			Zip.Caption := ObjVerf.ZIP;

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
         end;
      end;

   { END }
	FreeAndNil(ObjVerf);
   *)
end;

procedure TPref_RegistrationForm.FindKey();
begin
  inherited;
  OpenDLG.InitialDir := ExtractFileDir(ParamStr(0));
  if OpenDLG.Execute then
  begin
    AvoINIWriteString('AvoBase', 'KeyFile', OpenDLG.FileName);
    RunReg;
    if Assigned(fEvent) then
      fEvent(Self);
  end;
end;


{ this method helps find the key on the web given a very specific URL and brings that key down to AVOBASE }

procedure tPref_RegistrationForm.FindKeyWeb;
var
   keyFile : string;
   saveFile : string;
   canContinue : boolean;
   DLOK : Boolean;
   didFail : boolean;
begin
   keyFile := AvoBaseWebKeyDialog();

   //
   if ( keyFile <> '' ) then
   begin
      saveFile := ExtractFileDir(ParamStr(0))+'\' + keyFile;
      //
      canContinue := true;
      //
      if FileExists(saveFile) then
         if AvoBaseDialog('Key Already Exists', 'The Key you specified already exists on your machine.\n\n' +
            'Overwrite existing key?', mtWarning, [mbyes, mbno], 0) = mbNo then
            canContinue := false;
      //
      if ( canContinue ) then
      begin
         // We will delete it
         if FileExists(saveFile) then
            DeleteFile( saveFile );
         didFail := false;
         PercentForm_Create('Contacting AvoBase.Com for KeyFile', 0, 0);
         try
            DLOK := URLDownloadToFile(NIL, PChar(AVOBASE_KEYS + keyFile ), PChar(SaveFile), 0, NIL) = 0;
         except
            PercentForm_Free();
            AvoBaseDialog('HTTP Error', 'Unable to connect to AVOBASE.COM. Check Firewall? Internet Connectivity', mtError, [mbok], 0);
            didFail := true;
         end;
         PercentForm_Free();
         //
         if NOT ( DLOK ) then
         begin
            AvoBaseDialog('Key Web Error', 'Unable to locate keyfile ' + keyFile + '.\n\n' +
               'Please check Key File Name. Name is case sensative (uppercase/lowercase).', mtError, [mbok], 0);
            exit;
         end;
         //
         if NOT FileExists(SaveFile) then
         begin
            AvoBaseDialog('File Error', 'File Did Not Save Properly', mtError, [mbok], 0);
            didFail := true;
         end;
         //
         if NOT ( didFail ) then
         begin
            // attempt at register
            AvoINIWriteString('AvoBase', 'KeyFile', keyFile);
            RunReg;
            if Assigned(fEvent) then
               fEvent(Self);
         end;
      end;
   end;

//AVOBASE_KEYS


end;



end.
