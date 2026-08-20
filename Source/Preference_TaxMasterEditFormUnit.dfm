inherited Pref_TaxMasterEditForm: TPref_TaxMasterEditForm
  Caption = 'Pref_TaxMasterEditForm'
  ClientHeight = 217
  ClientWidth = 375
  OnShow = FormShow
  ExplicitWidth = 377
  ExplicitHeight = 219
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 375
    Height = 217
    ExplicitWidth = 375
    ExplicitHeight = 217
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 373
      Height = 215
      Caption = ''
      ExplicitWidth = 373
      ExplicitHeight = 215
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 373
        ExplicitWidth = 373
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 373
        Height = 120
        Caption = ''
        ExplicitWidth = 373
        ExplicitHeight = 120
        object db_active: TCheckBox
          Left = 6
          Top = 3
          Width = 139
          Height = 17
          Caption = 'Tax Group Active'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object db_name: TLabeledEdit
          Left = 6
          Top = 42
          Width = 361
          Height = 21
          EditLabel.Width = 80
          EditLabel.Height = 13
          EditLabel.Caption = 'Tax Group Name'
          MaxLength = 50
          TabOrder = 1
        end
        object db_desc: TLabeledEdit
          Left = 6
          Top = 87
          Width = 361
          Height = 21
          EditLabel.Width = 106
          EditLabel.Height = 13
          EditLabel.Caption = 'Tax Group Description'
          MaxLength = 200
          TabOrder = 2
        end
      end
      inherited ToolBar: TToolBar
        Width = 373
        ExplicitWidth = 373
      end
      inherited StatusBar: TStatusBar
        Top = 194
        Width = 373
        ExplicitTop = 194
        ExplicitWidth = 373
      end
    end
  end
end
