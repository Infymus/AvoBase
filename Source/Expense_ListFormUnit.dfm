inherited ExpenseListForm: TExpenseListForm
  Caption = 'ExpenseListForm'
  ClientHeight = 482
  ClientWidth = 805
  ExplicitWidth = 811
  ExplicitHeight = 511
  PixelsPerInch = 96
  TextHeight = 13
  inherited border_panel: TPanel
    Width = 805
    Height = 482
    ExplicitWidth = 665
    ExplicitHeight = 415
    inherited BASE_TOP_CAPTION_PANEL: TPanel
      Width = 805
      ExplicitWidth = 665
      inherited BASE_FORM_LABEL: TLabel
        Width = 795
      end
    end
    inherited StatusBar: TStatusBar
      Top = 461
      Width = 805
      Panels = <
        item
          Width = 150
        end
        item
          Width = 50
        end>
      ExplicitTop = 394
      ExplicitWidth = 665
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Width = 805
      ExplicitWidth = 665
      object Label2: TLabel [0]
        Left = 12
        Top = 8
        Width = 97
        Height = 14
        Caption = 'Organizations:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 655
        Width = 150
        Caption = ''
        ExplicitLeft = 515
        ExplicitWidth = 150
      end
      object OrgCombo: TComboBox
        Left = 115
        Top = 5
        Width = 145
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
        TabOrder = 1
        Text = 'ALL ORGANIZATIONS'
        OnChange = OrgComboChange
        Items.Strings = (
          'ALL ORGANIZATIONS')
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Width = 805
      Height = 385
      ExplicitWidth = 665
      ExplicitHeight = 318
    end
  end
end
