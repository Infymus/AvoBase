 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_FEEItem_InterfaceUnit;


interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   classes;

type
	iFEELineItem = interface['{B9CDD7EF-8E57-42EE-AD25-A93101FFD5E8}']
		// ----------------------------------------------------------------------------- //
		// Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmount( inValue : currency );
      procedure fSetOrgID( inValue : string );
      procedure fSetOrderID( inValue : string );
      procedure fSetFeeName( inValue : string );
      procedure fSetDesc( inValue : string );
      procedure fSetTaxRate( inValue : double );
      procedure fSetmTaxID( inValue : string );

		// ----------------------------------------------------------------------------- //
      // Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmount : currency;
      function fGetOrgID : string;
      function fGetOrderID : string;
      function fGetFeeName : string;
      function fGetDesc : string;
      function fGetTaxRate : double;
      function fGetmTaxID : string;

      // Events

		// ----------------------------------------------------------------------------- //
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;

		// ----------------------------------------------------------------------------- //
      // Properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property Amount : currency read fGetAmount write fSetAmount;
      property OrgID : string read fGetOrgID write fSetOrgID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property FeeName : string read fGetFeeName write fSetFeeName;
      property Desc : string read fGetDesc write fSetDesc;
      property TaxRate : double read fGetTaxRate write fSetTaxRate;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;
	end;

   implementation

end.

