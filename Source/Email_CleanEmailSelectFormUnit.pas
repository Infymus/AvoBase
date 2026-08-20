 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Email_CleanEmailSelectFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   masterdata_BaseDataClassUnit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
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
   ToolWin;

type
   tEmailCleanEmailSelectForm = class(TAvoBase_BaseForm_Menu)
    deletegroupbox: TGroupBox;
    db_Deleted: TCheckBox;
    deletelabel: TLabel;
    db_pending: TCheckBox;
    db_sent: TCheckBox;
    db_failed: TCheckBox;
    db_error: TCheckBox;
    pendingstatlabel: TLabel;
   private
   	fCloseAction : tFormActions;
      fCycleQuery : tMasterData_BaseDataClass;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      function fGetCleanDeleted : boolean;
      function fGetCleanPending : boolean;
      function fGetCleanSent : boolean;
      function fGetCleanFailed : boolean;
      function fGetCleanError : boolean;
   public
      procedure StartUpForm();
   	property CloseAction : tFormActions read fCloseAction;
      property CleanDeleted : boolean read fGetCleanDeleted;
      property CleanPending : boolean read fGetCleanPending;
      property CleanSent : boolean read fGetCleanSent;
      property CleanFailed : boolean read fGetCleanFailed;
      property CleanError : boolean read fGetCleanError;
      //
      constructor Create( owner: TComponent); override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tEmailCleanEmailSelectForm.Create( owner: TComponent );
begin
	inherited create( owner, 'Email Cleanup Utility', true, false);
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SELECT_OK);
end;

function tEmailCleanEmailSelectForm.fGetCleanDeleted: boolean;
begin
   result := db_Deleted.Checked;
end;

function tEmailCleanEmailSelectForm.fGetCleanError: boolean;
begin
   result := db_error.Checked;

end;

function tEmailCleanEmailSelectForm.fGetCleanFailed: boolean;
begin
   result := db_failed.Checked;

end;

function tEmailCleanEmailSelectForm.fGetCleanPending: boolean;
begin
   result := db_pending.Checked;

end;

function tEmailCleanEmailSelectForm.fGetCleanSent: boolean;
begin
   result := db_sent.Checked;

end;

procedure tEmailCleanEmailSelectForm.CloseForm;
begin
	Close();
end;

// ################################################################################### //

procedure tEmailCleanEmailSelectForm.StartUpForm;
var
   bDate : tDateTime;
   orgName : string;
   cnt : integer;
begin
   // Nothing Yet.
end;

// ################################################################################### //

procedure tEmailCleanEmailSelectForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SELECT_OK :
      begin
         fCloseAction := actionOK;
         CloseForm();
      end;
      CMD_CANCEL :
      begin
         fCloseAction := actionCancel;
         CloseForm();
      end;
      CMD_HELP : AvoBaseHelp_Execute('EmailCleanEmailSelectForm');
   end;
end;

// ################################################################################### //

procedure tEmailCleanEmailSelectForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

// ################################################################################### //


end.