 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Transaction_TransObjectUnit;

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
   tTransactionTranObject = class( tObject )
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

constructor tTransactionTranObject.Create;
begin
   inherited create();
   //
end;

destructor tTransactionTranObject.destroy;
begin
  inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tTransactionTranObject.Load(inOrderID: string): tErrorResult;
begin
   fOrderID := inOrderID;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
