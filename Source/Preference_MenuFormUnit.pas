 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

UNIT  Preference_MenuFormUnit;

interface uses
	constantsunit,
   masterdataunit,
   toolboxunit,
   avobase_dialogformunit,
   img_storageformunit,
   avobase_percentformunit,
   actionunit,
   toolbox_preferencetoolboxunit,
   Toolbox_OrgToolBoxUnit,
   // Preference Forms
	Preference_BaseFormUnit,
	Preference_RegistrationFormUnit,
   Preference_ShippingFormUnit,
   Preference_OrganizationsFormUnit,
   Preference_TaxMasterFormUnit,
   Preference_FeesFormUnit,
   Preference_GeneralSettingsFormUnit,
   Preference_RepresentativeFormUnit,
   Preference_EmailFormUnit,
   Preference_ExpenseTypeFormUnit,
   Preference_EarningTypeFormUnit,
   Preference_InvoiceSettingsForm,
   AvoBase_HelpFormUnit,
   Preference_ProductSettingsForm,
   // Windows Forms
   windows,
   messages,
   themes,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   Buttons,
   ExtCtrls,
   DBCtrls,
   DB,
   ComCtrls,
   ActnList,
   ToolWin, DBTables;

type
	tPreferencesForm = class( tForm )
    BASE_BACKPANEL: TPanel;
    MAIN_BACK_PANEL: TPanel;
    PREF_DOCK_PANEL: TPanel;
    MENU_DOCK_PANEL: TPanel;
    TOP_MENU_DOCK_PANEL: TPanel;
    SETTINGS_LABEL: TLabel;
    SettingImage: TImage;
    MOPButtonBar: TToolBar;
    topSaveButton: TToolButton;
    SPLIT_LINE_PANEL: TPanel;
    PrefBar: TToolBar;
    representativeSettingsButton: TToolButton;
    generalSettingsButton: TToolButton;
    taxesButton: TToolButton;
    emailButton: TToolButton;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actHelp: TAction;
    feesButton: TToolButton;
    organizationsButton: TToolButton;
    shippingRatesButton: TToolButton;
    earningTypesButton: TToolButton;
    expenseTypesButton: TToolButton;
    actRegistration: TAction;
    actGeneralSettings: TAction;
    actRepSettings: TAction;
    actEmailSettings: TAction;
    actOrganizations: TAction;
    actOrderFees: TAction;
    actTaxRates: TAction;
    actShippingRates: TAction;
    actEarningTypes: TAction;
    actExpenseTypes: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    invoiceSettingsButton: TToolButton;
    actInvoiceSettings: TAction;
    actProductSettings: TAction;
    ToolButton3: TToolButton;
      procedure FormCreate(Sender: TObject);
      procedure ActionListExecute(Sender: TObject);
      procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure PrefViewClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure DataSourceDataChange(Sender: TObject; Field: TField);
      procedure HelpButtonClick(Sender: TObject);
      procedure PrefBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
    procedure FormShow(Sender: TObject);
   private
   	// forms used
      PrefForm_Registration : TPref_RegistrationForm;
      PrefForm_ShippingRates : TPref_ShippingForm;
      PrefForm_Organizations : TPref_OrganizationsForm;
      PrefForm_Taxes : TPref_TaxesMasterForm;
      PrefForm_Fees : tPref_FeesForm;
      PrefForm_General : tPref_GeneralSettingsForm;
      PrefForm_Rep : tPref_RepresentativeForm;
      PrefForm_Email : TPref_EmailSettingsForm;
      PrefForm_ExpenseTypes : TPref_ExpenseTypesForm;
      PrefForm_EarningTypes : TPref_EarningTypesForm;
      PrefForm_InvoiceSettings : TPref_InvoiceSettingsForm;
      PrefForm_ProductSettings : TPref_ProductSettingsForm;
   	fHelpAction : tHelpEvent;
      EventPrefChange : tPrefChange;
      fHelpArea : integer;
      fHelpStartup : boolean;
      {
         PrefForm_Company : TPref_CompanyForm;
         PrefForm_Fees : TPref_FeesForm;
         PrefForm_Expense : TPref_ExpenseTypes;
         PrefForm_Earning : tPref_EarningTypes;
         PrefForm_General : TPref_GeneralSettings;
         PrefForm_Email : tPref_EmailFormUnit;
      }
      Procedure Preference_Menu( InPref:Integer );
      Procedure Handle_Pref_Event( Sender : Tobject );
      Procedure HandlePreferenceRefreshEvent;
   public
      procedure ExecuteStartupHelp();
      Procedure SetPreferenceArea( inPrefArea : tPrefAreaTypes );
   	// Properties
      property OnUPdate : tPrefChange READ EventPrefChange WRITE EventPrefChange;
      property OnHelpAction : tHelpEvent READ fHelpAction WRITE fHelpAction;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPreferencesForm.FormCreate(Sender: TObject);
begin
	fHelpStartup := false;
  Self.Width := 850;
  Self.Height := 600;
  Preference_Menu(PREF_REGISTRATION);
  //
  actShippingRates.tag := PREF_SHIPPINGRATES;
  actOrganizations.tag := PREF_ORGANIZATIONS;
  actSave.tag := PREF_SAVE;
  actCancel.tag := PREF_CANCEL;
  actHelp.tag := PREF_HELP;
  actRegistration.tag := PREF_REGISTRATION;
  actGeneralSettings.tag := PREF_GENERALSETTINGS;
  actRepSettings.tag := PREF_REPSETTINGS;
  actEmailSettings.tag := PREF_EMAILSETTINGS;
  actOrganizations.tag := PREF_ORGANIZATIONS;
  actOrderFees.tag := PREF_ORDERFEES;
  actTaxRates.tag := PREF_TAXRATES;
  actShippingRates.tag := PREF_SHIPPINGRATES;
  actEarningTypes.tag := PREF_EARNINGTYPES;
  actExpenseTypes.tag := PREF_EXPENSETYPES;
  actInvoiceSettings.tag := PREF_INVOICESETTINGS;
  actProductSettings.tag := PREF_PRODUCTSETTINGS;
  actHelp.Tag := PREF_HELP;
end;

procedure tPreferencesForm.FormShow(Sender: TObject);
begin
	if ( fHelpStartup ) then
   	AvoBaseHelp_Execute('FIRSTTIMECONFIGURE');
   fHelpStartup := False;
end;

procedure TPreferencesForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
   OrgID : string;
begin
   // SAVE ANYTHING...
   //
   if ( PrefForm_ProductSettings <> NIL ) then
   begin
      OrgID := PrefForm_ProductSettings.OrgID;
      if ( orgID <> '' ) then
      begin
         Org_PutOrgProductSpecialField( OrgID, 'PRODN1', PrefForm_ProductSettings.db_prodn1.text );
         Org_PutOrgProductSpecialField( OrgID, 'PRODN2', PrefForm_ProductSettings.db_prodn2.text );
         Org_PutOrgProductSpecialField( OrgID, 'PRODN3', PrefForm_ProductSettings.db_prodn3.text );
         Org_PutOrgProductSpecialField( OrgID, 'PRODN4', PrefForm_ProductSettings.db_prodn4.text );
      end;
   end;

   if (PrefForm_General <> nil) then
   begin
      Pref_Set(tPrefConstants.EDITSL, PrefForm_General.db_editshowbuttons.Checked);
      Pref_Set(tPrefConstants.CheckForUpdates, PrefForm_General.db_cup.Checked);
      Pref_Set(tPrefConstants.RegionCode, PrefForm_General.Region);
      Pref_Set(tPrefConstants.dbGridColorGridLines, PrefForm_General.db_DBGRIDCOL.checked);
      Pref_Set(tPrefConstants.NEWORDCURCYCLE, PrefForm_General.db_newordcurcycle.checked);
      Pref_Set(tPrefConstants.INVLIST1, PrefForm_General.db_olist1.ItemIndex );
      Pref_Set(tPrefConstants.INVLIST2, PrefForm_General.db_olist2.ItemIndex );
      Pref_Set(tPrefConstants.INVLIST3, PrefForm_General.db_olist3.ItemIndex );
      Pref_Set(tPrefConstants.INVLIST4, PrefForm_General.db_olist4.ItemIndex );
      Pref_Set(tPrefConstants.INVLIST5, PrefForm_General.db_olist5.ItemIndex );
   end;

   if (PrefForm_InvoiceSettings <> nil) then
   begin
      // save it
      Pref_Set(tPrefConstants.INVHEAD, PrefForm_InvoiceSettings.db_invtop.Text);
      Pref_Set(tPrefConstants.INV1, PrefForm_InvoiceSettings.db_inv1.ItemIndex);
      Pref_Set(tPrefConstants.INV2, PrefForm_InvoiceSettings.db_inv2.ItemIndex);
      Pref_Set(tPrefConstants.INV3, PrefForm_InvoiceSettings.db_inv3.ItemIndex);
      Pref_Set(tPrefConstants.INV4, PrefForm_InvoiceSettings.db_inv4.ItemIndex);
      Pref_Set(tPrefConstants.INV5, PrefForm_InvoiceSettings.db_inv5.ItemIndex);
      Pref_Set(tPrefConstants.INV6, PrefForm_InvoiceSettings.db_inv6.ItemIndex);
		Pref_Set(tPrefConstants.ORGONINVLAB, PrefForm_InvoiceSettings.db_ORGONINVLAB.Checked);
      Pref_Set(tPrefConstants.InvoiceShowDiscount, PrefForm_InvoiceSettings.db_INVSHOW_DISC.Checked);
      Pref_Set(tPrefConstants.SONUM, StrToInt(PrefForm_InvoiceSettings.db_sonum.Text));
      Pref_Set(tPrefConstants.CPRODTYPE, PrefForm_InvoiceSettings.db_CPRODTYPE.ItemIndex );
      Pref_Set(tPrefConstants.InvoiceLineItemStyle, PrefForm_InvoiceSettings.db_lineitemtype.ItemIndex);
      Pref_Set(tPrefConstants.INVCPH, PrefForm_InvoiceSettings.db_INVCPH.ItemIndex );
   end;

   if (PrefForm_Rep <> nil) then
   begin
      // save it
      Pref_Set(tPrefConstants.RepPhone, PrefForm_Rep.db_rphone.text);
      Pref_Set(tPrefConstants.RepFax, PrefForm_Rep.db_rfax.text);
      Pref_Set(tPrefConstants.RepCell, PrefForm_Rep.db_rcell.text);
      Pref_Set(tPrefConstants.RepAddress1, PrefForm_Rep.db_raddr1.text);
      Pref_Set(tPrefConstants.RepAddress2, PrefForm_Rep.db_raddr2.text);
      Pref_Set(tPrefConstants.RepCity, PrefForm_Rep.db_rcity.text);
      Pref_Set(tPrefConstants.RepZip, PrefForm_Rep.db_rzip.text);
      Pref_Set(tPrefConstants.RepState, PrefForm_Rep.db_rstate.text);
      Pref_Set(tPrefConstants.RCOMP, PrefForm_Rep.db_rcomp.text);
      Pref_Set(tPrefConstants.RepName, PrefForm_Rep.db_repname.Text );
   end;

   if (PrefForm_Email <> nil) then
   begin
      PrefForm_Email.Save();
   end;
   //

	{ Close all forms }
   if (PrefForm_Registration <> Nil) then
   	PrefForm_Registration.Close;
   if (PrefForm_ShippingRates <> nil) then
   	PrefForm_ShippingRates.Close();
   if (PrefForm_Taxes <> nil) then
   	PrefForm_Taxes.Close();
   if (PrefForm_Fees <> nil) then
      PrefForm_Fees.Close();
   if (PrefForm_ExpenseTypes <> nil) then
      PrefForm_ExpenseTypes.Close();
   if (PrefForm_EarningTypes <> nil) then
      PrefForm_EarningTypes.Close();
   if (PrefForm_InvoiceSettings <> nil) then
   if ( PrefForm_ProductSettings <> NIL ) then
      PrefForm_ProductSettings.Close();
   //
	Inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPreferencesForm.ActionListExecute(Sender: TObject);
begin
  inherited;
  With Sender as TAction do
    Case Tag Of
     {----------------------}
      PREF_HELP:
      begin
         case fHelpArea of
            PREF_EARNINGTYPES : AvoBaseHelp_Execute('PREF_EARNINGTYPES');
            PREF_EXPENSETYPES : AvoBaseHelp_Execute('PREF_EXPENSETYPES');
            PREF_ORDERFEES : AvoBaseHelp_Execute('PREF_ORDERFEES');
            PREF_TAXRATES : AvoBaseHelp_Execute('PREF_TAXRATES');
            PREF_REGISTRATION : AvoBaseHelp_Execute('PREF_REGISTRATION');
            PREF_SHIPPINGRATES : AvoBaseHelp_Execute('PREF_SHIPPINGRATES');
            PREF_ORGANIZATIONS : AvoBaseHelp_Execute('PREF_ORGANIZATIONS');
            PREF_GENERALSETTINGS : AvoBaseHelp_Execute('PREF_GENERALSETTINGS');
            PREF_REPSETTINGS : AvoBaseHelp_Execute('PREF_REPSETTINGS');
            PREF_EMAILSETTINGS : AvoBaseHelp_Execute('PREF_EMAILSETTINGS');
            PREF_INVOICESETTINGS : AvoBaseHelp_Execute('PREF_INVOICESETTINGS');
            PREF_PRODUCTSETTINGS : AvoBaseHelp_Execute('PREF_PRODUCTSETTINGS');
         end;
      end;
     	PREF_CANCEL:
      begin
      	if AvoBaseDialog('Cancel Settings Changes','Are you sure you want to cancel and lose any changes made?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
            //DataSource.DataSet.Cancel();
         	Close();
         end;
      end;
      PREF_EARNINGTYPES : Preference_Menu(PREF_EARNINGTYPES);
      PREF_EXPENSETYPES : Preference_Menu(PREF_EXPENSETYPES);
      PREF_ORDERFEES : Preference_Menu(PREF_ORDERFEES);
      PREF_TAXRATES: Preference_Menu(PREF_TAXRATES);
      PREF_REGISTRATION: Preference_Menu(PREF_REGISTRATION);
      PREF_SHIPPINGRATES: Preference_Menu(PREF_SHIPPINGRATES);
      PREF_ORGANIZATIONS: Preference_Menu(PREF_ORGANIZATIONS);
      PREF_GENERALSETTINGS : Preference_Menu( PREF_GENERALSETTINGS );
      PREF_REPSETTINGS: Preference_menu(PREF_REPSETTINGS);
      PREF_EMAILSETTINGS: Preference_Menu(PREF_EMAILSETTINGS);
      PREF_INVOICESETTINGS: Preference_Menu(PREF_INVOICESETTINGS);
      PREF_PRODUCTSETTINGS: Preference_Menu(PREF_PRODUCTSETTINGS);
      PREF_SAVE: Close();
     {----------------------}
    end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPreferencesForm.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  inherited;
  Handled := True;
  Enabled := True;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ Pref Click Events }
procedure TPreferencesForm.PrefViewClick(Sender: TObject);
begin
  Preference_Menu((Sender AS tToolButton).Tag);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPreferencesForm.SetPreferenceArea(inPrefArea: tPrefAreaTypes);
begin
   case inPrefArea of
      tPrefAreaTypes.EarningTypes: Preference_Menu(PREF_EARNINGTYPES);
      tPrefAreaTypes.ExpenseTypes: Preference_Menu(PREF_EXPENSETYPES);
      tPrefAreaTypes.OrderFees: Preference_Menu(PREF_ORDERFEES);
      tPrefAreaTypes.TaxRates: Preference_Menu(PREF_TAXRATES);
      tPrefAreaTypes.Registration: Preference_Menu(PREF_REGISTRATION);
      tPrefAreaTypes.ShippingRates: Preference_Menu(PREF_SHIPPINGRATES);
      tPrefAreaTypes.Organizations: Preference_Menu(PREF_ORGANIZATIONS);
      tPrefAreaTypes.GeneralSettings: Preference_Menu( PREF_GENERALSETTINGS );
      tPrefAreaTypes.RepSettings: Preference_menu(PREF_REPSETTINGS);
      tPrefAreaTypes.EmailSettings: Preference_Menu(PREF_EMAILSETTINGS);
      tPrefAreaTypes.InvoiceSettings: Preference_Menu(PREF_INVOICESETTINGS);
      tPrefAreaTypes.ProductSettings: Preference_Menu(PREF_PRODUCTSETTINGS);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPreferencesForm.Preference_Menu(InPref: Integer);
  {----------------------------------------------------------------------------------------------}
  Procedure Dock_Form( InForm : tForm );
  begin
    InForm.ManualDock(PREF_DOCK_PANEL, nil, alClient);
    InForm.BorderStyle := bsNone;
    InForm.Left := (Self.Width - PREF_DOCK_PANEL.Width) div 2;
    InForm.Top := (Self.Height - PREF_DOCK_PANEL.Height) div 2;
    InForm.WindowState := wsMaximized;
    InForm.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
    InForm.BorderIcons := [];
    InForm.Position := poDefault;
    InForm.show;
  end;
  {----------------------------------------------------------------------------------------------}
Var
  WorkForm : tForm;
begin
   fHelpArea := InPref;
	{ Assign it by Type }
   Case InPref of
      PREF_ORDERFEES : WorkForm := PrefForm_Fees;
   	PREF_REGISTRATION : WorkForm := PrefForm_Registration;
      PREF_SHIPPINGRATES : WorkForm := PrefForm_ShippingRates;
      PREF_ORGANIZATIONS : WorkForm := PrefForm_Organizations;
      PREF_TAXRATES : WorkForm := PrefForm_Taxes;
      PREF_GENERALSETTINGS : WorkForm := PrefForm_General;
      PREF_REPSETTINGS: WorkForm := PrefForm_Rep;
      PREF_EMAILSETTINGS: WorkForm := PrefForm_Email;
      PREF_EXPENSETYPES: WorkForm := PrefForm_ExpenseTypes;
      PREF_EARNINGTYPES: WorkForm := PrefForm_EarningTypes;
      PREF_INVOICESETTINGS: WorkForm := PrefForm_InvoiceSettings;
      PREF_PRODUCTSETTINGS:  WorkForm := PrefForm_ProductSettings;
   end;

   { Does the form exist? }
   if WorkForm <> NIL then
   begin
   	WorkForm.Show;
      Exit;
   end;

   { Does not, so let us create it }
   Case InPref of
      PREF_PRODUCTSETTINGS:
      begin
         if ( Org_GetOrgCount() = 0 ) then
         begin
            AvoBaseDialog('Product Settings','Product Settings are Organizational based. Please create an Organization first.', mtError, [mbOk], 0);
            EXIT; // do NOT go any further
         end;
         PrefForm_ProductSettings := TPref_ProductSettingsForm.Create(nil, inPref);
         PrefForm_ProductSettings.OnEvent := Handle_Pref_Event;
      end;
      PREF_INVOICESETTINGS:
      begin
         PrefForm_InvoiceSettings := TPref_InvoiceSettingsForm.Create(nil, inPref);
         PrefForm_InvoiceSettings.OnEvent := Handle_Pref_Event;
      end;
      PREF_EARNINGTYPES:
      begin
         PrefForm_EarningTypes := TPref_EarningTypesForm.Create(nil, inPref);
         PrefForm_EarningTypes.OnEvent := Handle_Pref_Event;
      end;
      PREF_EXPENSETYPES:
      begin
         PrefForm_ExpenseTypes := TPref_ExpenseTypesForm.Create(nil, inPref);
         PrefForm_ExpenseTypes.OnEvent := Handle_Pref_Event;
      end;
      PREF_ORDERFEES:
      begin
         PrefForm_Fees := tPref_FeesForm.Create(nil, inPref);
         PrefForm_Fees.OnEvent := Handle_Pref_Event;
      end;
   	PREF_TAXRATES:
      begin
         PrefForm_Taxes := TPref_TaxesMasterForm.Create(nil, inPref);
         PrefForm_Taxes.OnEvent := Handle_Pref_Event;
      end;
   	PREF_ORGANIZATIONS:
      begin
         PrefForm_Organizations := TPref_OrganizationsForm.Create(nil, inPref);
         PrefForm_Organizations.OnEvent := Handle_Pref_Event;
         PrefForm_Organizations.OnPreferenceRefreshEvent := HandlePreferenceRefreshEvent;
      end;
   	PREF_REGISTRATION:
      begin
         PrefForm_Registration := TPref_RegistrationForm.Create(Nil, InPref);
         PrefForm_Registration.OnEvent := Handle_Pref_Event;
      end;
      PREF_SHIPPINGRATES:
      begin
      	PrefForm_ShippingRates := TPref_ShippingForm.Create(nil, InPref);
         PrefForm_ShippingRates.OnEvent := Handle_Pref_Event;
      end;
      PREF_GENERALSETTINGS:
      begin
         PrefForm_General := tPref_GeneralSettingsForm.Create(nil, InPref);
         PrefForm_General.OnEvent := Handle_Pref_Event;
      end;
      PREF_REPSETTINGS:
      begin
         PrefForm_Rep := tPref_RepresentativeForm.Create(nil, InPRef);
         PrefForm_Rep.OnEvent := Handle_Pref_Event;
      end;
      PREF_EMAILSETTINGS:
      begin
         PrefForm_Email := TPref_EmailSettingsForm.Create(nil, InPRef);
         PrefForm_Email.OnEvent := Handle_Pref_Event;
      end;

   end;

   { Dock it }
   case InPref of
      PREF_ORDERFEES: Dock_Form(PrefForm_Fees);
	   PREF_TAXRATES: DocK_Form(PrefForm_Taxes);
   	PREF_ORGANIZATIONS: Dock_Form(PrefForm_Organizations);
   	PREF_REGISTRATION: Dock_Form(PrefForm_Registration);
      PREF_SHIPPINGRATES: Dock_Form(PrefForm_ShippingRates);
      PREF_GENERALSETTINGS : Dock_Form(PrefForm_General);
      PREF_REPSETTINGS : Dock_Form(PrefForm_Rep);
      PREF_EMAILSETTINGS: Dock_Form(PrefForm_Email);
      PREF_EXPENSETYPES: Dock_Form(PrefForm_ExpenseTypes);
      PREF_EARNINGTYPES: Dock_Form(PrefForm_EarningTypes);
      PREF_INVOICESETTINGS: Dock_Form(PrefForm_InvoiceSettings);
      PREF_PRODUCTSETTINGS: Dock_Form(PrefForm_ProductSettings);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPreferencesForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  if Assigned(EventPrefChange) then
    EventPrefChange(Self);
end;

procedure tPreferencesForm.ExecuteStartupHelp;
begin
   fHelpStartup := true;
end;

procedure tPreferencesForm.HandlePreferenceRefreshEvent;
begin
   if ( PrefForm_Registration <> NIL ) then
      PrefForm_Registration.GlobalRefreshEvent();
   if ( PrefForm_ShippingRates <> NIL ) then
      PrefForm_ShippingRates.GlobalRefreshEvent();
   if ( PrefForm_Organizations <> NIL ) then
      PrefForm_Organizations.GlobalRefreshEvent();
   if ( PrefForm_Taxes <> NIL ) then
      PrefForm_Taxes.GlobalRefreshEvent();
   if ( PrefForm_Fees <> NIL ) then
      PrefForm_Fees.GlobalRefreshEvent();
   if ( PrefForm_General <> NIL ) then
      PrefForm_General.GlobalRefreshEvent();
   if ( PrefForm_Rep <> NIL ) then
      PrefForm_Rep.GlobalRefreshEvent();
   if ( PrefForm_Email <> NIL ) then
      PrefForm_Email.GlobalRefreshEvent();
   if ( PrefForm_ExpenseTypes <> NIL ) then
      PrefForm_ExpenseTypes.GlobalRefreshEvent();
   if ( PrefForm_EarningTypes <> NIL ) then
      PrefForm_EarningTypes.GlobalRefreshEvent();
   if ( PrefForm_InvoiceSettings <> NIL ) then
      PrefForm_InvoiceSettings.GlobalRefreshEvent();
   if ( PrefForm_ProductSettings <> NIL ) then
      PrefForm_ProductSettings.GlobalRefreshEvent();
end;

procedure TPreferencesForm.Handle_Pref_Event(Sender: Tobject);
begin
  if Assigned(EventPrefChange) then
    EventPrefChange(Self);
end;

procedure TPreferencesForm.HelpButtonClick(Sender: TObject);
begin
{
  if Assigned(fHelpAction) then
    fHelpAction(Self, HELP_PREFERENCES);
    }
end;

procedure tPreferencesForm.PrefBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
var
	eleDetail : tThemedElementDetails;
begin
   exit;
	if (ThemeServices.ThemesEnabled) then
   begin
   	eleDetail := ThemeServices.GetElementDetails(trRebarRoot);
      ThemeServices.DrawElement(Sender.Canvas.Handle, eleDetail, Sender.ClientRect);
      ThemeServices.DrawElement(Self.Canvas.Handle, eleDetail, Sender.ClientRect);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
end.

