 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Order_LineItemFormUnit;

INTERFACE USES
       Windows,
      Messages,
      Constantsunit,
      SysUtils,
      Classes,
      Graphics,
      Controls,
      Forms,
      Dialogs,
      Db,
      Toolboxunit,
      MasterDataUnit,
      order_DiscountFormUnit,
      AvoBase_DialogFormUnit,
      avobase_PercentFormUnit,
      DBTables,
      INIFiles,
      BDE,
      ExtCtrls,
      StdCtrls,
      Mask,
      Buttons,
      Menus,
      ImgList,
      jpeg,
      IMG_StorageFormUnit;

CONST
  INVOICELINEITEM_FORM_HEIGHT_ORDER = 140;
  INVOICELINEITEM_FORM_HEIGHT_RETURN = 173;

TYPE
  tInvoiceLineItemDeleteLine = Procedure( Sender : Tobject; LineNum : Integer ) OF Object;
  tInvoiceLineItemLineUpdate = Procedure( Sender : Tobject; LineNum : Integer ) OF Object;
  tRecalcInvoice = Procedure( Sender : tObject ) OF Object;
  tAddProduct = Procedure( Sender : tObject; ProdNum : String) OF Object;
  
// form object
type
  tInvoiceLineItem = class( tForm )
  PROTECTED
  PRIVATE
  PUBLIC
    { CONSTRUCTORS }
    CONSTRUCTOR Create( Owner : TComponent; InCampID : Integer ); OVERLOAD;
  end;

IMPLEMENTATION

{$R *.DFM}

(* **************************************************************************************** *)

CONSTRUCTOR TInvoiceLineItem.Create( Owner : TComponent; InCampID : Integer );
begin
  Inherited Create(Owner);
  { Create Method }
  Self.Height := INVOICELINEITEM_FORM_HEIGHT_ORDER;
end;



end.
