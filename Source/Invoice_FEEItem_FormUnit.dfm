object Invoice_FEEItem_Form: TInvoice_FEEItem_Form
  Left = 336
  Top = 7
  BorderStyle = bsNone
  Caption = 'Invoice_FEEItem_Form'
  ClientHeight = 38
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object InvoceLineFrontPanel: TPanel
    Left = 0
    Top = 0
    Width = 781
    Height = 38
    Align = alClient
    BevelOuter = bvNone
    Caption = 'InvoceLineFrontPanel'
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 62
    object Fee_Opt_Panel: TPanel
      Left = 0
      Top = 0
      Width = 35
      Height = 38
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 93
      object OrderProductNumPanel: TPanel
        Left = 0
        Top = 0
        Width = 33
        Height = 33
        Align = alCustom
        BevelOuter = bvNone
        Caption = '01'
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = FeeLineItemClicked
      end
    end
    object FEE_BACK_PANEL: TPanel
      Left = 35
      Top = 0
      Width = 746
      Height = 38
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 1
      Color = clBlack
      ParentBackground = False
      TabOrder = 1
      ExplicitHeight = 62
      object LineItemOnePanel: TPanel
        Left = 1
        Top = 1
        Width = 744
        Height = 36
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = FeeLineItemClicked
        ExplicitHeight = 59
        object FeeNameLabel: TLabel
          Left = 1
          Top = -2
          Width = 51
          Height = 13
          Caption = 'FEE NAME'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = FeeLineItemClicked
        end
        object Label1: TLabel
          Left = 196
          Top = -2
          Width = 91
          Height = 14
          Caption = 'FEE DESCRIPTION'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = FeeLineItemClicked
        end
        object FeeCostLabel: TLabel
          Left = 331
          Top = -2
          Width = 70
          Height = 14
          Caption = 'FEE AMOUNT:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = FeeLineItemClicked
        end
        object TaxRateLabel: TLabel
          Left = 543
          Top = -2
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = '99.99%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = FeeLineItemClicked
        end
        object TaxLabel: TLabel
          Left = 518
          Top = -2
          Width = 24
          Height = 14
          Caption = 'TAX:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = FeeLineItemClicked
        end
        object tTotalTaxLabel: TLabel
          Left = 518
          Top = 12
          Width = 60
          Height = 19
          Alignment = taRightJustify
          AutoSize = False
          Caption = '     0.00'
          Color = 7405307
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          OnClick = FeeLineItemClicked
        end
        object TOtalCostLabel: TLabel
          Left = 587
          Top = -2
          Width = 39
          Height = 14
          Alignment = taRightJustify
          Caption = 'TOTAL:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
          OnClick = FeeLineItemClicked
        end
        object tTotalCostLabel: TLabel
          Left = 587
          Top = 12
          Width = 60
          Height = 19
          Alignment = taRightJustify
          AutoSize = False
          Caption = '     0.00'
          Color = 7405307
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          OnClick = FeeLineItemClicked
        end
        object db_taxclasslabel: TLabel
          Left = 416
          Top = -2
          Width = 64
          Height = 14
          Caption = 'TAX GROUP:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = FeeLineItemClicked
        end
        object tFeeLineFeeName: TEdit
          Tag = 3
          Left = 1
          Top = 12
          Width = 192
          Height = 21
          Hint = 'The name of your Product'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = FeeLineItemClicked
        end
        object tFeeLineDescr: TEdit
          Tag = 3
          Left = 196
          Top = 12
          Width = 133
          Height = 21
          Hint = 'The name of your Product'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = FeeLineItemClicked
        end
        object tFeeLineFeeAmount: TMaskEdit
          Tag = 5
          Left = 331
          Top = 12
          Width = 83
          Height = 21
          Hint = 'What discount you are giving to your Customer'
          BevelInner = bvNone
          BevelOuter = bvNone
          Color = 14933503
          EditMask = '####.##;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 7
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Text = '    .  '
          OnChange = tFeeLineFeeAmountChange
          OnClick = FeeLineItemClicked
        end
        object db_taxclass: TComboBox
          Left = 416
          Top = 12
          Width = 99
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 3
          OnClick = FeeLineItemClicked
        end
      end
    end
  end
  object PopMenu: TPopupMenu
    Images = IMG_StorageForm.Avobase_25x25_Images
    Left = 675
    Top = 65530
    object None1: TMenuItem
      Caption = 'None'
      ImageIndex = 7
    end
  end
end
