 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Report_Earning_ListByCycleFormUnit;

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
   Masterdata_Reportearninglistbycycleunit,
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
   Toolbox_Ordertoolboxunit,
   Toolbox_Orgtoolboxunit,
   Toolbox_Preferencetoolboxunit,
   Toolboxunit,
   Toolwin,
   Variants,
   Windows;

type
   tReport_Earning_ListByCycle = class(TAvoBase_ReportBase)
      QRLabel1: TQRLabel;
      QRLabel2: TQRLabel;
      QRLabel3: TQRLabel;
      QRLabel4: TQRLabel;
      QRPShape1: TQRPShape;
      QRLabel9: TQRLabel;
      db_orgname: TQRLabel;
      db_cyclename: TQRLabel;
      db_totitems: TQRLabel;
      db_totamt: TQRLabel;
      ChildBand1: TQRChildBand;
      db_total: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
   private
      fTotal : currency;
      fReportQuery : tMasterDataReportEarningListByCycle;
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

constructor TReport_Earning_ListByCycle.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Earning_ListByCycle.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Earning_ListByCycle.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
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
   //
   fReportQuery := tMasterDataReportEarningListByCycle.Create(
      masterData,
      inOrgID,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num
      );
   //
   fReportQuery.Open();
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';
   QReport.DataSet:= fReportQuery;
end;


function TReport_Earning_ListByCycle.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReport_Earning_ListByCycle.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_orgname.caption := fReportQuery.FieldByname('ORGNAME').AsString;
   db_cyclename.caption := fReportQuery.FieldByname('CYCLENAME').AsString;
   db_totitems.caption := fReportQuery.FieldByname('TOTITEMS').AsString;
   db_totamt.caption := FormatCurrency( fReportQuery.FieldByname('TOTAMT').AsCurrency );
   fTotal := fTotal + fReportQuery.FieldByname('TOTAMT').AsCurrency;
end;

procedure tReport_Earning_ListByCycle.ChildBand1BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_total.caption := FormatCurrency( fTotal );
end;



end.


