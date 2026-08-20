 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_LineItem_NoFormUnit;

interface uses
	Return_LineItem_InterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   classes;

type
   tReturn_LineItem_Report = class( TInterfacedObject, iReturnLineItem )
   private
		// ----------------------------------------------------------------------------- //
      // variables
      fCycleID : string;
      fLineNumber : integer;
      fCostRetail : currency;
      fCostSellAt : currency;
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
      fReturnProdID : string;
      fQTYPriorReturned : integer;
      fProDN1 : string;
      fProDN2 : string;
      fProDN3 : string;
      fProDN4 : string;
      fmTaxID : string; // master tax ID

		// ----------------------------------------------------------------------------- //
		// Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmountRetail( inValue : currency );
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
      procedure fSetReturnProdID( inValue : string );
      procedure fSetQTYPriorReturned( inValue : integer );
      procedure fSetReturnPRODN1( inValue : string );
      procedure fSetReturnPRODN2( inValue : string );
      procedure fSetReturnPRODN3( inValue : string );
      procedure fSetReturnPRODN4( inValue : string );
      procedure fSetmTaxID( inValue : string );

		// ----------------------------------------------------------------------------- //
      // Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmountRetail : currency;
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
      function fGetReturnProdID : string;
      function fGetQTYPriorReturned : integer;
      function fGetReturnPRODN1 : string;
      function fGetReturnPRODN2 : string;
      function fGetReturnPRODN3 : string;
      function fGetReturnPRODN4 : string;
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
      property ReturnProdID : string read fGetReturnProdID write fSetReturnProdID;
      property QTYPriorReturned : integer read fGetQTYPriorReturned write fSetQTYPriorReturned;
      property ProductPRODN1 : string read fGetReturnPRODN1 write fSetReturnPRODN1;
      property ProductPRODN2 : string read fGetReturnPRODN2 write fSetReturnPRODN2;
      property ProductPRODN3 : string read fGetReturnPRODN3 write fSetReturnPRODN3;
      property ProductPRODN4 : string read fGetReturnPRODN4 write fSetReturnPRODN4;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;
   end;

implementation

// ======================================================================================= //

function tReturn_LineItem_Report.fGetAmountRetail: currency;
begin
   result := fCostRetail;
end;

procedure tReturn_LineItem_Report.fSetAmountRetail(inValue: currency);
begin
   fCostRetail := inValue;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetAmountSellAt: currency;
begin
   result := fCostSellAt;
end;

procedure tReturn_LineItem_Report.fSetAmountSellAt(inValue: currency);
begin
   fCostSellAt := inValue;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetBackOrderedType: integer;
begin
   result := fBackOrderedType;
end;

procedure tReturn_LineItem_Report.fSetBackOrderedType(inValue: integer);
begin
   fBackOrderedType := inValue;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetCycleID: string;
begin
   result := fCycleID;
end;

procedure tReturn_LineItem_Report.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetID: string;
begin
   result := fID;
end;

procedure tReturn_LineItem_Report.fSetID(inValue: string);
begin
   fID := inValue;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetLineItemCharge: boolean;
begin
   result := fLineItemCharge;
end;

procedure tReturn_LineItem_Report.fSetLineItemCharge(inValue: boolean);
begin
   fLineItemCharge := inValue;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetOrgID: string;
begin
   result := fOrgID;
end;

procedure tReturn_LineItem_Report.fSetOrgID(inValue: string);
begin
   fOrgID := inValue;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetProductName: string;
begin
   result := fProductName;
end;

procedure tReturn_LineItem_Report.fSetProductName(inValue: string);
begin
   fProductName := inValue;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetQTYFree: integer;
begin
   result := fQTYFree;
end;



procedure tReturn_LineItem_Report.fSetQTYFree(inValue: integer);
begin
   fQTYFree := inValue;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetQTYOnHand(inValue: integer);
begin
   //
end;



function tReturn_LineItem_Report.fGetQTYOnHand: integer;
begin
  //
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetQTYPriorReturned(inValue: integer);
begin
   fQTYPriorReturned := invalue;
end;

function tReturn_LineItem_Report.fGetQTYPriorReturned: integer;
begin
   result := fQTYPriorReturned;
end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetTaxRate: currency;
begin
   result := fTaxRate;
end;

procedure tReturn_LineItem_Report.fSetTaxRate(inValue: currency);
begin
   fTaxRate := inValue;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
end;


function tReturn_LineItem_Report.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
end;

function tReturn_LineItem_Report.fGetmTaxID: string;
begin
   result := fmTaxID;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetOrderID(inValue: string);
begin
   fOrderID := inValue;
end;

function tReturn_LineItem_Report.fGetOrderID: string;
begin
   result := fOrderID;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetProductDesc(inValue: string);
begin
   fProductDesc := inValue;
end;

function tReturn_LineItem_Report.fGetProductDesc: string;
begin
   result := fProductDesc;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetProductNum(inValue: string);
begin
   fProductNum := inValue;
end;

function tReturn_LineItem_Report.fGetProductNum: string;
begin
   result := fProductNum;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetProductSold(inValue: boolean);
begin

end;

function tReturn_LineItem_Report.fGetProductSold: boolean;
begin

end;

// ======================================================================================= //

function tReturn_LineItem_Report.fGetQTYReturned: integer;
begin
   result := fQTYReturned;
end;

procedure tReturn_LineItem_Report.fSetQTYReturned(inValue: integer);
begin
   fQTYReturned := inValue;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fsetQTYSold(inValue: integer);
begin
   fQTYSold := inValue;
end;

function tReturn_LineItem_Report.fGetQTYSold: integer;
begin
   result := fQTYSold;
end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.fSetReturnProdID(inValue: string);
begin
   fReturnProdID := invalue;
end;

procedure tReturn_LineItem_Report.fSetReturnPRODN1(inValue: string);
begin
   fprodn1 := invalue;
end;

procedure tReturn_LineItem_Report.fSetReturnPRODN2(inValue: string);
begin
   fprodn2 := invalue;
end;

procedure tReturn_LineItem_Report.fSetReturnPRODN3(inValue: string);
begin
   fprodn3 := invalue;
end;

procedure tReturn_LineItem_Report.fSetReturnPRODN4(inValue: string);
begin
   fprodn4 := invalue;
end;

function tReturn_LineItem_Report.fGetReturnProdID: string;
begin
   result := fReturnProdID;
end;

function tReturn_LineItem_Report.fGetReturnPRODN1: string;
begin
   result := fprodn1;
end;

function tReturn_LineItem_Report.fGetReturnPRODN2: string;
begin
   result := fprodn2;

end;

function tReturn_LineItem_Report.fGetReturnPRODN3: string;
begin
   result := fprodn3;

end;

function tReturn_LineItem_Report.fGetReturnPRODN4: string;
begin
   result := fprodn4;

end;

// ======================================================================================= //

procedure tReturn_LineItem_Report.TabBackward;
begin
   // We do nothing, there is NO form here, no events in reports.
end;

procedure tReturn_LineItem_Report.TabForward;
begin
   // We do nothing, there is NO form here, no events in reports.
end;

end.