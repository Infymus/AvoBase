 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_FEEItem_NoFormUnit;

interface uses
	Invoice_FEEItem_InterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
	//
   classes;

{  The purpose of this class is to create a LineItem for reports only. This has NO form so there is
   no form overhead. It still however MUST incorporate everything that the Interface contains for
   full compatibility. }

type
   tFEEItem_Report = class( TInterfacedObject, iFEELineItem )
   private
      // variables
      fCycleID : string;
      fLineNumber : integer;
      fAmount : currency;
      fOrgID : string;
      fOrderID : string;
      fFeeName : string;
      fDesc : string;
      fTaxRate : double;
      fWaveTax : boolean;
      fmTaxID : string; // master tax ID

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

   public
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;

      // properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property Amount : currency read fGetAmount write fSetAmount;
      property OrgID : string read fGetOrgID write fSetOrgID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property FeeName : string read fGetFeeName write fSetFeeName;
      property Desc : string read fGetDesc write fSetDesc;
//      property Taxable : boolean read fGetTaxable write fSetTaxable;
      property TaxRate : double read fGetTaxRate write fSetTaxRate;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;

   end;

implementation

// ============================================================================== //

function tFEEItem_Report.fGetAmount: currency;
begin
   result := fAmount;
end;

procedure tFEEItem_Report.fSetAmount(inValue: currency);
begin
   fAmount := inValue;
end;

// ============================================================================== //

function tFEEItem_Report.fGetCycleID: string;
begin
   result := fCycleID;
end;

procedure tFEEItem_Report.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

// ============================================================================== //


function tFEEItem_Report.fGetFeeName: string;
begin
   result := fFeeName;
end;

procedure tFEEItem_Report.fSetFeeName(inValue: string);
begin
   fFeeName := inValue;
end;

// ============================================================================== //

procedure tFEEItem_Report.fSetDesc(inValue: string);
begin
   fDesc := inValue;
end;

function tFEEItem_Report.fGetDesc: string;
begin
   result := fDesc;
end;


// ============================================================================== //

function tFEEItem_Report.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

procedure tFEEItem_Report.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
end;

// ============================================================================== //

function tFEEItem_Report.fGetOrderID: string;
begin
   result := fOrderId;
end;

procedure tFEEItem_Report.fSetOrderID(inValue: string);
begin
   fOrderId := inValue;
end;

// ============================================================================== //

function tFEEItem_Report.fGetOrgID: string;
begin
   result := fOrgID;
end;

procedure tFEEItem_Report.fSetOrgID(inValue: string);
begin
   fOrgID := inValue;
end;


// ============================================================================== //

function tFEEItem_Report.fGetTaxRate: double;
begin
	result := fTaxRate;
end;


procedure tFEEItem_Report.fSetTaxRate(inValue: double);
begin
	fTaxRate := inValue;
end;



// ============================================================================== //

procedure tFEEItem_Report.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
end;

function tFEEItem_Report.fGetmTaxID: string;
begin
   result := fmTaxID;
end;

// ============================================================================== //

// ============================================================================== //

// ============================================================================== //

procedure tFEEItem_Report.TabBackward;
begin
   // We do nothing, there is NO form here.
end;

procedure tFEEItem_Report.TabForward;
begin
   // We do nothing, there is NO form here.
end;

end.
