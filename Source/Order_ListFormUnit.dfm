inherited OrderListForm: TOrderListForm
  Left = 342
  Top = 15
  Caption = 'OrderListForm'
  ClientHeight = 251
  ClientWidth = 479
  Color = clWhite
  ExplicitWidth = 479
  ExplicitHeight = 251
  PixelsPerInch = 96
  TextHeight = 13
  inherited border_panel: TPanel
    Width = 479
    Height = 251
    ExplicitWidth = 479
    ExplicitHeight = 251
    inherited BASE_TOP_CAPTION_PANEL: TPanel
      Width = 479
      ExplicitWidth = 479
    end
    inherited StatusBar: TStatusBar
      Top = 230
      Width = 479
      ExplicitTop = 230
      ExplicitWidth = 479
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Width = 479
      Height = 72
      ExplicitWidth = 479
      ExplicitHeight = 72
      object Label5: TLabel [0]
        Left = 48
        Top = 51
        Width = 54
        Height = 14
        Caption = 'Sort By:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel [1]
        Left = 52
        Top = 28
        Width = 50
        Height = 14
        Caption = 'List By:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel [2]
        Left = 21
        Top = 5
        Width = 82
        Height = 14
        Caption = 'Order Types'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 329
        Width = 150
        Height = 72
        Caption = ''
        Color = clWhite
        ParentBackground = False
        ExplicitLeft = 329
        ExplicitWidth = 150
        ExplicitHeight = 72
      end
      object SortViewComboBox: TComboBox
        Left = 106
        Top = 48
        Width = 145
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
        Text = 'LASTEST TO EARLIEST'
        OnChange = ComboBoxChange
        Items.Strings = (
          'LASTEST TO EARLIEST'
          'EARLIEST TO LATEST')
      end
      object SortTypeComboBox: TComboBox
        Left = 106
        Top = 25
        Width = 145
        Height = 19
        BevelInner = bvLowered
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ItemIndex = 1
        ParentFont = False
        TabOrder = 2
        Text = 'ORDER NUMBER'
        OnChange = ComboBoxChange
        Items.Strings = (
          'STATUS'
          'ORDER NUMBER'
          'CAMPAIGN'
          'CUSTOMER NAME'
          'DATE'
          'TIME')
      end
      object ShowOrderTypesComboBox: TComboBox
        Left = 106
        Top = 2
        Width = 145
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
        Text = 'OPEN'
        OnChange = ComboBoxChange
        Items.Strings = (
          'OPEN'
          'CLOSED'
          'CANCELLED'
          'ALL')
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Top = 92
      Width = 479
      Height = 138
      ExplicitTop = 92
      ExplicitWidth = 479
      ExplicitHeight = 138
    end
  end
  object OrderOptionsMenu: TPopupMenu
    Images = IMG_StorageForm.Avobase_25x25_Images
    Left = 60
    Top = 151
    object ordOpt_LoadOrder: TMenuItem
      Caption = 'Load Order'
      ImageIndex = 20
      OnClick = ordOpt_LoadOrderClick
    end
    object CreateReturnAgainstOrder1: TMenuItem
      Caption = 'Create Return Against Closed Order'
      ImageIndex = 51
      OnClick = CreateReturnAgainstOrder1Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object akeaPayment1: TMenuItem
      Caption = 'Take a Payment'
      ImageIndex = 18
      OnClick = akeaPayment1Click
    end
    object VoidaPayment1: TMenuItem
      Caption = 'Void a Payment'
      ImageIndex = 7
      OnClick = VoidaPayment1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object CloseOrderReturn: TMenuItem
      Caption = 'Close Order/Return/Delinquent'
      ImageIndex = 29
      OnClick = CloseOrderReturnClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object ordOpt_ViewInvoice: TMenuItem
      Caption = 'View Invoice'
      ImageIndex = 1
      OnClick = ordOpt_ViewInvoiceClick
    end
    object viewOrderAccount: TMenuItem
      Caption = 'View Order/Return Account'
      ImageIndex = 46
      OnClick = viewOrderAccountClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object ordOpt_EmailInvoice: TMenuItem
      Caption = 'Email Invoice'
      ImageIndex = 21
      OnClick = ordOpt_EmailInvoiceClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ordOpt_ChangeOrderCampaign: TMenuItem
      Caption = 'Change Order Organization or Sales Cycle'
      ImageIndex = 6
      OnClick = ordOpt_ChangeOrderCampaignClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object EditCustomer1: TMenuItem
      Caption = 'Edit Customer'
      ImageIndex = 12
      OnClick = EditCustomer1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ordOpt_CanceLOrder: TMenuItem
      Caption = 'Cancel Order/Return'
      ImageIndex = 7
      OnClick = ordOpt_CanceLOrderClick
    end
    object ordOpt_UncancelOrder: TMenuItem
      Caption = 'Un-Cancel Order/Return'
      ImageIndex = 41
      OnClick = ordOpt_UncancelOrderClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object None1: TMenuItem
      Caption = 'None'
      ImageIndex = 23
    end
  end
end
