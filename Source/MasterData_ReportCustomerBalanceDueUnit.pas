 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_ReportCustomerBalanceDueUnit;

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
  AvoBase_PercentFormUnit,
  inifileunit,
  masterdataunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  Order_InvoiceObjectUnit,
  Return_InvoiceObjectUnit,
  toolbox_escrowtoolboxunit,
  encryptunit,
  ErrorResultUnit;


// This is the customer ORDER DETAILS list
type
   tMasterDataCustomerBalanaceDue = class(tQuery)
   private
      fSQL : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
      constructor Create(inMasterData : tMasterData); virtual;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataCustomerBalanaceDue.Create(inMasterData : tMasterData);
var
   errResult : tErrorResult;
   fQuery : tQuery;
   fCustQuery : tQuery;
   fOrdQuery : tQuery;
   fMOPQuery : tQuery;
   fREVQuery : tQuery;
   orderInvoice : tInvoice;
   returnInvoice : tReturnInvoice;
   sqlText : string;
   custID : string;
   fOrderAmountDue : currency;
   fReturnAmountRefund : currency;
   fMOPAmount : currency;
   fREVAmount : currency;
   fAmountDue : currency;
begin
	// create and assign
   inherited create( owner );
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;


   // Report Table
   masterData.RemoveTable( table_report );

   // First, build the table if it doesn't exist
   if (NOT masterData.TableExists(masterData.GetTable_Report)) then
   begin
      errResult := masterData.AddTable(masterData.dbPath + table_report,
         'ID VARCHAR(40), ' + // simple ID
         'CNAME VARCHAR(30), ' + // CUSTname
         'ADDR1 VARCHAR(100), ' + // address 1
         'CITY VARCHAR(50), ' + // city
         'STATE VARCHAR(50), ' + // state
         'ZIP VARCHAR(30), ' + // zip
         'PHONEH VARCHAR(30), ' + // phone H
         'PHONEC VARCHAR(30), ' + // phone C
         'PHONEW VARCHAR(30), ' + // phone W
         'EMAIL VARCHAR(60), ' + // email address
         'AMTREV MONEY, ' + // reversals
         'AMTORD MONEY, ' + // Order
         'AMTMOP MONEY, ' + // MOP
         'AMTRET MONEY, ' + // Returns
         'AMTDUE MONEY', // amount due
         {----------------}
         'ID');
         if (errResult.errorResult) then
         begin
            Error_Log( errResult, true);
            Exit;
         end;
      end;

   // Invoices
   orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL );
   returnInvoice := tReturnInvoice.Create( InvoiceTypeReport, NIL, NIL );

   // Queries
   fCustQuery := masterData.GetQuery();
   fOrdQuery := masterData.GetQuery();
   fMOPQuery := masterData.GetQuery();
   fREVQuery := masterData.GetQuery();
   fQuery := masterData.GetQuery();

   //
   fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report;
   fQuery.Open();

   // Our main loop
   fCustQuery.Close();
   fCustQuery.SQL.Text := 'SELECT ID, FNAME, LNAME, ADDR1, CITY, STATE, ZIP, PHONEH, PHONEC, PHONEW, EMAIL ' +
      'FROM ' + masterData.Gettable_Customer;
   fCustQuery.Open();
   PercentForm_Create('Gathering Report Data - One Moment Please...', 0, fCustQuery.RecordCount);
   repeat
      PercentForm_Update();
      custID := fCustQuery.FieldByName('ID').AsString;
      fOrderAmountDue := 0;
      fReturnAmountRefund := 0;
      fMOPAmount := 0;
      fREVAmount := 0;

      // ORDER AND RETURN AMOUNTS
      // --------------------------------------------------------------
      fOrdQuery.Close();
      fOrdQuery.SQL.Text := 'SELECT ID, O_TYPE, C_STID FROM ' + masterData.GetTable_Order +
         ' WHERE C_STID = ' + masterData.WrapDBID( custID );
      fOrdQuery.Open();
      if ( fOrdQuery.RecordCount <> 0 ) then
      begin
         repeat
            //
            case fOrdQuery.FieldByName('O_TYPE').AsInteger of
               integer(tOrderTypes.OrdTypeOrder):
               begin
                  orderInvoice.Load( fOrdQuery.FieldByName('ID').AsString);
                  fOrderAmountDue := fOrderAmountDue + orderInvoice.Amount_Total;
               end;
               integer(tOrderTypes.OrdTypeReturn):
               begin
                  returnInvoice.Load( fOrdQuery.FieldByName('ID').AsString);
                  fReturnAmountRefund := fReturnAmountRefund + returnInvoice.Amount_TotalRefund;
               end;
            end;
            //
            fOrdQuery.Next();
         until fOrdQuery.EOF;
      end;
      fOrdQuery.Close();

      // PAYMENTS - METHOD OF PAYMENTS
      // --------------------------------------------------------------
      fMOPQuery.Close();
      fMOPQuery.SQL.Text := 'SELECT SUM(AMOUNT) AS TOT FROM ' + MasterData.GetTable_Mop +
         ' WHERE C_ID = ' + masterData.WrapDBID( custID );
      fMOPQuery.Open();
      if ( fMOPQuery.RecordCount <> 0 ) then
         fMOPAmount := fMOPAmount + fMOPQuery.FieldByName('TOT').AsCurrency;
      fMOPQuery.Close();

      // REVERSALS - REVERSALS
      // --------------------------------------------------------------
      fREVQuery.Close();
      fREVQuery.SQL.Text := 'SELECT SUM(AMOUNT) AS TOT FROM ' + MasterData.GetTable_Reversal +
         ' WHERE C_ID = ' + masterData.WrapDBID( custID );
      fREVQuery.Open();
      if ( fREVQuery.RecordCount <> 0 ) then
         fREVAmount := fREVAmount + fREVQuery.FieldByName('TOT').AsCurrency;
      fREVQuery.Close();

      // TOTALS NOW...
      fAmountDue := fOrderAmountDue;
      // Subtract paid or returns
      fAmountDue := fAmountDue - ( fReturnAmountRefund );
      fAmountDue := fAmountDue - ( fMOPAmount );
      // Add back in any reversals
      fAmountDue := fAmountDue + ( fRevAmount );

      // Ok?
      if ( fAmountDue > 0 ) then
      begin
         fQuery.Append();
         fQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
         fQuery.FieldByName('CNAME').AsString := fCustQuery.FieldByName('FNAME').AsString +
            ' ' + fCustQuery.FieldByName('LNAME').AsString;
         fQuery.FieldByName('ADDR1').AsString := fCustQuery.FieldByName('ADDR1').AsString;
         fQuery.FieldByName('CITY').AsString := fCustQuery.FieldByName('CITY').AsString;
         fQuery.FieldByName('STATE').AsString := fCustQuery.FieldByName('STATE').AsString;
         fQuery.FieldByName('ZIP').AsString := fCustQuery.FieldByName('ZIP').AsString;
         fQuery.FieldByName('PHONEH').AsString := fCustQuery.FieldByName('PHONEH').AsString;
         fQuery.FieldByName('PHONEC').AsString := fCustQuery.FieldByName('PHONEC').AsString;
         fQuery.FieldByName('PHONEW').AsString := fCustQuery.FieldByName('PHONEW').AsString;
         fQuery.FieldByName('EMAIL').AsString := fCustQuery.FieldByName('EMAIL').AsString;
         fQuery.FieldByName('AMTDUE').AsCurrency := fAmountDue;
         fQuery.FieldByName('AMTREV').AsCurrency := fRevAmount;
         fQuery.FieldByName('AMTORD').AsCurrency := fOrderAmountDue;
         fQuery.FieldByName('AMTRET').AsCurrency := fReturnAmountRefund;
         fQuery.FieldByName('AMTMOP').AsCurrency := fMOPAmount;
         //
         fQuery.Post();
      end;

      // DONE
      fCustQuery.Next();
   until fCustQuery.EOF;

   // DONE
   fCustQuery.Close();
   fOrdQuery.Close();
   fMOPQuery.Close();
   fREVQuery.Close();
   fQuery.Close();

   // Free
   FreeAndNil( fCustQuery );
   FreeAndNil( fOrdQuery );
   FreeAndNil( fMOPQuery );
   FreeAndNil (fREVQuery );

   // Reset our query
   Self.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Report +
      ' ORDER BY CNAME';

   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
   PercentForm_Free();
end;

procedure tMasterDataCustomerBalanaceDue.HandleCalculated(DataSet: TDataSet);
begin
   // Nothing at this time.
end;



procedure tMasterDataCustomerBalanaceDue.Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
var
   errResult : tErrorResult;
   sql : string;
begin
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Customer;
   if (inActiveState in [stateActive]) then
      sql := sql + ' WHERE ISACTIVE = TRUE';
   if (inActiveState in [stateInactive]) then
   	sql := sql + ' WHERE ISACTIVE = FALSE';
   if (inOrderBy <> '') then
      sql := sql + ' ORDER BY ' + inOrderBy;
   if (inSortOpt <> '') then
   	sql := sql + ' ' + inSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

end.