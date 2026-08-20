 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_InvoiceSettingsForm;

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
   tPref_InvoiceSettingsForm = class(TPrefBaseForm)
      GroupBox1: TGroupBox;
      Label2: TLabel;
      Label3: TLabel;
      Label8: TLabel;
      Label6: TLabel;
      Label7: TLabel;
      Label1: TLabel;
      Label4: TLabel;
      db_inv1: TComboBox;
      db_inv2: TComboBox;
      db_inv3: TComboBox;
      db_inv4: TComboBox;
      db_inv5: TComboBox;
      db_inv6: TComboBox;
      GroupBox3: TGroupBox;
      Label5: TLabel;
      db_ORGONINVLAB: TCheckBox;
    db_invtop: TMaskEdit;
    db_sonum: TEdit;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    db_CPRODTYPE: TComboBox;
    Label10: TLabel;
    db_INVCPH: TRadioGroup;
    InvoiceLineSettings: TLabel;
    db_INVSHOW_DISC: TCheckBox;
    Label11: TLabel;
    db_lineitemtype: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure db_sonumKeyPress(Sender: TObject; var Key: Char);
   private
   public
      procedure GlobalRefreshEvent();
      procedure FillCombos( VAR InCombo : tComboBox );
   end;

implementation

{$R *.dfm}

(* ***************************************************************************** *)

procedure tPref_InvoiceSettingsForm.db_sonumKeyPress(Sender: TObject; var Key: Char);
var
   p : integer;
begin
   case Key of
      '0'..'9', #8  : ;
      else key := #0;
   end;
end;


procedure tPref_InvoiceSettingsForm.FillCombos(var InCombo: tComboBox);
begin
   inCombo.Clear;
   inCombo.Items.Add('BLANK');
   inCombo.Items.Add('SALES REPRESENTATIVE NAME');
   inCombo.Items.Add('ADDRESS LINE 1');
   inCombo.Items.Add('ADDRESS LINE 2');
   inCombo.Items.Add('EMAIL ADDRESS');
   inCombo.Items.Add('CITY, STATE/PROVICE, ZIP/POSTAL CODE');
   inCombo.Items.Add('PHONE');
   inCombo.Items.Add('CELL PHONE');
end;

procedure tPref_InvoiceSettingsForm.FormCreate(Sender: TObject);
begin
   inherited;
   //
   FillCombos( db_inv1 );
   FillCombos( db_inv2 );
   FillCombos( db_inv3 );
   FillCombos( db_inv4 );
   FillCombos( db_inv5 );
   FillCombos( db_inv6 );
   //
   db_invtop.Text := Pref_GetString(tPrefConstants.INVHEAD, '');
   db_inv1.ItemIndex := Pref_GetInteger(tPrefConstants.INV1, 0);
   db_inv2.ItemIndex := Pref_GetInteger(tPrefConstants.INV2, 0);
   db_inv3.ItemIndex := Pref_GetInteger(tPrefConstants.INV3, 0);
   db_inv4.ItemIndex := Pref_GetInteger(tPrefConstants.INV4, 0);
   db_inv5.ItemIndex := Pref_GetInteger(tPrefConstants.INV5, 0);
   db_inv6.ItemIndex := Pref_GetInteger(tPrefConstants.INV6, 0);
   db_ORGONINVLAB.Checked := Pref_GetBoolean(tPrefConstants.ORGONINVLAB, True);
   db_INVSHOW_DISC.Checked := Pref_GetBoolean(tPrefConstants.InvoiceShowDiscount, True);
   db_sonum.Text := IntToStr(pref_GetInteger(tPrefConstants.SONUM, 0));
   db_INVCPH.ItemIndex := Pref_GetInteger(tPrefConstants.INVCPH, 0);
   //
{
   tCprodTypes = (
      cprodNone = 0,
      cprodCurrent = 1,
      cprodAll = 2
      );
}
   db_CPRODTYPE.Items.clear;
   db_CPRODTYPE.Items.add('NONE - Do not match Products');
   db_CPRODTYPE.Items.add('CURRENT - Match Sales Cycle Only');
   db_CPRODTYPE.Items.add('ALL - Match any Sales Cycle');
   db_CPRODTYPE.ItemIndex := Pref_GetInteger(tPrefConstants.CPRODTYPE, 0);
   if ( db_CPRODTYPE.ItemIndex = -1 ) then
      db_CPRODTYPE.ItemIndex := 0;
   //
   db_lineitemtype.Clear;
   db_lineitemtype.Items.Add('FULL - Default Line Item Display');
   db_lineitemtype.Items.Add('QUICK - Quick Line Item (Minimal)');
   db_lineitemtype.ItemIndex := Pref_GetInteger(tPrefConstants.InvoiceLineItemStyle, integer(tInvoiceLineItemStyles.liGeneric));
   if ( db_lineitemtype.ItemIndex = -1 ) then
      db_lineitemtype.ItemIndex := 0;
end;

procedure tPref_InvoiceSettingsForm.GlobalRefreshEvent;
begin
   //
end;

end.


