 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_CustomerListUnit;

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
   MasterData_CustomerListUnit,
   db,
   bde,
   //
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
   Report_BaseForm;

type
   tCustListOptions = (
      CustListOpt1,
      CustListOpt2,
      CustListOpt3,
      CustListOpt4,
      CustListOpt5
      );

type
  TReport_Customer_List = class(TAvoBase_ReportBase)
    OptionBand1: TQRChildBand;
    OptionBand2: TQRChildBand;
    OptionBand3: TQRChildBand;
    OptionBand4: TQRChildBand;
    OptionBand5: TQRChildBand;
    opt1_db_custname: TQRLabel;
    opt1_db_custfulladdr: TQRLabel;
    opt1_orders: TQRLabel;
    opt1_db_orders: TQRLabel;
    opt1_cancels: TQRLabel;
    opt1_db_cancels: TQRLabel;
    opt1_returns: TQRLabel;
    opt1_db_returns: TQRLabel;
    opt1_phone: TQRLabel;
    opt1_cellphone: TQRLabel;
    opt1_workphone: TQRLabel;
    opt1_db_phone: TQRLabel;
    opt1_db_cell: TQRLabel;
    opt1_db_work: TQRLabel;
    QRLabel17: TQRLabel;
    opt2_db_custname: TQRLabel;
    opt2_db_custfulladdr: TQRLabel;
    QRLabel3: TQRLabel;
    opt2_db_cell: TQRLabel;
    opt2_db_phone: TQRLabel;
    QRLabel1: TQRLabel;
    OPT3_DB_CUSTNAME: TQRLabel;
    QRLabel4: TQRLabel;
    opt3_db_orders: TQRLabel;
    QRLabel6: TQRLabel;
    opt3_db_cancels: TQRLabel;
    QRLabel8: TQRLabel;
    opt3_db_returns: TQRLabel;
    QRLabel11: TQRLabel;
    opt3_db_phone: TQRLabel;
    QRLabel13: TQRLabel;
    opt3_db_cell: TQRLabel;
    opt4_db_custname: TQRLabel;
    QRLabel5: TQRLabel;
    opt4_db_phone: TQRLabel;
    QRLabel9: TQRLabel;
    opt4_db_orders: TQRLabel;
    QRLabel12: TQRLabel;
    opt4_db_cancels: TQRLabel;
    QRLabel15: TQRLabel;
    opt4_db_returns: TQRLabel;
    opt5_db_custname: TQRLabel;
    QRLabel19: TQRLabel;
    opt5_db_phone: TQRLabel;
    QRLabel21: TQRLabel;
    opt5_db_cell: TQRLabel;
    QRLabel23: TQRLabel;
    opt5_db_bday: TQRLabel;
    procedure OptionBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure OptionBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure OptionBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure OptionBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure OptionBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
      fReportQuery : tQuery;
      fOptionType : tCustListOptions;
  public
      procedure SetOptions( inOption : tCustListOptions );
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


constructor TReport_Customer_List.create(Owner: tComponent );
begin
   inherited Create( Owner );
   //
   ColorDetailBand := true;
   //
   fReportQuery := tMasterDataCustomerList.Create( masterData );
   fReportQuery.Open();
   //
   ReportNameLabel.Caption := 'Customer List';
   ReportLabel.Enabled := false;
   SalesCycleLabel.Enabled := False;

   // LAST ON THE LIST...
   QReport.DataSet := fReportQuery;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Customer_List.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Customer_List.SetOptions(inOption: tCustListOptions);
begin
   //
   fOptionType := inOption;

   // First turn them all off
   OptionBand1.Enabled := false;
   OptionBand2.Enabled := false;
   OptionBand3.Enabled := false;
   OptionBand4.Enabled := false;
   OptionBand5.Enabled := false;
   //
   case fOptionType of
      CustListOpt1 : OptionBand1.Enabled := True;
      CustListOpt2 : OptionBand2.Enabled := True;
      CustListOpt3 : OptionBand3.Enabled := True;
      CustListOpt4 : OptionBand4.Enabled := True;
      CustListOpt5 : OptionBand5.Enabled := True;
   end;
end;

function TReport_Customer_List.CanPrint: string;
begin
   result := '';
   //
   if ( fReportQuery.RecordCount = 0 ) then
      result := 'There are no Customers to print.';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// OPTION BAND 1
procedure TReport_Customer_List.OptionBand1BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   opt1_db_custname.Caption := fReportQuery.FieldByName('FULLNAME').AsString;
   opt1_db_custfulladdr.Caption := fReportQuery.FieldByName('FULLADDR').AsString;
   opt1_db_orders.caption := fReportQuery.FieldByName('TotO').AsString;
   opt1_db_cancels.caption := fReportQuery.FieldByName('TotC').AsString;
   opt1_db_phone.caption := fReportQuery.FieldByName('PHONEH').AsString;
   opt1_db_cell.caption := fReportQuery.FieldByName('PHONEC').AsString;
   opt1_db_work.caption := fReportQuery.FieldByName('PHONEW').AsString;
   //
  if OptionBand1.Color = $00DFDFDF
    then OptionBand1.Color := clWhite
  else
    OptionBand1.Color := $00DFDFDF;
end;

// OPTION BAND 2
procedure TReport_Customer_List.OptionBand2BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   opt2_db_custname.Caption := fReportQuery.FieldByName('FULLNAME').AsString;
   opt2_db_custfulladdr.Caption := fReportQuery.FieldByName('FULLADDR').AsString;
   opt2_db_phone.caption := fReportQuery.FieldByName('PHONEH').AsString;
   opt2_db_cell.caption := fReportQuery.FieldByName('PHONEC').AsString;
   //
  if OptionBand2.Color = $00DFDFDF
    then OptionBand2.Color := clWhite
  else
    OptionBand2.Color := $00DFDFDF;
end;

// OPTION BAND 3
procedure TReport_Customer_List.OptionBand3BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   opt3_db_custname.Caption := fReportQuery.FieldByName('FULLNAME').AsString;
   opt3_db_orders.caption := fReportQuery.FieldByName('TotO').AsString;
   opt3_db_cancels.caption := fReportQuery.FieldByName('TotC').AsString;
   opt3_db_phone.caption := fReportQuery.FieldByName('PHONEH').AsString;
   opt3_db_cell.caption := fReportQuery.FieldByName('PHONEC').AsString;
   //
  if OptionBand3.Color = $00DFDFDF
    then OptionBand3.Color := clWhite
  else
    OptionBand3.Color := $00DFDFDF;
end;

// OPTION BAND 4
procedure TReport_Customer_List.OptionBand4BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   opt4_db_custname.Caption := fReportQuery.FieldByName('FULLNAME').AsString;
   opt4_db_orders.caption := fReportQuery.FieldByName('TotO').AsString;
   opt4_db_cancels.caption := fReportQuery.FieldByName('TotC').AsString;
   opt4_db_phone.caption := fReportQuery.FieldByName('PHONEH').AsString;
   //
  if OptionBand4.Color = $00DFDFDF
    then OptionBand4.Color := clWhite
  else
    OptionBand4.Color := $00DFDFDF;
end;

// OPTION BAND 5
procedure TReport_Customer_List.OptionBand5BeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   opt5_db_custname.Caption := fReportQuery.FieldByName('FULLNAME').AsString;
   opt5_db_phone.caption := fReportQuery.FieldByName('PHONEH').AsString;
   opt5_db_cell.caption := fReportQuery.FieldByName('PHONEC').AsString;
   opt5_db_bday.caption := fReportQuery.FieldByName('BDAY').AsString;
   //
  if OptionBand5.Color = $00DFDFDF
    then OptionBand5.Color := clWhite
  else
    OptionBand5.Color := $00DFDFDF;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.

{

   masterData.QueryAddCalculatedField( self, 'TotO', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'TotC', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'FullName', 40, ftString);
   masterData.QueryAddCalculatedField( self, 'FullAddr', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'BOT', 1, ftInteger);


            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'FNAME VARCHAR(30), ' +
            'MNAME VARCHAR(30), ' +
            'LNAME VARCHAR(30), ' +
            'ADDR1 VARCHAR(100), ' +
            'ADDR2 VARCHAR(100), ' +
            'CITY VARCHAR(50), ' +
            'STATE VARCHAR(50), ' +
            'ZIP VARCHAR(30), ' +
            'PHONEH VARCHAR(30), ' +
            'PHONEC VARCHAR(30), ' +
            'PHONEW VARCHAR(30), ' +
            'BDAY DATE, ' +
            'EMAIL VARCHAR(60), ' +
            'TAXE BOOLEAN',
}
