 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Accounting_ShippingCollectedByCycleFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   recordstructureunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   order_invoiceobjectunit,
   return_invoiceobjectunit,
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   MasterData_ReportAccountingShippingCollectedByCycleUnit,
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
   tReport_Accounting_ShippingCollectedByCycle = class(TAvoBase_ReportBase)
      QRLabel1: TQRLabel;
      QRLabel2: TQRLabel;
      QRLabel3: TQRLabel;
      QRLabel4: TQRLabel;
      QRLabel5: TQRLabel;
      db_onum: TQRLabel;
      db_odate: TQRLabel;
      db_cycle: TQRLabel;
      db_dispstatus: TQRLabel;
    db_shipping: TQRLabel;
      ChildBand1: TQRChildBand;
      QRPShape1: TQRPShape;
      QRLabel11: TQRLabel;
      db_amount: TQRLabel;
      procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
      procedure ChildBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
   private
      fTotal : currency;
      fReportQuery : tMasterDataReportAccountingShippingCollectedByCycle;
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

constructor tReport_Accounting_ShippingCollectedByCycle.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor tReport_Accounting_ShippingCollectedByCycle.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure tReport_Accounting_ShippingCollectedByCycle.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
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
   fTotal := 0;
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
   fReportQuery := tMasterDataReportAccountingShippingCollectedByCycle.Create(
      masterData,
      inOrgID,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num
      );
   // Open the Report Query
   fReportQuery.Open();
   // Is there any data?
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';
   QReport.DataSet := fReportQuery;
end;


function tReport_Accounting_ShippingCollectedByCycle.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReport_Accounting_ShippingCollectedByCycle.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_onum.Caption := fReportQuery.FieldByName('ONUM').AsString;
   db_odate.Caption := fReportQuery.FieldByName('ODATE').AsString;
   db_cycle.Caption := fReportQuery.FieldByName('CYCLE').AsString;
   db_dispstatus.Caption := fReportQuery.FieldByName('DISPSTATUS').AsString;
   db_shipping.Caption := FormatCurrency( fReportQuery.FieldByName('SHIPPING').AsCurrency );
   fTotal := fTotal + fReportQuery.FieldByName('SHIPPING').AsCurrency;
end;

procedure tReport_Accounting_ShippingCollectedByCycle.ChildBand1BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_amount.Caption := FormatCurrency( fTotal );
end;

end.



