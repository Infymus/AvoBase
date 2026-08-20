 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Invoice_LineItem_InterfaceUnit;

interface uses
	constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   classes;

type
	iInvoiceLineItem = interface['{78624C00-C877-4AFA-A073-FE3F399A517D}']
		// ----------------------------------------------------------------------------- //
      // Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmountRetail : currency;
      function fGetAmountSellAt : currency;
      function fGetAmountYCost : currency;
      function fGetID : string;
      function fGetOrderID : string;
      function fGetOrgID : string;
      function fGetBackOrderedType : integer;
      function fGetLineItemCharge : boolean;
      function fGetTaxRate : currency;
      function fGetQTYSold : integer;
      function fGetQTYReturned : integer;
      function fGetQTYFree : integer;
      function fGetProductNum : string;
      function fGetProductName : string;
      function fGetProductDesc : string;
      function fGetQTYOnHand : integer;
      function fGetProductSold : boolean;
      function fGetProductPRODN1 : string;
      function fGetProductPRODN2 : string;
      function fGetProductPRODN3 : string;
      function fGetProductPRODN4 : string;
      function fGetmTaxID : string;

		// ----------------------------------------------------------------------------- //
		// Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmountRetail( inValue : currency );
      procedure fSetAmountSellAt( inValue : currency );
      procedure fSetAmountYCost( invalue : currency );
      procedure fSetID( inValue : string );
      procedure fSetOrderID( inValue : string );
      procedure fSetOrgID( inValue : string );
      procedure fSetBackOrderedType( inValue : integer );
      procedure fSetLineItemCharge( inValue : boolean);
      procedure fSetTaxRate( inValue : currency );
      procedure fsetQTYSold( inValue : integer );
      procedure fSetQTYReturned( inValue : integer );
      procedure fSetQTYFree( inValue : integer );
      procedure fSetProductNum( inValue : string );
      procedure fSetProductName( inValue : string );
      procedure fSetProductDesc( inValue : string );
      procedure fSetQTYOnHand( inValue : integer );
      procedure fSetProductSold( inValue : boolean );
      procedure fSetProductPRODN1( inValue : string );
      procedure fSetProductPRODN2( inValue : string );
      procedure fSetProductPRODN3( inValue : string );
      procedure fSetProductPRODN4( inValue : string );
      procedure fSetmTaxID( inValue : string );

		// ----------------------------------------------------------------------------- //
		// Standard Procedures

		// ----------------------------------------------------------------------------- //
      // Properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property CycleID : string read fGetCycleID write fSetCycleID;
      property Amount_Retail : currency read fGetAmountRetail write fSetAmountRetail;
      property Amount_SellAt : currency read fGetAmountSellAt write fSetAmountSellAt;
      property Amount_YCost : currency read fGetAmountYCost write fSetAmountYCost;
      property ID : string read fGetID write fSetID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property OrgID : string read fGetOrgID write fSetOrgID;
      property BackOrderType : integer read fGetBackOrderedType write fSetBackOrderedType;
      property LineItemFree : boolean read fGetLineItemCharge write fSetLineItemCharge;
      property TaxRate : currency read fGetTaxRate write fSetTaxRate;
      property QTYSold : integer read fGetQTYSold write fSetQTYSold;
      property QTYReturned : integer read fGetQTYReturned write fSetQTYReturned;
      property QTYFree : integer read fGetQTYFree write fSetQTYFree;
      property QTYOnHand : integer read fGetQTYOnHand write fSetQTYOnHand;
      property ProductNum : string read fGetProductNum write fSetProductNum;
      property ProductName : string read fGetProductName write fSetProductName;
      property ProductDesc : string read fGetProductDesc write fSetProductDesc;
      property ProductSold : boolean read fGetProductSold write fSetProductSold;
      property ProductPRODN1 : string read fGetProductPRODN1 write fSetProductPRODN1;
      property ProductPRODN2 : string read fGetProductPRODN2 write fSetProductPRODN2;
      property ProductPRODN3 : string read fGetProductPRODN3 write fSetProductPRODN3;
      property ProductPRODN4 : string read fGetProductPRODN4 write fSetProductPRODN4;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;
	end;

   implementation

end.



