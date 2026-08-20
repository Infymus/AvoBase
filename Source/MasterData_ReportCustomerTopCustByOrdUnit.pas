 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportCustomerTopCustByOrdUnit;

Interface Uses
   Bde,
   Classes,
   Constantsunit,
   Dateutils,
   Db,
   Dbtables,
   Encryptunit,
   Errorresultunit,
   Inifileunit,
   AvoBase_PercentFormUnit,
   Masterdataunit,
   Order_Invoiceobjectunit,
   Recordstructureunit,
   Sysutils,
   Toolbox_Ordertoolboxunit,
   Toolbox_Paymenttoolboxunit,
   Toolbox_Producttoolboxunit,
   Toolboxunit;


type
   tMasterDataReportTopCustByOrd = class(tQuery)
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

constructor tMasterDataReportTopCustByOrd.Create( inMasterData : tMasterData; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   errResult : tErrorResult;
   sql : string;
   sqlWhere : string;
   cnt : integer;
   fQuery : tQuery;
   fWriteQuery : tQuery;
   count : integer;
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
         'TOT INTEGER', // total orders
         'CUSTID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;

   // build the sql for the data we are going to need
	sql := 'SELECT C.FNAME, C.LNAME, COUNT(*) AS TOT ' +
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
   sql := sql + ' GROUP BY C.FNAME, C.LNAME ORDER BY TOT DESC';
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
   PercentForm_IncreaseTotal( fQuery.RecordCount );

   // Go through the whole thing and pull the data out the report can use
   count := 0;
   if ( fQuery.RecordCount <> 0 ) then
   repeat
      inc( count ); // only do top 20, else it is too much on the report
      PercentForm_Update();
      if ( count < 20 ) then
      begin
         fWriteQuery.Append();
         fWriteQuery.FieldByName('CUSTID').AsString := masterData.NewDBGuid();
         fWriteQuery.FieldByName('CUSTNAME').AsString := fQuery.FieldByName('FNAME').AsString + ' ' +
            fQuery.FieldByName('LNAME').AsString;
         fWriteQuery.FieldByName('TOT').AsInteger := fQuery.FieldByName('TOT').AsInteger;
         fWriteQuery.Post();
      end;
      fQuery.Next();
   until fQuery.EOF;
   fQuery.Close();
   fWriteQuery.Close();

   // All done, now just open the report.
   sql := 'SELECT * FROM ' + masterData.GetTable_Report +
      ' ORDER BY TOT DESC';
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

destructor tMasterDataReportTopCustByOrd.destroy;
begin
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportTopCustByOrd.HandleCalculated(DataSet: TDataSet);
begin
	// We have none yere.
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportTopCustByOrd.Update();
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
