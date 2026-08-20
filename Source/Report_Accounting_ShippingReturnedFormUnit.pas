 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Report_Accounting_ShippingReturnedFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   return_invoiceobjectunit,
   recordstructureunit,
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   MasterData_ReportShippingReturns,
   Toolbox_EarningToolBoxUnit,
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
  TReport_Accounting_ShippingReturns = class(TAvoBase_ReportBase)
    ReportQuery: TQuery;
    Band_Group: TQRGroup;
    QRLabel1: TQRLabel;
    db_cycle: TQRLabel;
    db_org: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel4: TQRLabel;
    db_onum: TQRLabel;
    db_otype: TQRLabel;
    db_retail: TQRLabel;
    db_sellat: TQRLabel;
    db_fees: TQRLabel;
    db_tax: TQRLabel;
    db_ship: TQRLabel;
    db_total: TQRLabel;
    Band_GroupFooter: TQRBand;
    ChildBand1: TQRChildBand;
    QRPShape1: TQRPShape;
    QRLabel3: TQRLabel;
    db_group_retail: TQRLabel;
    db_group_sellat: TQRLabel;
    db_group_fees: TQRLabel;
    db_group_tax: TQRLabel;
    db_group_ship: TQRLabel;
    db_group_total: TQRLabel;
    ChildBand3: TQRChildBand;
    ChildBand4: TQRChildBand;
    QRPShape2: TQRPShape;
    QRLabel6: TQRLabel;
    QRLabel23: TQRLabel;
    db_total_retail: TQRLabel;
    db_total_sellat: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel21: TQRLabel;
    db_total_fees: TQRLabel;
    db_total_tax: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel19: TQRLabel;
    db_total_ship: TQRLabel;
    db_total_total: TQRLabel;
    QRLabel17: TQRLabel;
    procedure Band_GroupBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ChildBand4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
   private
      fCycleTotal : currency;
      fReportTotal : currency;
      fOrgID : string;
      fStartCycleID : string;
      fEndCycleID : string;
      ferrResult : string;
      fShowOpen : boolean;
      fShowClosed : boolean;
      fShowCancel : boolean;
      ReturnInvoiceObj : tReturnInvoice;
      fGroupTotalRetail : currency;
      fGroupTotalSellAt : currency;
      fGroupTotalFees : currency;
      fGroupTotalTax : currency;
      fGroupTotalShip : currency;
      fGroupTotalTotal : currency;

      fReportTotalRetail : currency;
      fReportTotalSellAt : currency;
      fReportTotalFees : currency;
      fReportTotalTax : currency;
      fReportTotalShip : currency;
      fReportTotalTotal : currency;

   public
      procedure SetOptions( inOrgID, inStartCycleID, inEndCycleID : string; inOptOpen, inOptClosed, inOptCancel : boolean);
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_Accounting_ShippingReturns.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   fCycleTotal := 0;
   fReportTotal := 0;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Accounting_ShippingReturns.destroy;
begin
   FreeAndNil(	ReturnInvoiceObj );
   inherited destroy;
end;

procedure TReport_Accounting_ShippingReturns.SetOptions( inOrgID, inStartCycleID,
   inEndCycleID : string; inOptOpen, inOptClosed, inOptCancel : boolean);
var
   startCycleRec : tCycleRec;
   endCycleRec : tCycleRec;
   tempQuery: tQuery;
   fReportQuery : tMasterDataReportShippingReturns;
   errResult : tErrorResult;
begin
   //
   fOrgID := inOrgID;
   fStartCycleID := inStartCycleID;
   fEndCycleID := inEndCycleID;
   fShowOpen := inOptOpen;
   fShowClosed := inOptClosed;
   fShowCancel := inOptCancel;
   fReportTotalRetail := 0;
   fReportTotalSellAt := 0;
   fReportTotalFees := 0;
   fReportTotalTax := 0;
   fReportTotalShip := 0;
   fReportTotalTotal := 0;

   //
   ferrResult := '';
   //
   if ( fShowOpen = false ) AND ( fShowClosed = false ) AND ( fShowCancel = false ) then
   begin
      ferrResult := 'Must at least one option checked for Open, Closed or Cancelled Orders.';
      exit;
   end;

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
   SalesCycleLabel.Caption := 'Sales Cycle ' +
      startCycleRec.cname + ' to ' +
      endCycleRec.cname;
   ReportLabel.Caption := 'Org: ' + Org_GetOrgNameByOrgID( inOrgID );
   //
   // now we get all tricky tricky for pointers
   fReportQuery := tMasterDataReportShippingReturns.Create(
      masterData,
      inOrgID,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num,
      fShowOpen,
      fShowClosed,
      fShowCancel
      );
   //
   ReportQuery.SessionName := masterData.AvoBaseSession.SessionName;
   ReportQuery.SQL.text := fReportQuery.SQL.Text;
   errResult := masterData.QueryAddFields( ReportQuery );
   ReportQuery.Open();
   FreeAndNil(fReportQuery);
   //
   //
   ReportQuery.Open();
   // Is there any data?
   if ( ReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';
   //
	ReturnInvoiceObj := tReturnInvoice.Create( InvoiceTypeReport, nil, nil);
   //
   QReport.DataSet := ReportQuery;
end;

function TReport_Accounting_ShippingReturns.CanPrint: string;
begin
   result := ferrResult;
end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Accounting_ShippingReturns.Band_GroupBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_cycle.caption := Cycle_GetCycleNameByCycleID( ReportQuery.FieldByName('C_ID').AsString );
   db_org.caption := Org_GetOrgNameByOrgID( ReportQuery.FieldByName('ORG_ID').AsString );
   fCycleTotal := 0;
   fGroupTotalRetail := 0;
   fGroupTotalSellAt := 0;
   fGroupTotalFees := 0;
   fGroupTotalTax := 0;
   fGroupTotalShip := 0;
   fGroupTotalTotal := 0;
end;

// DETAIL BAND
procedure TReport_Accounting_ShippingReturns.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   ReturnInvoiceObj.Load( ReportQuery.FieldByname('ID').AsString );
   //
   db_onum.caption := ReturnInvoiceObj.Order_GetOrderNumberName;
   db_retail.caption := FormatCurrency( ReturnInvoiceObj.Amount_TotalRetail );
   db_sellat.caption := FormatCurrency( ReturnInvoiceObj.Amount_TotalSellAt );
   db_fees.caption := FormatCurrency( ReturnInvoiceObj.Amount_FeeTotal );
   db_tax.caption := FormatCurrency( ReturnInvoiceObj.Amount_TotalTax );
   db_ship.caption := FormatCurrency( ReturnInvoiceObj.Amount_ShippingTotal );
   db_total.caption := FormatCurrency( ReturnInvoiceObj.Amount_Total );
   //
   fGroupTotalRetail := fGroupTotalRetail + ReturnInvoiceObj.Amount_TotalRetail;
   fGroupTotalSellAt := fGroupTotalSellAt + ReturnInvoiceObj.Amount_TotalSellAt;
   fGroupTotalFees := fGroupTotalFees + ReturnInvoiceObj.Amount_FeeTotal;
   fGroupTotalTax := fGroupTotalTax + ReturnInvoiceObj.Amount_TotalTax;
   fGroupTotalShip := fGroupTotalShip + ReturnInvoiceObj.Amount_ShippingTotal;
   fGroupTotalTotal := fGroupTotalTotal + ReturnInvoiceObj.Amount_Total;

   fReportTotalRetail := fReportTotalRetail + ReturnInvoiceObj.Amount_TotalRetail;
   fReportTotalSellAt := fReportTotalSellAt + ReturnInvoiceObj.Amount_TotalSellAt;
   fReportTotalFees := fReportTotalFees + ReturnInvoiceObj.Amount_FeeTotal;
   fReportTotalTax := fReportTotalTax + ReturnInvoiceObj.Amount_TotalTax;
   fReportTotalShip := fReportTotalShip + ReturnInvoiceObj.Amount_ShippingTotal;
   fReportTotalTotal := fReportTotalTotal + ReturnInvoiceObj.Amount_Total;
end;

// Group Totals
procedure TReport_Accounting_ShippingReturns.ChildBand1BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_group_retail.caption := FormatCurrency( fGroupTotalRetail );
   db_group_sellat.caption := FormatCurrency( fGroupTotalSellAt );
   db_group_fees.caption := FormatCurrency( fGroupTotalFees );
   db_group_tax.caption := FormatCurrency( fGroupTotalTax );
   db_group_ship.caption := FormatCurrency( fGroupTotalShip );
   db_group_total.caption := FormatCurrency( fGroupTotalTotal );
end;


// Report Totals
procedure TReport_Accounting_ShippingReturns.ChildBand4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_total_retail.caption := FormatCurrency( fReportTotalRetail );
   db_total_sellat.caption := FormatCurrency( fReportTotalSellAt );
   db_total_fees.caption := FormatCurrency( fReportTotalFees );
   db_total_tax.caption := FormatCurrency( fReportTotalTax );
   db_total_ship.caption := FormatCurrency( fReportTotalShip );
   db_total_total.caption := FormatCurrency( fReportTotalTotal );
end;

end.

