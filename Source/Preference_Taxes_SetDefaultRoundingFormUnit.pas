 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Preference_Taxes_SetDefaultRoundingFormUnit;

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
   errorresultunit,
   AvoBase_TextEditorFormUnit,
   toolbox_orgtoolboxunit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
   dbtables,
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
   Buttons,
   Tabs,
   TabNotBk;

type
	tPref_Taxes_SetDefaultRoundingForm = class(TAvoBase_BaseForm_Menu)
    InvoiceLineSettings: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    db_rounding: TComboBox;
    Label5: TLabel;
   private
   	fCloseAction : tFormActions;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure SaveData();
      procedure StartForm();
   public
      //
      constructor Create( owner: TComponent); overload;
  end;

implementation


{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tPref_Taxes_SetDefaultRoundingForm.Create(owner: TComponent);
begin
	inherited create( owner, 'Tax Rounding Options', true, false );
   //
	StartForm();
end;

procedure tPref_Taxes_SetDefaultRoundingForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPref_Taxes_SetDefaultRoundingForm.StartForm;
var
	TaxPref : integer;
begin
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   CreateButton( CMD_SAVE );
   //

	TaxPref := Pref_GetInteger(tPrefConstants.TaxRounding, 0);
   if ( TaxPref = 0 ) then
   	TaxPref := 1;
   db_rounding.ItemIndex := (TaxPref - 1);
end;

procedure tPref_Taxes_SetDefaultRoundingForm.SaveData;
begin
   Pref_Set(tPrefConstants.TaxRounding, db_rounding.ItemIndex + 1);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tPref_Taxes_SetDefaultRoundingForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SAVE :
      begin
      	SaveData();
         fCloseAction := actionSave;
         CloseForm();
      end;
   end;
end;

procedure tPref_Taxes_SetDefaultRoundingForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case tag of
      	CMD_SAVE : enabled := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
