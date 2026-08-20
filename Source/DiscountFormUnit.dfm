object DiscountForm: TDiscountForm
  Left = 290
  Top = 156
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Quick Discount Line Item'
  ClientHeight = 204
  ClientWidth = 345
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object disc_back_panel: TPanel
    Left = 0
    Top = 0
    Width = 345
    Height = 204
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 738
    ExplicitHeight = 473
    object disc_top_panel: TPanel
      Left = 1
      Top = 1
      Width = 343
      Height = 202
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 2
      ExplicitWidth = 734
      ExplicitHeight = 469
      object DiscToolBar: TToolBar
        Left = 0
        Top = 152
        Width = 343
        Height = 50
        Align = alBottom
        AutoSize = True
        ButtonHeight = 50
        ButtonWidth = 49
        Caption = 'DiscToolBar'
        Color = clWhite
        Images = IMG_StorageForm.Avobase_ToolBar_Img
        ParentColor = False
        ShowCaptions = True
        TabOrder = 0
        ExplicitTop = 157
        object discountButton: TToolButton
          Left = 0
          Top = 0
          Caption = 'Discount'
          ImageIndex = 35
          OnClick = discountButtonClick
        end
        object cancelButton: TToolButton
          Left = 49
          Top = 0
          Hint = 'Cancel - NO Discount'
          Caption = 'Cancel'
          ImageIndex = 3
          ParentShowHint = False
          ShowHint = True
          OnClick = cancelButtonClick
        end
      end
      object quick_percent_group: TRadioGroup
        Left = 8
        Top = 5
        Width = 157
        Height = 146
        Caption = 'Quick Discount'
        Color = clWhite
        ItemIndex = 0
        Items.Strings = (
          '10 % Off'
          '20 % Off'
          '30 % Off'
          '40 % Off'
          '50 % Off'
          '60 % Off'
          '70 % Off'
          '80 % Off'
          '90 % Off')
        ParentColor = False
        TabOrder = 1
        OnClick = quick_percent_groupClick
      end
      object disc_percent_group: TGroupBox
        Left = 168
        Top = 5
        Width = 167
        Height = 146
        Caption = 'Set Discount Percentage'
        Color = clWhite
        ParentColor = False
        TabOrder = 2
        object percent_label: TLabel
          Left = 103
          Top = 57
          Width = 16
          Height = 20
          Caption = '%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DiscSpin: TSpinEdit
          Left = 42
          Top = 54
          Width = 59
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 3
          MaxValue = 100
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
        end
      end
    end
  end
end
