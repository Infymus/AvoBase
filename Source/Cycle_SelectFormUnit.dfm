inherited Cycle_SelectForm: TCycle_SelectForm
  Caption = 'Cycle_SelectForm'
  ClientHeight = 578
  ClientWidth = 490
  ExplicitWidth = 490
  ExplicitHeight = 578
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASE_BACK_PANEL: TPanel
    Width = 490
    Height = 578
    ExplicitWidth = 490
    ExplicitHeight = 578
    inherited BASE_FORM_TOP_PANEL: TPanel
      Width = 488
      ExplicitWidth = 488
      inherited BASE_FORM_CAPTION_LABEL: TLabel
        Width = 482
        Height = 20
      end
    end
    inherited StatusBar: TStatusBar
      Top = 556
      Width = 488
      ExplicitTop = 556
      ExplicitWidth = 488
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Width = 488
      ExplicitWidth = 488
      inherited BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 336
        ExplicitLeft = 336
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Top = 103
      Width = 488
      Height = 453
      ExplicitTop = 103
      ExplicitWidth = 488
      ExplicitHeight = 453
    end
    inherited OPTION_DOCK: TPanel
      Width = 488
      Height = 26
      Caption = ''
      ExplicitWidth = 488
      ExplicitHeight = 26
      object selectLabel: TLabel
        Left = 3
        Top = 5
        Width = 87
        Height = 13
        Caption = 'Organization:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object OrgCombo: TComboBox
        Left = 94
        Top = 2
        Width = 179
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
        TabOrder = 0
        Text = 'ACTIVE'
        OnChange = OrgComboChange
        Items.Strings = (
          'ACTIVE'
          'INACTIVE'
          'ALL')
      end
    end
  end
end
