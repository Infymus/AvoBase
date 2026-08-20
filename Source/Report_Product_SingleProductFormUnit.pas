 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_Product_SingleProductFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   recordstructureunit,
   masterdata_BaseDataClassUnit,
   order_invoiceobjectunit,
   return_invoiceobjectunit,
   avobase_percentformunit,
   Toolbox_CycleToolBoxUnit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   Toolbox_ProductToolBoxUnit,
   toolbox_ordertoolboxunit,
   toolbox_orgtoolboxunit,
   MasterData_ReportProductSingleProductUnit,
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
  TReport_Product_SingleProduct = class(TAvoBase_ReportBase)
    QRPShape1: TQRPShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    lb_PRODN1: TQRLabel;
    lb_PRODN2: TQRLabel;
    lb_PRODN3: TQRLabel;
    lb_PRODN4: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    db_cycle: TQRLabel;
    db_ONUM: TQRLabel;
    db_ordate: TQRLabel;
    db_sqty: TQRLabel;
    db_fqty: TQRLabel;
    db_scost: TQRLabel;
    db_rqty: TQRLabel;
    db_rcost: TQRLabel;
    QRLabel1: TQRLabel;
    db_PRODN1: TQRLabel;
    db_PRODN2: TQRLabel;
    db_PRODN3: TQRLabel;
    db_PRODN4: TQRLabel;
    p_cycle: TQRLabel;
    p_org: TQRLabel;
    p_num: TQRLabel;
    p_name: TQRLabel;
    p_salespec: TQRLabel;
    p_rcost: TQRLabel;
    p_qtyoh: TQRLabel;
    QRLabel7: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure Band_TitleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
      fReportQuery : tMasterDataReportSingleProduct;
      fProdNum : string;
      fCycleID : string;
      ferrResult : string;
  public
      procedure SetOptions( InProdNum, InCycleID : string);
      function CanPrint : string;
      //
      constructor create( Owner : tComponent); overload;
      destructor destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_Product_SingleProduct.create(Owner: tComponent );
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   InvoiceDateLabel.Caption := 'Printed ' + DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

destructor TReport_Product_SingleProduct.destroy;
begin
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;

procedure TReport_Product_SingleProduct.SetOptions( InProdNum, InCycleID : string );
var
   OrgID : string;
   PrefProd : string;
begin
   fProdNum := InProdNum;
   fCycleID := InCycleID;
   //
   ferrResult := '';
   //
   SalesCycleLabel.enabled := false;
   //






   //
   fReportQuery := tMasterDataReportSingleProduct.Create( masterData, InProdNum, InCycleID );
   fReportQuery.Open();
   QReport.DataSet := fReportQuery;
   if ( fReportQuery.RecordCount = 0 ) then
   begin
      // turn bands off
      Band_ColumnHeader.enabled := false;
      Band_ColumnHeader_Child1.enabled := false;
      Band_Detail.enabled := false;
   end;

   OrgID := fReportQuery.FieldByName('ORG_ID').AsString;
   if ( OrgID <> '' ) then
   begin
      PrefProd := Org_GetOrgProductSpecialField( OrgID, 'PRODN1' );
      if ( prefProd <> '' ) then
         lb_PRODN1.Caption := '"'+ Org_GetOrgProductSpecialField( OrgID, 'PRODN1' ) + '"'
      else
         lb_PRODN1.Enabled := False;
      //
      PrefProd := Org_GetOrgProductSpecialField( OrgID, 'PRODN2' );
      if ( prefProd <> '' ) then
         lb_PRODN2.Caption := '"'+ Org_GetOrgProductSpecialField( OrgID, 'PRODN2' ) + '"'
      else
         lb_PRODN2.Enabled := False;
      //
      PrefProd := Org_GetOrgProductSpecialField( OrgID, 'PRODN3' );
      if ( prefProd <> '' ) then
         lb_PRODN3.Caption := '"'+ Org_GetOrgProductSpecialField( OrgID, 'PRODN3' ) + '"'
      else
         lb_PRODN3.Enabled := False;
      //
      PrefProd := Org_GetOrgProductSpecialField( OrgID, 'PRODN4' );
      if ( prefProd <> '' ) then
         lb_PRODN4.Caption := '"'+ Org_GetOrgProductSpecialField( OrgID, 'PRODN4' ) + '"'
      else
         lb_PRODN4.Enabled := False;
   end;
end;



function TReport_Product_SingleProduct.CanPrint: string;
begin
   result := ferrResult;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TReport_Product_SingleProduct.Band_TitleBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
var
   prodRec : tProdRec;
begin
   inherited;
   //
   prodRec := Product_GetProductByProdNumCycleID( fProdNum, fCycleID );
   //
   ReportLabel.enabled := false;
   ReportNameLabel.Caption := prodRec.Num + ' - ' + prodRec.name;
   p_cycle.Caption := Cycle_GetCycleNameByCycleID( prodRec.c_id );
   p_org.Caption := Org_GetOrgNameByOrgID( prodRec.org_id );
   p_name.Caption := prodRec.num;
   db_PRODN1.Caption := prodRec.prodn1;
   db_PRODN2.Caption := prodRec.prodn2;
   db_PRODN3.Caption := prodRec.prodn3;
   db_PRODN4.Caption := prodRec.prodn4;
   p_cycle.Caption := Cycle_GetCycleNameByCycleID( prodrec.c_id);
   p_org.Caption := Org_GetOrgNameByOrgID( prodREc.org_id );
   p_num.Caption := prodRec.num;
   p_name.Caption := prodRec.name;
   p_salespec.Caption := prodRec.descr;
   p_rcost.Caption := formatcurrency( prodRec.amount );
   p_qtyoh.Caption := inttostr( prodRec.qty );
end;

procedure TReport_Product_SingleProduct.Band_DetailBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   inherited;
   //
   db_cycle.Caption := fReportQuery.FieldByName('CYCLE').AsString;
   db_ONUM.Caption := fReportQuery.FieldByName('ONUM').AsString;
   db_ordate.Caption := fReportQuery.FieldByName('ORDATE').AsString;
   db_sqty.Caption := fReportQuery.FieldByName('SQTY').AsString;
   db_fqty.Caption := fReportQuery.FieldByName('FQTY').AsString;
   db_scost.Caption := FormatCurrency( fReportQuery.FieldByName('SCOST').AsCurrency );
   db_rqty.Caption := fReportQuery.FieldByName('RQTY').AsString;
   db_rcost.Caption := FormatCurrency( fReportQuery.FieldByName('RCOST').AsCurrency );
end;



end.




{

         retVal := masterData.AddTable(masterData.dbPath + table_order_product,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'R_ID VARCHAR(40), ' + // return prior order_product_ID
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'RQTY INTEGER, ' + // return qty (if RQTY = SQTY + FQTY then this line CANNOT be returned!!! )
            'FQTY INTEGER, ' + // free quantity (for by X get X free)
            'PQTY INTEGER, ' + // prior returned quantity
            'SO INTEGER, ' + // integer sort, only on save for bringing back into the invoice.
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PRODN1 VARCHAR(40), ' + // product table field name 1
            'PRODN2 VARCHAR(40), ' + // product table field name 2
            'PRODN3 VARCHAR(40), ' + // product table field name 3
            'PRODN4 VARCHAR(40), ' + // product table field name 4
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost


procedure tMasterDataReportSingleProduct.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( Self.FieldByname('ORG_ID').AsString );
   DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByCycleID( Self.FieldByname('C_ID').AsString );
   DataSet.FieldByName('ONUM').Value := Order_GetOrderNumberByOrderID( Self.FieldByname('ORDER_ID').AsString );
      DataSet.FieldByName('ORDATE').Value := Order_GetOrderDateByOrderID( Self.FieldByname('ORDER_ID').AsString );

end;

}

