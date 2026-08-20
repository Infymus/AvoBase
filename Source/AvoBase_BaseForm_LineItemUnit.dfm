object AvoBase_BaseForm_lineItem: TAvoBase_BaseForm_lineItem
  Left = 305
  Top = 3
  Caption = 'AvoBase_BaseForm_lineItem'
  ClientHeight = 164
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LINEITEM_BACK_PANEL: TPanel
    Left = 0
    Top = 0
    Width = 743
    Height = 164
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clBlack
    TabOrder = 0
    object INVOICE_RETURN_BAR: TPanel
      Left = 1
      Top = 1
      Width = 741
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Visible = False
      object tProductReturn: TCheckBox
        Left = 4
        Top = 2
        Width = 543
        Height = 17
        Hint = 'Check this if the Product is to be Returned'
        Caption = 'Check Box To Return This Product'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object LINEITEM_FRONT_PANEL: TPanel
      Left = 1
      Top = 21
      Width = 741
      Height = 142
      Align = alClient
      BevelOuter = bvNone
      Caption = 'LINEITEM_FRONT_PANEL'
      TabOrder = 1
    end
  end
end
