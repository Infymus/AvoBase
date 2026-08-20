 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_InvoiceFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
  recordstructureunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   order_invoiceobjectunit,
   MasterData_ReportInvoiceUnit,
   avobase_percentformunit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   Customer_SelectFormUnit,
   Toolbox_OrgToolBoxUnit,
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
   verificationunit,
   QRCtrls,
   qrpctrls,
   Report_BaseForm, jpeg;

type
  TReport_InvoiceForm = class(TAvoBase_ReportBase)
    db_name: TQRLabel;
    db_cost: TQRLabel;
    db_totalcost: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    db_num: TQRLabel;
    db_qty: TQRLabel;
    totals_shape: TQRShape;
    amountdue_label: TQRLabel;
    db_amountdue: TQRLabel;
    mop_label: TQRLabel;
    db_mop: TQRLabel;
    QRLabel16: TQRLabel;
    db_invoicetotal: TQRLabel;
    QRShape8: TQRShape;
    QRLabel15: TQRLabel;
    db_salestax: TQRLabel;
    QRLabel14: TQRLabel;
    db_shipping: TQRLabel;
    QRLabel13: TQRLabel;
    db_fees: TQRLabel;
    QRShape1: TQRShape;
    db_subtotal: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel2: TQRLabel;
    db_custname: TQRLabel;
    ShipToTitleLabel: TQRLabel;
    Band_Summary_Child1: TQRChildBand;
    db_imsg: TQRLabel;
    invHead: TQRLabel;
    invLine1: TQRLabel;
    invLine2: TQRLabel;
    invLine3: TQRLabel;
    invLine4: TQRLabel;
    invLine5: TQRLabel;
    Band_Detail_Child_ProdInfo: TQRChildBand;
    db_prodinfo: TQRLabel;
    invLine6: TQRLabel;
    db_custaddr: TQRLabel;
    db_custcitystatezip: TQRLabel;
    db_void_label: TQRLabel;
    db_void: TQRLabel;
    db_image: TQRImage;
    db_disclabel: TQRLabel;
    db_shipcustname: TQRLabel;
    db_shipcustaddr: TQRLabel;
    db_shipcustcitystatezip: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure Band_Detail_Child_ProdInfoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure Band_DetailAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
   private
      lineColor : TColor;
      currSymb : string;
      fOrderID : string;
      orderInvoice : tInvoice;
      fReportQuery : tQuery;
      fPriorInvoiceBalance : currency;
      //ObjVerf : tKeyVerif;
      KeyRepName : string;
      function FillInvoiceLine( inPref : tPrefConstants ) : String;
   public
      constructor create( Owner : tComponent; inOrderID : string ); overload;
      destructor destroy; override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TReport_InvoiceForm.create(Owner: tComponent; inOrderID: string);
var
   errResult : tErrorResult;
   prevOrderInvoice : tInvoice;
   fQuery : tQuery;
   custRec : tCustRec;
   fProdQuery : tQuery;
   fFeeQuery : tQuery;
   lineItemCount : integer;
   orgCycleText : string;
   cust_phones : string;
begin
   inherited Create( Owner );
   ColorDetailBand := true;
   lineColor := clWhite;
   //
   orderInvoice := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
   fProdQuery := masterData.GetQuery();
   fReportQuery := masterData.GetQuery();
   fFeeQuery := masterData.GetQuery();
   currSymb := Pref_GetCashSymbol;

   // Load
   errResult := orderInvoice.Load( inOrderID );
   if (errResult.errorResult) then
   begin
      Error_Log( errResult, true );
      exit;
   end;

   // ************* CREATE THE TEMPORARY DATA TABLE FOR THIS REPORT ****************************************** //

   // We  need to ensure the table isn't there because we re-use this table... A LOT.
   masterData.RemoveTable( table_report );

   // First, build the table if it doesn't exist
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'SO INTEGER, ' + // integer sort, only on save for bringing back into the invoice.
         'NUM VARCHAR(20), ' +
         'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
         'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
         'TAX FLOAT, ' + // tax AT TIME of invoice
         'SQTY INTEGER, ' +
         'RQTY INTEGER, ' + // return qty (if RQTY = SQTY + FQTY then this line CANNOT be returned!!! )
         'FQTY INTEGER, ' + // free quantity (for by X get X free)
         'PQTY INTEGER, ' + // prior returned quantity
         'NAME VARCHAR(40), ' +
         'DESCR VARCHAR(40), ' +
         'PRODN1 VARCHAR(40), ' + // product table field name 1
         'PRODN2 VARCHAR(40), ' + // product table field name 2
         'PRODN3 VARCHAR(40), ' + // product table field name 3
         'PRODN4 VARCHAR(40), ' + // product table field name 4
         'SCOST MONEY, ' + // sell at cost
         'RCOST MONEY, ' +  // retail cost
         'YCOST MONEY', // your cost
         {----------------}
         'SO');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
   end;

   // Setup the Report Query
   fReportQuery.Close();
   fReportQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report;
   fReportQuery.Open();
   lineItemCount := 0;

   // ######### PRODUCTS #########################

   // First, PULL all products
   fProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID ) +
      ' ORDER BY SO';

   fProdQuery.Open();
   if ( fProdQuery.RecordCount <> 0 ) then
   repeat
      fReportQuery.Append();
      //
      fReportQuery.FieldByName('NUM').AsString := fProdQuery.FieldByName('NUM').AsString;
      fReportQuery.FieldByName('BOT').AsInteger := fProdQuery.FieldByName('BOT').AsInteger;
      fReportQuery.FieldByName('LIFREE').AsBoolean := fProdQuery.FieldByName('LIFREE').AsBoolean;
      fReportQuery.FieldByName('TAX').AsString := fProdQuery.FieldByName('TAX').AsString;
      fReportQuery.FieldByName('SQTY').AsInteger := fProdQuery.FieldByName('SQTY').AsInteger;
      fReportQuery.FieldByName('RQTY').AsInteger := fProdQuery.FieldByName('RQTY').AsInteger;
      fReportQuery.FieldByName('FQTY').AsInteger := fProdQuery.FieldByName('FQTY').AsInteger;
      fReportQuery.FieldByName('PQTY').AsInteger := fProdQuery.FieldByName('PQTY').AsInteger;
      inc(lineItemCount);
      fReportQuery.FieldByName('SO').AsInteger := lineItemCount;
      fReportQuery.FieldByName('NAME').AsString := fProdQuery.FieldByName('NAME').AsString;
      fReportQuery.FieldByName('DESCR').AsString := fProdQuery.FieldByName('DESCR').AsString;
      fReportQuery.FieldByName('PRODN1').AsString := fProdQuery.FieldByName('PRODN1').AsString;
      fReportQuery.FieldByName('PRODN2').AsString := fProdQuery.FieldByName('PRODN2').AsString;
      fReportQuery.FieldByName('PRODN3').AsString := fProdQuery.FieldByName('PRODN3').AsString;
      fReportQuery.FieldByName('PRODN4').AsString := fProdQuery.FieldByName('PRODN4').AsString;
      fReportQuery.FieldByName('SCOST').AsCurrency := fProdQuery.FieldByName('SCOST').AsCurrency;
      fReportQuery.FieldByName('RCOST').AsCurrency := fProdQuery.FieldByName('RCOST').AsCurrency;
      fReportQuery.FieldByName('YCOST').AsCurrency := fProdQuery.FieldByName('YCOST').AsCurrency;
      //
      fReportQuery.Post();
      //
      fProdQuery.Next();
   until fProdQuery.Eof;
   fProdQuery.Close();

   // ######### FEES #########################
   (*
   ObjVerf := tKeyVerif.Create;
   ObjVerf.Tk4726TuI;
   *)
   //

   // Second, PULL all the fees
   fFeeQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Fee +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   fFeeQuery.Open();
   if ( fFeeQuery.RecordCount <> 0 ) then
   repeat
      fReportQuery.Append();
      //
      fReportQuery.FieldByName('NUM').AsString := 'FEE';
      fReportQuery.FieldByName('BOT').AsInteger := 0;
      fReportQuery.FieldByName('LIFREE').AsBoolean := False;
      fReportQuery.FieldByName('TAX').AsString := fFeeQuery.FieldByName('TAX').AsString;
      fReportQuery.FieldByName('SQTY').AsInteger := 1;
      fReportQuery.FieldByName('RQTY').AsInteger := 0;
      fReportQuery.FieldByName('FQTY').AsInteger := 0;
      fReportQuery.FieldByName('PQTY').AsInteger := 0;
      inc(lineItemCount);
      fReportQuery.FieldByName('SO').AsInteger := lineItemCount;
      fReportQuery.FieldByName('NAME').AsString := fFeeQuery.FieldByName('NAME').AsString;
      fReportQuery.FieldByName('DESCR').AsString := fFeeQuery.FieldByName('DESCR').AsString;
      fReportQuery.FieldByName('PRODN1').AsString := '';
      fReportQuery.FieldByName('PRODN2').AsString := '';
      fReportQuery.FieldByName('PRODN3').AsString := '';
      fReportQuery.FieldByName('PRODN4').AsString := '';
      fReportQuery.FieldByName('SCOST').AsCurrency := fFeeQuery.FieldByName('AMOUNT').AsCurrency;
      fReportQuery.FieldByName('RCOST').AsCurrency := fFeeQuery.FieldByName('AMOUNT').AsCurrency;
      //
      fReportQuery.Post();
      //
      fFeeQuery.Next;
   until fFeeQuery.Eof;
   fFeeQuery.Close();

   // Now close it adn reset it
   fReportQuery.First();
   QReport.DataSet := fReportQuery;

   // ******************************************************************************************************** //

   // ************* TOTALS, AMOUNTS, PAYMENTS, ETC ****************************************** //

   // CUSTOMER SOLD TO RECORD
   custRec := Customer_GetCustomerByCustID( orderInvoice.Customer_SoldToID );
   cust_phones := '';
   if ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTHome)) OR ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTAll) ) then
      if ( custRec.PHONEH <> '' ) then
      cust_phones := cust_phones + ' (H ' + custrec.PHONEH + ')';
   if ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTCell)) OR ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTAll) ) then
      if ( custRec.PHONEC <> '' ) then
      cust_phones := cust_phones + ' (C ' + custrec.PHONEC + ')';
   if ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTWork)) OR ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTAll) ) then
      if ( custRec.PHONEW <> '' ) then
      cust_phones := cust_phones + ' (W ' + custrec.PHONEW + ')';
   if ( cust_phones <> '' ) then
      db_custname.Caption := custRec.FULLNAME + cust_phones
   else
      db_custname.Caption := custRec.FULLNAME;
   db_custaddr.Caption := custRec.ADDR1;
   db_custcitystatezip.Caption := custRec.CITYSTATEZIP;

   // CUSTOMER SHIP TO RECORD
   db_shipcustname.Caption := '';
   db_shipcustaddr.Caption := '';
	db_shipcustcitystatezip.Caption := '';
   custRec := Customer_GetCustomerByCustID( orderInvoice.Customer_ShipToID );
   cust_phones := '';
   if ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTHome)) OR ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTAll) ) then
      if ( custRec.PHONEH <> '' ) then
      cust_phones := cust_phones + ' (H ' + custrec.PHONEH + ')';
   if ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTCell)) OR ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTAll) ) then
      if ( custRec.PHONEC <> '' ) then
      cust_phones := cust_phones + ' (C ' + custrec.PHONEC + ')';
   if ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTWork)) OR ( Pref_GetInteger(tPrefConstants.INVCPH, 0) = integer(tInvoiceCustPhoneTypes.ICPTAll) ) then
      if ( custRec.PHONEW <> '' ) then
      cust_phones := cust_phones + ' (W ' + custrec.PHONEW + ')';
   if ( cust_phones <> '' ) then
      db_shipcustname.Caption := custRec.FULLNAME + cust_phones
   else
      db_shipcustname.Caption := custRec.FULLNAME;
   db_shipcustaddr.Caption := custRec.ADDR1;
   db_shipcustcitystatezip.Caption := custRec.CITYSTATEZIP;
   if ( custRec.FULLNAME = '') then
   begin
   	db_shipcustname.Caption := '';
      db_shipcustname.Enabled := False;
   	db_shipcustaddr.Caption := '';
      db_shipcustaddr.Enabled := False;
   	db_shipcustcitystatezip.Caption := '';
      db_shipcustcitystatezip.Enabled := False;
      ShipToTitleLabel.Caption := '';
      ShipToTitleLabel.Enabled := False;
   end;

   // All the Items
   if ( Pref_GetBoolean(tPrefConstants.ORGONINVLAB, True) ) then
   	ReportLabel.Caption := orderInvoice.Org_GetOrgName + ' Invoice # ' + IntToStr( orderInvoice.Order_GetOrderNumber )
   else
   	ReportLabel.Caption := 'Invoice # ' + IntToStr( orderInvoice.Order_GetOrderNumber );

   InvoiceDateLabel.Caption := 'Date: ' + DateToStr( orderInvoice.Order_GetOrderDate );

   orgCycleText := ORg_GetOrgCycleNameByID( orderInvoice.OrgID );
   SalesCycleLabel.Caption := orgCycleText + ' ' + orderInvoice.Cycle_GetCycleName;

   ReportNameLabel.Caption := Org_GetOrgInvoiceTitleByOrgID( orderInvoice.OrgID );
   db_fees.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_FeeTotal);
   db_shipping.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_ShippingSubTotal);
   db_salestax.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_TotalTax);

   // Invoice Message
   db_imsg.caption := orderInvoice.Order_Message;

   // Amount Due, Amount Paid, Amount Over Paid
   db_subtotal.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_LineItemTotal);
   db_invoicetotal.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_Total);
   db_mop.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_TotalMOP);
   db_void.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_VoidNSF);
   if ( orderInvoice.Amount_TotalDue > 0 ) then
   begin
      db_amountdue.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_TotalDue);
      amountdue_label.Caption := 'AMOUNT DUE:';
   end;
   if ( orderInvoice.Amount_TotalDue = 0 ) then
   begin
      db_amountdue.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_TotalDue);
      amountdue_label.Caption := 'BALANCE:';
   end;
   if ( orderInvoice.Amount_OverPaid <> 0 ) then
   begin
      db_amountdue.Caption := FormatFloat( currSymb + '####0.00', orderInvoice.Amount_OverPaid);
      amountdue_label.Caption := 'CHANGE DUE:';
   end;

   // remove voided payments line?
   if ( orderInvoice.Amount_VoidNSF = 0 ) then
   begin
      db_void_label.enabled := false;
      db_void.enabled := false;
      //
      amountdue_label.top := 122;
      db_amountdue.top := 122;
      //
      totals_shape.height := 140;
      Band_Summary.height := 163;
   end;

   // invoice line captions
   invHead.Caption := Pref_GetString(tPrefConstants.INVHEAD, '');
   invLine1.Caption := FillInvoiceLine(tPrefConstants.INV1);
   invLine2.Caption := FillInvoiceLine(tPrefConstants.INV2);
   invLine3.Caption := FillInvoiceLine(tPrefConstants.INV3);
   invLine4.Caption := FillInvoiceLine(tPrefConstants.INV4);
   invLine5.Caption := FillInvoiceLine(tPrefConstants.INV5);
   invLine6.Caption := FillInvoiceLine(tPrefConstants.INV6);
   //
   FreeAndNil( fProdQuery );
   FreeAndNil( fFeeQuery );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

destructor TReport_InvoiceForm.destroy;
begin
   //
   FreeAndNil( orderInvoice );
   fReportQuery.Close();
   FreeAndNil( fReportQuery );
   //FreeAndNil(ObjVerf);
   inherited destroy;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TReport_InvoiceForm.FillInvoiceLine(inPref: tPrefConstants ): String;
begin
   //KeyRepName := ObjVerf.FIRST_NAME + ' ' + ObjVerf.MIDDLE_INITIAL + ' ' + ObjVerf.LAST_NAME;
   KeyRepName := Pref_GetString(tPrefConstants.RepName, '');

   (*
   if NOT(ObjVerf.Tk4726TuI) then
      KeyRepName := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #78 + #111 + #116 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100; {AvoBase Not Registered}
	if (ObjVerf.Tk4726TuI) AND NOT(ObjVerf.Tk4726Tu1) then
      KeyRepName := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #78 + #111 + #116 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100; {AvoBase Not Registered}
   *)
   case Pref_GetInteger( inPref, integer(tInvoiceLineDisplayItems.InvLineBlank) ) of
      integer(tInvoiceLineDisplayItems.InvLineBlank) : result := '';
      integer(tInvoiceLineDisplayItems.InvLineSalesRepName) : result := KeyRepName;
      integer(tInvoiceLineDisplayItems.InvLineAddr1) : result := Pref_GetString(tPrefConstants.RepAddress1, '');
      integer(tInvoiceLineDisplayItems.InvLineAddr2) : result := Pref_GetString(tPrefConstants.RepAddress2, '');
      integer(tInvoiceLineDisplayItems.InvLineEmail) : result := Pref_GetString(tPrefConstants.RepEmail, '');
      integer(tInvoiceLineDisplayItems.InvLineCityStateZip) :
         result := Pref_GetString(tPrefConstants.RepCity, '') + ', ' + Pref_GetString(tPrefConstants.RepState, '') + ', ' + Pref_GetString(tPrefConstants.RepZip, '');
      integer(tInvoiceLineDisplayItems.InvLinePhone) : result := Pref_GetString(tPrefConstants.RepPhone, '');
      integer(tInvoiceLineDisplayItems.InvLineCell) : result := Pref_GetString(tPrefConstants.RepCell, '');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


procedure TReport_InvoiceForm.Band_DetailAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
   // DO NOTTHING

end;

procedure TReport_InvoiceForm.Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
   amtCost : currency;
   amtTotalCost : currency;
   qty : integer;
   prodName : string;
   discName : string;
   sCost : currency;
   rCost : currency;
   yCost : currency;
   discPcnt : real;
   discStr : string;
   errResult : tErrorResult;
   ProductInfo : string;
begin
   inherited;
   //
   if ( lineColor = clWhite ) then
      lineColor :=  $00DFDFDF
   else
      lineColor := clWhite;
   Band_Detail.Color := lineColor;
   Band_Detail_Child_ProdInfo.Color := lineColor;
   Band_Detail_Child_ProdInfo.Color := lineColor;

   // Startup  - all items go into db_prodInfo
   db_prodinfo.caption := '';
   ProductInfo := '';

   //
   db_num.Caption := fReportQuery.FieldByName('NUM').AsString;

   qty := 0;
   //
   qty := fReportQuery.FieldByname('SQTY').AsInteger;
   qty := qty + fReportQuery.FieldByname('FQTY').AsInteger;
   //
   db_qty.Caption := IntToStr( qty );

   // build the product name and add the PROD? descriptions to it plus the comment
   prodName := fReportQuery.FieldByname('NAME').AsString;

   // User Defined Product Fields
   if ( Org_GetOrgProductSpecialField( orderInvoice.OrgID, 'PRODN1') <> '' ) then
      if ( fReportQuery.FieldByName('PRODN1').AsString <> '' ) then
         prodName := prodName + ' (' + Org_GetOrgProductSpecialField( orderInvoice.OrgID, 'PRODN1') + ': ' + fReportQuery.FieldByname('PRODN1').AsString + ')';
   //
   if ( Org_GetOrgProductSpecialField( orderInvoice.OrgID, 'PRODN2') <> '' ) then
      if ( fReportQuery.FieldByName('PRODN2').AsString <> '' ) then
         prodName := prodName + ' (' + Org_GetOrgProductSpecialField( orderInvoice.OrgID, 'PRODN2') + ': ' + fReportQuery.FieldByname('PRODN2').AsString + ')';
   //
   if ( Org_GetOrgProductSpecialField( orderInvoice.OrgID, 'PRODN3') <> '' ) then
      if ( fReportQuery.FieldByName('PRODN3').AsString <> '' ) then
         prodName := prodName + ' (' + Org_GetOrgProductSpecialField( orderInvoice.OrgID, 'PRODN3') + ': ' + fReportQuery.FieldByname('PRODN3').AsString + ')';
   //
   if ( Org_GetOrgProductSpecialField( orderInvoice.OrgID, 'PRODN4') <> '' ) then
      if ( fReportQuery.FieldByName('PRODN4').AsString <> '' ) then
         prodName := prodName + ' (' + Org_GetOrgProductSpecialField( orderInvoice.OrgID, 'PRODN4') + ': ' + fReportQuery.FieldByname('PRODN4').AsString + ')';

   // Description
   if (fReportQuery.FieldByname('DESCR').AsString <> '') then
      prodName := prodName + ' (' + fReportQuery.FieldByname('DESCR').AsString + ')';

   // Now assign it
   db_name.Caption := prodName;

   qty := fReportQuery.FieldByname('SQTY').AsInteger;
   amtCost := fReportQuery.FieldByname('SCOST').AsCurrency;
   amtTotalCost := ( amtCost * qty );
   // Is it a No Charge Free Item?
   if (fReportQuery.FieldByName('LIFREE').AsBoolean) then
      amtTotalCost := 0.00;
   db_cost.Caption := FormatFloat( currSymb + '####0.00', amtCost);
   db_totalcost.Caption := FormatFloat( currSymb + '####0.00', amtTotalCost);

   // back ordered
   case fReportQuery.FieldByname('BOT').AsInteger of
      integer(tBackOrderTypes.BOOrdered): ProductInfo := ProductInfo + '* The above Product has been back ordered.' + #32;
      integer(tBackOrderTypes.BONotShipped): ProductInfo := ProductInfo + '* The above Product has been miss-shipped.' + #32;
      integer(tBackOrderTypes.BONoLongerAvail): ProductInfo := ProductInfo + '* The above Product is no longer available or has been discontinued.' + #32;
   end;

   // Line Item Free?
   if (fReportQuery.FieldByName('LIFREE').AsBoolean) then
      ProductInfo := ProductInfo + ' * You will not be billed on this invoice.';

   // Any FQTY? Free Quantity? OR Discounts - on the same line
   if ( fReportQuery.FieldByName('FQTY').AsInteger ) > 0 then
   	ProductInfo := ProductInfo + ' * Order contains ' + fReportQuery.FieldByName('FQTY').AsString + ' FREE item(s)' + #32;

   // discounts
	discName := '';
   db_disclabel.Caption := '';
   if (orderInvoice.Order_ShowDiscount) then
   begin
      rCost := fReportQuery.FieldByName('RCOST').AsCurrency;
      sCost := fReportQuery.FieldByName('SCOST').AsCurrency;
      if (rCost <> sCost) AND (sCost <> 0) then
      begin
         discPcnt := ( sCost * 100 / rCost ) - 100;
         STR( discPcnt : 2:0, discStr);
         System.Delete( discStr,1,1 );
         discName := discName + ' ' + discStr + '% off!';
      end;
      if ( discname <> '' ) then
      	db_disclabel.Caption := discName;
   end;

   // Prior returned items?
   qty := fReportQuery.FieldByName('PQTY').AsInteger;
   if ( qty <> 0 ) then
      ProductInfo := ProductInfo + ' * ' + IntToStr( qty ) + ' Item(s) have been Returned.';

   // do we turn off the SHIP_TO label?
	if ( db_shipcustname.Caption = '' ) then
      ShipToTitleLabel.Caption := '';

   // DONE HERE.
   if ( ProductInfo <> '' ) then
   	db_prodinfo.Caption  := ProductInfo;

end;

{
   tBackOrderTypes = ( None = 0, BackOrdered = 1, BONotShipped = 2, BONoLongerAvail = 3);


            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'RQTY INTEGER, ' + // return qty
            'FQTY INTEGER, ' + // free quantity (for by X get X free)
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
// Coloration for line items

procedure TReport_InvoiceForm.Band_Detail_Child_ProdInfoBeforePrint( Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   if ( db_prodinfo.Caption = '') then
      PrintBand := false;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.


