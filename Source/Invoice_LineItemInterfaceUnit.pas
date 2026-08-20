 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

 UNIT  Invoice_LineItemInterfaceUnit;

INTERFACE USES
  constantsunit,
  toolboxunit,
  errorresultunit,
  masterdataunit,
  //
  classes;

// The basic Interface for all Invoice Line Items.

type
   tInvoiceLineBackOrderTypes = (this, that, other);

type
   tEvent_DeleteLine = procedure( sender : tObject ) of Object;

type
	iInvoiceLineItem = interface['{78624C00-C877-4AFA-A073-FE3F399A517D}']
   	// events
(*
      // events
      //fOnDeleteLine : tEvent_DeleteLine;
   	// Get
      function fGetProductNum : string;
      function fGetQuantity : integer;
      function fGetTaxRate : double;
      function fGetWaveTax : boolean;
      function fGetCost : currency;
      function fGetRetailCost : currency;
      function fGetDescr : string;
      function fGetCycleNum : string;
      function fGetBackOrderedType : tInvoiceLineBackOrderTypes;
      function fGetSize : string;
      function fGetPage : string;
      function fGetReturned : boolean;
      function fGetSold : boolean;
      // Set
      procedure fSetProductNum( inValue : string );
      procedure fSetQuantity( inValue : integer );
      procedure fSetTaxRate( inValue : double );
      procedure fSetWaveTax( inValue : boolean );
      procedure fSetCost( inValue : currency );
      procedure fSetRetailCost( inValue : currency );
      procedure fSetDescr( inValue : string );
      procedure fSetCycleNum( inValue : string );
      procedure fSetBackOrderedType( inValue : tInvoiceLineBackOrderTypes );
      procedure fSetSize( inValue : string );
      procedure fSetPage( inValue : string );
      procedure fSetReturned( inValue : boolean );
      procedure fSetSold( inValue : boolean );
       // Standard Procedures
      procedure TabForward;
      procedure TabBackward;
      // Properties
      property ProductNum : string read fGetProductNum write fSetProductNum;
   	property Quantity : integer read fGetQuantity write fSetQuantity;
      property TaxRate : double read fGetTaxRate write fSetTaxRate;
      property WaveTax : boolean read fGetWaveTax write fSetWaveTax;
      property CostSellAt : currency read fGetCost write fSetCost;
      property CostRetail : currency read fGetRetailCost write fSetRetailCost;
      property Descr : string read fGetDescr write fSetDescr;
      property CycleNum : string read fGetCycleNum write fSetCycleNum; // passed in a 0000/00 manner
      property BackOrderedType : tInvoiceLineBackOrderTypes read fGetBackOrderedType write fSetBackOrderedType;
      property Size : string read fGetSize write fSetSize;
      property Page : string read fGetPage write fSetPage;
      property Returned : boolean read fGetReturned write fSetReturned;
      property Sold : boolean read fGetSold write fSetSold;
      // Events
      //property onDeleteLine : tEvent_DeleteLine read fOnDeleteLine write fOnDeleteLine;
*)

		// ----------------------------------------------------------------------------- //
		// Set
      procedure fSetLineNumber( inValue : integer );

		// ----------------------------------------------------------------------------- //
      // Get
      function fGetLineNumber : integer;

		// ----------------------------------------------------------------------------- //
		// Standard Procedures

		// ----------------------------------------------------------------------------- //
      // Properties
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;
	end;

   implementation

end.


{
      Procedure Discount_Line_Item;
      Procedure Delete_line;
      Procedure Ask_Discount_Line_Item;
      procedure Back_Tab_Pressed;
      Procedure Tab_Pressed;
      Procedure Recalc_Invoice;
      Procedure Do_Update_Invoice;
      Procedure Add_Product(InProdRec : tProdRec);
      Procedure Add_Product_Event( InProdNum : String );
      procedure Add_Select_Product(OrderCampID:Integer; InProd: tProdRec);
      Procedure RefreshPage;
      Procedure Initialize;


   	property onHand : boolean
      property prodNum : string
      property qty : integer
      property name : string
      property descr : string

line number

product name
page
size
cycle
retail cost
sell at cost
total cost
taxable
back ordered
back ordered type (see below)
	Back Ordered - Bill
	Back Ordered - No Bill
	Avon Missed Shipment - Bill
	Avon Missed Shipment - No Bill
	Product No Longer Available

comment?
wave tax
tax rate
quantity on hand
page
size
type (see below)
	Normal Product - Charge
	Buy X Item(s) - Get X Item(s) Free - Charge
	Buy X Item(s) - Get X Item(s) Free - No Charge
	Buy X Item(s) At Price X, Regular Price X - Charge
	Buy X Item(s) At Price X, Regular Price X - No Charge
	Complimentary/Free Item - No Charge
	Replacement Product - No Charge
	Replacement Product - Charge
	Back Order Now In From Prior Order - Charge
	Back Order Now In From Prior Order - No Charge

    property
}

{
    fOnNewLine : tNotifyEvent;
    fDeleteLine : tInvoiceLineItemDeleteLine;
    fLineUpdate : tInvoiceLineItemLineUpdate;
    EventRecalcInvoice : tRecalcInvoice;
    EventInvoiceUpdate : tNotifyEvent;
    EventAddProduct : tAddProduct;
    fOrderType : Integer;
    fProductSold : Boolean;
    fOrderCampID : Integer;
    fOnHand : Integer;

      Procedure Recalc_Invoice_Line;
      Procedure Discount_Line_Item;
      Procedure Delete_line;
      Procedure Ask_Discount_Line_Item;
      procedure Back_Tab_Pressed;
      Procedure Tab_Pressed;
      Procedure Recalc_Invoice;
      Procedure Do_Update_Invoice;
      Procedure Add_Product(InProdRec : tProdRec);
      Procedure Add_Product_Event( InProdNum : String );
      procedure Add_Select_Product(OrderCampID:Integer; InProd: tProdRec);
      Procedure RefreshPage;
      Procedure Initialize;
      Function ReturnInvoiceLineObject : tInvoiceLineObject;
      PROPERTY OnNewLine : TNotifyEvent READ fOnNewLine WRITE fOnNewLine;
      PROPERTY OnDeleteLine : tInvoiceLineItemDeleteLine READ fDeleteLine WRITE fDeleteLine;
      PROPERTY OnLineUpdate : tInvoiceLineItemLineUpdate READ fLineUpdate WRITE fLineUpdate;
      PROPERTY BackOrdered : Boolean READ GetBackOrdered WRITE SetBackOrdered;
      PROPERTY LoadBackOrdered : Boolean READ GetBackOrdered WRITE SetLoadBackOrdered;
      PROPERTY WaveTax : Boolean READ GetWaveTax WRITE SetWaveTax;
      PROPERTY LoadWaveTax : Boolean READ GetWaveTax WRITE SetLoadWaveTax;
      PROPERTY BackOrderedType : Integer READ GetBackOrderedType WRITE SetBackOrderedType;
      PROPERTY Page : String READ GetPage WRITE SetPage;
      PROPERTY SizeOZ : String READ GetSizeOZ Write SetSizeOZ;
      PROPERTY OnRecalcInvoice : tRecalcInvoice READ EventRecalcInvoice WRITE EventRecalcInvoice;
      PROPERTY OnInvoiceChange : tNotifyEvent READ EventInvoiceUpdate WRITE EventInvoiceUpdate;
      PROPERTY OnAddProduct : tAddProduct READ EventAddProduct WRITE EventAddProduct;
      PROPERTY OrderType : Integer READ fOrderType WRITE fOrderType;
      PROPERTY ProductSold : Boolean READ fProductSold WRITE fProductSold;
      PROPERTY ProductType : Integer READ GetProductType WRITE SetProductType;
      PROPERTY ProductReturn : Boolean READ GetProductReturn WRITE SetProductReturn;
      PROPERTY OrderCampID : Integer READ fOrderCampID WRITE fOrderCampID;
      PROPERTY OnHandQTY : Integer READ GetOnHand WRITE SetOnHand;
}
