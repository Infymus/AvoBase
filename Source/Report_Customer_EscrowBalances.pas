 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
 unit Report_Customer_EscrowBalances;

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
   MasterData_Report_CustomerEscrowBalances,
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
   TReport_CustomerEscrowBalance = class(TAvoBase_ReportBase)
    ChildBand1: TQRChildBand;
    db_amount: TQRLabel;
    QRLabel11: TQRLabel;
    QRPShape1: TQRPShape;
    QRLabel1: TQRLabel;
    db_amounttotal: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    db_custname: TQRLabel;
    db_amountescrow: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
   private
      fReportQuery : tMasterDataReport_CustomerEscrowList;
      ferrResult : string;
      fAmountTotal : currency;
   public
      procedure SetOptions();
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_CustomerEscrowBalance.create(Owner: tComponent);
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_CustomerEscrowBalance.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_CustomerEscrowBalance.SetOptions();
begin
   ferrResult := '';
   fAmountTotal := 0;

   //
   ReportLabel.Enabled := false;
   SalesCycleLabel.Enabled := false;

   //
   fReportQuery := tMasterDataReport_CustomerEscrowList.Create( masterData );

   // Open the Report Query
   fReportQuery.Open();

   // Is there any data?
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'No Customer Escrow Balances found. Report contains no data.';

   QReport.DataSet := fReportQuery;
end;

procedure TReport_CustomerEscrowBalance.Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   fAmountTotal := fAmountTotal + fReportQuery.FieldByName('AMOUNT').AsCurrency;
   db_custname.Caption := fReportQuery.FieldByName('CNAME').AsString;
   db_amountescrow.Caption := FormatCurrency(fReportQuery.FieldByName('AMOUNT').AsCurrency);
end;

function TReport_CustomerEscrowBalance.CanPrint: string;
begin
   result := ferrResult;
end;


procedure TReport_CustomerEscrowBalance.ChildBand1BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   db_amounttotal.Caption := FormatCurrency(fAmountTotal);
end;

end.
