 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Product_InvoiceLineItemProductLookupUnit;

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
   MasterData_InvoiceLineItemProductLookupUnit,
   AvoBase_BaseForm_SelectUnit,
   AvoBase_PercentFormUnit,
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
   tInvoiceLineItemProductLookupForm = class(TAvoBase_BaseForm_Select)
      GroupBox2: TGroupBox;
      SortByLabel: TLabel;
      SortViewLabel: TLabel;
      SortViewComboBox: TComboBox;
      SortByComboBox: TComboBox;
      db_qtyoh: TCheckBox;
      GroupBox1: TGroupBox;
      searchButton: TSpeedButton;
      clearButton: TSpeedButton;
      SearchEdit: TEdit;
      procedure clearButtonClick(Sender: TObject);
      procedure searchButtonClick(Sender: TObject);
      procedure SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure SortByComboBoxChange(Sender: TObject);
      procedure SortViewComboBoxChange(Sender: TObject);
      procedure db_qtyohClick(Sender: TObject);
      procedure HandleGridDoubleClick( Sender : tObject );
    procedure FormKeyPress(Sender: TObject; var Key: Char);
   private
      fprodListQuery : tMasterDataInvoiceLineItemProductLookup;
      fProdNum : string;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      function fGetProductID: string;
   public
      //
      procedure UpdateProdQuery();
      procedure Recalculate();
      //
      property ProdID : string read fGetProductID;
      //
      constructor Create(
         owner: TComponent;
         InCaption : string;
         isTopBarVisble : boolean;
         inProdListQuery : tMasterDataInvoiceLineItemProductLookup;
         inProdNum : string ); overload;
      destructor Destroy; override;
  end;

// A call from Invoice_LineItemControlObjectUnit as per a handled event.

function Product_InvoiceLineItemProductLookup(
   inProdNum : string;
   inCycleID : string;
   fprodListQuery : tMasterDataInvoiceLineItemProductLookup ) : string;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tInvoiceLineItemProductLookupForm.Create(
         owner: TComponent;
         InCaption : string;
         isTopBarVisble : boolean;
         inProdListQuery : tMasterDataInvoiceLineItemProductLookup;
         inProdNum : string );

begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   fProdListQuery := inProdListQuery;
   fProdNum := inProdNum;
   //
   gridDataSource.DataSet := fProdListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   // These items are INHERITED from the AvoBase_BasweForm_StandardUnit
   // DataListGrid, gridDataSource, dbNavTool <-- all inherited
   DataListGrid.Init( fProdListQuery, 'NUM' );
   DataListGrid.Clear;
   DataListGrid.Add(fProdListQuery.FieldByName('ORGNAME'), 'ORG', 60, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(fProdListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(fProdListQuery.FieldByName('NUM'), 'PRODUCT', 80, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(fProdListQuery.FieldByName('NAME'), 'NAME', 240, clHighlight, [fsBold], taLeftJustify);
   DataListGrid.Add(fProdListQuery.FieldByName('QTY'), 'QTY OH', 50, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(fProdListQuery.FieldByName('AMOUNT'), 'RETAIL', 50, clGreen, [fsBold], taRightJustify);
   DataListGrid.OnDblClick := HandleGridDoubleClick;
   //
	dbNavTool.Init( fProdListQuery);
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
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
   SearchEdit.Text := inProdNum;
end;

procedure tInvoiceLineItemProductLookupForm.db_qtyohClick(Sender: TObject);
begin
   UpdateProdQuery();
end;

destructor tInvoiceLineItemProductLookupForm.Destroy;
begin
	fProdListQuery.Close();
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.clearButtonClick(Sender: TObject);
begin
   SearchEdit.Text := '';
   UpdateProdQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tInvoiceLineItemProductLookupForm.fGetProductID: string;
begin
   result := fProdListQuery.FieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.FormKeyPress(Sender: TObject; var Key: Char);
var
	x : integer;
begin
   x := Ord(KEY);
   case ORD(KEY) of
   	79,111,13:
      begin
         fFormEvent := mrOk;
         Close();
      end;
   end;
  {
  procedure TAvoBaseDialogForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  X : Integer;
begin
  x := Ord(KEY);
  case ORD(KEY) of
//yes
    89,121:
    begin
      Self.iResult := 1;
      Close;
    end;
//no
    78,110:
    begin
      Self.iResult := 3;
      Close;
    end;
//cancel
    67,99:
    begin
      Self.iResult := 4;
      Close;
    end;
//ok
    79,111,13:
    begin
      Self.iResult := 2;
      Close;
    end;
  end;
end;
  }

  {
end;         fFormEvent := mrOk;
         Close();
         }

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.Recalculate;
var
   findID : string;
begin
   findID := fProdListQuery.FieldByName('ID').AsString;
   fProdListQuery.Close();
   fProdListQuery.Open();
   fProdListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.searchButtonClick(Sender: TObject);
begin
   UpdateProdQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if ( Key = VK_RETURN ) then
      UpdateProdQuery()
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.SortByComboBoxChange(Sender: TObject);
begin
   UpdateProdQuery()
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.SortViewComboBoxChange(Sender: TObject);
begin
	UpdateProdQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.HandleActionExecute(sender: tObject; actionID: integer);
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

procedure tInvoiceLineItemProductLookupForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
end;

procedure tInvoiceLineItemProductLookupForm.HandleGridDoubleClick(Sender: tObject);
begin
   fFormEvent := mrOk;
   Close();
end;

procedure tInvoiceLineItemProductLookupForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(fProdListQuery.RecNo) + ' of ' + IntToStr(fProdListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tInvoiceLineItemProductLookupForm.UpdateProdQuery;
begin
   // first to last, or last to first?
	if (SortViewComboBox.ItemIndex = 0) then
      fProdListQuery.SortOption := 'DESC'
   else
      fProdListQuery.SortOption := '';
   //
   fProdListQuery.ProductNum := fProdNum;
   fProdListQuery.SearchOH := db_qtyoh.Checked;
   //
   fProdListQuery.SearchText := ProperCase(SearchEdit.Text, True);
   //   tSortProdTypes = (ProdOrg, ProdCycle, ProdNum, ProdName, ProdQTY, ProdAmount);
   case SortByComboBox.ItemIndex of
   	0 : fProdListQuery.SortType := ProdOrg;
   	1 : fProdListQuery.SortType := ProdCycle;
   	2 : fProdListQuery.SortType := ProdNum;
   	3 : fProdListQuery.SortType := ProdName;
   	4 : fProdListQuery.SortType := ProdQTY;
   	5 : fProdListQuery.SortType := ProdAmount;
   end;
   //
   fProdListQuery.Update();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTSIDE FUNCTION CALL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function Product_InvoiceLineItemProductLookup(
   inProdNum : string;
   inCycleID : string;
   fprodListQuery : tMasterDataInvoiceLineItemProductLookup ) : string;
var
   invLookup : tInvoiceLineItemProductLookupForm;
begin
   result := '';
   //
   fprodListQuery.Update( inProdNum, inCycleID );
   if ( fProdListQuery.RecordCount <> 0 ) then
   begin
      invLookup := tInvoiceLineItemProductLookupForm.Create(Application, 'Existing Product Found', true, fprodListQuery, inProdNum);
      invLookup.ShowModal();
      if ( invLookUp.FormResult = mrOK ) then
         result := invLookUp.ProdID;
      FreeAndNil( invLookup );
   end;
end;

// ======== //

end.