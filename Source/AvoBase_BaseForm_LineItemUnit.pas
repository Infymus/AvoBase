 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
unit AvoBase_BaseForm_LineItemUnit;

interface uses
	Invoice_LineItemInterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
	//
   windows,
   messages,
   sysutils,
   forms,
   contnrs,
   classes,
   Variants,
   Graphics,
   Controls,
   Dialogs,
   StdCtrls,
   Mask,
   ExtCtrls;

// these tell how big to make the form when it is created and docked
const
	LINEITEM_ORDER_HEIGHT = 140;
   LINEITEM_RETURN_HEIGHT = 173;

// events associated with the form
type
  tInvoiceLineItemDeleteLine = Procedure( Sender : Tobject; LineNum : Integer ) OF Object;
  tInvoiceLineItemLineUpdate = Procedure( Sender : Tobject; LineNum : Integer ) OF Object;
  tRecalcInvoice = Procedure( Sender : tObject ) OF Object;
  tAddProduct = Procedure( Sender : tObject; ProdNum : String) OF Object;

// Invoice Back Ordered Types
type
   tInvoiceLineBackOrderTypes =
      (
         BONone,
         BOBill,
         BONoBill
      );

type
	LineItemBackOrderedTypes =
   	(	boNormal,
			boBuyXGetXFree,
         buyXatPriceX
      );

type
	TAvoBase_BaseForm_lineItem = class(TForm)
   	LINEITEM_BACK_PANEL: TPanel;
      INVOICE_RETURN_BAR: TPanel;
      tProductReturn: TCheckBox;
      LINEITEM_FRONT_PANEL: TPanel;
   private
   	fOnNewLine : tNotifyEvent;
      fDeleteLine : tInvoiceLineItemDeleteLine;
      fLineUpdate : tInvoiceLineItemLineUpdate;
      EventRecalcInvoice : tRecalcInvoice;
      EventInvoiceUpdate : tNotifyEvent;
      // properties
   public

  end;

implementation

{$R *.dfm}

end.


