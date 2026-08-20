 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Product_QuantityOnHandFormUnit;

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
   MasterData_ReportProductQuantityOnHandUnit,
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
   TReport_Product_QuantityOnHand = class(TAvoBase_ReportBase)
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    db_orgname: TQRLabel;
    db_cycle: TQRLabel;
    db_num: TQRLabel;
    db_name: TQRLabel;
    db_qty: TQRLabel;
    db_amount: TQRLabel;
    ChildBand1: TQRChildBand;
    db_rpttotal: TQRLabel;
    QRLabel8: TQRLabel;
      procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
   private
      fReportQuery : tMasterDataReportProductList;
      fOrgID : string;
      fStartCycleID : string;
      fEndCycleID : string;
      ferrResult : string;
      fTotal : currency;
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

constructor TReport_Product_QuantityOnHand.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   ReportLabel.Enabled := false;
   SalesCycleLabel.Enabled := false;
   fTotal := 0;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Product_QuantityOnHand.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Product_QuantityOnHand.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
begin
   //
   fOrgID := inOrgID;
   fStartCycleID := inStartCycleID;
   fEndCycleID := inEndCycleID;
   //
   ferrResult := '';
   //
   fReportQuery := tMasterDataReportProductList.Create( masterData );
   fReportQuery.Open();
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data.';
   QReport.DataSet := fReportQuery;
end;

function TReport_Product_QuantityOnHand.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Product_QuantityOnHand.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_orgname.Caption := fReportQuery.FieldByName('ORGNAME').AsString;
   db_cycle.Caption := fReportQuery.FieldByName('CYCLE').AsString;
   db_num.Caption := fReportQuery.FieldByName('NUM').AsString;
   db_name.Caption := fReportQuery.FieldByName('NAME').AsString;
   db_qty.Caption := fReportQuery.FieldByName('QTY').AsString;
   db_amount.Caption := FormatCurrency( fReportQuery.FieldByName('AMOUNT').Ascurrency );
   fTotal := fTotal + fReportQuery.FieldByName('AMOUNT').Ascurrency;
end;

procedure TReport_Product_QuantityOnHand.ChildBand1BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   db_rpttotal.Caption := FormatCurrency( fTotal );
end;



end.





