 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_ProductSettingsForm;

interface uses
   preference_baseformunit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   toolbox_preferencetoolboxunit,
   toolbox_orgToolBoxUnit,
   inifileunit,
   //
   windows,
   messages,
   sysutils,
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

type
   tPref_ProductSettingsForm = class(TPrefBaseForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    InvoiceLineSettings: TLabel;
    Label5: TLabel;
    db_PRODN1: TMaskEdit;
    db_PRODN2: TMaskEdit;
    db_PRODN3: TMaskEdit;
    db_PRODN4: TMaskEdit;
    Label6: TLabel;
    orgCombo: TComboBox;
      procedure FormCreate(Sender: TObject);
    procedure orgComboChange(Sender: TObject);
    procedure orgComboEnter(Sender: TObject);
   private
      function fGetOrgID : string;
   public
      procedure GlobalRefreshEvent();
      //
      property OrgID : string read fGetOrgID;
   end;

implementation

{$R *.dfm}

(* ***************************************************************************** *)

function tPref_ProductSettingsForm.fGetOrgID: string;
begin
   result := Org_GetOrgIDByOrgName( orgCombo.Text );
end;

procedure TPref_ProductSettingsForm.FormCreate(Sender: TObject);
begin
   inherited;
   //
   Org_ComboBox_FillActiveOrgs( orgCombo );
   if ( orgID <> '' ) then
   begin
      db_PRODN1.Text := Org_GetOrgProductSpecialField( orgID, 'PRODN1' );
      db_PRODN2.Text := Org_GetOrgProductSpecialField( orgID, 'PRODN2' );
      db_PRODN3.Text := Org_GetOrgProductSpecialField( orgID, 'PRODN3' );
      db_PRODN4.Text := Org_GetOrgProductSpecialField( orgID, 'PRODN4' );
   end;
end;

procedure tPref_ProductSettingsForm.GlobalRefreshEvent;
begin
   //
end;


procedure tPref_ProductSettingsForm.orgComboChange(Sender: TObject);
begin
   if ( orgID <> '' ) then
   begin
      db_PRODN1.Text := Org_GetOrgProductSpecialField( orgID, 'PRODN1' );
      db_PRODN2.Text := Org_GetOrgProductSpecialField( orgID, 'PRODN2' );
      db_PRODN3.Text := Org_GetOrgProductSpecialField( orgID, 'PRODN3' );
      db_PRODN4.Text := Org_GetOrgProductSpecialField( orgID, 'PRODN4' );
   end;
end;

procedure tPref_ProductSettingsForm.orgComboEnter(Sender: TObject);
begin
   if ( orgID <> '' ) then
   begin
      Org_PutOrgProductSpecialField( OrgID, 'PRODN1', db_prodn1.text );
      Org_PutOrgProductSpecialField( OrgID, 'PRODN2', db_prodn2.text );
      Org_PutOrgProductSpecialField( OrgID, 'PRODN3', db_prodn3.text );
      Org_PutOrgProductSpecialField( OrgID, 'PRODN4', db_prodn4.text );
   end;
end;

end.
