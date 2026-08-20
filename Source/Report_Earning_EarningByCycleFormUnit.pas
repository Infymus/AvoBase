 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Earning_EarningByCycleFormUnit;

Interface Uses
   Actionunit,
   Actnlist,
   Avobase_Percentformunit,
   Bde,
   Buttons,
   Chart,
   Classes,
   Comctrls,
   Constantsunit,
   Controls,
   Db,
   Dbchart,
   Dbtables,
   Dialogs,
   Errorresultunit,
   Extctrls,
   Forms,
   Graphics,
   Img_Storageformunit,
   Mask,
   Masterdata_Basedataclassunit,
   Masterdata_Reportearningbycycleunit,
   Masterdataunit,
   Messages,
   Order_Invoiceobjectunit,
   Qrctrls,
   Qrexport,
   Qrpctrls,
   Qrpdffilt,
   Qrtee,
   Qrwebfilt,
   Quickrpt,
   Recordstructureunit,
   Report_Baseform,
   Return_Invoiceobjectunit,
   Series,
   Stdctrls,
   Sysutils,
   Teengine,
   Teeprocs,
   Themes,
   Toolbox_Customertoolboxunit,
   Toolbox_Cycletoolboxunit,
   Toolbox_Earningtoolboxunit,
   Toolbox_Ordertoolboxunit,
   Toolbox_Orgtoolboxunit,
   Toolbox_Preferencetoolboxunit,
   Toolboxunit,
   Toolwin,
   Variants,
   Windows;

type
   tReport_Earning_EarningByCycle = class(TAvoBase_ReportBase)
      BAND_Group: TQRGroup;
      ReportQuery: TQuery;
      QRLabel1: TQRLabel;
      db_cycle: TQRLabel;
      DateLabel: TQRLabel;
      QRLabel3: TQRLabel;
      QRLabel4: TQRLabel;
      ChildBand1: TQRChildBand;
      db_mopdate: TQRLabel;
      db_exptype: TQRLabel;
      db_amount: TQRLabel;
      BAND_GroupFooter: TQRBand;
      ChildBand3: TQRChildBand;
      QRShape1: TQRShape;
      QRLabel2: TQRLabel;
      db_subtotal: TQRLabel;
      ChildBand4: TQRChildBand;
      QRShape2: TQRShape;
      QRLabel6: TQRLabel;
      db_reporttotal: TQRLabel;
      procedure BAND_GroupBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
      procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand4BeforePrint(Sender: TQRCustomBand;
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

constructor TReport_Earning_EarningByCycle.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   fCycleTotal := 0;
   fReportTotal := 0;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Earning_EarningByCycle.destroy;
begin
   inherited destroy;
end;



procedure TReport_Earning_EarningByCycle.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
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


function TReport_Earning_EarningByCycle.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// GROUP HEADER
procedure TReport_Earning_EarningByCycle.BAND_GroupBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   db_cycle.caption := Cycle_GetCycleNameByCycleID( ReportQuery.FieldByName('C_ID').AsString );
   fCycleTotal := 0;
end;

// DETAIL BAND
procedure TReport_Earning_EarningByCycle.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   db_mopdate.caption := ReportQuery.FieldByName('MOPDATE').AsString;
   db_exptype.caption := Earning_GetEarningTypeNameByID( ReportQuery.FieldByName('ET_ID').AsString ) +
      ' - ' + ReportQuery.FieldByName('EDESC').AsString;
   db_amount.caption := FormatCurrency( ReportQuery.FieldByName('AMOUNT').AsCurrency );
   fCycleTotal := fCycleTotal + ReportQuery.FieldByName('AMOUNT').AsCurrency;
   fReportTotal := fReportTotal + ReportQuery.FieldByName('AMOUNT').AsCurrency;
end;

procedure tReport_Earning_EarningByCycle.ChildBand3BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   db_subtotal.Caption := FormatCurrency( fCycleTotal );
end;

procedure tReport_Earning_EarningByCycle.ChildBand4BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean );
begin
   inherited;
   //
   db_reporttotal.Caption := FormatCurrency( fReportTotal );
end;

end.


