 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_ControlFormUnit;

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   img_storageformunit,
   avobase_dialogformunit,
   avobase_helpformunit,
  recordstructureunit,
   avobase_baseform_menuunit,
   avobase_baseform_standardunit,
   encryptunit,
   VerificationUnit,
   Avobase_RegisterDialogFormUnit,
   Customer_ExportFormUnit,
   //
   Customer_EditFormunit,
   Customer_ListFormUnit,
   Customer_NoteListFormUnit,
   Customer_ProdHistoryFormUnit,
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

const
	CUSTCONTROL_CUSTLIST = 1000;
   CUSTCONTROL_CUSTEDIT = 1001;

type
	tControlForm_Customer = class( tForm )
   	MAIN_DOCK_PANEL: TScrollBox;
      //
      procedure HandleCloseForm(Sender: TObject);
      procedure HandleOnLoadOrderEvent( sender : tObject; inOrderID : string );
      procedure HandleOnNewOrderWithCustomerEvent( inCustId : string );
      procedure HandleOnMethodOfPaymentCustomerEvent( inCustID : string );
      Procedure HandleOnViewOrderInvoiceEvent( sender : tObject; inOrderID : string );
      Procedure HandleOnPrintOrderInvoiceEvent ( sender : tObject; inOrderID : string );
      Procedure HandleOnCancelUnCancelOrderEvent( CancelType : tCanceLtypes; InorderID : string );
      Procedure HandleOnTakeMethodOfPayment( inOrderID : string );
      Procedure HandleOnReturnOrderEvent( inOrderID : string );
      Procedure HandleOnVoidMethodOfPaymentEvent( inCustID : string );
      Procedure HandleCustomerRefreshEvent();
      procedure HandleOnViewPrintCustomerEvent( inCustID : string );
      procedure HandleEmailCustomer();
   protected
      function tygHjehtU88jge: vEnResultRec;
   private
      fNewOrderWithCustomerEvent : tNewOrderWithCustomerEvent;
      fLoadOrderEvent : tLoadOrderEvent;
      fTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent;
      fVoidPaymentEvent : tVoidPaymentEvent;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fPrintInvoiceEvent : tPrintInvoiceEvent;
      fFinalizeOrderEvent : tFinalizeOrderEvent;
      fCancelEvent : tCancelEvent;
      fTakeMethodOfPaymentCustomerEvent : tTakeMethodOfPaymentCustomerEvent;
      fReturnEvent : tReturnEvent;
      fVoidMethodOfPaymentCustomerEvent : tVoidMethodOfPaymentCustomerEvent;
      fCustomerRefreshEvent : tCustomerRefreshEvent;
      fViewPrintCustomerEvent : tViewPrintCustomerEvent;
   public
   	frm_CustomerList : TCustomerListForm;
      frm_CustomerEdit : tCustomerEditForm;

      procedure StartForm;
      procedure StopForm;
      procedure DockForm(inForm: tForm; inFormType : integer);
      procedure GlobalRefreshEvent();
      procedure OrderListEditCustomer( inCustID : string );
      procedure CustomerNotes();
      procedure CustomerOrderProd();
      procedure ExportCustomer();
      procedure ImportCustomer();
      //
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OnNewOrderWithCustomerEvent : tnewOrderWithCustomerEvent read FNewOrderWithCustomerEvent write FNewOrderWithCustomerEvent;
      property OnCustomerMethodOfPaymentEvent : tTakeMethodOfPaymentCustomerEvent read fTakeMethodOfPaymentCustomerEvent write fTakeMethodOfPaymentCustomerEvent;
      property OnViewOrderInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OnPrintOrderInvoiceEvent : tPrintInvoiceEvent read fPrintInvoiceEvent write fPrintInvoiceEvent;
      property OnFinalizeOrderInvoiceEvent : tFinalizeOrderEvent read fFinalizeOrderEvent write fFinalizeOrderEvent;
      property OnTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent read fTakeMethodOfPaymentEvent write fTakeMethodOfPaymentEvent;
      property OnVoidPaymentEvent : tVoidPaymentEvent read fVoidPaymentEvent write fVoidPaymentEvent;
      property OnCancelUnCancelOrderEvent : tCancelEvent read fCancelEvent write fCancelEvent;
      property OnReturnOrderEvent : tReturnEvent read fReturnEvent write fReturnEvent;
      property OnVoidMethodOfPaymentEvent : tVoidMethodOfPaymentCustomerEvent read fVoidMethodOfPaymentCustomerEvent write fVoidMethodOfPaymentCustomerEvent;
      property OnCustomerRefreshEvent : tCustomerRefreshEvent read fCustomerRefreshEvent write fCustomerRefreshEvent;
      property OnViewPrintCustomerEvent : tViewPrintCustomerEvent read fViewPrintCustomerEvent write fViewPrintCustomerEvent;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//




procedure tControlForm_Customer.DockForm(inForm: tForm; inFormType : integer);
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


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.GlobalRefreshEvent;
begin
   frm_CustomerList.GlobalRefreshEvent();
end;

procedure tControlForm_Customer.HandleCloseForm(Sender: TObject);
begin
  case tForm(Sender).Tag of
    CUSTCONTROL_CUSTLIST: frm_CustomerList := Nil;
  end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleCustomerRefreshEvent;
begin
   if Assigned( fCustomerRefreshEvent ) then
      fCustomerRefreshEvent();
end;

procedure tControlForm_Customer.HandleEmailCustomer;
begin
   frm_CustomerList.CustomerEmail();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleOnCancelUnCancelOrderEvent( CancelType: tCanceLtypes; InorderID: string);
begin
   if Assigned( fCancelEvent ) then
      fCancelEvent( CancelType, InOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleOnLoadOrderEvent(sender: tObject; inOrderID: string);
begin
	if Assigned(fLoadOrderEvent) then
   	fLoadOrderEvent( Self, inOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleOnMethodOfPaymentCustomerEvent( inCustID: string);
begin
   if Assigned( fTakeMethodOfPaymentCustomerEvent ) then
      fTakeMethodOfPaymentCustomerEvent( inCustID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleOnNewOrderWithCustomerEvent( inCustId: string);
begin
   // we can't handle this here, it has to go to the order control
   if Assigned(FNewOrderWithCustomerEvent) then
      FNewOrderWithCustomerEvent( inCustId );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleOnPrintOrderInvoiceEvent( sender: tObject; inOrderID: string);
begin
   if Assigned(fPrintInvoiceEvent) then
      fPrintInvoiceEvent( Sender, InOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleOnReturnOrderEvent(inOrderID: string);
begin
	if Assigned( fReturnEvent ) then
   	fReturnEvent( inOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleOnTakeMethodOfPayment( inOrderID: string);
begin
   if Assigned(fTakeMethodOfPaymentEvent) then
      fTakeMethodOfPaymentEvent( inOrderID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.HandleOnViewOrderInvoiceEvent( sender: tObject; inOrderID: string);
begin
   if Assigned( fViewInvoiceEvent ) then
      fViewInvoiceEvent( Sender, InOrderID );
end;

procedure tControlForm_Customer.HandleOnViewPrintCustomerEvent( inCustID: string);
begin
   if Assigned(fViewPrintCustomerEvent) then
      fViewPrintCustomerEvent( inCustID );
end;

procedure tControlForm_Customer.HandleOnVoidMethodOfPaymentEvent( inCustID: string);
begin
   if Assigned(fVoidMethodOfPaymentCustomerEvent) then
      fVoidMethodOfPaymentCustomerEvent( inCustID );
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.StartForm;
begin
	// we need to make sure that if this form is created and NO other forms are showing
	if (frm_CustomerList = NIL) then
   begin
   	frm_CustomerList := tCustomerListForm.Create(Application);//('Customers', true);
      frm_CustomerList.OnLoadOrderEvent := HandleOnLoadOrderEvent;
      frm_CustomerList.OnNewOrderWithCustomerEvent := HandleOnNewORderWithCustomerEvent;
      frm_CustomerList.OnCustomerMethodOfPaymentEvent := HandleOnMethodOfPaymentCustomerEvent;
      frm_CustomerList.OnTakeMethodOfPaymentEvent := HandleOnTakeMethodOfPayment;
      frm_CustomerList.OnViewOrderInvoiceEvent := Self.HandleOnViewOrderInvoiceEvent;
      frm_CustomerList.OnPrintOrderInvoiceEvent := Self.HandleOnPrintOrderInvoiceEvent;
      frm_CustomerList.OnCancelUnCancelOrderEvent := Self.HandleOnCancelUnCancelOrderEvent;
      frm_CustomerList.OnReturnOrderEvent := Self.HandleOnReturnOrderEvent;
      frm_CustomerList.OnVoidMethodOfPaymentEvent := Self.HandleOnVoidMethodOfPaymentEvent;
      frm_CustomerList.OnCustomerRefreshEvent := Self.HandleCustomerRefreshEvent;
      frm_CustomerList.OnViewPrintCustomerEvent := Self.HandleOnViewPrintCustomerEvent;
      frm_CustomerList.OnEmailCustomerEvent := Self.HandleEmailCustomer;
      DockForm( frm_CustomerList, CUSTCONTROL_CUSTLIST );
   end;

   // now, which one do we show? We always try to show the list, but if an EDIT is up
   if (frm_CustomerList <> NIL) then
   	frm_CustomerList.Show();
   if (frm_CustomerEdit <> NIL) then
   	frm_CustomerEdit.Show();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.StopForm;
begin
	if (frm_CustomerList <> NIL) then
   	frm_CustomerList.Close();
   if (frm_CustomerEdit <> NIL) then
   begin
   	frm_CustomerEdit.Show();
      frm_CustomerEdit.Close();
   end;
end;

function tControlForm_Customer.tygHjehtU88jge: vEnResultRec;
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

procedure tControlForm_Customer.OrderListEditCustomer(inCustID: string);
begin
   if ( frm_CustomerList <> NIL ) then
      frm_CustomerList.CustomerEditExternalCustomer( inCustID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.CustomerNotes;
var
   custNoteEdit : tCustomer_NoteListForm;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      AvoBaseRegisterDialog(#84 + #104 + #105 + #115 + #32 + #65 + #118 + #111 + #66 + #97 +
         #115 + #101 + #32 + #70 + #101 + #97 + #116 + #117 + #114 + #101 + #32 + #114 +
         #101 + #113 + #117 + #105 + #114 + #101 + #115 + #32 + #82 + #101 + #103 + #105 +
         #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 + #46);
         {This AvoBase Feature requires Registration.}
      Exit;
   end;
   custNoteEdit := tCustomer_NoteListForm.Create( Application, NIL, frm_CustomerList.CustID );
   custNoteEdit.ShowModal();
   FreeAndNil(custNoteEdit);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This brings up an entire history of all products ordered by a customer, from latest to first
procedure tControlForm_Customer.CustomerOrderProd;
var
   custProdHist : TCustomer_ProdHistoryForm;
begin
   custProdHist := TCustomer_ProdHistoryForm.Create( Application, frm_CustomerList.CustID );
   custProdHist.ShowModal();
   // DONT FREE THE FORM, it is a CAFREE... NONE OF THE FREES GET FREED RIGHT?F REEEEEEEEEEEEEEEEEEEEEE
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Customer.ImportCustomer;
begin
	AvoBaseDialog('Customer Import', 'Customer Import Functionality is still being worked on.', mtInformation, [mbOk], 0);
end;

procedure tControlForm_Customer.ExportCustomer;
var
	frmCustExport : tExport_Customer;
begin
	frmCustExport := tExport_Customer.Create( Application, 'Export Customer', true );
   try
   	frmCustExport.ShowModal();
   finally
   end;
end;


end.



