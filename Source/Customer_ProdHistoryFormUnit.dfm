inherited Customer_ProdHistoryForm: TCustomer_ProdHistoryForm
  Caption = 'Customer_ProdHistoryForm'
  ClientHeight = 440
  ClientWidth = 680
  ExplicitWidth = 682
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 680
    Height = 440
    ExplicitWidth = 680
    ExplicitHeight = 440
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 678
      Height = 438
      ExplicitWidth = 678
      ExplicitHeight = 438
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 678
        ExplicitTop = 0
        ExplicitWidth = 678
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 672
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 76
        Width = 678
        Height = 341
        ExplicitLeft = 0
        ExplicitTop = 76
        ExplicitWidth = 678
        ExplicitHeight = 341
        object VIEWGRID_DOCK_PANEL: TPanel
          Left = 1
          Top = 57
          Width = 676
          Height = 283
          Align = alClient
          Caption = 'VIEWGRID_DOCK_PANEL'
          Color = clActiveCaption
          ParentBackground = False
          TabOrder = 0
        end
        object BASE_NAVBAR_PANEL: TPanel
          Left = 1
          Top = 1
          Width = 676
          Height = 56
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          Ctl3D = True
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 1
          object SortByLabel: TLabel
            Left = 8
            Top = 8
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
          object SortViewLabel: TLabel
            Left = 18
            Top = 31
            Width = 44
            Height = 14
            Caption = 'Order:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object BASE_NAVBAR_DOCK_PANEL: TPanel
            Left = 526
            Top = 0
            Width = 150
            Height = 56
            Align = alRight
            BevelOuter = bvNone
            Caption = 'BASE_NAVBAR_DOCK_PANEL'
            Color = clWhite
            Ctl3D = False
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
            ExplicitLeft = 524
          end
          object SortByComboBox: TComboBox
            Left = 64
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
            Text = 'DATE'
            OnChange = SortByComboBoxChange
            Items.Strings = (
              'DATE'
              'PRODUCT NUMBER'
              'PRODUCT NAME'
              'SALES CYCLE')
          end
          object SortViewComboBox: TComboBox
            Left = 64
            Top = 27
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
            OnChange = SortViewComboBoxChange
            Items.Strings = (
              'LAST TO FIRST'
              'FIRST TO LAST')
          end
        end
      end
      inherited StatusBar: TStatusBar [2]
        Top = 417
        Width = 678
        ExplicitTop = 417
        ExplicitWidth = 678
      end
      inherited ToolBar: TToolBar [3]
        Width = 678
        Height = 56
        ButtonHeight = 56
        TabOrder = 3
        ExplicitWidth = 678
        ExplicitHeight = 56
      end
    end
  end
end
