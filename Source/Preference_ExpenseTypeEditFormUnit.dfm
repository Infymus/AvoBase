inherited Pref_ExpenseTypeEditForm: TPref_ExpenseTypeEditForm
  Caption = 'Pref_ExpenseTypeEditForm'
  ClientHeight = 317
  ClientWidth = 377
  ExplicitWidth = 379
  ExplicitHeight = 319
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 377
    Height = 317
    ExplicitWidth = 377
    ExplicitHeight = 317
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 375
      Height = 315
      ExplicitWidth = 375
      ExplicitHeight = 315
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 375
        ExplicitWidth = 375
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 375
        Height = 220
        Caption = ''
        ExplicitWidth = 375
        ExplicitHeight = 220
        object Label1: TLabel
          Left = 6
          Top = 30
          Width = 61
          Height = 13
          Caption = 'Organization'
        end
        object db_desc: TLabeledEdit
          Left = 7
          Top = 124
          Width = 361
          Height = 21
          EditLabel.Width = 124
          EditLabel.Height = 13
          EditLabel.Caption = 'Expense Type Description'
          MaxLength = 200
          TabOrder = 3
        end
        object db_name: TLabeledEdit
          Left = 6
          Top = 84
          Width = 361
          Height = 21
          EditLabel.Width = 98
          EditLabel.Height = 13
          EditLabel.Caption = 'Expense Type Name'
          MaxLength = 40
          TabOrder = 2
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
          Width = 133
          Height = 17
          Caption = 'Expense Type Is Active'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object db_autoinv: TCheckBox
          Left = 10
          Top = 151
          Width = 168
          Height = 60
          Caption = 
            'Expense Type is Automatically Added to New Sales Cycle Expense L' +
            'ists'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          WordWrap = True
        end
        object db_taxdeduct: TCheckBox
          Left = 190
          Top = 151
          Width = 168
          Height = 60
          Caption = 
            'Expense Type is Tax Deductable - Will show on Tax Deduction Repo' +
            'rts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          WordWrap = True
        end
      end
      inherited ToolBar: TToolBar
        Width = 375
        ExplicitWidth = 375
      end
      inherited StatusBar: TStatusBar
        Top = 294
        Width = 375
        ExplicitTop = 294
        ExplicitWidth = 375
      end
    end
  end
end
