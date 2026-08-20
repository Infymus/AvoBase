 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_RepresentativeFormUnit;

interface uses
   preference_baseformunit,
   constantsunit,
   toolboxunit,
   masterdataunit,
   toolbox_preferencetoolboxunit,
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
  TPref_RepresentativeForm = class(TPrefBaseForm)
    RepSettingsGroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    db_rcomp: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    db_raddr1: TEdit;
    db_raddr2: TEdit;
    db_rcity: TEdit;
    db_rstate: TEdit;
    db_rzip: TEdit;
    db_rcell: TEdit;
    db_rphone: TEdit;
    Label9: TLabel;
    db_rfax: TEdit;
    Label10: TLabel;
    db_repname: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      procedure GlobalRefreshEvent();
  end;

implementation

{$R *.dfm}

(* ***************************************************************************** *)

{
            'RPHONE VARCHAR(20), ' +
            'RFAX VARCHAR(20), ' +
            'RCELL VARCHAR(20), ' +
            'RADDR1 VARCHAR(40), ' +
            'RADDR2 VARCHAR(40), ' +
            'RCITY VARCHAR(40), ' +
            'RZIP VARCHAR(20), ' +
            'RSTATE VARCHAR(40), ' +
            'REMAIL VARCHAR(60), ' +
            'RCOMP VARCHAR(120), ' +
}

procedure TPref_RepresentativeForm.FormCreate(Sender: TObject);
begin
   inherited;
   //
   db_rphone.Text := Pref_GetString(tPrefConstants.RepPhone, '');
   db_rfax.Text := Pref_GetString(tPrefConstants.RepFax, '');
   db_rcell.Text := Pref_GetString(tPrefConstants.RepCell, '');
   db_raddr1.Text := Pref_GetString(tPrefConstants.RepAddress1, '');
   db_raddr2.Text := Pref_GetString(tPrefConstants.RepAddress2, '');
   db_rcity.Text := Pref_GetString(tPrefConstants.RepCity, '');
   db_rzip.Text := Pref_GetString(tPrefConstants.RepZip, '');
   db_rstate.Text := Pref_GetString(tPrefConstants.RepState, '');
   db_rcomp.Text := Pref_GetString(tPrefConstants.RCOMP, '');
   db_repname.Text := Pref_GetString(tPrefConstants.RepName, '');
end;

procedure TPref_RepresentativeForm.GlobalRefreshEvent;
begin
   //
end;

end.
