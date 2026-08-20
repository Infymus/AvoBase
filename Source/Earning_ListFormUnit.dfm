inherited EarningListForm: TEarningListForm
  Caption = 'EarningListForm'
  ExplicitWidth = 671
  ExplicitHeight = 444
  PixelsPerInch = 96
  TextHeight = 13
  inherited border_panel: TPanel
    inherited BASE_TOP_CAPTION_PANEL: TPanel
      inherited BASE_FORM_LABEL: TLabel
        Width = 655
      end
    end
    inherited BASE_NAVBAR_PANEL: TPanel
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
        Left = 515
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
        Font.Color = clWindowText
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
  end
end
