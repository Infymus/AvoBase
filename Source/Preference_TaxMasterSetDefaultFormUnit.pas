 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_TaxMasterSetDefaultFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   toolbox_PreferenceToolBoxUnit,
   masterdata_BaseDataClassUnit,
   toolbox_taxtoolboxunit,
   errorresultunit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
   dbtables,
   db,
   sysutils,
   variants,
   classes,
   ActnList,
   graphics,
   controls,
   forms,
   dialogs,
   stdctrls,
   extctrls,
   ComCtrls,
   ToolWin,
   Mask,
   Buttons;

type
   tPref_TaxesMasterSetDefaultForm = class(TAvoBase_BaseForm_Menu)
      default_label: TLabel;
    GroupBox1: TGroupBox;
    db_none: TCheckBox;
    db_ship: TCheckBox;
    db_prod: TCheckBox;
    db_fee: TCheckBox;
    db_ord: TCheckBox;
    procedure db_noneClick(Sender: TObject);
    procedure db_shipClick(Sender: TObject);
    procedure db_prodClick(Sender: TObject);
    procedure db_feeClick(Sender: TObject);
    procedure db_ordClick(Sender: TObject);
   private
      fDefaultFee: boolean;
      fDefaultShip : boolean;
      fDefaultProd : boolean;
      fDefaultOrd : boolean;
      fNone : boolean;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure StartUpForm();
   public
      property DefaultNone : boolean read fNone;
   	property DefaultFee : boolean read fDefaultFee;
   	property DefaultShip : boolean read fDefaultShip;
   	property DefaultProd : boolean read fDefaultProd;
      property DefaultOrd : boolean read fDefaultOrd;
      //
      constructor Create( owner: TComponent );
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tPref_TaxesMasterSetDefaultForm.Create( owner: TComponent );
begin
	inherited create( owner, 'Set Default Tax Group', true, false );
   //
	StartUpForm();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPref_TaxesMasterSetDefaultForm.StartUpForm;
var
	cCount : integer;
begin
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SELECT_OK );
   //
   default_label.caption := 'Setting the default Tax Group to Shipping, Orders, Product and ' +
   	'Fees is used when creating new items - by default they will use this Tax Group.';
end;

procedure tPref_TaxesMasterSetDefaultForm.db_feeClick(Sender: TObject);
begin
   if ( db_fee.checked ) then
      db_none.checked := false;
end;

procedure tPref_TaxesMasterSetDefaultForm.db_noneClick(Sender: TObject);
begin
   if ( db_none.Checked ) then
   begin
      db_ship.checked := false;
      db_prod.checked := false;
      db_fee.checked := false;
      db_ord.checked := false;
   end;
end;

procedure tPref_TaxesMasterSetDefaultForm.db_ordClick(Sender: TObject);
begin
   if ( db_ord.checked ) then
      db_none.checked := false;
end;

procedure tPref_TaxesMasterSetDefaultForm.db_prodClick(Sender: TObject);
begin
   if ( db_prod.checked ) then
      db_none.checked := false;
end;

procedure tPref_TaxesMasterSetDefaultForm.db_shipClick(Sender: TObject);
begin
   if ( db_ship.checked ) then
      db_none.checked := false;
end;

procedure tPref_TaxesMasterSetDefaultForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SELECT_OK :
      begin
         fFormEvent := mrOK;
         //
         fNone := ( db_none.checked );
         //
         if ( db_ship.checked ) then
            fDefaultShip := true;
         if ( db_fee.checked ) then
            fDefaultFee := true;
         if ( db_prod.checked ) then
            fDefaultProd := true;
         if ( db_ord.Checked ) then
            fdefaultord := true;
         //
         Close();
{
   tTaxDefaultTypes = (
      taxDefaultNone = 0,
      taxDefaultProduct = 1,
      taxDefaultFee = 2,
      taxDefaultShipping = 3
      );

}
      end;
      CMD_CANCEL :
      begin
         fFormEvent := mrCancel;
         Close();
      end;
      CMD_HELP : AvoBaseHelp_Execute('Pref_TaxesMasterSetDefaultForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPref_TaxesMasterSetDefaultForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
