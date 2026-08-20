 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Expense_ItemEditFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   actionunit,
   masterdata_basegridunit,
   recordstructureunit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   toolbox_paymenttoolboxunit,
   toolbox_PreferenceToolBoxUnit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   toolbox_orgtoolboxunit,
   toolbox_ExpenseToolBoxUnit,
   toolbox_cycletoolboxunit,
   AvoBase_ToolBarUnit,
   //
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   ExtCtrls,
   ComCtrls,
   ToolWin,
   ActnList,
   jpeg,
   Mask;

type
   tExpense_EditForm = class(TForm)
    back_panel: TPanel;
    EXP_BACK_PANEL: TPanel;
    Label2: TLabel;
    expenseTypeLabel: TLabel;
    Label1: TLabel;
    mopvalueLabel: TLabel;
    FeeCostLabel: TLabel;
    expTypeCombo: TComboBox;
    paymentTypeCombo: TComboBox;
    db_mopvalue: TEdit;
    db_amount: TMaskEdit;
    db_mopdate: TDateTimePicker;
    db_taxded: TCheckBox;
    MENU_PANEL: TPanel;
    TOP_PANEL: TPanel;
    ORG_LABEL: TLabel;
    CYCLE_LABEL: TLabel;
    db_edesc: TEdit;
    Label3: TLabel;
    procedure paymentTypeComboChange(Sender: TObject);
    procedure expTypeComboChange(Sender: TObject);
    procedure db_amountClick(Sender: TObject);
   private
      fID : string;
      fOrgID : string;
      fEID : string;
      fCID : string;
      fETID : string;
      fMOPDate : tDateTime;
      fMOPType : integer;
      fModalResult : TModalResult;
      fMOPValue : string;
      fAmount : currency;
      expItemQuery : tMasterData_BaseDataClass;
      fEnabled : boolean;
      ToolBar : tAvoBaseToolBar;
      //
      function fGetExpTypeID : string;
      function fGetMopDate : tDateTime;
      function fGetMopType : integer;
      function fGetMopValue : string;
      function fGetAmount : currency;
      function fGetEnabled : boolean;
      function fGetTaxed : boolean;
      function fGetEdesc : string;
      //
      procedure fSetExpTypeID( inVal : string );
      procedure fSetMopDate( inVal : tDateTime );
      procedure fSetMopType( inVal : integer );
      procedure fSetMopValue( inVal : string );
      procedure fSetAmount( inVal : currency );
      procedure fSetEnabled( inVal : boolean );
      procedure fSetOrgID( inVal : string );
      procedure fSetCycleID( inVal : string );
      procedure fSetEdesc( inVal : string );
      //
      procedure UpdateFields;
      procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      procedure Clear;
      procedure Load( inID : string );
      function CanSave : boolean;
      //
      property ID : string read fID write fID;
      property OrgID : string read fOrgID write fSetOrgID;
      property CycleID : string read fCID write fSetCycleID;
      property C_ID : string read fCID write fCID;
      property ExpTypeID : string read fGetExpTypeID write fSetExpTypeID;
      property MopDate : tDateTime read fGetMopDate write fSetMopDate;
      property MopType : integer read fGetMopType write fSetMopType;
      property MopValue : string read fGetMopValue write fSetMopValue;
      property Amount : currency read fGetAmount write fSetAmount;
      property Enabled : boolean read fGetEnabled write fSetEnabled;
      property CloseAction : TModalResult read fModalResult;
      property Taxed : boolean read fGetTaxed;
      property Edesc : string read fGetEdesc write fSetEdesc;
      //
      constructor Create( Owner : TComponent; inDockPanel : tPanel ); virtual;
      destructor Destroy; override;
  end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Show, Destroy'}

constructor TExpense_EditForm.Create(Owner: TComponent; inDockPanel: tPanel);
begin
	inherited Create( owner );
   //
   if ( inDockPanel <> NIL ) then
   with Self do
   begin
      ManualDock(inDockPanel, nil, alClient);
      BorderStyle := bsNone;
      Left := (Self.Width - inDockPanel.Width) div 2;
      Top := (Self.Height - inDockPanel.Height) div 2;
      WindowState := wsMaximized;
      Anchors := [AkLeft,AkTop,AkRight,AkBottom];
      BorderIcons := [];
      Position := poDefault;
      Align := alClient;
      MENU_PANEL.Visible := false;
      MENU_PANEL.Visible := false;
      TOP_PANEL.Visible := False;
      Show();
   end else
      begin
         // this is being called NOT from the regular area, so lets create a menu
         ToolBar := tAvoBaseToolBar.Create( MENU_PANEL );
         ToolBar.actionList.OnUpdate := HandleActionListUpdate;
         ToolBar.actionList.onActionEvent := HandleActionExecute;
         ToolBar.Align := alClient;
         ToolBar.CreateButton( CMD_CANCEL );
         ToolBar.CreateButton( CMD_SAVE );
      end;
   //
   expItemQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Expense );
   //
   Payment_FillPaymentTypes( paymentTypeCombo );
   //
   Self.Clear();
end;

destructor TExpense_EditForm.Destroy;
begin
   FreeAndNil(expItemQuery);
   FreeAndNil(ToolBar);
   //
   Inherited Destroy;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties'}

function tExpense_EditForm.fGetAmount: currency;
begin
   fAmount := Return_MaskEdit_Curr(db_amount.Text);
   result := fAmount;
end;

procedure tExpense_EditForm.fSetAmount(inVal: currency);
begin
   fAmount := inVal;
   db_amount.Text := FormatFloat('####0.00', fAmount);
end;

function tExpense_EditForm.fGetExpTypeID: string;
begin
   fETID := Expense_GetExpenseTypeIDByExpenseTypeName( expTypeCombo.Text );
   result := fETID;
end;

procedure tExpense_EditForm.fSetExpTypeID(inVal: string);
var
   expTName : string;
   cnt : integer;
begin
   fETID := inVal;
   expTName := Expense_GetExpenseTypeNameByID( fETID );
   for cnt := 0 to expTypeCombo.Items.Count -1 do
      if ( expTypeCombo.Items.Strings[cnt] = expTName ) then
         expTypeCombo.ItemIndex := cnt;
end;

function tExpense_EditForm.fGetMopDate: tDateTime;
begin
   fMopDate := db_mopdate.Date;
   result := fMopDate;
end;

procedure tExpense_EditForm.fSetMopDate(inVal: tDateTime);
begin
   fMOPDate := inVal;
   db_mopdate.Date := fMopDate;
end;

function tExpense_EditForm.fGetMopType: integer;
begin
   fMopType := Payment_GetPaymentIntegerByName ( paymentTypeCombo.Text );
   result := fMopType;
end;

procedure tExpense_EditForm.fSetMopType(inVal: integer);
begin
   fMopType := inVal;
   paymenttypecombo.itemindex := inVal - 1;
   UpdateFields();
end;

function tExpense_EditForm.fGetMopValue: string;
begin
   fMopValue := db_mopvalue.text;
   result := fMopValue;
end;

function tExpense_EditForm.fGetTaxed: boolean;
begin
   result := db_taxded.Checked;
end;

procedure tExpense_EditForm.fSetMopValue(inVal: string);
begin
   fMopValue := inVal;
   db_mopvalue.text := fMopValue;
end;

function tExpense_EditForm.fGetEdesc: string;
begin
   result := db_edesc.Text;
end;

procedure tExpense_EditForm.fSetEdesc(inVal: string);
begin
   db_edesc.Text := inVal;
end;

function tExpense_EditForm.fGetEnabled: boolean;
begin
   result := fEnabled;
end;

procedure tExpense_EditForm.fSetEnabled(inVal: boolean);
begin
   fEnabled := inVal;
   //
   db_mopdate.enabled := inVal;
   expTypeCombo.enabled := inVal;
   paymentTypeCombo.enabled := inVal;
   db_mopvalue.enabled := inVal;
   db_amount.enabled := inVal;
   db_edesc.enabled := inVal;
   db_taxded.enabled := inVal;
   //
   if ( inVal ) then
      EXP_BACK_PANEL.Color := clWhite
   else
      EXP_BACK_PANEL.Color := $00EBEBEB;
end;

procedure tExpense_EditForm.fSetOrgID(inVal: string);
begin
   fOrgID := inVal;
   ORG_LABEL.Caption := 'Org: ' + Org_GetOrgNameByOrgID( fOrgID );
end;

procedure tExpense_EditForm.fSetCycleID(inVal: string);
begin
   fCID := inVal;
   CYCLE_LABEL.Caption := 'Sales Cycle: ' + Cycle_GetCycleNameByCycleID( fCID );
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Handle Action Execute'}

procedure tExpense_EditForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_SAVE :
      begin
         if ( CanSave ) then
         begin
            fModalResult := mrOk;
            Close();
         end;
      end;
      CMD_CANCEL :
      begin
         if AvoBaseDialog('Cancel Entry', 'Cancel this entry?', mtConfirmation, [mbyes, mbno], 0) = mbYes then
         begin
            Close();
            fModalResult := mrCancel;
         end;
      end;
   end;
end;

procedure tExpense_EditForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

procedure tExpense_EditForm.db_amountClick(Sender: TObject);
begin
   db_amount.SelectAll();
end;

procedure tExpense_EditForm.expTypeComboChange(Sender: TObject);
var
   expTypeRec : tExpenseTypeRecord;
begin
   expTypeRec := Expense_GetExpenseTypeRecordByID( ExpTypeID );
   db_taxded.checked := expTypeRec.taxded;
end;

procedure tExpense_EditForm.paymentTypeComboChange(Sender: TObject);
begin
   UpdateFields();
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Methods and Procedures'}

procedure tExpense_EditForm.Load(inID: string);
begin
   // if you want to load it
end;

function tExpense_EditForm.CanSave : boolean;
var
   errMsg : string;
begin
   errMsg := '';
   // Validate the data here
   if ( Amount = 0 ) then
   	errMsg := 'Expense Amount cannot be a 0 amount.';
   //
   if ( errMsg <> '' ) then
      AvoBaseDialog('Unable To Save', errMsg, mtError, [mbOk], 0);
   //
   result := ( errMsg = '' );
end;

procedure tExpense_EditForm.Clear;
begin
   // This will clear the form and reset it back to default values
   Expense_ComboBox_FillActiveExpenseTypes( expTypeCombo );
   //
   Self.MopDate := Now;
   Self.Amount := 0.00;
   Self.MopType := 1;
   Self.MopValue := '';
   Self.Edesc := '';
   // Last
   UpdateFields();
end;

procedure tExpense_EditForm.UpdateFields;
var
   ccDataEnabled : boolean;
   checkEnabled : boolean;
begin
   ccDataEnabled := true;
   checkEnabled := false;

   //
   case Payment_GetPaymentTypeByPaymentName( paymentTypeCombo.Text ) of
      integer(PayTypeCash):
      begin
         mopvalueLabel.Caption := 'NOT USED';
         ccDataEnabled := false;
         checkEnabled := false;
      end;
      integer(PayTypeCreditCard):
      begin
         mopvalueLabel.Caption := 'CREDIT CARD NUMBER';
         ccDataEnabled := true;
         checkEnabled := false;
      end;
      integer(PayTypeCheck):
      begin
         mopvalueLabel.Caption := 'CHECK NUMBER';
         ccDataEnabled := false;
         checkEnabled := true;
      end;
      integer(PayTypeCashierCheck):
      begin
         mopvalueLabel.Caption := 'CHECK NUMBER';
         ccDataEnabled := false;
         checkEnabled := true;
      end;
      integer(PayTypeMoneyOrder):
      begin
         mopvalueLabel.Caption := 'MONEY ORDER NUMBER';
         ccDataEnabled := false;
         checkEnabled := true;
      end;
      integer(PayTypeDebitCard):
      begin
         mopvalueLabel.Caption := 'DEBIT CARD NUMBER';
         ccDataEnabled := true;
         checkEnabled := false;
      end;
   end;

   // first, they are all off, then we turn the ones on we want
   db_mopvalue.visible := false;
   mopvalueLabel.visible := false;

   //
   if (ccDataEnabled) then
   begin
      db_mopvalue.visible := FALSE;
      mopvalueLabel.visible := FALSE;
   end;

   //
   if (checkEnabled) then
   begin
      db_mopvalue.visible := true;
      mopvalueLabel.visible := true;
   end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



end.
