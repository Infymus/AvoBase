inherited ProductEditForm: TProductEditForm
  Caption = 'ProductEditForm'
  ClientHeight = 506
  ClientWidth = 460
  OnShow = FormShow
  ExplicitWidth = 462
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 460
    Height = 506
    ExplicitWidth = 460
    ExplicitHeight = 506
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 458
      Height = 504
      ExplicitWidth = 458
      ExplicitHeight = 504
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 458
        ExplicitWidth = 458
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 458
        Height = 409
        Caption = ''
        ExplicitWidth = 458
        ExplicitHeight = 409
        object Label1: TLabel
          Left = 6
          Top = 29
          Width = 61
          Height = 13
          Caption = 'Organization'
        end
        object Label5: TLabel
          Left = 220
          Top = 28
          Width = 66
          Height = 13
          Caption = 'Cycle Number'
        end
        object campYearLabel: TLabel
          Left = 296
          Top = 28
          Width = 51
          Height = 13
          Caption = 'Cycle Year'
        end
        object Label2: TLabel
          Left = 6
          Top = 77
          Width = 77
          Height = 13
          Caption = 'Product Number'
        end
        object amountLabel: TLabel
          Left = 189
          Top = 77
          Width = 52
          Height = 13
          Caption = 'Retail Cost'
        end
        object Label3: TLabel
          Left = 369
          Top = 77
          Width = 65
          Height = 13
          Caption = 'QTY On Hand'
        end
        object Label4: TLabel
          Left = 6
          Top = 360
          Width = 54
          Height = 13
          Caption = 'Tax Group:'
        end
        object db_noprodlabel: TLabel
          Left = 237
          Top = 204
          Width = 187
          Height = 131
          AutoSize = False
          Caption = 'FILLED IN AT RUNTIME.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label6: TLabel
          Left = 279
          Top = 77
          Width = 55
          Height = 13
          Caption = 'Sell At Cost'
        end
        object Label7: TLabel
          Left = 98
          Top = 77
          Width = 47
          Height = 13
          Caption = 'Your Cost'
        end
        object db_name: TLabeledEdit
          Left = 6
          Top = 136
          Width = 445
          Height = 21
          EditLabel.Width = 67
          EditLabel.Height = 13
          EditLabel.Caption = 'Product Name'
          MaxLength = 40
          TabOrder = 9
        end
        object orgCombo: TComboBox
          Left = 6
          Top = 47
          Width = 208
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
          OnChange = orgComboChange
        end
        object CycleNumComboBox: TComboBox
          Left = 220
          Top = 47
          Width = 70
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
          TabOrder = 2
        end
        object CycleYearComboBox: TComboBox
          Left = 296
          Top = 47
          Width = 69
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
        end
        object db_num: TMaskEdit
          Left = 6
          Top = 94
          Width = 85
          Height = 21
          Hint = 'Enter up to 20 length for Product Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 20
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object db_descr: TLabeledEdit
          Left = 6
          Top = 177
          Width = 445
          Height = 21
          EditLabel.Width = 121
          EditLabel.Height = 13
          EditLabel.Caption = 'Sale, Special or Comment'
          MaxLength = 40
          TabOrder = 10
        end
        object db_PRODN1: TLabeledEdit
          Left = 6
          Top = 219
          Width = 200
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'PRODN1'
          MaxLength = 40
          TabOrder = 11
        end
        object db_PRODN3: TLabeledEdit
          Left = 6
          Top = 297
          Width = 200
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'PRODN3'
          MaxLength = 40
          TabOrder = 13
        end
        object db_amount: TMaskEdit
          Tag = 4
          Left = 188
          Top = 94
          Width = 85
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          Color = 14933503
          EditMask = '#####.##;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 8
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Text = '     .  '
        end
        object db_isactive: TCheckBox
          Left = 6
          Top = 6
          Width = 97
          Height = 17
          Caption = 'Product Is Active'
          TabOrder = 0
        end
        object db_qty: TMaskEdit
          Left = 369
          Top = 94
          Width = 38
          Height = 21
          Color = clWhite
          EditMask = '!99999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 8
          Text = '     '
        end
        object db_PRODN2: TLabeledEdit
          Left = 6
          Top = 258
          Width = 200
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'PRODN2'
          MaxLength = 40
          TabOrder = 12
        end
        object db_PRODN4: TLabeledEdit
          Left = 6
          Top = 336
          Width = 200
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'PRODN4'
          MaxLength = 40
          TabOrder = 14
        end
        object db_taxclass: TComboBox
          Left = 6
          Top = 379
          Width = 114
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
          TabOrder = 15
        end
        object db_sellat: TMaskEdit
          Tag = 4
          Left = 279
          Top = 94
          Width = 85
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          Color = 14933503
          EditMask = '#####.##;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 8
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Text = '     .  '
        end
        object db_ycost: TMaskEdit
          Tag = 4
          Left = 97
          Top = 94
          Width = 85
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          Color = 14933503
          EditMask = '#####.##;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 8
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Text = '     .  '
        end
      end
      inherited ToolBar: TToolBar
        Width = 458
        ExplicitWidth = 458
      end
      inherited StatusBar: TStatusBar
        Top = 483
        Width = 458
        ExplicitTop = 483
        ExplicitWidth = 458
      end
    end
  end
end
