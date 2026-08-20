unit MaskAmountEdit;

interface

uses
   SysUtils,
   Classes,
   Controls,
   StdCtrls,
   windows,
   messages,
   contnrs,
   Variants,
   Graphics,
   Dialogs,
   Mask,
   ExtCtrls,
   forms,
   Menus,
   Buttons;

type
   tMaskAmountEdit = class(TMaskEdit)
   private
   protected
   public
      procedure HandleClicked(Sender: TObject);
      constructor create( owner : TComponent ); override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [tMaskAmountEdit]);
end;

constructor tMaskAmountEdit.create( owner : TComponent );
begin
   inherited Create( owner );
   //
   self.Color := $00E3DDFF;
   self.EditMask := '#####.##;1;';
   self.Font.Name := 'Arial';
   Self.Font.Size := 8;
   Self.Font.Style := [fsBold];
   self.Width := 82;
   Self.Height := 22;
   Self.MaxLength := 7;
   self.BorderStyle := bsSingle;
   Self.OnClick := HandleClicked;
end;

procedure tMaskAmountEdit.HandleClicked(Sender: TObject);
begin
   Self.SelectAll();
end;

end.
