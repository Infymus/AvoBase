 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
{ This pulls in ALL of the transaction payments by Order ID }

unit Transaction_ReversalsObjectUnit;

interface uses
	constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
  recordstructureunit,
   avobase_dialogformunit,
   avobase_percentformunit,
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
   tTransactionReversalObject = class( tObject )
   private
      fOrderID : string;
      //
      LineItems : tObjectList;
      //

      // ----------------------------------------------------------------------------- //
      // functions

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

   	// ----------------------------------------------------------------------------- //
      // Standard constructors
      constructor Create;
      destructor destroy; override;
   end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tTransactionReversalObject.Create;
begin
   inherited create();
   //
end;

destructor tTransactionReversalObject.destroy;
begin
  inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tTransactionReversalObject.Load(inOrderID: string): tErrorResult;
begin
   fOrderID := inOrderID;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
