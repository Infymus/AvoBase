 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit	AvoBase_BitButtonUnit;

interface uses
  constantsunit,
  toolboxunit,
  //
  classes,
  graphics,
  buttons,
  controls;

type
   tAvoBaseBitButton = class( tSpeedButton )
   public
      OrderID : string;
      FORM_GROUP : integer;
      AVOBASE_MENU_BUTTON_HEIGHT : integer;
      AVOBASE_ORDER_BUTTON_NEIGHT : integer;
      //
      constructor Create( aOwner : tComponent ); override;
  end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tAvoBaseBitButton.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   //
   Self.Font.Name := 'Verdana';
   Self.Font.Size := 10;
   Self.Font.Style := [fsBold];
   Self.Font.Color := ClBlack;
   Self.Cursor := crHandPoint;
   Self.Transparent := TRUE;
   Self.Font.Size := 9;
   Self.Font.Color := $00301C66;
   // Our extra tweaks to this object
   AVOBASE_MENU_BUTTON_HEIGHT := 20;
   AVOBASE_ORDER_BUTTON_NEIGHT := 55;
   OrderID := '';
end;

end.