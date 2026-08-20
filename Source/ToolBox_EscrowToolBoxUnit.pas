 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit ToolBox_EscrowToolBoxUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  RecordStructureUnit,
  encryptunit,
  ErrorResultUnit;

function Escrow_GetCustomerEscrowByCustomerID( inCustID : string ) : currency;
function Escrow_AddEscrowByCustomerID( inCustID : string; inAmount : currency ) : tErrorResult;
function Escrow_RemoveEscrowByCustomerID( inCustID : string; inAmount : currency ) : tErrorResult;
function Escrow_AdjustEscrowByCustomerID( inCustID : string; inAmount : currency ) : tErrorResult;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{
         retVal := masterData.AddTable(masterData.dbPath + table_escrow,
            'C_ID VARCHAR(40), ' + // customer ID
            'MOPDATE DATE, ' + // date of MOP
            'AMOUNT MONEY',
}

// Get the total amount of escrow available to the customer
function Escrow_GetCustomerEscrowByCustomerID( inCustID : string ) : currency;
var
   fQuery : tQuery;
begin
   result := 0.00;
   //
   fQuery := masterData.GetQuery();
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT * FROM ' + MasterData.gettable_escrow +
      ' WHERE C_ID = ' + masterData.WrapDBID( inCustID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0) then
      result := fQuery.FieldByname('AMOUNT').AsCurrency;
   //
   fQuery.Close();
   //
   FreeAndNil(fQuery);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

// This will add to the escrow account by customer id.
function Escrow_AddEscrowByCustomerID( inCustID : string; inAmount : currency ) : tErrorResult;
var
   fQuery : tQuery;
   totEscrow : currency;
begin
   result := Error_Init;
   //
   fQuery := masterData.GetQuery();
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT * FROM ' + MasterData.gettable_escrow +
      ' WHERE C_ID = ' + masterData.WrapDBID( inCustID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0) then
   begin
      // found the record, pull it, add to it, save it
      totEscrow := fQuery.FieldByname('AMOUNT').AsCurrency;
      totEscrow := totEscrow + inAmount;
      //
      fQuery.Edit();
      fQuery.FieldByName('AMOUNT').AsCurrency := totEscrow;
      fQuery.FieldByName('MOPDATE').AsDateTime := Now;
      fQuery.Post();
   end else
      begin
         // new record required, create it, add to it, save it
         fQuery.Append();
         fQuery.FieldByName('C_ID').AsString := inCustID;
         fQuery.FieldByName('AMOUNT').AsCurrency := inAmount;
         fQuery.FieldByName('MOPDATE').AsDateTime := Now;
         fQuery.Post();
      end;
   //
   fQuery.Close();
   //
   FreeAndNil(fQuery);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

function Escrow_RemoveEscrowByCustomerID( inCustID : string; inAmount : currency ) : tErrorResult;
var
   fQuery : tQuery;
   totEscrow : currency;
begin
   result := Error_Init;
   //
   fQuery := masterData.GetQuery();
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT * FROM ' + MasterData.gettable_escrow +
      ' WHERE C_ID = ' + masterData.WrapDBID( inCustID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0) then
   begin
      // found the record, pull it, add to it, save it
      totEscrow := fQuery.FieldByname('AMOUNT').AsCurrency;
      totEscrow := totEscrow - inAmount;

      //
      fQuery.Edit();
      fQuery.FieldByName('AMOUNT').AsCurrency := totEscrow;
      fQuery.FieldByName('MOPDATE').AsDateTime := Now;
      fQuery.Post();
   end else
      begin
         // we do nothing in this case. don't want to create a deficient escrow record.
      end;
   //
   fQuery.Close();
   //
   FreeAndNil(fQuery);
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

function Escrow_AdjustEscrowByCustomerID( inCustID : string; inAmount : currency ) : tErrorResult;
var
   fQuery : tQuery;
begin
   result := Error_Init;
   //
   fQuery := masterData.GetQuery();
   fQuery.Close();
   fQuery.SQL.Text := 'SELECT * FROM ' + MasterData.gettable_escrow +
      ' WHERE C_ID = ' + masterData.WrapDBID( inCustID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0) then
   begin
      fQuery.Edit();
      fQuery.FieldByName('AMOUNT').AsCurrency := inAmount;
      fQuery.FieldByName('MOPDATE').AsDateTime := Now;
      fQuery.Post();
   end else
      begin
         // new record required, create it, add to it, save it
         fQuery.Append();
         fQuery.FieldByName('C_ID').AsString := inCustID;
         fQuery.FieldByName('AMOUNT').AsCurrency := inAmount;
         fQuery.FieldByName('MOPDATE').AsDateTime := Now;
         fQuery.Post();
      end;
   //
   fQuery.Close();
   //
   FreeAndNil(fQuery);
end;

end.
