inherited CycleListForm: TCycleListForm
  Left = 348
  Top = 22
  Caption = 'CycleListForm'
  ClientHeight = 335
  ClientWidth = 587
  OldCreateOrder = True
  WindowState = wsMinimized
  ExplicitWidth = 587
  ExplicitHeight = 335
  PixelsPerInch = 96
  TextHeight = 13
  inherited border_panel: TPanel
    Width = 587
    Height = 335
    ExplicitWidth = 587
    ExplicitHeight = 335
    inherited BASE_TOP_CAPTION_PANEL: TPanel
      Width = 587
      ExplicitWidth = 587
    end
    inherited StatusBar: TStatusBar
      Top = 314
      Width = 587
      ExplicitTop = 314
      ExplicitWidth = 587
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Width = 587
      ExplicitWidth = 587
      object Label1: TLabel [0]
        Left = 7
        Top = 7
        Width = 71
        Height = 14
        Caption = 'Show Org:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel [1]
        Left = 7
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
      object Label3: TLabel [2]
        Left = 230
        Top = 7
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
        Left = 437
        Width = 150
        Caption = ''
        ExplicitLeft = 437
        ExplicitWidth = 150
      end
      object orgComboBox: TComboBox
        Left = 80
        Top = 4
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
        Text = 'CYCLE'
        OnChange = SortComboBoxChange
        Items.Strings = (
          'CYCLE'
          'ORG'
          'START DATE'
          'END DATE'
          '')
      end
      object SortViewComboBox: TComboBox
        Left = 80
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
        TabOrder = 2
        Text = 'LAST TO FIRST'
        OnChange = SortComboBoxChange
        Items.Strings = (
          'LAST TO FIRST'
          'FIRST TO LAST')
      end
      object SortByComboBox: TComboBox
        Left = 287
        Top = 4
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
        TabOrder = 3
        Text = 'CYCLE'
        OnChange = SortComboBoxChange
        Items.Strings = (
          'CYCLE'
          'ORG'
          'START DATE'
          'END DATE'
          '')
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Width = 587
      Height = 238
      Color = clPurple
      ExplicitWidth = 587
      ExplicitHeight = 238
    end
  end
end
