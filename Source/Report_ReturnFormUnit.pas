 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_ReturnFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   recordstructureunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   return_invoiceobjectunit,
   avobase_percentformunit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_orgtoolboxunit,
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
   verificationunit,
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
  tReport_Return = class(TAvoBase_ReportBase)
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
    QRShape2: TQRShape;
    mop_label: TQRLabel;
    db_amountrefund: TQRLabel;
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
    Band_Summary_Child1: TQRChildBand;
    db_imsg: TQRLabel;
    invHead: TQRLabel;
    invLine1: TQRLabel;
    invLine2: TQRLabel;
    invLine3: TQRLabel;
    invLine4: TQRLabel;
    invLine5: TQRLabel;
    invLine6: TQRLabel;
    db_custaddr: TQRLabel;
    db_custcitystatezip: TQRLabel;
    db_priororder: TQRLabel;
    db_disclabel: TQRLabel;
    db_image: TQRImage;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
   private
      currSymb : string;
      fOrderID : string;
      fReportQuery : tQuery;
      prevOrderInvoice : tReturnInvoice;
      fProdQuery : tQuery;
      fPriorInvoiceBalance : currency;
      function FillInvoiceLine( inPref : tPrefConstants) : String;
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


constructor tReport_Return.create(Owner: tComponent; inOrderID: string);
var
   errResult : tErrorResult;
   fQuery : tQuery;
   custRec : tCustRec;
   fProdQuery : tQuery;
   fFeeQuery : tQuery;
   lineItemCount : integer;
   orgCycleText : string;
begin
   inherited Create( Owner );
   ColorDetailBand := true;

   //
   prevOrderInvoice := tReturnInvoice.Create( InvoiceTypeReport, nil, nil );
   fProdQuery := masterData.GetQuery();
   fReportQuery := masterData.GetQuery();
   fFeeQuery := masterData.GetQuery();
   currSymb := Pref_GetCashSymbol;

   // Load
   errResult := prevOrderInvoice.Load( inOrderID );
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
         'RCOST MONEY',  // retail cost
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
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
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

{
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
}
      //
      fReportQuery.Post();
      //
      fProdQuery.Next();
   until fProdQuery.Eof;
   fProdQuery.Close();

   // ######### FEES #########################

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


{
         retVal := masterData.AddTable(masterData.dbPath + table_order_fee,
            'ID VARCHAR(40), ' +
            'R_ID VARCHAR(40), ' + // return prior order_product_ID
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'TAX FLOAT, ' + // tax rate
            'RET BOOLEAN, ' + // fee has been refunded? (returned)? if so, don't bring back on RETURN invoice
            'RETFLAG BOOLEAN, ' + // only for returns, flagged as required for return
            'RETADD BOOLEAN, ' + // applies only to returns, is a fee that can be added or subtracted
            'AMOUNT MONEY',
            'ID');
            }
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

   //
   custRec := Customer_GetCustomerByCustID( prevOrderInvoice.CustSoldToID );
   db_custname.Caption := custRec.FULLNAME;
   db_custaddr.Caption := custRec.ADDR1;
   db_custcitystatezip.Caption := custRec.CITYSTATEZIP;

   // All the Items
   if ( Pref_GetBoolean(tPrefConstants.ORGONINVLAB, True) ) then
   	ReportLabel.Caption := prevOrderInvoice.OrgName + ' Return Invoice # ' + IntToStr( prevOrderInvoice.Order_GetOrderNum )
   else
   	ReportLabel.Caption := 'Return Invoice # ' + IntToStr( prevOrderInvoice.Order_GetOrderNum );

   //
   db_priororder.Caption := 'Prior Invoice #' + Order_GetOrderNumberByOrderID( prevOrderInvoice.PriorOrderID );

   //
   InvoiceDateLabel.Caption := 'Date: ' + DateToStr( prevOrderInvoice.Order_GetOrderDate );

   //
   orgCycleText := ORg_GetOrgCycleNameByID( prevOrderInvoice.OrgID );
   SalesCycleLabel.Caption := orgCycleText + ' ' + prevOrderInvoice.Cycle_GetCycleName;

   ReportNameLabel.Caption := Org_GetOrgInvoiceTitleByOrgID( prevOrderInvoice.OrgID );
   db_fees.Caption := FormatFloat( currSymb + '####0.00', prevOrderInvoice.Amount_FeeTotal);
   db_shipping.Caption := FormatFloat( currSymb + '####0.00', prevOrderInvoice.Amount_ShippingTotal);
   db_salestax.Caption := FormatFloat( currSymb + '####0.00', prevOrderInvoice.Amount_TotalTax);

   // Invoice Message
   db_imsg.caption := prevOrderInvoice.Order_Message;

   // Amount Due, Amount Paid, Amount Over Paid
   db_subtotal.Caption := FormatFloat( currSymb + '####0.00', prevOrderInvoice.Amount_LineItemTotal);
   db_amountrefund.Caption := FormatFloat( currSymb + '####0.00', prevOrderInvoice.Amount_TotalRefund);

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

destructor tReport_Return.destroy;
begin
   //
   FreeAndNil( prevOrderInvoice );
   fReportQuery.Close();
   FreeAndNil( fReportQuery );
   //
   inherited destroy;
end;



function tReport_Return.FillInvoiceLine(inPref: tPrefConstants): String;
var
//	ty345Gt : tKeyVerif;
   KeyRepName : string;
begin
   (*
   ty345Gt := tKeyVerif.Create;
   ty345GT.Tk4726TuI;
   //
   KeyRepName := ty345Gt.FIRST_NAME + ' ' + ty345Gt.LAST_NAME;
   *)
   KeyRepName :=  Pref_GetString(tPrefConstants.RepName, '');
   (*
   if NOT(ty345Gt.Tk4726TuI) then
      KeyRepName := #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #78 + #111 + #116 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 + #114 + #101 + #100; {AvoBase Not Registered}
	if (ty345Gt.Tk4726TuI) AND NOT(ty345Gt.Tk4726Tu1) then
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
   //FreeAndNil(ty345Gt);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReport_Return.Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
   amtCost : currency;
   amtTotalCost : currency;
   qty : integer;
   prodName : string;
   discName : string;
   sCost : currency;
   rCost : currency;
   discPcnt : real;
   discStr : string;
   errResult : tErrorResult;
begin
   inherited;
   //
   db_num.Caption := fReportQuery.FieldByName('NUM').AsString;

   // Set up Quantity Proper
   {
   qty := 0;
   qty := fReportQuery.FieldByname('SQTY').AsInteger;
   qty := qty + fReportQuery.FieldByname('FQTY').AsInteger;
   db_qty.Caption := IntToStr( qty );
   }
   qty := 0;
   qty := fReportQuery.FieldByname('RQTY').AsInteger;
   db_qty.Caption := IntToStr( qty );

   // rerturn quantity - if NO items are being returned, then
   if ( fReportQuery.FieldByName('RQTY').AsInteger = 0 ) then
      PrintBand := False;

   prodName := fReportQuery.FieldByname('NAME').AsString;

   // User Defined Product Fields
   if ( Org_GetOrgProductSpecialField( prevOrderInvoice.OrgID, 'PRODN1') <> '' ) then
      if ( fReportQuery.FieldByName('PRODN1').AsString <> '' ) then
         prodName := prodName + ' (' + Org_GetOrgProductSpecialField( prevOrderInvoice.OrgID, 'PRODN1') + ': ' + fReportQuery.FieldByname('PRODN1').AsString + ')';
   //
   if ( Org_GetOrgProductSpecialField( prevOrderInvoice.OrgID, 'PRODN2') <> '' ) then
      if ( fReportQuery.FieldByName('PRODN2').AsString <> '' ) then
         prodName := prodName + ' (' + Org_GetOrgProductSpecialField( prevOrderInvoice.OrgID, 'PRODN2') + ': ' + fReportQuery.FieldByname('PRODN2').AsString + ')';
   //
   if ( Org_GetOrgProductSpecialField( prevOrderInvoice.OrgID, 'PRODN3') <> '' ) then
      if ( fReportQuery.FieldByName('PRODN3').AsString <> '' ) then
         prodName := prodName + ' (' + Org_GetOrgProductSpecialField( prevOrderInvoice.OrgID, 'PRODN3') + ': ' + fReportQuery.FieldByname('PRODN3').AsString + ')';
   //
   if ( Org_GetOrgProductSpecialField( prevOrderInvoice.OrgID, 'PRODN4') <> '' ) then
      if ( fReportQuery.FieldByName('PRODN4').AsString <> '' ) then
         prodName := prodName + ' (' + Org_GetOrgProductSpecialField( prevOrderInvoice.OrgID, 'PRODN4') + ': ' + fReportQuery.FieldByname('PRODN4').AsString + ')';

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


   // discounts
   discName := '';

   if (prevOrderInvoice.ShowDiscount ) then
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
   end;
   db_disclabel.Caption := discName;

{ copied from invoice, but may not be used...

   // back ordered
   db_backordered.caption := '';
   case fReportQuery.FieldByname('BOT').AsInteger of
      integer(tBackOrderTypes.BOOrdered): db_backordered.Caption := '*The above Product has been back ordered.';
      integer(tBackOrderTypes.BONotShipped): db_backordered.Caption := '*The above Product has been miss-shipped.';
      integer(tBackOrderTypes.BONoLongerAvail): db_backordered.Caption := '*The above Product is no longer available or has been discontinued.';
   end;

   // Line Item Free?
   if (fReportQuery.FieldByName('LIFREE').AsBoolean) then
      db_backordered.Caption := db_backordered.Caption + 'You will not be billed on this invoice.';

   // Prior returned items?
   qty := fReportQuery.FieldByName('PQTY').AsInteger;
   if ( qty <> 0 ) then
      db_return.Caption := '* ' + IntToStr( qty ) + ' Item(s) have been Returned.'
   else
      db_return.Caption := '';

}

end;

end.



(*


unit Report_ReturnFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   return_invoiceobjectunit,
   avobase_percentformunit,
   toolbox_customertoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_ordertoolboxunit,
   Customer_SelectFormUnit,
   toolbox_orgtoolboxunit,
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
  tReport_Return = class(TAvoBase_ReportBase)
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
    QRShape2: TQRShape;
    mop_label: TQRLabel;
    db_amountrefund: TQRLabel;
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
    Band_Summary_Child1: TQRChildBand;
    db_imsg: TQRLabel;
    invHead: TQRLabel;
    invLine1: TQRLabel;
    invLine2: TQRLabel;
    invLine3: TQRLabel;
    invLine4: TQRLabel;
    invLine5: TQRLabel;
    invLine6: TQRLabel;
    db_custaddr: TQRLabel;
    db_custcitystatezip: TQRLabel;
    db_priororder: TQRLabel;
    db_disclabel: TQRLabel;
    procedure Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
   private
      currSymb : string;
      fOrderID : string;
      ReturnInvoice : tReturnInvoice;
      fProdQuery : tQuery;
      fPriorInvoiceBalance : currency;
      function FillInvoiceLine( inPref : string ) : String;
   public
      constructor create( Owner : tComponent; inOrderID : string ); overload;
      destructor destroy; overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


constructor tReport_Return.create(Owner: tComponent; inOrderID: string);
var
   errResult : tErrorResult;
   prevOrderInvoice : tReturnInvoice;
   fQuery : tQuery;
   custRec : tCustRec;
begin
   inherited Create( Owner );
   ColorDetailBand := true;

   //
   ReturnInvoice := tReturnInvoice.Create( InvoiceTypeReport, nil, nil );
   fProdQuery := masterData.GetQuery;
   currSymb := Pref_GetCashSymbol;

   // Load
   errResult := ReturnInvoice.Load( inOrderID );
   if (errResult.errorResult) then
   begin
      Error_Log( errResult, true );
      exit;
   end;

   // Setup the Order Product Query for the order
   fProdQuery.SessionName := masterData.AvoBaseSession.SessionName;
   fProdQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Order_Product +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   fProdQuery.Open();
   ReportInvoice.DataSet := fProdQuery;

   //
   custRec := Customer_GetCustomerByCustID( ReturnInvoice.CustSoldToID );
   db_custname.Caption := custRec.FULLNAME;
   db_custaddr.Caption := custRec.ADDR1;
   db_custcitystatezip.Caption := custRec.CITYSTATEZIP;

   // All the Items
   if ( Pref_GetBoolean('ORGONINVLAB') ) then
   	ReportLabel.Caption := ReturnInvoice.OrgName + ' Return Invoice # ' + IntToStr( ReturnInvoice.OrderNum )
   else
   	ReportLabel.Caption := ' Return Invoice # ' + IntToStr( ReturnInvoice.OrderNum );

   //
   db_priororder.Caption := 'Prior Invoice #' + Order_GetOrderNumberByOrderID( ReturnInvoice.PriorOrderID );

   //
   SalesCycleLabel.Caption := 'Sales Cycle ' + ReturnInvoice.CycleName;
   ReportNameLabel.Caption := Org_GetOrgInvoiceTitleByOrgID( ReturnInvoice.OrgID );
   db_fees.Caption := FormatFloat( currSymb + '####0.00', ReturnInvoice.Amount_FeeTotal);
   db_shipping.Caption := FormatFloat( currSymb + '####0.00', ReturnInvoice.Amount_ShippingTotal);
   db_salestax.Caption := FormatFloat( currSymb + '####0.00', ReturnInvoice.Amount_TotalTax);

   // Invoice Message
   db_imsg.caption := ReturnInvoice.InvoiceMessage;

   // Amount Due, Amount Paid, Amount Over Paid
   db_subtotal.Caption := FormatFloat( currSymb + '####0.00', ReturnInvoice.Amount_LineItemTotal);
   db_amountrefund.Caption := FormatFloat( currSymb + '####0.00', ReturnInvoice.Amount_TotalRefund);

   // invoice line captions
   invHead.Caption := Pref_GetString('INVHEAD');
   invLine1.Caption := FillInvoiceLine('INV1');
   invLine2.Caption := FillInvoiceLine('INV2');
   invLine3.Caption := FillInvoiceLine('INV3');
   invLine4.Caption := FillInvoiceLine('INV4');
   invLine5.Caption := FillInvoiceLine('INV5');
   invLine6.Caption := FillInvoiceLine('INV6');
end;

{
            'ID VARCHAR(40), ' +
            'RET_ID VARCHAR(40), ' + // The prior order ID only for returns
            'C_ID VARCHAR(40), ' +
            'C_SID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ONUM INTEGER, ' +
            'TAX FLOAT, ' +
            'ODATE DATE, ' +
            'OTIME TIME, ' +
            'SHIPAMT MONEY, ' +
            'STATUS INTEGER, ' +
            'WTAX BOOLEAN, ' +
            'WSHIP BOOLEAN, ' +
            'WSHIPTAX BOOLEAN, ' + // wave shipping?
            'SHIPTAX FLOAT, ' + // shipping tax rate
            'SHOW_DISC BOOLEAN, ' +
            'O_TYPE INTEGER, ' +
            'I_MSG BLOB(240,1)',
}

destructor tReport_Return.destroy;
begin
   fProdQuery.Close();
   //
   FreeAndNil( ReturnInvoice );
   FreeAndNil( fProdQuery );
   //
   inherited destroy;
end;

function tReport_Return.FillInvoiceLine(inPref: string): String;
begin
{   tInvoiceLineDisplayItems = ( InvLineBlank = 0, InvLineSalesRepName = 1, InvLineAddr1 = 2,
      InvLineAddr2 = 3, InvLineEmail = 4, InvLineCityStateZip = 5, InvLinePhone = 6, InvLineCell = 7); }
   case Pref_GetInteger( inPref ) of
      integer(tInvoiceLineDisplayItems.InvLineBlank) : result := '';
      integer(tInvoiceLineDisplayItems.InvLineSalesRepName) : result := 'Get Key Rep Name';
      integer(tInvoiceLineDisplayItems.InvLineAddr1) : result := Pref_GetString('RADDR1');
      integer(tInvoiceLineDisplayItems.InvLineAddr2) : result := Pref_GetString('RADDR2');
      integer(tInvoiceLineDisplayItems.InvLineEmail) : result := Pref_GetString('REMAIL');
      integer(tInvoiceLineDisplayItems.InvLineCityStateZip) :
         result := Pref_GetString('RCITY') + ', ' + Pref_GetString('RSTATE') + ', ' + Pref_GetString('RZIP');
      integer(tInvoiceLineDisplayItems.InvLinePhone) : result := Pref_GetString('RPHONE');
      integer(tInvoiceLineDisplayItems.InvLineCell) : result := Pref_GetString('RCELL');
   end;
{
            'RPHONE VARCHAR(20), ' +
            'RFAX VARCHAR(20), ' +
            'RCELL VARCHAR(20), ' +
            'RADDR1 VARCHAR(40), ' +
            'RADDR2 VARCHAR(40), ' +
            'RCITY VARCHAR(40), ' +
            'RZIP VARCHAR(20), ' +
            'RSTATE VARCHAR(40), ' +
            'REMAIL VARCHAR(60), ' +
            'RCOMP VARCHAR(120), ' +
}
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tReport_Return.Band_DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
   amtCost : currency;
   amtTotalCost : currency;
   qty : integer;
   prodName : string;
   discName : string;
   sCost : currency;
   rCost : currency;
   discPcnt : real;
   discStr : string;
begin
   inherited;

   //
   // NOTE: Only do what has to do with the PRODUCT TABLE only!

   //
   db_num.Caption := fProdQuery.FieldByName('NUM').AsString;

   qty := 0;
   //
   qty := fProdQuery.FieldByname('SQTY').AsInteger;
   qty := qty + fProdQuery.FieldByname('FQTY').AsInteger;
   //
   db_qty.Caption := IntToStr( qty );

   // We only show product name here. We don't care about book and page.
   prodName := fProdQuery.FieldByname('NAME').AsString;

   //
   db_name.Caption := prodName;

   qty := fProdQuery.FieldByname('SQTY').AsInteger;
   amtCost := fProdQuery.FieldByname('SCOST').AsCurrency;
   amtTotalCost := ( amtCost * qty );
   // Is it a No Charge Free Item?
   if (fProdQuery.FieldByName('LIFREE').AsBoolean) then
      amtTotalCost := 0.00;
   db_cost.Caption := FormatFloat( currSymb + '####0.00', amtCost);
   db_totalcost.Caption := FormatFloat( currSymb + '####0.00', amtTotalCost);


   // discounts
   discName := '';
   db_disclabel.Caption := discName;

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
            'PPAGE VARCHAR(8), ' +
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
*)
