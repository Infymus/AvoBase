object Return_FEEItem_Form: TReturn_FEEItem_Form
  Left = 336
  Top = 7
  Caption = 'Return_FEEItem_Form'
  ClientHeight = 297
  ClientWidth = 847
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
    Width = 847
    Height = 297
    Align = alClient
    BevelOuter = bvNone
    Caption = 'InvoceLineFrontPanel'
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Fee_Opt_Panel: TPanel
      Left = 0
      Top = 0
      Width = 33
      Height = 297
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object MenuBackPanel: TPanel
        Left = -1
        Top = 0
        Width = 33
        Height = 36
        BorderWidth = 1
        Color = clWhite
        TabOrder = 0
        object OrderProductNumPanel: TPanel
          Left = 1
          Top = 0
          Width = 34
          Height = 40
          Align = alCustom
          Caption = '01'
          Color = clMaroon
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          OnClick = FeeLineItemClicked
        end
      end
    end
    object FEE_BACK_PANEL: TPanel
      Left = 33
      Top = 0
      Width = 814
      Height = 297
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 1
      Color = clBlack
      ParentBackground = False
      TabOrder = 1
      object LineItemOnePanel: TPanel
        Left = 1
        Top = 1
        Width = 812
        Height = 295
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = FeeLineItemClicked
        object FeeNameLabel: TLabel
          Left = 4
          Top = 19
          Width = 52
          Height = 14
          Caption = 'FEE NAME'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = FeeLineItemClicked
        end
        object OrgLabel: TLabel
          Left = 1
          Top = 0
          Width = 117
          Height = 13
          Caption = 'ORG_NAME_LABEL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clPurple
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = FeeLineItemClicked
        end
        object nonAddFeeLabel: TLabel
          Left = 5
          Top = 63
          Width = 215
          Height = 13
          Caption = '* Note: This fee is from prior Invoice. '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object tFeeLineFeeName: TEdit
          Tag = 3
          Left = 4
          Top = 36
          Width = 380
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
        end
        object CalculationGroupBox: TGroupBox
          Left = 626
          Top = 0
          Width = 186
          Height = 295
          Align = alRight
          Color = clWhite
          ParentBackground = False
          ParentColor = False
          TabOrder = 1
          OnClick = FeeLineItemClicked
          object FeeCostLabel: TLabel
            Left = 10
            Top = 6
            Width = 86
            Height = 13
            Caption = 'FEE AMOUNT:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = FeeLineItemClicked
          end
          object TaxLabel: TLabel
            Left = 83
            Top = 26
            Width = 29
            Height = 13
            Caption = 'TAX:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = FeeLineItemClicked
          end
          object TOtalCostLabel: TLabel
            Left = 69
            Top = 44
            Width = 45
            Height = 13
            Alignment = taRightJustify
            Caption = 'TOTAL:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
            OnClick = FeeLineItemClicked
          end
          object tTotalCostLabel: TLabel
            Left = 120
            Top = 44
            Width = 60
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '     0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            OnClick = FeeLineItemClicked
          end
          object tTotalTaxLabel: TLabel
            Left = 120
            Top = 26
            Width = 60
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '     0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            OnClick = FeeLineItemClicked
          end
          object TaxRateLabel: TLabel
            Left = 18
            Top = 26
            Width = 62
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'TBD %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = FeeLineItemClicked
          end
          object db_taxclasslabel: TLabel
            Left = 127
            Top = 96
            Width = 50
            Height = 12
            Caption = 'Tax Class:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object tFeeLineFeeAmount: TMaskEdit
            Tag = 5
            Left = 98
            Top = 3
            Width = 83
            Height = 21
            Hint = 'What discount you are giving to your Customer'
            BevelInner = bvNone
            BevelOuter = bvNone
            Color = 14933503
            Enabled = False
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
            TabOrder = 0
            Text = '    .  '
            OnChange = tFeeLineFeeAmountChange
            OnClick = FeeLineItemClicked
          end
          object ReturnFeePanel: TPanel
            Left = 15
            Top = 66
            Width = 159
            Height = 23
            BevelOuter = bvNone
            Color = 15459070
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 2
            object db_feerefund: TCheckBox
              Left = 12
              Top = 3
              Width = 134
              Height = 17
              Caption = 'Refund This Fee'
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 0
              OnClick = tFeeLineFeeAmountChange
            end
          end
          object db_taxclass: TComboBox
            Left = 63
            Top = 114
            Width = 114
            Height = 19
            BevelInner = bvLowered
            Style = csOwnerDrawVariable
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 1
          end
        end
      end
    end
  end
  object PopMenu: TPopupMenu
    Images = IMG_StorageForm.Avobase_25x25_Images
    Left = 453
    Top = 9
    object None1: TMenuItem
      Caption = 'None'
      ImageIndex = 7
    end
  end
end
