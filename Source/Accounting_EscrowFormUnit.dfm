inherited AccountingEscrowForm: TAccountingEscrowForm
  Caption = 'AccountingEscrowForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited border_panel: TPanel
    inherited BASE_NAVBAR_PANEL: TPanel
      Top = 70
      ExplicitTop = 70
      object sortViewLabel: TLabel [0]
        Left = 4
        Top = 7
        Width = 70
        Height = 14
        Caption = 'Sort View:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object activityLabel: TLabel [1]
        Left = 18
        Top = 31
        Width = 55
        Height = 14
        Caption = 'Activity:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SortViewComboBox: TComboBox
        Left = 78
        Top = 4
        Width = 128
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
        Text = 'ACENDING'
        OnChange = SortViewComboBoxChange
        Items.Strings = (
          'ACENDING'
          'DECENDING')
      end
      object ActiveComboBox: TComboBox
        Left = 78
        Top = 28
        Width = 128
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
        TabOrder = 2
        Text = 'ACTIVE'
        OnChange = ActiveComboBoxChange
        Items.Strings = (
          'ACTIVE'
          'INACTIVE'
          'ALL')
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Top = 126
      Height = 222
      ExplicitTop = 126
      ExplicitHeight = 222
    end
    object MENU_DOCK_PANEL: TPanel
      Left = 0
      Top = 20
      Width = 586
      Height = 50
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 4
    end
  end
end
