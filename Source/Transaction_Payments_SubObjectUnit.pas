 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Transaction_Payments_SubObjectUnit;

interface uses
	constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
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
   tTransactionPaymentObject = class( tObject )
   private
   public
      // ----------------------------------------------------------------------------- //
      // functions

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

{ tTransactionPaymentObject }

constructor tTransactionPaymentObject.Create;
begin
   inherited create;
   //
end;

destructor tTransactionPaymentObject.destroy;
begin

  inherited;
end;

end.
