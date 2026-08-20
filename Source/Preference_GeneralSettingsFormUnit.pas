 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_GeneralSettingsFormUnit;

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
   tPref_GeneralSettingsForm = class(TPrefBaseForm)
    GroupBox2: TGroupBox;
    db_editshowbuttons: TCheckBox;
    db_cup: TCheckBox;
    GroupBox1: TGroupBox;
    db_region: TComboBox;
    InvoiceLineSettings: TLabel;
    db_DBGRIDCOL: TCheckBox;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    db_olist1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    db_olist2: TComboBox;
    Label5: TLabel;
    db_olist3: TComboBox;
    Label6: TLabel;
    db_olist4: TComboBox;
    Label7: TLabel;
    db_olist5: TComboBox;
    Label8: TLabel;
    db_newordcurcycle: TCheckBox;
    procedure FormCreate(Sender: TObject);
    function fGetRegion: integer;
   private
   public
      procedure GlobalRefreshEvent();
      property Region : integer read fGetRegion;
   end;

implementation

{$R *.dfm}

(* ***************************************************************************** *)

function tPref_GeneralSettingsForm.fGetRegion: integer;
begin
   result := db_region.ItemIndex;
end;

procedure tPref_GeneralSettingsForm.FormCreate(Sender: TObject);

   procedure SetInvListCombo( VAR inCombo : TComboBox );
   begin
      inCombo.Clear;
      inCombo.Items.Add('BLANK');
      inCombo.Items.Add('LINE ITEM COUNT');
      inCombo.Items.Add('BACK ORDER COUNT');
      inCombo.Items.Add('TOTAL INVOICE AMT');
      inCombo.Items.Add('TOTAL MOP AMT');
      inCombo.Items.Add('TOTAL LEFT DUE');
   end;

begin
   inherited;
   //
   db_editshowbuttons.Checked := Pref_GetBoolean(tPrefConstants.EDITSL, True);
   db_cup.Checked := Pref_GetBoolean(tPrefConstants.CheckForUpdates, True);
   //
   db_region.Clear;
   db_region.items.add('UNITED STATES');
   db_region.items.add('UNITED KINGDOM');
   db_region.items.add('CANADA');
   db_region.itemindex := Pref_GetInteger(tPrefConstants.RegionCode, 0);
   db_DBGRIDCOL.checked := Pref_GetBoolean(tPrefConstants.dbGridColorGridLines, True);
   db_newordcurcycle.checked := Pref_GetBoolean(tPrefConstants.NEWORDCURCYCLE, True);


   //
   SetInvListCombo( db_olist1 );
   SetInvListCombo( db_olist2 );
   SetInvListCombo( db_olist3 );
   SetInvListCombo( db_olist4 );
   SetInvListCombo( db_olist5 );

   //
   db_olist1.itemindex := Pref_GetInteger(tPrefConstants.INVLIST1, 1);
   db_olist2.itemindex := Pref_GetInteger(tPrefConstants.INVLIST2, 2);
   db_olist3.itemindex := Pref_GetInteger(tPrefConstants.INVLIST3, 3);
   db_olist4.itemindex := Pref_GetInteger(tPrefConstants.INVLIST4, 4);
   db_olist5.itemindex := Pref_GetInteger(tPrefConstants.INVLIST5, 5);

{
   tRegions = (
      RegionUS = 0,
      RegionUK = 1,
      RegionCAN = 2
      );
}
   end;

procedure tPref_GeneralSettingsForm.GlobalRefreshEvent;
begin
   //
end;

end.
