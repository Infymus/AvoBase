inherited Pref_TaxEditForm: TPref_TaxEditForm
  Left = 339
  Top = 309
  Caption = 'Pref_TaxEditForm'
  ClientHeight = 255
  ClientWidth = 377
  OnShow = FormShow
  ExplicitWidth = 379
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 377
    Height = 255
    ExplicitWidth = 377
    ExplicitHeight = 255
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 375
      Height = 253
      Caption = ''
      ExplicitWidth = 375
      ExplicitHeight = 253
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 375
        ExplicitWidth = 375
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 375
        Height = 158
        Caption = ''
        ExplicitWidth = 375
        ExplicitHeight = 158
        object samtLabel: TLabel
          Left = 117
          Top = 113
          Width = 78
          Height = 13
          Caption = 'Starting Amount'
        end
        object eamtLabel: TLabel
          Left = 204
          Top = 113
          Width = 72
          Height = 13
          Caption = 'Ending Amount'
        end
        object rateLabel: TLabel
          Left = 291
          Top = 113
          Width = 44
          Height = 13
          Caption = 'Tax Rate'
        end
        object pcntLabel: TLabel
          Left = 336
          Top = 133
          Width = 13
          Height = 13
          Caption = '%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 5
          Top = 113
          Width = 45
          Height = 13
          Caption = 'Tax Type'
        end
        object db_name: TLabeledEdit
          Left = 6
          Top = 42
          Width = 361
          Height = 21
          EditLabel.Width = 48
          EditLabel.Height = 13
          EditLabel.Caption = 'Tax Name'
          MaxLength = 50
          TabOrder = 1
        end
        object db_active: TCheckBox
          Left = 6
          Top = 3
          Width = 115
          Height = 17
          Caption = 'Tax Rate Is Active'
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
          Top = 87
          Width = 361
          Height = 21
          EditLabel.Width = 74
          EditLabel.Height = 13
          EditLabel.Caption = 'Tax Description'
          MaxLength = 200
          TabOrder = 2
        end
        object db_samt: TMaskEdit
          Tag = 4
          Left = 117
          Top = 129
          Width = 81
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          BorderStyle = bsNone
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
          TabOrder = 4
          Text = '     .  '
        end
        object db_eamt: TMaskEdit
          Tag = 4
          Left = 204
          Top = 129
          Width = 81
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
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
        object db_rate: TMaskEdit
          Tag = 4
          Left = 291
          Top = 129
          Width = 42
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          BorderStyle = bsNone
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
          TabOrder = 6
          Text = '  .  '
        end
        object taxTypeCombo: TComboBox
          Left = 6
          Top = 129
          Width = 105
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ItemIndex = 0
          ParentFont = False
          TabOrder = 3
          Text = 'Simple'
          Items.Strings = (
            'Simple'
            'Compound')
        end
      end
      inherited ToolBar: TToolBar
        Width = 375
        ExplicitWidth = 375
      end
      inherited StatusBar: TStatusBar
        Top = 232
        Width = 375
        ExplicitTop = 232
        ExplicitWidth = 375
      end
    end
  end
end
