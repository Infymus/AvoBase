inherited CustomerListForm: TCustomerListForm
  Left = 364
  Top = 4
  Caption = 'CustomerListForm'
  ClientHeight = 257
  ClientWidth = 431
  OldCreateOrder = True
  ExplicitWidth = 431
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 13
  inherited border_panel: TPanel
    Width = 431
    Height = 257
    ExplicitWidth = 431
    ExplicitHeight = 257
    inherited BASE_TOP_CAPTION_PANEL: TPanel
      Width = 431
      ExplicitWidth = 431
    end
    inherited StatusBar: TStatusBar
      Top = 236
      Width = 431
      ExplicitTop = 236
      ExplicitWidth = 431
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Width = 431
      ExplicitWidth = 431
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
      inherited BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 281
        Width = 150
        Caption = ''
        ExplicitLeft = 331
        ExplicitWidth = 150
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
        OnChange = EventUpdateQuery
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
        OnChange = EventUpdateQuery
        Items.Strings = (
          'ACTIVE'
          'INACTIVE'
          'ALL')
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Width = 431
      Height = 160
      ExplicitWidth = 431
      ExplicitHeight = 160
    end
  end
end
