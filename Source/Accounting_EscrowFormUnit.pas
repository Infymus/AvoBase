 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


unit Accounting_EscrowFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   actionunit,
   masterdata_basegridunit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   toolbox_ordertoolboxunit,
   avobase_percentformunit,
   avobase_toolbarunit,
   AvoBase_HelpFormUnit,
   MasterData_AccountingEscrowListUnit,
   Accounting_EscrowModifyFormUnit,
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
   jpeg;

type
   tAccountingEscrowForm = class(TAvobase_BaseForm_List)
      sortViewLabel: TLabel;
      SortViewComboBox: TComboBox;
      activityLabel: TLabel;
      ActiveComboBox: TComboBox;
      MENU_DOCK_PANEL: TPanel;
    procedure SortViewComboBoxChange(Sender: TObject);
    procedure ActiveComboBoxChange(Sender: TObject);
  private
      MenuToolBar : tAvoBaseToolBar;
      //
      custQuery : tMasterData_BaseDataClass;
      custListQuery : tMasterDataAccountingEscrowList;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      function fGetCustRecCount : integer;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      //
      procedure UpdateCustQuery();
      procedure Recalculate( inID : string );
      procedure GlobalRefreshEvent();
      procedure AccountingModifyEscrow();
      //
      property CustRecCount : integer read fGetCustRecCount;
      //
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TAccountingEscrowForm.create(owner : TComponent);
begin
	inherited create( Nil, 'Customers', false, True);
   //
   BASE_NAVBAR_DOCK_PANEL.Parent := MENU_DOCK_PANEL;
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   custListQuery := tMasterDataAccountingEscrowList.Create( masterData);
   //
   custQuery := tMasterData_BaseDataClass.create( masterData, masterData.Gettable_Customer );
   //
   // These items are INHERITED from the AvoBase_BasweForm_StandardUnit
   // DataListGrid, gridDataSource, dbNavTool <-- all inherited
   gridDataSource.DataSet := custListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( custListQuery, 'FNAME' );
   DataListGrid.Clear;
   DataListGrid.Add(custListQuery.FieldByName('FULLNAME'), 'CUSTOMER NAME', 150, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(custListQuery.FieldByName('ESCROW'), 'ESCROW', 60, CLRED, [FSBOLD], taRightJustify);
   DataListGrid.Add(custListQuery.FieldByName('TOTO'), 'OPEN', 60, clGreen, [], taRightJustify);
   DataListGrid.Add(custListQuery.FieldByName('TOTC'), 'CLOSED', 60, clGreen, [], taRightJustify);
   DataListGrid.Add(custListQuery.FieldByName('PHONEH'), 'PHONE', 110, clHighlight, [], taLeftJustify);
   DataListGrid.Add(custListQuery.FieldByName('PHONEC'), 'CELL', 110, clHighlight, [], taLeftJustify);
   DataListGrid.Add(custListQuery.FieldByName('FULLADDR'), 'ADDRESS', 250, clBlack, [], taLeftJustify);
   //DataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( custListQuery );
   //
   // Line Item Tool Bar
   MenuToolBar := tAvoBaseToolBar.Create( MENU_DOCK_PANEL );
   MenuToolBar.actionList.OnUpdate := HandleActionListUpdate;
   MenuToolBar.actionList.onActionEvent := HandleActionExecute;
   MenuToolBar.Align := alLeft;
   MenuToolBar.Wrapable := True;
   MenuToolBar.AutoSize := True;
	MenuToolBar.CreateButton( CMD_HELP );
   MenuToolBar.CreateButtonSep();
	MenuToolBar.CreateButton( CMD_CLOSE );
   MenuToolBar.CreateButtonSep();
   MenuToolBar.CreateButton( CMD_ACCOUNT_ESCROW );
   //
   UpdateCustQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

destructor TAccountingEscrowForm.Destroy;
begin
	custListQuery.Close();
   freeAndNil(custListQuery);
   FreeAndNil(custQuery);
   FreeAndNil(MenuToolBar);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TAccountingEscrowForm.fGetCustRecCount: integer;
begin
	result := custListQuery.RecordCount;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tAccountingEscrowForm.GlobalRefreshEvent;
begin
   Recalculate('');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAccountingEscrowForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_ACCOUNT_ESCROW: AccountingModifyEscrow();
      CMD_HELP: AvoBaseHelp_Execute('AccountingEscrowForm');
      CMD_CLOSE : Close();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAccountingEscrowForm.HandleActionListUpdate( Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;
   with Action as tAction do
   case tag of
      CMD_ACCOUNT_ESCROW: enabled := ( custListQuery.RecordCount <> 0 );
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAccountingEscrowForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(custListQuery.RecNo) + ' of ' + IntToStr(custListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAccountingEscrowForm.UpdateCustQuery;
var
	sortDir : string;
   onlyActive : tActiveStates;
begin
   PercentForm_Create('Generating Customer List - One Moment Please...', 0, 0);
	if (SortViewComboBox.ItemIndex = 1) then
   	sortDir := 'DESC'
   else
   	sortDir := '';
   //
   case ActiveComboBox.ItemIndex of
   	0 : onlyActive := tActiveStates.stateActive;
   	1 : onlyActive := tActiveStates.stateInactive;
   	2 : onlyActive := tActiveStates.stateAll;
   end;
   //
   custListQuery.Update('FNAME', sortDir, onlyActive);
   PercentForm_Free();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAccountingEscrowForm.Recalculate( inID : string );
begin
   if ( inID = '' ) then
      inID := custListQuery.FieldByName('ID').AsString;
   custListQuery.Close();
   custListQuery.Open();
   custListQuery.Locate('ID', inID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tAccountingEscrowForm.ActiveComboBoxChange(Sender: TObject);
begin
   UpdateCustQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tAccountingEscrowForm.SortViewComboBoxChange(Sender: TObject);
begin
   UpdateCustQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tAccountingEscrowForm.AccountingModifyEscrow;
var
   escModForm : tEscrowModifyForm;
begin
   custQuery.Load( custListQuery.FieldByName('ID').AsString );
   //
   escModForm := tEscrowModifyForm.Create( Application, 'Customer Escrow Adjustment', true, CustQuery );
   escModForm.ShowModal();
   if ( escModForm.FormResult = mrOK ) then
      Recalculate('');
   // Don't CA FREE.
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

