 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Return_FEEItem_NoFormUnit;

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
   tReturn_FEEItem_Report = class( TInterfacedObject, iFEELineItem )
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
      fReturnFlag : boolean;
      fReturnAdd : Boolean;
      fReturnProdID : string;
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
      function fGetReturnFlag : boolean;
      function fGetReturnAdd : boolean;
      function fGetReturnProdID : string;
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
      procedure fSetReturnFlag( inValue : boolean );
      procedure fSetReturnAdd( inValue : boolean );
      procedure fSetReturnProdID( inValue : string );
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
      property TaxRate : double read fGetTaxRate write fSetTaxRate;
      property ReturnFlag : boolean read fGetReturnFlag write fSetReturnFlag;
      property ReturnAdd : boolean read fGetReturnAdd write fSetReturnAdd;
      property ReturnFeeID : string read fGetReturnProdID write fSetReturnProdID;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;
   end;

implementation

// ============================================================================== //

function tReturn_FEEItem_Report.fGetAmount: currency;
begin
   result := fAmount;
end;

procedure tReturn_FEEItem_Report.fSetAmount(inValue: currency);
begin
   fAmount := inValue;
end;

// ============================================================================== //

function tReturn_FEEItem_Report.fGetCycleID: string;
begin
   result := fCycleID;
end;

procedure tReturn_FEEItem_Report.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

// ============================================================================== //


function tReturn_FEEItem_Report.fGetFeeName: string;
begin
   result := fFeeName;
end;

procedure tReturn_FEEItem_Report.fSetFeeName(inValue: string);
begin
   fFeeName := inValue;
end;

// ============================================================================== //

procedure tReturn_FEEItem_Report.fSetDesc(inValue: string);
begin
   fDesc := inValue;
end;

function tReturn_FEEItem_Report.fGetDesc: string;
begin
   result := fDesc;
end;


// ============================================================================== //

function tReturn_FEEItem_Report.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

procedure tReturn_FEEItem_Report.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
end;

// ============================================================================== //

function tReturn_FEEItem_Report.fGetOrderID: string;
begin
   result := fOrderId;
end;

procedure tReturn_FEEItem_Report.fSetOrderID(inValue: string);
begin
   fOrderId := inValue;
end;

// ============================================================================== //

function tReturn_FEEItem_Report.fGetOrgID: string;
begin
   result := fOrgID;
end;

procedure tReturn_FEEItem_Report.fSetOrgID(inValue: string);
begin
   fOrgID := inValue;
end;

// ============================================================================== //

function tReturn_FEEItem_Report.fGetReturnFlag: boolean;
begin
   result := fReturnFlag;
end;

procedure tReturn_FEEItem_Report.fSetReturnFlag(inValue: boolean);
begin
   fReturnFlag := inValue;
end;

// ============================================================================== //

function tReturn_FEEItem_Report.fGetReturnProdID: string;
begin
   result := fReturnProdID;
end;

procedure tReturn_FEEItem_Report.fSetReturnProdID(inValue: string);
begin
   fReturnProdID := inValue;
end;

// ============================================================================== //


// ============================================================================== //


function tReturn_FEEItem_Report.fGetReturnAdd: boolean;
begin
   result := fReturnAdd;
end;

procedure tReturn_FEEItem_Report.fSetReturnAdd(inValue: boolean);
begin
   fReturnAdd := inValue;
end;

// ============================================================================== //

function tReturn_FEEItem_Report.fGetTaxRate: double;
begin
	result := fTaxRate;
end;


procedure tReturn_FEEItem_Report.fSetTaxRate(inValue: double);
begin
	fTaxRate := inValue;
end;


// ============================================================================== //

// ============================================================================== //

procedure tReturn_FEEItem_Report.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
end;

function tReturn_FEEItem_Report.fGetmTaxID: string;
begin
   result := fmTaxID;
end;

// ============================================================================== //

// ============================================================================== //

procedure tReturn_FEEItem_Report.TabBackward;
begin
   // We do nothing, there is NO form here.
end;

procedure tReturn_FEEItem_Report.TabForward;
begin
   // We do nothing, there is NO form here.
end;

end.
