object Invoice_MOPItem_Form: TInvoice_MOPItem_Form
  Left = 370
  Top = 35
  BorderStyle = bsNone
  Caption = 'Invoice_MOPItem_Form'
  ClientHeight = 45
  ClientWidth = 651
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MOP_BACK_PANEL: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 45
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Caption = 'MOP_BACK_PANEL'
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object MOP_SIDE_PANEL: TPanel
      Left = 1
      Top = 1
      Width = 35
      Height = 43
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      OnClick = MOPLineClicked
      object OrderProductNumPanel: TPanel
        Left = 0
        Top = 0
        Width = 33
        Height = 33
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
        OnClick = MOPLineClicked
      end
    end
    object MOP_PANEL: TPanel
      Left = 36
      Top = 1
      Width = 614
      Height = 43
      Align = alClient
      BorderWidth = 1
      Color = clBlack
      ParentBackground = False
      TabOrder = 1
      object LineItemOnePanel: TPanel
        Left = 2
        Top = 2
        Width = 610
        Height = 39
        Align = alClient
        BevelOuter = bvNone
        Color = clCream
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = MOPLineClicked
        object Label2: TLabel
          Left = 0
          Top = 0
          Width = 80
          Height = 14
          Caption = 'PAYMENT DATE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MOPLineClicked
        end
        object Label1: TLabel
          Left = 101
          Top = 0
          Width = 80
          Height = 14
          Caption = 'PAYMENT TYPE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MOPLineClicked
        end
        object mopvalueLabel: TLabel
          Left = 257
          Top = 0
          Width = 83
          Height = 14
          Caption = 'CHECK NUMBER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MOPLineClicked
        end
        object FeeCostLabel: TLabel
          Left = 384
          Top = 0
          Width = 49
          Height = 14
          Caption = 'AMOUNT:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MOPLineClicked
        end
        object paymentTypeCombo: TComboBox
          Left = 101
          Top = 14
          Width = 154
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
          TabOrder = 1
          OnChange = paymentTypeComboChange
          OnClick = MOPLineClicked
        end
        object db_mopvalue: TEdit
          Left = 257
          Top = 14
          Width = 125
          Height = 21
          TabOrder = 2
          Text = 'db_mopvalue'
          OnClick = MOPLineClicked
        end
        object db_mopdate: TDateTimePicker
          Left = 0
          Top = 14
          Width = 99
          Height = 21
          Date = 40904.351171550920000000
          Time = 40904.351171550920000000
          MinDate = 40179.000000000000000000
          TabOrder = 0
          OnClick = MOPLineClicked
        end
        object db_amount: TMaskEdit
          Tag = 5
          Left = 384
          Top = 14
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
          TabOrder = 3
          Text = '    .  '
          OnChange = db_amountChange
          OnClick = MOPLineClicked
        end
      end
    end
  end
end
