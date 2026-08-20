 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Accounting_TransactionLogByCycleFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   recordstructureunit,
   order_invoiceobjectunit,
   return_invoiceobjectunit,
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   MasterData_ReportAccountingTransactionLogByCycleUnit,
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
  TReport_Accounting_TransactionLogByCycle = class(TAvoBase_ReportBase)
    QRLabel1: TQRLabel;
    db_totorders: TQRLabel;
    QRLabel3: TQRLabel;
    db_returns: TQRLabel;
    QRLabel5: TQRLabel;
    db_cancel: TQRLabel;
    QRLabel7: TQRLabel;
    db_amountorder: TQRLabel;
    db_amountmop: TQRLabel;
    db_amountreturn: TQRLabel;
    db_amountvoid: TQRLabel;
    db_amounttranscredit: TQRLabel;
    db_amounttransdebit: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel9: TQRLabel;
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
      fReportQuery : tMasterData_Report_AccountingTransactionLogByCycle;
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

constructor TReport_Accounting_TransactionLogByCycle.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Accounting_TransactionLogByCycle.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Accounting_TransactionLogByCycle.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
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
   //
   fReportQuery := tMasterData_Report_AccountingTransactionLogByCycle.Create(
      masterData,
      inOrgID,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num
      );
   //
   fReportQuery.Open();
   // Is there any data?
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data.';
   QReport.DataSet := fReportQuery;
end;

function TReport_Accounting_TransactionLogByCycle.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Accounting_TransactionLogByCycle.Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_tdate.caption := fReportQuery.FieldByName('TDATE').AsString;
   db_transtype.caption := fReportQuery.FieldByName('TRANSTYPE').AsString;
   db_ordnum.caption := fReportQuery.FieldByName('ORDNUM').AsString;
   db_transtat.caption := fReportQuery.FieldByName('TRANSTAT').AsSTring;
   db_tamt.caption := fReportQuery.FieldByName('TAMT').AsString;
end;

procedure TReport_Accounting_TransactionLogByCycle.Band_TitleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
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
end;

end.


