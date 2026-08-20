inherited Product_ImportProductForm: TProduct_ImportProductForm
  Caption = 'Product_ImportProductForm'
  ClientHeight = 598
  ClientWidth = 798
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 798
    Height = 598
    ExplicitWidth = 798
    ExplicitHeight = 598
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 796
      Height = 596
      Caption = ''
      ExplicitWidth = 796
      ExplicitHeight = 596
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 796
        ExplicitWidth = 796
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 241
        Width = 796
        Height = 334
        Caption = 'PRODUCT_IMPORT_LINE_ITEMS'
        ExplicitTop = 241
        ExplicitWidth = 796
        ExplicitHeight = 334
        object LineItemToolBar_DOCK: TPanel
          Left = 1
          Top = 13
          Width = 40
          Height = 320
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
        end
        object db_scrollbox: TScrollBox
          Left = 41
          Top = 13
          Width = 754
          Height = 320
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWhite
          ParentColor = False
          TabOrder = 1
        end
        object product_header_panel: TPanel
          Left = 1
          Top = 1
          Width = 794
          Height = 12
          Align = alTop
          TabOrder = 2
          object Label3: TLabel
            Left = 139
            Top = -2
            Width = 99
            Height = 13
            Caption = 'PRODUCT NAME'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RetailCostLabel: TLabel
            Left = 562
            Top = -2
            Width = 87
            Height = 13
            Caption = 'RETAIL COST:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 61
            Top = -2
            Width = 72
            Height = 13
            Caption = 'PRODUCT #'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 420
            Top = -2
            Width = 47
            Height = 13
            Caption = 'QTY OH'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 477
            Top = -2
            Width = 75
            Height = 13
            Caption = 'YOUR COST:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      inherited ToolBar: TToolBar
        Width = 796
        ExplicitWidth = 796
      end
      inherited StatusBar: TStatusBar
        Top = 575
        Width = 796
        ExplicitTop = 575
        ExplicitWidth = 796
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 74
        Width = 796
        Height = 167
        Align = alTop
        TabOrder = 4
        object orgLabel: TLabel
          Left = 7
          Top = 79
          Width = 80
          Height = 14
          Caption = 'ORGANIZATION'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 8
          Top = 57
          Width = 321
          Height = 13
          Caption = 'Organization and Sales Cycle to tie imported Products to:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object campYearLabel: TLabel
          Left = 225
          Top = 79
          Width = 67
          Height = 14
          Caption = 'CYCLE YEAR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object CycleNumLabel: TLabel
          Left = 305
          Top = 78
          Width = 63
          Height = 14
          Caption = 'CYCLE NUM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 7
          Top = 120
          Width = 314
          Height = 13
          Caption = 'Note: Only Organizations and Sales Cycles created will be shown.'
        end
        object db_confirmdelete: TCheckBox
          Left = 8
          Top = 143
          Width = 155
          Height = 17
          Caption = 'Don'#39't Confirm Deleting Items'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object db_addr1: TLabeledEdit
          Left = 5
          Top = 18
          Width = 426
          Height = 21
          EditLabel.Width = 54
          EditLabel.Height = 13
          EditLabel.Caption = 'Filename:'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Tahoma'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 1
        end
        object orgCombo: TComboBox
          Left = 7
          Top = 95
          Width = 208
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 2
          OnChange = orgComboChange
        end
        object CycleYearComboBox: TComboBox
          Left = 225
          Top = 95
          Width = 69
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 3
          OnChange = CycleYearComboBoxChange
        end
        object CycleNumComboBox: TComboBox
          Left = 305
          Top = 95
          Width = 70
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 4
        end
        object OpenFileButton: TBitBtn
          Left = 437
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Select File'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 5
        end
        object GroupBox2: TGroupBox
          Left = 525
          Top = 6
          Width = 259
          Height = 148
          Caption = 'Options'
          TabOrder = 6
          object CheckBox1: TCheckBox
            Left = 15
            Top = 19
            Width = 155
            Height = 17
            Caption = 'Overwrite Existing Products'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
  end
end
