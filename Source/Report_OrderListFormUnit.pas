 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_OrderListFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
  recordstructureunit,
   Order_InvoiceObjectUnit,
   Return_InvoiceObjectUnit,
   avobase_percentformunit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_orgtoolboxunit,
   MasterData_ReportOrderListUnit,
   Toolbox_CycleToolBoxUnit,
   //
   db,
   bde,
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
   Themes,
   stdctrls,
   extctrls,
   ComCtrls,
   ToolWin,
   Mask,
   Buttons,
   QuickRpt,
   dbtables,
   QRPDFFilt,
   QRWebFilt,
   QRExport,
   QRCtrls,
   qrpctrls,
   Report_BaseForm,
   TeEngine,
   Series,
   TeeProcs,
   Chart,
   DBChart,
   QrTee;

type
   tReport_Order_List = class(TAvoBase_ReportBase)
    db_type: TQRLabel;
    db_num: TQRLabel;
    db_cycle: TQRLabel;
    db_date: TQRLabel;
    db_customer: TQRLabel;
    db_items: TQRLabel;
    db_total: TQRLabel;
    db_mop: TQRLabel;
    db_status: TQRLabel;
    db_group_type: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
   private
      fReportQuery : tQuery;
      fOrgID : string;
      fStartCycleID : string;
      fEndCycleID : string;
      ferrResult : string;
      InvoiceObj : tInvoice;
      ReturnObj : tReturnInvoice;
  public
      procedure SetOptions( inOrgID, inStartCycleID, inEndCycleID : string);
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_Order_List.create(Owner: tComponent );
begin
   inherited Create( Owner );
   //
	InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
	ReturnObj := tReturnInvoice.Create( InvoiceTypeReport, nil, nil);
   //
//   ReportSession := masterData.AvoBaseSession;
   //
   ColorDetailBand := true;
//   Band_Title.Enabled := false;
   //
   ReportLabel.Enabled := false;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Order_List.destroy;
begin
   FreeAndNil( fReportQuery );
   FreeAndNil( InvoiceObj );
   FreeAndNil( ReturnObj );
   //
   inherited destroy;
end;

procedure TReport_Order_List.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
var
   startCycleRec : tCycleRec;
   endCycleRec : tCycleRec;
   cycleQuery : tQuery;
begin
   //
   fOrgID := inOrgID;
   fStartCycleID := inStartCycleID;
   fEndCycleID := inEndCycleID;
   //
   ferrResult := '';
   //
   startCycleRec := Cycle_GetCycleByCycleID( fStartCycleID );
   endCycleRec := Cycle_GetCycleByCycleID( fEndCycleID );
   //
   if ( endCycleRec.year < startCycleRec.year ) then
   begin
      ferrResult := 'Ending Sales Cycle cannot be less than the Starting Sales Cycle.';
      exit;
   end;
   //
   SalesCycleLabel.Caption := 'Sales Cycle ' + startCycleRec.cname + ' to ' + endCycleRec.cname;

   // Our body is ready
   fReportQuery := tMasterDataReportOrderList.Create(
      masterData,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num
      );
   fReportQuery.Open();

   //
   if ( fReportQuery.RecordCount = 0 ) then
   begin
      ferrResult := 'Report contains no data for selected Sales Cycles.';
      exit;
   end;

   //
   QReport.DataSet := fReportQuery;
end;

function TReport_Order_List.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReport_Order_List.Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   case fReportQuery.FieldByname('O_TYPE').AsInteger of
      integer(OrdTypeOrder):
      begin
         InvoiceObj.Load( fReportQuery.FieldByname('ID').AsString );
         db_num.caption := InvoiceObj.Order_GetOrderNumberName;
         db_type.caption := InvoiceObj.Order_GetOrderTypeName;
         db_cycle.caption := InvoiceObj.Cycle_GetCycleName;
         db_customer.caption := InvoiceObj.Customer_GetSoldToName;
         db_items.caption := IntToStr( InvoiceObj.LineItemCount );
         db_total.caption := Pref_GetCashSymbol + FormatCurrency( InvoiceObj.Amount_Total );
         db_mop.caption := Pref_GetCashSymbol + FormatCurrency( InvoiceObj.Amount_TotalMOP );
         db_status.caption := InvoiceObj.Order_GetOrderStatusName;
         db_date.Caption := DateToStr( InvoiceObj.Order_GetORderDate );

{
         DataSet.FieldByName('CUSTNAME').AsString := InvoiceObj.Customer_GetSoldToName;
         DataSet.FieldByName('ORGNAME').AsString := InvoiceObj.Org_GetOrgName;
         DataSet.FieldByName('OTYPE').AsString := 'ORDER';
         DataSet.FieldByName('CYCLE').AsString := InvoiceObj.Cycle_GetCycleName;
         DataSet.FieldByName('ITEMS').asInteger := InvoiceObj.LineItemCount;
         DataSet.FieldByName('TOTAL').AsCurrency := InvoiceObj.Amount_Total;
         DataSet.FieldByName('PAID').AsCurrency := InvoiceObj.Amount_TotalMOP - invoiceObj.Amount_VoidNSF;
         DataSet.FieldByname('BOI').AsInteger := InvoiceObj.BackOrderCount;
         DataSet.FieldByName('DISPSTATUS').AsString := InvoiceObj.Order_GetOrderStatusName;
}
      end;
      integer(OrdTypeReturn):
      begin
         ReturnObj.Load( fReportQuery.FieldByname('ID').AsString );
         db_num.caption := ReturnObj.Order_GetOrderNumberName;
         db_type.caption := ReturnObj.Order_GetOrderTypeName;
         db_cycle.caption := ReturnObj.Cycle_GetCycleName;
         db_customer.caption := ReturnObj.Customer_GetSoldToName;
         db_num.caption := ReturnObj.Order_GetOrderNumberName;
         db_type.caption := ReturnObj.Order_GetOrderTypeName;
         db_cycle.caption := ReturnObj.Cycle_GetCycleName;
         db_customer.caption := ReturnObj.Customer_GetSoldToName;
         db_items.caption := IntToStr( ReturnObj.LineItemCount );
         db_total.caption := Pref_GetCashSymbol + FormatCurrency( ReturnObj.Amount_TotalRefund );
         db_mop.caption := '';
         db_status.caption := ReturnObj.Order_GetOrderStatusName;
         db_date.Caption := DateToStr( ReturnObj.Order_GetOrderDate );
{
         DataSet.FieldByName('CUSTNAME').AsString := ReturnObj.CustName;
         DataSet.FieldByName('ORGNAME').AsString := ReturnObj.OrgName;
         DataSet.FieldByName('OTYPE').AsString := 'RETURN';
         DataSet.FieldByName('CYCLE').AsString := ReturnObj.CycleName;
         DataSet.FieldByName('ITEMS').asInteger := ReturnObj.LineItemCount;
         DataSet.FieldByName('TOTAL').AsCurrency := ReturnObj.Amount_TotalRefund;
         DataSet.FieldByName('PAID').AsCurrency := 0.00;
         DataSet.FieldByname('BOI').AsInteger := 0;
         DataSet.FieldByName('DISPSTATUS').AsString := ReturnObj.OrderStatusName;
}
      end;
   end;
end;


end.



