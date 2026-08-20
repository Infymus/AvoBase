 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Tax_InterfaceUnit;

INTERFACE USES
  constantsunit,
  toolboxunit,
  errorresultunit,
  recordstructureunit,
  masterdataunit,
  //
  classes;

// The basic Interface for all Tax Categories



type
	iInvoiceLineItem = interface['{1F3DD534-D7BD-4F14-80F8-1F6639C6F851}']
      function Tax ( inTaxRecord : tTaxRecord2 ) : tTaxRecord2;
	end;

   implementation

end.