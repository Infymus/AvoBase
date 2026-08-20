 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


unit Report_Product_ReturnProductListFormUnit;

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
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   MasterData_ReportProductReturnListUnit,
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
  TReport_Product_ReturnProductList = class(TAvoBase_ReportBase)
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    db_orgname: TQRLabel;
    db_cycle: TQRLabel;
    db_num: TQRLabel;
    db_name: TQRLabel;
    db_qty: TQRLabel;
    db_rcost: TQRLabel;
    db_stat: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
      fReportQuery : tMasterData_ProductBOTempList;
      fPrintPend : boolean;
      fPrintReturned : boolean;
      fPrintRestocked : boolean;
      ferrResult : string;
  public
      procedure SetOptions( PrintPend, PrintReturned, PrintRestocked : Boolean );
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_Product_ReturnProductList.create(Owner: tComponent );
begin
   inherited Create( Owner );
   //
   ColorDetailBand := true;
   ReportLabel.Enabled := false;
   SalesCycleLabel.Enabled := false;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Product_ReturnProductList.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Product_ReturnProductList.SetOptions( PrintPend, PrintReturned, PrintRestocked : Boolean );
begin
   //
   fPrintPend := PrintPend;
   fPrintReturned := PrintReturned;
   fPrintRestocked := PrintRestocked;
   //
   ferrResult := '';
   //
   fReportQuery := tMasterData_ProductBOTempList.Create( masterData, fPrintPend, fPrintReturned, fPrintRestocked );
   fReportQuery.Open();
   // Is there any data?
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data.';
   QReport.DataSet := fReportQuery;
end;



function TReport_Product_ReturnProductList.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Product_ReturnProductList.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_orgname.Caption := fReportQuery.FieldByName('ORGNAME').AsString;
   db_cycle.Caption := fReportQuery.FieldByName('CYCLE').AsString;
   db_num.Caption := fReportQuery.FieldByName('NUM').AsString;
   db_name.Caption := fReportQuery.FieldByName('NAME').AsString;
   db_qty.Caption := fReportQuery.FieldByName('QTY').AsString;
   db_rcost.Caption := fReportQuery.FieldByName('RCOST').AsString;
   db_stat.Caption := fReportQuery.FieldByName('STAT').AsString;
end;

end.

