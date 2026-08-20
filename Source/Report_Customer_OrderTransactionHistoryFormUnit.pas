 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Customer_OrderTransactionHistoryFormUnit;

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
   MasterData_TransactionListUnit,
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
  TReport_Customer_OrderTransactionHistory = class(TAvoBase_ReportBase)
    QRLabel1: TQRLabel;
    db_totorders: TQRLabel;
    QRLabel3: TQRLabel;
    db_returns: TQRLabel;
    QRLabel5: TQRLabel;
    db_cancel: TQRLabel;
    QRLabel7: TQRLabel;
    db_amountorder: TQRLabel;
    QRLabel9: TQRLabel;
    db_amountmop: TQRLabel;
    QRLabel11: TQRLabel;
    db_amountreturn: TQRLabel;
    QRLabel13: TQRLabel;
    db_amountvoid: TQRLabel;
    QRLabel15: TQRLabel;
    db_amounttranscredit: TQRLabel;
    QRLabel17: TQRLabel;
    db_amounttransdebit: TQRLabel;
    QRLabel19: TQRLabel;
    db_amountescrow: TQRLabel;
    AmouneDueLabel: TQRLabel;
    db_totowed: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    db_tdate: TQRLabel;
    db_transtype: TQRLabel;
    db_ordnum: TQRLabel;
    db_transtat: TQRLabel;
    db_tamt: TQRLabel;
    procedure Band_TitleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
      fReportQuery : tMasterDataCustomerAccountList;
      fCustID : string;
      fStartCycleID : string;
      fEndCycleID : string;
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

constructor TReport_Customer_OrderTransactionHistory.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Customer_OrderTransactionHistory.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Customer_OrderTransactionHistory.SetOptions( inCustID : string );
begin
   //
   fCustID := inCustID;
   //
   ferrResult := '';
   //
   SalesCycleLabel.Enabled := false;
   fReportQuery := tMasterDataCustomerAccountList.Create( masterData, fCustID );
   fReportQuery.Open();
   // Is there any data?
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data.';
   QReport.DataSet := fReportQuery;
end;



function TReport_Customer_OrderTransactionHistory.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Customer_OrderTransactionHistory.Band_TitleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
   custRec : tCustRec;
begin
   inherited;
   //
   db_totorders.Caption := IntToStr( fReportQuery.TotalOrders );
	db_returns.Caption := IntToStr( fReportQuery.TotalReturns );
	db_cancel.Caption := IntToStr( fReportQuery.TotalCancels );
   //
   db_AmountOrder.Caption := Pref_GetCashSymbol + FormatCurrency(fReportQuery.AmountOrder);
   DB_AmountMOP.Caption := Pref_GetCashSymbol + FormatCurrency(fReportQuery.AmountMOP);
   db_AmountReturn.Caption := Pref_GetCashSymbol + FormatCurrency(fReportQuery.AmountReturn);
   DB_AmountTransDebit.Caption := Pref_GetCashSymbol + FormatCurrency( fReportQuery.AmountTransDebit );
   DB_AmountTransCredit.Caption := Pref_GetCashSymbol + FormatCurrency( fReportQuery.AmountTransCredit );
   DB_AmountVoid.Caption := Pref_GetCashSymbol + FormatCurrency(fReportQuery.AmountVoid);
   DB_AmountEscrow.Caption := Pref_GetCashSymbol + FormatCurrency( fReportQuery.AmountEscrow );
   //
   if ( fReportQuery.AmountDue > 0 ) then
   begin
      AmouneDueLabel.caption := 'OUTSTANDING BALANCE:';
      db_totowed.Caption := Pref_GetCashSymbol + FormatCurrency(fReportQuery.AmountDue);
   end;
   if ( fReportQuery.AmountDue <= 0 ) then
   begin
      AmouneDueLabel.caption := 'NO OUTSTANDING BALANCE:';
      db_totowed.Caption := Pref_GetCashSymbol + FormatCurrency(0.00);
   end;
   //
   custRec := Customer_GetCustomerByCustID( fCustID );
   //
   ReportNameLabel.Caption := custRec.FULLNAME;
end;

procedure TReport_Customer_OrderTransactionHistory.Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_tdate.caption := fReportQuery.FieldByName('TDATE').AsString;
   db_transtype.caption := fReportQuery.FieldByName('TRANSTYPE').AsString;
   db_ordnum.caption := fReportQuery.FieldByName('ORDNUM').AsString;
   db_transtat.caption := fReportQuery.FieldByName('TRANSTAT').AsSTring;
   db_tamt.caption := fReportQuery.FieldByName('TAMT').AsString;
end;


end.




