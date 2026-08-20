 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportAccountingShippingCollectedByCycleUnit;

interface uses
   sysutils,
   classes,
   constantsunit,
   recordstructureunit,
   toolboxunit,
   db,
   dbtables,
   bde,
   dateutils,
   inifileunit,
   toolbox_paymenttoolboxunit,
   toolbox_ordertoolboxunit,
   AvoBase_PercentFormUnit,
   toolbox_ProductToolBoxUnit,
   masterdataunit,
   Order_InvoiceObjectUnit,
   Return_InvoiceObjectUnit,
   encryptunit,
   ErrorResultUnit;

type
   tMasterDataReportAccountingShippingCollectedByCycle = class(tQuery)
   private
      InvoiceObj : tInvoice;
      ReturnObj : tReturnInvoice;
      //
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      constructor Create( inMasterData : tMasterData; inOrgID : string;
   inStartYear, inEndYear, InStartNum, InEndNum : integer);  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportAccountingShippingCollectedByCycle.Create( inMasterData : tMasterData; inOrgID : string;
   inStartYear, inEndYear, InStartNum, InEndNum : integer);
var
   errResult : tErrorResult;
   sql : string;
   sqlWhere : string;
   cnt : integer;
   count : integer;
   sqlText : string;
   sqlOpt : string;
   sqlOrdType : string;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   //
   sqlText := 'SELECT O.*, C.ID, C.NUM, C.CYEAR, C.ORG_ID ' +
      ' FROM ' + masterData.GetTable_Order + ' O' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C' +
      ' ON C.ID = O.C_ID';
   //
   sqlOpt := 'O.STATUS = ' + IntToStr(Integer(tOrderStatusTypes.OrderStatusClosed));
   sqlOrdType := IntToStr(Integer(tOrderTypes.OrdTypeOrder));
   //   inOptOpen, inOptClosed, inOptCancel
   //
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30)' +
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (SHIPAMT > 0) AND (O_TYPE=' + sqlOrdType + ')) ';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
         sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( cnt ) + ' ) AND (NUM BETWEEN 1 AND 30)' +
            ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ')  AND (SHIPAMT > 0) AND (O_TYPE=' + sqlOrdType + '))';
      //
      sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( inEndYear ) + ') AND (NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' )' +
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (SHIPAMT > 0) AND (O_TYPE=' + sqlOrdType + '))';
   end;
   //
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30)' +
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (SHIPAMT > 0) AND (O_TYPE=' + sqlOrdType + '))';
   end;
   //
   sqlText := sqlText + sqlWhere;
   sqlText := sqlText + ' ORDER BY O.C_ID DESC';
   //
   // All done, now just open the report.
   self.SQL.Clear();
   self.SQL.Text := sqlText;
   errResult := fMasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CUSTNAME', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 30, ftString);
   masterData.QueryAddCalculatedField( self, 'OTYPE', 10, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 7, ftString);
   masterData.QueryAddCalculatedField( self, 'ITEMS', 1, ftInteger);
   masterData.QueryAddCalculatedField( self, 'TOTAL', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'FEES', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'SHIPPING', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'PAID', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'DISPSTATUS', 30, ftString);
   masterData.QueryAddCalculatedField( self, 'BOI', 1, ftInteger);
   //
	InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
	ReturnObj := tReturnInvoice.Create( InvoiceTypeReport, nil, nil);   //
   PercentForm_Free();
end;

{
         retVal := masterData.AddTable(masterData.dbPath + table_order,
            'ID VARCHAR(40), ' +
            'C_STID VARCHAR(40), ' + // sold to id
            'C_ID VARCHAR(40), ' + // cycle id
            'RET_ID VARCHAR(40), ' + // The prior order ID only for returns
            'C_SHID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'ORG_ID VARCHAR(40), ' +
            'SHIPTAXID VARCHAR(40), ' + // shipping Tax ID
            'ORDTAXID VARCHAR(40), ' + // order tax ID for compound tax
            'ONUM INTEGER, ' + // order number
            'ODATE DATE, ' +
            'OTIME TIME, ' +
            'SHIPAMT MONEY, ' + // stored shipping amount
            'SHIPTAXAMT MONEY, ' + // stored shipping tax
            'CTAXAMT MONEY, ' + // stored compound tax amount
            'STATUS INTEGER, ' +
            'WTAX BOOLEAN, ' +
            'WSHIP BOOLEAN, ' +
            'WSHIPTAX BOOLEAN, ' + // wave shipping?
            'SHIPTAX FLOAT, ' + // shipping tax rate
            'REFSHIP BOOLEAN, ' + // for returns only. Refund shipping?
            'SHIPREF BOOLEAN, ' + // for prior orders, mark shipping as refunded
            'SHOW_DISC BOOLEAN, ' + // show discounts on invoice?
            'O_TYPE INTEGER, ' + // order type
            'I_MSG BLOB(240,1)', // invoice special message
}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportAccountingShippingCollectedByCycle.destroy;
begin
   FreeAndNil(	InvoiceObj );
   FreeAndNil(	ReturnObj );
   //
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportAccountingShippingCollectedByCycle.HandleCalculated(DataSet: TDataSet);
begin
   case Self.FieldByname('O_TYPE').AsInteger of
      integer(OrdTypeOrder):
      begin
         InvoiceObj.Load( Self.FieldByname('ID').AsString );
         DataSet.FieldByName('CUSTNAME').AsString := InvoiceObj.Customer_GetSoldToName;
         DataSet.FieldByName('ORGNAME').AsString := InvoiceObj.Org_GetOrgName;
         DataSet.FieldByName('OTYPE').AsString := 'ORDER';
         DataSet.FieldByName('CYCLE').AsString := InvoiceObj.Cycle_GetCycleName;
         DataSet.FieldByName('ITEMS').asInteger := InvoiceObj.LineItemCount;
         DataSet.FieldByName('TOTAL').AsCurrency := InvoiceObj.Amount_Total;
         DataSet.FieldByName('TOTAL').AsCurrency := InvoiceObj.Amount_Total;
         DataSet.FieldByName('FEES').AsCurrency := InvoiceObj.Amount_FeeTotal;
         DataSet.FieldByName('SHIPPING').AsCurrency := InvoiceObj.Amount_ShippingSubTotal;
         DataSet.FieldByName('PAID').AsCurrency := InvoiceObj.Amount_TotalMOP - invoiceObj.Amount_VoidNSF;
         DataSet.FieldByname('BOI').AsInteger := InvoiceObj.BackOrderCount;
         DataSet.FieldByName('DISPSTATUS').AsString := InvoiceObj.Order_GetOrderStatusName;

      end;

{
not doing returns in this batch....
      integer(OrdTypeReturn):
      begin
         ReturnObj.Load( Self.FieldByname('ID').AsString );
         DataSet.FieldByName('CUSTNAME').AsString := ReturnObj.Customer_GetSoldToName;
         DataSet.FieldByName('ORGNAME').AsString := ReturnObj.OrgName;
         DataSet.FieldByName('OTYPE').AsString := 'RETURN';
         DataSet.FieldByName('CYCLE').AsString := ReturnObj.Cycle_GetCycleName;
         DataSet.FieldByName('ITEMS').asInteger := ReturnObj.LineItemCount;
         DataSet.FieldByName('TOTAL').AsCurrency := ReturnObj.Amount_TotalRefund;
         DataSet.FieldByName('PAID').AsCurrency := 0.00;
         DataSet.FieldByname('BOI').AsInteger := 0;
         DataSet.FieldByName('DISPSTATUS').AsString := ReturnObj.Order_GetOrderStatusName;
      end;
}
   end;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.



