object ImportProduct_LineItem_Form: TImportProduct_LineItem_Form
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'ImportProduct_LineItem_Form'
  ClientHeight = 25
  ClientWidth = 728
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object line_item_panel: TPanel
    Left = 0
    Top = 0
    Width = 728
    Height = 25
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    OnClick = line_item_panelClick
    object db_ycost: TMaskEdit
      Tag = 5
      Left = 396
      Top = 3
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
      TabOrder = 0
      Text = '    .  '
    end
    object db_rcost: TMaskEdit
      Tag = 5
      Left = 485
      Top = 3
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
      TabOrder = 1
      Text = '    .  '
    end
    object db_prodnum: TEdit
      Left = 21
      Top = 3
      Width = 79
      Height = 21
      Color = 13421823
      TabOrder = 2
      Text = 'db_prodnum'
    end
    object db_prodname: TEdit
      Left = 102
      Top = 3
      Width = 243
      Height = 21
      Color = 13421823
      TabOrder = 3
      Text = 'db_prodname'
    end
    object db_qty: TEdit
      Left = 351
      Top = 3
      Width = 43
      Height = 21
      Color = 13421823
      TabOrder = 4
      Text = 'db_qty'
    end
  end
end
