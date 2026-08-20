inherited Pref_FeeEditForm: TPref_FeeEditForm
  Caption = 'Pref_FeeEditForm'
  ClientHeight = 339
  ClientWidth = 382
  ExplicitWidth = 384
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 382
    Height = 339
    ExplicitWidth = 382
    ExplicitHeight = 339
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 380
      Height = 337
      ExplicitWidth = 380
      ExplicitHeight = 337
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 380
        ExplicitWidth = 380
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 380
        Height = 242
        Caption = ''
        ExplicitWidth = 380
        ExplicitHeight = 242
        object samtLabel: TLabel
          Left = 7
          Top = 151
          Width = 37
          Height = 13
          Caption = 'Amount'
        end
        object Label1: TLabel
          Left = 6
          Top = 30
          Width = 61
          Height = 13
          Caption = 'Organization'
        end
        object Label3: TLabel
          Left = 6
          Top = 195
          Width = 54
          Height = 13
          Caption = 'Tax Group:'
        end
        object db_amount: TMaskEdit
          Tag = 4
          Left = 6
          Top = 168
          Width = 76
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
        object db_desc: TLabeledEdit
          Left = 7
          Top = 124
          Width = 361
          Height = 21
          EditLabel.Width = 74
          EditLabel.Height = 13
          EditLabel.Caption = 'Fee Description'
          MaxLength = 200
          TabOrder = 5
        end
        object db_name: TLabeledEdit
          Left = 6
          Top = 84
          Width = 361
          Height = 21
          EditLabel.Width = 48
          EditLabel.Height = 13
          EditLabel.Caption = 'Fee Name'
          MaxLength = 50
          TabOrder = 4
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
        object db_active: TCheckBox
          Left = 6
          Top = 3
          Width = 82
          Height = 17
          Caption = 'Fee Is Active'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object db_autoinv: TCheckBox
          Left = 220
          Top = 17
          Width = 129
          Height = 26
          Caption = 'Fee is Automatically Added to Org Invoices'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          WordWrap = True
        end
        object db_autoret: TCheckBox
          Left = 220
          Top = 44
          Width = 129
          Height = 26
          Caption = 'Fee is Automatically Added to Org Returns'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          WordWrap = True
        end
        object db_taxclass: TComboBox
          Left = 6
          Top = 210
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
          TabOrder = 7
        end
      end
      inherited ToolBar: TToolBar
        Width = 380
        ExplicitWidth = 380
      end
      inherited StatusBar: TStatusBar
        Top = 316
        Width = 380
        ExplicitTop = 316
        ExplicitWidth = 380
      end
    end
  end
end
