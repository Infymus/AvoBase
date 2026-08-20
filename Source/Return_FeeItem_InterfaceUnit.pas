 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_FeeItem_InterfaceUnit;

interface uses
	constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   classes;

type
	iReturnFeeItem = interface['{CBF2D652-A1E6-4065-9100-4D658DD0B332}']
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
      procedure fSetReturnFlag( inValue : boolean );
      procedure fSetReturnAdd( inValue : boolean );
      procedure fSetReturnProdID( inValue : string );
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
      function fGetReturnFlag : boolean;
      function fGetReturnAdd : boolean;
      function fGetReturnProdID : string;
      function fGetmTaxID : string;

		// ----------------------------------------------------------------------------- //
		// Standard Procedures

		// ----------------------------------------------------------------------------- //
      // Properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property Amount : currency read fGetAmount write fSetAmount;
      property OrgID : string read fGetOrgID write fSetOrgID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property FeeName : string read fGetFeeName write fSetFeeName;
      property Desc : string read fGetDesc write fSetDesc;
      property TaxRate : double read fGetTaxRate write fSetTaxRate;
      property ReturnFlag : boolean read fGetReturnFlag write fSetReturnFlag;
      property ReturnAdd : boolean read fGetReturnAdd write fSetReturnAdd;
      property ReturnProdID : string read fGetReturnProdID write fSetReturnProdID;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;
	end;

implementation

end.





