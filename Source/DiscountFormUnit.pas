 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit DiscountFormUnit;

interface uses
   constantsunit,
   img_storageformunit,
   toolboxunit,
   //
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   Spin,
   Buttons,
   ExtCtrls,
   Mask,
   ComCtrls,
   ToolWin;

type
   tDiscountForm = class(tForm)
      disc_back_panel: TPanel;
      disc_top_panel: TPanel;
      DiscToolBar: TToolBar;
      cancelButton: TToolButton;
      discountButton: TToolButton;
      quick_percent_group: TRadioGroup;
      disc_percent_group: TGroupBox;
      percent_label: TLabel;
      DiscSpin: TSpinEdit;
      procedure cancelButtonClick(Sender: TObject);
      procedure discountButtonClick(Sender: TObject);
      procedure quick_percent_groupClick(Sender: TObject);
   public
      _DiscountPercent : real;
      _DiscountAmount : Currency;
   end;

(* ***************************************************************************************************** *)

implementation

{$R *.dfm}

(* ***************************************************************************************************** *)

procedure TDiscountForm.cancelButtonClick(Sender: TObject);
begin
  _DiscountPercent := 0;
  _DiscountAmount := 0;
  Close;
end;

procedure tDiscountForm.quick_percent_groupClick(Sender: TObject);
begin
   if quick_percent_group.ItemIndex = 0 then
      DiscSpin.Value := 10;
   if quick_percent_group.ItemIndex = 1 then
      DiscSpin.Value := 20;
   if quick_percent_group.ItemIndex = 2 then
      DiscSpin.Value := 30;
   if quick_percent_group.ItemIndex = 3 then
      DiscSpin.Value := 40;
   if quick_percent_group.ItemIndex = 4 then
      DiscSpin.Value := 50;
   if quick_percent_group.ItemIndex = 5 then
      DiscSpin.Value := 60;
   if quick_percent_group.ItemIndex = 6 then
      DiscSpin.Value := 70;
   if quick_percent_group.ItemIndex = 7 then
      DiscSpin.Value := 80;
   if quick_percent_group.ItemIndex = 8 then
      DiscSpin.Value := 90;
end;

procedure tDiscountForm.discountButtonClick(Sender: TObject);
begin
  if DiscSpin.Value = 0 then _DiscountPercent := 0.00;
  if DiscSpin.Value = 1 then _DiscountPercent := 0.01;
  if DiscSpin.Value = 2 then _DiscountPercent := 0.02;
  if DiscSpin.Value = 3 then _DiscountPercent := 0.03;
  if DiscSpin.Value = 4 then _DiscountPercent := 0.04;
  if DiscSpin.Value = 5 then _DiscountPercent := 0.05;
  if DiscSpin.Value = 6 then _DiscountPercent := 0.06;
  if DiscSpin.Value = 7 then _DiscountPercent := 0.07;
  if DiscSpin.Value = 8 then _DiscountPercent := 0.08;
  if DiscSpin.Value = 9 then _DiscountPercent := 0.09;
  if DiscSpin.Value = 10 then _DiscountPercent := 0.10;
  if DiscSpin.Value = 11 then _DiscountPercent := 0.11;
  if DiscSpin.Value = 12 then _DiscountPercent := 0.12;
  if DiscSpin.Value = 13 then _DiscountPercent := 0.13;
  if DiscSpin.Value = 14 then _DiscountPercent := 0.14;
  if DiscSpin.Value = 15 then _DiscountPercent := 0.15;
  if DiscSpin.Value = 16 then _DiscountPercent := 0.16;
  if DiscSpin.Value = 17 then _DiscountPercent := 0.17;
  if DiscSpin.Value = 18 then _DiscountPercent := 0.18;
  if DiscSpin.Value = 19 then _DiscountPercent := 0.19;
  if DiscSpin.Value = 20 then _DiscountPercent := 0.20;
  if DiscSpin.Value = 21 then _DiscountPercent := 0.21;
  if DiscSpin.Value = 22 then _DiscountPercent := 0.22;
  if DiscSpin.Value = 23 then _DiscountPercent := 0.23;
  if DiscSpin.Value = 24 then _DiscountPercent := 0.24;
  if DiscSpin.Value = 25 then _DiscountPercent := 0.25;
  if DiscSpin.Value = 26 then _DiscountPercent := 0.26;
  if DiscSpin.Value = 27 then _DiscountPercent := 0.27;
  if DiscSpin.Value = 28 then _DiscountPercent := 0.28;
  if DiscSpin.Value = 29 then _DiscountPercent := 0.29;
  if DiscSpin.Value = 30 then _DiscountPercent := 0.30;
  if DiscSpin.Value = 31 then _DiscountPercent := 0.31;
  if DiscSpin.Value = 32 then _DiscountPercent := 0.32;
  if DiscSpin.Value = 33 then _DiscountPercent := 0.33;
  if DiscSpin.Value = 34 then _DiscountPercent := 0.34;
  if DiscSpin.Value = 35 then _DiscountPercent := 0.35;
  if DiscSpin.Value = 36 then _DiscountPercent := 0.36;
  if DiscSpin.Value = 37 then _DiscountPercent := 0.37;
  if DiscSpin.Value = 38 then _DiscountPercent := 0.38;
  if DiscSpin.Value = 39 then _DiscountPercent := 0.39;
  if DiscSpin.Value = 40 then _DiscountPercent := 0.40;
  if DiscSpin.Value = 41 then _DiscountPercent := 0.41;
  if DiscSpin.Value = 42 then _DiscountPercent := 0.42;
  if DiscSpin.Value = 43 then _DiscountPercent := 0.43;
  if DiscSpin.Value = 44 then _DiscountPercent := 0.44;
  if DiscSpin.Value = 45 then _DiscountPercent := 0.45;
  if DiscSpin.Value = 46 then _DiscountPercent := 0.46;
  if DiscSpin.Value = 47 then _DiscountPercent := 0.47;
  if DiscSpin.Value = 48 then _DiscountPercent := 0.48;
  if DiscSpin.Value = 49 then _DiscountPercent := 0.49;
  if DiscSpin.Value = 50 then _DiscountPercent := 0.50;
  if DiscSpin.Value = 51 then _DiscountPercent := 0.51;
  if DiscSpin.Value = 52 then _DiscountPercent := 0.52;
  if DiscSpin.Value = 53 then _DiscountPercent := 0.53;
  if DiscSpin.Value = 54 then _DiscountPercent := 0.54;
  if DiscSpin.Value = 55 then _DiscountPercent := 0.55;
  if DiscSpin.Value = 56 then _DiscountPercent := 0.56;
  if DiscSpin.Value = 57 then _DiscountPercent := 0.57;
  if DiscSpin.Value = 58 then _DiscountPercent := 0.58;
  if DiscSpin.Value = 59 then _DiscountPercent := 0.59;
  if DiscSpin.Value = 60 then _DiscountPercent := 0.60;
  if DiscSpin.Value = 61 then _DiscountPercent := 0.61;
  if DiscSpin.Value = 62 then _DiscountPercent := 0.62;
  if DiscSpin.Value = 63 then _DiscountPercent := 0.63;
  if DiscSpin.Value = 64 then _DiscountPercent := 0.64;
  if DiscSpin.Value = 65 then _DiscountPercent := 0.65;
  if DiscSpin.Value = 66 then _DiscountPercent := 0.66;
  if DiscSpin.Value = 67 then _DiscountPercent := 0.67;
  if DiscSpin.Value = 68 then _DiscountPercent := 0.68;
  if DiscSpin.Value = 69 then _DiscountPercent := 0.69;
  if DiscSpin.Value = 70 then _DiscountPercent := 0.70;
  if DiscSpin.Value = 71 then _DiscountPercent := 0.71;
  if DiscSpin.Value = 72 then _DiscountPercent := 0.72;
  if DiscSpin.Value = 73 then _DiscountPercent := 0.73;
  if DiscSpin.Value = 74 then _DiscountPercent := 0.74;
  if DiscSpin.Value = 75 then _DiscountPercent := 0.75;
  if DiscSpin.Value = 76 then _DiscountPercent := 0.76;
  if DiscSpin.Value = 77 then _DiscountPercent := 0.77;
  if DiscSpin.Value = 78 then _DiscountPercent := 0.78;
  if DiscSpin.Value = 79 then _DiscountPercent := 0.79;
  if DiscSpin.Value = 80 then _DiscountPercent := 0.80;
  if DiscSpin.Value = 81 then _DiscountPercent := 0.81;
  if DiscSpin.Value = 82 then _DiscountPercent := 0.82;
  if DiscSpin.Value = 83 then _DiscountPercent := 0.83;
  if DiscSpin.Value = 84 then _DiscountPercent := 0.84;
  if DiscSpin.Value = 85 then _DiscountPercent := 0.85;
  if DiscSpin.Value = 86 then _DiscountPercent := 0.86;
  if DiscSpin.Value = 87 then _DiscountPercent := 0.87;
  if DiscSpin.Value = 88 then _DiscountPercent := 0.88;
  if DiscSpin.Value = 89 then _DiscountPercent := 0.89;
  if DiscSpin.Value = 90 then _DiscountPercent := 0.90;
  if DiscSpin.Value = 91 then _DiscountPercent := 0.91;
  if DiscSpin.Value = 92 then _DiscountPercent := 0.92;
  if DiscSpin.Value = 93 then _DiscountPercent := 0.93;
  if DiscSpin.Value = 94 then _DiscountPercent := 0.94;
  if DiscSpin.Value = 95 then _DiscountPercent := 0.95;
  if DiscSpin.Value = 96 then _DiscountPercent := 0.96;
  if DiscSpin.Value = 97 then _DiscountPercent := 0.97;
  if DiscSpin.Value = 98 then _DiscountPercent := 0.98;
  if DiscSpin.Value = 99 then _DiscountPercent := 0.99;
  if DiscSpin.Value = 100 then _DiscountPercent := 1.0;
  _DiscountAmount := 0;
  Close;
end;

end.

