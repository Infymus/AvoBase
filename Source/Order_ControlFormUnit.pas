 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Order_ControlFormUnit;

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   img_storageformunit,
   avobase_dialogformunit,
   avobase_helpformunit,
   avobase_baseform_menuunit,
   avobase_baseform_standardunit,
   avobase_bitbuttonunit,
   avobase_groupboxunit,
   INIFileUnit,
   recordstructureunit,
   avobase_percentformunit,
   encryptunit,
   masterdataunit,
   toolbox_cycletoolboxunit,
   toolbox_ordertoolboxunit,
   Order_ViewOrderFormUnit,
   Return_ViewReturnFormUnit,
   Order_OrderNumberInputFormUnit,
   VerificationUnit,
   avobase_registerdialogformunit,
   toolbox_orgtoolboxunit,
   toolbox_producttoolboxunit,
   Cycle_SelectOrgAndCycleFormUnit,
   Order_EditFormUnit,
   Return_EditFormUnit,
   Order_ListFormUnit,
   Report_InvoiceFormUnit,
   Report_ReturnFormUnit,
   order_invoiceobjectunit,
   Return_InvoiceObjectUnit,
   Order_TakeMethodOfPaymentEditFormUnit,
   toolbox_customertoolboxunit,
   Order_OrderSelectOrderByCustIDFormUnit,
   toolbox_PaymentToolBoxUnit,
   Payment_SelectPaymentFormUnit,
   Payment_VoidPaymentFormUnit,
   Escrow_SelectEscrowFormUnit,
   Transaction_Object,
   BackOrder_ManagerFormUnit,
   ReturnProduct_ManagerFormUnit,
   Toolbox_PreferenceToolBoxUnit,
   Toolbox_EmailToolBoxUnit,
   QuickRpt,
   Qrctrls,
   QRPDFFilt,
   QRWebFilt,
   QRExport,
   Windows,
   bde,
   db,
   dbtables,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Contnrs,
   Controls,
   Forms,
   Dialogs,
   ExtCtrls;

const
	ORDERCONTROL_ORDERLIST = 2000;
   ORDERCONTROL_ORDEREDIT = 2001;

type
   tControlForm_Order = class( tForm )
      MAIN_DOCK_PANEL: TScrollBox;
      SideBarPanelBackDrop: TPanel;
      SideBarPanel: TScrollBox;
      orderSplitter: TSplitter;
      fSave: TSaveDialog;
      //
   private
      eInvoiceUpdatedEvent : tInvoiceUpdatedEvent;
      fOrderControlListState : boolean;
      Group_Orders : tAvoBaseGroupBox;
      fOrderRefreshEvent : tOrderRefreshEvent;
      fEmailEvent : tEmailEvent;
      fOrderListEditCustomerEvent : tOrderListEditCustomerEvent;
      fEmailCycleEvent : tEmailCycleEvent;
      //
      function Create_AvoBaseGroupBox( InCaption : String ) : tAvoBaseGroupBox;
      function fGetOrderListID : string;
      function fGetOrderOrReturnOpen : boolean;
      //
      procedure OrderObjectButtonClick(Sender:Tobject);
      procedure Close_Order_Form( Sender: Tobject );
   public
   	frm_OrderList : TOrderListForm;
      frm_OrderEdit : tOrderEditForm;
      AvoBase_OrderList : tObjectList;
      //
      function tygHjehtU88jge : vEnResultRec;
      function Check_CanCreate : boolean;
      function OrderEditState( InOrderID : string ) : boolean;
      function SelectCycle : string;
      function Order_EnableDisableButtons : boolean;
      //
      procedure StartForm;
      procedure StopForm;
      procedure ShowOrderList;
      procedure DockForm(inForm: tForm; inFormType : integer);
      procedure PrintAllCycleInvoices();
      procedure EmailAllCycleInvoices();

      //
      procedure Order_New; overload;
      procedure Order_New( inCustID : string ); overload;
      procedure Order_Load( LoadOrderType : tLoadOrderTypes; inOrderID, inCustID, inCycleID : string); overload;
      procedure OrderLoadNum();
      //
      procedure Return_New();
      procedure Return_NewWithCustID( inCustID : string ); overload;
      procedure Return_Load( LoadOrderType : tLoadOrderTypes; inOrderID : string );
      procedure DBGotoID( inID : string );
      //
      procedure HandleOnTakeMethodOfPaymentEvent( inOrderID : string );
      procedure HandleOnTakeMethodOfPaymentCustomerEvent( inCustID : string );
      procedure HandleOnVoidPaymentEvent( inOrderID : string );
      procedure HandleOnReturnOrderEvent( inOrderID : string );
      procedure HandleClosedViewPrint( inOrderID : string );
      procedure HandleViewOrderAccount();
      procedure HandleCloseOrderEvent();
      procedure HandleCloseForm(Sender: TObject);
      procedure HandleOnLoadOrderEvent( sender : tObject; inOrderID : string );
      procedure HandleOnViewOrderInvoiceEvent( sender : tObject; inOrderID : string );
      procedure HandleOnPrintOrderInvoiceEvent( sender : tObject; inOrderID : string );
      procedure HandleOnFinalizeOrderInvoiceEvent( inOrderID : string );
      procedure HandleOnCancelUnCancelEventprocedure( CancelType : tCanceLtypes; InorderID : string );
      procedure HandleOnOrderListEditCustomerEvent( inCustID : string );
      procedure HandleInvoiceUpdated;
      Procedure HandleOrderRefreshEvent();
      procedure HandleVoidPaymentByCustomerID( inCustID : string );
      procedure HandleOnEmailEvent( inOrderID : string );
      //
      procedure BackOrderNotAvailable( inProdID,InBOProdID : string );
      procedure BackOrderDelivered( inProdID,InBOProdID : string );
      procedure OrderBackOrderManager();
      procedure OrderReturnManager();
      procedure OrderSaveInvoice();
      //
      procedure OrderCustomerProduct();
      //
      procedure OrderChangeCycle();
      procedure GlobalRefreshEvent();
      procedure InvoiceLineItem_TabPressed();
      //
      property OrderControlListState : boolean read fOrderControlListState write fOrderControlListState;
      property OnInvoiceUpdated : tInvoiceUpdatedEvent read eInvoiceUpdatedEvent write eInvoiceUpdatedEvent;
      property OrderListID : string read fGetOrderListID;
      property OnOrderRefreshEvent : tOrderRefreshEvent read fOrderRefreshEvent write fOrderRefreshEvent;
      property OnEmailEvent : tEmailEvent read fEmailEvent write fEmailEvent;
      property OnOrderListEditCustomerEvent : tOrderListEditCustomerEvent read fOrderListEditCustomerEvent write fOrderListEditCustomerEvent;
      property OnEmailCycle : tEmailCycleEvent read fEmailCycleEvent write fEmailCycleEvent;
      property OrderOrReturnOpen : boolean read fGetOrderOrReturnOpen;
      //
      constructor Create(AOwner: TComponent); override;
      destructor destroy; override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Destroy, Starup, Shutdown'}

constructor tControlForm_Order.Create(AOwner: TComponent);
begin
  inherited Create( aOwner );
  //
  AvoBase_OrderList := tObjectList.Create(False);
end;

destructor tControlForm_Order.destroy;
begin
   FreeAndNil(AvoBase_OrderList);
   if (frm_OrderList <> Nil) then
      frm_OrderList.Close();
   FreeAndNil(frm_OrderList);
   FreeAndNil(frm_OrderEdit);
   inherited;
end;

procedure tControlForm_Order.StartForm;
begin
	// we need to make sure that if this form is created and NO other forms are showing
	if (frm_OrderList = NIL) then
   begin
   	frm_OrderList := tOrderListForm.Create( Application);
      frm_OrderList.OnLoadOrderEvent := HandleOnLoadOrderEvent;
      frm_OrderList.OnViewOrderInvoiceEvent := HandleOnViewOrderInvoiceEvent;
      frm_OrderList.OnPrintOrderInvoiceEvent := HandleOnPrintORderInvoiceEvent;
      frm_OrderList.OnFinalizeOrderInvoiceEvent := HandleOnFinalizeOrderInvoiceEvent;
      frm_OrderList.OnTakeMethodOfPaymentEvent := HandleOnTakeMethodOfPaymentEvent;
      frm_OrderList.OnVoidPaymentEvent := HandleOnVoidPaymentEvent;
      frm_OrderList.OnCancelUnCancelOrderEvent := HandleOnCancelUnCancelEventprocedure;
      frm_OrderList.OnReturnOrderEvent := HandleOnReturnOrderEvent;
      frm_OrderLIst.OnViewOrderAccountEvent := HandleViewOrderAccount;
      frm_OrderList.OnChangeOrderCycleEvent := OrderChangeCycle;
      frm_OrderList.OnCloseOrderEvent := HandleCloseOrderEvent;
      frm_OrderList.OnEmailEvent := HandleOnEmailEvent;
      frm_OrderList.onOrderListEditCustomerEvent := HandleOnOrderListEditCustomerEvent;
      DockForm( frm_OrderList, ORDERCONTROL_ORDERLIST );
   end;

   // Create the group Box
   Group_Orders := Create_AvoBaseGroupBox('Open Orders');
   Group_Orders.ORDERS_IMAGE.Visible := True;

   // now, which one do we show? We always try to show the list, but if an EDIT is up
   if (frm_OrderList <> NIL) then
   	frm_OrderList.Show();
   if (frm_OrderEdit <> NIL) then
   	frm_OrderEdit.Show();
end;

procedure tControlForm_Order.StopForm;
begin
	if (frm_OrderList <> NIL) then
   	frm_OrderList.Close();
   if (frm_OrderEdit <> NIL) then
   begin
   	frm_OrderEdit.Show();
      frm_OrderEdit.Close();
   end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties'}

function tControlForm_Order.fGetOrderListID: string;
begin
   if ( frm_OrderList <> nil ) then
      result := frm_OrderList.ID
   else
      result := '';
end;

function tControlForm_Order.fGetOrderOrReturnOpen: boolean;
begin
   result := ( AvoBase_OrderList.Count <> 0 );
end;


{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Encryption, Registration and Key Values'}

function tControlForm_Order.tygHjehtU88jge: vEnResultRec;
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

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

// A refresh event is called
procedure tControlForm_Order.GlobalRefreshEvent;
begin
   if ( frm_OrderList <> Nil ) then
      frm_OrderList.GlobalRefreshEvent;
end;

procedure tControlForm_Order.HandleCloseOrderEvent;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 +
         #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 + #65 + #118 +
         #111 + #66 + #97 + #115 + #101 + #32 + #99 + #97 + #110 + #32 + #111 + #110 + #108 + #121 + #32 +
         #99 + #108 + #111 + #115 + #101 + #32 + #79 + #114 + #100 + #101 + #114 + #115 + #32 + #119 +
         #105 + #116 + #104 + #105 + #110 + #32 + #97 + #110 + #32 + #79 + #114 + #100 + #101 + #114 + #46);
      {Unregistered versions of AvoBase can only close Orders within an Order.}
      Exit;
   end;
   HandleOnFinalizeOrderInvoiceEvent( frm_OrderList.ID );
end;

procedure tControlForm_Order.HandleCloseForm(Sender: TObject);
begin
	case tForm(Sender).Tag of
   	ORDERCONTROL_ORDERLIST: frm_OrderList := Nil;
   end;
end;

procedure tControlForm_Order.HandleInvoiceUpdated;
begin
   // this form can't handle that an invoice was updated. this kind of event is only to notify the
   // mainform_control that an invoice was updated, and to cascade upwards to any particular open form
   // to recalculate grids and so forth.
   if Assigned(eInvoiceUpdatedEvent) then
      eInvoiceUpdatedEvent();
end;

procedure tControlForm_Order.DockForm(inForm: tForm; inFormType : integer);
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

// Load Order, but it came from somewhere else and we have the ID
procedure tControlForm_Order.HandleOnFinalizeOrderInvoiceEvent( inOrderID: string);
var
   errRec : tErrorResult;
   orderInvoice : tInvoice;
   returnInvoice : tReturnInvoice;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 +
         #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 + #65 + #118 +
         #111 + #66 + #97 + #115 + #101 + #32 + #99 + #97 + #110 + #32 + #111 + #110 + #108 + #121 + #32 +
         #99 + #108 + #111 + #115 + #101 + #32 + #79 + #114 + #100 + #101 + #114 + #115 + #32 + #119 +
         #105 + #116 + #104 + #105 + #110 + #32 + #97 + #110 + #32 + #79 + #114 + #100 + #101 + #114 + #46);
      {Unregistered versions of AvoBase can only close Orders within an Order.}
      Exit;
   end;
   if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeOrder ) then
   begin
      if ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusDelinquent ) then
      begin
         if AvoBaseDialog('Mark Delinquency Closed',
            'By marking a Delinquency Closed you acknowledge that you have processed all transactions on ' +
            'the Order. This is regardless of whether full payments have been made.\n\n' +
            'Are you sure you want to Close this Delinquency?', mtConfirmation, [mbyes, mbno], 0) = mbYes then
               Order_CloseDelinquentOrder( inOrderID );
      end else
         begin
            orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
            errRec := orderInvoice.Load( inOrderID );
            if (NOT errRec.errorResult) then
            begin
               errRec := orderInvoice.Finalize;
               if ( NOT errRec.errorResult ) then
                  if AvoBaseDialog('Print Final Invoice','Do you wish to View/Print a final Invoice for this Order?', mtInformation, [mbyes, mbno], 0) = mbYes then
                     HandleOnViewOrderInvoiceEvent( Self, inOrderID );
            end else
               Error_Log( errRec, true );
            FreeAndNil( orderInvoice);
         end;
      if Assigned(eInvoiceUpdatedEvent) then
         eInvoiceUpdatedEvent();
   end;
   if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeReturn ) then
   begin
      returnInvoice := tReturnInvoice.Create( InvoiceTypeReport, NIL, NIL);
      errRec := returnInvoice.Load( inOrderID );
      if (NOT errRec.errorResult) then
      begin
         errRec := returnInvoice.Finalize;
         if ( NOT errRec.errorResult ) then
            if AvoBaseDialog('Print Final Invoice','Do you wish to View/Print a final Invoice for this Return?', mtInformation, [mbyes, mbno], 0) = mbYes then
               HandleOnViewOrderInvoiceEvent( Self, inOrderID );
      end else
         Error_Log( errRec, true );
      FreeAndNil( returnInvoice);
      if Assigned(eInvoiceUpdatedEvent) then
         eInvoiceUpdatedEvent();
   end;
end;

procedure tControlForm_Order.HandleOnLoadOrderEvent(sender: tObject; inOrderID: string);
begin
   if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeOrder ) then
      Order_Load( tLoadOrderTypes.LoadOrderTypeLoadOrder, inOrderID, '', '' );
   if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeReturn ) then
      Return_Load( tLoadOrderTypes.LoadOrderTypeLoadOrder, inOrderID );
end;

// We are being told to print an invoice
procedure tControlForm_Order.HandleOnPrintOrderInvoiceEvent( sender: tObject; inOrderID: string);
var
   invoiceReport : tReport_InvoiceForm;
   returnReport : tReport_Return;
begin
   if (OrderEditState( inOrderID)) then
   begin
      AvoBaseDialog('Order Print', 'Order #' + Order_GetOrderNumberByOrderID(inOrderID) + ' is currently being edited.' + #13 + #13 +
         'You cannot print an Order while the Order is in an editing state.' + #13 + #13 +
         'Save and close the Order first.', mtconfirmation, [mbOK], 0);
   end else
      begin
         if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeOrder ) then
         begin
            invoiceReport := tReport_InvoiceForm.create( Application, inOrderID );
            invoiceReport.QReport.Print();
            FreeAndNil(invoiceReport);
         end;
         if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeReturn ) then
         begin
            returnReport := tReport_Return.create( Application, inOrderID );
            returnReport.QReport.Print();
            if (invoiceReport <> NIL) then
               FreeAndNil(returnReport);
         end;
      end;
end;

// we are being told to view an invoice
procedure tControlForm_Order.HandleOnViewOrderInvoiceEvent(sender: tObject; inOrderID: string);
var
   invoiceReport : tReport_InvoiceForm;
   returnReport : tReport_Return;
begin
   if (OrderEditState( inOrderID)) then
   begin
      AvoBaseDialog('Unable To View', 'Order/Return #' + Order_GetOrderNumberByOrderID(inOrderID) + ' is currently being edited.' + #13 + #13 +
         'You cannot view an Order while the Order/Return is in an editing state.' + #13 + #13 +
         'Save and close the Order/Return first.', mtconfirmation, [mbOK], 0);
   end else
      begin
         if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeOrder ) then
         begin
            invoiceReport := tReport_InvoiceForm.create( Application, inOrderID );
            invoiceReport.QReport.Preview();
            if (invoiceReport <> NIL) then
               FreeAndNil(invoiceReport);
         end;
         if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeReturn ) then
         begin
            returnReport := tReport_Return.create( Application, inOrderID );
            returnReport.QReport.Preview();
            if (invoiceReport <> NIL) then
               FreeAndNil(returnReport);
         end;
      end;
end;

// we are inside an invoice/return, but we want to print anyway. we must assume we're saved first.
procedure tControlForm_Order.HandleClosedViewPrint(inOrderID: string);
var
   invoiceReport : tReport_InvoiceForm;
   returnReport : tReport_Return;
begin
   if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeOrder ) then
   begin
      invoiceReport := tReport_InvoiceForm.create( Application, inOrderID );
      invoiceReport.QReport.Preview();
      if (invoiceReport <> NIL) then
         FreeAndNil(invoiceReport);
   end;
   if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeReturn ) then
   begin
      returnReport := tReport_Return.create( Application, inOrderID );
      returnReport.QReport.Preview();
      if (invoiceReport <> NIL) then
         FreeAndNil(returnReport);
   end;
end;

procedure tControlForm_Order.HandleOnOrderListEditCustomerEvent( inCustID: string);
begin
   if Assigned( fOrderListEditCustomerEvent ) then
      fOrderListEditCustomerEvent( inCustID );
end;

procedure tControlForm_Order.HandleOrderRefreshEvent;
begin
   if Assigned( fOrderRefreshEvent ) then
      fOrderRefreshEvent();
end;

procedure tControlForm_Order.HandleViewOrderAccount;
var
   orderInvoice : tInvoice;
   returnInvoice : tReturnInvoice;
begin
   case Order_GetOrderTypeByOrderID( frm_orderList.ID ) of
      OrdTypeOrder:
      begin
         orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
         orderInvoice.Load( frm_OrderList.ID );
         OrderViewOrder('View Order', 'Viewing Order.', mtInformation, [mbOK], orderInvoice);
         freeandnil( orderInvoice);
      end;
      OrdTypeReturn:
      begin
         returnInvoice := treturnInvoice.Create( InvoiceTypeReport, NIL, NIL);
         returnInvoice.Load( frm_OrderList.ID );
         ReturnViewReturn('View Return', 'Viewing Return.', mtInformation, [mbOK], returnInvoice);
         freeandnil( returnInvoice);
      end;
   end;
end;

procedure tControlForm_Order.HandleVoidPaymentByCustomerID( inCustID: string);
var
   custOrdSelectForm : tOrderSelectOrderByCustIDForm;
begin
   custOrdSelectForm := tOrderSelectOrderByCustIDForm.Create( Application, inCustID, OrderStatusOpen, 'Select Order', true);
   try
      custOrdSelectForm.ShowModal;
      if ( custOrdSelectForm.FormResult = mrOk ) then
      begin
         HandleOnVoidPaymentEvent(custOrdSelectForm.OrderID);
      end;
   finally
      FreeAndNil(custOrdSelectForm);
   end;
end;

procedure tControlForm_Order.InvoiceLineItem_TabPressed;
begin
   // This is handled already, so we don't have to do anything. MainForm "inherited" does not fire.
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Button Clicks'}

procedure tControlForm_Order.OrderObjectButtonClick(Sender: Tobject);
var
   ordCount : integer;
   WorkOrd : String;
   WorkBtnOrd : String;
begin
   for ordCount := 0 to AvoBase_OrderList.Count -1 do
   begin
      if (AvoBase_OrderList.Items[ordCount].ClassType = tOrderEditForm) then
      begin
         WorkOrd := (AvoBase_OrderList.Items[ordCount] AS tOrderEditForm).OrderID;
         WorkBtnOrd := (Sender AS tAvoBaseBitButton).OrderID;
         if (WorkOrd = WorkBtnOrd) then
         begin
            (AvoBase_OrderList.Items[ordCount] AS tOrderEditForm).Show;
            fOrderControlListState := false;
         end;
      end;
      if (AvoBase_OrderList.Items[ordCount].ClassType = tReturnEditForm) then
      begin
         WorkOrd := (AvoBase_OrderList.Items[ordCount] AS tReturnEditForm).OrderID;
         WorkBtnOrd := (Sender AS tAvoBaseBitButton).OrderID;
         if (WorkOrd = WorkBtnOrd) then
         begin
            (AvoBase_OrderList.Items[ordCount] AS tReturnEditForm).Show;
            fOrderControlListState := false;
         end;
      end;
   end;
end;

{$ENDREGION}


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Methods and Functions'}

function tControlForm_Order.Check_CanCreate: boolean;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if ( Customer_GetCustomerCount = 0 ) then
   	errMsg := 'You must first create at least one Customer.';
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

// This method determines if the main form buttons should be ON or OFF
function tControlForm_Order.Order_EnableDisableButtons: boolean;
begin
   result := true;
   if ( frm_OrderList.OrderRecCount = 0 ) then
      result := false;
///   if ( org_getOrgC
end;

procedure tControlForm_Order.Close_Order_Form(Sender: Tobject);
var
  WorkNum : String;
  X : Integer;
  FormObject : tOrderEditForm;
  Temp : tComponent;
  TagVar : Integer;
  delOrderID : string;
begin
	if AvoBase_OrderList <> NIL then
   begin

      PercentForm_Create('One Moment Please...', 0, 0);
      // Determine which one to use
      if ( Sender IS tOrderEditForm) then
      begin
      	WorkNum := (Sender AS tOrderEditForm).OrderID;
         (Sender AS tOrderEditForm).Hide;
      end;
      if ( Sender IS tReturnEditForm ) then
      begin
         WorkNum := (Sender AS tReturnEditForm).OrderID;
         (Sender AS tReturnEditForm).Hide;
      end;
      //

      Application.ProcessMessages();
      //
      for X := AvoBase_OrderList.Count - 1 downto 0 do
      begin
      	// Gotta set WorkNum

         if (AvoBase_OrderList.Items[X] IS tOrderEditForm) then
            delOrderID := (AvoBase_OrderList.Items[X] AS tOrderEditForm).OrderID;

         if (AvoBase_OrderList.Items[X] IS tReturnEditForm) then
            delOrderID := (AvoBase_OrderList.Items[X] AS tReturnEditForm).OrderID;

         //
			if ( delOrderID = WorkNum ) then
         begin
         	AvoBase_OrderList.Delete(X);
            AvoBase_OrderList.Pack();
         	Break;
         end;
      end;

      // Now we free the associated button on the SideBarPanel
      For X := Group_Orders.DockPanel.ComponentCount - 1 DownTo 0 do
      begin
      	Temp := Group_Orders.DockPanel.Components[ X ];
         if ( tAvoBaseBitButton(Temp).OrderID = WorkNum ) then
         begin
         	TagVar := Group_Orders.Height;
            Dec(TagVar, tAvoBaseBitButton(Temp).Height);
            Dec(TagVar, Group_Orders.AVO_GROUPBOX_ADDHEIGHT);
            Group_Orders.Height := TagVar;
            Temp.Free;
         end;
      end;

      // Now Visible
      if ( Group_Orders.DockPanel.ComponentCount -1 = -1 ) then
         Group_Orders.Hide;

      // show the list, not another order
      if (frm_OrderList <> NIL) then
      begin
      	frm_OrderList.Show();
//         Frm_OrderList.RefreshOrderList( WorkNum );
         fOrderControlListState := true;
         frm_OrderList.DBGotoID( WorkNum );
      end;

      // shout out an event
      if Assigned( fOrderRefreshEvent ) then
         fOrderRefreshEvent();
      //
      PercentForm_Free();
  end;
end;

Function tControlForm_Order.Create_AvoBaseGroupBox( InCaption : String ) : tAvoBaseGroupBox;
begin
   Result := tAvoBaseGroupBox.Create(SideBarPanel);
   Result.ManualDock(SideBarPanel);
   Result.HEADER_PANEL.Caption := InCaption;
   Result.Align := alTop;
   Result.Visible := False;
   Result.OnClick := OrderObjectButtonClick;
   Result.Tag := 0; { # of Objects }
   Result.Cursor := crHandPoint;
   Result.Height := Result.AVO_GROUPBOX_INITHEIGHT;
   Result.FORM_CONST := 0;
end;

procedure tControlForm_Order.DBGotoID(inID: string);
begin
   if (frm_OrderList <> NIL) then
   begin
      frm_OrderList.Show();
      fOrderControlListState := true;
      frm_OrderList.DBGotoID( inID );
   end;
end;

procedure tControlForm_Order.ShowOrderList;
begin
   if (frm_OrderList <> NIL) then
   begin
      frm_OrderList.Show();
      fOrderControlListState := true;
   end;
{
   if (AvoBase_OrderList.Count <> 0) then
   	noOrderPanel.Visible := true
   else
   	noOrderPanel.Visible := false;
}
end;

function tControlForm_Order.OrderEditState( InOrderID : string ) : boolean;
var
   ordCount : integer;
   WorkOrd : String;
   WorkOrdNum : string;
begin
   result := false;
   //
   for ordCount := 0 to AvoBase_OrderList.Count -1 do
      if AvoBase_OrderList.Items[ordCount].ClassType = tOrderEditForm then
      begin
         WorkOrd := (AvoBase_OrderList.Items[ordCount] AS tOrderEditForm).OrderID;
         WorkOrdNum := (AvoBase_OrderList.Items[ordCount] AS tOrderEditForm).orderInvoice.Order_GetOrderNumberName;
         if (WorkOrd = inOrderID) then
            result := true;
      end;
end;

function tControlForm_Order.SelectCycle() : string;
var
   CycleViewForm : TOrgSelectOrgAndCycleForm;
   CycleID : string;
begin
   CycleID := '';
   //
   CycleViewForm := TOrgSelectOrgAndCycleForm.Create( Application );
   try
      CycleViewForm.ShowModal;
      if (CycleViewForm.FormResult = mrOk) then
         CycleID := CycleViewForm.CycleID;
   finally
      FreeAndNil(CycleViewForm);
   end;
   //
   result := CycleID;
end;

procedure tControlForm_Order.OrderLoadNum;
var
   ordNum : string;
   ordID : string;
begin
   ordNum := Order_GetOrderNumberInputForm( 'Load Order By Order Number' );
   if ( ordNum <> '' ) then
   begin
      ordID := Order_GetOrderIDByOrderNumber( ordNum );
      if ( ordID <> '' ) then
         Order_Load( tLoadOrderTypes.LoadOrderTypeLoadOrder, ordID, '', '' )
      else
      	AvoBaseDialog('Unable To Locate Order','AvoBase was unable to locate Order # ' + ordNum + '.', mtError, [mbOk], 0);
   end;
end;

procedure tControlForm_Order.HandleOnEmailEvent(inOrderID: string);
begin
   if Assigned(fEmailEvent) then
      fEmailEvent( inOrderID );
end;

procedure tControlForm_Order.OrderSaveInvoice;
var
   invoiceReport : tReport_InvoiceForm;
   returnReport : tReport_Return;
   ordType : string;
   fPrevDir : string;
   fileName : string;
   orgID : string;
begin
   { do not allow unregistered, but allow registered-expired }
   if ( tygHjehtU88jge.noKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#79 + #110 + #108 + #121 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 +
         #101 + #100 + #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 + #65 +
         #118 + #111 + #66 + #97 + #115 + #101 + #32 + #99 + #97 + #110 + #32 + #115 + #97 + #118 + #101 + #32 +
         #97 + #110 + #32 + #73 + #110 + #118 + #111 + #105 + #99 + #101 + #32 + #80 + #68 + #70 + #46);
      {Only Registered versions of AvoBase can save an Invoice PDF.}
      Exit;
   end;
	if (frm_OrderList <> NIL) then
   	if ( frm_OrderList.ID <> '' ) then
   begin
   	orgID := Order_GetOrgIDByOrderID( frm_OrderList.ID );
      if ( Order_GetOrderTypeByOrderID( frm_OrderList.ID ) = OrdTypeOrder ) then
         ordType := 'Invoice';
      if ( Order_GetOrderTypeByOrderID( frm_OrderList.ID ) = ordTypeReturn ) then
         ordType := 'Return';
   	fileName := Org_GetOrgNameByOrgID( orgID ) + ordType + Order_GetOrderNumberByOrderID( frm_OrderList.ID ) + '.PDF';
      fPrevDir := AvoINIReadString(AVOBASE_NAME, 'OrderSaveInvoice', '');
      fSave.InitialDir := fPrevDir;
      fSave.FileName := fileName;
      if (fSave.Execute()) then
      begin
         fPrevDir := ExtractFilePath(fSave.FileName);
         AvoINIWriteString( AVOBASE_NAME, 'OrderSaveInvoice', fPrevDir );
         if ( Order_GetOrderTypeByOrderID( frm_OrderList.ID ) = OrdTypeOrder ) then
         begin
            invoiceReport := tReport_InvoiceForm.create( Application, frm_OrderList.ID );
            try
               invoiceReport.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
            finally
               FreeAndNil(invoiceReport);
            end;
         end;
         if ( Order_GetOrderTypeByOrderID( frm_OrderList.ID ) = ordTypeReturn ) then
         begin
            returnReport := tReport_Return.create( Application, frm_OrderList.ID );
            try
               returnReport.QReport.ExportToFilter(TQRPDFDocumentFilter.Create( fSave.FileName ));
            finally
               FreeAndNil(returnReport);
            end;
         end;
      end;
   end;
end;

procedure tControlForm_Order.OrderCustomerProduct;
begin
   showmessage('We are now to dock this and get going.');
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'ORDERS - New, Edit, Save, Delete'}

// Straight up New Order Button
procedure tControlForm_Order.Order_New;
var
   CycleID : string;
   OrgID : string;
begin
   (*
   if ( Order_GetOrderCount > 312 ) and ( tygHjehtU88jge.noKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog( #89 + #111 + #117 + #32 + #104 + #97 + #118 + #101 + #32 + #101 +
         #120 + #99 + #101 + #101 + #100 + #101 + #100 + #32 + #116 + #104 + #101 + #32 + #110 +
         #117 + #109 + #98 + #101 + #114 + #32 + #111 + #102 + #32 + #79 + #114 + #100 + #101 +
         #114 + #115 + #32 + #111 + #114 + #32 + #82 + #101 + #116 + #117 + #114 + #110 + #115 +
         #32 + #121 + #111 + #117 + #32 + #99 + #97 + #110 + #32 + #104 + #97 + #118 + #101 +
         #32 + #105 + #110 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #46 + #32 +
         #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #105 + #110 + #103 + #32 +
         #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #97 + #108 + #108 + #111 +
         #119 + #115 + #32 + #121 + #111 + #117 + #32 + #116 + #111 + #32 + #104 + #97 +
         #118 + #101 + #32 + #97 + #110 + #32 + #117 + #110 + #108 + #105 + #109 + #105 +
         #116 + #101 + #100 + #32 + #110 + #117 + #109 + #98 + #101 + #114 + #32 + #111 +
         #102 + #32 + #79 + #114 + #100 + #101 + #114 + #115 + #32 + #97 + #110 + #100 +
         #32 + #82 + #101 + #116 + #117 + #114 + #110 + #115 + #46);
         {You have exceeded the number of Orders or Returns you can have in AvoBase. Unregistered versions of
         AvoBase are limited at 300. Registering AvoBase allows you to have unlimited Orders.}
      Exit;
    end;
    *)
   if ( Check_CanCreate ) then
   begin
      CycleID := SelectCycle();
      //
      if (CycleID <> '') then
         if ( Cycle_GetCycleEndDateByCycleID( CycleID) < NOW ) then
         begin
            OrgID := Cycle_GetOrgIDByCycleID( CycleID );
            if AvoBaseDialog('Sales Cycle ' + Cycle_GetCycleNameByCycleID( CycleID ) + ' Expired',
               Org_GetOrgNameByOrgID( orgID ) + ' Sales Cycle ' + Cycle_GetCycleNameByCycleID( CycleID ) +
               ' expired on ' + DateToStr( Cycle_GetCycleEndDateByCycleID( CycleID) ) + '.' +
               #13 + #13 + 'Are you sure you want to use this Sales Cycle?', mtWarning, [mbYes, mbNo], 0) = mbNo then
                  CycleID := '';
         end;
      if (CycleID <> '') then
         Order_Load( LoadOrderTypeNewOrder, '', '', CycleID);
   end;
end;

// New order but passing a Customer ID
procedure tControlForm_Order.Order_New(inCustID: string);
var
   CycleID : string;
   OrgID : string;
begin
   if ( Order_GetOrderCount > 105 ) and ( tygHjehtU88jge.noKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog( #89 + #111 + #117 + #32 + #104 + #97 + #118 + #101 + #32 + #101 +
         #120 + #99 + #101 + #101 + #100 + #101 + #100 + #32 + #116 + #104 + #101 + #32 + #110 +
         #117 + #109 + #98 + #101 + #114 + #32 + #111 + #102 + #32 + #79 + #114 + #100 + #101 +
         #114 + #115 + #32 + #111 + #114 + #32 + #82 + #101 + #116 + #117 + #114 + #110 + #115 +
         #32 + #121 + #111 + #117 + #32 + #99 + #97 + #110 + #32 + #104 + #97 + #118 + #101 +
         #32 + #105 + #110 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #46 + #32 +
         #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #105 + #110 + #103 + #32 +
         #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #97 + #108 + #108 + #111 +
         #119 + #115 + #32 + #121 + #111 + #117 + #32 + #116 + #111 + #32 + #104 + #97 +
         #118 + #101 + #32 + #97 + #110 + #32 + #117 + #110 + #108 + #105 + #109 + #105 +
         #116 + #101 + #100 + #32 + #110 + #117 + #109 + #98 + #101 + #114 + #32 + #111 +
         #102 + #32 + #79 + #114 + #100 + #101 + #114 + #115 + #32 + #97 + #110 + #100 +
         #32 + #82 + #101 + #116 + #117 + #114 + #110 + #115 + #46);
         {You have exceeded the number of Orders or Returns you can have in AvoBase.
         Registering AvoBase allows you to have an unlimited number of Orders and Returns.}
      Exit;
    end;
   if ( Check_CanCreate ) then
   begin
      CycleID := SelectCycle();
      //
      if (CycleID <> '') then
         if ( Cycle_GetCycleEndDateByCycleID( CycleID) < NOW ) then
         begin
            OrgID := Cycle_GetOrgIDByCycleID( CycleID );
            if AvoBaseDialog('Sales Cycle ' + Cycle_GetCycleNameByCycleID( CycleID ) + ' Expired',
               Org_GetOrgNameByOrgID( orgID ) + ' Sales Cycle ' + Cycle_GetCycleNameByCycleID( CycleID ) +
               ' expired on ' + DateToStr( Cycle_GetCycleEndDateByCycleID( CycleID) ) + '.' +
               #13 + #13 + 'Are you sure you want to use this Sales Cycle?', mtWarning, [mbYes, mbNo], 0) = mbNo then
                  CycleID := '';
         end;
      //
      if (CycleID <> '') then
         Order_Load( LoadOrderTypeNewOrder, '', inCustID, CycleID);
   end;
end;

procedure tControlForm_Order.Order_Load( LoadOrderType : tLoadOrderTypes; inOrderID, inCustID, inCycleID : string);
var
   fOrderID : string;
   fOrgID : string;
   ObjCount : Integer;
   MenuBitButton : tAvoBaseBitButton;
   MenuBitMap : tBitMap;
   ObjOrderNum : String;
   TagVar : integer;
   OrderFormObject : tOrderEditForm;
   fNewOrderNum : integer;
begin
   PercentForm_Create('Processing Order - One Moment Please...', 0, 0);

   //
   fOrderID := inOrderID;

   // ==================================================================================/
   // AvoBase_OrderList tracks all open orders
   if (AvoBase_Orderlist = NIL) then
      AvoBase_OrderList := tObjectList.Create(False);

   // ==================================================================================/
   //

	{ REGISTRATION | Cannot have more than 312 orders in the system unless they have PREVIOUSLY registered }
   if ( LoadOrderType = LoadOrderTypeNewOrder ) then
      if ( Order_GetOrderCount > 300 ) and ( tygHjehtU88jge.noKey ) then
      begin
         PercentForm_Free();
         AvoBaseRegisterDialog( #89 + #111 + #117 + #32 + #104 + #97 + #118 + #101 + #32 + #101 +
         #120 + #99 + #101 + #101 + #100 + #101 + #100 + #32 + #116 + #104 + #101 + #32 + #110 +
         #117 + #109 + #98 + #101 + #114 + #32 + #111 + #102 + #32 + #79 + #114 + #100 + #101 +
         #114 + #115 + #32 + #111 + #114 + #32 + #82 + #101 + #116 + #117 + #114 + #110 + #115 +
         #32 + #121 + #111 + #117 + #32 + #99 + #97 + #110 + #32 + #104 + #97 + #118 + #101 +
         #32 + #105 + #110 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #46 + #32 +
         #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #105 + #110 + #103 + #32 +
         #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #97 + #108 + #108 + #111 +
         #119 + #115 + #32 + #121 + #111 + #117 + #32 + #116 + #111 + #32 + #104 + #97 +
         #118 + #101 + #32 + #97 + #110 + #32 + #117 + #110 + #108 + #105 + #109 + #105 +
         #116 + #101 + #100 + #32 + #110 + #117 + #109 + #98 + #101 + #114 + #32 + #111 +
         #102 + #32 + #79 + #114 + #100 + #101 + #114 + #115 + #32 + #97 + #110 + #100 +
         #32 + #82 + #101 + #116 + #117 + #114 + #110 + #115 + #46);
            {You have exceeded the number of Orders or Returns you can have in AvoBase. Unregistered versions of
            AvoBase are limited at 300. Registering AvoBase allows you to have unlimited Orders.}
         Exit;
       end;

   // TEMPORARILY REMOVED THIS SECTION AND YOU CAN LOAD CLOSED ORDERS

   if (LoadOrderType = LoadOrderTypeLoadOrder) then
      if (Order_GetOrderStatusByOrderID( fOrderID ) = OrderStatusClosed) OR
      (Order_GetOrderStatusByOrderID( fOrderID ) = OrderStatusCancelled) OR
		(Order_GetOrderStatusByOrderID( fOrderID ) = OrderStatusDelinquent) then
      begin
         PercentForm_Free();
         if AvoBaseDialog('Unable to Load Order',
            'Order # ' + Order_GetOrderNumberByOrderID( inOrderID ) + ' is not Open. You can only load Open Orders.\n\n' +
            'Would you like to view this Order?', mtInformation, [mbyes, mbno], 0) = mbyes then
         HandleOnViewOrderInvoiceEvent( Self, inOrderID);
         Exit;
      end;

   // ==================================================================================/
   // Pack the OrderList
   AvoBase_OrderList.Pack;

   //
   if ( LoadOrderType = LoadOrderTypeNewOrder ) then
   begin
   	fOrderID := masterData.NewDBGuid;
      fOrgID := Cycle_GetOrgIDByCycleID( inCycleID );
   end;

   // ==================================================================================/
   // Check the Object List to make sure the order # hasn't already been assigned
   for ObjCount := 0 to AvoBase_OrderList.Count -1 do
   begin
      if (AvoBase_OrderList.Items[ObjCount] IS tOrderEditForm) then
         ObjOrderNum := (AvoBase_OrderList.Items[ObjCount] AS tOrderEditForm).OrderID;
      if (ObjOrderNum = fOrderID) then
      begin
         (AvoBase_OrderList.Items[ObjCount] AS tOrderEditForm).Show;
         fOrderControlListState := false;
         PercentForm_Free();
         Exit;
      end;
   end;

   // ==================================================================================/
   // ok, now we validate how many open orders they have at the same time

   // ==================================================================================/
   // now we validate if they are registered or not, and if not, they can't have X number of orders

   // ==================================================================================/
   // create a BitButton
   MenuBitButton := Nil;
   MenuBitButton := tAvoBaseBitButton.Create(Group_Orders.DockPanel);
   MenuBitButton.ManualDock(Group_Orders.DockPanel);
   MenuBitButton.Align := alBottom;
   MenuBitButton.Visible := True;
   MenuBitButton.OnClick := OrderObjectButtonClick;
   MenuBitButton.Cursor := crHandPoint;
   MenuBitButton.Height := MenuBitButton.AVOBASE_ORDER_BUTTON_NEIGHT;

   // ==================================================================================/
   // Create Bitmap and assign it to it
   MenuBitMap := tBitMap.Create;
   try
     IMG_StorageForm.AvoBase_25x25_Images.GetBitmap(52, MenuBitMap);
     MenuBitButton.Glyph.Assign(MenuBitMap);
   finally
     FreeAndNil(MenuBitMap);
   end;

   // ==================================================================================/
   // Setup the ORDERS_GROUP to place the order on it
   TagVar := Group_Orders.Tag;
   Inc(TagVar);
   Group_Orders.Tag := TagVar;
   TagVar := Group_Orders.Height;
   Inc(TagVar, MenuBitButton.Height + Group_Orders.AVO_GROUPBOX_ADDHEIGHT);
   Group_Orders.Height := TagVar;
   Group_Orders.Visible := True;

   // ==================================================================================/
   // Now we show our button
   MenuBitButton.Show;
   MenuBitButton.Align := alTop;

   // ==================================================================================/
   // Now we have to create the Order Form Object and make it our bitch

   case LoadOrderType of
      LoadOrderTypeLoadOrder :
      begin
         OrderFormObject := tOrderEditForm.Create;
         OrderFormObject.orderInvoice.Load( fOrderID );
         orderFormObject.Check_Customer_Escrow();
         OrderFormObject.OnViewInvoiceEvent := HandleOnViewOrderInvoiceEvent;
         OrderFormObject.OnFinalizeViewPrint := HandleClosedViewPrint;
         OrderFormObject.Order_Message := OrderFormObject.orderInvoice.Order_Message;
         MenuBitButton.OrderID := OrderFormObject.orderInvoice.Order_ID;
      end;
      LoadOrderTypeNewOrder :
      begin
         OrderFormObject := tOrderEditForm.Create;
         OrderFormObject.orderInvoice.New( fOrderID, fOrgID, inCycleID, inCustID );
         OrderFormObject.orderInvoice.Order_SetOrderNumber( fNewOrderNum );
         orderFormObject.Check_Customer_Escrow();
         OrderFormObject.OnViewInvoiceEvent := HandleOnViewOrderInvoiceEvent;
         OrderFormObject.OnFinalizeViewPrint := HandleClosedViewPrint;
         OrderFormObject.Order_Message := Cycle_GetCycleMessageByCycleID( inCycleID );
         MenuBitButton.OrderID := OrderFormObject.orderInvoice.Order_ID;
         // Now we have to set the Order Number
         fNewOrderNum := Order_GetNextOrderNumber();
         for ObjCount := 0 to AvoBase_OrderList.Count -1 do
         begin
            if (AvoBase_OrderList.Items[ObjCount] IS tOrderEditForm) then
               if (( AvoBase_OrderList.Items[ObjCount] AS tOrderEditForm).OrderNumber = fNewOrderNum ) then
                  inc(fNewOrderNum);
            if (AvoBase_OrderList.Items[ObjCount] IS tReturnEditForm) then
               if (( AvoBase_OrderList.Items[ObjCount] AS tReturnEditForm).OrderNumber = fNewOrderNum ) then
                  inc(fNewOrderNum);
         end;
         //
         OrderFormObject.orderInvoice.Order_SetOrderNumber( fNewOrderNum );

      end;
   end;

   // ==================================================================================/
   // Setup all EVENTS
   OrderFormObject.OnDestroy := Close_Order_Form;
   OrderFormObject.OnInvoiceUpdated := HandleInvoiceUpdated;

   // ==================================================================================/
   // Position, Size, Clarity, Monstrosity, Vulgarity
   OrderFormObject.ManualDock(MAIN_DOCK_PANEL, nil, alClient);
   OrderFormObject.BorderStyle := bsNone;
   OrderFormObject.Left := (Self.Width - MAIN_DOCK_PANEL.Width) div 2;
   OrderFormObject.Top := (Self.Height - MAIN_DOCK_PANEL.Height) div 2;
   OrderFormObject.WindowState := wsMaximized;
   OrderFormObject.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
   OrderFormObject.BorderIcons := [];
   OrderFormObject.Position := poDefault;

   // ==================================================================================/
   // Now Show It
   OrderFormObject.Show;
   fOrderControlListState := false;

   // ==================================================================================/
   // Assign it into the Object List so it can be baby sat whislt we go and play poker
   AvoBase_OrderList.Add(OrderFormObject);

   // ==================================================================================/
   // Set the Caption on our Button
   MenuBitButton.Caption := OrderFormObject.orderInvoice.Org_GetOrgName + #13 +
      OrderFormObject.orderInvoice.Order_GetOrderTypeName  + #13 + '#' + OrderFormObject.orderInvoice.Order_GetOrderNumberName;

   // ==================================================================================/
   // Assign the Edit for anything we might need like if they are loading.
   OrderFormObject.InvoiceMessage := OrderFormObject.orderInvoice.Order_Message;

   // ==================================================================================/
   // Finished
   Application.Processmessages;
   //
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'RETURNS - New, Edit, Save, Delete'}

procedure tControlForm_Order.Return_Load(LoadOrderType: tLoadOrderTypes; inOrderID: string);
var
   fOrderID : string;
   fOrgID : string;
   ObjCount : Integer;
   MenuBitButton : tAvoBaseBitButton;
   MenuBitMap : tBitMap;
   ObjOrderNum : String;
   TagVar : integer;
   ReturnFormObject : tReturnEditForm;
   fNewOrderNum : integer;
begin
   PercentForm_Create('Processing Return - One Moment Please...', 0, 0);
   //
   fOrderID := inOrderID;
   // ==================================================================================/
   // AvoBase_OrderList tracks all open orders
   if (AvoBase_Orderlist = NIL) then
      AvoBase_OrderList := tObjectList.Create(False);
   // ==================================================================================/

   //
   if (LoadOrderType = LoadOrderTypeLoadOrder) then
   begin
      if (Order_GetOrderStatusByOrderID( fOrderID ) = OrderStatusClosed) OR (Order_GetOrderStatusByOrderID( fOrderID ) = OrderStatusCancelled) then
      begin
         PercentForm_Free();
{
         AvoBaseDialog('Load Order','You cannot load a Cancelled or Closed Order. \n\n' +
            'If the Order is Cancelled you must un-Cancel it first. \n\n' +
            'Closed Orders can only be Viewed or Printed.', mtInformation, [mbOK], 0);
         Exit;
}
         if AvoBaseDialog('Unable to Load Return',
            'Return # ' + Order_GetOrderNumberByOrderID( inOrderID ) + ' is not Open. You can only load Open Returns.\n\n' +
            'Would you like to view this Return?', mtInformation, [mbyes, mbno], 0) = mbyes then
         HandleOnViewOrderInvoiceEvent( Self, inOrderID);
         Exit;
      end;
   end;

   // ==================================================================================/
   // Pack the OrderList
   AvoBase_OrderList.Pack;

   // ==================================================================================/
   // Check the Object List to make sure the order # hasn't already been assigned
   for ObjCount := 0 to AvoBase_OrderList.Count -1 do
   begin
      if (AvoBase_OrderList.Items[ObjCount] IS tReturnEditForm) then
         ObjOrderNum := (AvoBase_OrderList.Items[ObjCount] AS tReturnEditForm).OrderID;
      if (ObjOrderNum = fOrderID) then
      begin
         (AvoBase_OrderList.Items[ObjCount] AS tReturnEditForm).Show;
         fOrderControlListState := false;
         PercentForm_Free();
         Exit;
      end;
   end;

   // ==================================================================================/
   // ok, now we validate how many open orders they have at the same time

   // ==================================================================================/
   // now we validate if they are registered or not, and if not, they can't have X number of orders

   // ==================================================================================/
   // create a BitButton
   MenuBitButton := Nil;
   MenuBitButton := tAvoBaseBitButton.Create(Group_Orders.DockPanel);
   MenuBitButton.ManualDock(Group_Orders.DockPanel);
   MenuBitButton.Align := alBottom;
   MenuBitButton.Visible := True;
   MenuBitButton.OnClick := OrderObjectButtonClick;
   MenuBitButton.Cursor := crHandPoint;
   MenuBitButton.Height := MenuBitButton.AVOBASE_ORDER_BUTTON_NEIGHT;

   // ==================================================================================/
   // Create Bitmap and assign it to it
   MenuBitMap := tBitMap.Create;
   try
     IMG_StorageForm.AvoBase_25x25_Images.GetBitmap(51, MenuBitMap);
     MenuBitButton.Glyph.Assign(MenuBitMap);
   finally
     FreeAndNil(MenuBitMap);
   end;

   // ==================================================================================/
   // Setup the ORDERS_GROUP to place the order on it
   TagVar := Group_Orders.Tag;
   Inc(TagVar);
   Group_Orders.Tag := TagVar;
   TagVar := Group_Orders.Height;
   Inc(TagVar, MenuBitButton.Height + Group_Orders.AVO_GROUPBOX_ADDHEIGHT);
   Group_Orders.Height := TagVar;
   Group_Orders.Visible := True;

   // ==================================================================================/
   // Now we show our button
   MenuBitButton.Show;
   MenuBitButton.Align := alTop;

   // ==================================================================================/
   // Now we have to create the Order Form Object and make it our bitch

   case LoadOrderType of
   	LoadOrderTypeLoadOrder :
      begin
      	ReturnFormObject := tReturnEditForm.Create;
         ReturnFormObject.ReturnInvoice.Load( fOrderID );
         ReturnFormObject.OnViewInvoiceEvent := HandleOnViewOrderInvoiceEvent;
         ReturnFormObject.OnFinalizeViewPrint := HandleClosedViewPrint;
         ReturnFormObject.InvoiceMessage := ReturnFormObject.ReturnInvoice.Order_Message;
         MenuBitButton.OrderID := ReturnFormObject.ReturnInvoice.ID;
      end;
      LoadOrderTypeNewReturn :
      begin
         ReturnFormObject := tReturnEditForm.Create;
         ReturnFormObject.ReturnInvoice.NewReturn( fOrderID );
         ReturnFormObject.OnViewInvoiceEvent := HandleOnViewOrderInvoiceEvent;
         ReturnFormObject.OnFinalizeViewPrint := HandleClosedViewPrint;
         MenuBitButton.OrderID := ReturnFormObject.ReturnInvoice.ID;

         // Now we have to set the Order Number
         fNewOrderNum := Order_GetNextOrderNumber();
         for ObjCount := 0 to AvoBase_OrderList.Count -1 do
         begin
            if (AvoBase_OrderList.Items[ObjCount] IS tOrderEditForm) then
               if (( AvoBase_OrderList.Items[ObjCount] AS tOrderEditForm).OrderNumber = fNewOrderNum ) then
                  inc(fNewOrderNum);
            if (AvoBase_OrderList.Items[ObjCount] IS tReturnEditForm) then
               if (( AvoBase_OrderList.Items[ObjCount] AS tReturnEditForm).OrderNumber = fNewOrderNum ) then
                  inc(fNewOrderNum);
         end;
         //
         ReturnFormObject.ReturnInvoice.OrderNumberSet( fNewOrderNum );
      end;
   end;

   // ==================================================================================/
   // Setup all EVENTS
   ReturnFormObject.OnDestroy := Close_Order_Form;
   ReturnFormObject.OnInvoiceUpdated := HandleInvoiceUpdated;

   // ==================================================================================/
   // Position, Size, Clarity, Monstrosity, Vulgarity
   ReturnFormObject.ManualDock(MAIN_DOCK_PANEL, nil, alClient);
   ReturnFormObject.BorderStyle := bsNone;
   ReturnFormObject.Left := (Self.Width - MAIN_DOCK_PANEL.Width) div 2;
   ReturnFormObject.Top := (Self.Height - MAIN_DOCK_PANEL.Height) div 2;
   ReturnFormObject.WindowState := wsMaximized;
   ReturnFormObject.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
   ReturnFormObject.BorderIcons := [];
   ReturnFormObject.Position := poDefault;

   // ==================================================================================/
   // Now Show It
   ReturnFormObject.Show;
   fOrderControlListState := false;

   // ==================================================================================/
   // Assign it into the Object List so it can be baby sat whislt we go and play poker
   AvoBase_OrderList.Add(ReturnFormObject);

   // ==================================================================================/
   // Set the Caption on our Button

   MenuBitButton.Caption := ReturnFormObject.ReturnInvoice.OrgName + #13 + ReturnFormObject.ReturnInvoice.Order_GetOrderTypeName  + #13 + '#' +
   	ReturnFormObject.ReturnInvoice.Order_GetOrderNumberName;

   // ==================================================================================/
   // Assign the Edit for anything we might need like if they are loading.
   ReturnFormObject.InvoiceMessage := ReturnFormObject.ReturnInvoice.Order_Message;

   // ==================================================================================/
   // Finished
   Application.Processmessages;
   PercentForm_Free();
   //
end;

procedure tControlForm_Order.OrderReturnManager;
var
   RPForm : TReturnProduct_Manager;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#84 + #104 + #105 + #115 + #32 + #65 + #118 + #111 + #66 + #97 +
         #115 + #101 + #32 + #70 + #101 + #97 + #116 + #117 + #114 + #101 + #32 + #114 +
         #101 + #113 + #117 + #105 + #114 + #101 + #115 + #32 + #82 + #101 + #103 + #105 +
         #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 + #46);
         {This AvoBase Feature requires Registration.}
      Exit;
   end;
   RPForm := TReturnProduct_Manager.Create( Application );
   // Events
   {
   BOForm.OnBackOrderDeliveredEvent := BackOrderDelivered;
   BOForm.OnBackOrderNotAvailableEvent := BackOrderNotAvailable;
   BOForm.OnLoadOrderEvent := HandleOnLoadOrderEvent;
   BOForm.OnViewOrderInvoiceEvent := HandleOnViewOrderInvoiceEvent;
   BOForm.OnPrintOrderInvoiceEvent := HandleOnPrintOrderInvoiceEvent;
   }
   // Show
   RPForm.ShowModal;
   FreeAndNil(RPForm);
end;

procedure tControlForm_Order.Return_New;
var
   ordNum : string;
   ordID : string;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#84 + #104 + #105 + #115 + #32 + #65 + #118 + #111 + #66 + #97 +
         #115 + #101 + #32 + #70 + #101 + #97 + #116 + #117 + #114 + #101 + #32 + #114 +
         #101 + #113 + #117 + #105 + #114 + #101 + #115 + #32 + #82 + #101 + #103 + #105 +
         #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 + #46);
         {This AvoBase Feature requires Registration.}
      Exit;
   end;

   ordNum := Order_GetOrderNumberInputForm('Please enter a Closed Order Number to base Return on:');
   if ( ordNum <> '' ) then
   begin
      ordID := Order_GetOrderIDByOrderNumber( ordNum );
      if ( ordID <> '' ) then
         HandleOnReturnOrderEvent( ordID )
      else
         AvoBaseDialog('Unable To Locate Order', 'Unable to locate Order # ' + OrdNum, mtError, [mbok], 0);
   end;
{
   LEAVE THIS HERE... IT WORKS STILL. IT MAKES THE ORDER LIST CREATE A RETURN BASED ON AN ORDER
   if (frm_OrderList <> NIL) then
   	frm_OrderList.OrderReturn();
}
end;

procedure tControlForm_Order.Return_NewWithCustID( inCustID : string );
begin
   showmessage('Handling New Return from Order Control Form WITH CUSTOMER ID');
end;

procedure tControlForm_Order.HandleOnReturnOrderEvent(inOrderID: string);
var
   errMsg : string;
   errResult : tErrorResult;
   orderInvoice : tInvoice;
   objCount : integer;
   objOrderNum : string;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#84 + #104 + #105 + #115 + #32 + #65 + #118 + #111 + #66 + #97 +
         #115 + #101 + #32 + #70 + #101 + #97 + #116 + #117 + #114 + #101 + #32 + #114 +
         #101 + #113 + #117 + #105 + #114 + #101 + #115 + #32 + #82 + #101 + #103 + #105 +
         #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 + #46);
         {This AvoBase Feature requires Registration.}
      Exit;
   end;

   orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
   orderInvoice.Load( inOrderID );
   errMsg := '';

   //
   if ( Order_GetReturnProductAvailableCountByOrderID( inOrderID ) <= 0 ) AND
      ( Order_GetReturnFeeAvailableCountByOrderID( inOrderID ) <= 0) AND
      ( Order_GetReturnShippingAvailableByOrderID( inOrderID ) <= 0) then
      	errMsg := 'Order no longer has any Product, Fees or Shipping that can be Returned.';

   ///
	if ( Order_IsReturnOpenByPriorOrderID( inOrderID )) then
   	errMsg := 'Order is already being processed as a Return. Please close or cancel existing working Return.';

   // Check the Object List to make sure the order # hasn't already been assigned but not saved
   for ObjCount := 0 to AvoBase_OrderList.Count -1 do
   begin
      if (AvoBase_OrderList.Items[ObjCount] IS tReturnEditForm) then
         ObjOrderNum := (AvoBase_OrderList.Items[ObjCount] AS tReturnEditForm).PriorOrderID;
      if (ObjOrderNum = inOrderID) then
         errMsg := 'Order is already being processed as a Return but not yet saved. Please Save or Cancel existing working Return.';
   end;

   //
	if ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusDelinquent) then
   	errMsg := 'This Order is marked as Delinquent.\n\nYou must take a Payment or Close the Order again.';
	//
	if ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusOpen ) OR
	   ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusCancelled ) then
   	errMsg := 'You can only create Returns based on Closed Orders.';
   //
   if ( Order_GetOrderTypeByOrderID( inOrderID ) <> OrdTypeOrder ) then
   	errMsg := 'You can only create Returns based on Orders.';
   //
   if ( errMsg <> '') then
   begin
   	errMsg := 'Unable to create a Return based on Order # ' + Order_GetOrderNumberByOrderID( inOrderID ) + '.' + #13 + #13 + errMsg;
      AvoBaseDialog('Unable to Create Return', errMsg, mterror, [mbOK], 0);
   end else
      begin
         if OrderViewOrder('Create a New Return for Order # ' + Order_GetOrderNumberByOrderID( inOrderID ),
         	'Create a New Return based on Order # ' + Order_GetOrderNumberByOrderID( inOrderID ) + '?', mtConfirmation, [mbyes, mbno], orderInvoice) = mbYes then
         begin
            FreeAndNil(OrderInvoice);
            Return_Load( LoadOrderTypeNewReturn, inOrderID );
         end;
      end;
   //
   if ( OrderInvoice <> Nil ) then
      FreeAndNil(OrderInvoice);
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'PAYMENTS - Take, Void, NSF'}

// this here is some complicated shit. it took days to write it and all the associated forms and toolboxes!
procedure tControlForm_Order.HandleOnVoidPaymentEvent(inOrderID: string);
var
   PaySelectForm : TPayment_SelectPaymentForm;
   VoidPaymentForm : TPayment_VoidPaymentForm;
   payRec : tPaymentRec;
   transObj : tTransactionObject;
   canVoid : boolean;
   retEscrow : currency;
   ReturnOrderID : string;
   custID : string;
begin
	if ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusOpen ) OR
	   ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusCancelled ) then
   begin
      AvoBaseDialog('Unable To Void Payment',
         'You cannot void payments on Orders that are not closed.', mterror, [mbOK], 0);
   end else
   begin
      transObj := tTransactionObject.Create();
      transObj.Load( inOrderID );
      //
      canVoid := true;
      if ( Payment_GetTotalPaymentCountByOrderID( inOrderID ) = 0) then
      begin
         AvoBaseDialog('Unable To Void Payment',
            'No payments have been made on this Order that can be voided.', mterror, [mbOK], 0);
         canVoid := false;
      end;
      //
      if ( CanVoid ) then
      begin
         PaySelectForm := TPayment_SelectPaymentForm.Create( Application, inOrderID, 'Select Order Payment', True);
         try
            PaySelectForm.ShowModal();
            if ( PaySelectForm.FormResult = mrOk ) then
            begin
               payRec := Payment_GetPaymentRecordByID( PaySelectForm.MOPID );
               if ( payRec.mop_rev = true ) then
               begin
                  AvoBaseDialog('Unable To Void Payment',
                     'The payment selected has already been voided.', mterror, [mbOK], 0);
               end else
                  begin
                     VoidPaymentForm := TPayment_VoidPaymentForm.Create( Application, 'Void Payment', inOrderID, PaySelectForm.MOPID, True);
                     try
                        VoidPaymentForm.ShowModal();
                        if ( VoidPaymentForm.CloseAction = actionSave ) then
                        begin
                           PercentForm_Create('Voiding Payment - One Moment Please...', 0, 0);
                           Payment_ReversePayment( InOrderID, PaySelectForm.MOPID, VoidPaymentForm.VoidType, VoidPaymentForm.VoidDate);
                           Order_MarkOrderDelinquent( inOrderID );
                           custID := Order_GetCustomerIdByOrderID( inOrderID );
                           retEscrow := Payment_VoidPaymentEscrowByOrderID( custID, inOrderID );
                           if ( retEscrow <> 0 ) then
                              AvoBaseDialog('Escrow Reversed',
                                 'A prior Return created Escrow for this Customer in the amount of ' + Pref_GetCashSymbol +
                                 FormatCurrency( retEscrow ) + '.\n\n' +
                                 'The amount has been subtracted from the Customer Escrow.', mtInformation, [mbok], 0);
                           PercentForm_Free();

                        end;
                     finally
                        FreeAndNil( VoidPaymentForm );
                     end;
               end;
                  if Assigned(eInvoiceUpdatedEvent) then
                     eInvoiceUpdatedEvent();
            end;
         finally
            FreeAndNil(PaySelectForm);
         end;
      end;
      //
      FreeAndNil( transObj);
   end;
end;

procedure tControlForm_Order.HandleOnTakeMethodOfPaymentEvent( inOrderID: string);
var
   TakeMOPForm : tOrderTakeMethodOfPaymentForm;
   mopRec : tPaymentRec;
   orderInvoice : tInvoice;
   CanPay : boolean;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 +
         #100 + #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 +
         #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #99 + #97 + #110 + #32 + #111 + #110 + #108 +
         #121 + #32 + #116 + #97 + #107 + #101 + #32 + #97 + #32 + #112 + #97 + #121 + #109 + #101 + #110 +
         #116 + #32 + #119 + #105 + #116 + #104 + #105 + #110 + #32 + #97 + #110 + #32 + #79 + #114 + #100 +
         #101 + #114 + #46);
      {Unregistered versions of AvoBase can only take a payment within an Order.}
      Exit;
   end;
   CanPay := true;
   //
   if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeReturn ) then
   begin
      AvoBaseDialog('Unable To Take Payment', 'You cannot take a payment on an a Return.', mterror, [mbOK], 0);
      CanPay := False;
   end else
	if ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusClosed) OR
	   ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusCancelled ) then
   begin
      AvoBaseDialog('Unable To Take Payment', 'You cannot take a payment on an Order that is not ' +
         'open.' + #13 + #13 + 'Orders that are closed or cancelled are not eligble for payments.', mterror, [mbOK], 0);
      CanPay := False;
   end;

   //
   if ( CanPay ) then
   begin
      TakeMOPForm := tOrderTakeMethodOfPaymentForm.Create( Application, 'Take Order Payment', inOrderID, True);
      try
         TakeMOPForm.ShowModal();
         if ( TakeMOPForm.CloseAction = actionSave ) then
         begin
            PercentForm_Create('Applying Payment - One Moment Please...', 0, 0);
            orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
            orderInvoice.Load( inOrderID );
            //
            mopRec := Payment_InitializePaymentRecord;
            //
            mopRec.id := masterdata.NewDBGuid;
            mopRec.org_id := orderInvoice.OrgID;
            mopRec.order_id := inOrderId;
            mopRec.c_id := orderInvoice.Customer_SoldToID;
            mopRec.mopdate := TakeMOPForm.MOPItem_Form.MopDate;
            mopRec.moptype := TakeMOPForm.MOPItem_Form.MopType;
            mopRec.mopvalue := EncryptObj.EncryptString(TakeMOPForm.MOPItem_Form.MopValue);
            mopRec.mopccexpm := TakeMOPForm.MOPItem_Form.MopCCExpM;
            mopRec.mopccexpy := TakeMOPForm.MOPItem_Form.MopCCExpY;
            mopRec.mopnoc := EncryptObj.DecryptString(TakeMOPForm.MOPItem_Form.MopNoc);
            mopRec.mopcvv := EncryptObj.DecryptString(TakeMOPForm.MOPItem_Form.MopCVV);
            mopRec.amount := TakeMOPForm.MOPItem_Form.Amount;
            mopRec.mopcct := TakeMOPForm.MOPItem_Form.MOPCCT;
            //
            Payment_MakePaymentByPaymentRecord( moPRec );
            //
            DBGotoID( inOrderID );
            PercentForm_Free();
            //
            if (Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusDelinquent ) then
            begin
               orderInvoice.Load( inOrderID );
               if ( orderInvoice.Amount_TotalDue = 0 ) then
                  	Order_CloseDelinquentOrder( inOrderID )
               else
                  AvoBaseDialog('Delinquent Order',
                     'Order # ' + Order_GetOrderNumberByOrderID( inOrderID ) + ' is delinquent.\n\n' +
                     'There is still an outstanding balance of ' + Pref_GetCashSymbol + FormatCurrency( orderInvoice.Amount_TotalDue ) + '.\nn' +
                     'Additional payments are still required until balance is paid in full.', mtInformation, [mbOK], 0 );
            end;
            //
            FreeAndNil(orderInvoice);
         end;
      finally
         FreeAndNil( TakeMOPForm );
      end;
      if Assigned(eInvoiceUpdatedEvent) then
         eInvoiceUpdatedEvent();
      if Assigned( fOrderRefreshEvent ) then
         fOrderRefreshEvent();
   end;
end;

procedure tControlForm_Order.HandleOnTakeMethodOfPaymentCustomerEvent(inCustID: string);
var
   custOrdSelectForm : tOrderSelectOrderByCustIDForm;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 +
         #100 + #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 +
         #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #99 + #97 + #110 + #32 + #111 + #110 + #108 +
         #121 + #32 + #116 + #97 + #107 + #101 + #32 + #97 + #32 + #112 + #97 + #121 + #109 + #101 + #110 +
         #116 + #32 + #119 + #105 + #116 + #104 + #105 + #110 + #32 + #97 + #110 + #32 + #79 + #114 + #100 +
         #101 + #114 + #46);
      {Unregistered versions of AvoBase can only take a payment within an Order.}
      Exit;
   end;
   custOrdSelectForm := tOrderSelectOrderByCustIDForm.Create( Application, inCustID, OrderStatusOpen, 'Select Order', true);
   try
      custOrdSelectForm.ShowModal;
      if ( custOrdSelectForm.FormResult = mrOk ) then
      begin
         HandleOnTakeMethodOfPaymentEvent(custOrdSelectForm.OrderID);
      end;
   finally
      FreeAndNil(custOrdSelectForm);
   end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'CANCEL ORDERS/RETURNS'}

procedure tControlForm_Order.HandleOnCancelUnCancelEventprocedure( CancelType: tCanceLtypes; InorderID: string);
var
   errMsg : string;
   errResult : tErrorResult;
   orderInvoice : tInvoice;
   returnInvoice : tReturnInvoice;
begin
   if (NOT OrderEditState( inOrderID)) then
   begin
      case CancelType of
         CancelOrders:
         begin
            errMsg := '';
            //
            if ( Order_GetOrderStatusByOrderID( inOrderID ) <> OrderStatusOpen ) then
               errMsg := 'You can only cancel Open Orders.';
            //
            if ( errMsg <> '') then
            begin
               AvoBaseDialog('Unable to Cancel Order # ' + Order_GetOrderNumberByOrderID( inOrderID ), errMsg, mterror, [mbOK], 0);
            end else
               begin
                  if ( Order_GetOrderTypeByOrderID( inOrderID) = OrdTypeOrder ) then
                  begin
                     orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
                     orderInvoice.Load( inOrderID );
                     if OrderViewOrder('Cancel Order', 'Cancelling an Order removes ALL methods of payments - included any voided payments.' + #13 + #13 +
                        'Are you sure you want to Cancel this Order?', mtWarning, [mbYes, mbNo], orderInvoice) = mbYes then
                     begin
                        PercentForm_Create('Cancelling Order # ' + Order_GetOrderNumberByOrderID( inOrderID ) + ' - One Moment Please...', 0, 0);
                        Order_CancelOrderByOrderID( inOrderID );
                        if Assigned(eInvoiceUpdatedEvent) then
                           eInvoiceUpdatedEvent();
                        if Assigned( fOrderRefreshEvent ) then
                           fOrderRefreshEvent();
                        PercentForm_Free();
                     end;
                     FreeAndNil( orderInvoice );
                  end;
                  //
                  if ( Order_GetOrderTypeByOrderID( inOrderID) = OrdTypeReturn ) then
                  begin
                     returnInvoice := treturnInvoice.Create( InvoiceTypeReport, NIL, NIL);
                     returnInvoice.Load( inOrderID );
                     if ReturnViewReturn('Cancel Return', 'Cancelling a Return is permanent - you will need to create a new Return based on the Order.' + #13 + #13 +
                        'Are you sure you want to Cancel this Return?', mtWarning, [mbYes, mbNo], returnInvoice) = mbYes then
                     begin
                        PercentForm_Create('Cancelling Return # ' + Order_GetOrderNumberByOrderID( inOrderID ) + ' - One Moment Please...', 0, 0);
                        Order_CancelOrderByOrderID( inOrderID );
                        if Assigned(eInvoiceUpdatedEvent) then
                           eInvoiceUpdatedEvent();
                        if Assigned( fOrderRefreshEvent ) then
                           fOrderRefreshEvent();
                        PercentForm_Free();
                     end;
                     FreeAndNil( returnInvoice );
                  end;
                  //
               end;
         end;
         // UN-C ANCEL ORDER
         CancelUnCancel:
         begin
            errMsg := '';
            //
            if ( Order_GetOrderStatusByOrderID( inOrderID ) <> OrderStatusCancelled ) then
               errMsg := 'You can only un-Cancel Cancelled Orders.';
            //
            if ( Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeReturn ) then
            	errMsg := 'You cannot un-Cancel Returns. Please create a new Return based on the prior Order.';
            //
            if ( errMsg <> '') then
            begin
               AvoBaseDialog('Unable to Un-Cancel Order # ' + Order_GetOrderNumberByOrderID( inOrderID ), errMsg, mterror, [mbOK], 0);
            end else
               begin
                  orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
                  orderInvoice.Load( inOrderID );
                  if OrderViewOrder('Un-Cancel Order # ' + Order_GetOrderNumberByOrderID( inOrderID ),
                     'Are you sure you want to Un-Cancel this Order making it active?', mtConfirmation, [mbYes, mbNo], orderInvoice) = mbYes then
                  begin
                     PercentForm_Create('Un-Cancelling Order # ' + Order_GetOrderNumberByOrderID( inOrderID ) + ' - One Moment Please...', 0, 0);
                     Order_UnCancelOrderByOrderID( inOrderID );
                     if Assigned(eInvoiceUpdatedEvent) then
                        eInvoiceUpdatedEvent();
                     if Assigned( fOrderRefreshEvent ) then
                        fOrderRefreshEvent();

                     PercentForm_Free();
                  end;
                  FreeAndNil( orderInvoice );
               end;
        end;
      end;
   end else
      AvoBaseDialog('Order View', 'Order #' + Order_GetOrderNumberByOrderID(inOrderID) + ' is currently being edited.' + #13 + #13 +
         'You cannot Cancel/Un-Cancel an Order while the Order is in an editing state.' + #13 + #13 +
         'Save and close the Order first.', mtconfirmation, [mbOK], 0);
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'BACK ORDERS'}

procedure tControlForm_Order.BackOrderDelivered(inProdID,InBOProdID: string);
var
   inOrderID : string;
   OrdStat : tOrderStatusTypes;
begin
   inOrderID := Product_GetOrderIDByBackOrderProductID( InBOProdID );
   OrdStat := Order_GetOrderStatusByOrderID( inOrderID );
   //
   if (OrderEditState( inOrderID)) then
   begin
      AvoBaseDialog('Back-Order Processing', 'Order #' + Order_GetOrderNumberByOrderID(inOrderID) + ' is currently being edited.' + #13 + #13 +
         'You cannot Back-Order Process while the Order is in an editing state.' + #13 + #13 +
         'Save and close the Order first.', mtconfirmation, [mbOK], 0);
   end else
      begin
         Product_MarkOrderProductDelivered( inProdID, InBOProdID, OrdStat );
         //
         AvoBaseDialog('Back-Order Processing','Product has been marked as Delivered (No longer Back-Ordered).' + #13 + #13 +
            'Invoice Line Item has been updated to reflect this change.', mtInformation, [mbOk], 0);
      end;
end;

procedure tControlForm_Order.BackOrderNotAvailable(inProdID,InBOProdID: string);
var
   inOrderID : string;
   OrdStat : tOrderStatusTypes;
   TranRec : tTransRec;
   EscrowSelect : TEscrow_SelectEscrow;
   RetOrderID : string;
begin
   inOrderID := Product_GetOrderIDByBackOrderProductID( InBOProdID );
   OrdStat := Order_GetOrderStatusByOrderID( inOrderID );
   //
   if (OrderEditState( inOrderID)) then
   begin
      AvoBaseDialog('Back-Order Processing', 'Order #' + Order_GetOrderNumberByOrderID(inOrderID) + ' is currently being edited.' + #13 + #13 +
         'You cannot Back-Order Process while the Order is in an editing state.' + #13 + #13 +
         'Save and close the Order first.', mtconfirmation, [mbOK], 0);
   end else
      begin
         Product_MarkOrderProductNotAvailable( inProdID, InBOProdID, OrdStat );
         //
         AvoBaseDialog('Back-Order Processing','Product has been marked as No Longer Available.' + #13 + #13 +
            'Invoice Line Item has been updated to reflect this change.', mtInformation, [mbOk], 0);
         //
         TranRec := Payment_InitializeTranRecord;
         TranRec.id := masterData.NewDBGuid();
         tranRec.disp_msg := 'The Product marked as No Longer Available was marked as "Paid For" on the original ' +
            'Invoice. A refund must be issued in the form of Cash, Check or Escrow.' + #13 + #13 +
            'If issued as Escrow, the transaction can be used on any future Invoice by this Customer.';
         tranRec.order_id := inOrderID;
         tranRec.c_stid := Order_GetCustomerIdByOrderID( inOrderID );
         tranRec.c_id := Product_GetCycleIDByOrderProductID( inProdID );
         tranRec.amount := Product_GetOrderProductAmountById( inProdID );
         EscrowSelect := TEscrow_SelectEscrow.Create( Application, 'Select Return Escrow', True, TranRec);
         EscrowSelect.ShowModal();
         // don't free, it is a CaFree on Close.
      end;
end;

procedure tControlForm_Order.OrderBackOrderManager;
var
   BOForm : tBackOrder_ManagerForm;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#84 + #104 + #105 + #115 + #32 + #65 + #118 + #111 + #66 + #97 +
         #115 + #101 + #32 + #70 + #101 + #97 + #116 + #117 + #114 + #101 + #32 + #114 +
         #101 + #113 + #117 + #105 + #114 + #101 + #115 + #32 + #82 + #101 + #103 + #105 +
         #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 + #46);
         {This AvoBase Feature requires Registration.}
      Exit;
   end;
   BOForm := tBackOrder_ManagerForm.Create( Application );
   // Events
   BOForm.OnBackOrderDeliveredEvent := BackOrderDelivered;
   BOForm.OnBackOrderNotAvailableEvent := BackOrderNotAvailable;
   BOForm.OnLoadOrderEvent := HandleOnLoadOrderEvent;
   BOForm.OnViewOrderInvoiceEvent := HandleOnViewOrderInvoiceEvent;
   BOForm.OnPrintOrderInvoiceEvent := HandleOnPrintOrderInvoiceEvent;
   // Show
   BOForm.ShowModal;
   FreeAndNil(BoForm);
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'CHANGE Order/Return Cycles'}

procedure tControlForm_Order.OrderChangeCycle;
var
   inOrderID : string;
   CycleViewForm : TOrgSelectOrgAndCycleForm;
   newCycleID : string;
   oldCycleID : string;
   oldOrgID : string;
   newOrgID : string;
   errMsg : string;
begin
   inOrderID := frm_OrderList.ID;
   //
   errMsg := '';
   if ( inOrderID = '' ) then
      errMsg := 'Bad Order ID?';
   if (OrderEditState( inOrderID)) then
      errMsg := 'Order #' + Order_GetOrderNumberByOrderID(inOrderID) + ' is currently being edited.' + #13 + #13 +
               'You cannot change an Order while the Order is in an editing state.' + #13 + #13 +
               'Save and close the Order first.';
   if (Order_GetOrderTypeByOrderID( inOrderID ) = OrdTypeReturn ) then
      errMsg := 'You cannot change the Organization or Sales Cycle on a Return.';
   //
   if ( errMsg = '' ) then
   begin
      if ( Order_GetOrderStatusByOrderID( inOrderID ) = OrderStatusOpen ) then
      begin
         CycleViewForm := TOrgSelectOrgAndCycleForm.Create( Application );
         try
            CycleViewForm.ShowModal;
            if (CycleViewForm.FormResult = mrOk) then
            begin
               NewCycleID := CycleViewForm.CycleID;
               newOrgID := Cycle_GetOrgIDByCycleID( NewCycleID );
               //
               oldCycleID := Cycle_GetCycleIDByOrderID( inOrderID );
               oldOrgID := Cycle_GetOrgIDByCycleID( OldCycleID );
               //
               if ( newCycleID <> oldCycleID ) then
               begin
                  if AvoBaseDialog('Confirm Org/Sales Cycle Change',
                     'Please confirm changes to Order #' + Order_GetOrderNumberByOrderID(inOrderID) + ' Organization and Sales Cycle.' + #13 + #13 +
                     'Previous Org/Cycle: ' + Org_GetOrgNameByOrgID( oldOrgID ) + ' - ' + Cycle_GetCycleNameByCycleID( oldCycleID ) + #13 + #13 +
                     'New Org/Cycle: ' + Org_GetOrgNameByOrgID( newOrgID ) + ' - ' + Cycle_GetCycleNameByCycleID( newCycleID ) + #13 + #13 +
                     'Note: This only changes the Order, not Line Items or Fees.', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
                  begin
                     Order_ChangeSalesCycleByOrderID( inOrderID, NewCycleID, newOrgID );
                     if Assigned(eInvoiceUpdatedEvent) then
                        eInvoiceUpdatedEvent();
                     if Assigned( fOrderRefreshEvent ) then
                        fOrderRefreshEvent();
                  end;
               end else
                  AvoBaseDialog('Change Order Cycle', 'You have selected the same Sales Organization and Cycle. No changes will be made.', mtError, [mbOK], 0);
            end;
         finally
            // Don't do this here. It's a caFree. FreeAndNil(CycleViewForm);
         end;
      end else
         AvoBaseDialog('Change Order Cycle', 'Order #' + Order_GetOrderNumberByOrderID(inOrderID) + ' is not in an Open state.' + #13 + #13 +
         'You can only change an Order Sales Cycle while the Order is still in the Open State.', mtError, [mbOK], 0);
   end else
      AvoBaseDialog('Change Order Cycle', errMsg, mtError, [mbOK], 0);
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Printing, Emailing'}

procedure tControlForm_Order.PrintAllCycleInvoices;
var
   cycleID : string;
   orderID : string;
   ordCount : integer;
   fOrdPrintQuery : tQuery;
   invoiceReport : tReport_InvoiceForm;
begin
   cycleID := SelectCycle();
   if ( cycleID <> '' ) then
   begin
      ordCount := Order_GetOrderCountByCycleTypeStatus( cycleID, OrdTypeOrder, OrderStatusOpen );
      if ( ordCount <> 0 ) then
      begin
         if AvoBaseDialog('Confirm Print', 'There are ' + IntToStr(ordCount) + ' Open Order(s) in Sales Cycle ' +
            Cycle_GetCycleNameByCycleID( cycleID ) + '.\n\nConfirm Printing of all Open Orders?', mtConfirmation, [mbyes, mbno], 0) = mbYes then
         begin
            fOrdPrintQuery := Order_GetOrderQueryByCycleTypeStatus( cycleID, OrdTypeOrder, OrderStatusOpen );
            if ( fOrdPrintQuery.RecordCount <> 0 ) then
            begin
               PercentForm_Create('Printing Sales Cycle ' + Cycle_GetCycleNameByCycleID( cycleID ) + ' Invoices', 0, fOrdPrintQuery.RecordCount);
               fOrdPrintQuery.First();
               repeat
                  PercentForm_Update();
                  orderID := fOrdPrintQuery.FieldByname('ID').AsString;
                  if ( Order_GetOrderTypeByOrderID( orderID ) = OrdTypeOrder ) then
                  begin
                     invoiceReport := tReport_InvoiceForm.create( Application, orderID );
                     invoiceReport.QReport.Print();
                     FreeAndNil(invoiceReport);
                  end;
                  fOrdPrintQuery.Next();
               until fOrdPrintQuery.Eof;
               PercentForm_Free();
            end;
            fOrdPrintQuery.Close();
            FreeAndNil(fOrdPrintQuery);
         end;
      end else
         AvoBaseDialog('No Open orders', 'There are no Open Orders that match the selected Sales Cycle.', mtInformation, [mbok], 0);
   end;
end;

procedure tControlForm_Order.EmailAllCycleInvoices;
var
   cycleID : string;
   ordCount : integer;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#79 + #110 + #108 + #121 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 +
         #114 + #101 + #100 + #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 +
         #102 + #32 + #111 + #102 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #99 + #97 +
         #110 + #32 + #113 + #117 + #101 + #117 + #101 + #32 + #79 + #114 + #100 + #101 + #114 + #32 + #80 +
         #68 + #70 + #32 + #73 + #110 + #118 + #111 + #105 + #99 + #101 + #115 + #32 + #102 + #111 + #114 +
         #32 + #69 + #109 + #97 + #105 + #108 + #105 + #110 + #103 + #46);
      {Only Registered versions of of AvoBase can queue Order PDF Invoices for Emailing.}
      Exit;
   end;
   //
   cycleID := SelectCycle();
   if ( cycleID <> '' ) then
   begin
      ordCount := Order_GetOrderCountByCycleID( cycleID );
      if ( ordCount <> 0 ) then
      begin
         if AvoBaseDialog('Confirm Email', 'There are ' + IntToStr(ordCount) + ' Order/Return(s) in Sales Cycle ' +
            Cycle_GetCycleNameByCycleID( cycleID ) + '.\n\nConfirm Emailing (further options will be presented during ' +
            'Email generation)?', mtConfirmation, [mbyes, mbno], 0) = mbYes then
            if Assigned( fEmailCycleEvent ) then
               fEmailCycleEvent( cycleID );
      end else
         AvoBaseDialog('No Open orders', 'There are no Open Orders that match the selected Sales Cycle.', mtInformation, [mbok], 0);
   end;
end;

{$ENDREGION}


end.


