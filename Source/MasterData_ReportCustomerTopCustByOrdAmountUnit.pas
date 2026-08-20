 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportCustomerTopCustByOrdAmountUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
   RecordStructureUnit,
  bde,
  dateutils,
  inifileunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_ProductToolBoxUnit,
  masterdataunit,
  AvoBase_PercentFormUnit,
  Order_InvoiceObjectUnit,
  Return_InvoiceObjectUnit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataReportTopCustByOrdAmount = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update();
      constructor Create( inMasterData : tMasterData; inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportTopCustByOrdAmount.Create( inMasterData : tMasterData; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   errResult : tErrorResult;
   sql : string;
   sqlWhere : string;
   cnt : integer;
   fQuery : tQuery;
   fWriteQuery : tQuery;
   count : integer;
	InvoiceObj : tInvoice;
   ReturnObj : tReturnInvoice;
begin
   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;

   //
   PercentForm_Create('Gathering Report Data - One Moment Please ...', 0, 1);

   // Build the Report Table
   masterData.RemoveTable( table_report );
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'CUSTID VARCHAR(40), ' + // customer id
         'CUSTNAME VARCHAR(60), ' + // customer name
         'AMOUNT MONEY', // total money
         'CUSTID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;

{
SELECT C.FNAME, C.LNAME, O.ID
FROM CYCLE S
INNER JOIN ORD O ON O.C_ID = S.ID
INNER JOIN CUST C ON C.ID = O.C_STID
WHERE
   (( CYEAR = 2010 ) AND ( NUM BETWEEN 1 AND 27 ))
OR
   (( CYEAR = 2011 ) AND ( NUM BETWEEN 1 AND 5 ))
GROUP BY C.FNAME, C.LNAME, O.ID

}
   // build the sql for the data we are going to need
	sql := 'SELECT C.FNAME, C.LNAME, O.ID ' +
      'FROM ' + masterData.GetTable_Cycle + ' S ' +
   	'INNER JOIN ' + masterData.GetTable_Order + ' O ON O.C_ID = S.ID ' +
      'INNER JOIN ' + masterData.Gettable_Customer + ' C ON C.ID = O.C_STID ';
   // Now we have to build the years selected.
   sqlWhere := '';
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) AND ( NUM BETWEEN ' +
         IntToStr( inStartNum ) + ' AND 30 ))';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
      begin
         sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( cnt ) + ' ) AND ( NUM BETWEEN 1 AND 30 ))';
      end;
      //
      sqlWhere := sqlWhere + ' OR (( CYEAR = ' + IntToStr( inEndYear ) + ' ) AND ( NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' ))';
   end;
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE (( CYEAR = ' + IntToStr( inStartYear ) + ' ) AND ( NUM BETWEEN ' +
         IntToStr( inStartNum ) + ' AND ' + IntToStr( inEndNum ) + ' ))';
   end;
   // Combine
   sql := sql + sqlWhere;
   //
   sql := sql + ' GROUP BY C.FNAME, C.LNAME, O.ID';
   //
   fQuery := masterData.GetQuery();
   fQuery.SQL.Clear();
   fQuery.SQL.Text := sql;
   fQuery.Open();
   //
   fWriteQuery := masterData.GetQuery();
   fWriteQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report;
   fWriteQuery.Open();
   //
   // Go through the whole thing and pull the data out the report can use

   PercentForm_IncreaseTotal( fQuery.RecordCount );
   count := 0;
   if ( fQuery.RecordCount <> 0 ) then
   repeat
      PercentForm_Update();
         fWriteQuery.Append();
         fWriteQuery.FieldByName('CUSTID').AsString := masterData.NewDBGuid();
         fWriteQuery.FieldByName('CUSTNAME').AsString := fQuery.FieldByName('FNAME').AsString + ' ' +
            fQuery.FieldByName('LNAME').AsString;
         if ( Order_GetOrderTypeByOrderID( fQuery.FieldByname('ID').AsString ) = OrdTypeOrder ) then
         begin
            InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
            invoiceObj.Load( fQuery.FieldByName('ID').AsString );
            fWriteQuery.FieldByName('AMOUNT').AsCurrency := InvoiceObj.Amount_Total;
            FreeAndNil(InvoiceObj);
         end;
   //
{
   leave out returns for now. but here is a stubby.
   if ( Order_GetOrderTypeByOrderID( Self.FieldByname('ID').AsString ) = OrdTypeReturn ) then
   begin
      ReturnObj := tReturnInvoice.Create( InvoiceTypeReport, nil, nil );
      ReturnObj.Load( fQuery.FieldByName('ID').AsString );
      fWriteQuery.FieldByName('AMOUNT').AsInteger := ReturnObj.Amount_Total;
      FreeAndNil(ReturnObj);
   end;
}
         fWriteQuery.Post();
      fQuery.Next();
   until fQuery.EOF;
   fQuery.Close();
   fWriteQuery.Close();

   // Now we have to eliminate ALL but the last 20 rows because Ansi-92 SQL for Paradox doesn't have a "TOP" command...
   // Build the Report Table
   masterData.RemoveTable( table_report2 );
   if (NOT masterData.TableExists(masterData.GetTable_Report2)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report2,
         'CUSTID VARCHAR(40), ' + // customer id
         'CUSTNAME VARCHAR(60), ' + // customer name
         'AMOUNT MONEY', // total money
         'CUSTID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;
   //
   sql := 'SELECT * FROM ' + masterData.GetTable_Report2;
   fWriteQuery.SQL.text := sql;
   fWriteQuery.Open();

   // get the summation of the above
   sql := 'SELECT CUSTNAME, SUM(AMOUNT) AS AMOUNT FROM ' + masterData.GetTable_Report +
      ' GROUP BY CUSTNAME ' +
      ' ORDER BY AMOUNT DESC';
   fQuery.SQL.Text := sql;
   fQuery.Open();
   //
   PercentForm_IncreaseTotal( fQuery.RecordCount );
   count := 0;
   if ( fQuery.RecordCount <> 0 ) then
   repeat
      PercentForm_Update();
      inc( count );
      //
      if ( count < 21 ) then
      begin
         fWriteQuery.Append();
         fWriteQuery.FieldByName('CUSTID').AsString := masterData.NewDBGuid();
         fWriteQuery.FieldByName('CUSTNAME').AsString := fQuery.FieldByName('CUSTNAME').AsString;
         fWriteQuery.FieldByName('AMOUNT').AsCurrency := fQuery.FieldByName('AMOUNT').AsCurrency;
         fWriteQuery.Post();
      end;
      fQuery.Next();
   until fQuery.EOF;
   fQuery.Close();
   fWriteQuery.Close();

   // now we get our data from THAT report
   sql := 'SELECT * FROM ' + masterData.GetTable_Report2 +
      ' ORDER BY AMOUNT DESC';
   self.SQL.Clear();
   self.SQL.Text := sql;

   errResult := fMasterData.QueryAddFields( self );
   //
   FreeAndNil(fQuery);
   FreeAndNil(fWriteQuery);
   //
   PercentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportTopCustByOrdAmount.destroy;
begin
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportTopCustByOrdAmount.HandleCalculated(DataSet: TDataSet);
begin
	// We have none yere.
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportTopCustByOrdAmount.Update();
begin
	self.Close();
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.



{


      // First get rid of it. Just so that we never have to worry about it.
   masterData.RemoveTable( table_cust_account );

   // First, build the table if it doesn't exist
   if (NOT masterData.TableExists(masterData.GetTable_Cust_Account)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_cust_account,
         'CUSTID VARCHAR(40), ' + // customer id
         'TOT INTEGER', // total orders
         'CUSTID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;



SELECT C.FNAME, C.LNAME, COUNT(*) AS TOT
FROM CYCLE S
INNER JOIN ORD O ON O.C_ID = S.ID
INNER JOIN CUST C ON C.ID = O.C_STID
WHERE
   (( CYEAR = 2010 ) AND ( NUM BETWEEN 6 AND 27 ))
OR
   (( CYEAR = 2011 ) AND ( NUM BETWEEN 1 AND 5 ))
GROUP BY C.FNAME, C.LNAME
ORDER BY TOT
DESC



     select a.fname, a.lname, count(*) as tot
 from cycle C
inner join ord O on o.c_id = c.id
inner join cust a on a.id = o.c_stid
WHERE
  ((cyear = 2010) and (num between 1 and 27))
OR
  ((cYear = 2011) and (num between 1 and 29))
group by a.fname, a.lname
order by tot desc



      select a.fname, a.lname, c.id, c.num, c.cyear, o.onum, o.c_id, o.c_stid from cycle C
inner join ord O on o.c_id = c.id
inner join cust a on a.id = o.c_stid
WHERE
  ((cyear = 2010) and (num between 1 and 27))
OR
  ((cYear = 2011) and (num between 1 and 29))

order by cyear desc, num desc



WORKS:

  select id, num, cyear from cycle
WHERE
  ((cyear = 2005) and (num between 10 and 27))
OR
   ( cyear between 2006 and 2010)
OR
  ((cYear = 2011) and (num between 1 and 6))
order by cyear desc, num desc


select c.id, c.num, c.cyear, o.c_id, o.c_stid from cycle C, ord O
WHERE
  ((c.cyear = 2010) and (c.num between 1 and 27))
OR
  ((c.cYear = 2011) and (c.num between 1 and 6))
order by c_stid
desc





select c.id, c.num, c.cyear, o.c_id, o.c_stid from cycle C, ord O
WHERE
  ((cyear = 2010) and (num between 1 and 27))
OR
  ((cYear = 2011) and (num between 1 and 6))
order by c.id
desc








}

