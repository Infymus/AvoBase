object PreferencesForm: TPreferencesForm
  Left = 343
  Top = 9
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 518
  ClientWidth = 771
  Color = clNavy
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BASE_BACKPANEL: TPanel
    Left = 0
    Top = 0
    Width = 771
    Height = 518
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object MAIN_BACK_PANEL: TPanel
      Left = 1
      Top = 1
      Width = 769
      Height = 516
      Align = alClient
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clCream
      ParentBackground = False
      TabOrder = 0
      object PREF_DOCK_PANEL: TPanel
        Left = 197
        Top = 0
        Width = 568
        Height = 512
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
      end
      object MENU_DOCK_PANEL: TPanel
        Left = 0
        Top = 0
        Width = 197
        Height = 512
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        object TOP_MENU_DOCK_PANEL: TPanel
          Left = 0
          Top = 0
          Width = 197
          Height = 78
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object SETTINGS_LABEL: TLabel
            Left = 16
            Top = 0
            Width = 113
            Height = 13
            Caption = 'AvoBase Settings'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SettingImage: TImage
            Left = 1
            Top = 2
            Width = 12
            Height = 12
            Picture.Data = {
              07544269746D6170A2070000424DA20700000000000036000000280000001900
              00001900000001001800000000006C0700002700000027000000000000000000
              0000FDFEFEFDFEFEFEFEFEFEFEFDFEFEFDFDFDFCFEFDFCF8F7F6F5F4F4FAFAFA
              A09FA0616063929193CDCDCD8081808C8C8BE5E4E3FAFAF8FDFCFAFDFCFBFDFD
              FCFDFDFDFBFCFCFDFDFDFEFEFE04FCFEFEFCFEFEFEFEFEFFFEFCFEFCF8FEFCF8
              EAE9E49C9995979293CFCCC97675735E5C625E5D60686A645E5F5963615FAAA7
              A3D7D5D0DDDAD5FBF9F5FDFCFBFAFBFBFAFBFCFDFDFDFEFEFE04FCFEFEFDFEFE
              FEFEFDFEFEFDFEFDFCFDFCFBCBCBCB6F6D6D6E62627A72676D685B6F6A65706D
              636C6B596F685C625B595D5D5D6E6D6D80807EDADAD8F9F9F8FCFCFCFCFDFDFC
              FDFDFEFEFE04FFFEFDFEFEFDFEFEFEFCFDFEEBEDEFE7EAECC8CBCD6F72716F72
              667A767D857F898988848B88868581867E7F7573786865696B696C6F686A6E92
              9395EEEFF0FAFAF9FEFDFCFEFEFDFEFEFE04FFFEFBFEFEFBFCFCFDEBEFF0979B
              A07F8388898D9078797A8C8A87958DA1908F93899573848B728D858E8C848586
              85787A7C7F6A6E72555A5F565A5FB0B2B4F8F8F7FDFCF9FDFDFBFEFEFE04FEFD
              F8FEFCFAFBFCFCD7DBDE7E8388787B7D7E7D7B8C8B888B9390908669A37B48B2
              7C42A8733688693375725586897F8886837A7B7B686C70696E747C7F82D3D3D3
              FBFAF6FEFEFCFEFEFE04FDFBF5FEFEFBFAFCFDEEF2F49FA1A4868581958E839B
              8A80906B63BB9A4ED3AF4EC68F49CC9B47D5AE40A98342825E51968B7D8F8982
              7A7A7A76797E7A7D808D8C8CECEAE6FEFDFBFEFEFE04FEFDF8FAF9F7D0D2D3B5
              B9BC9D9D9D938D83988A758D714CD4973EB186408376627D7F8F827E7E937542
              D19E38BC8A348371599D928288847F797C7E5B5E61656565A3A19DF7F6F5FEFE
              FE04FCF9F8EAE9E7979998868B8B8C8E8A978D7D8E78559B7D4A978048988580
              9699A37E95868A9589AE97979A744DC09B568B6C429F93818B8986757472605E
              5C565454656261D1D0CFFCFCFC04FDF8FDE6E3E4989D948D98908D948F968B75
              977137B98A3A8B8466989D928690937C848D7876799E8E89A58C7EAC844FB17D
              2F948E84828B968D847D9484777971716A646ACECCCEF6F6F604FDFAFCF9F9F4
              D1D5CB919894939297907A75A2714BB177459A8C9980747E837472A39992C0BD
              B4AAA998A29C7EA08043B27C369A928A898F9A9188809D9084807C7D6D6C70D3
              D2D3FDFDFD04F9FAF9E2E3DCB3B7AB9A9D9A9790998E7273AD7657B17447918C
              9E5A4D51765F4FD9CFC2F4F8F7BABEBBA69D85A57F47AD793F9D939091949D91
              887F736A6063656765686A8B8C8BF0F0F004F6F8FBB1B3AEA4A89CA4A6A0A19A
              9B92786BB07E4FB37E3F94998F505041514B3AD4D9D9D5E1F0A8A5B5B08D79BB
              814E9C7146A69E9F93939A847A704F4A434B52565D6262939493EFEFEF04F4F4
              FAAEAFB0A2A49AACAEA4A8A49C99856AAB8542B78C3C9C957E8F9084505A5C99
              ADBE9EAEC2B5A9A0B17E48C388459A7B5FA5A1A698979BA2988D86837F4F575E
              A1A5A5E5E5E3F7F7F704F8F8FEDDDEDD92938A9B9D95ABA8A3A3957E947637C9
              A14C97754EB5A596ACAEB1A7AFB0B1AC96A3884FC89B46A07530AD9E8FA0A3AC
              A2A1A3AEA397959291595F69B4B3B2FAF9F7FCFCFC04F7FAFAF5F7F1C8CABFB3
              B3B3B2AEB9A99B9B9B7E5DAC823FD4A24AA28141968358A48852B99145D8AC5C
              A07E45A18F73B1AEA8959FAA7F7F807E72667D797A5E626E6F6765DEDAD7FDFD
              FD04FAFDF8EAEBE3C2C4BBBFBFC2BCB7C9B3A6B5B49C96987551B08323C8A548
              CAAD61DAB362D6AA53AF7A3DA99187B3B0B9A6A9A79EA8B182838361584F6864
              667F808A948C8BF1ECEAFDFDFD04FBFBFBF6F6F6C1C1C1A3A3A3AAAAAABEBEBE
              AAAAAAA4A19EA0907C877358856E508E775A9F8D76BBB2A6B4B4B2AAADAFB2B2
              B2B0B0B0A1A1A1727272A0A0A0DFDFDFECECECFDFDFDFEFEFE04FCFCFCFCFCFC
              EEEEEEBCBCBCAFAFAFC9C9C9C4C4C4B0AFAEAEA9A2B6AEA3BFB3A4BFB2A2BDB3
              A8B6B4B1B0B5BBA7ACB28F8F8FA1A1A19595956565658A8A8AECECECFBFBFBFD
              FDFDFEFEFE04FBFBFBFCFCFCFCFCFCE4E4E4CACACACBCBCBBDBDBDC3C4C5C0C5
              CABCBEC0B9B8B5C1BDB8C1BFBCBDBFC1B7BDC4A7ACB270707068686873737368
              6868737373DFDFDFFBFBFBFDFDFDFEFEFE04FCFCFCFAFAFAFCFCFCF0F0F0CFCF
              CFC8C8C8B4B4B4C2C3C4C9CED4B9BDC1C4C4C4CBC9C6BBB9B59B9A98BCBDBEB2
              B3B5898989737373A5A5A5ABABABB6B6B6F5F5F5F9F9F9FDFDFDFEFEFE04FEFE
              FEFEFEFEFEFEFEFDFDFDEDEDEDD3D3D3C1C1C1C7C8C8CACACAAEACABBDBAB6D5
              D0C9B6B0A8948E869C979095928E8A8A8A8E8E8EDADADAFDFDFDFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFE04FEFEFEFEFEFEFEFEFEFEFEFEFCFCFCF6F6F6E7E7E7CB
              CBCAC6C3BEC4C0BBB5B2ACC0BCB5BBB6B0A8A49C8D888095928D7676768D8D8D
              E7E7E7FDFDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE04FEFEFEFEFEFEFEFEFEFD
              FDFDFCFCFCFDFDFDFAFAFAF8F8F7E5E3DFCAC8C6B5B5B4B5B6B5AAACADA4A5A5
              ABACABE7E7E6D4D4D4DDDDDDFAFAFAFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FE04FEFEFEFEFEFEFEFEFEFDFDFDFCFCFCFDFDFDFCFCFCFDFDFDFBFBFAECEDED
              DEE1E3ECF1F5E0E6EBB5BBC3D3D9DEF6FAFBFCFCFCFBFBFBFCFCFCFDFDFDFEFE
              FEFEFEFEFEFEFEFEFEFEFEFEFE04}
            Stretch = True
          end
          object MOPButtonBar: TToolBar
            Left = 1
            Top = 20
            Width = 82
            Height = 50
            Align = alNone
            AutoSize = True
            ButtonHeight = 50
            ButtonWidth = 37
            Caption = 'ToolBar1'
            Color = clCream
            DisabledImages = IMG_StorageForm.Disable_Img
            EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = IMG_StorageForm.Avobase_ToolBar_Img
            GradientDrawingOptions = []
            ParentColor = False
            ShowCaptions = True
            TabOrder = 0
            Wrapable = False
            object ToolButton1: TToolButton
              Left = 0
              Top = 0
              Action = actHelp
            end
            object ToolButton2: TToolButton
              Left = 37
              Top = 0
              Width = 8
              Caption = 'ToolButton2'
              ImageIndex = 5
              Style = tbsSeparator
            end
            object topSaveButton: TToolButton
              Left = 45
              Top = 0
              Action = actSave
              Caption = 'Close'
              ImageIndex = 4
            end
          end
          object SPLIT_LINE_PANEL: TPanel
            Left = 16
            Top = 14
            Width = 181
            Height = 1
            BevelOuter = bvNone
            Color = clNavy
            ParentBackground = False
            TabOrder = 1
          end
        end
        object PrefBar: TToolBar
          Left = 0
          Top = 78
          Width = 197
          Height = 434
          Cursor = crHandPoint
          Align = alClient
          AutoSize = True
          ButtonHeight = 36
          ButtonWidth = 170
          Caption = 'PrefBar'
          Color = clWhite
          DisabledImages = IMG_StorageForm.Disable_Img
          EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
          EdgeInner = esNone
          EdgeOuter = esNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          GradientEndColor = clWhite
          GradientStartColor = clWhite
          HotTrackColor = clWhite
          Images = IMG_StorageForm.Avobase_ToolBar_Img
          List = True
          ParentColor = False
          ParentFont = False
          ShowCaptions = True
          TabOrder = 1
          OnCustomDraw = PrefBarCustomDraw
          object generalSettingsButton: TToolButton
            Tag = 8
            Left = 0
            Top = 0
            Action = actGeneralSettings
            Wrap = True
          end
          object representativeSettingsButton: TToolButton
            Tag = 2
            Left = 0
            Top = 36
            Action = actRepSettings
            Wrap = True
          end
          object organizationsButton: TToolButton
            Left = 0
            Top = 72
            Action = actOrganizations
            Wrap = True
          end
          object taxesButton: TToolButton
            Tag = 3
            Left = 0
            Top = 108
            Action = actTaxRates
            Wrap = True
          end
          object earningTypesButton: TToolButton
            Left = 0
            Top = 144
            Action = actEarningTypes
            Wrap = True
          end
          object expenseTypesButton: TToolButton
            Left = 0
            Top = 180
            Action = actExpenseTypes
            Wrap = True
          end
          object emailButton: TToolButton
            Tag = 10
            Left = 0
            Top = 216
            Action = actEmailSettings
            Wrap = True
          end
          object feesButton: TToolButton
            Left = 0
            Top = 252
            Action = actOrderFees
            Caption = 'Fee Rates'
            Wrap = True
          end
          object invoiceSettingsButton: TToolButton
            Left = 0
            Top = 288
            Action = actInvoiceSettings
            Wrap = True
          end
          object ToolButton3: TToolButton
            Left = 0
            Top = 324
            Action = actProductSettings
            Wrap = True
          end
          object shippingRatesButton: TToolButton
            Left = 0
            Top = 360
            Action = actShippingRates
            Wrap = True
          end
        end
      end
    end
  end
  object ActionList: TActionList
    Images = IMG_StorageForm.Avobase_ToolBar_Img
    OnUpdate = ActionListUpdate
    Left = 223
    Top = 26
    object actSave: TAction
      Tag = 1
      Caption = 'Save'
      ImageIndex = 2
      OnExecute = ActionListExecute
    end
    object actCancel: TAction
      Tag = 2
      Caption = 'Cancel'
      ImageIndex = 3
      OnExecute = ActionListExecute
    end
    object actHelp: TAction
      Caption = 'Help'
      ImageIndex = 24
      OnExecute = ActionListExecute
    end
    object actRegistration: TAction
      Caption = 'Donate!'
      ImageIndex = 42
      OnExecute = ActionListExecute
    end
    object actGeneralSettings: TAction
      Caption = 'General Settings'
      ImageIndex = 11
      OnExecute = ActionListExecute
    end
    object actRepSettings: TAction
      Caption = 'Sales Rep Settings'
      ImageIndex = 12
      OnExecute = ActionListExecute
    end
    object actEmailSettings: TAction
      Caption = 'Email Configuration'
      ImageIndex = 23
      OnExecute = ActionListExecute
    end
    object actOrganizations: TAction
      Caption = 'Sales Organizations'
      ImageIndex = 56
      OnExecute = ActionListExecute
    end
    object actOrderFees: TAction
      Caption = 'Order Fees'
      ImageIndex = 57
      OnExecute = ActionListExecute
    end
    object actTaxRates: TAction
      Caption = 'Tax Groups/Rates'
      ImageIndex = 39
      OnExecute = ActionListExecute
    end
    object actShippingRates: TAction
      Tag = 8
      Caption = 'Shipping Rates'
      ImageIndex = 55
      OnExecute = ActionListExecute
    end
    object actEarningTypes: TAction
      Caption = 'Earning Types'
      ImageIndex = 39
      OnExecute = ActionListExecute
    end
    object actExpenseTypes: TAction
      Caption = 'Expense Types'
      ImageIndex = 57
      OnExecute = ActionListExecute
    end
    object actInvoiceSettings: TAction
      Caption = 'Invoice Settings'
      ImageIndex = 36
      OnExecute = ActionListExecute
    end
    object actProductSettings: TAction
      Caption = 'Product Settings'
      ImageIndex = 34
      OnExecute = ActionListExecute
    end
  end
end
