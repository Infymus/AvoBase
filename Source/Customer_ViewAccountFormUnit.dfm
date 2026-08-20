inherited Customer_AccountViewForm: TCustomer_AccountViewForm
  Left = 365
  Top = 11
  Caption = 'Customer_AccountViewForm'
  ClientHeight = 606
  ClientWidth = 615
  ExplicitWidth = 617
  ExplicitHeight = 608
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 615
    Height = 606
    ExplicitWidth = 615
    ExplicitHeight = 606
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 613
      Height = 604
      ExplicitWidth = 613
      ExplicitHeight = 604
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 613
        ExplicitTop = 0
        ExplicitWidth = 613
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 607
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 613
        Height = 509
        ExplicitLeft = 0
        ExplicitTop = 74
        ExplicitWidth = 613
        ExplicitHeight = 509
        object VIEWGRID_DOCK_PANEL: TPanel
          Left = 1
          Top = 249
          Width = 611
          Height = 259
          Align = alBottom
          Caption = 'VIEWGRID_DOCK_PANEL'
          Color = clActiveCaption
          ParentBackground = False
          TabOrder = 0
        end
        object BASE_NAVBAR_PANEL: TPanel
          Left = 1
          Top = 193
          Width = 611
          Height = 56
          Align = alBottom
          BevelOuter = bvNone
          Color = clWhite
          Ctl3D = True
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 1
          object BASE_NAVBAR_DOCK_PANEL: TPanel
            Left = 459
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
        end
        object addresGroupBox: TGroupBox
          Left = 1
          Top = 1
          Width = 611
          Height = 143
          Align = alTop
          Caption = 'Customer Transaction History'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentColor = False
          ParentFont = False
          TabOrder = 2
          object addr1Label: TLabel
            Left = 49
            Top = 18
            Width = 132
            Height = 13
            Caption = 'TOTAL ORDERS PLACED:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object db_totorders: TLabel
            Left = 187
            Top = 18
            Width = 24
            Height = 13
            Caption = '000'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Label2: TLabel
            Left = 43
            Top = 39
            Width = 138
            Height = 13
            Caption = 'TOTAL RETURNS PLACED:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object db_returns: TLabel
            Left = 187
            Top = 39
            Width = 24
            Height = 13
            Caption = '000'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Label4: TLabel
            Left = 9
            Top = 59
            Width = 172
            Height = 13
            Caption = 'TOTAL ORDER CANCELLATIONS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object db_cancel: TLabel
            Left = 187
            Top = 59
            Width = 24
            Height = 13
            Caption = '000'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object DB_AmountVoid: TLabel
            Left = 545
            Top = 57
            Width = 60
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object DB_AmountMOP: TLabel
            Left = 545
            Top = 27
            Width = 60
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object db_totowed: TLabel
            Left = 545
            Top = 122
            Width = 60
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object db_AmountOrder: TLabel
            Left = 545
            Top = 12
            Width = 60
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object SalesTaxLabel: TLabel
            Left = 340
            Top = 12
            Width = 200
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'ORDER AMOUNTS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object InvoiceTotalLabel: TLabel
            Left = 340
            Top = 57
            Width = 200
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'TOTAL VOIDED PAYMENTS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PaymentsLabel: TLabel
            Left = 340
            Top = 27
            Width = 200
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'TOTAL PAYMENTS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object AmountDueLabel: TLabel
            Left = 340
            Top = 122
            Width = 200
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'TOTAL AMOUNT OWED:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label1: TLabel
            Left = 340
            Top = 42
            Width = 200
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'TOTAL REFUNDS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object db_AmountReturn: TLabel
            Left = 545
            Top = 42
            Width = 60
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Label3: TLabel
            Left = 340
            Top = 107
            Width = 200
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'TOTAL ESCROW BALANCE:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DB_AmountEscrow: TLabel
            Left = 545
            Top = 107
            Width = 60
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Label5: TLabel
            Left = 340
            Top = 72
            Width = 200
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'TRANSACTION CREDITS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DB_AmountTransCredit: TLabel
            Left = 545
            Top = 72
            Width = 60
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Label7: TLabel
            Left = 340
            Top = 87
            Width = 200
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'TRANSACTION DEBITS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DB_AmountTransDebit: TLabel
            Left = 545
            Top = 87
            Width = 60
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
        end
        object GroupBox1: TGroupBox
          Left = 1
          Top = 144
          Width = 611
          Height = 48
          Align = alTop
          Caption = 'Grid Options'
          TabOrder = 3
          object sortLabel: TLabel
            Left = 16
            Top = 20
            Width = 27
            Height = 13
            Caption = 'Sort:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SortViewComboBox: TComboBox
            Left = 49
            Top = 17
            Width = 109
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
            Text = 'LAST TO FIRST'
            OnChange = SortViewComboBoxChange
            Items.Strings = (
              'LAST TO FIRST'
              'FIRST TO LAST')
          end
        end
      end
      inherited ToolBar: TToolBar
        Width = 613
        ExplicitWidth = 613
      end
      inherited StatusBar: TStatusBar
        Top = 583
        Width = 613
        ExplicitTop = 583
        ExplicitWidth = 613
      end
    end
  end
end
