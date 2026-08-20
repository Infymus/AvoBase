 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Earning_TypesFormUnit;

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
   MasterData_EarningTypeListUnit,
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
  TReport_Earning_Types = class(TAvoBase_ReportBase)
    db_earningtype: TQRLabel;
    QRLabel1: TQRLabel;
    db_active: TQRLabel;
    ab_autoadd: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
      fReportQuery : tMasterDataEarningTypeList;
      fOrgID : string;
      ferrResult : string;
  public
      procedure SetOptions( inOrgID : string);
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_Earning_Types.create(Owner: tComponent );
begin
   inherited Create( Owner );
   //
   // ONLY USE IF YOU ARE USING A QRCHART ------> ReportSession := masterData.AvoBaseSession;
   //
   ColorDetailBand := true;
   //
   ReportLabel.Enabled := false;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Earning_Types.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Earning_Types.SetOptions( inOrgID : string );
begin
   //
   fOrgID := inOrgID;
   //
   ferrResult := '';
   //
   SalesCycleLabel.Enabled := false;
   ReportLabel.Caption := 'Org: ' + Org_GetOrgNameByOrgID( inOrgID );
   // Create the Report Query and pass to it whatever required...
   fReportQuery := tMasterDataEarningTypeList.Create( masterData );
   fReportQuery.OrgID := fOrgID;
   fReportQuery.Update();
   // Is there any data?
   if ( fReportQuery.RecordCount = 0 ) then
      ferrResult := 'Report contains no data.';
   QReport.DataSet := fReportQuery;
end;


function TReport_Earning_Types.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Earning_Types.Band_DetailBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
   //
   db_earningtype.caption := fReportQuery.FieldByName('NAME').AsString;
   if ( fReportQuery.FieldByName('ISACTIVE').AsBoolean ) then
      db_active.caption := 'Yes'
   else
      db_active.caption := 'No';

   if ( fReportQuery.FieldByName('AUTOA').AsBoolean ) then
      ab_autoadd.caption := 'Yes'
   else
      ab_autoadd.caption := 'No';
{
               'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
}
end;

end.


