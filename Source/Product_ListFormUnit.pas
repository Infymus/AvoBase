 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Product_ListFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   encryptunit,
  recordstructureunit,
   VerificationUnit,
   Avobase_RegisterDialogFormUnit,
   actionunit,
   masterdata_basegridunit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   masterdata_productlistunit,
   product_editformunit,
   product_viewformunit,
   AvoBase_HelpFormUnit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_orgtoolboxunit,
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
   Buttons;

type
	tProductListForm = class(TAvobase_BaseForm_List)
    GroupBox1: TGroupBox;
    SearchEdit: TEdit;
    searchButton: TSpeedButton;
    clearButton: TSpeedButton;
    GroupBox2: TGroupBox;
    SortByLabel: TLabel;
    SortViewLabel: TLabel;
    SortViewComboBox: TComboBox;
    SortByComboBox: TComboBox;
      procedure EventUpdateQuery(Sender: TObject);
    procedure SortByComboBoxChange(Sender: TObject);
    procedure SortViewComboBoxChange(Sender: TObject);
    procedure clearButtonClick(Sender: TObject);
    procedure searchButtonClick(Sender: TObject);
    procedure SearchEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   private
   	frmProdEdit : tProductEditForm;
      prodQuery : tMasterData_BaseDataClass;
      prodListQuery : tMasterDataProductList;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleDataListGridDoubleClick( sender : tObject );
      function fGetProdID : string;
      function fGetProdNum : string;
      function fGetCycleID : string;
      function fGetProductCount : integer;
      function tygHjehtU88jge: vEnResultRec;
   public
      //
      function Check_CanCreate: boolean;
      procedure UpdateProdQuery();
      procedure ProductActivateDeactivate();
      procedure ProductNew();
      procedure ProductEdit();
      procedure ProductView();
      procedure ProductHelp();
      procedure ProductReports();
      procedure ProductDelete();
      procedure Recalculate( inID : string );
      procedure GlobalRefreshEvent();
      property ID : string read fGetProdID;
      property NUM : string read fGetProdNum;
      property CycleID : string read fGetCycleID;
      property Count : integer read fGetProductCount;
      //
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.clearButtonClick(Sender: TObject);
begin
   SearchEdit.Text := '';
   UpdateProdQuery();
end;

constructor TProductListForm.create(owner : TComponent);
begin
	inherited create( NIL, 'Products', false, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   ProdListQuery := tMasterDataProductList.Create( masterData);
   //
   ProdQuery := tMasterData_BaseDataClass.create( masterData, masterData.Gettable_Product );
   //
   // These items are INHERITED from the AvoBase_BasweForm_StandardUnit
   // DataListGrid, gridDataSource, dbNavTool <-- all inherited
   gridDataSource.DataSet := ProdListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   // These items are INHERITED from the AvoBase_BasweForm_StandardUnit
   // DataListGrid, gridDataSource, dbNavTool <-- all inherited
   DataListGrid.Init( ProdListQuery, 'NUM' );
   DataListGrid.Clear;
   DataListGrid.Add(ProdListQuery.FieldByName('ORGNAME'), 'ORG', 120, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('NUM'), 'PRODUCT', 80, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('NAME'), 'NAME', 240, clHighlight, [fsBold], taLeftJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('QTY'), 'QTY OH', 50, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('YCOST'),  'YOUR COST', 75, clGreen, [fsBold], taRightJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('AMOUNT'), 'RETAIL', 75, clGreen, [fsBold], taRightJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('SELLAT'), 'SELL AT', 75, clGreen, [fsBold], taRightJustify);
   DataListGrid.OnDblClick := HandleDataListGridDoubleClick;
   //
	dbNavTool.Init( ProdListQuery);
   //
   SortByComboBox.Items.Clear;
   SortByComboBox.Items.Add('ORGANIZATION');
   SortByComboBox.Items.Add('CYCLE');
   SortByComboBox.Items.Add('PRODUCT NUMBER');
   SortByComboBox.Items.Add('NAME');
   SortByComboBox.Items.Add('QUANTITY ON HAND');
   SortByComboBox.Items.Add('AMOUNT');
   SortByComboBox.ItemIndex := 0;
   //
   SortViewComboBox.Items.Clear;
   SortViewComboBox.Items.Add('LAST TO FIRST');
   SortViewComboBox.Items.Add('FIRST TO LAST');
   SortViewComboBox.ItemIndex := 0;
   //
   UpdateProdQuery();
end;

destructor tProductListForm.Destroy;
begin
	ProdListQuery.Close();
   freeAndNil(ProdListQuery);
   FreeAndNil(ProdQuery);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tProductListForm.Check_CanCreate: boolean;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if ( Cycle_GetCycleCount = 0 ) then
   	errMsg := 'You must first create a Sales Cycle.';
   //
   if ( Org_GetOrgCount = 0 ) then
   	errMsg := 'You must first create a Sales Organization.';
   //
   if ( errMsg <> '' ) then
   	AvoBaseDialog('Unable To Proceed', errMsg, mtError, [mbOk], 0);
   //
   result := ( errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.ProductActivateDeactivate;
begin
   showmessage('ProductActivateDeactivate');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.ProductDelete;
var
	errRec : tErrorResult;
   delMsg : string;
begin
	if ( ProdListQuery.RecordCount <> 0 ) then
   begin
      delMsg := 'Deleting a product will not affect any open or closed orders.' + #13 + #13 +
         'Are you sure you want to delete this product?';
      if AvoBaseDialog('Delete Product', delMsg, mtConfirmation, [mbYes, mbNo], 0) = mbyes then
      begin
         ProdQuery.Delete( ProdListQuery.FieldByName('ID').AsString );
         UpdateProdQuery();
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.ProductEdit;
var
	errRec : tErrorResult;
   frmEdit : TProductEditForm;
begin
	if ( ProdListQuery.RecordCount <> 0 ) then
   begin
      errRec := ProdQuery.Load( ProdListQuery.FieldByName('ID').AsString );
      if NOT (errRec.errorResult) then
      begin
         ProdQuery.Edit();
         frmEdit := TProductEditForm.Create( Application, 'Edit Product', true, false, ProdQuery);
         try
            frmEdit.ShowModal();
         finally
            //FreeAndNil(frmEdit);
         end;
         Recalculate( ProdListQuery.FieldByName('ID').AsString );
      end else
         AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0);
 	end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.ProductNew;
var
	errRec : tErrorResult;
   frmEdit : TProductEditForm;
   id : string;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
      if ( Count > 100 ) then
   begin
      AvoBaseRegisterDialog(#85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 + #32 + #118 + #101 +
         #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 +
         #97 + #114 + #101 + #32 + #108 + #105 + #109 + #105 + #116 + #101 + #100 + #32 + #116 + #111 + #32 + #49 + #48 + #48 +
         #32 + #80 + #114 + #111 + #100 + #117 + #99 + #116 + #115 + #32 + #111 + #110 + #108 + #121 + #46 + #32 + #69 + #120 +
         #112 + #105 + #114 + #101 + #100 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #114 + #97 + #116 + #105 + #111 +
         #110 + #32 + #114 + #101 + #113 + #117 + #105 + #114 + #101 + #115 + #32 + #114 + #101 + #110 + #101 + #119 + #97 +
         #108 + #32 + #116 + #111 + #32 + #97 + #100 + #100 + #32 + #109 + #111 + #114 + #101 + #32 + #80 + #114 + #111 + #100 +
         #117 + #99 + #116 + #115 + #46);
      {Unregistered versions of AvoBase are limited to 100 Products only. Expired Registration requires renewal to add more Products.}
      Exit;
   end;
	if ( Check_CanCreate ) then
   begin
      errRec := ProdQuery.Append();
      id := prodQuery.GetFieldByName('ID').AsString;
      if NOT (errRec.errorResult) then
      begin
         ProdQuery.SetFieldByName('ISACTIVE', true);
         frmEdit := TProductEditForm.Create( Application, 'New Product', true, true, ProdQuery);
         frmEdit.IsNew := true;
         try
            frmEdit.ShowModal();
         finally
            //FreeAndNil(frmEdit);
         end;
         Recalculate(id);
      end else
         AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.ProductHelp;
begin
   AvoBaseHelp_Execute('ProductListForm');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.ProductReports;
begin
   showmessage('ProductReports');

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ RIBBON View Product Pressed }
procedure tProductListForm.ProductView;
var
   frmProdView : tProduct_ViewForm;
	errRec : tErrorResult;
begin
	if ( ProdListQuery.RecordCount <> 0 ) then
   begin
      errRec := ProdQuery.Load( ProdListQuery.FieldByName('ID').AsString );
      if NOT (errRec.errorResult) then
      begin
         ProdQuery.Edit();
         frmProdView := tProduct_ViewForm.Create( Application, 'View Product', true, ProdQuery);
         try
            frmProdView.ShowModal();
         finally
            //FreeAndNil(frmProdView);
         end;
      end else
         AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0);
 	end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.Recalculate( inID : string );
begin
   ProdListQuery.Close();
   ProdListQuery.Open();
   ProdListQuery.Locate('ID', inID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.searchButtonClick(Sender: TObject);
begin
   UpdateProdQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if ( Key = VK_RETURN ) then
      UpdateProdQuery()
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.SortByComboBoxChange(Sender: TObject);
begin
   UpdateProdQuery()
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.SortViewComboBoxChange(Sender: TObject);
begin
	UpdateProdQuery();
end;

function tProductListForm.tygHjehtU88jge: vEnResultRec;
//var ty345Gt : tKeyVerif;
begin
   result.noKey := false;
   result.exKey := false;
   (*
   //
   ty345Gt := tKeyVerif.Create;
   //
   if NOT(ty345Gt.Tk4726TuI) then
      result.noKey := true;
	if (ty345Gt.Tk4726TuI) AND NOT(ty345Gt.Tk4726Tu1) then
      result.exKey := true;
   //
   FreeAndNil(ty345Gt);
   *)
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.EventUpdateQuery(Sender: TObject);
begin
	UpdateProdQuery();
end;

function tProductListForm.fGetCycleID: string;
begin
   result := ProdListQuery.FieldByName('C_ID').AsString;

end;

function tProductListForm.fGetProdID: string;
begin
   result := ProdListQuery.FieldByName('ID').AsString;
end;

function tProductListForm.fGetProdNum: string;
begin
   result := ProdListQuery.FieldByName('NUM').AsString;
end;

function tProductListForm.fGetProductCount: integer;
begin
   result := ProdListQuery.RecordCount;
end;

procedure tProductListForm.GlobalRefreshEvent;
var
	curID : String;
begin
	curID := Self.ID;
   UpdateProdQuery();
   ProdListQuery.Locate('ID', curID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.HandleDataListGridDoubleClick(sender: tObject);
begin
   ProductEdit();
end;

procedure TProductListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(ProdListQuery.RecNo) + ' of ' + IntToStr(ProdListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductListForm.UpdateProdQuery;
begin
   // first to last, or last to first?
	if (SortViewComboBox.ItemIndex = 0) then
      ProdListQuery.SortOption := 'DESC'
   else
      ProdListQuery.SortOption := '';
   //
   ProdListQuery.SearchText := ProperCase(SearchEdit.Text, True);
   //   tSortProdTypes = (ProdOrg, ProdCycle, ProdNum, ProdName, ProdQTY, ProdAmount);
   case SortByComboBox.ItemIndex of
   	0 : ProdListQuery.SortType := ProdOrg;
   	1 : ProdListQuery.SortType := ProdCycle;
   	2 : ProdListQuery.SortType := ProdNum;
   	3 : ProdListQuery.SortType := ProdName;
   	4 : ProdListQuery.SortType := ProdQTY;
   	5 : ProdListQuery.SortType := ProdAmount;
   end;
   //
   ProdListQuery.Update();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
