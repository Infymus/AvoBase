 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Product_SelectFormUnit;

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
   RecordStructureUnit,
   masterdata_BaseDataClassUnit,
   MasterData_ProductSelectListUnit,
   product_editformunit,
   product_viewformunit,
   AvoBase_BaseForm_SelectUnit,
   //
   AvoBase_PercentFormUnit,
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
   tProductSelectForm = class(TAvoBase_BaseForm_Select)
      GroupBox2: TGroupBox;
      SortByLabel: TLabel;
      SortViewLabel: TLabel;
      SortViewComboBox: TComboBox;
      SortByComboBox: TComboBox;
      GroupBox1: TGroupBox;
      searchButton: TSpeedButton;
      clearButton: TSpeedButton;
      SearchEdit: TEdit;
    db_qtyoh: TCheckBox;
      procedure clearButtonClick(Sender: TObject);
      procedure searchButtonClick(Sender: TObject);
      procedure SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure SortByComboBoxChange(Sender: TObject);
      procedure SortViewComboBoxChange(Sender: TObject);
      procedure db_qtyohClick(Sender: TObject);
      procedure HandleGridDoubleClick( Sender : tObject );
   private
   	frmProdEdit : tProductEditForm;
      prodQuery : tMasterData_BaseDataClass;
      prodListQuery : tMasterDataProducSelectList;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      function fGetProductID: string;
   public
      //
      procedure UpdateProdQuery();
      procedure ProductActivateDeactivate();
      procedure ProductNew();
      procedure ProductEdit();
      procedure ProductView();
      procedure ProductHelp();
      procedure ProductReports();
      procedure ProductPrint();
      procedure ProductDelete();
      procedure Recalculate();
      //
      property ProdID : string read fGetProductID;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean); overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tProductSelectForm.Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
//   StatusBar.Panels.Ad/d();
//   StatusBar.Panels[0].Width := 100;
   //
   ProdListQuery := tMasterDataProducSelectList.Create( masterData);
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
   DataListGrid.Add(ProdListQuery.FieldByName('ORGNAME'), 'ORG', 60, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('NUM'), 'PRODUCT', 80, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('NAME'), 'NAME', 240, clHighlight, [fsBold], taLeftJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('QTY'), 'QTY OH', 50, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(ProdListQuery.FieldByName('AMOUNT'), 'RETAIL', 50, clGreen, [fsBold], taRightJustify);
   DataListGrid.OnDblClick := HandleGridDoubleClick;
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
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
end;

procedure tProductSelectForm.db_qtyohClick(Sender: TObject);
begin
   UpdateProdQuery();
end;

{
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   CustomerDetailListQuery := tMasterDataCustomerSelectList.Create( masterData);
   //
   dataListGrid.Init( CustomerDetailListQuery, 'ORGNAME');
   gridDataSource.DataSet := CustomerDetailListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   dataListGrid.Clear;
   //
   dataListGrid.Add(CustomerDetailListQuery.FieldByName('FULLNAME'), 'CUSTOMER NAME', 164, clRed, [fsBold], taLeftJustify);
   dataListGrid.Add(CustomerDetailListQuery.FieldByName('PHONEH'), 'PHONE', 120, clBlue, [], taLeftJustify);
   dataListGrid.Add(CustomerDetailListQuery.FieldByName('PHONEC'), 'CELL', 120, clHighlight, [], taLeftJustify);
   dataListGrid.Add(CustomerDetailListQuery.FieldByName('FULLADDR'), 'ADDRESS', 300, clBlack, [], taLeftJustify);

   //
   dataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( CustomerDetailListQuery );
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
	StartUpForm();
   StatBarUpdate();
end;}
destructor tProductSelectForm.Destroy;
begin
	ProdListQuery.Close();
   freeAndNil(ProdListQuery);
   FreeAndNil(ProdQuery);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.clearButtonClick(Sender: TObject);
begin
   SearchEdit.Text := '';
   UpdateProdQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tProductSelectForm.fGetProductID: string;
begin
   result := ProdListQuery.FieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.ProductActivateDeactivate;
var
  OldRec : Integer;
  SetActive : boolean;
  CanDo : Boolean;
  errRec : tErrorResult;
begin
   showmessage('ProductActivateDeactivate');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.ProductDelete;
var
	errRec : tErrorResult;
   delMsg : string;
begin
   delMsg := 'Deleting a product will not affect any open or closed orders.' + #13 + #13 +
      'Are you sure you want to delete this product?';
   if AvoBaseDialog('Delete Product', delMsg, mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      ProdQuery.Delete( ProdListQuery.FieldByName('ID').AsString );
      UpdateProdQuery();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.ProductEdit;
var
	errRec : tErrorResult;
   frmEdit : TProductEditForm;
begin
   errRec := ProdQuery.Load( ProdListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
      ProdQuery.Edit();
      frmEdit := TProductEditForm.Create( Application, 'Edit Product', true, false, ProdQuery);
      try
         frmEdit.ShowModal();
      finally
         FreeAndNil(frmEdit);
      end;
   end else
      AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0);
   Recalculate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.ProductNew;
var
	errRec : tErrorResult;
   frmEdit : TProductEditForm;
begin
   errRec := ProdQuery.Load( ProdListQuery.FieldByName('ID').AsString );
   if NOT (errRec.errorResult) then
   begin
      ProdQuery.Edit();
      frmEdit := TProductEditForm.Create( Application, 'New Product', true, true, ProdQuery);

      frmEdit.IsNew := true;
      try
         frmEdit.ShowModal();
      finally
         FreeAndNil(frmEdit);
      end;
   end else
      AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0);
   Recalculate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.ProductHelp;
begin
   showmessage('ProductHelp');

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.ProductPrint;
begin
   showmessage('ProductPrint');

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.ProductReports;
begin
   showmessage('ProductReports');

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ RIBBON View Product Pressed }
procedure tProductSelectForm.ProductView;
var
   frmProdView : tProduct_ViewForm;
	errRec : tErrorResult;
begin
   showmessage('ProductView');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.Recalculate;
var
   findID : string;
begin
   findID := ProdListQuery.FieldByName('ID').AsString;
   ProdListQuery.Close();
   ProdListQuery.Open();
   ProdListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.searchButtonClick(Sender: TObject);
begin
   UpdateProdQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if ( Key = VK_RETURN ) then
      UpdateProdQuery()
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.SortByComboBoxChange(Sender: TObject);
begin
   UpdateProdQuery()
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.SortViewComboBoxChange(Sender: TObject);
begin
	UpdateProdQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_SELECT_OK :
      begin
         fFormEvent := mrOk;
         Close();
      end;
      CMD_SELECT_CANCEL :
      begin
         fFormEvent := mrCancel;
         Close();
      end;
   end;
end;

procedure tProductSelectForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
end;

procedure tProductSelectForm.HandleGridDoubleClick(Sender: tObject);
begin
         fFormEvent := mrOk;
         Close();

end;

procedure tProductSelectForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(ProdListQuery.RecNo) + ' of ' + IntToStr(ProdListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tProductSelectForm.UpdateProdQuery;
begin
   // first to last, or last to first?
	if (SortViewComboBox.ItemIndex = 0) then
      ProdListQuery.SortOption := 'DESC'
   else
      ProdListQuery.SortOption := '';
   //
   ProdListQuery.SearchOH := db_qtyoh.Checked;
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
