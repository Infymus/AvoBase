 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_UpdateUnit;

interface uses
   sysutils,
   classes,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   AvoBase_StartupFormUnit,
   Toolbox_PreferenceToolBoxUnit,
   RecordStructureUnit,
   //
   db,
   dbtables,
   inifiles,
   bde,
   dateutils;

const
   // This affects the percentage bar as you go
   FILE_STRUCT_COUNT = 6;
   // Increment this version # forward for each database change you make
   // do not use decimal points! 100, 101, 102, 103 ---> just go up by ONE

   // THIS VERSION MATCHES THE DATABASE "MAIN.DB" FILE:
   // NOTE: THIS VERSION MUST BE GREATER >> THAN THE LAST UPDATE IN THIS FILE
   // IF DB_VERSION = 105 AND LAST VERSION IS 105, you will RUNTIME ERROR
   // DB_VERSION SHOULD = 105 and LAST = 104 (one less)
   NEXT_DB_VERSION = 114;

type
   tMasterDataUpdate = class(tObject)
   public
      function UpdateTables(): tErrorResult;
   end;

IMPLEMENTATION

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

function TMasterDataUpdate.UpdateTables(): tErrorResult;
var
  retVal : tErrorResult;
  tempQuery : tQuery;

{$REGION 'Internal Methods'}

procedure DeleteFiles(sMask, sPath: string);
var
  SearchRec: TSearchRec;
  Found: Integer;
begin
  sPath := IncludeTrailingPathDelimiter(sPath);
  Found := SysUtils.FindFirst(sPath + sMask, faAnyFile, SearchRec);
  try
    while (Found = 0) do
    begin
      if not (SearchRec.Attr and faDirectory > 0) then
        SysUtils.DeleteFile(sPath + SearchRec.Name);
      Found := SysUtils.FindNext(SearchRec);
    end;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

{$ENDREGION}

begin
   result := Error_Init;
   if (masterData.dbPath = 'ERROR') then
   begin
      result.errorResult := true;
      result.errorMessage := 'Could not find specified DBPATH in the AVOBASE.INI file.';
      Error_Log(result, True);
      Exit;
   end;

{$REGION 'Table Creation And Initial Data'}

   // create the initial table_main
   if (NOT masterData.TableExists(table_main)) then
   begin
      retVal := masterData.AddTable(masterData.dbPath + table_main,
         'DBID INTEGER',
         {----------------}
         '');
      if (retVal.errorResult) then
      begin
         result.errorResult := true;
         result.errorMessage := retVal.errorMessage;
         Exit;
      end;
   end;

   // TABLE_PREFERENCE - ALWAYS CREATED
   if (NOT masterData.TableExists(table_preference)) then
   begin
      retVal := masterData.AddTable(masterData.dbPath + table_preference,
         'ID VARCHAR(40), ' +
         'PNAME VARCHAR(255), ' +
         'ASSTR VARCHAR(255), ' +
         'ASBOOL BOOLEAN, ' +
         'ASGUID VARCHAR(50), ' +
         'ASMEMO BLOB(240,1), ' +
         'ASINT INTEGER, ' +
         'ASCURR MONEY',
         {----------------}
         'ID');
      if (retVal.errorResult) then
      begin
         result.errorResult := true;
         result.errorMessage := retVal.errorMessage;
         Exit;
      end;
      // Now set defaults
      Pref_Set(tPrefConstants.dbGridColorGridLines, False);
      Pref_Set(tPrefConstants.RegionCode, integer(tRegions.RegionUS) );
   end;
   StartPercentForm_Update();

   StartPercentForm_UpdateHeader('Database Initialization');

   // do they have a shitload of temp files left over?
   try
      DeleteFiles( '_Q*.DB', masterData.dbPath  );
      DeleteFiles( '_Q*.MB', masterData.dbPath  );
   finally
   end;


(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

   { UPDATE 100 }
   if (masterData.CompareVersion(100)) then
   begin
   	StartPercentForm_IncreaseTotal(23);
      // create the initial table_main



      // create the customer table
      if (NOT masterData.TableExists(table_customer)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_customer,
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'FNAME VARCHAR(30), ' +
            'MNAME VARCHAR(30), ' +
            'LNAME VARCHAR(30), ' +
            'ADDR1 VARCHAR(100), ' +
            'ADDR2 VARCHAR(100), ' +
            'CITY VARCHAR(50), ' +
            'STATE VARCHAR(50), ' +
            'ZIP VARCHAR(30), ' +
            'PHONEH VARCHAR(30), ' +
            'PHONEC VARCHAR(30), ' +
            'PHONEW VARCHAR(30), ' +
            'BDAY DATE, ' +
            'EMAIL VARCHAR(60), ' +
            'TAXEXID VARCHAR(40), ' + // tax exempt ID
            'TAXE BOOLEAN',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
      end;
      StartPercentForm_Update();

      // create the organization table
      if (NOT masterData.TableExists(table_org)) then
      begin
        retVal := masterData.AddTable(masterData.dbPath + table_org,
          'ID VARCHAR(40), ' +
          'NAME VARCHAR(50), ' +
          'ISACTIVE BOOLEAN, ' +
          'INAME VARCHAR(50), ' +
          'DESCR VARCHAR(200), ' +
          'ACC VARCHAR(50), ' +
          'IHEADD VARCHAR(50), ' + // invoice header display
          'CYCLES INTEGER, ' + // # of cycles per year
          'IMSG VARCHAR(200), ' + // specific invoice message
          'ICNCLMSG BLOB(240,1)', // cancellation message
          {----------------}
          'ID');
        if (retVal.errorResult) then
        begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
        end;
      end;
      StartPercentForm_Update();
      // masterData.AddIndex( masterData.dbPath + table_org, 'SIDX', 'ID', [ixCaseInsensitive]);

      // table_tax_master
      if (NOT masterData.TableExists(table_tax_master)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_tax_master,
            'ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200)',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
      end;
      StartPercentForm_Update();
      // masterData.AddIndex( masterData.dbPath + table_tax_master, 'SIDX', 'ID', [ixCaseInsensitive]);

      // Taxes | table_tax
      if (NOT masterData.TableExists(table_tax)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_tax,
            'ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'TTYPE INTEGER, ' + // see tTaxTypes for details
            'RATE FLOAT',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_tax, 'SIDX', 'TAXID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_shipping
      if (NOT masterData.TableExists(table_shipping)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_shipping,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'PCNT FLOAT, ' + // PERCENT if STYPE = 2
            'RATE MONEY, ' + // RATE if STYPE = 1
            'STYPE INTEGER',  // TYPE - 1 = $RATE$ - 2 = %PCNT%
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_shipping, 'SIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // create the fees table
      if (NOT masterData.TableExists(table_fee)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_fee,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'AUTOINV BOOLEAN, ' + // auto-add to invoice
            'AUTORET BOOLEAN, ' + // auto-add to returns
            'AMOUNT MONEY',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_fee, 'SIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // create the cycles table (used to be campaigns)
      if (NOT masterData.TableExists(table_cycle)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_cycle,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NUM INTEGER, ' + // Cycle Number
            'CYEAR INTEGER, ' + // Cycle Year
            'CNAME VARCHAR(7), ' + // Cycle Name for Sorting
            'IMSG BLOB(240, 1), ' + // specific invoice message for cycle
            'SDATE DATE, ' + // start date
            'EDATE DATE ',  // end date
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_cycle, 'SIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // create the product table
      if (NOT masterData.TableExists(table_product)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_product,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'ISACTIVE BOOLEAN, ' +
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PRODN1 VARCHAR(40), ' + // product table field name 1
            'PRODN2 VARCHAR(40), ' + // product table field name 2
            'PRODN3 VARCHAR(40), ' + // product table field name 3
            'PRODN4 VARCHAR(40), ' + // product table field name 4
            'AMOUNT MONEY',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_product, 'SIDX', 'C_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_product, 'TIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      //table_brochure = 'book.db';
      if (NOT masterData.TableExists(table_brochure)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_brochure,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'TBO INTEGER, ' + // total books ordered
            'AMOUNT MONEY, ' + // Total Cost of all books
            'DESCR VARCHAR(40)',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
      end;
      StartPercentForm_Update();

      // table_customer_brochure = 'custbook.db';
      if (NOT masterData.TableExists(table_customer_brochure)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_customer_brochure,
            'ID VARCHAR(40), ' +
            'BOOK_ID VARCHAR(40), ' + // book list ID
            'ORG_ID VARCHAR(40), ' + // org tied to
            'CUST_ID VARCHAR(40), ' + // customer on this book
            'SE BOOLEAN, ' + // send email?
            'SB BOOLEAN, ' + // send book?
            'ES BOOLEAN, ' + // email sent?
            'BS BOOLEAN', // book sent?
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
      end;
      StartPercentForm_Update();

      // ***** EMAIL SYSTEM ****************************************************************************** //

      // table_email = 'email.db';
      if (NOT masterData.TableExists(table_email)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_email,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer_id
            'ORDER_ID VARCHAR(40), ' + // order_id
            'ETIME TIME, ' + // queued time
            'EDATE DATE, ' + // queued date
            'SDATE DATE, ' + // date sent
            'STIME TIME, ' + // time sent
            'ETYPE INTEGER, ' + // email type - see tEmailTypes
            'STATUS INTEGER, ' + // email status - see tEmailStatusTypes
            'RET INTEGER, ' + // retries
            'DESCR VARCHAR(40)',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
      end;
      StartPercentForm_Update();

      // ***** EARNINGS AND EXPENSES********************************************************************** //

      // table_earninglist = 'ernl.db';
      if (NOT masterData.TableExists(table_earninglist)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_earninglist,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'C_ID VARCHAR(40)', // cycle id
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_earninglist, 'SIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();


      // table_expenselist = 'expl.db';
      if (NOT masterData.TableExists(table_expenselist)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_expenselist,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'C_ID VARCHAR(40)', // cycle id
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_expenselist, 'SIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();


      // table_earning = 'ern.db';
      if (NOT masterData.TableExists(table_earning)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_earning,
            'ID VARCHAR(40), ' +
            'E_ID VARCHAR(40), ' + // earning ID
            'ORG_ID VARCHAR(40), ' + // org id
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // earning type ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_earning, 'SIDX', 'E_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_earning, 'TIDX', 'ET_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_earning, 'FIDX', 'C_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_expense = 'exp.db';
      if (NOT masterData.TableExists(table_expense)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_expense,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' + // org id
            'E_ID VARCHAR(40), ' + // expense ID
            'C_ID VARCHAR(40), ' + // cycle id
            'ET_ID VARCHAR(40), ' + // expense type ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY, ' + // amount
            'DESCR VARCHAR(40)', // description if any
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_expense, 'SIDX', 'E_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_expense, 'TIDX', 'ET_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_expense, 'FIDX', 'C_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_expense_type = 'expt.db';
      if (NOT masterData.TableExists(table_expense_type)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_expense_type,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40),' + // organization
            'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
            'DESCR VARCHAR(200)',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_expense_type, 'SIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_earning_type = 'ernt.db';
      if (NOT masterData.TableExists(table_earning_type)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_earning_type,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40),' + // organization
            'NAME VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'AUTOA BOOLEAN, ' + // automatically add when creating a new list
            'DESCR VARCHAR(200)',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_earning_type, 'SIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();


      // ***** TRANSACTIONS ************************************************************************* //

      // table_trans
      if (NOT masterData.TableExists(table_trans)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_trans,
            'ID VARCHAR(40), ' +
            'C_STID VARCHAR(40), ' + // customer_id
            'ORDER_ID VARCHAR(40), ' + // orderID
            'TDATE DATE, ' + // transaction date
            'TTIME TIME, ' + // ttime
            'C_ID VARCHAR(40), ' + // cycle_ID
            'ORG_ID VARCHAR(40), ' + // orgID
            'TTYPE INTEGER, ' + // trans type, see tTransTypes
            'TMOPTYPE INTEGER, ' + // method of payment type, see tMethodOfPaymentTypes
            'TMOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'AMOUNT MONEY',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_trans, 'SIDX', 'C_STID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_trans, 'TIDX', 'ORDER_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_reversal
      if (NOT masterData.TableExists(table_reversal)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_reversal,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer ID
            'ORG_ID VARCHAR(40), ' +
            'PAY_ID VARCHAR(40), ' + // original method of payment ID
            'RDATE DATE, ' + // reversal date
            'RTYPE INTEGER, ' + // reversal type - see tVoidTypes
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY INTEGER, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'MOPCCT INTEGER, ' + // credit card type ( see tCreditCardTypes );
            'AMOUNT MONEY',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_reversal, 'SIDX', 'ORDER_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_reversal, 'TIDX', 'C_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_escrow
      if (NOT masterData.TableExists(table_escrow)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_escrow,
            'C_ID VARCHAR(40), ' + // customer ID
            'MOPDATE DATE, ' + // date of MOP
            'AMOUNT MONEY',
            {----------------}
            'C_ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
      end;
      StartPercentForm_Update();

      // ***** ORDERS ************************************************************************* //

      // create the order table
      if (NOT masterData.TableExists(table_order)) then
      begin
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
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_order, 'SIDX', 'C_STID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_order, 'TIDX', 'C_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_order, 'FIDX', 'RET_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_mop
      if (NOT masterData.TableExists(table_mop)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_mop,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // CUSTOMER ID
            'ORG_ID VARCHAR(40), ' +
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY INTEGER, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'MOPCCT INTEGER, ' + // credit card type ( see tCreditCardTypes );
            'MOP_REV BOOLEAN, ' + // payment reversed?
            'AMOUNT MONEY',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_mop, 'SIDX', 'ORDER_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_mop, 'TIDX', 'C_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_mop, 'FIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_order_fee = 'ofee.db';
      if (NOT masterData.TableExists(table_order_fee)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_order_fee,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'R_ID VARCHAR(40), ' + // return prior order_product_ID
            'TAXID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'TAX FLOAT, ' + // tax rate
            'RET BOOLEAN, ' + // fee has been refunded? (returned)? if so, don't bring back on RETURN invoice
            'RETFLAG BOOLEAN, ' + // only for returns, flagged as required for return
            'RETADD BOOLEAN, ' + // applies only to returns, is a fee that can be added or subtracted
            'AMOUNT MONEY',
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_order_fee, 'SIDX', 'ORDER_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();


      // table_order_product = 'ordprod.db';
      if (NOT masterData.TableExists(table_order_product)) then
      begin
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
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_order_product, 'SIDX', 'ORDER_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_order_product, 'TIDX', 'C_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_order_product, 'FIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      // table_backordered = 'bo.db';
      if (NOT masterData.TableExists(table_backordered)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_backordered,
            'ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_STID VARCHAR(40), ' + // sold to id
            'OPT_ID VARCHAR(40),' + // order_product_table product_id
            'TAXID VARCHAR(40), ' +
            'ONUM INTEGER, ' + // integer
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PRODN1 VARCHAR(40), ' + // product table field name 1
            'PRODN2 VARCHAR(40), ' + // product table field name 2
            'PRODN3 VARCHAR(40), ' + // product table field name 3
            'PRODN4 VARCHAR(40), ' + // product table field name 4
            'STATUS INTEGER, ' + // status : see tBackOrderStatus
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_backordered, 'SIDX', 'ORDER_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_backordered, 'TIDX', 'C_STID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

      //
      if (NOT masterData.TableExists(table_returntable)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_returntable,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // campaign ID
            'ORG_ID VARCHAR(40), ' +
            'TAXID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'QTY INTEGER, ' + // total quantity returned
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PRODN1 VARCHAR(40), ' + // product table field name 1
            'PRODN2 VARCHAR(40), ' + // product table field name 2
            'PRODN3 VARCHAR(40), ' + // product table field name 3
            'PRODN4 VARCHAR(40), ' + // product table field name 4
            'STATUS INTEGER, ' + // status see - tProdReturnStatus
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_returntable, 'SIDX', 'C_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_returntable, 'TIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
      StartPercentForm_Update();

   end; // end of updates for tables
   StartPercentForm_Update();

{$ENDREGION}

   // %%%%%%%%%%%%%%% UPDATES FROM HERE ON ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

{$REGION 'Updates to Tables Here On Only'}

   // %%%%%%%%%%%%%%% UPDATES FROM HERE ON ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
   // %%%%%%%%%%%%%%% UPDATES FROM HERE ON ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
   // %%%%%%%%%%%%%%% UPDATES FROM HERE ON ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
   // %%%%%%%%%%%%%%% UPDATES FROM HERE ON ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
   // %%%%%%%%%%%%%%% UPDATES FROM HERE ON ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
   // %%%%%%%%%%%%%%% UPDATES FROM HERE ON ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
   // %%%%%%%%%%%%%%% UPDATES FROM HERE ON ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

   { UPDATE 101 }
   if (masterData.CompareVersion(101)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      // Add a Tax Writeoff to the
      masterData.AddField( masterData.GetTable_Expense_Type, 'TAXDED', 'BOOLEAN');
   end;
   StartPercentForm_Update();


   { UPDATE 102 }
   if (masterData.CompareVersion(102)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      // Add a Tax Writeoff to the
      masterData.AddField( masterData.GetTable_Org, 'PRODN1', 'VARCHAR(40)');
      masterData.AddField( masterData.GetTable_Org, 'PRODN2', 'VARCHAR(40)');
      masterData.AddField( masterData.GetTable_Org, 'PRODN3', 'VARCHAR(40)');
      masterData.AddField( masterData.GetTable_Org, 'PRODN4', 'VARCHAR(40)');
   end;
   StartPercentForm_Update();

   { UPDATE 103 }
   if (masterData.CompareVersion(103)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      // Add a Tax Writeoff to the
      masterData.AddField( masterData.GetTable_Expense, 'TAXDED', 'BOOLEAN');
   end;
   StartPercentForm_Update();

   { UPDATE 104 }
   if (masterData.CompareVersion(104)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      // Add a preference for
      masterData.AddField( masterData.GetTable_Preference, 'DBGRIDCOL', 'BOOLEAN');
   end;
   StartPercentForm_Update();

   { UPDATE 105 }
   if (masterData.CompareVersion(105)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      // Add a preference for sales organization "Sales Cycle" label
      masterData.AddField( masterData.Gettable_org, 'CNAME', 'VARCHAR(20)');
   end;
   StartPercentForm_Update();

   { UPDATE 106 }
   if (masterData.CompareVersion(106)) then
   begin
   	StartPercentForm_IncreaseTotal(1);

      // Add the Customer Notes Table
      if (NOT masterData.TableExists(table_custnotes)) then
      begin
        retVal := masterData.AddTable(masterData.dbPath + table_custnotes,
          'ID VARCHAR(40), ' +
          'C_ID VARCHAR(40), ' + // customer id
          'NDATE DATE, ' + // note date
          'NDESC VARCHAR(40), ' + // Topic or Description
          'CNOTE BLOB(240,1)', // note
          {----------------}
          'ID');
        if (retVal.errorResult) then
        begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
        end;
      end;
   end;
   StartPercentForm_Update();

   { UPDATE 107 }
   if (masterData.CompareVersion(107)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      masterData.AddField( masterData.GetTable_Preference, 'INVCPH', 'INTEGER');
   end;
   StartPercentForm_Update();

   { UPDATE 108 }
   if (masterData.CompareVersion(108)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      masterData.AddField( masterData.GetTable_Preference, 'INVLIST1', 'INTEGER');
      masterData.AddField( masterData.GetTable_Preference, 'INVLIST2', 'INTEGER');
      masterData.AddField( masterData.GetTable_Preference, 'INVLIST3', 'INTEGER');
      masterData.AddField( masterData.GetTable_Preference, 'INVLIST4', 'INTEGER');
      masterData.AddField( masterData.GetTable_Preference, 'INVLIST5', 'INTEGER');
   end;
   StartPercentForm_Update();

   { UPDATE 109 }
   if (masterData.CompareVersion(109)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      masterData.AddField( masterData.GetTable_Product, 'SELLAT', 'MONEY');
      masterData.AddField( masterData.GetTable_Preference, 'NEWORDCURCYCLE', 'BOOLEAN');
   end;

   { UPDATE 110 }
   if (masterData.CompareVersion(110)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      //             'SHOW_DISC BOOLEAN, ' + // show discounts on invoice?
      masterData.AddField( masterData.GetTable_Preference, 'INVSHOW_DISC', 'BOOLEAN');
   end;

   { UPDATE 111 }
   if (masterData.CompareVersion(111)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      // Add CCOST to all tables - "Customer Cost"
      masterData.AddField( masterData.GetTable_Order_Product, 'YCOST', 'MONEY');
      masterData.AddField( masterData.GetTable_Product, 'YCOST', 'MONEY');
      masterData.AddField( masterData.GetTable_BackOrdered, 'YCOST', 'MONEY');
      masterData.AddField( masterData.GetTable_Returns, 'YCOST', 'MONEY');
      // Now we have to add the query to all areas
      masterData.QueryExecute('UPDATE ' + masterData.GetTable_Order_Product + ' SET YCOST = RCOST');
      masterData.QueryExecute('UPDATE ' + masterData.GetTable_Product + ' SET YCOST = AMOUNT');
      masterData.QueryExecute('UPDATE ' + masterData.GetTable_BackOrdered + ' SET YCOST = RCOST');
      masterData.QueryExecute('UPDATE ' + masterData.GetTable_Returns + ' SET YCOST = RCOST');
   end;

   { UPDATE 112 }
   if (masterData.CompareVersion(112)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      masterData.AddField( masterData.GetTable_Preference, 'TAXPREF', 'INTEGER');
   end;

   { UPDATE 113 }
   if (masterData.CompareVersion(113)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      masterData.AddField( masterData.GetTable_Expense, 'EDESC', 'VARCHAR(80)');
      masterData.AddField( masterData.GetTable_Earning, 'EDESC', 'VARCHAR(80)');
   end;


// RCOST = Retail Cost
// SCOST = Sell At Cost
// YCOST = Your Cost

(* THIS WILL BE UPCOMMING  FOR THE ORDER PRODUCT CUSTOMER PRE-ORDER MAKER THINGY
   if (masterData.CompareVersion(108)) then
   begin
   	StartPercentForm_IncreaseTotal(1);
      // create the product table
      if (NOT masterData.TableExists(table_custproduct)) then
      begin
         retVal := masterData.AddTable(masterData.dbPath + table_custproduct,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // cycle_ID
            'CU_ID VARCHAR(40), ' + // Customer ID
            'ORG_ID VARCHAR(40), ' + // Organization
            'TAXID VARCHAR(40), ' + // Master Tax
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'NUM VARCHAR(20), ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PRODN1 VARCHAR(40), ' + // product table field name 1
            'PRODN2 VARCHAR(40), ' + // product table field name 2
            'PRODN3 VARCHAR(40), ' + // product table field name 3
            'PRODN4 VARCHAR(40), ' + // product table field name 4
            'AMOUNT MONEY', // amount of
            {----------------}
            'ID');
         if (retVal.errorResult) then
         begin
            result.errorResult := true;
            result.errorMessage := retVal.errorMessage;
            Exit;
         end;
         masterData.AddIndex( masterData.dbPath + table_product, 'SIDX', 'C_ID', [ixCaseInsensitive]);
         masterData.AddIndex( masterData.dbPath + table_product, 'TIDX', 'ORG_ID', [ixCaseInsensitive]);
      end;
   end;
   StartPercentForm_Update();
*)

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* VERSION : 2.? *)

{$ENDREGION}

(* $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ *)
(* NO MORE UPDATES BEYOND THIS LINE *)
(* $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ *)

   masterData.SetDataBaseVersion(NEXT_DB_VERSION);
end;

end.

  (*  Data type mappings for CREATE TABLE:
   *
  The following table lists SQL syntax for data types used with
  CREATE TABLE, and describes how those types are mapped to Paradox
  and dBASE types by the BDE:

  SQL Syntax	BDE Logical	Paradox	dBASE
  SMALLINT	fldINT16	Short	Number (6,10)
  INTEGER	fldINT32	Long Integer	Number (20,4)
  DECIMAL(x,y)	fldBCD	BCD	N/A
  NUMERIC(x,y)	fldFLOAT	Number	Number (x,y)
  FLOAT(x,y)	fldFLOAT	Number	Float (x,y)
  CHARACTER(n)	fldZSTRING	Alpha	Character
  VARCHAR(n)	fldZSTRING	Alpha	Character
  DATE	fldDATE	Date	Date
  BOOLEAN	fldBOOL	Logical	Logical
  BLOB(n,1)	fldstMEMO	Memo	Memo
  BLOB(n,2)	fldstBINARY	Binary	Binary
  BLOB(n,3)	fldstFMTMEMO	Formatted memo	N/A
  BLOB(n,4)	fldstOLEOBJ	OLE	OLE
  BLOB(n,5)	fldstGRAPHIC	Graphic	N/A
  TIME	fldTIME	Time	N/A
  TIMESTAMP	fldTIMESTAMP	Timestamp	N/A
  MONEY	fldFLOAT, fldstMONEY	Money	Number (20,4)
  AUTOINC	fldINT32, fldstAUTOINC	Autoincrement	N/A
  BYTES(n)	fldBYTES(n)	Bytes	N/A
  x = precision (default: specific to driver)
  y = scale (default: 0)
  n = length in bytes (default: 0)
  1-5 = BLOB subtype (default: 1)
  *
  *)
