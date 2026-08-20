 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Invoice_MOPItem_NoFormUnit;

interface uses
	Invoice_MOPItem_InterfaceUnit,
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
   tMOPItem_Report = class( TInterfacedObject, iMOPLineItem )
   private
      // variables
      fCycleID : string; // the sales cycle
      fLineNumber : integer; // the line number of the MOP
      fAmount : currency;
      fID : string;
      fOrgID : string;
      fCID : string;
      fMopDate : tDateTime;
      fMopType : integer;
      fMopValue : string;
      fMopCCExpM : integer;
      fMopCCExpY : integer;
      fMopNoc : string;
      fMopCVV : string;
      fMOPCCT : integer;
      fOrderID : string;
      fVoid : boolean;

   	// Get
      function fGetLineNumber : integer;
      function fGetCycleID : string;
      function fGetAmount : currency;
      function fGetID : string;
      function fGetOrgId : string;
      function fGetCID : string;
      function fGetMopDate : tDateTime;
      function fGetMopType : integer;
      function fGetMopValue : string;
      function fGetMopCCExpM : integer;
      function fGetMopCCExpy : integer;
      function fGetMopNoc : string;
      function fGetMopCVV : string;
      function fGetOrderID : string;
      function fGetMOPCCT : integer;

      // Set
      procedure fSetLineNumber( inValue : integer );
      procedure fSetCycleID( inValue : string );
      procedure fSetAmount( inValue : currency );
      procedure fSetId( inValue : string );
      procedure fSetOrgID( inValue : string );
      procedure fSetCID( inValue : string );
      procedure fSetMopDate( inValue : tDateTime );
      procedure fSetMopType( inValue : integer );
      procedure fSetMopValue( inValue : string );
      procedure fSetMopCCExpM( inValue : integer );
      procedure fSetMopCCExpY( inValue : integer );
      procedure fSetMopNoc( inValue : string );
      procedure fSetMopCVV( inValue : string );
      procedure fSetOrderID( inValue : string );
      procedure fSetMOPCCT( inValue : integer );

   public
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;

      // properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
      property ID : string read fGetID write fSetId;
      property OrgID : string read fGetOrgId write fSetOrgID;
      property CycleID : string read fGetCycleID write fSetCycleID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property C_ID : string read fGetCID write fSetCID;
      property MopDate : tDateTime read fGetMopDate write fSetMopDate;
      property MopType : integer read fGetMopType write fSetMopType;
      property MopValue : string read fGetMopValue write fSetMopValue;
      property MopCCExpM : integer read fGetMopCCExpM write fSetMopCCExpM;
      property MopCCExpY : integer read fGetMopCCExpy write fSetMopCCExpY;
      property MopNoc : string read fGetMopNoc write fSetMopNoc;
      property MopCVV : string read fGetMopCVV write fSetMopCVV;
      property Amount : currency read fGetAmount write fSetAmount;
      property MOPCCT : integer read fGetMOPCCT write fSetMOPCCT;
      property Void : boolean read fVoid write fVoid;
end;

implementation

// ============================================================================== //

function tMOPItem_Report.fGetAmount: currency;
begin
   result := fAmount;
end;

procedure tMOPItem_Report.fSetAmount(inValue: currency);
begin
   fAmount := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetCID: string;
begin
   result := fCID;
end;

procedure tMOPItem_Report.fSetCID(inValue: string);
begin
   fCID := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetCycleID: string;
begin
   result := fCycleID;
end;

procedure tMOPItem_Report.fSetCycleID(inValue: string);
begin
   fCycleID := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetID: string;
begin
   result := fID;
end;

procedure tMOPItem_Report.fSetId(inValue: string);
begin
   fID := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetLineNumber: integer;
begin
   result := fLineNumber;
end;

procedure tMOPItem_Report.fSetLineNumber(inValue: integer);
begin
   fLineNumber := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetMopCCExpM: integer;
begin
   result := fMOPCCExpM;
end;

procedure tMOPItem_Report.fSetMopCCExpM(inValue: integer);
begin
   fMOPCCExpM := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetMopCCExpy: integer;
begin
   result := fMopCCExpy;
end;


procedure tMOPItem_Report.fSetMopCCExpY(inValue: integer);
begin
   fMopCCExpy := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetMOPCCT: integer;
begin
   result := fMOPCCT;
end;

procedure tMOPItem_Report.fSetMOPCCT(inValue: integer);
begin
   fMOPCCT := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetMopCVV: string;
begin
   result := fMopCVV;
end;

procedure tMOPItem_Report.fSetMopCVV(inValue: string);
begin
   fMopCVV := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetMopDate: tDateTime;
begin
   result := fMopDate;
end;

procedure tMOPItem_Report.fSetMopDate(inValue: tDateTime);
begin
   fMopDate := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetMopNoc: string;
begin
   result := fMopNoc;
end;

procedure tMOPItem_Report.fSetMopNoc(inValue: string);
begin
   fMopNoc := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetMopType: integer;
begin
   result := fMopType;
end;

procedure tMOPItem_Report.fSetMopType(inValue: integer);
begin
   fMopType := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetMopValue: string;
begin
   result := fMopValue;
end;

procedure tMOPItem_Report.fSetMopValue(inValue: string);
begin
   fMopValue := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetOrderID: string;
begin
   result := fOrderID;
end;

procedure tMOPItem_Report.fSetOrderID(inValue: string);
begin
   fOrderID := inValue;
end;

// ============================================================================== //

function tMOPItem_Report.fGetOrgId: string;
begin
   result := fOrgId;
end;

procedure tMOPItem_Report.fSetOrgID(inValue: string);
begin
   fOrgId := inValue;
end;

// ============================================================================== //
// ============================================================================== //
// ============================================================================== //
// ============================================================================== //
// ============================================================================== //
// ============================================================================== //

procedure tMOPItem_Report.TabBackward;
begin
   // We do nothing, there is NO form here.
end;

procedure tMOPItem_Report.TabForward;
begin
   // We do nothing, there is NO form here.
end;

end.
