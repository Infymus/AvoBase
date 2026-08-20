 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Order_OrderProductFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   RecordStructureUnit,
   masterdata_BaseDataClassUnit,
   order_invoiceobjectunit,
   return_invoiceobjectunit,
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   //
   MasterData_ReportOrderProductListUnit,
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
   tReport_Order_OrderProduct = class(TAvoBase_ReportBase)
      db_org: TQRLabel;
      Band_Group: TQRGroup;
      QRLabel1: TQRLabel;
      QRLabel2: TQRLabel;
      QRLabel3: TQRLabel;
      QRLabel4: TQRLabel;
      QRLabel5: TQRLabel;
    RCOST: TQRLabel;
    SCOST: TQRLabel;
      db_num: TQRLabel;
      db_qty: TQRLabel;
      db_descr: TQRLabel;
    db_rcost: TQRLabel;
    db_scost: TQRLabel;
      db_groupcycle: TQRLabel;
      ReportQuery: TQuery;
      QRShape1: TQRShape;
      QRLabel13: TQRLabel;
    db_reptotal_rcost: TQRLabel;
    db_reptotal_scost: TQRLabel;
    BAND_GroupFooter: TQRBand;
    QRShape2: TQRShape;
    QRLabel8: TQRLabel;
    db_cycle_total_rcost: TQRLabel;
    db_cycle_total_scost: TQRLabel;
    ChildBand1: TQRChildBand;
    YCOST: TQRLabel;
    db_ycost: TQRLabel;
    db_cycle_total_ycost: TQRLabel;
    db_reptotal_ycost: TQRLabel;
      procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
      procedure Band_GroupBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
      procedure Band_SummaryBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure BAND_GroupFooterBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
   private
      fReportTotalYCOST : currency;
      fReportTotalRCOST : currency;
      fReportTotalSCOST : currency;
      fCycleTotalYCOST : currency;
      fCycleTotalRCOST : currency;
      fCycleTotalSCOST : currency;
      fOrgID : string;
      fCycleID : string;
      ferrResult : string;
   public
      procedure SetOptions( inOrgID, inCycleID : string);
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_Order_OrderProduct.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Order_OrderProduct.destroy;
begin
   inherited destroy;
end;

procedure TReport_Order_OrderProduct.SetOptions( inOrgID, inCycleID : string );
var
   startCycleRec : tCycleRec;
   endCycleRec : tCycleRec;
   fReportQuery : tQuery;
begin
   //
   fOrgID := inOrgID;
   fCycleID := inCycleID;
   //
   ReportLabel.Caption := 'Org: ' + Org_GetOrgNameByOrgID( fOrgID );
   ferrResult := '';
   //
   fReportTotalYCOST := 0;
   fReportTotalRCOST := 0;
   fReportTotalSCOST := 0;
   fCycleTotalYCOST := 0;
   fCycleTotalRCOST := 0;
   fCycleTotalSCOST := 0;
   //
   startCycleRec := Cycle_GetCycleByCycleID( fCycleID );
   //
   SalesCycleLabel.Caption := 'Sales Cycle ' + startCycleRec.cname;
   //
   //SalesCycleLabel.Caption := 'Sales Cycle ' + startCycleRec.cname;
   //
   // Build the data
   fReportQuery := tMasterDataReportOrderProductList.Create( masterData, fCycleID );
   fReportQuery.Open();
   fReportQuery.Close();
   FreeAndNil(fReportQuery);
   //
   ReportQuery.SessionName := masterData.AvoBaseSession.SessionName;
   ReportQuery.sql.text := 'SELECT * FROM ' + masterData.GetTable_Report +
      ' ORDER BY C_ID';
   ReportQuery.open();
   //
   Band_Group.Expression := 'ReportQuery.C_ID';
   // Is there any data?
   if ( ReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';
end;

function TReport_Order_OrderProduct.CanPrint: string;
begin
   result := ferrResult;
end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Order_OrderProduct.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
var
   orgStr : string;
begin
   inherited;
   //
   db_num.caption := ReportQuery.FieldByName('NUM').AsString;
   orgStr := Org_GetOrgNameByOrgID( ReportQuery.FieldByName('ORG_ID').AsString );
   if ( Length(orgStr) > 20 ) then
      Delete(orgStr, 20, Length(orgStr));
   db_org.caption := orgstr;
   db_qty.caption := ReportQuery.FieldByName('SQTY').AsSTring;
   db_descr.caption := ReportQuery.FieldByName('NAME').AsString;
   //
   db_ycost.caption := FormatCurrency( ReportQuery.FieldByName('YCOST').AsCurrency );
   db_rcost.caption := FormatCurrency( ReportQuery.FieldByName('RCOST').AsCurrency );
   db_scost.caption := FormatCurrency( ReportQuery.FieldByName('SCOST').AsCurrency );
   //
   fCycleTotalYCOST := fCycleTotalYCOST  + ReportQuery.FieldByName('YCOST').AsCurrency;
   fCycleTotalRCOST := fCycleTotalRCOST  + ReportQuery.FieldByName('RCOST').AsCurrency;
   fCycleTotalSCOST := fCycleTotalSCOST  + ReportQuery.FieldByName('SCOST').AsCurrency;

   fReportTotalYCOST := fReportTotalYCOST  + ReportQuery.FieldByName('YCOST').AsCurrency;
   fReportTotalRCOST := fReportTotalRCOST  + ReportQuery.FieldByName('RCOST').AsCurrency;
   fReportTotalSCOST := fReportTotalSCOST  + ReportQuery.FieldByName('SCOST').AsCurrency;
{
         'ID VARCHAR(40), ' +
         'C_ID VARCHAR(40), ' + // camp id
         'ORG_ID VARCHAR(40), ' +
         'ORDER_ID VARCHAR(40), ' +
         'NUM VARCHAR(20), ' +
         'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
         'SQTY INTEGER, ' +
         'NAME VARCHAR(40), ' +
         'DESCR VARCHAR(40), ' +
         'SCOST MONEY, ' + // sell at cost
         'RCOST MONEY',  // retail cost
         }
end;

procedure TReport_Order_OrderProduct.Band_GroupBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_groupcycle.Caption := Cycle_GetCycleNameByCycleID( ReportQuery.FieldByName('C_ID').AsString );
   //
   fCycleTotalYCOST := 0;
   fCycleTotalRCOST := 0;
   fCycleTotalSCOST := 0;
end;

procedure tReport_Order_OrderProduct.BAND_GroupFooterBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_cycle_total_ycost.caption := FormatCurrency( fCycleTotalYCOST );
   db_cycle_total_rcost.caption := FormatCurrency( fCycleTotalRCOST );
   db_cycle_total_scost.caption := FormatCurrency( fCycleTotalSCOST );
end;

procedure TReport_Order_OrderProduct.Band_SummaryBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   db_reptotal_ycost.caption := FormatCurrency( fReportTotalYCOST );
   db_reptotal_rcost.caption := FormatCurrency( fReportTotalRCOST );
   db_reptotal_scost.caption := FormatCurrency( fReportTotalSCOST );
end;


end.

