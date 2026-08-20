 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_ProdHistoryFormUnit;

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
   MasterData_CustomerProdHistoryUnit,
   AvoBase_ToolBarUnit,
   toolbox_ordertoolboxunit,
   toolbox_PreferenceToolBoxUnit,
   ToolBox_EscrowToolBoxUnit,
   Toolbox_CustomerToolBoxUnit,
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
   tCustomer_ProdHistoryForm = class(TAvoBase_BaseForm_Menu)
      VIEWGRID_DOCK_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
    SortByLabel: TLabel;
    SortByComboBox: TComboBox;
    SortViewLabel: TLabel;
    SortViewComboBox: TComboBox;
    procedure SortByComboBoxChange(Sender: TObject);
    procedure SortViewComboBoxChange(Sender: TObject);
   private
      fCustID: string;
      fStartCycleID : string;
      fEndCycleID : string;
   	custOrderProdListGrid : tAvoBaseDBGrid;
      custOrderProdDetailListQuery : tMasterDataCustomerProdHistoryQuery;
      dbNavTool : tAvoBaseDBNavigationTool;
      //
      procedure StartUpForm();
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure UpdateQuery();
   public
      //
      constructor Create(owner : tComponent; inCustID : string );  overload;
      destructor Destroy; override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


constructor tCustomer_ProdHistoryForm.Create(owner: tComponent; inCustID : string);
begin
	inherited create( owner, Customer_GetCustomerNameByCustID(inCustID) + ' Order Product History', true, True );
   //
   fCustID := inCustID;
   //
   PercentForm_Create('Generating Product History - One Moment Please...', 0, 0);
   //
   custOrderProdDetailListQuery := tMasterDataCustomerProdHistoryQuery.Create( masterData, fCustID );
   //
   custOrderProdListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, custOrderProdDetailListQuery, 'FNAME' );
   custOrderProdListGrid.Clear;
   custOrderProdListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   UpdateQuery();
   //
   custOrderProdListGrid.Add(custOrderProdDetailListQuery.FieldByName('ODATE'), 'DATE', 80, clBlue, [], taRightJustify);
   custOrderProdListGrid.Add(custOrderProdDetailListQuery.FieldByName('CYCLENAME'), 'CYCLE', 80, clBlue, [], taRightJustify);
   custOrderProdListGrid.Add(custOrderProdDetailListQuery.FieldByName('NUM'), 'PROD #', 90, clRed, [], taLeftJustify);
   custOrderProdListGrid.Add(custOrderProdDetailListQuery.FieldByName('NAME'), 'PRODUCT', 220, clBlack, [], taLeftJustify);
   custOrderProdListGrid.Add(custOrderProdDetailListQuery.FieldByName('SQTY'), 'QTY', 40, clBlack, [], taRightJustify);
   custOrderProdListGrid.Add(custOrderProdDetailListQuery.FieldByName('RCOST'), 'RETAIL', 60, clBlack, [], taRightJustify);
   custOrderProdListGrid.Add(custOrderProdDetailListQuery.FieldByName('SCOST'), 'SELL-AT', 60, clBlack, [], taRightJustify);
   //
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, custOrderProdDetailListQuery);
   //
	StartUpForm();
   PercentForm_Free();
end;

destructor tCustomer_ProdHistoryForm.Destroy;
begin
   FreeAndNil(custOrderProdListGrid);
   FreeAndNil(custOrderProdDetailListQuery);
   FreeAndNil(dbNavTool);
   //
  inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_ProdHistoryForm.HandleActionExecute(sender: tObject;
  actionID: integer);
begin
   case actionID of
      CMD_CLOSE : Close();
   end;
end;

procedure tCustomer_ProdHistoryForm.HandleActionListUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_CLOSE: ;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_ProdHistoryForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(custOrderProdDetailListQuery.RecNo) + ' of ' + IntToStr(custOrderProdDetailListQuery.RecordCount);
end;

procedure tCustomer_ProdHistoryForm.SortByComboBoxChange(Sender: TObject);
begin
   UpdateQuery();
end;

procedure tCustomer_ProdHistoryForm.SortViewComboBoxChange( Sender: TObject);
begin
   UpdateQuery();
end;

procedure tCustomer_ProdHistoryForm.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
end;

procedure tCustomer_ProdHistoryForm.UpdateQuery;
begin
   case SortViewComboBox.ItemIndex of
      0 : custOrderProdDetailListQuery.SortDir := 'DESC';
      1 : custOrderProdDetailListQuery.SortDir := '';
   end;
   case SortByComboBox.ItemIndex of
      0 : custOrderProdDetailListQuery.SortField := 'O.ODATE';
      1 : custOrderProdDetailListQuery.SortField := 'P.NUM';
      2 : custOrderProdDetailListQuery.SortField := 'P.NAME';
      3 : custOrderProdDetailListQuery.SortField := 'O.CYCLENAME';
   end;
   custOrderProdDetailListQuery.Update();
end;

end.
