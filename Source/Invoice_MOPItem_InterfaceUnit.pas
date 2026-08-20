 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
unit Invoice_MOPItem_InterfaceUnit;


interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   classes;

// The basic Interface for all Invoice Method Of Payment Line Items.


type
	iMOPLineItem = interface['{7280506D-537B-4901-AF00-1575E7278ADE}']
		// ----------------------------------------------------------------------------- //
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

		// ----------------------------------------------------------------------------- //
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

      // Events

		// ----------------------------------------------------------------------------- //
		// Standard Procedures
      procedure TabForward;
      procedure TabBackward;

		// ----------------------------------------------------------------------------- //
      // Properties
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
      property MOPCCT : integer read fGetMOPCCT write fSetMOPCCT;
      property Amount : currency read fGetAmount write fSetAmount;

		// ----------------------------------------------------------------------------- //

      { NOTE : THIS IS COMMENTED OUT BECAUSE IT CANNOT BE HANDLED IN AN INTERFACE, HOWEVER,
               THIS AREA **MUST** BE COPIED INTO ANY IMPLEMENTED OBJECT. }
      // Events
      {
      eLineDelete : tEvent_MOPItem_LineDelete;
      eLineUpdate : tEvent_MOPItem_LineUpdate;

      property OnLineDelete : tEvent_MOPItem_LineDelete read eLineDelete write eLineDelete;
      property OnLineUpdate : tEvent_MOPItem_LineUpdate read eLineUpdate write eLineUpdate;
      }
	end;

   implementation

end.

{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'CID VARCHAR(40), ' + // customer ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY YEAR, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'AMOUNT MONEY',

}
