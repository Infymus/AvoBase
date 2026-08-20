 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Expense_ByCycleFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   recordstructureunit,
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
   MasterData_ReportExpenseByCycleUnit,
   Toolbox_ExpenseToolBoxUnit,
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
  TReport_Expense_ByCycle = class(TAvoBase_ReportBase)
    ReportQuery: TQuery;
    BAND_GroupFooter: TQRBand;
    BAND_Group: TQRGroup;
    QRLabel1: TQRLabel;
    db_cycle: TQRLabel;
    DateLabel: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    db_mopdate: TQRLabel;
    db_exptype: TQRLabel;
    db_amount: TQRLabel;
    ChildBand1: TQRChildBand;
    ChildBand3: TQRChildBand;
    QRShape1: TQRShape;
    QRLabel2: TQRLabel;
    db_subtotal: TQRLabel;
    ChildBand4: TQRChildBand;
    QRShape2: TQRShape;
    QRLabel6: TQRLabel;
    db_reporttotal: TQRLabel;
    ChildBand5: TQRChildBand;
    procedure BAND_GroupBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
   private
      fCycleTotal : currency;
      fReportTotal : currency;
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

constructor TReport_Expense_ByCycle.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   fCycleTotal := 0;
   fReportTotal := 0;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Expense_ByCycle.destroy;
begin
   inherited destroy;
end;

procedure TReport_Expense_ByCycle.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
var
   startCycleRec : tCycleRec;
   endCycleRec : tCycleRec;
   tempQuery: tQuery;
   fReportQuery : tMasterDataReportEarningByCycle;
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
   ReportLabel.Caption := 'Org: ' + Org_GetOrgNameByOrgID( inOrgID );
   //
   // now we get all tricky tricky for pointers
   fReportQuery := tMasterDataReportEarningByCycle.Create(
      masterData,
      inOrgID,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num
      );
   //
   ReportQuery.SessionName := masterData.AvoBaseSession.SessionName;
   ReportQuery.SQL.text := fReportQuery.SQL.Text;
   ReportQuery.Open();
   FreeAndNil(fReportQuery);
   //
   //
   ReportQuery.Open();
   // Is there any data?
   if ( ReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';
   //
   QReport.DataSet := ReportQuery;
end;



function TReport_Expense_ByCycle.CanPrint: string;
begin
   result := ferrResult;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// GROUP HEADER

procedure TReport_Expense_ByCycle.BAND_GroupBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   db_cycle.caption := Cycle_GetCycleNameByCycleID( ReportQuery.FieldByName('C_ID').AsString );
   fCycleTotal := 0;
end;

// DETAIL BAND
procedure TReport_Expense_ByCycle.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   db_mopdate.caption := ReportQuery.FieldByName('MOPDATE').AsString;
   db_exptype.caption := Expense_GetExpenseTypeNameByID( ReportQuery.FieldByName('ET_ID').AsString ) + ' - ' +
      ReportQuery.FieldByName('EDESC').AsString;
   db_amount.caption := FormatCurrency( ReportQuery.FieldByName('AMOUNT').AsCurrency );
   fCycleTotal := fCycleTotal + ReportQuery.FieldByName('AMOUNT').AsCurrency;
   fReportTotal := fReportTotal + ReportQuery.FieldByName('AMOUNT').AsCurrency;
end;

procedure TReport_Expense_ByCycle.ChildBand3BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   db_subtotal.Caption := FormatCurrency( fCycleTotal );
end;

procedure TReport_Expense_ByCycle.ChildBand4BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   db_reporttotal.Caption := FormatCurrency( fReportTotal );
end;

end.


