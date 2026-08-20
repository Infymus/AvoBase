 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

{ This pulls in ALL of the transaction payments by Order ID }

unit Transaction_PaymentsObjectUnit;

interface uses
	constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   avobase_dialogformunit,
   avobase_percentformunit,
  recordstructureunit,
   masterdata_BaseDataClassUnit,
   //
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
   tTransactionPaymentObject = class( tObject )
   private
      fOrderID : string;
      //
      LineItems : tObjectList;

      //

      // ----------------------------------------------------------------------------- //
      // functions
      function fGetCount : integer;

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
      property Count : integer read fGetCount;

   	// ----------------------------------------------------------------------------- //
      // Standard constructors
      constructor Create;
      destructor destroy; override;
   end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tTransactionPaymentObject.Create;
begin
   inherited create();
   //
   LineItems := tObjectList.Create(True);
end;

destructor tTransactionPaymentObject.destroy;
begin
  inherited;
end;

function tTransactionPaymentObject.fGetCount: integer;
begin
   result := LineItems.Count - 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tTransactionPaymentObject.Load(inOrderID: string): tErrorResult;
begin
   fOrderID := inOrderID;
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
