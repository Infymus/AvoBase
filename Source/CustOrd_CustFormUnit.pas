 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
 unit CustOrd_CustFormUnit;


interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_percentformunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   MasterData_TransactionListUnit,
   AvoBase_ToolBarUnit,
   toolbox_ordertoolboxunit,
   toolbox_PreferenceToolBoxUnit,
   ToolBox_EscrowToolBoxUnit,
   avobase_dialogformunit,
   //
   bde,
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Contnrs,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   math,
   StdCtrls, ComCtrls, ToolWin, ExtCtrls;

type
   tCustOrd_CustForm = class(TForm)
    BASEFORM_DOCK: TPanel;
    BASEFORM_BACK_PANEL: TPanel;
    BASE_FORM_TOP_PANEL: TPanel;
    BASE_FORM_CAPTION_LABEL: TLabel;
    BASE_LABEL_SEP_PANEL: TPanel;
    BASE_DOCK_PANEL: TPanel;
    ToolBar: TToolBar;
    StatusBar: TStatusBar;
   private
      LineItem : tObjectList;
      //
      fCustID : string;
      // events
      fLineItem_FormHeight_Order : integer;
      fInvoiceLineItemClickedEvent : tInvoiceLineItemClickedEvent;
      eLineDelete : tDeleteLineEvent;
      eLineUpdate : tEvent_LineItem_LineUpdate;
      eRecalculateInvoiceEvent : tRecalculateInvoiceEvent;
      fInvoiceLineItemProductLookupEvent : tInvoiceLineItemProductLookupEvent;
      eInvoiceLineItemExit : tInvoiceLineItemExit;
      //
      function fGetProductLineItemCount : integer;
   public

      // Properties
      property FormHeight : integer read fLineItem_FormHeight_Order;
      property CustID : string read fCustID write fCustID;
      property Count : integer read fGetProductLineItemCount;
      // Events
      property OnLineDelete : tDeleteLineEvent read eLineDelete write eLineDelete;
      property OnLineUpdate : tEvent_LineItem_LineUpdate read eLineUpdate write eLineUpdate;
      property OnRecalculateInvoice : tRecalculateInvoiceEvent read eRecalculateInvoiceEvent write eRecalculateInvoiceEvent;
      property OnLineClicked : tInvoiceLineItemClickedEvent read fInvoiceLineItemClickedEvent write fInvoiceLineItemClickedEvent;
      //
      constructor create( inOwner : tComponent ); override;
      constructor destroy; virtual;
   end;

implementation

{$R *.dfm}

// ######################################################################################### //

constructor tCustOrd_CustForm.create(inOwner: tComponent);
begin
	inherited create( inOwner );
   //
   fLineItem_FormHeight_Order := 150; // SIZE OF FORM WHEN IT IS CREATED
   //
   LineItem := TObjectList.Create;
end;

constructor tCustOrd_CustForm.destroy;
begin
   FreeAndNil( LineItem );
   //
   inherited Free;
end;

function tCustOrd_CustForm.fGetProductLineItemCount: integer;
begin
   result := LineItem.Count;
end;

end.
