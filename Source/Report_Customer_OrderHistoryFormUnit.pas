 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Customer_OrderHistoryFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
  recordstructureunit,
   masterdata_BaseDataClassUnit,
   order_invoiceobjectunit,
   return_invoiceobjectunit,
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   MasterData_CustomerOrderDetailsListUnit,
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
  TReport_Customer_OrderHistory = class(TAvoBase_ReportBase)
    db_onum: TQRLabel;
    db_orgname: TQRLabel;
    db_cycle: TQRLabel;
    db_odate: TQRLabel;
    db_orditems: TQRLabel;
    db_totalinvamount: TQRLabel;
    db_totpaid: TQRLabel;
    db_ordstatus: TQRLabel;
    db_ordtype: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    CYCLE: TQRLabel;
    PAID: TQRLabel;
    TOTAL: TQRLabel;
    STATUS: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel7: TQRLabel;
    db_addr1: TQRLabel;
    QRLabel9: TQRLabel;
    db_addr2: TQRLabel;
    QRLabel11: TQRLabel;
    db_city: TQRLabel;
    QRLabel13: TQRLabel;
    db_zip: TQRLabel;
    QRLabel15: TQRLabel;
    db_state: TQRLabel;
    QRLabel8: TQRLabel;
    db_phoneh: TQRLabel;
    QRLabel12: TQRLabel;
    db_phonec: TQRLabel;
    QRLabel16: TQRLabel;
    db_phonew: TQRLabel;
    QRLabel19: TQRLabel;
    db_bdate: TQRLabel;
    QRLabel21: TQRLabel;
    db_email: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Band_TitleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
      fReportQuery : tMasterDataCustomerOrderDetailsList;
      fCustID : string;
      ferrResult : string;
  public
      procedure SetOptions( inCustID : string);
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_Customer_OrderHistory.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Customer_OrderHistory.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Customer_OrderHistory.SetOptions( inCustID : string );
begin
   //
   fCustID := inCustID;
   //
   ferrResult := '';
   //
   SalesCycleLabel.Enabled := False;
   //
   fReportQuery := tMasterDataCustomerOrderDetailsList.Create( masterData, fCustID );
   fReportQuery.Open();
   // Is there any data?
   if ( fReportQuery.RecordCount < 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';
   //
   QReport.DataSet := fReportQuery;
end;



function TReport_Customer_OrderHistory.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


procedure TReport_Customer_OrderHistory.Band_TitleBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
var
   custRec : tCustRec;
begin
   inherited;
   //
   custRec := Customer_GetCustomerByCustID( fCustID );
   //
   ReportNameLabel.caption := custRec.FULLNAME;
   //
   db_addr1.caption := custRec.ADDR1;
   db_addr2.caption := custRec.addr2;
   db_city.caption := custRec.city;
   db_state.caption := custRec.state;
   db_zip.caption := custRec.zip;
   db_phoneh.caption := custRec.phoneh;
   db_phonec.caption := custRec.phonec;
   db_phonew.caption := custRec.phonew;
   db_bdate.caption := datetostr( custRec.BDAY );
   db_email.caption := custRec.email;
end;

// Detail

procedure TReport_Customer_OrderHistory.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_onum.caption := fReportQuery.fieldbyname('ONUM').AsString;
   db_orgname.caption := fReportQuery.fieldbyname('ORGNAME').AsString;
   db_cycle.caption := fReportQuery.fieldbyname('CYCLE').AsString;
   db_odate.caption := fReportQuery.fieldbyname('ODATE').AsString;
   db_orditems.caption := fReportQuery.fieldbyname('ORDITEMS').AsString;
   db_totalinvamount.caption := fReportQuery.fieldbyname('TOTALINVAMOUNT').AsString;
   db_totpaid.caption := fReportQuery.fieldbyname('TOTPAID').AsString;
   db_ordstatus.caption := fReportQuery.fieldbyname('ORDSTATUS').AsString;
   db_ordtype.caption := fReportQuery.fieldbyname('ORDTYPE').AsString;
end;

end.




