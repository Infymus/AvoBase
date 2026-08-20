inherited EmailListForm: TEmailListForm
  Caption = 'EmailListForm'
  ExplicitWidth = 586
  ExplicitHeight = 369
  PixelsPerInch = 96
  TextHeight = 13
  inherited border_panel: TPanel
    inherited BASE_TOP_CAPTION_PANEL: TPanel
      inherited BASE_FORM_LABEL: TLabel
        Width = 576
      end
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Height = 59
      ExplicitHeight = 59
      object Label4: TLabel [0]
        Left = 9
        Top = 32
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
      object Label3: TLabel [1]
        Left = 22
        Top = 9
        Width = 54
        Height = 14
        Caption = 'Sort By:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 436
        Width = 150
        Height = 59
        Caption = ''
        ExplicitLeft = 486
        ExplicitWidth = 150
        ExplicitHeight = 59
      end
      object SortViewComboBox: TComboBox
        Left = 82
        Top = 29
        Width = 142
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
        Text = 'LAST TO FIRST'
        OnChange = SortViewComboBoxChange
        Items.Strings = (
          'LAST TO FIRST'
          'FIRST TO LAST')
      end
      object SortByComboBox: TComboBox
        Left = 82
        Top = 6
        Width = 142
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
        Text = 'DATE'
        OnChange = SortByComboBoxChange
        Items.Strings = (
          'DATE'
          'STATUS')
      end
      object db_ShowDeleted: TCheckBox
        Left = 235
        Top = 19
        Width = 140
        Height = 17
        Caption = 'Show Deleted Emails'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = db_ShowDeletedClick
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Top = 79
      Height = 269
      ExplicitTop = 79
      ExplicitHeight = 269
    end
  end
end
