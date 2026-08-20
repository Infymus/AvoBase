 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_ExportSelectTypeFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_percentformunit,
   avobase_baseform_menuunit,
   AvoBase_ToolBarUnit,
   toolbox_PreferenceToolBoxUnit,
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
	tCustomer_ExportSelectTypeForm = class(TAvoBase_BaseForm_Menu)
    exportGroup: TRadioGroup;
   private
      fFormExportType : tAvoBaseExportTypes;
   	fFormCloseType : TModalResult;
   	//
      procedure StartUpForm();
      procedure CloseForm();
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      property FormCloseType : TModalResult read fFormCloseType;
      property ExportType : tAvoBaseExportTypes read fFormExportType;
      //
   	constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tCustomer_ExportSelectTypeForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble , True );
   //
	StartUpForm();
end;

procedure tCustomer_ExportSelectTypeForm.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CANCEL);
   CreateButtonSep();
   CreateButton( CMD_OK );
   //
   exportGroup.Items.Clear;
   exportGroup.Items.Add('Text - Comma Delimited Text');                            //
   exportGroup.Items.Add('Text - Comma Delimited Text - With Double Quotes');
   exportGroup.Items.Add('Text - Comma Delimited Text - With Single Quotes');
   //
   exportGroup.ItemIndex := 0;
end;

procedure tCustomer_ExportSelectTypeForm.CloseForm;
begin
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_ExportSelectTypeForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_OK:
      	begin
         	fFormCloseType := mrOK;
            case exportGroup.ItemIndex of
            	0 : fFormExportType := tAvoBaseExportTypes.Text_CommaDelimited;
            	1 : fFormExportType := tAvoBaseExportTypes.Text_CommaDelimitedQuotes;
            	2 : fFormExportType := tAvoBaseExportTypes.Text_CommaDelimitedSingleQuotes;
            end;
            Close();
         end;
      CMD_CANCEL:
      	begin
            fFormCloseType := mrCancel;
            Close();
         end;
   end;
end;

procedure tCustomer_ExportSelectTypeForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
      	CMD_CANCEL,CMD_OK : enabled := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
