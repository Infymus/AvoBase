 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Product_ViewFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
  recordstructureunit,
   avobase_dialogformunit,
   masterdata_BaseDataClassUnit,
   toolbox_orgtoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_cycletoolboxunit,
   MasterData_ReportProductSingleProductUnit,
   masterdata_navigationtoolunit,
   MasterData_BaseGridUnit,
   //
   windows,
   messages,
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
   Mask;

type
  TProduct_ViewForm = class(TAvoBase_BaseForm_Menu)
    db_isactive: TCheckBox;
    CycleNumComboBox: TComboBox;
    Label5: TLabel;
    campYearLabel: TLabel;
    CycleYearComboBox: TComboBox;
    Label1: TLabel;
    orgCombo: TComboBox;
    Label2: TLabel;
    db_num: TMaskEdit;
    amountLabel: TLabel;
    db_amount: TMaskEdit;
    Label3: TLabel;
    db_qty: TMaskEdit;
    db_name: TLabeledEdit;
    db_descr: TLabeledEdit;
    db_PRODN1: TLabeledEdit;
    db_PRODN2: TLabeledEdit;
    db_PRODN3: TLabeledEdit;
    db_PRODN4: TLabeledEdit;
    DB_DOCK_PANEL: TPanel;
    db_top_panel: TPanel;
    db_nav_panel: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    db_ycost: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
      fProdQuery : tMasterData_BaseDataClass;
      dataListGrid : tAvoBaseDBGrid;
      gridDataSource : tDataSource;
      dbNavTool : tAvoBaseDBNavigationTool;
      prodListQuery : tMasterDataReportSingleProduct;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure StartUpForm();
      procedure Fill_Cycle_Years;
      procedure Fill_Cycle_Numbers;
      procedure SetProductSpecialFields();
      function fGetOrgID : string;
   public
      property OrgID : string read fGetOrgID;
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TProduct_ViewForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inQuery: tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   fProdQuery := inQuery;
   //
	StartUpForm();
end;

function TProduct_ViewForm.fGetOrgID: string;
begin
   result := fProdQuery.GetFieldByName('ORG_ID').AsString;
end;

procedure TProduct_ViewForm.CloseForm;
begin
	Close();
end;

procedure TProduct_ViewForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_CLOSE : CloseForm();
   end;
end;

procedure TProduct_ViewForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   // we do absollutely nothing here because there isn't anything to do, this is a  modal, read only form.
end;

procedure TProduct_ViewForm.HandleQueryUpdate(Sender: TObject;
  Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(prodListQuery.RecNo) + ' of ' + IntToStr(prodListQuery.RecordCount);
end;

procedure TProduct_ViewForm.SetProductSpecialFields;
begin
   db_prodn1.visible := false;
   db_prodn2.visible := false;
   db_prodn3.visible := false;
   db_prodn4.visible := false;
   //
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN1') <> '' ) then
   begin
      db_prodn1.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN1');
      db_prodn1.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN2') <> '' ) then
   begin
      db_prodn2.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN2');
      db_prodn2.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN3') <> '' ) then
   begin
      db_prodn3.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN3');
      db_prodn3.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( OrgID, 'PRODN4') <> '' ) then
   begin
      db_prodn4.editlabel.Caption := Org_GetOrgProductSpecialField( OrgID, 'PRODN4');
      db_prodn4.visible := true;
   end;
end;

procedure TProduct_ViewForm.StartUpForm;
var
   cnt : integer;
   orgName : string;
   cycleRec : tCycleRec;
begin
	// what to do on the startup of a form
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
   //
   Org_ComboBox_FillActiveOrgs( orgCombo );
   orgName := Org_GetOrgNameByOrgID( fProdQuery.GetFieldByName('ORG_ID').AsString);
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;


   // now transfer ALL of the Product record into the visible fields on the form.
   db_isactive.Checked := fProdQuery.GetFieldByName('ISACTIVE').AsBoolean;
   db_num.Text := fProdQuery.GetFieldByName('NUM').AsString;
	db_name.Text := fProdQuery.GetFieldByName('NAME').AsString;
   db_DESCR.Text := fProdQuery.GetFieldByName('DESCR').AsString;

   db_PRODN1.EditLabel.Caption := '"'+ Org_GetOrgProductSpecialField( fProdQuery.GetFieldByName('ORG_ID').AsString, 'PRODN1' ) + '"';
   db_PRODN2.EditLabel.Caption := '"'+ Org_GetOrgProductSpecialField( fProdQuery.GetFieldByName('ORG_ID').AsString, 'PRODN2' ) + '"';
   db_PRODN3.EditLabel.Caption := '"'+ Org_GetOrgProductSpecialField( fProdQuery.GetFieldByName('ORG_ID').AsString, 'PRODN3' ) + '"';
   db_PRODN4.EditLabel.Caption := '"'+ Org_GetOrgProductSpecialField( fProdQuery.GetFieldByName('ORG_ID').AsString, 'PRODN4' ) + '"';

   db_PRODN1.Text := fProdQuery.GetFieldByName('PRODN1').AsString;
   db_PRODN2.Text := fProdQuery.GetFieldByName('PRODN2').AsString;
   db_PRODN3.Text := fProdQuery.GetFieldByName('PRODN3').AsString;
   db_PRODN4.Text := fProdQuery.GetFieldByName('PRODN4').AsString;

   db_qty.Text := fProdQuery.GetFieldByName('QTY').AsString;
   db_amount.Text := FormatFloat('#0.00', fProdQuery.GetFieldByName('AMOUNT').AsCurrency);
   db_ycost.Text := FormatFloat('#0.00', fProdQuery.GetFieldByName('YCOST').AsCurrency);
   // '000\-000;1; ';

   // yes these are duplicates from below
   Cycle_ComboBox_FillCycleNumbers( Org_GetOrgIDByOrgName(orgCombo.Text), CycleNumComboBox );
   Cycle_ComboBox_FillCycleYears( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );

   // cycle numbers
   Fill_Cycle_Numbers();
   // cycle years
   Fill_Cycle_Years();

   prodListQuery := tMasterDataReportSingleProduct.Create( masterData,
      fProdQuery.GetFieldByName('NUM').AsSTring, fProdQuery.GetFieldByName('C_ID').AsSTring );

   dataListGrid := tAvoBaseDBGrid.Create( nil, DB_DOCK_PANEL );
	gridDataSource := tDataSource.Create(nil);
   dbNavTool := tAvoBaseDBNavigationTool.Create( nil, db_nav_panel );
   gridDataSource.DataSet := prodListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;


   DataListGrid.Init( prodListQuery, 'ORGNAME' );
   DataListGrid.Clear;
   DataListGrid.Add(prodListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clNavy, [fsBold], taLeftJustify);
   DataListGrid.Add(prodListQuery.FieldByName('ORGNAME'), 'ORG', 120, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(prodListQuery.FieldByName('ORDATE'), 'DATE', 65, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(prodListQuery.FieldByName('SQTY'), 'SQTY', 50, clBlack, [fsBold], taRightjustify);
   DataListGrid.Add(prodListQuery.FieldByName('FQTY'), 'FQTY', 50, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(prodListQuery.FieldByName('RQTY'), 'RQTY', 50, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(prodListQuery.FieldByName('YCOST'), 'YCOST', 60, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(prodListQuery.FieldByName('RCOST'), 'RETAIL', 60, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(prodListQuery.FieldByName('SCOST'), 'SOLD AT', 60, clBlack, [fsBold], taRightJustify);
	dbNavTool.Init ( prodListQuery);

{
   masterData.QueryAddCalculatedField( self, 'ORDATE', 20, ftDateTime );
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 60, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 60, ftString);
   masterData.QueryAddCalculatedField( self, 'ONUM', 20, ftString);

         retVal := masterData.AddTable(masterData.dbPath + table_order_product,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'R_ID VARCHAR(40), ' + // return prior order_product_ID
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'RQTY INTEGER, ' + // return qty (if RQTY = SQTY + FQTY then this line CANNOT be returned!!! )
            'FQTY INTEGER, ' + // free quantity (for by X get X free)
            'PQTY INTEGER, ' + // prior returned quantity
            'SO INTEGER, ' + // integer sort, only on save for bringing back into the invoice.
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PRODN1 VARCHAR(40), ' + // product table field name 1
            'PRODN2 VARCHAR(40), ' + // product table field name 2
            'PRODN3 VARCHAR(40), ' + // product table field name 3
            'PRODN4 VARCHAR(40), ' + // product table field name 4
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
}
   prodListQuery.Open();
   //
   SetProductSpecialFields();
end;

procedure TProduct_ViewForm.Fill_Cycle_Numbers;
var
   cnt : integer;
   cNum : integer;
   cycleRec : tCycleRec;
begin
      cycleRec := Cycle_GetCycleByCycleID( fProdQuery.GetFieldByName('C_ID').AsString );
      for cnt := 0 to CycleNumComboBox.Items.Count - 1 do
      begin
         cNum := StrToInt( CycleNumComboBox.Items.Strings[ cnt ] );
         if ( cNum = cycleRec.num )  then
            CycleNumComboBox.ItemIndex := cnt;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TProduct_ViewForm.Fill_Cycle_Years;
var
   cnt : integer;
   cYear : integer;
   cycleRec : tCycleRec;
begin
      cycleRec := Cycle_GetCycleByCycleID( fProdQuery.GetFieldByName('C_ID').AsString );
      for cnt := 0 to CycleYearComboBox.Items.Count - 1 do
      begin
         cYear := StrToInt( CycleYearComboBox.Items.Strings[ cnt ] );
         if ( cYear = cycleRec.year )  then
            CycleYearComboBox.ItemIndex := cnt;
      end;
end;

procedure TProduct_ViewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FreeAndNil(prodListQuery);
   FreeAndNil(GridDataSource);
	FreeAndNil(DataListGrid);
   FreeAndNil(dbNavTool);
   //
   inherited;
end;

end.
