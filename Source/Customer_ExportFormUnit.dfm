inherited Export_Customer: TExport_Customer
  Caption = 'Export_Customer'
  ClientHeight = 498
  ClientWidth = 798
  ExplicitWidth = 800
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 798
    Height = 498
    ExplicitWidth = 798
    ExplicitHeight = 498
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 796
      Height = 496
      ExplicitWidth = 796
      ExplicitHeight = 496
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 796
        ExplicitWidth = 796
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 796
        Height = 401
        ExplicitWidth = 796
        ExplicitHeight = 401
        object BASE_NAVBAR_PANEL: TPanel
          Left = 1
          Top = 35
          Width = 794
          Height = 56
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          Ctl3D = True
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 0
          object sortViewLabel: TLabel
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
          object activityLabel: TLabel
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
          object BASE_NAVBAR_DOCK_PANEL: TPanel
            Left = 642
            Top = 0
            Width = 152
            Height = 56
            Align = alRight
            BevelOuter = bvNone
            Caption = 'BASE_NAVBAR_DOCK_PANEL'
            Color = clWhite
            Ctl3D = False
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
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
            OnChange = UpdateEventQuery
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
            OnChange = UpdateEventQuery
            Items.Strings = (
              'ACTIVE'
              'INACTIVE'
              'ALL')
          end
        end
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 794
          Height = 34
          Align = alTop
          BevelOuter = bvNone
          Caption = 
            'Select the Activity and Sort View - then click Export for Export' +
            ' Types'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
        end
      end
      inherited ToolBar: TToolBar
        Width = 796
        ExplicitWidth = 796
      end
      inherited StatusBar: TStatusBar
        Top = 475
        Width = 796
        ExplicitTop = 475
        ExplicitWidth = 796
      end
    end
  end
  object SaveDialog: TSaveDialog
    Filter = 'Text Files|txt'
    Left = 30
    Top = 150
  end
end
