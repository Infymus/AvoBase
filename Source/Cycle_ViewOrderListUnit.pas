 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Cycle_ViewOrderListUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
  recordstructureunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   MasterData_CycleOrderListUnit,
   avobase_dialogformunit,
   Toolbox_PreferenceToolBoxUnit,
   AvoBase_ToolBarUnit,
   Toolbox_CustomerToolBoxUnit,
   Report_OrderListFormUnit,
   //
   ShellAPI,
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
  TCycleViewOrderListForm = class(TAvoBase_BaseForm_Menu)
    VIEWGRID_DOCK_PANEL: TPanel;
    BASE_NAVBAR_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
   private
      fLoadOrderEvent : tLoadOrderEvent;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fCycleQuery : tMasterData_BaseDataClass;
   	CycleOrderDetailListGrid : tAvoBaseDBGrid;
      CycleOrderDetailListQuery : tMasterDataCycleOrderList;
      dbNavTool : tAvoBaseDBNavigationTool;

      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure CloseForm();
      procedure StartUpForm();
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      function fGetOrderListOrgID : string;
      function fGetOrderListCycleID : string;
   public
      procedure PrintOrderList();
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property onViewOrderEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OrderListOrgID : string read fGetOrderListOrgID;
      property OrderListCycleID : string read fGetOrderListCycleID;
      procedure EmailCustomerByOrderID();
   	procedure StatBarUpdate();
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TCycleViewOrderListForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inQuery: tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   self.Width := 755;
   //
   fCycleQuery := inQuery;
   //
   CycleOrderDetailListQuery := tMasterDataCycleOrderList.Create( masterData, inQuery.ID);
   //
   CycleOrderDetailListGrid := tAvoBaseDBGrid.Create( nil, VIEWGRID_DOCK_PANEL, CycleOrderDetailListQuery, '' );
   CycleOrderDetailListGrid.Clear;
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('ONUM'), 'ORDER #', 60, clBlack, [fsBold], tarightJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('ORGNAME'), 'ORG', 60, clRed, [fsBold], taLeftJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('ODATE'), 'DATE', 90, clTeal, [], taRightJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('CUSTNAME'), 'CUSTOMER', 140, clNavy, [fsBold], taLeftJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('OTYPE'), 'OTYPE', 60, clBlack, [], taLeftJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clBlack, [fsBold], taRightJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('ITEMS'), 'ITEMS', 60, clBlack, [], taRightJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('TOTAL'), 'TOTAL', 60, clRed, [], taRightJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('PAID'), 'PAID', 60, clBlue, [], taRightJustify);
   CycleOrderDetailListGrid.Add(CycleOrderDetailListQuery.FieldByName('DISPSTATUS'), 'STATUS', 75, $00000040, [fsBold], taLeftJustify);
   CycleOrderDetailListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, CycleOrderDetailListQuery);
   //
{
   addr1Edit.Text := fCustQuery.GetFieldByName('ADDR1').AsString;
   addr2Edit.Text := fCustQuery.GetFieldByName('ADDR2').AsString;
   cityEdit.Text := fCustQuery.GetFieldByName('CITY').AsString;
   stateEdit.Text := fCustQuery.GetFieldByName('STATE').AsString;
   zipEdit.Text := fCustQuery.GetFieldByName('ZIP').AsString;
   phonehEdit.Text := fCustQuery.GetFieldByName('PHONEH').AsString;
   phonecEdit.Text := fCustQuery.GetFieldByName('PHONEC').AsString;
   phonewEdit.Text := fCustQuery.GetFieldByName('PHONEW').AsString;
   bdayEdit.Text := DateToStr(fCustQuery.GetFieldByName('BDAY').AsDateTime);
   emailEdit.Text := fCustQuery.GetFieldByName('EMAIL').AsString;
}
   //
	StartUpForm();
   StatBarUpdate();
end;


function TCycleViewOrderListForm.fGetOrderListCycleID: string;
begin
   result := CycleOrderDetailListQuery.FieldByName('C_ID').AsString;
end;

function TCycleViewOrderListForm.fGetOrderListOrgID: string;
begin
   result := CycleOrderDetailListQuery.FieldByName('ORG_ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCycleViewOrderListForm.CloseForm;
begin
	FreeAndNil(CycleOrderDetailListGrid);
   FreeAndNil(dbNavTool);
   freeAndNil(CycleOrderDetailListQuery);
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCycleViewOrderListForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_CLOSE : CloseForm();
      CMD_ORDER_LOAD:
      begin
      	if Assigned(fLoadOrderEvent) then
         begin
         	fLoadOrderEvent( Self, CycleOrderDetailListQuery.FieldByName('ID').AsString );
            Close();
         end;
      end;
      CMD_NEW_ORDER : showmessage('CMD_NEW_ORDER SAID ORDER');
      CMD_ORDER_VIEWINVOICE :
      begin
         if Assigned(fViewInvoiceEvent) then
            fViewInvoiceEvent( self, CycleOrderDetailListQuery.FieldByName('ID').AsString );
      end;
      CMD_PRINT_LIST: PrintOrderList();
      CMD_CUST_EMAIL: EmailCustomerByOrderID();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCycleViewOrderListForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   // we do absollutely nothing here because there isn't anything to do, this is a  modal, read only form.
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCycleViewOrderListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCycleViewOrderListForm.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
   CreateButtonSep;
   CreateButton( CMD_PRINT_LIST );
   CreateButtonSep;
   CreateButton( CMD_ORDER_VIEWINVOICE );
   CreateButton( CMD_CUST_EMAIL );
   CreateButton( CMD_ORDER_LOAD );
   //
   BASE_FORM_CAPTION_LABEL.Caption := CycleOrderDetailListQuery.FieldByName('ORGNAME').AsString + ' Sales Cycle ' +
      CycleOrderDetailListQuery.FieldByName('CYCLE').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCycleViewOrderListForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(CycleOrderDetailListQuery.RecNo) + ' of ' + IntToStr(CycleOrderDetailListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCycleViewOrderListForm.PrintOrderList;
var
   rpt_Order_List : TReport_Order_List;
   errMsg : string;
begin
   rpt_Order_List := TReport_Order_List.Create( Application );
   // Setup Options
   rpt_Order_List.SetOptions( OrderListOrgID,
      OrderListCycleID,
      OrderListCycleID );
   errMsg := rpt_Order_List.CanPrint;
   // Check for Errors
   if ( errMsg = '' ) then
   begin
      // Display it
      rpt_Order_List.QReport.Preview();
   end else
      AvoBaseDialog('Unable To Print Report', errMsg, mtInformation, [mbOk], 0);
   // Free it
   if (rpt_Order_List <> NIL) then
      FreeAndNil(rpt_Order_List);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCycleViewOrderListForm.EmailCustomerByOrderID;
var
   orderID : string;
   custRec : tCustRec;
   myWideString  : WideString;
   subjString : string;
begin
   orderID := CycleOrderDetailListQuery.FieldByName('ID').AsString;
   custRec := Customer_GetCustomerByOrderID( orderID );
   if ( custRec.EMAIL <> '' ) then
   begin
      if AvoBaseDialog('Send Email To ' + custRec.FULLNAME,
         'This will open up your favorite email program and allow you to send an email to ' + custRec.FULLNAME + '.\n\n' +
         'Confirm you want to send an Email?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
      begin
         subjString := Pref_GetString(tPrefConstants.RCOMP, '');
         if (subjString = '') then
            subjString := 'AvoBase Email';
         myWideString := 'mailto:' + custRec.EMAIL + '?Subject=' + subjString + '&Body=Sent via AvoBase ' + VER_NUM;
         ShellExecute(0,nil,PWideChar(myWideString),nil,nil,SW_NORMAL);
      end;
   end else
      AvoBaseDialog('Email Error', 'The selected Customer does not have an Email Address.', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

