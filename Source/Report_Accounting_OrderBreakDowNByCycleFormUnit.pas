 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Accounting_OrderBreakDowNByCycleFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   recordstructureunit,
   order_invoiceobjectunit,
   return_invoiceobjectunit,
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   MasterData_ReportAccountingOrderAmountByCycleUnit,
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
   tReport_Accounting_OrderAmountBreakDownByCycle = class(TAvoBase_ReportBase)
      Band_Group: TQRGroup;
      QRLabel1: TQRLabel;
      db_cycle: TQRLabel;
      Band_GroupFooter: TQRBand;
      ChildBand1: TQRChildBand;
      ChildBand3: TQRChildBand;
      ReportQuery: TQuery;
      db_org: TQRLabel;
      db_onum: TQRLabel;
    db_rcost: TQRLabel;
    db_scost: TQRLabel;
      db_fees: TQRLabel;
      db_mop: TQRLabel;
      db_tax: TQRLabel;
      db_ship: TQRLabel;
      db_profit: TQRLabel;
      db_loss: TQRLabel;
      db_total: TQRLabel;
      QRLabel2: TQRLabel;
      QRLabel5: TQRLabel;
      QRLabel7: TQRLabel;
      QRLabel8: TQRLabel;
      QRLabel9: TQRLabel;
      QRLabel10: TQRLabel;
      QRLabel11: TQRLabel;
      QRLabel12: TQRLabel;
      QRLabel13: TQRLabel;
      QRLabel14: TQRLabel;
      QRLabel4: TQRLabel;
      db_otype: TQRLabel;
    ChildBand4: TQRChildBand;
    QRPShape1: TQRPShape;
    QRLabel3: TQRLabel;
    db_group_rcost: TQRLabel;
    db_group_scost: TQRLabel;
    db_group_fees: TQRLabel;
    db_group_tax: TQRLabel;
    db_group_ship: TQRLabel;
    db_group_mop: TQRLabel;
    db_group_total: TQRLabel;
    db_group_loss: TQRLabel;
    db_group_profit: TQRLabel;
    QRPShape2: TQRPShape;
    QRLabel6: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    db_total_loss: TQRLabel;
    db_total_profit: TQRLabel;
    db_total_rcost: TQRLabel;
    db_total_scost: TQRLabel;
    db_total_fees: TQRLabel;
    db_total_tax: TQRLabel;
    db_total_ship: TQRLabel;
    db_total_mop: TQRLabel;
    db_total_total: TQRLabel;
    QRLabel24: TQRLabel;
    db_ycost: TQRLabel;
    db_group_ycost: TQRLabel;
    QRLabel25: TQRLabel;
    db_total_ycost: TQRLabel;
      procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
      procedure Band_GroupBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
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
      InvoiceObj : tInvoice;
      fGroupTotalProfit : currency;
      fGroupTotalLoss : currency;
      fReportTotalProfit : currency;
      fReportTotalLoss : currency;
      fGroupTotalRCOST: currency;
      fGroupTotalSCOST: currency;
      fGroupTotalYCOST: currency;
      fGroupTotalFees : currency;
      fGroupTotalTax : currency;
      fGroupTotalShip : currency;
      fGroupTotalMOP : currency;
      fGroupTotalTotal : currency;

      fReportTotalRCOST: currency;
      fReportTotalSCOST: currency;
      fReportTotalYCOST: currency;
      fReportTotalFees : currency;
      fReportTotalTax : currency;
      fReportTotalShip : currency;
      fReportTotalMOP : currency;
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

constructor TReport_Accounting_OrderAmountBreakDownByCycle.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   fCycleTotal := 0;
   fReportTotal := 0;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Accounting_OrderAmountBreakDownByCycle.destroy;
begin
   FreeAndNil(	InvoiceObj );
   inherited destroy;
end;

procedure TReport_Accounting_OrderAmountBreakDownByCycle.SetOptions( inOrgID, inStartCycleID,
   inEndCycleID : string; inOptOpen, inOptClosed, inOptCancel : boolean);
var
   startCycleRec : tCycleRec;
   endCycleRec : tCycleRec;
   tempQuery: tQuery;
   fReportQuery : tMasterDataReportOrderAmountBreakDownByCycle;
   errResult : tErrorResult;
begin
   //
   fOrgID := inOrgID;
   fStartCycleID := inStartCycleID;
   fEndCycleID := inEndCycleID;
   fShowOpen := inOptOpen;
   fShowClosed := inOptClosed;
   fShowCancel := inOptCancel;
   fGroupTotalProfit := 0;
   fGroupTotalLoss := 0;
   fReportTotalProfit := 0;
   fReportTotalLoss := 0;
   fReportTotalRCOST:= 0;
   fReportTotalYCOST:= 0;
   fReportTotalSCOST:= 0;
   fReportTotalFees := 0;
   fReportTotalTax := 0;
   fReportTotalShip := 0;
   fReportTotalMOP := 0;
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
   fReportQuery := tMasterDataReportOrderAmountBreakDownByCycle.Create(
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
	InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
   //
   QReport.DataSet := ReportQuery;
end;

function TReport_Accounting_OrderAmountBreakDownByCycle.CanPrint: string;
begin
   result := ferrResult;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Accounting_OrderAmountBreakDownByCycle.Band_GroupBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_cycle.caption := Cycle_GetCycleNameByCycleID( ReportQuery.FieldByName('C_ID').AsString );
   db_org.caption := Org_GetOrgNameByOrgID( ReportQuery.FieldByName('ORG_ID').AsString );
   fCycleTotal := 0;
   fGroupTotalProfit := 0;
   fGroupTotalLoss := 0;
   fGroupTotalRCOST:= 0;
   fGroupTotalSCOST:= 0;
   fGroupTotalYCOST:= 0;
   fGroupTotalFees := 0;
   fGroupTotalTax := 0;
   fGroupTotalShip := 0;
   fGroupTotalMOP := 0;
   fGroupTotalTotal := 0;
end;


// DETAIL BAND
procedure TReport_Accounting_OrderAmountBreakDownByCycle.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
var
   amt_SCOST: currency;
   amt_YCOST : currency;
   amtProfit : currency;
   amtLoss : currency;
begin
   inherited;
   //
   InvoiceObj.Load( ReportQuery.FieldByname('ID').AsString );
   //
   db_onum.caption := InvoiceObj.Order_GetOrderNumberName;
   db_rcost.caption := FormatCurrency( InvoiceObj.Amount_Total_RCOST);
   db_scost.caption := FormatCurrency( InvoiceObj.Amount_Total_SCOST);
   db_ycost.caption := FormatCurrency( InvoiceObj.Amount_Total_YCOST);
   db_fees.caption := FormatCurrency( InvoiceObj.Amount_FeeTotal );
   db_mop.caption := FormatCurrency( InvoiceObj.Amount_TotalMOP );
   db_tax.caption := FormatCurrency( InvoiceObj.Amount_TotalTax );
   db_ship.caption := FormatCurrency( InvoiceObj.Amount_ShippingSubTotal );
   db_total.caption := FormatCurrency( InvoiceObj.Amount_Total );
   //
   fGroupTotalYCOST := fGroupTotalYCOST + InvoiceObj.Amount_Total_YCOST;
   fGroupTotalRCOST:= fGroupTotalRCOST + InvoiceObj.Amount_Total_RCOST;
   fGroupTotalSCOST := fGroupTotalSCOST + InvoiceObj.Amount_Total_SCOST;

   fGroupTotalFees := fGroupTotalFees + InvoiceObj.Amount_FeeTotal;
   fGroupTotalTax := fGroupTotalTax + InvoiceObj.Amount_TotalTax;
   fGroupTotalShip := fGroupTotalShip + InvoiceObj.Amount_ShippingSubTotal;
   fGroupTotalMOP := fGroupTotalMOP + InvoiceObj.Amount_TotalMOP;
   fGroupTotalTotal := fGroupTotalTotal + InvoiceObj.Amount_Total;

   fReportTotalYCOST := fReportTotalYCOST + InvoiceObj.Amount_Total_YCOST;
   fReportTotalSCOST := fReportTotalSCOST + InvoiceObj.Amount_Total_SCOST;
   fReportTotalRCOST := fReportTotalRCOST + InvoiceObj.Amount_Total_RCOST;

   fReportTotalFees := fReportTotalFees + InvoiceObj.Amount_FeeTotal;
   fReportTotalTax := fReportTotalTax + InvoiceObj.Amount_TotalTax;
   fReportTotalShip := fReportTotalShip + InvoiceObj.Amount_ShippingSubTotal;
   fReportTotalMOP := fReportTotalMOP + InvoiceObj.Amount_TotalMOP;
   fReportTotalTotal := fReportTotalTotal + InvoiceObj.Amount_Total;


   //
   amt_SCOST := InvoiceObj.Amount_Total_SCOST;
   amt_YCOST := InvoiceObj.Amount_Total_YCOST;

   amtProfit := 0;
   amtLoss := 0;
   //
   if ( amt_SCOST > amt_YCOST ) then
      amtProfit := ( amt_SCOST - amt_YCOST );

   if ( amt_SCOST < amt_YCOST ) then
      amtLoss := ( amt_YCOST - amt_SCOST );

{
   if ( amtSellAt > amtRetail ) then
      amtProfit := ( amtSellAt - amtRetail );
   if ( amtSellAt < amtRetail ) then
      amtLoss := ( amtRetail - amtSellAt );
}



   //
   if ( amtProfit > 0 ) then
   begin
      fGroupTotalProfit := fGroupTotalProfit + amtProfit;
      fReportTotalProfit := fGroupTotalProfit + amtProfit;
   end else
   begin
      fGroupTotalProfit := fGroupTotalProfit - amtProfit;
      fReportTotalProfit := fGroupTotalProfit - amtProfit;
   end;
   //
   if ( amtLoss > 0 ) then
   begin
      fGroupTotalLoss := fGroupTotalLoss + amtLoss;
      fReportTotalLoss := fReportTotalLoss + amtLoss;
   end else
   begin
      fGroupTotalLoss := fGroupTotalLoss - amtLoss;
      fReportTotalLoss := fReportTotalLoss - amtLoss;
   end;
   //
   db_profit.caption := FormatCurrency( amtProfit );
   db_loss.caption := FormatCurrency( amtLoss );
end;


// Group Totals
procedure tReport_Accounting_OrderAmountBreakDownByCycle.ChildBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_group_loss.caption := FormatCurrency( fGroupTotalLoss );
   db_group_profit.caption := FormatCurrency( fGroupTotalProfit );


   db_group_RCOST.caption := FormatCurrency( fGroupTotalRCOST);
   db_group_SCOST.caption := FormatCurrency( fGroupTotalSCOST);
   db_group_YCOST.caption := FormatCurrency( fGroupTotalYCOST);
   db_group_fees.caption := FormatCurrency( fGroupTotalFees );
   db_group_tax.caption := FormatCurrency( fGroupTotalTax );
   db_group_ship.caption := FormatCurrency( fGroupTotalShip );
   db_group_mop.caption := FormatCurrency( fGroupTotalMOP );
   db_group_total.caption := FormatCurrency( fGroupTotalTotal );
end;

// Report Totals
procedure tReport_Accounting_OrderAmountBreakDownByCycle.ChildBand1BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_total_loss.caption := FormatCurrency( fReportTotalLoss );
   db_total_profit.caption := FormatCurrency( fReportTotalProfit );
   db_total_RCOST.caption := FormatCurrency( fReportTotalRCOST);
   db_total_SCOST.caption := FormatCurrency( fReportTotalSCOST);
   db_total_YCOST.caption := FormatCurrency( fReportTotalYCOST);
   db_total_fees.caption := FormatCurrency( fReportTotalFees );
   db_total_tax.caption := FormatCurrency( fReportTotalTax );
   db_total_ship.caption := FormatCurrency( fReportTotalShip );
   db_total_mop.caption := FormatCurrency( fReportTotalMOP );
   db_total_total.caption := FormatCurrency( fReportTotalTotal );
end;


end.


