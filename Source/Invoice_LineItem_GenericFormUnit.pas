 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit	Invoice_LineItem_GenericFormUnit;

interface uses
	Invoice_LineItemInterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   AvoBase_BaseForm_LineItemUnit,
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

type
	TLineItem_GenericForm = class(TAvoBase_BaseForm_lineItem, iInvoiceLineItem)
   private
   	// **** START FROM INTERFACE **********************************************
   	// Get
      procedure fSetLineNumber( inValue : integer );

      // Set
      function fGetLineNumber : integer;

   	// **** END FROM INTERFACE ************************************************
   public
      property LineNumber : integer read fGetLineNumber write fSetLineNumber;

   end;

implementation

{$R *.dfm}


{ TLineItem_GenericForm }

function TLineItem_GenericForm.fGetLineNumber: integer;
begin

end;

procedure TLineItem_GenericForm.fSetLineNumber(inValue: integer);
begin

end;

end.
