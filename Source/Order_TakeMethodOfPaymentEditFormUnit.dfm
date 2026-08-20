inherited OrderTakeMethodOfPaymentForm: TOrderTakeMethodOfPaymentForm
  Caption = 'OrderTakeMethodOfPaymentForm'
  ClientHeight = 333
  ClientWidth = 582
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 584
  ExplicitHeight = 335
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 582
    Height = 333
    ExplicitWidth = 582
    ExplicitHeight = 333
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 580
      Height = 331
      Caption = ''
      ExplicitWidth = 580
      ExplicitHeight = 331
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 580
        ExplicitWidth = 580
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 239
        Width = 580
        Height = 71
        ExplicitTop = 239
        ExplicitWidth = 580
        ExplicitHeight = 71
      end
      inherited ToolBar: TToolBar
        Width = 580
        ExplicitWidth = 580
      end
      inherited StatusBar: TStatusBar
        Top = 310
        Width = 580
        ExplicitTop = 310
        ExplicitWidth = 580
      end
      object CUST_INFO_BACK_PANEL: TPanel
        Left = 0
        Top = 74
        Width = 580
        Height = 133
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 4
        object CustSoldToName: TLabel
          Tag = 1
          Left = 6
          Top = 6
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
          Left = 24
          Top = 26
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
          Left = 24
          Top = 42
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
          Left = 24
          Top = 57
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
          Left = 370
          Top = 0
          Width = 210
          Height = 133
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
            Top = 108
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
            Top = 108
            Width = 60
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -12
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
          object db_void: TLabel
            Left = 147
            Top = 90
            Width = 60
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$    0.00'
            Color = 7405307
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Label1: TLabel
            Left = 1
            Top = 91
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
      object MOPEscrowPanel: TPanel
        Left = 0
        Top = 207
        Width = 580
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 5
        object credImage: TImage
          Left = 70
          Top = 3
          Width = 25
          Height = 25
          Hint = 'Credit_Hint'
          AutoSize = True
          ParentShowHint = False
          Picture.Data = {
            07544269746D6170A2070000424DA20700000000000036000000280000001900
            00001900000001001800000000006C0700002700000027000000000000000000
            0000FAFDFBFDFDFDFEFCFEFEFDFEFEFEFCFDFEFAFBFDFBFAFCFDF3F4F6E7E7E8
            DEDEDEDCDBDADBDAD8DAD9D7E3E2E1ECEBEBF9F7F8FDFDFEFCFDFEFCFEFEFDFD
            FDFDFDFDFEFEFDFEFEFDFEFEFE00F6FDF7FAFCFCFBF6FEFDF8FEFCFBF7F8FBF1
            E9EFEAD2D8DAD9DADDE6E4E0E4E2D6E2E0CEE3E0CDE4E0D0E9E3D6EAE3DDDDD5
            D7E1DFE0F1F4F6F4F9FCFAFCFEFDFCFBFEFCF8FEFEFCFEFEFE00FAFEF4FAFEF7
            FAFEFBFAFDFDF8F9FBE3E2E2DAD9D3E2DFD3D3CCB2BCB78EC2C086CDCD86D1CF
            89CCC78DC8BC91C8BE9EDFDBC3E8E8D7D6D7D0ECEDEDFAFAFDFDFCFDFEFDFBFE
            FDFDFEFEFE00FEFDF9FBFEF6F6FEF3F2FCF8DBDFE2D8D4D6D6CEBABEB589DBD2
            91F7F2A3FEFC9FFCFC9AFEFD9BFDFAA1FCF7A8ECE8A3CBCB8EC8C79AE3E1C9DA
            D7D0EDEBECFBFBFDFBFCFEFDFEFEFEFEFE00FEF7FEFBFBFBF4FCF3D4DFD6CFD6
            D0C3C0AEC6BE8CF4EF9FFEFD9EFDFDA3FBFAA8FBF8ADFBF8ABFDFCA7FDFC9FFC
            FDA0F6FAA2DEDE99C2BD91DDD6C2D6D1CDEEEEEFF4FAFCFBFDFEFEFEFE00FCF0
            FFFBF5FEE9EAEBC5CCBDBDC2A4B5B683F5F3A5FDFD9FFBFE9AF8FBAC8F8D6447
            4136464133515031BEC277FBFEA2FAFEA1FAFBA9E7E2A2C5BB92DAD4BFCFD0CA
            EEF5F6FAFDFEFEFEFE00F9F6FCF8F2FCD3CBD3C9C4B0A6A86CE7EC97F6F9A3FA
            FAACF8FCADF1F5BF61615105020A0201090E0F05A2A87BF1F8AFFAFDA9FDFDA9
            FAF4A5DBD290C4BE93CACAB9DCE2E1FAFCFDFEFEFE00F5FEF0EBEBEBC7B8C0AF
            9F83CDCB77F3F893BBBF7983805B858258818063323429020505000206050504
            565447858563D3D692FAFAA9FEFCA2F6EF99C1BA7DC3C1A4C5C7C5F7F9FAFEFE
            FE00F6FDE6D5D7CDBBACAB9E8965E8DC81F6F48C7F83530A08011A0900120900
            05080001090000090002050107030515110BA5A878F9F8AFFEF99CFCF595D2C7
            7CB6B08BB5B6B4E9EAECFEFEFE00F5F4F2BBBBB7A19C8B9D8A5AF3D583FBE587
            BBBA6E7A844E9783518D81577C805B76805B79825C7A7D5E2E2E1D090C04545A
            3F8D8A59DED282FEE98AE8C876B39E74ACAAA9D1D2D6FCFCFC00E1E2E49A9B9A
            837A6AA58854F6C96FFED86CFAE27FEFE793E9F298EDF79AF5FA98FEFC96FEF8
            9AF5EDAA5A5335050800040A00201B09B8A361F8D37BE7BD6DAF9164AB9F97BA
            B8B8F7F7F700D1D4D68A8B8C6C5E4FAA824FF7BB5FFECC5DFED16AF7D67FB3AF
            5F83843B84863B8A8639948B45847E4D2C2C170A0B0558503C87724FD2AD6CF2
            BD6AE2AD61AD8659A79388AEAAA9F7F7F700D4D3D285817E665546A07446EBA5
            55F9B457F6BC6CE8BC818E674720090307020102030104050007070007050020
            1108B48D64ECBD83F3B66CF2AC59DC9C55A57C54998881AAA7A8F6F6F600E4E2
            DA8A847E6555478B643FD69758E19F5AAD7D4E785B43472F2615050345383371
            5E4D7E634585644185634393683FE0A25DF6B266F6A958EE9F4DD29150997655
            847E7FAAABAEF7F7F700F5F6F09D9C986B5F55795838C58E57CD9359754E3518
            0801040A01070B00846F48ECBC71FEBD63FEBA67F7B373EEB074EEAF67EBA75F
            EA9E54E0934BC2864D8D735772787ABFC4C7FCFCFC00F0FAFBB8C0C369656069
            4B2EB78148C98E4D8A5E36402A191C180F0E0902655036AE8450C28948C1874C
            B58356A87F59A57E54A8774CC28753CB8B53AC7A49847056717D7ADCE2E4FDFD
            FD00EFFBFED4DEE3706E6E5F472F986833C58A48C28D50B88C606942371B0204
            0E010A0A01080D00031103010F04001105001805002D0F068E6343B17F55936B
            447A6B5587908CF1F6F7FAFAFA00FEFAFEF9F5F9A09A9C574C4758412DA17851
            C58850CE894B8354314527181A100B0202080101090503052118113524193B23
            17472A168462428E6E4C765E486D645DC4C7CCFAFCFDFEFEFE00FEFCFEFBF9FB
            DEDDDD6A66614D3E2E6E4F30A7784BBD834EBA8351AB815B4B34220D04000D06
            001B0A02775A40A78058A77B4EA1774B956F48795B3E6958488D8988EBF0F5FA
            FDFEFEFEFE00FBF9F9F8F8F8F9FBFAB4B6B2544E444836236A4B2D9C724BB57D
            47AD7B4B6B46273E22143F23144A26138C5D32AD783DAF773B986A3877563361
            4D3A6E6660DCDCDEF6FBFDFBFDFEFEFEFE00FDFDFBFCFDFBF8FDFCF0F5F4A4A6
            A14D483E3E3021583F298D6032996E4396714B93714E94704B9A7045A1723F9F
            6E3A8E63366C4C2D55443565605DC7C8CAF6F8F9FCFDFBFDFDFDFEFEFE00FEFF
            FCFEFFFCFBFFFDF8FEFDEDF2F1B3B4B156514D3A2E264A3216593F23694F3576
            5B427C5F447C5C3D7654316246294A3B2E453E3A6C6D72C7CED5F4F9FCFCFDFA
            FEFEF6FEFDFAFEFEFE00FEFEFCFEFEFCFCFFFDFAFEFDF7FAFAF8F9F9DBD8DA8C
            87874D493D383124372C1E3B2B1E3F2E204131223F3122413A3256585F9FA4AC
            E2E9EFF3FBFDF8FDFDFCFDF9FEFEF6FEFDFAFEFEFE00FFFEFEFEFEFDFEFEFCFD
            FFFCFCFDFBFBFAFBFBF8FBF8F6F8D7E0DDACB1AB7E7D755850494C443E5D5A56
            8D8F8EBDC1C1E6E8EBF9FAFAFCFDFBFCFDFBFEFEFCFEFEFCFDFEFAFDFEFCFEFE
            FE00FFFEFEFFFEFDFFFEFCFEFEFBFCFBFAFEFCFCFDF9FBF9F7FBF0FEFCF3FCF9
            EBECE8DBD9D4D3D1CFDCDDDDEAF3F5F4FCFBFEFAF6FEFCF5FFFDF4FFFEF5FEFE
            F6FCFEFCF8FEFEFCFEFEFEFEFE00}
          ShowHint = True
          Stretch = True
          Transparent = True
        end
        object credLabel: TLabel
          Left = 101
          Top = 3
          Width = 290
          Height = 13
          AutoSize = False
          Caption = 'ESCROW: $00000.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object escLabelDesc: TLabel
          Left = 101
          Top = 16
          Width = 377
          Height = 13
          Caption = 'Click the Use Escrow button to add Escrow as a Method Of Payment'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
end
