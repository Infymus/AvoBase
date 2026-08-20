 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
 unit CustOrd_MainFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_percentformunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   MasterData_TransactionListUnit,
   AvoBase_ToolBarUnit,
   toolbox_ordertoolboxunit,
   toolbox_PreferenceToolBoxUnit,
   ToolBox_EscrowToolBoxUnit,
   avobase_dialogformunit,
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
   ToolWin,
   Mask,
   DB,
   jpeg;

type
   tCustOrd_MainForm = class(TAvoBase_BaseForm_Menu)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
   private
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      procedure StartUpForm();
      procedure StatBarUpdate();
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean); overload;
   end;

implementation

{$R *.dfm}

// ######################################################################################### //

constructor TCustOrd_MainForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
	StartUpForm();
   StatBarUpdate();
   PercentForm_Free();
end;

procedure TCustOrd_MainForm.StartUpForm;
var
   fEscrow : currency;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
   CreateButtonSep();
   CreateButton( CMD_PRINT_LIST );
   CreateButtonSep();
   CreateButton( CMD_ORDER_VIEWINVOICE );
   CreateButtonSep();
   CreateButton( CMD_VOID_PAYMENT );
   CreateButton( CMD_ORDER_PAYMENT );
   CreateButtonSep();
   CreateButton( CMD_ORDER_RETURN );
   CreateButton( CMD_ORDER_LOAD );
end;

// ######################################################################################### //

procedure TCustOrd_MainForm.StatBarUpdate;
begin
   //
end;

procedure TCustOrd_MainForm.HandleActionExecute(sender: tObject;
  actionID: integer);
begin
   case actionID of
      CMD_CLOSE : Close;
   end;
end;

procedure TCustOrd_MainForm.HandleActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin

	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_CLOSE : enabled := true;
      end;
end;

// ######################################################################################### //

end.
