 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Product_ControlFormUnit;

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   img_storageformunit,
   avobase_dialogformunit,
   avobase_helpformunit,
   avobase_baseform_menuunit,
   avobase_baseform_standardunit,
   //
   Product_EditFormUnit,
   Product_ListFormUnit,
   BackOrder_ManagerFormUnit,
   Report_Product_SingleProductFormUnit,
   Product_ImportProductFormUnit,
	//
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs;

// this form ONLY handles the List and the Edit. The SELECT and SELECT EDIT are handled by completely separate areas.
const
	PRODCONTROL_PRODLIST = 2000;
   PRODCONTROL_PRODEDIT = 2001;

type
	tControlForm_Product = class( tForm )
   	MAIN_DOCK_PANEL: TScrollBox;
      //
      procedure HandleCloseForm(Sender: TObject);
      procedure HandleBackOrderDeliveredEvent( InProdID,InBOProdID : string );
      procedure HandleBackOrderNotAvailableEvent( InProdID,InBOProdID : string );
      procedure HandleLoadOrderEvent( sender : tObject; inOrderID : string );
      procedure HandleViewOrderInvoiceEvent( sender : tObject; inOrderID : string );
      procedure HandlePrintOrderInvoiceEvent( sender : tObject; inOrderID : string );
   private
      fViewInvoiceEvent : tViewInvoiceEvent;
      fPrintInvoiceEvent : tPrintInvoiceEvent;
      fLoadOrderEvent : tLoadOrderEvent;
      fBackOrderNotAvailableEvent : tBackOrderNotAvailableEvent;
      fBackOrderDeliveredEvent : tBackOrderDeliveredEvent;
   public
   	frm_ProductList : TProductListForm;
      frm_ProductEdit : tProductEditForm;
      function Product_EnableDisableButtons : boolean;
		//
      procedure BackOrderManager();
      procedure StartForm;
      procedure StopForm;
      procedure DockForm(inForm: tForm; inFormType : integer);
      procedure GlobalRefreshEvent();
      procedure ProductPrint();
      procedure ProductExport();
      procedure ProductImport();
      //
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OnViewOrderInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OnPrintOrderInvoiceEvent : tPrintInvoiceEvent read fPrintInvoiceEvent write fPrintInvoiceEvent;
      property OnBackOrderNotAvailableEvent : tBackOrderNotAvailableEvent read fBackOrderNotAvailableEvent write fBackOrderNotAvailableEvent;
      property OnBackOrderDeliveredEvent : tBackOrderDeliveredEvent read fBackOrderDeliveredEvent write fBackOrderDeliveredEvent;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Product.BackOrderManager;
var
   BOForm : tBackOrder_ManagerForm;
begin
   BOForm := tBackOrder_ManagerForm.Create( Application );
   // Events
   BOForm.OnBackOrderDeliveredEvent := HandleBackOrderDeliveredEvent;
   BOForm.OnBackOrderNotAvailableEvent := HandleBackOrderNotAvailableEvent;
   BOForm.OnLoadOrderEvent := HandleLoadOrderEvent;
   BOForm.OnViewOrderInvoiceEvent := HandleViewOrderInvoiceEvent;
   BOForm.OnPrintOrderInvoiceEvent := HandlePrintOrderInvoiceEvent;
   // Show
   BOForm.ShowModal;
   FreeAndNil(BoForm);
end;

procedure tControlForm_Product.DockForm(inForm: tForm; inFormType : integer);
begin
	inForm.ManualDock(MAIN_DOCK_PANEL, nil, alClient);
   inForm.BorderStyle := bsNone;
   inForm.Left := (MAIN_DOCK_PANEL.Width - MAIN_DOCK_PANEL.Width) div 2;
   inForm.Top := (MAIN_DOCK_PANEL.Height - MAIN_DOCK_PANEL.Height) div 2;
   inForm.WindowState := wsMaximized;
   inForm.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
   inForm.BorderIcons := [];
   inForm.Position := poDefault;
   inForm.OnDestroy := HandleCloseForm;
   inForm.Tag := inFormType;
end;

procedure tControlForm_Product.GlobalRefreshEvent;
begin
   if ( frm_ProductList <> NIL ) then
      frm_ProductList.GlobalRefreshEvent();
end;

procedure tControlForm_Product.HandleBackOrderDeliveredEvent( InProdID,InBOProdID: string);
begin
   if Assigned( fBackOrderDeliveredEvent ) then
      fBackOrderDeliveredEvent( InProdID,InBOProdID );
end;

procedure tControlForm_Product.HandleBackOrderNotAvailableEvent( InProdID,InBOProdID: string);
begin
   if Assigned(fBackOrderNotAvailableEvent) then
      fBackOrderNotAvailableEvent( InProdID,InBOProdID );
end;

procedure tControlForm_Product.HandleCloseForm(Sender: TObject);
begin
  case tForm(Sender).Tag of
    PRODCONTROL_PRODLIST: frm_ProductList := Nil;
  end;
end;

procedure tControlForm_Product.HandleLoadOrderEvent(sender: tObject; inOrderID: string);
begin
   if Assigned( fLoadOrderEvent ) then
      fLoadOrderEvent( sender, inOrderID);
end;

procedure tControlForm_Product.HandlePrintOrderInvoiceEvent(
  sender: tObject; inOrderID: string);
begin
   if Assigned( fPrintInvoiceEvent ) then
      fPrintInvoiceEvent( sender, inOrderID);
end;

procedure tControlForm_Product.HandleViewOrderInvoiceEvent(sender: tObject; inOrderID: string);
begin
   if Assigned( fViewInvoiceEvent ) then
      fViewInvoiceEvent( sender, inOrderID);
end;


procedure tControlForm_Product.StartForm;
begin
	// we need to make sure that if this form is created and NO other forms are showing
	if (frm_ProductList = NIL) then
   begin
   	frm_ProductList := tProductListForm.Create(Application);
      DockForm( frm_ProductList, PRODCONTROL_PRODLIST );
   end;

   // now, which one do we show? We always try to show the list, but if an EDIT is up
   if (frm_ProductList <> NIL) then
   	frm_ProductList.Show();
   if (frm_ProductEdit <> NIL) then
   	frm_ProductEdit.Show();
end;

procedure tControlForm_Product.StopForm;
begin
	if (frm_ProductList <> NIL) then
   	frm_ProductList.Close();
   if (frm_ProductEdit <> NIL) then
   begin
   	frm_ProductEdit.Show();
      frm_ProductEdit.Close();
   end;
end;

procedure tControlForm_Product.ProductPrint;
var
   rpt_Product_SingleProduct : TReport_Product_SingleProduct;
   errMsg : string;
begin
   if ( frm_ProductList <> NIL ) then
   begin
      rpt_Product_SingleProduct := TReport_Product_SingleProduct.Create( Application );
      // Setup Options
      rpt_Product_SingleProduct.SetOptions( frm_ProductList.Num, frm_ProductList.CycleID );
      // Check for Errors
      errMsg := rpt_Product_SingleProduct.CanPrint;
      if ( errMsg = '' ) then
      begin
         // Display it
         rpt_Product_SingleProduct.QReport.Preview();
      end else
         AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
      // Free it
      if (rpt_Product_SingleProduct <> NIL) then
         FreeAndNil(rpt_Product_SingleProduct);
   end;
end;

function tControlForm_Product.Product_EnableDisableButtons: boolean;
begin
   result := true;
   if ( frm_ProductList.Count = 0 ) then
      result := false;
end;

procedure tControlForm_Product.ProductExport;
begin
   AvoBaseDialog('Product Export', 'Product Export Functionality is still being worked on.', mtInformation, [mbOk], 0);
end;

procedure tControlForm_Product.ProductImport;
var
   ProdImportForm : TProduct_ImportProductForm;
begin
   ProdImportForm := TProduct_ImportProductForm.Create(Application, 'Import Products', true);
   try
      ProdImportForm.ShowModal();
   finally
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
