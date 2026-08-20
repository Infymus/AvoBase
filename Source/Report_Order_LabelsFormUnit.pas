 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Order_LabelsFormUnit;

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
  TReport_Order_Labels = class(tForm)
    QuickReport: TQuickRep;
    DetailBand: TQRBand;
    QRMemo1: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo3: TQRMemo;
  private
      fReportQuery : tQuery;
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

constructor TReport_Order_Labels.create(Owner: tComponent );
begin
   inherited Create( Owner );
end;

destructor TReport_Order_Labels.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Order_Labels.SetOptions( inOrgID, inStartCycleID, inEndCycleID : string );
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
   {
   SalesCycleLabel.Caption := 'Sales Cycle ' +
      startCycleRec.cname + ' to ' +
      endCycleRec.cname;
}
   // Our body is ready

{ FILL THIS IN WHEN YOU ARE READY

   // Create the Report Query and pass to it whatever required...
   fReportQuery := tMasterDataReportTopCustByOrdAmount.Create(
      masterData,
      startCycleRec.year,
      endCycleRec.year,
      startCycleRec.num,
      endCycleRec.num
      );
   // Open the Report Query
   fReportQuery.Open();
   // Is there any data?
   if ( fReportQuery.RecordCount < 0 ) then
      ferrResult := 'Report contains no data for selected Sales Cycles.';
   // Set the datasource on the tQRChart - OR - set the datasource on the qReport
   // QRCHART --------------> QRChart.Chart.Series[0].DataSource := fReportQuery;
   // QUICKREPORT -------------> QReport.DataSource := fReportQuery;
   }
end;

function TReport_Order_Labels.CanPrint: string;
begin
   result := ferrResult;
end;

end.



(*
UNIT  Report_OrderLabels;

INTERFACE

USES  Windows,
      Messages,
      SysUtils,
      Constants,
      Variants,
      Classes,
      AvoINIFileUnit,
      Graphics,
      Controls,
      Forms,
      Dialogs,
      DB,
      VerificationUnit,
      DBTables,
      ExtCtrls,
      QuickRpt,
      Toolbox,
      MasterDataUnit,
      MasterDataKernalUnit,
      CalculateInvoiceUnit,
      QRCtrls,
      AvoBaseDialogFormUnit,
      StdCtrls,
      jpeg;

TYPE
  THLabel = (h5160, h5161, h18160);

TYPE
  TReportOrderLabels = class(TForm)
    QuickReport: TQuickRep;
    DetailBand: TQRBand;
    QRMemo1: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo3: TQRMemo;
    Report_Query: TQuery;
    procedure DetailBandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QuickReportBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
  PRIVATE
    fWidth : Double;
    fHeight : Integer;
    fLabels : Integer;
    FSkipRow: integer;
    Memos: array[0..2] of TQRMemo;
    procedure AddIfNotBlank(memo: TQRMemo; s: string);
  PUBLIC
    LabelCnt: integer;
    LabelSize : THLabel;
    SkipRow: integer;
    CONSTRUCTOR Create( Owner : TComponent; CampID : Integer; RowsSkip : Integer; PrintType : Integer ); OVERLOAD;
  end;

IMPLEMENTATION

{$R *.DFM}

CONSTRUCTOR TReportOrderLabels.Create( Owner : TComponent; CampID : Integer; RowsSkip : Integer; PrintType : Integer );
var
  SQLText : String;
  x : Integer;
  ObjVerf : tKeyVerif;
  Rep_Name : String;
  Rep_Company : String;
  Rep_Number : String;
  Rep_Email : String;
  Date_Due : String;
begin
  { Create It }
  Inherited Create(Owner);
  //
  fSkipRow := RowsSkip;
  Memos[0] := qrmemo1;
  Memos[1] := qrmemo2;
  Memos[2] := qrmemo3;

  Case PrintType of
    0: LabelSize := h5160;
    1: LabelSize := h5161;
    2: LabelSize := h18160;
  end;
  SkipRow := RowsSkip;

  // Bring in the PrintType to get the Margins
  {
  fWidth := AvoINIReadFloat( AVOINI_LABELS, PrintType, 'width', 2.60 );
  fHeight := AvoINIReadInteger( AVOINI_LABELS, PrintType, 'height', 96 );
  fLabels := AvoINIReadInteger( AVOINI_LABELS, PrintType, 'labels', 3 ) - 1;
  }
  // do this or it access violates on your head
  {
  if fLabels < 0 then
    fLabels := 0;
  if fLabels > 2 then
    fLabels := 2;
    }

  // Set up the Report_Query
  //
  { First Erase it }
  if FileExists(MasterDataKernal.DBPath + 'REPORT1.DB') then
    DeleteFile(MasterDataKernal.DBPath + 'REPORT1.DB');
  //
  Report_Query.Active := False;
  { Create our temporary table }
  SQLText := 'CREATE TABLE "REPORT1.DB" ';
  SQLText := SQLText + '(REP_COMPANY VARCHAR(60), REP_NAME VARCHAR(60), REP_NUMBER VARCHAR(60), REP_EMAIL VARCHAR(60), DUE_DATE VARCHAR(60))';
  try
    Report_Query.SQL.Clear;
    Report_Query.SQL.Text := SQLText;
    Report_Query.ExecSQL;
  except
    AvoBaseDialog('ERROR', 'Unable to create temporary report database.', mtError, [mbOk], 0);
    exit;
  end;
  // Our SHIZ
  Rep_Number := MasterData.Pref_Rep_Phone;
  Rep_Email := MasterData.Pref_Email;
  Date_Due := 'Order Due By ' + DateToStr(MasterData.CampDueDate(CampID));
  Rep_Company := MasterData.Pref_RepCompanyName;
  Rep_Name := 'Your Representative';
  //
	ObjVerf := tKeyVerif.Create;
	if (ObjVerf.Tk4726TuI) then
    Rep_Name := ObjVerf.FIRST_NAME + ' ' + ObjVerf.MIDDLE_INITIAL + ' ' + ObjVerf.LAST_NAME;
	FreeAndNil(ObjVerf);
  //
  // Fill It
  //
  Report_Query.Active := False;
  Report_Query.SQL.Text := 'SELECT * FROM REPORT1.DB';
  Report_Query.Active := True;
  for X := 1 to MasterData.Get_Book_Order_Count_By_Camp_ID(CampID) do
  begin
    Report_Query.Append;
    Report_Query.FieldByName('REP_COMPANY').AsString := Rep_Company;
    Report_Query.FieldByName('REP_NAME').AsString := Rep_Name;
    Report_Query.FieldByName('REP_NUMBER').AsString := Rep_Number;
    Report_Query.FieldByName('REP_EMAIL').AsString := Rep_Email;
    Report_Query.FieldByName('DUE_DATE').AsString := Date_Due;
    Report_Query.Post;
  end;
  Report_Query.First;
end;

procedure TReportOrderLabels.AddIfNotBlank(memo: TQRMemo; s: string);
begin
  if Trim(s) <> '' then
    memo.Lines.Add(s);
end;

procedure TReportOrderLabels.QuickReportBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  nIdx: integer;
begin
  FSkipRow := SkipRow;
  if LabelSize = h5160 then
  begin
    memos[2].Enabled := true;
    LabelCnt := 2;
  end;
  if LabelSize = h5161 then
  begin
    memos[2].Enabled := FALSE;
    LabelCnt := 1;
  end;
  if LabelSize = h18160 then
  begin
    memos[2].Enabled := true;
    LabelCnt := 2;
  end;
  for nIdx := 0 to LabelCnt do
  begin
    with memos[nIdx] do
    begin
      if Enabled then
      begin
        case LabelSize of
          h5160: Size.Width := 2.60;
          h5161: Size.Width := 4;
          h18160: Size.Width := 2.80;
        end;
        if nIdx > 0 then
          Left := memos[nIdx-1].Left + memos[nIdx-1].Width
        else
          Left := 0;
      end;
    end
  end;
end;

procedure TReportOrderLabels.DetailBandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  nIdx : integer;
begin
  for nIdx := low(memos) to high(memos) do
    memos[nIdx].Lines.Clear;
  if FSkipRow > 0 then
  begin
    dec(FSkipRow);
    quickreport.DataSet.Prior;
  end else
    begin
      with quickreport.DataSet do
      begin
        for nIdx := 0 to LabelCnt do
        begin
          if not EOF then
          begin
            memos[nIdx].Lines.Add(Report_Query.FieldByName('REP_COMPANY').AsString);
            AddIfNotBlank(memos[nIdx], Report_Query.FieldByName('REP_NUMBER').AsString);
            AddIfNotBlank(memos[nIdx], Report_Query.FieldByName('REP_EMAIL').AsString);
            AddIfNotBlank(memos[nIdx], Report_Query.FieldByName('DUE_DATE').AsString);
          end;
          if (nIdx < LabelCnt) and (not EOF) then
            Next
          else
            break;
        end;
      end;
    end;
end;


end.
*)
