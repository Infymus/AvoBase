 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit ReturnProduct_ManagerFormUnit;

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
   avobase_percentformunit,
   MasterData_ProductReturnListUnit,
   AvoBase_ToolBarUnit,
   AvoBase_HelpFormUnit,
   //
   Toolbox_OrgToolBoxUnit,
   toolbox_producttoolboxunit,
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
   Buttons;

type
   tReturnProduct_Manager = class(TAvobase_BaseForm_List)
      Panel1: TPanel;
      GroupBox2: TGroupBox;
      Label1: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      orgComboBox: TComboBox;
      SortByComboBox: TComboBox;
      SortViewComboBox: TComboBox;
      GroupBox1: TGroupBox;
      searchButton: TSpeedButton;
      clearButton: TSpeedButton;
      SearchEdit: TEdit;
    Label2: TLabel;
    viewTypeCombo: TComboBox;
      procedure searchButtonClick(Sender: TObject);
      procedure clearButtonClick(Sender: TObject);
      procedure orgComboBoxChange(Sender: TObject);
      procedure SortByComboBoxChange(Sender: TObject);
      procedure SortViewComboBoxChange(Sender: TObject);
      procedure SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure viewTypeComboChange(Sender: TObject);
   private
      //
      PBOQuery : tMasterData_BaseDataClass;
      PBOListQuery : tMasterData_ProductBOTempList;
      //
      ToolBar : tAvoBaseToolBar;

      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
   public
      //
      procedure UpdatePBOQuery();
      procedure Recalculate();
      procedure BOReports();
      procedure BOHelp();
      procedure ProductReturnedOEM();
      procedure ProductRestocked();
      //
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReturnProduct_Manager.create(owner : TComponent);
begin
	inherited create( Nil, 'Return-Product Manager', true, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   ShowBorder := True;
   BASE_FORM_LABEL.Caption := 'Return-Product Manager';
   //
   PBOListQuery := tMasterData_ProductBOTempList.Create( masterData);
   //
   PBOQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_BackOrdered );
   //
   // These items are INHERITED from the AvoBase_BasweForm_StandardUnit
   // DataListGrid, gridDataSource, dbNavTool <-- all inherited
   gridDataSource.DataSet := PBOListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( PBOListQuery, 'NUM' );
   DataListGrid.Clear;
   DataListGrid.Add(PBOListQuery.FieldByName('ORGNAME'), 'ORG', 60, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(PBOListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(PBOListQuery.FieldByName('NUM'), 'PRODUCT', 80, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(PBOListQuery.FieldByName('NAME'), 'NAME', 180, clHighlight, [fsBold], taLeftJustify);
   DataListGrid.Add(PBOListQuery.FieldByName('QTY'), 'QTY', 50, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(PBOListQuery.FieldByName('RCOST'), 'RETAIL', 60, clGreen, [fsBold], taRightJustify);
   DataListGrid.Add(PBOListQuery.FieldByName('STAT'), 'STATUS', 140, clHighlight, [fsBold], taLeftJustify);

   // DataListGrid.OnDblClick := HandleDoubleClick; <<--- not used, but here for ref just in case
   //
   dbNavTool.Init( PBOListQuery );
   //
   ToolBar := tAvoBaseToolBar.Create( BASE_NAVBAR_PANEL );
   ToolBar.actionList.OnUpdate := HandleActionListUpdate;
   ToolBar.actionList.onActionEvent := HandleActionExecute;
   ToolBar.Align := alClient;
   ToolBar.CreateButton( CMD_HELP);
   ToolBar.CreateButtonSep;
   ToolBar.CreateButton( CMD_CLOSE);
   ToolBar.CreateButtonSep;
   ToolBar.CreateButton( CMD_PBO_RETURNED );
   ToolBar.CreateButton( CMD_PBO_INVENTORY );
   //
   Org_ComboBox_FillActiveOrgs( 'All', orgComboBox );
   //
   SortByComboBox.Items.Clear;
   SortByComboBox.Items.Add('ORGANIZATION');
   SortByComboBox.Items.Add('CYCLE');
   SortByComboBox.Items.Add('PRODUCT NUMBER');
   SortByComboBox.Items.Add('NAME');
   SortByComboBox.ItemIndex := 3;
   //
   viewTypeCombo.Items.Clear;
   viewTypeCombo.Items.Add('PENDING');
   viewTypeCombo.Items.Add('RETURNED TO OEM');
   viewTypeCombo.Items.Add('RE-STOCKED');
   viewTypeCombo.ItemIndex := 0;
   //
   UpdatePBOQuery();
end;

{
         retVal := masterData.AddTable(masterData.dbPath + table_returntable,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // campaign ID
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' + // total quantity returned
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'STATUS INTEGER, ' + // status see - tProdReturnStatus
            'RCOST MONEY',  // retail cost
}

destructor TReturnProduct_Manager.Destroy;
begin
	PBOListQuery.Close();
   freeAndNil(PBOListQuery);
   FreeAndNil(PBOQuery);
   FreeAndNil(ToolBar);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.HandleActionExecute(sender: tObject;
  actionID: integer);
begin
   case actionID of
      CMD_CLOSE : Close();
      CMD_HELP : AvoBaseHelp_Execute('ReturnProduct_Manager');
      CMD_PBO_RETURNED: ProductReturnedOEM();
      CMD_PBO_INVENTORY: ProductRestocked();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.HandleActionListUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_PBO_RETURNED,
         CMD_PBO_INVENTORY : enabled := (PBOListQuery.RecordCount <> 0);
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(PBOListQuery.RecNo) + ' of ' + IntToStr(PBOListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.orgComboBoxChange(Sender: TObject);
begin
   UpdatePBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.Recalculate;
var
   findID : string;
begin
   findID := PBOListQuery.FieldByName('ID').AsString;
   PBOListQuery.Close();
   PBOListQuery.Open();
   PBOListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.searchButtonClick(Sender: TObject);
begin
   UpdatePBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if ( Key = VK_RETURN ) then
      UpdatePBOQuery()
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.SortByComboBoxChange(Sender: TObject);
begin
   UpdatePBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.SortViewComboBoxChange(Sender: TObject);
begin
   UpdatePBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.UpdatePBOQuery;
begin
   // first to last, or last to first?
	if (SortViewComboBox.ItemIndex = 0) then
      PBOListQuery.SortOption := 'DESC'
   else
      PBOListQuery.SortOption := '';
   //
   PBOListQuery.SearchText := ProperCase(SearchEdit.Text, True);
   //
   case SortByComboBox.ItemIndex of
   	0 : PBOListQuery.SortType := ProdOrg;
   	1 : PBOListQuery.SortType := ProdCycle;
   	2 : PBOListQuery.SortType := ProdNum;
   	3 : PBOListQuery.SortType := ProdName;
   end;
   //
   case viewTypeCombo.ItemIndex of
      0 : PBOListQuery.StatusType := prodRetPending;
      1 : PBOListQuery.StatusType := prodRetOEM;
      2 : PBOListQuery.StatusType := prodRetInv;
   end;
// tProdReturnStatus = ( prodRetPending = 0, prodRetOEM = 1, prodRetInv = 2 );

   //
   PBOListQuery.Update();
end;

procedure tReturnProduct_Manager.viewTypeComboChange(Sender: TObject);
begin
   UpdatePBOQuery;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.ProductRestocked;
var
   prodNum : string;
   prodName : string;
begin
   if ( Product_GetPBOStatusTypeByID( PBOListQuery.FieldByName('ID').AsString) = integer( prodRetPending )) then
   begin
      prodNum := PBOListQuery.FieldByName('NUM').AsString;
      prodName := PBOListQuery.FieldByName('NAME').AsString;
      if AvoBaseDialog('Confirm Product Re-Stock',
         'Product # ' + prodNum + ' "' + prodName + '"' + #13 + #13 +
         'Confirm this Product will be Re-Stocked into your Product Inventory?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
      begin
         Product_MovePBOToProductInventory( PBOListQuery.FieldByName('ID').AsString );
         UpdatePBOQuery();
      end;
   end else
      AvoBaseDialog('Cannot Re-Stock Product',
         'This Product has already been Re-Stocked. It is viewable for information only.', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.ProductReturnedOEM;
var
   prodNum : string;
   prodName : string;
begin
   if ( Product_GetPBOStatusTypeByID( PBOListQuery.FieldByName('ID').AsString) = integer( prodRetPending )) then
   begin
      prodNum := PBOListQuery.FieldByName('NUM').AsString;
      prodName := PBOListQuery.FieldByName('NAME').AsString;
      if AvoBaseDialog('Confirm Product Return To OEM',
         'Product # ' + prodNum + ' "' + prodName + '"' + #13 + #13 +
         'Confirm this Product will be be marked as Returned To Original Equipment Manufacturer?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
      begin
         Product_MarkPBOReturnedToStatus( PBOListQuery.FieldByName('ID').AsString, prodRetOEM );
         UpdatePBOQuery();
      end;
   end else
      AvoBaseDialog('Cannot Return To OEM Product',
         'This Product has already been Returned to OEM. It is viewable for information only.', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.BOHelp;
begin
	showmessage('HELP');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.BOReports;
begin
	showmessage('REPORT');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReturnProduct_Manager.clearButtonClick(Sender: TObject);
begin
   SearchEdit.Text := '';
   UpdatePBOQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.



