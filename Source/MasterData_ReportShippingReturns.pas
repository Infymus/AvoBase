 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ReportShippingReturns;

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
   toolbox_ProductToolBoxUnit,
   Return_InvoiceObjectUnit,
   masterdataunit,
   AvoBase_PercentFormUnit,
   encryptunit,
   ErrorResultUnit;

type
   tMasterDataReportShippingReturns = class(tQuery)
   PRIVATE
      fShowOpen : boolean;
      fShowClosed : boolean;
      fShowCancel : boolean;
   public
      fMasterData : tMasterData;
      constructor Create(
         inMasterData : tMasterData;
         inOrgID : string;
         inStartYear, inEndYear, InStartNum, InEndNum : integer;
         inOptOpen, inOptClosed, inOptCancel : boolean );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReportShippingReturns.Create( inMasterData : tMasterData; inOrgID : string;
   inStartYear, inEndYear, InStartNum, InEndNum : integer;
   inOptOpen, inOptClosed, inOptCancel : boolean );
var
   errResult : tErrorResult;
   sqlText : string;
   sqlWhere : string;
   cnt : integer;
   fWriteQuery : tQuery;
   count : integer;
   sqlOpt : string;
   ordType : string;
begin
   inherited create( nil );
   self.RequestLive := true;
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   //
   fShowOpen := inOptOpen;
   fShowClosed := inOptClosed;
   fShowCancel := inOptCancel;
   //
   sqlText := 'SELECT O.ID, O.STATUS, O.O_TYPE, O.ORG_ID, O.C_ID, C.ID, C.NUM, C.CYEAR, C.ORG_ID ' +
      ' FROM ' + masterData.GetTable_Order + ' O' +
      ' INNER JOIN ' + masterData.GetTable_Cycle + ' C' +
      ' ON C.ID = O.C_ID';
   //
   sqlOpt := 'O.STATUS = ' + IntToStr(Integer(tOrderStatusTypes.OrderStatusClosed));
   ordType := IntToStr(Integer(tOrderTypes.OrdTypeReturn));
   //   inOptOpen, inOptClosed, inOptCancel
   //
   if ( inStartYear < inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30)' +
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (O_TYPE=' + ordType + ')) ';
      //
      for cnt := inStartYear + 1 to inEndYear - 1 do
         sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( cnt ) + ' ) AND (NUM BETWEEN 1 AND 30)' +
            ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (O_TYPE=' + ordType + '))';
      //
      sqlWhere := sqlWhere + ' OR ((CYEAR = ' + IntToStr( inEndYear ) + ') AND (NUM BETWEEN 1 AND ' + IntToStr( inEndNum ) + ' )' +
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (O_TYPE=' + ordType + '))';
   end;
   //
   if ( inStartYear = inEndYear ) then
   begin
      sqlWhere := ' WHERE ';
      //
      sqlWhere := sqlWhere +  '((CYEAR = ' + IntToStr( inStartYear ) + ') AND (NUM BETWEEN ' + IntToStr( inStartNum ) + ' AND 30)' +
         ' AND (' + sqlOpt + ') AND (O.ORG_ID = ' + masterData.WrapDBID(InOrgID) + ') AND (O_TYPE=' + ordType + '))';
   end;
   //
   sqlText := sqlText + sqlWhere;
   sqlText := sqlText + ' ORDER BY O.C_ID DESC';
   self.SQL.Clear();
   self.SQL.Text := sqlText;
   errResult := fMasterData.QueryAddFields( self );
   //
   PercentForm_Free();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataReportShippingReturns.destroy;
begin
   inherited;
end;


end.
