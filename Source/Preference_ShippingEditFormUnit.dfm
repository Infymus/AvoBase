inherited Pref_ShippingEditForm: TPref_ShippingEditForm
  Left = 347
  Top = 307
  Caption = 'Pref_ShippingEditForm'
  ClientHeight = 345
  ClientWidth = 542
  ExplicitWidth = 544
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 542
    Height = 345
    ExplicitWidth = 542
    ExplicitHeight = 345
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 540
      Height = 343
      ExplicitWidth = 540
      ExplicitHeight = 343
      inherited BASE_FORM_TOP_PANEL: TPanel
        Top = 36
        Width = 540
        ExplicitTop = 36
        ExplicitWidth = 540
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 56
        Width = 540
        Height = 266
        Caption = ''
        ExplicitTop = 56
        ExplicitWidth = 540
        ExplicitHeight = 266
        object samtLabel: TLabel
          Left = 114
          Top = 159
          Width = 78
          Height = 13
          Caption = 'Starting Amount'
        end
        object eamtLabel: TLabel
          Left = 204
          Top = 159
          Width = 72
          Height = 13
          Caption = 'Ending Amount'
        end
        object rateLabel: TLabel
          Left = 294
          Top = 159
          Width = 23
          Height = 13
          Caption = 'Rate'
        end
        object Label1: TLabel
          Left = 6
          Top = 30
          Width = 61
          Height = 13
          Caption = 'Organization'
        end
        object Label2: TLabel
          Left = 6
          Top = 159
          Width = 67
          Height = 13
          Caption = 'Shipping Type'
        end
        object shippingAmountLabel: TLabel
          Left = 366
          Top = 159
          Width = 37
          Height = 13
          Caption = 'Amount'
        end
        object pcntLabel: TLabel
          Left = 346
          Top = 178
          Width = 11
          Height = 13
          Caption = '%'
        end
        object Label3: TLabel
          Left = 6
          Top = 207
          Width = 54
          Height = 13
          Caption = 'Tax Group:'
        end
        object db_samt: TMaskEdit
          Tag = 4
          Left = 114
          Top = 174
          Width = 79
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
        object db_eamt: TMaskEdit
          Tag = 4
          Left = 204
          Top = 174
          Width = 80
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
        object db_rate: TMaskEdit
          Tag = 4
          Left = 294
          Top = 174
          Width = 52
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          Color = 14933503
          EditMask = '##.##;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Text = '  .  '
        end
        object db_name: TLabeledEdit
          Left = 6
          Top = 84
          Width = 361
          Height = 21
          EditLabel.Width = 70
          EditLabel.Height = 13
          EditLabel.Caption = 'Shipping Name'
          MaxLength = 50
          TabOrder = 2
        end
        object db_active: TCheckBox
          Left = 6
          Top = 3
          Width = 133
          Height = 17
          Caption = 'Shipping Rate Is Active'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object db_desc: TLabeledEdit
          Left = 6
          Top = 130
          Width = 361
          Height = 21
          EditLabel.Width = 96
          EditLabel.Height = 13
          EditLabel.Caption = 'Shipping Description'
          MaxLength = 200
          TabOrder = 3
        end
        object orgCombo: TComboBox
          Left = 6
          Top = 46
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
        end
        object shippingTypeCombo: TComboBox
          Left = 6
          Top = 174
          Width = 97
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
          TabOrder = 4
          OnChange = shippingTypeComboChange
          Items.Strings = (
            'Rate'
            'Amount')
        end
        object db_amount: TMaskEdit
          Tag = 4
          Left = 366
          Top = 174
          Width = 80
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
          TabOrder = 8
          Text = '     .  '
        end
        object db_taxclass: TComboBox
          Left = 6
          Top = 222
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
          TabOrder = 9
        end
      end
      inherited ToolBar: TToolBar
        Top = 0
        Width = 540
        Height = 36
        ButtonHeight = 36
        ExplicitTop = 0
        ExplicitWidth = 540
        ExplicitHeight = 36
      end
      inherited StatusBar: TStatusBar
        Top = 322
        Width = 540
        ExplicitTop = 322
        ExplicitWidth = 540
      end
    end
  end
end
