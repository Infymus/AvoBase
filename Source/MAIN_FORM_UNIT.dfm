object MainForm: TMainForm
  Left = 364
  Top = 23
  Caption = 'MainForm'
  ClientHeight = 420
  ClientWidth = 865
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BotSepPanel: TPanel
    Left = 0
    Top = 416
    Width = 865
    Height = 4
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
  end
  object AvoBaseRibbon: TRibbon
    Left = 0
    Top = 0
    Width = 865
    Height = 148
    ActionManager = AvoActionManager
    ApplicationMenu.Icon.Data = {
      0000010001002020000000000000A80C00001600000028000000200000004000
      00000100180000000000800C0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF0000FF0000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000FF0000FF0000FF0000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FF0000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000FF0000FF0000FF0000FF0000800000593F63706B72787579635669
      800000FF0000FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000FF0000FF0000FF0000800000675C6BD8D8D8FFFFFFFFFFFFFFFFFFFFFFFF
      EDEDED605564FF0000FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF0000FF
      0000FF0000FF0000800000A5A5A6FFFFFFFDFDFDF7F7F7FFFFFFFFFFFFFFFFFF
      FFFFFFF9F9F9503A59FF0000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF0000FF0000FF
      0000FF0000800000B3B3B3FFFFFFFFFFFFE2E2E2644F6DF8F8F8FFFFFFFFFFFF
      FFFFFFFFFFFFACACAC800000FF00008000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF0000FF0000FF0000FF
      0000FF0000827F83FFFFFFFFFFFFFFFFFFDBDADB69397D777179FFFFFFFFFFFF
      FFFFFFFFFFFFE3E3E3800000FF0000FF00008000000000000000000000000000
      00000000000000000000000000000000000000FF0000FF0000FF0000FF0000FF
      0000532A63F8F8F8FFFFFFFFFFFFFFFFFF807287C8C6C8F5F5F5E4E4E5FFFFFF
      FFFFFFFFFFFFECECEC800000FF0000FF0000FF00008000000000000000000000
      00000000000000000000000000000000FF0000FF0000FF0000FF0000FF0000FF
      0000838284FFFFFFFFFFFFFFFFFFEAEAEA503C586D6371FDFDFD7E7881A998B0
      FFFFFFFFFFFFD0D0D0800000FF0000FF0000FF0000FF00008000000000000000
      00000000000000000000000000000000FF0000FF0000FF0000FF0000FF000080
      0000C7C7C7FFFFFFFFFFFFFFFFFF8F8593B5B2B76A5B7084439E8629AB6E3486
      B4B2B4FFFFFF8C8C8CFF0000FF0000FF0000FF0000FF00008000000000000000
      00000000000000000000000000000000000000FF0000FF0000FF0000FF000080
      0000E6E6E6FFFFFFFFFFFFF4F4F4622F778632A88836A99D7DAAD2D1D2FDFDFD
      F0F0F0FBFBFB4A2857FF0000FF0000FF0000FF0000FF00000000000000000000
      00000000000000000000000000000000000000000000FF0000FF0000FF000080
      0000DEDEDEFFFFFFFFFFFFBEBCBF8D5AA2B2AAB5F7F7F7FFFFFFFFFFFFFFFFFF
      FFFFFF8D8C8E800000FF0000FF0000FF0000FF00000000000000000000000000
      00000000000000000000000000000000000000000000312D32FF0000FF000080
      0000A9A9A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      BEBEBE800000FF0000FF0000FF00008000000000000000000000000000000000
      000000000000000000000000000000000000006E6E6EF4F4F45F5662FF0000FF
      0000513A5AFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB2B2B2
      800000FF0000FF0000FF00008000000000000000000000000000000000000000
      00000000000000000000000000000000757575F9F9F9F4F4F4E6E6E64D3E53FF
      0000FF0000615865F0F0F0FFFFFFFFFFFFFFFFFFFFFFFFE3E3E36D6670FF0000
      FF0000FF0000FF00008000000000000000000000000000000000000000000000
      000000000000000000000000007E7E7EF9F9F9F4F4F4EDEDEDE6E6E6D1D1D142
      2B4BFF0000FF00004A1B5D80808080808076747757445F490B62FF0000FF0000
      FF0000FF0000FF00000000000000000000000000000000000000000000000000
      00000000000000000000888888FAFAFAF3F3F3EDEDEDE6E6E6DFDFDFD9D9D9B9
      B9B9800000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FF0000FF00000000000000000000000000000000000000000000000000000000
      00000000000000939393FAFAFAF4F4F4ECECECE6E6E6DFDFDFD8D8D8D2D2D2CB
      CBCBA1A1A1800000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      8000000000000000000000000000000000000000000000000000000000000000
      000000009D9D9DFAFAFAF3F3F3EDEDEDE5E5E5DFDFDFD8D8D8D1D1D1CBCBCBC4
      C4C4BDBDBD868686800000FF0000FF0000FF0000FF0000FF0000FF0000800000
      0000000000000000000000000000000000000000000000000000000000000000
      00A8A8A8FAFAFAF3F3F3ECECECE6E6E6DFDFDFD8D8D8D1D1D1CACACAC3C3C3BD
      BDBDB3B3B3515151000000800000FF0000FF0000FF0000FF0000800000000000
      0000000000000000000000000000000000000000000000000000000000005E5E
      5EDBDBDBF3F3F3ECECECE5E5E5DFDFDFD8D8D8D0D0D0CACACAC3C3C3BCBCBCB1
      B1B14E4E4E000000000000000000800000FF0000FF0000800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      005C5C5CDBDBDBE5E5E5DEDEDED7D7D7D1D1D1C9C9C9C3C3C3BCBCBCAEAEAE4D
      4D4D000000000000000000000000000000800000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000005A5A5AD6D6D6D7D7D7D0D0D0CACACAC3C3C3BCBCBCABABAB4D4D4D00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000005C5C5CCDCDCDC9C9C9C3C3C3BCBCBCA7A7A74D4D4D00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000616161C1C1C1BCBCBCA3A3A34F4F4F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000006969699F9F9F52525200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000050505000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FFFFFFFFDFFFFFFF8FFFFFFF07FFFFFE03FFFFFC01FFFFF800FFFFF0007FFFE0
      003FFFC0001FFF80000FFF000007FE000003FC000001FC000001FE000003FF00
      0007FF00000FFE00001FFC00003FF800007FF00000FFE00001FFC00003FF8002
      07FF00070FFF800F9FFFC01FFFFFE03FFFFFF07FFFFFF8FFFFFFFDFFFFFF}
    ApplicationMenu.IconSize = isLarge
    ApplicationMenu.Menu = AvoApplicationMenuBar
    Caption = 'AvoBase'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowHelpButton = False
    Tabs = <
      item
        Caption = 'Home'
        Page = RibbonPage1
      end
      item
        Caption = 'Orders'
        Page = RibbonPage2
      end
      item
        Caption = 'Customers'
        Page = RibbonPage3
      end
      item
        Caption = 'Products'
        Page = RibbonPage4
      end
      item
        Caption = 'Sales Cycles'
        Page = RibbonPage5
      end
      item
        Caption = 'Expenses'
        Page = RibbonPage7
      end
      item
        Caption = 'Earnings'
        Page = ribbonExpense
      end
      item
        Caption = 'Email Manager'
        Page = RibbonPage9
      end
      item
        Caption = 'Accounting'
        Page = RibbonPage8
      end
      item
        Caption = 'Reports'
        Page = RibbonPage6
      end>
    TabIndex = 9
    OnTabChange = AvoBaseRibbonTabChange
    ExplicitTop = -6
    DesignSize = (
      865
      148)
    StyleName = 'Ribbon - Luna'
    object AvoApplicationMenuBar: TRibbonApplicationMenuBar
      ActionManager = AvoActionManager
      OptionItems = <>
      RecentItems = <>
    end
    object RibbonPage8: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Reports'
      Index = 8
      object RibbonGroup2: TRibbonGroup
        Left = 4
        Top = 3
        Width = 179
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Accounting'
        GroupIndex = 0
      end
    end
    object RibbonPage9: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Email Manager'
      Index = 7
      object RibbonGroup7: TRibbonGroup
        Left = 4
        Top = 3
        Width = 520
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Email Manager'#39
        GroupIndex = 0
      end
    end
    object ribbonExpense: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Earnings'
      Index = 6
      object RibbonGroup5: TRibbonGroup
        Left = 4
        Top = 3
        Width = 616
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Sales Cycle Earnings'
        GroupIndex = 0
      end
    end
    object RibbonPage7: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Expenses'
      Index = 5
      object RibbonGroup4: TRibbonGroup
        Left = 4
        Top = 3
        Width = 618
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Sales Cycle Expenses'
        GroupIndex = 0
      end
    end
    object RibbonPage1: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Home'
      Index = 0
      object RibbonGroup9: TRibbonGroup
        Left = 4
        Top = 3
        Width = 60
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Settings'
        GroupIndex = 1
      end
      object RibbonGroup10: TRibbonGroup
        Left = 66
        Top = 3
        Width = 311
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Support And Forums'
        GroupIndex = 2
      end
      object RibbonGroup11: TRibbonGroup
        Left = 379
        Top = 3
        Width = 50
        Height = 86
        ActionManager = AvoActionManager
        GroupIndex = 3
      end
    end
    object RibbonPage2: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Orders'
      Index = 1
      object RibbonGroup3: TRibbonGroup
        Left = 4
        Top = 3
        Width = 813
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Orders'
        GroupIndex = 0
      end
    end
    object RibbonPage3: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Customers'
      Index = 2
      object RibbonGroup6: TRibbonGroup
        Left = 4
        Top = 3
        Width = 843
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Customers'
        GroupIndex = 1
      end
    end
    object RibbonPage5: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Sales Cycles'
      Index = 4
      object RibbonGroup22: TRibbonGroup
        Left = 4
        Top = 3
        Width = 264
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Sales Cycles'
        GroupIndex = 0
      end
    end
    object RibbonPage4: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Products'
      Index = 3
      object RibbonGroup14: TRibbonGroup
        Left = 4
        Top = 3
        Width = 579
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'Products'
        GroupIndex = 1
      end
    end
    object RibbonPage6: TRibbonPage
      Left = 0
      Top = 55
      Width = 864
      Height = 93
      Caption = 'Accounting'
      Index = 9
      object RibbonGroup8: TRibbonGroup
        Left = 4
        Top = 3
        Width = 433
        Height = 86
        ActionManager = AvoActionManager
        Caption = 'AvoBase Reports'
        GroupIndex = 0
      end
    end
  end
  object MAIN_DOCK_PANEL: TScrollBox
    Left = 0
    Top = 148
    Width = 865
    Height = 268
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 2
  end
  object AvoActionList: TActionList
    Images = IMG_StorageForm.Avobase_25x25_Images
    OnChange = ActionListExecute
    Left = 50
    Top = 220
    object act_Support_AvoBaseWebsite: TAction
      Caption = 'act_Support_AvoBaseWebsite'
    end
    object act_Support_AvoBaseForums: TAction
      Caption = 'act_Support_AvoBaseForums'
    end
    object act_Support_AvoBaseForums_General: TAction
      Caption = 'act_Support_AvoBaseForums_General'
    end
    object act_Support_AvoBaseForums_FAQ: TAction
      Caption = 'act_Support_AvoBaseForums_FAQ'
    end
    object act_Support_AvoBaseForums_Tech: TAction
      Caption = 'act_Support_AvoBaseForums_Tech'
    end
    object act_Order_TakePayment: TAction
      Caption = 'Take A Payment'
      ImageIndex = 18
    end
    object act_Order_VoidPayment: TAction
      Caption = 'Void or NSF a Payment'
      ImageIndex = 7
    end
    object act_Order_Cust_TakePayment: TAction
      Caption = 'Take Payment On Order'
      ImageIndex = 18
    end
    object act_Order_Cust_Void_Payment: TAction
      Caption = 'Void or NSF a Payment'
      ImageIndex = 7
    end
    object act_Order_Cancel: TAction
      Caption = 'Cancel Order'
      ImageIndex = 7
    end
    object act_Order_UnCancel: TAction
      Caption = 'Un-Cancel Order'#39
      ImageIndex = 45
    end
    object act_Order_ViewInvoice: TAction
      Caption = 'View Invoice'
      ImageIndex = 37
    end
    object act_Order_PrintInvoice: TAction
      Caption = 'Print Selected Invoice'
      ImageIndex = 42
    end
    object act_Order_EmailInvoice: TAction
      Caption = 'Email Invoice'
    end
    object act_Order_ChangeOrderCampaign: TAction
      Caption = 'Change Order Sales Cycle'
    end
    object act_Report_CustomerTopCustByMoney: TAction
      Caption = 'Top Customer By Order Amounts'
    end
    object act_Report_OrderList: TAction
      Caption = 'Order List'
      ImageIndex = 0
    end
    object act_Report_CustomerTopCustByOrder: TAction
      Caption = 'Top Customer By Orders Placed'
    end
    object act_Report_Customer_OustandingBalance: TAction
      Caption = 'Customer Outstanding Balance Report'
    end
    object act_Report_CustomerList: TAction
      Caption = 'Customer List'
      ImageIndex = 0
    end
    object act_Report_Earning_Types: TAction
      Caption = 'Earning Types'
    end
    object act_Report_Earning_EarningByCycle: TAction
      Caption = 'Earning Breakdown By Sales Cycle'
    end
    object act_Report_Earning_ListByCycle: TAction
      Caption = 'Earning List By Sales Cycle'
    end
    object act_Report_Expense_Type: TAction
      Caption = 'Expense Types'
    end
    object act_Report_Expense_ByCycle: TAction
      Caption = 'Expense Breakdown By Sales Cycle'
    end
    object act_Report_Expense_ListByCycle: TAction
      Caption = 'Expense List By Sales Cycle'
    end
    object act_Report_EarningVsExpenseByCycle: TAction
      Caption = 'Earnings VS Expenses By Sales Cycle'
    end
    object act_Report_Order_Labels: TAction
      Caption = 'Order Labels'
    end
    object act_Report_Product_QuantityOnHand: TAction
      Caption = 'Products Quantity On Hand'
    end
    object act_Report_Customer_OrderHistory: TAction
      Caption = 'Customer Order History'
    end
    object act_Report_Order_BackOrderList: TAction
      Caption = 'Back Order Product List'
    end
    object act_Report_Accounting_FeesCollectedByCycle: TAction
      Caption = 'Fees Collected By Sales Cycle'
    end
    object act_Report_Accounting_ShippingCollectedByCycle: TAction
      Caption = 'Shipping Collected By Sales Cycle'
    end
    object act_Report_Accounting_TaxesCollectedByCycle: TAction
      Caption = 'Taxes Collected By Sales Cycle'
    end
    object act_Report_Accounting_TaxExemptByCycle: TAction
      Caption = 'Tax Exempt Orders By Sales Cycle'
    end
    object act_Report_Accounting_DepositSlipByCycle: TAction
      Caption = 'Deposit Slip By Sales Cycle'
    end
    object act_Report_Accounting_VoidNSFByCycle: TAction
      Caption = 'Void/NSF Orders By Sales Cycle'
    end
    object act_Report_Accounting_ReturnsByCycle: TAction
      Caption = 'Return Amount Breakdown by Sales Cycle'
    end
    object act_Report_Accounting_TransactionLogByCycle: TAction
      Caption = 'Transaction Log By Sales Cycle'
    end
    object act_Report_Customer_OrderTransactionHistory: TAction
      Caption = 'Customer Order Transaction History'
    end
    object act_Report_Product_ProductList: TAction
      Caption = 'Product List'
    end
    object act_Report_Cycle_CycleListByOrg: TAction
      Caption = 'Sales Cycle List By Org'
    end
    object act_Report_Customer_Labels: TAction
      Caption = 'Customer Labels'
    end
    object act_Report_ORder_OrderProductList: TAction
      Caption = 'Order Product List By Sales Cycle'
    end
    object act_Report_Order_ProductReturnList: TAction
      Caption = 'Product Return List'
    end
    object act_Report_Accounting_ShippingReturned: TAction
      Caption = 'Shipping Returned By Sales Cycle'
    end
    object act_Report_Accounting_FeesReturned: TAction
      Caption = 'Fees Returned By Sales Cycle'
    end
    object act_Order_PrintAllCycleInvoices: TAction
      Caption = 'Print All Sales Cycle Invoices'
      ImageIndex = 42
    end
    object act_Order_EmailAllCycleInvoices: TAction
      Caption = 'act_Order_EmailAllCycleInvoices'
    end
    object act_Report_Accounting_CycleBreakDown: TAction
      Caption = 'Order Amount Breakdown by Sales Cycle'
    end
    object act_Order_EmailSingleInvoice: TAction
      Caption = 'Email Selected Order Invoice'
    end
    object act_Order_EmailCycleInvoices: TAction
      Caption = 'Email All Invoices in a Sales Cycle'
    end
    object act_Report_CustomerEscrowBalance: TAction
      Caption = 'Customer Escrow Balance'
      ImageIndex = 0
    end
    object act_Settings_GeneralSettings: TAction
      Caption = 'General AvoBase Settings'
      ImageIndex = 38
    end
    object act_Settings_RepSettings: TAction
      Caption = 'Sales Representative Settings'
      ImageIndex = 38
    end
    object act_Settings_Email: TAction
      Caption = 'Email Server And Configs'
      ImageIndex = 38
    end
    object act_Settings_Organizations: TAction
      Caption = 'Sales Organizations'
      ImageIndex = 38
    end
    object act_Settings_OrderFees: TAction
      Caption = 'Fees for Orders and Returns'
      ImageIndex = 38
    end
    object act_Settings_TaxRates: TAction
      Caption = 'Taxes - Groups And Rates'
      ImageIndex = 38
    end
    object act_Settings_ShippingRates: TAction
      Caption = 'Shipping Rates'
      ImageIndex = 38
    end
    object act_Settings_EarningTypes: TAction
      Caption = 'Earning Types'
      ImageIndex = 38
    end
    object act_Settings_ExpenseTypes: TAction
      Caption = 'Expense Types'
      ImageIndex = 38
    end
    object act_Settings_InvoiceSettings: TAction
      Caption = 'Invoice and Invoice Printing Settings'
      ImageIndex = 38
    end
    object act_Settings_ProductSettings: TAction
      Caption = 'Product Settings'
      ImageIndex = 38
    end
    object act_Import_Customer: TAction
      Caption = 'Import Customer List'
      ImageIndex = 47
    end
    object act_Export_Customer: TAction
      Caption = 'Export Customer List'
      ImageIndex = 48
    end
    object act_Product_Import: TAction
      Caption = 'Import Product List'
      ImageIndex = 47
    end
    object act_Product_Export: TAction
      Caption = 'Export Product List'
      ImageIndex = 48
    end
  end
  object AvoActionManager: TActionManager
    ActionBars = <
      item
        Items = <
          item
            ChangesAllowed = [caModify]
            Items = <
              item
                Caption = '-'
              end
              item
                Caption = '-'
              end>
            Caption = '&ActionClientItem0'
            KeyTip = 'F'
          end>
        AutoSize = False
      end
      item
        AutoSize = False
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
        Items = <
          item
            ChangesAllowed = [caModify]
            Items = <
              item
                Caption = '-'
              end
              item
                Caption = '-'
              end
              item
                Caption = '&ActionClientItem0'
              end>
            Caption = '&ActionClientItem0'
            KeyTip = 'F'
          end>
        AutoSize = False
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end>
      end
      item
        Items = <
          item
            ChangesAllowed = [caModify]
            Caption = '&ActionClientItem0'
            KeyTip = 'F'
          end>
        AutoSize = False
      end
      item
        AutoSize = False
      end
      item
        Items = <
          item
            Caption = '&RibbonComboBox1'
            CommandStyle = csComboBox
            CommandProperties.Width = 150
          end
          item
            Caption = 'R&ibbonSpinEdit1'
            CommandStyle = csControl
            CommandProperties.Width = 150
          end>
      end
      item
        Items = <
          item
            ChangesAllowed = [caModify]
            Items = <
              item
                Action = actCtrl_Main_Settings
                Caption = 'A&voBase Settings'
                ImageIndex = 5
              end
              item
                Action = actCtrl_Main_Donate
                Caption = '&Donate!'
                ImageIndex = 42
              end
              item
                Caption = '-'
              end
              item
                Action = actCtrl_Main_Help
                Caption = '&AvoBase Help'
                ImageIndex = 24
              end
              item
                Action = actCtrl_Main_Contactus
                Caption = 'C&ontact Us'
                ImageIndex = 53
              end
              item
                Action = actCtrl_Main_Forums
                Caption = 'AvoBa&se Forums'
                ImageIndex = 7
              end
              item
                Caption = '-'
              end
              item
                Action = actCtrl_Main_CheckUpdates
                Caption = 'C&heck For Updates'
                ImageIndex = 54
              end
              item
                Caption = '-'
              end
              item
                Action = actCtrl_Main_Close
                Caption = '&Close'
                ImageIndex = 4
              end
              item
                Caption = '-'
              end>
            Caption = '&ActionClientItem0'
            KeyTip = 'F'
          end>
        AutoSize = False
      end
      item
        Items = <
          item
            Action = actCtrl_Order_List
            Caption = '&Order List'
            ImageIndex = 37
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Order_Load
            Caption = '&Load'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Order_New
            Caption = '&New Order'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Order_New_Return
            Caption = 'N&ew Return'
            ImageIndex = 6
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_ReturnManager
            Caption = '&Returns Manager'
            ImageIndex = 9
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Order_ViewInvoice
            Caption = '&View Invoice'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Order_PrintInvoice
            Caption = '&Print'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Order_EmailInvoice
            Caption = 'E&mail Invoice'
            ImageIndex = 23
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Order_EmailAllInvoicesInCycle
            Caption = '&Email All Invoices'
            ImageIndex = 26
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Order_Reports
            Caption = '&Order Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btSplit
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Cust_List
            Caption = '&Customers'
            ImageIndex = 12
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Cust_New
            Caption = '&New'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Cust_Edit
            Caption = '&Edit'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Cust_Activity
            Caption = '&Set Activity'
            ImageIndex = 22
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Cust_Email
            Caption = 'E&mail'
            ImageIndex = 23
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Cust_Print
            Caption = '&Print'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Cust_Reports
            Caption = '&Customer Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btSplit
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Main_Settings
            Caption = '&AvoBase Settings'
            ImageIndex = 5
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Main_Donate
            Caption = '&Donate!'
            ImageIndex = 42
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Main_CheckUpdates
            Caption = 'C&heck For Updates'
            ImageIndex = 54
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Main_Contactus
            Caption = '&Contact Us'
            ImageIndex = 53
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Items = <
              item
                Action = act_Support_AvoBaseForums
                Caption = '&act_Support_AvoBaseForums'
              end
              item
                Action = act_Support_AvoBaseForums_FAQ
                Caption = 'a&ct_Support_AvoBaseForums_FAQ'
              end
              item
                Action = act_Support_AvoBaseForums_General
                Caption = 'ac&t_Support_AvoBaseForums_General'
              end
              item
                Action = act_Support_AvoBaseForums_Tech
                Caption = 'act_&Support_AvoBaseForums_Tech'
              end>
            Action = actCtrl_Main_Forums
            Caption = 'A&voBase Forums'
            ImageIndex = 7
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btSplit
          end
          item
            Action = actCtrl_Main_Help
            Caption = '&AvoBase Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        AutoSize = False
      end
      item
        Items = <
          item
            Action = actCtrl_Main_Close
            Caption = '&Close'
            ImageIndex = 4
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Caption = '&ActionClientItem0'
          end>
      end
      item
        Items = <
          item
            ChangesAllowed = [caModify]
            Items = <
              item
                Caption = '-'
              end
              item
                Action = actCtrl_Main_Settings
                Caption = 'A&voBase Settings'
                ImageIndex = 5
              end
              item
                Caption = '-'
              end
              item
                Action = actCtrl_Main_Donate
                Caption = '&Donate!'
                ImageIndex = 59
              end
              item
                Action = actCtrl_Main_Help
                Caption = '&AvoBase Help'
                ImageIndex = 24
              end
              item
                Action = actCtrl_Main_Forums
                Caption = 'Avo&Base Forums'
                ImageIndex = 7
              end
              item
                Caption = '-'
              end
              item
                Action = actCtrl_Main_CheckUpdates
                Caption = 'C&heck For Updates'
                ImageIndex = 54
              end
              item
                Caption = '-'
              end
              item
                Action = actCtrl_Main_Close
                Caption = 'C&lose'
                ImageIndex = 4
              end>
            Caption = '&ActionClientItem0'
            ImageIndex = 5
            KeyTip = 'F'
          end>
        ActionBar = AvoApplicationMenuBar
        AutoSize = False
      end
      item
        Items = <
          item
            Action = actCtrl_Main_Home
            Caption = '&Home'
            ImageIndex = 17
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Main_Blog
            Caption = '&AvoBase Blog'
            ImageIndex = 67
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Cust_List
            Caption = '&Customers'
            ImageIndex = 12
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Order_List
            Caption = '&Order List'
            ImageIndex = 58
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Order_New
            Caption = '&New Order'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Order_New_Return
            Caption = 'N&ew Return'
            ImageIndex = 6
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Order_Load
            Caption = '&Load'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Order_LoadNum
            Caption = 'Lo&ad By Num'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Order_ViewInvoice
            Caption = '&View Invoice'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = act_Order_SaveInvoice
            Caption = '&Save Invoice'
            ImageIndex = 2
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Items = <
              item
                Action = act_Order_EmailSingleInvoice
                Caption = '&Email Selected Order Invoice'
                ImageIndex = 21
              end
              item
                Action = act_Order_EmailCycleInvoices
                Caption = 'E&mail All Invoices in a Sales Cycle'
                ImageIndex = 21
              end>
            Action = actCtrl_Order_EmailInvoice
            Caption = 'E&mail'
            ImageIndex = 23
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Items = <
              item
                Action = act_Order_PrintInvoice
                Caption = '&Print Selected Invoice'
                ImageIndex = 42
              end
              item
                Action = act_Order_PrintAllCycleInvoices
                Caption = 'P&rint All Sales Cycle Invoices'
                ImageIndex = 42
              end>
            Action = actCtrl_Order_PrintInvoice
            Caption = '&Print'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Order_TakePayment
                Caption = '&Take A Payment'
                ImageIndex = 18
              end
              item
                Action = act_Order_VoidPayment
                Caption = '&Void or NSF a Payment'
                ImageIndex = 7
              end>
            Action = actCtrl_Order_Payment
            Caption = 'Paymen&ts'
            ImageIndex = 59
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Order_Finalize
            Caption = '&Close Order'
            ImageIndex = 64
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_ReturnManager
            Caption = 'Ret&urns Manager'
            ImageIndex = 54
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = act_Ctrl_Order_BackOrder
            Caption = '&Back Order Manager'
            ImageIndex = 63
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_OrderList
                Caption = '&Order List'
                ImageIndex = 33
              end
              item
                Action = act_Report_Order_BackOrderList
                Caption = '&Back Order Product List'
                ImageIndex = 33
              end
              item
                Action = act_Report_ORder_OrderProductList
                Caption = 'O&rder Product List By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Customer_OustandingBalance
                Caption = '&Customer Outstanding Balance Report'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_CycleBreakDown
                Caption = 'Or&der Amount Breakdown by Sales Cycle'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Order
            Caption = '&Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Order_Help
            Caption = 'Order &Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup3
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Action = actCtrl_Cust_New
            Caption = '&New Customer'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Cust_Edit
            Caption = '&Edit Customer'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cust_Activity
            Caption = '&Set Activity'
            ImageIndex = 22
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cust_Notes
            Caption = 'N&otes'
            ImageIndex = 7
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cust_OrdProd
            Caption = '&Customer Products'
            ImageIndex = 34
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cust_View
            Caption = '&View Orders'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Cust_ViewAccount
            Caption = 'V&iew Account'
            ImageIndex = 39
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cust_NewOrder
            Caption = 'Ne&w Order'
            ImageIndex = 58
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Items = <
              item
                Action = act_Order_Cust_TakePayment
                Caption = '&Take Payment On Order'
                ImageIndex = 18
              end
              item
                Action = act_Order_Cust_Void_Payment
                Caption = '&Void or NSF a Payment'
                ImageIndex = 7
              end>
            Action = actCtrl_Cust_Payment
            Caption = 'P&ayments'
            ImageIndex = 59
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cust_Email
            Caption = 'E&mail Customer'
            ImageIndex = 23
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cust_Print
            Caption = '&Print Customer'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Import_Customer
                Caption = '&Import Customer List'
                ImageIndex = 47
              end
              item
                Action = act_Export_Customer
                Caption = '&Export Customer List'
                ImageIndex = 48
              end>
            Action = actCtrl_Customer_ImportExport
            Caption = 'Impor&t Export'
            ImageIndex = 5
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_CustomerList
                Caption = '&Customer List'
                ImageIndex = 33
              end
              item
                Action = act_Report_CustomerTopCustByOrder
                Caption = '&Top Customer By Orders Placed'
                ImageIndex = 33
              end
              item
                Action = act_Report_CustomerTopCustByMoney
                Caption = 'T&op Customer By Order Amounts'
                ImageIndex = 33
              end
              item
                Action = act_Report_Customer_OrderHistory
                Caption = 'C&ustomer Order History'
                ImageIndex = 33
              end
              item
                Action = act_Report_Customer_OrderTransactionHistory
                Caption = 'Cu&stomer Order Transaction History'
                ImageIndex = 33
              end
              item
                Action = act_Report_Customer_OustandingBalance
                Caption = 'Custo&mer Outstanding Balance Report'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Customer
            Caption = '&Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cust_Help
            Caption = 'C&ustomer Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup6
      end
      item
      end
      item
        Items = <
          item
            Caption = '-'
          end>
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Action = actCtrl_Product_New
            Caption = '&New Product'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Product_Edit
            Caption = '&Edit Product'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Product_Delete
            Caption = '&Delete Product'
            ImageIndex = 9
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Product_View
            Caption = '&View Product'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Product_Print
            Caption = '&Print Product'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_ReturnManager
            Caption = 'Re&turns Manager'
            ImageIndex = 54
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = act_Ctrl_Order_BackOrder
            Caption = '&Back Order Manager'
            ImageIndex = 63
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Product_Import
                Caption = '&Import Product List'
                ImageIndex = 47
              end
              item
                Action = act_Product_Export
                Caption = '&Export Product List'
                ImageIndex = 48
              end>
            Action = actCtrl_Product_ImportExport
            Caption = '&Import Export'
            ImageIndex = 5
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Product_ProductList
                Caption = '&Product List'
                ImageIndex = 33
              end
              item
                Action = act_Report_Product_QuantityOnHand
                Caption = 'P&roducts Quantity On Hand'
                ImageIndex = 33
              end
              item
                Action = act_Report_Order_ProductReturnList
                Caption = 'Pr&oduct Return List'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Product
            Caption = 'Rep&orts'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Product_Help
            Caption = 'P&roduct Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup14
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Action = actCtrl_Cycle_New
            Caption = '&New Cycle'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Cycle_Edit
            Caption = '&Edit Cycle'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cycle_ViewOrders
            Caption = 'V&iew Orders'
            ImageIndex = 58
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Cycle_CycleListByOrg
                Caption = '&Sales Cycle List By Org'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Cycle
            Caption = '&Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Cycle_Help
            Caption = '&Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup22
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Action = actCtrl_Brochure_New
            Caption = '&New Brochure List'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Brochure_Edit
            Caption = '&Edit Brochure List'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Brochure_Delete
            Caption = '&Delete Brochure List'
            ImageIndex = 9
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Brochure_View
            Caption = '&View Brochure List'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Brochure_Reports
            Caption = '&Brochure Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Brochure_Help
            Caption = 'B&rochure Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Action = actCtrl_EarningList_New
            Caption = '&New Earning List'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_EarningList_Edit
            Caption = '&Edit Earning List'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_EarningList_LoadByCycle
            Caption = '&Load By Cycle'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_EarningList_View
            Caption = '&View Earning List'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_EarningList_Print
            Caption = '&Print Earning List'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Earning_Reports
            Caption = '&Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_EarningList_Help
            Caption = '&Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Cust_Help
            Caption = 'C&ustomer Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_Cust_Reports
            Caption = '&Customer Reports'
            ImageIndex = 40
          end>
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Action = actCtrl_ExpenseList_New
            Caption = '&New Expense List'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_ExpenseList_Edit
            Caption = '&Edit Expense List'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_ExpenseList_LoadByCycle
            Caption = '&Load By Cycle'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_ExpenseList_View
            Caption = '&View Expense List'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_ExpenseList_Print
            Caption = '&Print Expense List'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Expense_Reports
            Caption = '&Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_ExpenseList_Help
            Caption = '&Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
      end
      item
        Items = <
          item
            Action = actCtrl_ExpenseList_New
            Caption = '&New Expense List'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Expense_QuickAdd
            Caption = 'E&xpense Quick Add'
            ImageIndex = 77
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_ExpenseList_Edit
            Caption = '&Edit Expense List'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_ExpenseList_LoadByCycle
            Caption = '&Load By Cycle'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_ExpenseList_View
            Caption = '&View Expense List'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_ExpenseList_Print
            Caption = '&Print Expense List'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Expense_EditTypes
            Caption = 'Expen&se Types'
            ImageIndex = 57
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Expense_Type
                Caption = '&Expense Types'
                ImageIndex = 33
              end
              item
                Action = act_Report_Expense_ByCycle
                Caption = 'E&xpense Breakdown By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Expense_ListByCycle
                Caption = 'Ex&pense List By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_EarningVsExpenseByCycle
                Caption = 'E&arnings VS Expenses By Sales Cycle'
                ImageIndex = 33
              end>
            Action = actCtrl_Report_Expense
            Caption = '&Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_ExpenseList_Help
            Caption = '&Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup4
      end
      item
        Items = <
          item
            Action = actCtrl_EarningList_New
            Caption = '&New Earning List'
            ImageIndex = 0
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Earning_QuickAdd
            Caption = 'E&arning Quick Add'
            ImageIndex = 77
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_EarningList_Edit
            Caption = '&Edit Earning List'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_EarningList_LoadByCycle
            Caption = '&Load By Cycle'
            ImageIndex = 1
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_EarningList_View
            Caption = '&View Earning List'
            ImageIndex = 15
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_EarningList_Print
            Caption = '&Print Earning List'
            ImageIndex = 8
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Earning_EditTypes
            Caption = 'Earn&ing Types'
            ImageIndex = 59
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Earning_Types
                Caption = '&Earning Types'
                ImageIndex = 33
              end
              item
                Action = act_Report_Earning_EarningByCycle
                Caption = 'E&arning Breakdown By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Earning_ListByCycle
                Caption = 'Ea&rning List By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Expense_ByCycle
                Caption = 'E&xpense Breakdown By Sales Cycle'
                ImageIndex = 33
              end>
            Action = actCtrl_Report_Earning
            Caption = '&Reports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_EarningList_Help
            Caption = '&Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup5
      end
      item
        Items = <
          item
            Action = actCtrl_Email_Send
            Caption = '&Send Email'
            ImageIndex = 23
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Email_SendAll
            Caption = 'Se&nd All Emails'
            ImageIndex = 26
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Email_ReQueue
            Caption = '&ReQueue Email'
            ImageIndex = 20
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Email_RequeueAll
            Caption = 'Re&queue All'
            ImageIndex = 20
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Email_Delete
            Caption = '&Delete Email'
            ImageIndex = 9
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actCtrl_Email_DeleteAll
            Caption = 'De&lete All Emails'
            ImageIndex = 9
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Email_Setting
            Caption = '&Email Settings'
            ImageIndex = 5
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Email_Clean
            Caption = '&Clean Email List'
            ImageIndex = 54
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Email_Help
            Caption = '&Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup7
      end
      item
        Items = <
          item
            Action = actCtrl_Main_Close
            Caption = 'C&lose'
            ImageIndex = 4
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup11
      end
      item
        Items = <
          item
            Action = actCtrl_Main_Forums
            Caption = 'A&voBase Forums'
            ImageIndex = 61
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Main_CheckUpdates
            Caption = 'C&heck For Updates'
            ImageIndex = 54
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = actViewUpdates
            Caption = 'V&iew Updates'
            ImageIndex = 63
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Main_Donate
            Caption = '&Donate!'
            ImageIndex = 59
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Main_Help
            Caption = '&AvoBase Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup10
      end
      item
        Items = <
          item
            Action = actCtrl_Main_Settings
            Caption = 'Avo&Base Settings'
            ImageIndex = 5
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup9
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Action = actCtrl_Account_Escrow
            Caption = '&Reconcile Escrow'
            ImageIndex = 59
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Accounting_FeesCollectedByCycle
                Caption = '&Fees Collected By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_ShippingCollectedByCycle
                Caption = '&Shipping Collected By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_TaxesCollectedByCycle
                Caption = '&Taxes Collected By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_TaxExemptByCycle
                Caption = 'T&ax Exempt Orders By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_VoidNSFByCycle
                Caption = '&Void/NSF Orders By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_ReturnsByCycle
                Caption = '&Return Amount Breakdown by Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_ReturnsByCycle
                Caption = 'R&eturn Amount Breakdown by Sales Cycle'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Accounting
            Caption = 'R&eports'
            ImageIndex = 40
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Action = actCtrl_Accounting_Help
            Caption = '&Help'
            ImageIndex = 24
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = RibbonGroup2
      end
      item
        Items = <
          item
            Items = <
              item
                Action = act_Report_OrderList
                Caption = '&Order List'
                ImageIndex = 33
              end
              item
                Action = act_Report_Order_BackOrderList
                Caption = '&Back Order Product List'
                ImageIndex = 33
              end
              item
                Action = act_Report_ORder_OrderProductList
                Caption = 'Or&der Product List By Sales Cycle'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Order
            Caption = '&Order'
            ImageIndex = 58
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_CustomerList
                Caption = '&Customer List'
                ImageIndex = 33
              end
              item
                Action = act_Report_CustomerTopCustByOrder
                Caption = '&Top Customer By Orders Placed'
                ImageIndex = 33
              end
              item
                Action = act_Report_CustomerTopCustByMoney
                Caption = 'T&op Customer By Order Amounts'
                ImageIndex = 33
              end
              item
                Action = act_Report_Customer_OrderHistory
                Caption = 'C&ustomer Order History'
                ImageIndex = 33
              end
              item
                Action = act_Report_Customer_OrderTransactionHistory
                Caption = 'Cu&stomer Order Transaction History'
                ImageIndex = 33
              end
              item
                Action = act_Report_Customer_OustandingBalance
                Caption = 'Custo&mer Outstanding Balance Report'
                ImageIndex = 33
              end
              item
                Action = act_Report_CustomerEscrowBalance
                Caption = 'Custom&er Escrow Balance'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Customer
            Caption = '&Customer'
            ImageIndex = 12
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Product_ProductList
                Caption = 'P&roduct List'
                ImageIndex = 33
              end
              item
                Action = act_Report_Product_QuantityOnHand
                Caption = '&Products Quantity On Hand'
                ImageIndex = 33
              end
              item
                Action = act_Report_Order_ProductReturnList
                Caption = 'Pr&oduct Return List'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Product
            Caption = '&Product'
            ImageIndex = 34
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Cycle_CycleListByOrg
                Caption = '&Sales Cycle List By Org'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Cycle
            Caption = 'C&ycle'
            ImageIndex = 38
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Expense_Type
                Caption = '&Expense Types'
                ImageIndex = 33
              end
              item
                Action = act_Report_Expense_ByCycle
                Caption = 'E&xpense Breakdown By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Expense_ListByCycle
                Caption = 'Ex&pense List By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_EarningVsExpenseByCycle
                Caption = 'E&arnings VS Expenses By Sales Cycle'
                ImageIndex = 33
              end>
            Action = actCtrl_Report_Expense
            Caption = 'E&xpense'
            ImageIndex = 57
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Earning_Types
                Caption = '&Earning Types'
                ImageIndex = 33
              end
              item
                Action = act_Report_Earning_EarningByCycle
                Caption = 'E&arning Breakdown By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Earning_ListByCycle
                Caption = 'Ea&rning List By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_EarningVsExpenseByCycle
                Caption = 'Ear&nings VS Expenses By Sales Cycle'
                ImageIndex = 33
              end>
            Action = actCtrl_Report_Earning
            Caption = '&Earning'
            ImageIndex = 59
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end
          item
            Caption = '-'
          end
          item
            Items = <
              item
                Action = act_Report_Accounting_FeesCollectedByCycle
                Caption = '&Fees Collected By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_ShippingCollectedByCycle
                Caption = '&Shipping Collected By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_TaxesCollectedByCycle
                Caption = '&Taxes Collected By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_TaxExemptByCycle
                Caption = 'T&ax Exempt Orders By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_VoidNSFByCycle
                Caption = '&Void/NSF Orders By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_ReturnsByCycle
                Caption = '&Return Amount Breakdown by Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_TransactionLogByCycle
                Caption = 'Tra&nsaction Log By Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_CycleBreakDown
                Caption = '&Order Amount Breakdown by Sales Cycle'
                ImageIndex = 33
              end
              item
                Action = act_Report_CustomerEscrowBalance
                Caption = '&Customer Escrow Balance'
                ImageIndex = 33
              end
              item
                Action = act_Report_Accounting_ShippingReturned
                Caption = 'S&hipping Returned By Sales Cycle'
                ImageIndex = 33
              end>
            Action = actCtrl_Reports_Accounting
            Caption = '&Accounting'
            ImageIndex = 68
            CommandProperties.ButtonSize = bsLarge
            CommandProperties.ButtonType = btDropDown
          end>
        ActionBar = RibbonGroup8
      end>
    DisabledImages = IMG_StorageForm.AvoBase_30x30_DisabledImages
    LargeDisabledImages = IMG_StorageForm.AvoBase_30x30_DisabledImages
    Images = IMG_StorageForm.Avobase_ToolBar_Img
    OnUpdate = AvoActionManagerUpdate
    Left = 51
    Top = 170
    StyleName = 'Ribbon - Luna'
    object actCtrl_Main_Close: TControlAction
      Tag = 34
      Caption = 'Close'
      ImageIndex = 4
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_List: TControlAction
      Caption = 'Order List'
      ImageIndex = 58
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_New: TControlAction
      Caption = 'New Order'
      ImageIndex = 0
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_New_Return: TControlAction
      Caption = 'New Return'
      ImageIndex = 6
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_Load: TControlAction
      Caption = 'Load'
      ImageIndex = 1
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_ReturnManager: TControlAction
      Caption = 'Returns Manager'
      ImageIndex = 54
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_ViewInvoice: TControlAction
      Caption = 'View Invoice'
      ImageIndex = 15
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_PrintInvoice: TControlAction
      Caption = 'Print'
      ImageIndex = 8
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_EmailInvoice: TControlAction
      Caption = 'Email Invoice'
      ImageIndex = 23
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_EmailAllInvoicesInCycle: TControlAction
      Caption = 'Email All Invoices'
      ImageIndex = 26
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Order_Reports: TControlAction
      Caption = 'Order Reports'
      ImageIndex = 40
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cust_List: TControlAction
      Tag = 82
      Caption = 'Customers'
      ImageIndex = 12
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cust_New: TControlAction
      Tag = 92
      Caption = 'New Customer'
      ImageIndex = 0
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cust_Edit: TControlAction
      Tag = 93
      Caption = 'Edit Customer'
      ImageIndex = 1
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cust_Activity: TControlAction
      Tag = 86
      Caption = 'Set Activity'
      ImageIndex = 22
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cust_Email: TControlAction
      Caption = 'Email Customer'
      ImageIndex = 23
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cust_Print: TControlAction
      Caption = 'Print Customer'
      ImageIndex = 8
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cust_Reports: TControlAction
      Caption = 'Customer Reports'
      ImageIndex = 40
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cust_Help: TControlAction
      Caption = 'Customer Help'
      ImageIndex = 24
    end
    object actCtrl_Main_Help: TControlAction
      Caption = 'AvoBase Help'
      ImageIndex = 24
    end
    object actCtrl_Main_Forums: TControlAction
      Caption = 'AvoBase Forums'
      ImageIndex = 61
    end
    object actCtrl_Main_Contactus: TControlAction
      Caption = 'Contact Us'
      ImageIndex = 53
    end
    object actCtrl_Main_Settings: TControlAction
      Tag = 91
      Caption = 'AvoBase Settings'
      ImageIndex = 5
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Main_CheckUpdates: TControlAction
      Caption = 'Check For Updates'
      ImageIndex = 54
    end
    object actCtrl_Main_IconSettings: TControlAction
      Tag = 91
      Caption = 'AvoBase Settings'
      ImageIndex = 5
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Main_Donate: TControlAction
      Caption = 'Donate!'
      ImageIndex = 59
    end
    object actCtrl_Product_List: TControlAction
      Caption = 'Products'
      ImageIndex = 34
    end
    object actCtrl_Product_New: TControlAction
      Caption = 'New Product'
      ImageIndex = 0
    end
    object actCtrl_Product_Edit: TControlAction
      Caption = 'Edit Product'
      ImageIndex = 1
    end
    object actCtrl_Product_Print: TControlAction
      Caption = 'Print Product'
      ImageIndex = 8
    end
    object actCtrl_Product_Reports: TControlAction
      Caption = 'Product Reports'
      ImageIndex = 40
    end
    object actCtrl_Product_Delete: TControlAction
      Caption = 'Delete Product'
      ImageIndex = 9
    end
    object actCtrl_Cust_View: TControlAction
      Tag = 97
      Caption = 'View Orders'
      ImageIndex = 15
      OnExecute = RibbonActionExecuteLarge
    end
    object actCtrl_Cycle_List: TControlAction
      Caption = 'Cycles'
      ImageIndex = 38
    end
    object actCtrl_Cycle_New: TControlAction
      Caption = 'New Cycle'
      ImageIndex = 0
    end
    object actCtrl_Cycle_Edit: TControlAction
      Caption = 'Edit Cycle'
      ImageIndex = 1
    end
    object actCtrl_Cycle_SetActive: TControlAction
      Caption = 'Set Active'
      ImageIndex = 22
    end
    object actCtrl_Cycle_Generate: TControlAction
      Caption = 'Generate Cycles'
      ImageIndex = 5
    end
    object actCtrl_Cycle_Reports: TControlAction
      Caption = 'Sales Cycle Reports'
      ImageIndex = 40
    end
    object actCtrl_Order_Payment: TControlAction
      Caption = 'Payments'
      ImageIndex = 59
    end
    object actCtrl_Order_NSF: TControlAction
      Caption = 'NSF Payment'
      ImageIndex = 46
    end
    object actCtrl_Order_VoidPayment: TControlAction
      Caption = 'Void Payment'
      ImageIndex = 20
    end
    object actCtrl_Product_Help: TControlAction
      Caption = 'Product Help'
      ImageIndex = 24
    end
    object actCtrl_Product_View: TControlAction
      Caption = 'View Product'
      ImageIndex = 15
    end
    object actCtrl_Order_Help: TControlAction
      Caption = 'Order Help'
      ImageIndex = 24
    end
    object actCtrl_Cycle_View: TControlAction
      Caption = 'View Cycle'
      ImageIndex = 15
    end
    object actCtrl_Brochure_List: TControlAction
      Caption = 'Brochure List'
      ImageIndex = 13
    end
    object actCtrl_Brochure_New: TControlAction
      Caption = 'New Brochure List'
      ImageIndex = 0
    end
    object actCtrl_Brochure_Edit: TControlAction
      Caption = 'Edit Brochure List'
      ImageIndex = 1
    end
    object actCtrl_Brochure_Delete: TControlAction
      Caption = 'Delete Brochure List'
      ImageIndex = 9
    end
    object actCtrl_Brochure_View: TControlAction
      Caption = 'View Brochure List'
      ImageIndex = 15
    end
    object actCtrl_Brochure_Reports: TControlAction
      Caption = 'Brochure Reports'
      ImageIndex = 40
    end
    object actCtrl_Brochure_Help: TControlAction
      Caption = 'Brochure Help'
      ImageIndex = 24
    end
    object actCtrl_Cust_NewOrder: TControlAction
      Caption = 'New Order'
      ImageIndex = 58
    end
    object actCtrl_Cust_NewReturn: TControlAction
      Caption = 'New Return'
      ImageIndex = 6
    end
    object actCtrl_Cust_Payment: TControlAction
      Caption = 'Payments'
      ImageIndex = 59
    end
    object actCtrl_Cust_NSF: TControlAction
      Caption = 'Non Sufficient Funds'
      ImageIndex = 20
    end
    object acCtrl_Cust_VoidPayment: TControlAction
      Caption = 'Void Payment'
      ImageIndex = 27
    end
    object actCtrl_Cycle_ViewOrders: TControlAction
      Caption = 'View Orders'
      ImageIndex = 58
    end
    object actCtrl_Order_Finalize: TControlAction
      Caption = 'Close Order'
      ImageIndex = 64
    end
    object actCtrl_Order_LoadNum: TControlAction
      Caption = 'Load By Num'
      ImageIndex = 1
    end
    object actCtrl_Cust_ViewAccount: TControlAction
      Caption = 'View Account'
      ImageIndex = 39
    end
    object actCtrl_ExpenseList_New: TControlAction
      Caption = 'New Expense List'
      ImageIndex = 0
    end
    object actCtrl_ExpenseList_Edit: TControlAction
      Caption = 'Edit Expense List'
      ImageIndex = 1
    end
    object actCtrl_ExpenseList_View: TControlAction
      Caption = 'View Expense List'
      ImageIndex = 15
    end
    object actCtrl_ExpenseList_Print: TControlAction
      Caption = 'Print Expense List'
      ImageIndex = 8
    end
    object actCtrl_Expense_Reports: TControlAction
      Caption = 'Reports'
      ImageIndex = 40
    end
    object actCtrl_ExpenseList_Help: TControlAction
      Caption = 'Help'
      ImageIndex = 24
    end
    object actCtrl_ExpenseList_LoadByCycle: TControlAction
      Caption = 'Load By Cycle'
      ImageIndex = 1
    end
    object actCtrl_EarningList_New: TControlAction
      Caption = 'New Earning List'
      ImageIndex = 0
    end
    object actCtrl_EarningList_Edit: TControlAction
      Caption = 'Edit Earning List'
      ImageIndex = 1
    end
    object actCtrl_EarningList_View: TControlAction
      Caption = 'View Earning List'
      ImageIndex = 15
    end
    object actCtrl_EarningList_Print: TControlAction
      Caption = 'Print Earning List'
      ImageIndex = 8
    end
    object actCtrl_EarningList_Help: TControlAction
      Caption = 'Help'
      ImageIndex = 24
    end
    object actCtrl_Earning_Reports: TControlAction
      AutoCheck = True
      Caption = 'Reports'
      ImageIndex = 40
    end
    object actCtrl_EarningList_LoadByCycle: TControlAction
      Caption = 'Load By Cycle'
      ImageIndex = 1
    end
    object actCtrl_Cust_BackOrder: TControlAction
      Caption = 'View Back Orders'
      ImageIndex = 63
    end
    object act_Ctrl_Order_BackOrder: TControlAction
      Caption = 'Back Order Manager'
      ImageIndex = 63
    end
    object actCtrl_Email_ReQueue: TControlAction
      Caption = 'ReQueue Email'
      ImageIndex = 20
    end
    object actCtrl_Email_Setting: TControlAction
      Caption = 'Email Settings'
      ImageIndex = 5
    end
    object actCtrl_Cycle_Help: TControlAction
      Caption = 'Help'
      ImageIndex = 24
    end
    object actCtrl_Email_Send: TControlAction
      Caption = 'Send Email'
      ImageIndex = 23
    end
    object actCtrl_Email_SendAll: TControlAction
      Caption = 'Send All Emails'
      ImageIndex = 26
    end
    object actCtrl_Email_Delete: TControlAction
      Caption = 'Delete Email'
      ImageIndex = 9
    end
    object actCtrl_Email_DeleteAll: TControlAction
      Caption = 'Delete All Emails'
      ImageIndex = 9
    end
    object actCtrl_Email_Help: TControlAction
      Caption = 'Help'
      ImageIndex = 24
    end
    object actCtrl_Email_Clean: TControlAction
      Caption = 'Clean Email List'
      ImageIndex = 54
    end
    object act_Order_SaveInvoice: TControlAction
      Caption = 'Save Invoice'
      ImageIndex = 2
    end
    object actCtrl_Main_Home: TControlAction
      Caption = 'Home'
      ImageIndex = 17
    end
    object actCtrl_Main_Blog: TControlAction
      Caption = 'AvoBase Blog'
      ImageIndex = 67
    end
    object actCtrl_Account_Escrow: TControlAction
      Caption = 'Reconcile Escrow'
      ImageIndex = 59
    end
    object actCtrl_Account_Transaction: TControlAction
      Caption = 'Reconcile Transactions'
      ImageIndex = 39
    end
    object actCtrl_Reports_Customer: TControlAction
      Caption = 'Customer'
      ImageIndex = 12
    end
    object actCtrl_Reports_Order: TControlAction
      Caption = 'Order'
      ImageIndex = 40
    end
    object actCtrl_Reports_Cycle: TControlAction
      Caption = 'Cycle'
      ImageIndex = 38
    end
    object actCtrl_Report_Earning: TControlAction
      Caption = 'Earning'
      ImageIndex = 59
    end
    object actCtrl_Report_Expense: TControlAction
      Caption = 'Expense'
      ImageIndex = 57
    end
    object actCtrl_Reports_Org: TControlAction
      Caption = 'Org'
      ImageIndex = 56
    end
    object actCtrl_Reports_Product: TControlAction
      Caption = 'Product'
      ImageIndex = 34
    end
    object actCtrl_Reports_Accounting: TControlAction
      Caption = 'Accounting'
      ImageIndex = 68
    end
    object actCtrl_Accounting_Help: TControlAction
      Caption = 'Help'
      ImageIndex = 24
    end
    object actCtrl_Earning_QuickAdd: TControlAction
      Caption = 'Earning Quick Add'
      ImageIndex = 77
    end
    object actCtrl_Expense_QuickAdd: TControlAction
      Caption = 'Expense Quick Add'
      ImageIndex = 77
    end
    object actCtrl_Cust_Notes: TControlAction
      Caption = 'Notes'
      ImageIndex = 7
    end
    object actCtrl_Expense_EditTypes: TControlAction
      Caption = 'Expense Types'
      ImageIndex = 57
    end
    object actCtrl_Earning_EditTypes: TControlAction
      Caption = 'Earning Types'
      ImageIndex = 59
    end
    object actCtrl_Cust_OrdProd: TControlAction
      Caption = 'Customer Products'
      ImageIndex = 34
    end
    object act_Order_CustProd: TControlAction
      Caption = 'Generate Orders'
      ImageIndex = 11
    end
    object actViewUpdates: TControlAction
      Caption = 'View Updates'
      ImageIndex = 63
    end
    object actCtrl_Email_RequeueAll: TControlAction
      Caption = 'Requeue All'
      ImageIndex = 20
    end
    object actCtrl_Product_ImportExport: TControlAction
      Caption = 'Import Export'
      ImageIndex = 5
    end
    object actCtrl_Customer_ImportExport: TControlAction
      Caption = 'Import Export'
      ImageIndex = 5
    end
  end
end
