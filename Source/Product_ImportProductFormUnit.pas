 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Product_ImportProductFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   ToolBox_PreferenceToolBoxUnit,
   recordstructureunit,
   Product_ImportProductObject,
   avobase_toolbarunit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   masterdata_BaseDataClassUnit,
   encryptunit,
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
   Mask, Buttons;

type
   tProduct_ImportProductForm = class(TAvoBase_BaseForm_Menu)
    GroupBox1: TGroupBox;
    db_confirmdelete: TCheckBox;
    db_addr1: TLabeledEdit;
    orgLabel: TLabel;
    orgCombo: TComboBox;
    Label1: TLabel;
    CycleYearComboBox: TComboBox;
    campYearLabel: TLabel;
    CycleNumComboBox: TComboBox;
    CycleNumLabel: TLabel;
    OpenFileButton: TBitBtn;
    Label2: TLabel;
    LineItemToolBar_DOCK: TPanel;
    db_scrollbox: TScrollBox;
    product_header_panel: TPanel;
    Label3: TLabel;
    RetailCostLabel: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    procedure orgComboChange(Sender: TObject);
    procedure CycleYearComboBoxChange(Sender: TObject);
   private
      LineItemToolBar : tAvoBaseToolBar;
      ProdImportObj : tImportProductObject;
      //
      function fGetCycleID : string;
      function fGetOrgID : string;
      //
      procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      //
      procedure CloseForm();
      procedure StartUpForm();
      procedure NewLine();
      procedure DeleteLine();
   public
      property CycleID : string read fGetCycleID;
      property OrgID : string read fGetOrgID;
      //
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean ); overload;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tProduct_ImportProductForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean );
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
	StartUpForm();
end;


procedure tProduct_ImportProductForm.StartUpForm;
var
	bDay : tDateTime;
begin
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CLOSE );
   CreateButtonSep();
   CreateButton( CMD_CLEAR );
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_SAVE );
   //
   LineItemToolBar := tAvoBaseToolBar.Create( LineItemToolBar_DOCK );
   LineItemToolBar.actionList.OnUpdate := HandleActionListUpdate;
   LineItemToolBar.actionList.onActionEvent := HandleActionExecute;
   LineItemToolBar.Align := alLeft;
   LineItemToolBar.Wrapable := True;
   LineItemToolBar.AutoSize := True;
   LineItemToolBar.CreateButton( CMD_NEW );
   LineItemToolBar.CreateButton( CMD_DELETE );
   //
   Org_ComboBox_FillActiveOrgs_WithCycles( orgCombo );
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
   //
   ProdImportObj := tImportProductObject.create( db_scrollbox );
end;

procedure tProduct_ImportProductForm.CloseForm;
begin
   FreeAndNil(LineItemToolBar);
   FreeAndNil(ProdImportObj);
   //
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProduct_ImportProductForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_SAVE :
      begin
      {
         if ( Save() ) then
         begin
            fCloseAction := actionSave;
            CloseForm();
         end;
         }
      end;
      CMD_CLOSE :
      begin
      	if ( ProdImportObj.Count <> 0 ) then
         begin
         	if AvoBaseDialog('Cancel ALL Changes', 'Are you sure you want exit the Product Import Tool?',
            	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
               	CloseForm();
         end else
         	CloseForm();
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel ALL Changes', 'Are you sure you want exit the Product Import Tool?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
            	ProdImportObj.Clear();
      end;
      CMD_HELP : AvoBaseHelp_Execute('ImportProductForm');
      CMD_NEW : NewLine();
      CMD_DELETE : DeleteLine();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProduct_ImportProductForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
      	CMD_CANCEL, CMD_DELETE : enabled := ( ProdImportObj.Count <> 0 );
         CMD_SAVE : enabled := true;
         CMD_NEW : enabled := true;
      end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tProduct_ImportProductForm.fGetCycleID: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( CycleYearComboBox.Text );
   cycleRec.Num := StrToInt( CycleNumComboBox.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( orgCombo.Text, cycleRec.Year, cycleRec.Num );
   //
   result := C_ID;
end;

function tProduct_ImportProductForm.fGetOrgID: string;
begin
   result := Org_GetOrgIDByOrgName( orgCombo.Text );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProduct_ImportProductForm.orgComboChange(Sender: TObject);
begin
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

procedure tProduct_ImportProductForm.CycleYearComboBoxChange( Sender: TObject);
begin
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProduct_ImportProductForm.DeleteLine;
begin
	if ( ProdImportObj <> nil ) then
   	ProdImportObj.DeleteLine();
end;

procedure tProduct_ImportProductForm.NewLine;
begin
	if ( ProdImportObj <> nil ) then
   	ProdImportObj.AddBlankLineItem();
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



end.
