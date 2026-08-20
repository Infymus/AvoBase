inherited Payment_SelectPaymentForm: TPayment_SelectPaymentForm
  Caption = 'Payment_SelectPaymentForm'
  ClientWidth = 480
  ExplicitWidth = 480
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASE_BACK_PANEL: TPanel
    Width = 480
    ExplicitWidth = 480
    inherited BASE_FORM_TOP_PANEL: TPanel
      Width = 478
      ExplicitWidth = 478
    end
    inherited StatusBar: TStatusBar
      Width = 478
      ExplicitWidth = 478
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Width = 478
      ExplicitWidth = 478
      inherited BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 326
        ExplicitLeft = 326
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Top = 206
      Width = 478
      Height = 137
      ExplicitTop = 206
      ExplicitWidth = 478
      ExplicitHeight = 137
    end
    inherited OPTION_DOCK: TPanel
      Width = 478
      Height = 129
      Caption = ''
      ExplicitWidth = 478
      ExplicitHeight = 129
      object OrdPurchLabel: TLabel
        Left = 6
        Top = 0
        Width = 183
        Height = 18
        Caption = 'Order Purchased By:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object CustSoldToName: TLabel
        Tag = 1
        Left = 25
        Top = 25
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
        Top = 43
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
        Top = 58
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
        Top = 73
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
      object InvoiceTotalsPanel: TPanel
        Left = 268
        Top = 0
        Width = 210
        Height = 129
        Align = alRight
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object SubTotalLabel: TLabel
          Left = 1
          Top = 0
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'LINE ITEM SUBTOTAL:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object OrderProcLabel: TLabel
          Left = 1
          Top = 14
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'ORDER FEES:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object SalesTaxLabel: TLabel
          Left = 1
          Top = 46
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'SALES TAX:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object PaymentsLabel: TLabel
          Left = 1
          Top = 77
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'PAYMENTS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object AmountDueLabel: TLabel
          Left = 1
          Top = 109
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'CHANGE/OWED:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Amount_SubTotal: TLabel
          Left = 147
          Top = 0
          Width = 60
          Height = 16
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
        object Amount_Fees: TLabel
          Left = 147
          Top = 14
          Width = 60
          Height = 16
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
        object Amount_Tax: TLabel
          Left = 147
          Top = 46
          Width = 60
          Height = 16
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
        object InvoiceTotalLabel: TLabel
          Left = 1
          Top = 62
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'INVOICE TOTAL:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Amount_Total: TLabel
          Left = 147
          Top = 62
          Width = 60
          Height = 16
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
        object Amount_MOP: TLabel
          Left = 147
          Top = 76
          Width = 60
          Height = 16
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
        object Amount_Due: TLabel
          Left = 147
          Top = 109
          Width = 60
          Height = 16
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
        object ShippingLabel: TLabel
          Left = 1
          Top = 30
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'SHIPPING:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Amount_Shipping: TLabel
          Left = 147
          Top = 30
          Width = 60
          Height = 16
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
        object Label1: TLabel
          Left = 1
          Top = 93
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VOIDED PAYMENTS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object db_void: TLabel
          Left = 147
          Top = 93
          Width = 60
          Height = 16
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
        object Panel9: TPanel
          Left = 147
          Top = 59
          Width = 60
          Height = 2
          BevelInner = bvRaised
          BevelOuter = bvNone
          Color = clBlack
          TabOrder = 0
        end
      end
    end
    object bot_warning_panel: TPanel
      Left = 1
      Top = 343
      Width = 478
      Height = 17
      Align = alBottom
      Color = clWhite
      ParentBackground = False
      TabOrder = 5
      object voidWarningLabel: TLabel
        Left = 2
        Top = 1
        Width = 335
        Height = 15
        AutoSize = False
        Caption = 
          '* Note: Greyed out items have already been voided and cannot be ' +
          're-voided'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
      end
    end
  end
end
