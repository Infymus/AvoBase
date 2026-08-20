object Earning_EditForm: TEarning_EditForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Earning'
  ClientHeight = 365
  ClientWidth = 218
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object back_panel: TPanel
    Left = 0
    Top = 0
    Width = 218
    Height = 365
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 247
    ExplicitHeight = 293
    object EXP_BACK_PANEL: TPanel
      Left = 1
      Top = 32
      Width = 216
      Height = 332
      Align = alClient
      BevelOuter = bvNone
      Color = 15461355
      ParentBackground = False
      TabOrder = 0
      ExplicitWidth = 245
      ExplicitHeight = 260
      object Label2: TLabel
        Left = 4
        Top = 2
        Width = 79
        Height = 14
        Caption = 'EARNING DATE:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object expenseTypeLabel: TLabel
        Left = 4
        Top = 44
        Width = 79
        Height = 14
        Caption = 'EARNING TYPE:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 4
        Top = 86
        Width = 83
        Height = 14
        Caption = 'PAYMENT TYPE:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mopvalueLabel: TLabel
        Left = 4
        Top = 125
        Width = 103
        Height = 14
        Caption = 'FILLED AT RUNTIME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FeeCostLabel: TLabel
        Left = 4
        Top = 164
        Width = 49
        Height = 14
        Caption = 'AMOUNT:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 4
        Top = 205
        Width = 84
        Height = 14
        AutoSize = False
        Caption = 'DESCRIPTION:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object expTypeCombo: TComboBox
        Left = 4
        Top = 59
        Width = 210
        Height = 22
        BevelInner = bvLowered
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 1
        OnChange = expTypeComboChange
      end
      object paymentTypeCombo: TComboBox
        Left = 4
        Top = 100
        Width = 152
        Height = 22
        BevelInner = bvLowered
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 2
        OnChange = paymentTypeComboChange
      end
      object db_mopvalue: TEdit
        Left = 4
        Top = 139
        Width = 88
        Height = 21
        TabOrder = 3
        Text = 'db_mopvalue'
      end
      object db_amount: TMaskEdit
        Tag = 5
        Left = 4
        Top = 179
        Width = 79
        Height = 21
        Hint = 'Amount Paid'
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
        TabOrder = 4
        Text = '    .  '
        OnClick = db_amountClick
      end
      object db_mopdate: TDateTimePicker
        Left = 4
        Top = 19
        Width = 96
        Height = 19
        Date = 40904.351171550920000000
        Time = 40904.351171550920000000
        TabOrder = 0
      end
      object MENU_PANEL: TPanel
        Left = 0
        Top = 280
        Width = 216
        Height = 52
        Align = alBottom
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 5
        ExplicitTop = 208
        ExplicitWidth = 245
      end
      object db_edesc: TEdit
        Left = 4
        Top = 220
        Width = 210
        Height = 21
        AutoSize = False
        MaxLength = 80
        TabOrder = 6
        Text = 'db_edesc'
      end
    end
    object TOP_PANEL: TPanel
      Left = 1
      Top = 1
      Width = 216
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      Color = 16094334
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 245
      object ORG_LABEL: TLabel
        Left = 0
        Top = -1
        Width = 81
        Height = 14
        Caption = 'ORG_LABEL'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object CYCLE_LABEL: TLabel
        Left = 0
        Top = 16
        Width = 95
        Height = 14
        Caption = 'CYCLE_LABEL'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
    end
  end
end
