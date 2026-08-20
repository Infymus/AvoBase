inherited Pref_EarningTypeEditForm: TPref_EarningTypeEditForm
  Caption = 'Pref_EarningTypeEditForm'
  ClientHeight = 319
  ClientWidth = 376
  ExplicitWidth = 378
  ExplicitHeight = 321
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 376
    Height = 319
    ExplicitWidth = 376
    ExplicitHeight = 248
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 374
      Height = 317
      ExplicitWidth = 374
      ExplicitHeight = 246
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 374
        ExplicitWidth = 374
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 374
        Height = 222
        ExplicitWidth = 374
        ExplicitHeight = 151
        object Label1: TLabel
          Left = 6
          Top = 30
          Width = 61
          Height = 13
          Caption = 'Organization'
        end
        object db_active: TCheckBox
          Left = 6
          Top = 3
          Width = 133
          Height = 17
          Caption = 'Earning Type Is Active'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
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
        object db_autoinv: TCheckBox
          Left = 13
          Top = 154
          Width = 168
          Height = 60
          Caption = 
            'Earning Type is Automatically Added to New Sales Cycle Earning L' +
            'ists'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          WordWrap = True
        end
        object db_name: TLabeledEdit
          Left = 6
          Top = 84
          Width = 361
          Height = 21
          EditLabel.Width = 93
          EditLabel.Height = 13
          EditLabel.Caption = 'Earning Type Name'
          MaxLength = 40
          TabOrder = 3
        end
        object db_desc: TLabeledEdit
          Left = 7
          Top = 124
          Width = 361
          Height = 21
          EditLabel.Width = 119
          EditLabel.Height = 13
          EditLabel.Caption = 'Earning Type Description'
          MaxLength = 200
          TabOrder = 4
        end
      end
      inherited ToolBar: TToolBar
        Width = 374
        ExplicitWidth = 374
      end
      inherited StatusBar: TStatusBar
        Top = 296
        Width = 374
        ExplicitTop = 225
        ExplicitWidth = 374
      end
    end
  end
end
