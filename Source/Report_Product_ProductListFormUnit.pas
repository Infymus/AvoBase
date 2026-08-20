 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Report_Product_ProductListFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   order_invoiceobjectunit,
   return_invoiceobjectunit,
   recordstructureunit,
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   MasterData_Report_ProductListUnit,
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
   tReport_Product_ProductList = class(TAvoBase_ReportBase)
      QRLabel1: TQRLabel;
      QRLabel2: TQRLabel;
      QRLabel3: TQRLabel;
      QRLabel4: TQRLabel;
      QRLabel5: TQRLabel;
      db_cycle: TQRLabel;
      db_num: TQRLabel;
      db_name: TQRLabel;
      db_qty: TQRLabel;
      db_amount: TQRLabel;
      procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
   private
      fReportQuery : tMasterDataReportProductList;
      fOrgID : string;
      fStartCycleID : string;
      fEndCycleID : string;
      ferrResult : string;
   public
      procedure SetOptions( inOrgID, inStartCycleID, inEndCycleID : string; inSortType : tSortProdTypes );
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_Product_ProductList.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Product_ProductList.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Product_ProductList.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string; inSortType : tSortProdTypes );
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
   //
   ReportLabel.Caption := 'Org: ' + Org_GetOrgNameByOrgID( inOrgID );
   // Create the Report Query and pass to it whatever required...
   fReportQuery := tMasterDataReportProductList.Create(
      masterData,
      inOrgID,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num
      );
   //
   fReportQuery.SortType := inSortType;
   // Open the Report Query
   fReportQuery.Update();
   // Is there any data?
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';
   QReport.DataSet := fReportQuery;
end;

function TReport_Product_ProductList.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Product_ProductList.Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_cycle.Caption := fReportQuery.FieldByName('CYCLE').AsString;
   db_num.Caption := fReportQuery.FieldByName('NUM').AsString;
   db_name.Caption := fReportQuery.FieldByName('NAME').AsString;
   db_qty.Caption := fReportQuery.FieldByName('QTY').AsString;
   db_amount.Caption := FormatCurrency( fReportQuery.FieldByName('AMOUNT').AsCurrency );
end;



end.

