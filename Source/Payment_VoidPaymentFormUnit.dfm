inherited Payment_VoidPaymentForm: TPayment_VoidPaymentForm
  Caption = 'Payment_VoidPaymentForm'
  ClientHeight = 356
  ClientWidth = 589
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 591
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 589
    Height = 356
    ExplicitWidth = 589
    ExplicitHeight = 356
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 587
      Height = 354
      ExplicitWidth = 587
      ExplicitHeight = 354
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 587
        ExplicitWidth = 587
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 587
        Height = 259
        Caption = ''
        ExplicitWidth = 587
        ExplicitHeight = 259
        object MOP_DOCK_PANEL: TPanel
          Left = 1
          Top = 149
          Width = 585
          Height = 109
          Align = alBottom
          BevelOuter = bvNone
          BorderWidth = 1
          Color = clMoneyGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object GroupBox1: TGroupBox
          Left = 1
          Top = 85
          Width = 585
          Height = 64
          Align = alBottom
          Caption = 'Void Payment Details'
          TabOrder = 1
          object Label2: TLabel
            Left = 10
            Top = 18
            Width = 59
            Height = 14
            Caption = 'VOID DATE:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label1: TLabel
            Left = 115
            Top = 18
            Width = 99
            Height = 14
            Caption = 'REASON FOR VOID:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object db_voidreason: TComboBox
            Left = 115
            Top = 34
            Width = 213
            Height = 22
            BevelInner = bvLowered
            Style = csOwnerDrawFixed
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 16
            ParentFont = False
            TabOrder = 0
          end
          object db_voiddate: TDateTimePicker
            Left = 9
            Top = 33
            Width = 96
            Height = 19
            Date = 40904.351171550920000000
            Time = 40904.351171550920000000
            TabOrder = 1
          end
        end
        object GroupBox2: TGroupBox
          Left = 1
          Top = 1
          Width = 585
          Height = 86
          Align = alTop
          Caption = 'Customer'
          TabOrder = 2
          object CustSoldToName: TLabel
            Tag = 1
            Left = 9
            Top = 15
            Width = 150
            Height = 18
            Caption = 'CustSoldToName'
            Color = clSkyBlue
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object CustSoldToAddress: TLabel
            Left = 27
            Top = 35
            Width = 140
            Height = 16
            Caption = 'CustSoldToAddress'
            Color = clSkyBlue
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 64
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object CustSoldToCityStateZip: TLabel
            Left = 27
            Top = 51
            Width = 171
            Height = 16
            Caption = 'CustSoldToCityStateZip'
            Color = clSkyBlue
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 64
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object CustSoldToPhone: TLabel
            Left = 27
            Top = 66
            Width = 126
            Height = 16
            Caption = 'CustSoldToPhone'
            Color = clSkyBlue
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 64
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
        end
      end
      inherited ToolBar: TToolBar
        Width = 587
        ExplicitWidth = 587
      end
      inherited StatusBar: TStatusBar
        Top = 333
        Width = 587
        ExplicitTop = 333
        ExplicitWidth = 587
      end
    end
  end
end
