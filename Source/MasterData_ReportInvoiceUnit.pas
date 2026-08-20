 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportInvoiceUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  recordstructureunit,
  bde,
  dateutils,
  inifileunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_ProductToolBoxUnit,
  masterdataunit,
  AvoBase_PercentFormUnit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataReportInvoice = class(tQuery)
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      constructor Create( inMasterData : tMasterData; inStartYear, inEndYear, InStartNum, InEndNum : integer );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportInvoice.Create( inMasterData : tMasterData; inStartYear, inEndYear, InStartNum, InEndNum : integer );
var
   errResult : tErrorResult;
   sql : string;
   sqlWhere : string;
   cnt : integer;
   count : integer;
begin

{
// This here thing will find all orders within a set of cycles with set order types even.
SELECT O.ID, O.C_ID, O.O_TYPE, C.NUM, C.CYEAR FROM ORD O
INNER JOIN CYCLE C ON O.C_ID = C.ID
WHERE
   (( CYEAR = 2010 ) AND ( NUM BETWEEN 1 AND 27 ))
OR
   (( CYEAR = 2011 ) AND ( NUM BETWEEN 1 AND 27 ))
AND (O.O_TYPE = 1 OR O.O_TYPE = 2)
ORDER BY CYEAR DESC, NUM DESC
}



   inherited create( nil );
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;

   //
   PercentForm_Create('Gathering Report Data - One Moment Please ...', 0, 0);

   // build the sql for the data we are going to need
	sql := 'SELECT O.ID, O.C_ID, O.O_TYPE, O.ONUM, O.STATUS, C.NUM, C.CYEAR ' +
      'FROM ' + masterData.GetTable_Order + ' O ' +
      'INNER JOIN ' + masterData.GetTable_Cycle + ' C ON O.C_ID = C.ID';
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
   //   sql := sql + ' ORDER BY CYEAR DESC, NUM DESC';
   sql := sql + ' ORDER BY O.ONUM';
   //
   self.SQL.Clear();
   self.SQL.Text := sql;

   errResult := fMasterData.QueryAddFields( self );
   //
   PercentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportInvoice.destroy;
begin
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataReportInvoice.HandleCalculated(DataSet: TDataSet);
begin
	// We have none yere.
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.

