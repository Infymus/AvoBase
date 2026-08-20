 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


unit Report_Customer_OutstandingBalanceFormUnit;

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
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_orgtoolboxunit,
   MasterData_ReportCustomerBalanceDueUnit,
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
   tReport_Customer_OutstandingBalance = class(TAvoBase_ReportBase)
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    db_cname: TQRLabel;
    db_custdata: TQRLabel;
    db_amtord: TQRLabel;
    db_amtmop: TQRLabel;
    db_amtret: TQRLabel;
    db_amtrev: TQRLabel;
    db_amtdue: TQRLabel;
    db_total: TQRLabel;
    ChildBand1: TQRChildBand;
    QRPShape1: TQRPShape;
    QRLabel9: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
   private
      fReportQuery : tMasterDataCustomerBalanaceDue;
      fCustID : string;
      ferrResult : string;
      fReportTotal : currency;
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

constructor tReport_Customer_OutstandingBalance.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor tReport_Customer_OutstandingBalance.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure tReport_Customer_OutstandingBalance.SetOptions( inCustID : string );
begin
   //
   fCustID := inCustID;
   //
   ferrResult := '';
   //
   SalesCycleLabel.Enabled := False;
   ReportLabel.Enabled := False;
   //
   fReportQuery := tMasterDataCustomerBalanaceDue.Create( masterData );
   fReportQuery.Open();
   // Is there any data?
   if ( fReportQuery.RecordCount <= 0 ) then
      ferrResult := 'There are no Customers with outstanding balances due..';
   //
   QReport.DataSet := fReportQuery;
   fReportTotal := 0;
end;



function tReport_Customer_OutstandingBalance.CanPrint: string;
begin
   result := ferrResult;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// Detail

procedure tReport_Customer_OutstandingBalance.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_cname.Caption := fReportQuery.FieldByName('CNAME').AsString;
   db_custdata.Caption := 'H ' + fReportQuery.FieldByName('PHONEH').AsString +
      ' C ' + fReportQuery.FieldByName('PHONEC').AsString;
   db_amtord.Caption := fReportQuery.FieldByName('AMTORD').AsString;
   db_amtmop.Caption := fReportQuery.FieldByName('AMTMOP').AsString;
   db_amtret.Caption := fReportQuery.FieldByName('AMTRET').AsString;
   db_amtrev.Caption := fReportQuery.FieldByName('AMTREV').AsString;
   db_amtdue.Caption := fReportQuery.FieldByName('AMTDUE').AsString;
   //
   fReportTotal := fReportTotal + fReportQuery.FieldByName('AMTDUE').AsCurrency;
   {

         fQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
         fQuery.FieldByName('CNAME').AsString := fCustQuery.FieldByName('FNAME').AsString +
            ' ' + fQuery.FieldByName('LNAME').AsString;
         fQuery.FieldByName('ADDR1').AsString := fCustQuery.FieldByName('ADDR1').AsString;
         fQuery.FieldByName('CITY').AsString := fCustQuery.FieldByName('CITY').AsString;
         fQuery.FieldByName('STATE').AsString := fCustQuery.FieldByName('STATE').AsString;
         fQuery.FieldByName('ZIP').AsString := fCustQuery.FieldByName('ZIP').AsString;
         fQuery.FieldByName('PHONEH').AsString := fCustQuery.FieldByName('PHONEH').AsString;
         fQuery.FieldByName('PHONEC').AsString := fCustQuery.FieldByName('PHONEC').AsString;
         fQuery.FieldByName('PHONEW').AsString := fCustQuery.FieldByName('PHONEW').AsString;
         fQuery.FieldByName('EMAIL').AsString := fCustQuery.FieldByName('EMAIL').AsString;
         fQuery.FieldByName('AMTDUE').AsCurrency := fAmountDue;
         fQuery.FieldByName('AMTREV').AsCurrency := fRevAmount;
         fQuery.FieldByName('AMTORD').AsCurrency := fOrderAmountDue;
         fQuery.FieldByName('AMTRET').AsCurrency := fReturnAmountRefund;
         fQuery.FieldByName('AMTMOP').AsCurrency := fMOPAmount;
   }

end;

procedure tReport_Customer_OutstandingBalance.ChildBand1BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_total.Caption := FormatCurrency( fReportTotal );
end;

end.


