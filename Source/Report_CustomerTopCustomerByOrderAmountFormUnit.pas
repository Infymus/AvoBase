 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_CustomerTopCustomerByOrderAmountFormUnit;

Interface Uses
   Actnlist,
   Avobase_Percentformunit,
   Bde,
   Buttons,
   Chart,
   Classes,
   Comctrls,
   Constantsunit,
   Controls,
   Customer_Selectformunit,
   Db,
   Dbchart,
   Dbtables,
   Dialogs,
   Errorresultunit,
   Extctrls,
   Forms,
   Graphics,
   Img_Storageformunit,
   Mask,
   Masterdata_Basedataclassunit,
   Masterdata_Reportcustomertopcustbyordamountunit,
   Masterdataunit,
   Messages,
   Order_Invoiceobjectunit,
   Qrctrls,
   Qrexport,
   Qrpctrls,
   Qrpdffilt,
   Qrtee,
   Qrwebfilt,
   Quickrpt,
   Recordstructureunit,
   Report_Baseform,
   Series,
   Stdctrls,
   Sysutils,
   Teengine,
   Teeprocs,
   Themes,
   Toolbox_Customertoolboxunit,
   Toolbox_Cycletoolboxunit,
   Toolbox_Ordertoolboxunit,
   Toolbox_Orgtoolboxunit,
   Toolbox_Preferencetoolboxunit,
   Toolboxunit,
   Toolwin,
   Variants,
   Windows;


type
  TReport_Customer_TopCustByOrderAmount = class(TAvoBase_ReportBase)
    QRChart: TQRChart;
    QRDBChart1: TQRDBChart;
    Series1: TPieSeries;
    ReportQuery: TQuery;
    ReportSession: TSession;
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


constructor TReport_Customer_TopCustByOrderAmount.create(Owner: tComponent );
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

destructor TReport_Customer_TopCustByOrderAmount.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Customer_TopCustByOrderAmount.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
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
   fReportQuery := tMasterDataReportTopCustByOrdAmount.Create(
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

function TReport_Customer_TopCustByOrderAmount.CanPrint: string;
begin
   result := ferrResult;
end;

end.


