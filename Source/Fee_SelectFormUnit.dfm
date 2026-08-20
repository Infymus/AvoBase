inherited FeeSelectForm: TFeeSelectForm
  Caption = 'FeeSelectForm'
  ClientWidth = 496
  ExplicitWidth = 496
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASE_BACK_PANEL: TPanel
    Width = 496
    ExplicitWidth = 496
    inherited BASE_FORM_TOP_PANEL: TPanel
      Width = 494
      ExplicitWidth = 494
      inherited BASE_FORM_CAPTION_LABEL: TLabel
        Width = 488
        Height = 20
      end
    end
    inherited StatusBar: TStatusBar
      Width = 494
      ExplicitWidth = 494
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Width = 494
      ExplicitWidth = 494
      inherited BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 342
        Caption = ''
        ExplicitLeft = 342
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Width = 494
      Caption = ''
      ExplicitWidth = 494
    end
    inherited OPTION_DOCK: TPanel
      Width = 494
      Caption = ''
      ExplicitWidth = 494
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
