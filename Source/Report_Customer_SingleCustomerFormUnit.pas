 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Customer_SingleCustomerFormUnit;


interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   RecordStructureUnit,
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
   {
   	ADD ->>> MASTERDATA_CONNECTOR FOR THIS REPORT
   MasterData_ReportCustomerTopCustByOrdAmountUnit,
   }
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
  TReport_Customer_SingleCustomer = class(TAvoBase_ReportBase)
    db_isactive: TQRLabel;
    db_taxe: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    db_fname: TQRLabel;
    db_mname: TQRLabel;
    db_lname: TQRLabel;
    db_bday: TQRLabel;
    db_addr1: TQRLabel;
    db_addr2: TQRLabel;
    db_city: TQRLabel;
    db_state: TQRLabel;
    db_zip: TQRLabel;
    db_phoneh: TQRLabel;
    db_phonec: TQRLabel;
    db_phonew: TQRLabel;
    db_email: TQRLabel;
    procedure Band_TitleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
      fcustRec : tCustRec;
      fReportQuery : tQuery;
      fOrgID : string;
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

constructor TReport_Customer_SingleCustomer.create(Owner: tComponent );
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

destructor TReport_Customer_SingleCustomer.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Customer_SingleCustomer.SetOptions( inCustID : string );
begin
   //
   fCustID := inCustID;
   fCustRec := Customer_GetCustomerByCustID( fCustID );
   //
   ferrResult := '';
   //
   SalesCycleLabel.Enabled := False;
   ReportNameLabel.Caption := fCustRec.FULLNAME;
   ReportLabel.Enabled := False;
end;

function TReport_Customer_SingleCustomer.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Customer_SingleCustomer.Band_TitleBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   if ( fcustRec.ISACTIVE ) then
      db_isactive.caption := 'Customer Is Active'
   else
      db_isactive.caption := 'Customer Is Inactive';
   //
   if ( fCustRec.TAXE ) then
      db_taxe.caption := '';
   //
   db_FNAME.Caption := fCustRec.FNAME;
   db_MNAME.Caption := fCustRec.MNAME;
   db_LNAME.Caption := fCustRec.LNAME;
   db_ADDR1.Caption := fCustRec.ADDR1;
   db_ADDR2.Caption := fCustRec.ADDR2;
   db_CITY.Caption := fCustRec.CITY;
   db_STATE.Caption := fCustRec.STATE;
   db_ZIP.Caption := fCustRec.ZIP;
   db_PHONEH.Caption := fCustRec.PHONEH;
   db_PHONEC.Caption := fCustRec.PHONEC;
   db_PHONEW.Caption := fCustRec.PHONEW;
   db_BDAY.Caption := DateToStr(fCustRec.BDAY);
   db_EMAIL.Caption := fCustRec.EMAIL;
end;



end.


