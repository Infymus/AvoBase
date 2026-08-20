 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportAccountingTaxExemptByCycleUnit;

interface uses
   sysutils,
   classes,
   constantsunit,
   toolboxunit,
   db,
   dbtables,
   bde,
   recordstructureunit,
   dateutils,
   inifileunit,
   toolbox_paymenttoolboxunit,
   toolbox_ordertoolboxunit,
   AvoBase_PercentFormUnit,
   toolbox_ProductToolBoxUnit,
   masterdataunit,
   Order_InvoiceObjectUnit,
   encryptunit,
   ErrorResultUnit;

type
   tMasterDataReportAccountingTaxCollectedByCycle = class(tQuery)
   private
      InvoiceObj : tInvoice;
   public
      fMasterData : tMasterData;
      constructor Create( inMasterData : tMasterData; inOrgID : string;
         inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportAccountingTaxCollectedByCycle.Create( inMasterData : tMasterData; inOrgID : string;
   inStartYear, inEndYear, InStartNum, InEndNum : integer);
var
   errResult : tErrorResult;
   sql : string;
   sqlWhere : string;
   cnt : integer;
   count : integer;
   fQuery : tQuery;
   fWriteQuery : tQuery;
   sqlText : string;
   sqlOpt : string;
   sqlOrdType : string;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   //
	InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
   //
   PercentForm_Create('Gathering Report Data - One Moment Please ...', 0, 1);

   // Build the Report Table
   masterData.RemoveTable( table_report );
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'ID VARCHAR(40), ' + //
         'ONUM INTEGER, ' + // order number
         'ODATE DATE, ' +
         'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
         'STATUS VARCHAR(20), ' +
         'TAXEXID VARCHAR(40), ' +
         'ORDTAX MONEY, ' +
         'TOTAL MONEY',
         'ID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;
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
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (WTAX=TRUE) AND (O_TYPE=' + sqlOrdType + ')) ';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
         sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( cnt ) + ' ) AND (NUM BETWEEN 1 AND 30)' +
            ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (WTAX=TRUE) AND (O_TYPE=' + sqlOrdType + '))';
      //
      sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( inEndYear ) + ') AND (NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' )' +
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (WTAX=TRUE) AND (O_TYPE=' + sqlOrdType + '))';
   end;
   //
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30)' +
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (WTAX=TRUE) AND (O_TYPE=' + sqlOrdType + '))';
   end;
   //
   sqlText := sqlText + sqlWhere;
   sqlText := sqlText + ' ORDER BY O.C_ID DESC';
   //
   fQuery := masterData.GetQuery();
   fWriteQuery := masterData.GetQuery();
   //
   fQuery.SQL.Text := sqlText;
   fQuery.Open();
   //
   fWriteQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report;
   fWriteQuery.Open();
   //
   if ( fQuery.RecordCount <> 0 ) then
   repeat
      InvoiceObj.Load( fQuery.FieldByname('ID').AsString );
      // WRITE IT OUT....
      fWriteQuery.Append();
      fWriteQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
      fWriteQuery.FieldByName('ONUM').AsInteger := InvoiceObj.Order_GetOrderNumber;
      fWriteQuery.FieldByName('ODATE').AsDateTime := InvoiceObj.Order_GetOrderDate;
      fWriteQuery.FieldByName('CYCLENAME').AsString := InvoiceObj.Cycle_GetCycleName;
      fWriteQuery.FieldByName('STATUS').AsString := InvoiceObj.Order_GetOrderStatusName;
      fWriteQuery.FieldByName('ORDTAX').AsCurrency := InvoiceObj.Amount_OrderTaxWaved;
      fWriteQuery.FieldByName('TAXEXID').AsString := InvoiceObj.TaxExemptID;
      fWriteQuery.Post();
      fQuery.Next();
   until fQuery.EOF;
   //
   fWriteQuery.Close();
   fQuery.Close();
   //
   FreeAndNil( fQuery );
   FreeAndNil( fWriteQuery );

   // All done, now just open the report.
   self.SQL.Clear();
   self.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report;
   errResult := fMasterData.QueryAddFields( self );
   //
   PercentForm_Free();
end;

{
         retVal := masterData.AddTable(masterData.dbPath + table_order,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // cycle id
            'RET_ID VARCHAR(40), ' + // The prior order ID only for returns
            'C_SHID VARCHAR(40), ' + // Customer SHIP TO ID
            'C_STID VARCHAR(40), ' + // sold to id
            'ORG_ID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
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
            'TAXEXID VARCHAR(40), ' + // tax exempt id
            'EXORDTAX MONEY, ' + // stored WAVE Order Tax AMOUNT ( for tax exemptions )
            'SHIPTAX FLOAT, ' + // shipping tax rate
            'REFSHIP BOOLEAN, ' + // for returns only. Refund shipping?
            'SHIPREF BOOLEAN, ' + // for prior orders, mark shipping as refunded
            'SHOW_DISC BOOLEAN, ' + // show discounts on invoice?
            'O_TYPE INTEGER, ' + // order type
            'I_MSG BLOB(240,1)', // invoice special message
}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportAccountingTaxCollectedByCycle.destroy;
begin
   FreeAndNil(	InvoiceObj );
   //
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.

