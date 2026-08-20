 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_LineItem_NoFormUnit;

interface uses
	Invoice_LineItem_InterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
	//
   classes;

{  The purpose of this class is to create a LineItem for reports only. This has NO form so there is
   no form overhead. It still however MUST incorporate everything that the Interface iInvoiceLineItem
   contains for full compatibility. }

type
   tLineItem_Report = class( TInterfacedObject, iInvoiceLineItem )
   private
		// ----------------------------------------------------------------------------- //
      // variables
      fCycleID : string;
      fLineNumber : integer;
      fCostRetail : currency;
      fCostSellAt : currency;
      fCostYCost : currency;
      fID : string;
      fOrderID : string;
      fOrgID : string;
      fBackOrderedType : integer;
      fLineItemCharge : boolean;
      fTaxRate : currency;
      fQTYSold : integer;
      fQTYReturned : integer;
      fQTYFree : integer;
      fProductNum : string;
      fProductName : string;
      fProductDesc : string;
      fprodn1 : string;
      fprodn2 : string;
      fprodn3 : string;
      fprodn4 : string;
      fmTaxID : string; // master tax ID

		// ----------------------------------------------------------------------------- //
		// Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmountRetail( inValue : currency );
      procedure fSetAmountYcost( inValue : currency );
      procedure fSetAmountSellAt( inValue : currency );
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
      // Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmountRetail : currency;
      function fGetAmountYcost : currency;
      function fGetAmountSellAt : currency;
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

   public
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;

		// ----------------------------------------------------------------------------- //
      // Properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property CycleID : string read fGetCycleID write fSetCycleID;
      property Amount_Retail : currency read fGetAmountRetail write fSetAmountRetail;
      property Amount_SellAt : currency read fGetAmountSellAt write fSetAmountSellAt;
      property Amount_Ycost : currency read fGetAmountYcost write fSetAmountYcost;
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

// ======================================================================================= //

function tLineItem_Report.fGetAmountRetail: currency;
begin
   result := fCostRetail;
end;

procedure tLineItem_Report.fSetAmountRetail(inValue: currency);
begin
   fCostRetail := inValue;
end;

// ======================================================================================= //

function tLineItem_Report.fGetAmountSellAt: currency;
begin
   result := fCostSellAt;
end;

procedure tLineItem_Report.fSetAmountSellAt(inValue: currency);
begin
   fCostSellAt := inValue;
end;

// ======================================================================================= //

procedure tLineItem_Report.fSetAmountYcost(inValue: currency);
begin
   fCostYCost := inValue;
end;

function tLineItem_Report.fGetAmountYcost: currency;
begin
   result := fCostYCost;
end;

// ======================================================================================= //

function tLineItem_Report.fGetBackOrderedType: integer;
begin
   result := fBackOrderedType;
end;

procedure tLineItem_Report.fSetBackOrderedType(inValue: integer);
begin
   fBackOrderedType := inValue;
end;

// ======================================================================================= //

function tLineItem_Report.fGetCycleID: string;
begin
   result := fCycleID;
end;

procedure tLineItem_Report.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

// ======================================================================================= //

function tLineItem_Report.fGetID: string;
begin
   result := fID;
end;

procedure tLineItem_Report.fSetID(inValue: string);
begin
   fID := inValue;
end;

// ======================================================================================= //

function tLineItem_Report.fGetLineItemCharge: boolean;
begin
   result := fLineItemCharge;
end;

procedure tLineItem_Report.fSetLineItemCharge(inValue: boolean);
begin
   fLineItemCharge := inValue;
end;

// ======================================================================================= //

function tLineItem_Report.fGetOrgID: string;
begin
   result := fOrgID;
end;

procedure tLineItem_Report.fSetOrgID(inValue: string);
begin
   fOrgID := inValue;
end;

// ======================================================================================= //

function tLineItem_Report.fGetProductName: string;
begin
   result := fProductName;
end;

procedure tLineItem_Report.fSetProductName(inValue: string);
begin
   fProductName := inValue;
end;

// ======================================================================================= //


function tLineItem_Report.fGetQTYFree: integer;
begin
   result := fQTYFree;
end;



procedure tLineItem_Report.fSetQTYFree(inValue: integer);
begin
   fQTYFree := inValue;
end;

// ======================================================================================= //

procedure tLineItem_Report.fSetQTYOnHand(inValue: integer);
begin
   //
end;

function tLineItem_Report.fGetQTYOnHand: integer;
begin
  //
end;

// ======================================================================================= //

function tLineItem_Report.fGetTaxRate: currency;
begin
   result := fTaxRate;
end;

procedure tLineItem_Report.fSetTaxRate(inValue: currency);
begin
   fTaxRate := inValue;
end;

// ======================================================================================= //

procedure tLineItem_Report.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
end;

function tLineItem_Report.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

// ======================================================================================= //

procedure tLineItem_Report.fSetOrderID(inValue: string);
begin
   fOrderID := inValue;
end;

function tLineItem_Report.fGetOrderID: string;
begin
   result := fOrderID;
end;

// ======================================================================================= //

procedure tLineItem_Report.fSetProductDesc(inValue: string);
begin
   fProductDesc := inValue;
end;

function tLineItem_Report.fGetProductDesc: string;
begin
   result := fProductDesc;
end;

// ======================================================================================= //

procedure tLineItem_Report.fSetProductNum(inValue: string);
begin
   fProductNum := inValue;
end;

function tLineItem_Report.fGetProductNum: string;
begin
   result := fProductNum;
end;

// ======================================================================================= //

procedure tLineItem_Report.fSetProductPRODN1(inValue: string);
begin
   fprodn1 := invalue;
end;

function tLineItem_Report.fGetProductPRODN1: string;
begin
   result := fprodn1;

end;


// ======================================================================================= //

procedure tLineItem_Report.fSetProductPRODN2(inValue: string);
begin
   fprodn2 := invalue;

end;

function tLineItem_Report.fGetProductPRODN2: string;
begin
   result := fprodn2;

end;

// ======================================================================================= //

procedure tLineItem_Report.fSetProductPRODN3(inValue: string);
begin
   fprodn3 := invalue;

end;

function tLineItem_Report.fGetProductPRODN3: string;
begin
   result := fprodn3;

end;

// ======================================================================================= //

procedure tLineItem_Report.fSetProductPRODN4(inValue: string);
begin
   fprodn4 := invalue;

end;

function tLineItem_Report.fGetProductPRODN4: string;
begin
   result := fprodn4;
end;

// ======================================================================================= //


procedure tLineItem_Report.fSetProductSold(inValue: boolean);
begin

end;


function tLineItem_Report.fGetProductSold: boolean;
begin

end;

// ======================================================================================= //

function tLineItem_Report.fGetQTYReturned: integer;
begin
   result := fQTYReturned;
end;

procedure tLineItem_Report.fSetQTYReturned(inValue: integer);
begin
   fQTYReturned := inValue;
end;

// ======================================================================================= //

procedure tLineItem_Report.fsetQTYSold(inValue: integer);
begin
   fQTYSold := inValue;
end;

function tLineItem_Report.fGetQTYSold: integer;
begin
   result := fQTYSold;
end;

// ======================================================================================= //

procedure tLineItem_Report.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
end;

function tLineItem_Report.fGetmTaxID: string;
begin
   result := fmTaxID;
end;

// ======================================================================================= //

// ======================================================================================= //


// ======================================================================================= //


// ======================================================================================= //

procedure tLineItem_Report.TabBackward;
begin
   // We do nothing, there is NO form here, no events in reports.
end;

procedure tLineItem_Report.TabForward;
begin
   // We do nothing, there is NO form here, no events in reports.
end;

end.