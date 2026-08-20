object Return_LineItem_Form: TReturn_LineItem_Form
  Left = 696
  Top = 18
  BorderStyle = bsNone
  Caption = 'Invoice_LineItem_Form'
  ClientHeight = 161
  ClientWidth = 837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object BACK_PANEL: TPanel
    Left = 34
    Top = 0
    Width = 803
    Height = 161
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Caption = 'BACK_PANEL'
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 728
    ExplicitHeight = 207
    object InvoceLineBackPanel: TPanel
      Left = 1
      Top = 1
      Width = 801
      Height = 159
      Align = alClient
      BevelOuter = bvNone
      Color = clSkyBlue
      ParentBackground = False
      TabOrder = 0
      ExplicitWidth = 726
      ExplicitHeight = 205
      object InvoceLineFrontPanel: TPanel
        Left = 0
        Top = 0
        Width = 801
        Height = 159
        Align = alClient
        BevelOuter = bvNone
        Caption = 'InvoceLineFrontPanel'
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 726
        ExplicitHeight = 205
        object LineItemOnePanel: TPanel
          Left = 0
          Top = 0
          Width = 801
          Height = 159
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          OnClick = InvoiceLineItemClicked
          ExplicitWidth = 726
          ExplicitHeight = 205
          object CycleNumLabel: TLabel
            Left = 209
            Top = 41
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
          object campYearLabel: TLabel
            Left = 280
            Top = 41
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
          object orgLabel: TLabel
            Left = 0
            Top = 40
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
          object CalculationGroupBox: TGroupBox
            Left = 615
            Top = 0
            Width = 186
            Height = 159
            Align = alRight
            Color = clWhite
            ParentBackground = False
            ParentColor = False
            TabOrder = 13
            OnClick = InvoiceLineItemClicked
            ExplicitLeft = 540
            ExplicitHeight = 205
            object RetailCostLabel: TLabel
              Left = 8
              Top = 6
              Width = 87
              Height = 13
              Caption = 'RETAIL COST:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = InvoiceLineItemClicked
            end
            object SellAtCostLabel: TLabel
              Left = 40
              Top = 28
              Width = 55
              Height = 13
              Caption = 'SELL AT:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = InvoiceLineItemClicked
            end
            object TaxLabel: TLabel
              Left = 83
              Top = 56
              Width = 29
              Height = 13
              Caption = 'TAX:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = InvoiceLineItemClicked
            end
            object TOtalCostLabel: TLabel
              Left = 14
              Top = 74
              Width = 100
              Height = 13
              Alignment = taRightJustify
              Caption = 'TOTAL REFUND:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              OnClick = InvoiceLineItemClicked
            end
            object tTotalCostLabel: TLabel
              Left = 120
              Top = 74
              Width = 60
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = '     0.00'
              Color = 7405307
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = False
              OnClick = InvoiceLineItemClicked
            end
            object tTotalTaxLabel: TLabel
              Left = 120
              Top = 56
              Width = 60
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = '     0.00'
              Color = 7405307
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = False
              OnClick = InvoiceLineItemClicked
            end
            object TaxRateLabel: TLabel
              Left = 18
              Top = 56
              Width = 62
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'TBD %'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object saleImage: TImage
              Left = 3
              Top = 25
              Width = 30
              Height = 30
              AutoSize = True
              Picture.Data = {
                07544269746D6170FE0A0000424DFE0A00000000000036000000280000001E00
                00001E0000000100180000000000C80A0000130B0000130B0000000000000000
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
                FEFEFEFFFEFEE5E2E2FFFFFED1CECDD2D0CFFFFFFFF2EFEFF9F8F8FFFFFFFFFF
                FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBABAB6FFFFFFCE
                C9BD785C4EF9EEDAAD91809D7E6EFBEEDE816659D2C8BFFFFFFFB9AFA6FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFF4F4F3FDF9F7FFFFFF8C7569B48B74CAA58A7835
                1EA6785A8C4A2E9B593DAC8063773924CCA18CA5846F927968FFFFFFF2ECEAF4
                F3F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFE5DEDC957A6BDFBDAAAF785E8C40208E4522A0401E97481F
                A4441EA748238E421EA34C2C924928855032A57960E3BEAA937B71E5E0DEFFFF
                FFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFEFEFEFFFF
                FFE3CAC5F8EDE87C492F874925984B23A4481E9F4518AF461BA84A1CAF481AB3
                4F22AB5427AC5023A251259B502A9D59378C52358D604BF0E7E3EBD6D0D2CACA
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFF2DBDA7E5950
                99614B9149249E4C1BA14B17954212AB5726A34819AA5524A95221A44F1EA355
                249E5220A25B29A34F22A85429A559358F4F32A06D58906E62EBDAD4FFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFE8E2E0EEE5E1986454823F219E
                4E22AC511CA44C17A15023A45025A35126A85227A5522AA25529A5572B9F5A2C
                A0592BB05B2CB55C2DB25C33AA5E399A5C3F9F6F5BF2DDD0E9E6E5F5F5F5FFFF
                FFFFFFFF0000FFFFFFFFFFFFF2E8E393776C7C4E3C8A4C3192492694451AA14D
                1CA24D1EA74E28AC4F2CA24E2CB04E2FA95233A95434B25634AA5A35AF5B35B3
                5D30B35E31B46033AF5F37A7603DA1684D8D6553927E76F5F1EFFFFFFFFFFFFF
                0000FEFEFEFFFFFFFFFFFFE8C2AB8A51338A45208F471F863E168D4A228F4821
                9F4B28A64B2C954B2CA7482FA14E35A45237B45538A95C39B35C3AAC623CAB63
                3AAF6239B3633AB26640A563459B6953E3C3B4FFFFFFFFFFFFFEFEFE0000FFFF
                FFC6BDBD977869AC785B924F26994F228740167B3E19713E2073412084461F8B
                4622764522904026884A2E8C4F31A45233975B35A25C369D613E9B5F3BA25F39
                AD6039B2633DB36C4AA2684DB289789F8378BBACA7FFFFFF0000FFFFFFFEFEFE
                B18E7E865031985730914F277A401D6E3F2357301C5E3E2266421B6D401F5A40
                1F713C21714628754C2E8950318657348E5A358B5C3D8A583B9257369E5A37A5
                5E39A66341A56C53956854AA887BFFFFFFFFFFFF0000FFFFFFCDBFBAD0AA9B92
                5D47EBD6C0FAF0DFE9DBCE80665B4A2B1E4C312071574369402D42301B5A3421
                6F402D6F47315E361E8C503A7E4E3771443276493674432D88543D824C34915E
                46986B54855D49B59481CABBB2FBF9F80000EFEFEF8571677D544087513AD8A5
                8FB08F80DBC8BDFFEDE357382BECD8CAFFFFFAFFFFFFCEC1AFEED4C45C312187
                6351987761834A386D432F6D4B3C6E493B6039276A3D288959448F604A8C624D
                906A56846351927C70EEECEB0000FDFBF9FEFEFEAE826DA46D53A16D56BF9887
                FFFBF0FEE8DE9A776DFFFFF5C6B3A6A07E73FFFFFDC1A7995E392DFFEEDFE9CF
                BF7543368B6959FEE9DFFEF8EEEFDCCD6642327C5542784E3B8C645186624FA3
                8270EBD5C9FFFFFF0000D6D3CEA78F81946650A1674DF3CDB5FFFFF7D6BDB08F
                7267A07B6EFFFFFB65524A65453EFFFFF8BAA49958362DFFFFFF9684766F463C
                E7D3C7FBF4EC90857FD1C5BB64493C674636E6CDBCFFFFF08865548D6C5B9E88
                7CC7C6C50000D0CDC8B69F9091634DA5694CDEA288FFF8E4B0988AE2C0B38559
                4AFFFFF3DFD0C57D5951EFE4DACAB1A768473EFFFFF8B3A59A6F4740FFFFFFEF
                E8E1C1BBB690837B715B4F6D5143AB897AC5A1917858488365569F8B81C2C1C0
                0000FFFFFFFFEDDEC1947CA16649A46A4DECB8A1FFF8E6FFFFEDA6745ECFA794
                FFFFF2FEE7DBFFFFF3E0C2B7916D63FBE9DEC0B0A3745045FFFEF3FEFDF4DACF
                C8FFFFFBD0B8AC85695BB59889E6C7B87F635591776BCDBCB3F7F5F40000EFEE
                ED917F75956A55AB7054BA7C60A9755BA4755EA37158B57B60B17F65C59887EA
                C1B1F0DCCADFB8A8A07667FBE5D6E5D3C28A6356CEB9AAFFFFF6C9B4A6DFCEC0
                FFFFF19A796ABCA698FFFAED856A5F766158877972D4D2D20000F7F7F7DDD2CD
                D3AA98B3775DB57758B0775BAE7B5FAF7859C48461BA7F60AF7961C2826D9E77
                5DBC8B75AB7864FCE1CDFCE1CCAA7C6A9A7E6CCEB2A1F7F0E0FBF3E1E7C2B1B1
                8C7BDBC0B0FEFDEF937B708F7D76B2A6A2F9F8F80000FEFEFEFFFFFFCEA595AF
                745CC58567BD8364B68061C08260CB8560CF8C67BA7E61CE846DBE8F72C68E75
                BE846EF7D7BFFEE9D0B78470AE8C75C29F8CB78F7DB78E78BA8F7AC29A86D7BB
                AAFEFEF1A48E869D8E87EBE2DFFFFFFF0000FFFFFFBDBCB6A38A7DBE9181B379
                65BE8068C18367C68968C78964C48866C5896ECC8C71C38D73C58C73C68D73D3
                A288D6AF95C78F77C5957EC5967DCA9A81C6967DCEA086C89E87CDB4A2FEFEF3
                BDABA5978D8DB3ADAFFFFFFF0000FEFEFEFFFFFFFFFFFFD9B9ADB8897BBF8671
                C4876EC48A6BC38D6BC48F6FC68F75C68F76C89178C99278CA937ACB947ACD96
                7CCE967DCF987ED19B81D19B81CE9C81CC9D82C79D86CCAB98EEE8DDD8CAC6FF
                FFFFFFFFFFFEFEFE0000FFFFFFFFFFFFF6F0EAA89488BA998ABA8D7CC08D76C3
                8D72C79172C79273C59479C69579C8977BCA977BCB997DCA9A7ECC9B80CD9C80
                D09E81D29F85D39F88D2A18ACEA28AC7A28DC4A898AD9C91AFA6A2EEEDEDFFFF
                FFFFFFFF0000FFFFFFFFFFFFF7F6F4E6E2DFEAE4E0AD9381B6927DBD9179C492
                7AC7967AC69878C7997AC89A7BCA9C7DCB9D7ECC9E7ECD9F80CFA181CFA182D0
                9F88D2A18CD3A590CEA793C6A794B6A092E9E4E2E3E2E0F2F2F3FFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFE4DFD2A59B8BAC9684B89582C29682C99983
                CA9B7FCC9D81CE9F83CFA084D0A185D1A186D2A387D3A488D4A58AD1A48FD1A5
                94CFA797C5A595B89D90B5A59AF3F1EFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFCFD7CDD8D7CBEAE6E3B79C8EB79387C69B8AD9AB93CD
                9F87CB9D85CD9F87CD9F87D9AB93CB9D85D9AB93D6A891D8AFA0D7B4A6C3A598
                C0A79DEAE5E3F0E8E4D8D5D0FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFEFEFEFFFFFFFFFFFFE4E2E0AA9B92D9C0B9C2A096C29A89C79E8ED7AC
                9DCEA293D4A99AD0A797D5AD9CD2A998CFA495CDAEA3BCA49BD5C0B8B1A39CE6
                E3E2FFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFF8F7F7F2EBE8FFFFFFA8938ECDB1A7CCB2AAB59890C1A49C
                BFA29AC8ACA2B3968DC9ACA3C4AAA3B8A69CA79990FFFFFFEFEAE8F5F4F4FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFBFB8B9FFFFFFCAC4C2B1A6A3FFFFFFAA9E9CB3
                A9A6FEFEFEAAA09DD5CDCBFEFEFEC0BCB6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFEFEFEFFFFFFFEFEFEFFFFFFE8E8E8FEFEFED0D1D2CED1D1FFFF
                FFEEEEEEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000}
            end
            object tInvoiceLineRetailCostEdit: TMaskEdit
              Tag = 4
              Left = 98
              Top = 5
              Width = 82
              Height = 21
              Hint = 'What Cost you are charging your Customer'
              BevelInner = bvNone
              BevelOuter = bvNone
              Color = 14933503
              Enabled = False
              EditMask = '####.##;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              MaxLength = 7
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Text = '    .  '
              OnClick = InvoiceLineItemClicked
            end
            object tInvoiceLineItemSellAtCostEdit: TMaskEdit
              Tag = 5
              Left = 98
              Top = 27
              Width = 82
              Height = 21
              Hint = 'What discount you are giving to your Customer'
              BevelInner = bvNone
              BevelOuter = bvNone
              Color = 14933503
              Enabled = False
              EditMask = '####.##;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              MaxLength = 7
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Text = '    .  '
              OnChange = InvoiceLineItemChanged
              OnClick = InvoiceLineItemClicked
            end
            object OptionsGroupBox: TGroupBox
              Left = 8
              Top = 116
              Width = 172
              Height = 33
              Caption = 'Options'
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentColor = False
              ParentFont = False
              TabOrder = 3
              OnClick = InvoiceLineItemClicked
              object tInvoiceLineItemFreeItem: TCheckBox
                Tag = 12
                Left = 21
                Top = 14
                Width = 81
                Height = 16
                Hint = 'No Charge'
                ParentCustomHint = False
                Caption = 'No Charge'
                Color = clWhite
                Ctl3D = True
                DoubleBuffered = False
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentColor = False
                ParentCtl3D = False
                ParentDoubleBuffered = False
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                WordWrap = True
                OnClick = tInvoiceLineItemFreeItemClick
              end
            end
            object tInvoiceLineItemBackOrderComboBox: TComboBox
              Tag = 9
              Left = 6
              Top = 96
              Width = 173
              Height = 19
              Hint = 'Back Ordered Options'
              BevelInner = bvLowered
              Style = csOwnerDrawVariable
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 13
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = InvoiceLineItemClicked
              Items.Strings = (
                'Back Ordered - Bill'
                'Back Ordered - No Bill'
                'Avon Missed Shipment - Bill'
                'Avon Missed Shipment - No Bill'
                'Product No Longer Available')
            end
          end
          object tInvoiceLineItemProductNumEdit: TLabeledEdit
            Left = 1
            Top = 17
            Width = 121
            Height = 22
            BevelInner = bvNone
            BevelOuter = bvRaised
            EditLabel.Width = 60
            EditLabel.Height = 14
            EditLabel.Caption = 'PRODUCT #'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object CycleNumComboBox: TComboBox
            Left = 209
            Top = 57
            Width = 70
            Height = 19
            Style = csOwnerDrawFixed
            Enabled = False
            ItemHeight = 13
            TabOrder = 6
          end
          object CycleYearComboBox: TComboBox
            Left = 280
            Top = 57
            Width = 69
            Height = 19
            Style = csOwnerDrawFixed
            Enabled = False
            ItemHeight = 13
            TabOrder = 7
            OnChange = CycleYearComboBoxChange
          end
          object orgCombo: TComboBox
            Left = 0
            Top = 57
            Width = 208
            Height = 19
            Style = csOwnerDrawFixed
            Enabled = False
            ItemHeight = 13
            TabOrder = 5
            OnChange = orgComboChange
          end
          object tInvoiceLineItemSoldQTYEdit: TLabeledEdit
            Left = 272
            Top = 17
            Width = 55
            Height = 22
            EditLabel.Width = 54
            EditLabel.Height = 14
            EditLabel.Caption = 'QTY SOLD'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            OnChange = InvoiceLineItemChanged
          end
          object tInvoiceLineItemQTYFreeEdit: TLabeledEdit
            Left = 329
            Top = 17
            Width = 55
            Height = 22
            EditLabel.Width = 50
            EditLabel.Height = 14
            EditLabel.Caption = 'QTY FREE'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            OnClick = InvoiceLineItemClicked
          end
          object tInvoiceLineItemDescriptionEdit: TLabeledEdit
            Left = 123
            Top = 17
            Width = 148
            Height = 22
            EditLabel.Width = 85
            EditLabel.Height = 14
            EditLabel.Caption = 'PRODUCT NAME'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object db_prodn1: TLabeledEdit
            Left = 0
            Top = 94
            Width = 100
            Height = 22
            EditLabel.Width = 42
            EditLabel.Height = 14
            EditLabel.Caption = 'PRODN1'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object db_prodn2: TLabeledEdit
            Left = 101
            Top = 94
            Width = 100
            Height = 22
            EditLabel.Width = 42
            EditLabel.Height = 14
            EditLabel.Caption = 'PRODN2'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 9
          end
          object tInvoiceLineItemDesc: TLabeledEdit
            Left = -1
            Top = 135
            Width = 430
            Height = 22
            EditLabel.Width = 93
            EditLabel.Height = 14
            EditLabel.Caption = 'COMMENT / SALE'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object RenameGroupBox: TGroupBox
            Left = 546
            Top = 0
            Width = 69
            Height = 159
            Align = alRight
            Caption = 'RETURN'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 14
            ExplicitLeft = 545
            ExplicitHeight = 444
            object db_qtyret: TLabeledEdit
              Left = 8
              Top = 32
              Width = 55
              Height = 22
              Color = 15459070
              EditLabel.Width = 54
              EditLabel.Height = 14
              EditLabel.Caption = 'QUANTITY'
              EditLabel.Font.Charset = DEFAULT_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -11
              EditLabel.Font.Name = 'Arial'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 5
              ParentFont = False
              TabOrder = 0
              OnChange = InvoiceLineItemChanged
              OnClick = InvoiceLineItemClicked
            end
          end
          object qtyPriorReturnedEdit: TLabeledEdit
            Left = 386
            Top = 17
            Width = 55
            Height = 22
            EditLabel.Width = 55
            EditLabel.Height = 14
            EditLabel.Caption = 'PRIOR RET'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            OnClick = InvoiceLineItemClicked
          end
          object db_prodn3: TLabeledEdit
            Left = 203
            Top = 94
            Width = 100
            Height = 22
            EditLabel.Width = 42
            EditLabel.Height = 14
            EditLabel.Caption = 'PRODN3'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object db_prodn4: TLabeledEdit
            Left = 305
            Top = 94
            Width = 100
            Height = 22
            EditLabel.Width = 42
            EditLabel.Height = 14
            EditLabel.Caption = 'PRODN4'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Arial'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 11
          end
        end
      end
    end
  end
  object LINE_ITEM_SIDE_PANEL: TPanel
    Left = 0
    Top = 0
    Width = 34
    Height = 161
    Align = alLeft
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    OnClick = InvoiceLineItemClicked
    ExplicitHeight = 207
    object MenuBackPanel: TPanel
      Left = 0
      Top = -1
      Width = 33
      Height = 36
      BorderWidth = 1
      Color = clWhite
      TabOrder = 0
      object OrderProductNumPanel: TPanel
        Left = 1
        Top = 0
        Width = 34
        Height = 40
        Align = alCustom
        Caption = '01'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = InvoiceLineItemClicked
      end
    end
  end
end
