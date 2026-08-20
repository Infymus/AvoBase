 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_ListFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   EncryptUnit,
   actionunit,
   masterdata_basegridunit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   recordstructureunit,
   MasterData_CustomerListUnit,
   toolbox_ordertoolboxunit,
   customer_editformunit,
   Customer_ViewOrdersFormUnit,
   customer_viewaccountformunit,
   avobase_percentformunit,
   Toolbox_PreferenceToolBoxUnit,
   AvoBase_HelpFormUnit,
   VerificationUnit,
   Avobase_RegisterDialogFormUnit,
   //
   ShellAPI,
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
  TCustomerListForm = class(TAvobase_BaseForm_List)
    SortViewComboBox: TComboBox;
    sortViewLabel: TLabel;
    activityLabel: TLabel;
    ActiveComboBox: TComboBox;
    procedure EventUpdateQuery(Sender: TObject);
    procedure MainFormactCtrl_Cust_PaymentExecute(Sender: TObject);
  private
      fNewOrderWithCustomerEvent : tNewOrderWithCustomerEvent;
      fLoadOrderEvent : tLoadOrderEvent;
      fTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent;
      fVoidPaymentEvent : tVoidPaymentEvent;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fPrintInvoiceEvent : tPrintInvoiceEvent;
      fFinalizeOrderEvent : tFinalizeOrderEvent;
      fEmailCustomerEvent : tEmailCustomerEvent;
      fCancelEvent : tCancelEvent;
      fTakeMethodOfPaymentCustomerEvent : tTakeMethodOfPaymentCustomerEvent;
      fReturnEvent : tReturnEvent;
      fVoidMethodOfPaymentCustomerEvent : tVoidMethodOfPaymentCustomerEvent;
      fCustomerRefreshEvent : tCustomerRefreshEvent;
      fViewPrintCustomerEvent : tViewPrintCustomerEvent;

      //
   	frmCustEdit : tCustomerEditForm;
      custQuery : tMasterData_BaseDataClass;
      custListQuery : tMasterDataCustomerList;
      frmCustView : tCustomer_ViewForm;
      frmCustViewAcc : TCustomer_AccountViewForm;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleDoubleClick( sender : tObject );
      procedure HandleEmailCustomerEvent();
      function fGetCustRecCount : integer;
      function fGetCustID : string;
      function fGetCustFullName : string;
      function fGetCustEmail : string;
      function tygHjehtU88jge: vEnResultRec;
   public
      //
      procedure UpdateCustQuery();
      procedure CustomerActivateDeactivate();
      procedure CustomerEditCustomer();
      procedure CustomerEditExternalCustomer( inCustID : string );
      procedure CustomerNewCustomer();
      procedure CustomerView();
		procedure CustomerEmail();
		procedure CustomerPrint();
		procedure CustomerHelp();
		procedure CustomerReport();
      procedure CustomerNewOrder();
      procedure CustomerPayment();
      procedure CustomerVoidPayment();
      procedure Recalculate( inID : string );
      procedure CustomerViewAccount();
      procedure GlobalRefreshEvent();

      //
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OnNewOrderWithCustomerEvent : tNewOrderWithCustomerEvent read fNewOrderWithCustomerEvent write fNewOrderWithCustomerEvent;
      property OnCustomerMethodOfPaymentEvent : tTakeMethodOfPaymentCustomerEvent read fTakeMethodOfPaymentCustomerEvent write fTakeMethodOfPaymentCustomerEvent;
      property OnViewOrderInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OnPrintOrderInvoiceEvent : tPrintInvoiceEvent read fPrintInvoiceEvent write fPrintInvoiceEvent;
      property OnFinalizeOrderInvoiceEvent : tFinalizeOrderEvent read fFinalizeOrderEvent write fFinalizeOrderEvent;
      property OnTakeMethodOfPaymentEvent : tTakeMethodOfPaymentEvent read fTakeMethodOfPaymentEvent write fTakeMethodOfPaymentEvent;
      property OnVoidMethodOfPaymentEvent : tVoidMethodOfPaymentCustomerEvent read fVoidMethodOfPaymentCustomerEvent write fVoidMethodOfPaymentCustomerEvent;
      property OnCancelUnCancelOrderEvent : tCancelEvent read fCancelEvent write fCancelEvent;
      property OnReturnOrderEvent : tReturnEvent read fReturnEvent write fReturnEvent;
      property OnCustomerRefreshEvent : tCustomerRefreshEvent read fCustomerRefreshEvent write fCustomerRefreshEvent;
      property OnViewPrintCustomerEvent : tViewPrintCustomerEvent read fViewPrintCustomerEvent write fViewPrintCustomerEvent;
      property OnEmailCustomerEvent : tEmailCustomerEvent read fEmailCustomerEvent write fEmailCustomerEvent;
      property CustID : string read fGetCustID;
      //
      property CustRecCount : integer read fGetCustRecCount;
      property CustFullName : string read fGetCustFullName;
      property CustEmail : string read fGetCustEmail;

      //
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TCustomerListForm.create(owner : TComponent);
begin
	inherited create( Nil, 'Customers', false, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   custListQuery := tMasterDataCustomerList.Create( masterData);
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
   DataListGrid.Add(custListQuery.FieldByName('FULLNAME'), 'CUSTOMER NAME', 150, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(custListQuery.FieldByName('PHONEH'), 'PHONE', 110, clHighlight, [], taLeftJustify);
   DataListGrid.Add(custListQuery.FieldByName('PHONEC'), 'CELL', 110, clHighlight, [], taLeftJustify);
   DataListGrid.Add(custListQuery.FieldByName('FULLADDR'), 'ADDRESS', 250, clBlack, [], taLeftJustify);
   DataListGrid.Add(custListQuery.FieldByName('TOTO'), 'OPEN', 60, clGreen, [], taRightJustify);
   DataListGrid.Add(custListQuery.FieldByName('TOTC'), 'CLOSED', 60, clGreen, [], taRightJustify);
   DataListGrid.Add(custListQuery.FieldByName('BOT'), 'B/O', 60, clGreen, [], taRightJustify);
   DataListGrid.Add(custListQuery.FieldByName('TOTN'), 'NOTES', 60, clGreen, [], taRightJustify);
   DataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( custListQuery );
   //
   UpdateCustQuery();
end;

destructor tCustomerListForm.Destroy;
begin
	custListQuery.Close();
   freeAndNil(custListQuery);
   FreeAndNil(custQuery);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerListForm.EventUpdateQuery(Sender: TObject);
begin
	UpdateCustQuery();
end;

function TCustomerListForm.fGetCustEmail: string;
begin
   result := custListQuery.FieldByName('EMAIL').AsString;
end;

function TCustomerListForm.fGetCustFullName: string;
begin
   result := custListQuery.FieldByName('FNAME').AsString + ' ' + custListQuery.FieldByName('LNAME').AsString;
end;

function TCustomerListForm.fGetCustID: string;
begin
   result := custListQuery.FieldByName('ID').AsString;
end;

function TCustomerListForm.fGetCustRecCount: integer;
begin
	result := custListQuery.RecordCount;
end;

procedure TCustomerListForm.GlobalRefreshEvent;
var
   inID : string;
begin
   inID := CustID;
   UpdateCustQuery();
   custListQuery.Locate('ID', inID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.HandleDoubleClick(sender: tObject);
begin
	CustomerEditCustomer();
end;

procedure TCustomerListForm.HandleEmailCustomerEvent;
begin
   if Assigned( fEmailCustomerEvent ) then
      fEmailCustomerEvent();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(custListQuery.RecNo) + ' of ' + IntToStr(custListQuery.RecordCount);
end;

procedure TCustomerListForm.MainFormactCtrl_Cust_PaymentExecute(Sender: TObject);
begin
  inherited;

end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerListForm.UpdateCustQuery;
var
	sortDir : string;
   onlyActive : tActiveStates;
begin
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
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerListForm.CustomerActivateDeactivate;
var
  OldRec : Integer;
  SetActive : boolean;
  CanDo : Boolean;
  errRec : tErrorResult;
begin
  CanDo := False;
  if (custListQuery.FieldByName('ISACTIVE').AsBoolean = FALSE) then
    if AvoBaseDialog('Activate Customer', 'Customer is Inactive. Are you sure you want to Activate this Customer?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
    begin
      CanDo := True;
      SetActive := true;
    end;
  if (custListQuery.FieldByName('ISACTIVE').AsBoolean = TRUE) then
    if AvoBaseDialog('Deactivate Customer', 'Customer is Active. Are you sure you want to Deactivate this Customer?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
    begin
      CanDo := True;
      SetActive := false;
    end;
  if (CanDo) then
  begin
    OldRec := custListQuery.RecNo - 1;
    if (OldRec < 0) then
      OldRec := 0;
    errRec := custQuery.Load( CustID );
    if NOT (errRec.errorResult) then
    begin
    	custQuery.Edit();
    	custQuery.SetFieldByName('ISACTIVE', SetActive);
      custQuery.Post();
      UpdateCustQuery();
      custListQuery.MoveBy(OldRec);
    end;
  end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerListForm.CustomerNewCustomer;
var
	errRec : tErrorResult;
   id : string;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
      if ( CustRecCount > 10 ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#85 + #110 + #114 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100 +
         #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 + #102 + #32 + #65 + #118 +
         #111 + #66 + #97 + #115 + #101 + #32 + #97 + #114 + #101 + #32 + #108 + #105 + #109 + #105 + #116 +
          #101 + #100 + #32 + #116 + #111 + #32 + #49 + #48 + #32 + #67 + #117 + #115 + #116 + #111 + #109 +
           #101 + #114 + #115 + #32 + #111 + #110 + #108 + #121 + #46 + #32 + #69 + #120 + #112 + #105 + #114 +
            #101 + #100 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #114 + #97 + #116 + #105 + #111 + #110 +
             #32 + #114 + #101 + #113 + #117 + #105 + #114 + #101 + #115 + #32 + #114 + #101 + #110 + #101 + #119 +
              #97 + #108 + #32 + #116 + #111 + #32 + #97 + #100 + #100 + #32 + #109 + #111 + #114 + #101 + #32 +
               #67 + #117 + #115 + #116 + #111 + #109 + #101 + #114 + #115 + #46);
       {Unregistered versions of AvoBase are limited to 10 Customers only. Expired Registration requires renewal to add more Customers.}
      Exit;
   end;
   //
   custQuery.Append();
   id := custQuery.GetFieldByName('ID').AsString;
   frmCustEdit := tCustomerEditForm.Create( Application, 'New Customer', true, custQuery);
   frmCustEdit.IsNew := true;
   try
      frmCustEdit.ShowModal();
      if ( frmCustEdit.CloseAction = actionSave ) then
      begin
         Recalculate( id );
         if Assigned( fCustomerRefreshEvent ) then
            fCustomerRefreshEvent();
      end;
   finally
      // DONT FreeAndNil(frmCustEdit);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerListForm.CustomerEditCustomer;
var
	errRec : tErrorResult;
begin
   errRec := custQuery.Load( CustID );
   frmCustEdit := tCustomerEditForm.Create( Application, 'Edit Customer', true, custQuery);
   frmCustEdit.IsNew := False;
   try
      frmCustEdit.ShowModal();
      if ( frmCustEdit.CloseAction = actionSave ) then
      begin
         Recalculate( CustID );
         if Assigned( fCustomerRefreshEvent ) then
            fCustomerRefreshEvent();
      end;
   finally
      // DONT FreeAndNil(frmCustEdit);
   end;
end;

procedure TCustomerListForm.CustomerEditExternalCustomer(inCustID: string);
var
	errRec : tErrorResult;
begin
   custListQuery.Locate('ID', inCustID, [loCaseInsensitive]);
   errRec := custQuery.Load( inCustID );
   frmCustEdit := tCustomerEditForm.Create( Application, 'Edit Customer', true, custQuery);
   frmCustEdit.IsNew := False;
   try
      frmCustEdit.ShowModal();
      if ( frmCustEdit.CloseAction = actionSave ) then
      begin
         Recalculate( inCustID );
         if Assigned( fCustomerRefreshEvent ) then
            fCustomerRefreshEvent();
      end;
   finally
      // DONT FreeAndNil(frmCustEdit);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.Recalculate( inID : string );
begin
   custListQuery.Close();
   custListQuery.Open();
   custListQuery.Locate('ID', inID, [loCaseInsensitive]);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TCustomerListForm.tygHjehtU88jge: vEnResultRec;
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

procedure TCustomerListForm.CustomerEmail;
var
   myWideString  : WideString;
   subjString : string;
begin
   if ( custEmail <> '' ) then
   begin
      if AvoBaseDialog('Send Email To ' + custFullName,
         'This will open up your favorite email program and allow you to send an email to ' + CustFullName + '.\n\n' +
         'Confirm you want to send an Email?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
      begin
         subjString := Pref_GetString(tPrefConstants.RCOMP, '');
         if (subjString = '') then
            subjString := 'AvoBase Email';
         myWideString := 'mailto:' + CustEmail + '?Subject=' + subjString + '&Body=Sent via AvoBase ' + VER_NUM;
         ShellExecute(0,nil,PWideChar(myWideString),nil,nil,SW_NORMAL);
      end;
   end else
      AvoBaseDialog('Email Error', 'The selected Customer does not have an Email Address.', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.CustomerHelp;
begin
	AvoBaseHelp_Execute('CustomerListForm');
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.CustomerNewOrder;
begin
   if Assigned(FNewOrderWithCustomerEvent) then
   begin
      FNewOrderWithCustomerEvent(CustID);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.CustomerPayment;
begin
   if ( Order_GetTotalOpenOrdersByCustID( CustID ) = 0) then
      AvoBaseDialog('No Orders Found', 'This customer does not have any OPEN Orders.', mtError, [mbOK], 0)
   else
      if Assigned( fTakeMethodOfPaymentCustomerEvent ) then
         fTakeMethodOfPaymentCustomerEvent( CustID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.CustomerPrint;
begin
   if Assigned(fViewPrintCustomerEvent) then
      fViewPrintCustomerEvent( CustID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.CustomerReport;
begin
	AvoBaseHelp_Execute('CustomerListForm');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.CustomerVoidPayment;
begin
   if ( Order_GetTotalOpenOrdersByCustID( CustID ) = 0) then
      AvoBaseDialog('No Orders Found', 'This customer does not have any OPEN Orders.', mtError, [mbOK], 0)
   else
      if Assigned( fTakeMethodOfPaymentCustomerEvent ) then
         fVoidMethodOfPaymentCustomerEvent( CustID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomerListForm.CustomerView;
var
	errRec : tErrorResult;
begin
    errRec := custQuery.Load( CustID );
    if NOT (errRec.errorResult) then
    begin
      frmCustView := tCustomer_ViewForm.Create( Application,
         'Order History | ' + custListQuery.FieldByName('FULLNAME').AsString, true, custQuery);
      frmCustView.OnEmailCustomerEvent := HandleEmailCustomerEvent;
      try
         frmCustView.ShowModal();
         case frmCustView.OnCloseAction of
            CustViewTypes_Close:; // do nothing
            //
            CustViewTypes_NewOrderWithCustomer:
            begin
               if Assigned(fNewOrderWithCustomerEvent) then
                  fNewOrderWithCustomerEvent( frmCustView.CustID );
            end;
            CustViewTypes_LoadOrder:
            begin
            	if Assigned(fLoadOrderEvent) then
                  fLoadOrderEvent( Self, frmCustView.OrderID );
            end;
            CustViewTypes_MOP:
            begin
               if Assigned(fTakeMethodOfPaymentEvent) then
                  fTakeMethodOfPaymentEvent( frmCustView.OrderID );
            end;
            CustViewTypes_ViewInvoice:
            begin
               if Assigned( fViewInvoiceEvent ) then
                  fViewInvoiceEvent( Self, frmCustView.OrderID );
            end;
            CustViewTypes_PrintInvoice:
            begin
               if Assigned(fPrintInvoiceEvent) then
                  fPrintInvoiceEvent( Self, frmCustView.OrderID );
            end;
            CustViewTypes_FinalizeOrder:
            begin
               ShowMessage('Finalize Order Is Not Ready From Here');
            end;
            CustViewTypes_Cancel:
            begin
               if Assigned( fCancelEvent ) then
                  fCancelEvent( CancelOrders, frmCustView.OrderID );
            end;
            CustViewTypes_UnCancel:
            begin
               if Assigned( fCancelEvent ) then
                  fCancelEvent( CancelUnCancel, frmCustView.OrderID );
            end;
            CustViewTypes_Return:
            begin
            	if Assigned( fReturnEvent ) then
               	fReturnEvent( frmCustView.OrderID );
            end;
         end;
      finally
      end;
   end else
   	AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0)
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerListForm.CustomerViewAccount;
var
	errRec : tErrorResult;
begin
    errRec := custQuery.Load( CustID );
    if NOT (errRec.errorResult) then
    begin
      frmCustViewAcc := TCustomer_AccountViewForm.Create( Application,
         'Transaction History | ' + custListQuery.FieldByName('FULLNAME').AsString, true, custQuery);
      frmCustViewAcc.ShowModal();
      case frmCustViewAcc.OnCloseAction of
         CustViewAcc_Close:; // do nothing
         //
         CustViewAcc_Load:
         begin
            if Assigned(fLoadOrderEvent) then
               fLoadOrderEvent( Self, frmCustViewAcc.OrderID );
         end;
         CustViewAcc_Pay:
         begin
            if Assigned(fTakeMethodOfPaymentEvent) then
               fTakeMethodOfPaymentEvent( frmCustViewAcc.OrderID );
         end;
         CustViewAcc_View:
         begin
            if Assigned( fViewInvoiceEvent ) then
               fViewInvoiceEvent( Self, frmCustViewAcc.OrderID );
         end;
         CustViewAcc_Print:
         begin
            if Assigned(fPrintInvoiceEvent) then
               fPrintInvoiceEvent( Self, frmCustViewAcc.OrderID );
         end;
         CustViewAcc_Void:
         begin
            ShowMessage('Void Payment With ID not yet');
         end;
         CustViewAcc_Return:
         begin
         	if Assigned( fReturnEvent ) then
            	fReturnEvent( frmCustViewAcc.OrderID );
         end;
      end;
   end else
   	AvoBaseDialog('Error', errRec.errorMessage, mtError, [mbok], 0)
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.

