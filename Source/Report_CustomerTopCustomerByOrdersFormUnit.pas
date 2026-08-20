 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Report_CustomerTopCustomerByOrdersFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   order_invoiceobjectunit,
   avobase_percentformunit,
   recordstructureunit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_orgtoolboxunit,
   MasterData_ReportCustomerTopCustByOrdUnit,
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
  TReport_Customer_TopCustByOrder = class(TAvoBase_ReportBase)
    QRDBChart1: TQRDBChart;
    QRChart: TQRChart;
    Series1: TPieSeries;
    ReportQuery: TQuery;
    ReportSession: TSession;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
      fReportQuery : tQuery;
      fOrgID : string;
      fStartCycleID : string;
      fEndCycleID : string;
      ferrResult : string;

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


constructor TReport_Customer_TopCustByOrder.create(Owner: tComponent );
begin
   inherited Create( Owner );
   //
   ReportSession := masterData.AvoBaseSession;
   //
   ColorDetailBand := true;
   //
   ReportLabel.Enabled := false;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Customer_TopCustByOrder.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Customer_TopCustByOrder.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
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
   SalesCycleLabel.Caption := 'Sales Cycle ' +
      startCycleRec.cname + ' to ' +
      endCycleRec.cname;
   // Our body is ready
   fReportQuery := tMasterDataReportTopCustByOrd.Create(
      masterData,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num
      );
   fReportQuery.Open();
   //
   if ( fReportQuery.RecordCount < 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';

   // Set the datasource on the tQRChart
   QRChart.Chart.Series[0].DataSource := fReportQuery;
end;

procedure TReport_Customer_TopCustByOrder.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // we do nothing
end;

function TReport_Customer_TopCustByOrder.CanPrint: string;
begin
   result := ferrResult;
end;

end.


