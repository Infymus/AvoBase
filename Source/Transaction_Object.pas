 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

{ This object controls ALL transactions against an Order }

unit Transaction_Object;

interface uses
	constantsunit,
   toolboxunit,
   errorresultunit,
  recordstructureunit,
   masterdataunit,
   avobase_dialogformunit,
   avobase_percentformunit,
   masterdata_BaseDataClassUnit,
   //

   //
   Transaction_PaymentsObjectUnit,
   Transaction_ReversalsObjectUnit,
   Transaction_EscrowObjectUnit,
   Transaction_TransObjectUnit,
   //
   windows,
   messages,
   sysutils,
   bde,
   db,
   math,
   dialogs,
   dbtables,
   forms,
   contnrs,
   classes;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

type
   tTransactionObject = class( tObject )
   private
      fOrderID : string;
      //
      Payments : tTransactionPaymentObject;
      Reversals : tTransactionReversalObject;
      Escrows : tTransactionEscrowObject;
      Transactions : tTransactionTranObject;

      // ----------------------------------------------------------------------------- //
      // functions
      function fPayments_GetTotalPaymentCount : integer;

      // ----------------------------------------------------------------------------- //
      // procedures
   public
      // ----------------------------------------------------------------------------- //
      // functions
      function Load( inOrderID : string ) : tErrorResult;

      // ----------------------------------------------------------------------------- //
      // procedures


      // ----------------------------------------------------------------------------- //
      // properties
      property Payments_TotalPaymentCount : integer read fPayments_GetTotalPaymentCount;

   	// ----------------------------------------------------------------------------- //
      // Standard constructors
      constructor Create;
      destructor destroy; override;
   end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tTransactionObject.Create;
begin
   inherited create();
   //
   Payments := tTransactionPaymentObject.Create();
   Reversals := tTransactionReversalObject.Create();
   Escrows := tTransactionEscrowObject.Create();
   Transactions := tTransactionTranObject.Create();
end;

destructor tTransactionObject.destroy;
begin
   FreeAndNil( Payments );
   FreeAndNil( Payments );
   FreeAndNil( Escrows );
   FreeAndNil( Transactions );
   //
   inherited;
end;

function tTransactionObject.fPayments_GetTotalPaymentCount: integer;
begin
   result := Payments.Count;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tTransactionObject.Load(inOrderID: string): tErrorResult;
begin
   fOrderID := inOrderID;
   //
   Payments.Load( fOrderID );
   Reversals.Load( fOrderID );
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
