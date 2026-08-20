inherited EscrowModifyForm: TEscrowModifyForm
  Caption = 'EscrowModifyForm'
  ClientHeight = 239
  ClientWidth = 328
  OnShow = FormShow
  ExplicitWidth = 330
  ExplicitHeight = 241
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 328
    Height = 239
    ExplicitWidth = 328
    ExplicitHeight = 239
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 326
      Height = 237
      ExplicitWidth = 326
      ExplicitHeight = 237
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 326
        ExplicitWidth = 326
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 20
        Width = 326
        Height = 142
        Caption = ''
        ExplicitTop = 20
        ExplicitWidth = 326
        ExplicitHeight = 142
        object AmountDueLabel: TLabel
          Left = 46
          Top = 88
          Width = 185
          Height = 16
          Alignment = taRightJustify
          Caption = 'TOTAL CURRENT ESCROW:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object db_escrow: TLabel
          Left = 237
          Top = 88
          Width = 77
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = '$    0.00'
          Color = 7405307
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object CustSoldToName: TLabel
          Tag = 1
          Left = 6
          Top = 6
          Width = 150
          Height = 18
          Caption = 'CustSoldToName'
          Color = clSkyBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object CustSoldToAddress: TLabel
          Left = 24
          Top = 26
          Width = 140
          Height = 16
          Caption = 'CustSoldToAddress'
          Color = clSkyBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 64
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object CustSoldToCityStateZip: TLabel
          Left = 24
          Top = 42
          Width = 171
          Height = 16
          Caption = 'CustSoldToCityStateZip'
          Color = clSkyBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 64
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object CustSoldToPhone: TLabel
          Left = 24
          Top = 57
          Width = 126
          Height = 16
          Caption = 'CustSoldToPhone'
          Color = clSkyBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 64
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object RetailCostLabel: TLabel
          Left = 56
          Top = 112
          Width = 175
          Height = 16
          Caption = 'NEW ESCROW BALANCE:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = RetailCostLabelClick
        end
        object db_adjust: TMaskEdit
          Tag = 4
          Left = 237
          Top = 110
          Width = 78
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          BevelInner = bvNone
          BevelOuter = bvNone
          Color = 14933503
          EditMask = '####.##;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 7
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = '    .  '
        end
      end
      inherited ToolBar: TToolBar
        Top = 162
        Width = 326
        Align = alBottom
        ExplicitTop = 162
        ExplicitWidth = 326
      end
      inherited StatusBar: TStatusBar
        Top = 216
        Width = 326
        ExplicitTop = 216
        ExplicitWidth = 326
      end
    end
  end
end
