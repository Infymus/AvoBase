object Invoice_LineItem_SimpleForm: TInvoice_LineItem_SimpleForm
  Left = 696
  Top = 18
  BorderStyle = bsNone
  Caption = 'Invoice_LineItem_SimpleForm'
  ClientHeight = 198
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BACK_PANEL: TPanel
    Left = 35
    Top = 0
    Width = 744
    Height = 198
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Caption = 'BACK_PANEL'
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object InvoceLineBackPanel: TPanel
      Left = 1
      Top = 1
      Width = 742
      Height = 196
      Align = alClient
      BevelOuter = bvNone
      Color = clNavy
      ParentBackground = False
      TabOrder = 0
      object InvoceLineFrontPanel: TPanel
        Left = 0
        Top = 0
        Width = 742
        Height = 196
        Align = alTop
        BevelOuter = bvNone
        Caption = 'InvoceLineFrontPanel'
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object LineItemOnePanel: TPanel
          Left = 0
          Top = 0
          Width = 742
          Height = 196
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
          ExplicitLeft = -2
          object CycleNumLabel: TLabel
            Left = 209
            Top = 38
            Width = 63
            Height = 14
            Caption = 'CYCLE NUM'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = InvoiceLineItemClicked
          end
          object campYearLabel: TLabel
            Left = 281
            Top = 38
            Width = 67
            Height = 14
            Caption = 'CYCLE YEAR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = InvoiceLineItemClicked
          end
          object orgLabel: TLabel
            Left = 0
            Top = 36
            Width = 80
            Height = 14
            Caption = 'ORGANIZATION'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = InvoiceLineItemClicked
          end
          object CalculationGroupBox: TGroupBox
            Left = 556
            Top = 0
            Width = 186
            Height = 196
            Align = alRight
            Color = clWhite
            ParentBackground = False
            ParentColor = False
            TabOrder = 12
            OnClick = InvoiceLineItemClicked
            object RetailCostLabel: TLabel
              Left = 8
              Top = 29
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
              Top = 51
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
              Top = 92
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
              Left = 32
              Top = 110
              Width = 82
              Height = 13
              Alignment = taRightJustify
              Caption = 'TOTAL COST:'
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
              Top = 110
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
              Top = 92
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
              Top = 92
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
              OnClick = InvoiceLineItemClicked
            end
            object saleImage: TImage
              Left = 4
              Top = 48
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
              OnClick = InvoiceLineItemClicked
            end
            object db_taxclasslabel: TLabel
              Left = 7
              Top = 160
              Width = 50
              Height = 12
              Caption = 'Tax Group'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = InvoiceLineItemClicked
            end
            object Label1: TLabel
              Left = 7
              Top = 128
              Width = 59
              Height = 12
              Caption = 'Back Order:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = InvoiceLineItemClicked
            end
            object Label2: TLabel
              Left = 19
              Top = 7
              Width = 75
              Height = 13
              Caption = 'YOUR COST:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = InvoiceLineItemClicked
            end
            object backOrderCombo: TComboBox
              Tag = 9
              Left = 7
              Top = 141
              Width = 173
              Height = 19
              Hint = 'Back Ordered Options'
              BevelInner = bvLowered
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ItemHeight = 13
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              TabStop = False
              OnChange = backOrderComboChange
              OnClick = InvoiceLineItemClicked
              Items.Strings = (
                'Back Ordered - Bill'
                'Back Ordered - No Bill'
                'Avon Missed Shipment - Bill'
                'Avon Missed Shipment - No Bill'
                'Product No Longer Available')
            end
            object db_taxclass: TComboBox
              Left = 7
              Top = 172
              Width = 174
              Height = 19
              BevelInner = bvLowered
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGreen
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ItemHeight = 13
              ParentFont = False
              TabOrder = 5
              TabStop = False
              OnChange = db_taxclassChange
              OnClick = InvoiceLineItemClicked
              OnKeyDown = db_taxclassKeyDown
            end
            object lineItemFreeCheckBox: TCheckBox
              Tag = 12
              Left = 98
              Top = 73
              Width = 69
              Height = 16
              Hint = 'No Charge'
              ParentCustomHint = False
              TabStop = False
              Caption = 'No Charge'
              Color = clWhite
              Ctl3D = True
              DoubleBuffered = False
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
              TabOrder = 3
              WordWrap = True
              OnClick = lineItemFreeCheckBoxClick
            end
            object retailCostEdit: TMaskEdit
              Tag = 5
              Left = 98
              Top = 26
              Width = 83
              Height = 21
              Hint = 'What discount you are giving to your Customer'
              BevelInner = bvNone
              BevelOuter = bvNone
              Color = 14933503
              EditMask = '####.##;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
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
            object sellAtCostEdit: TMaskEdit
              Tag = 5
              Left = 98
              Top = 48
              Width = 83
              Height = 21
              Hint = 'What discount you are giving to your Customer'
              BevelInner = bvNone
              BevelOuter = bvNone
              Color = 14933503
              EditMask = '####.##;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              MaxLength = 7
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Text = '    .  '
              OnChange = InvoiceLineItemChanged
              OnClick = InvoiceLineItemClicked
              OnKeyPress = sellAtCostEditKeyPress
            end
            object YcostEdit: TMaskEdit
              Tag = 5
              Left = 98
              Top = 4
              Width = 83
              Height = 21
              Hint = 'What discount you are giving to your Customer'
              BevelInner = bvNone
              BevelOuter = bvNone
              Color = 14933503
              EditMask = '####.##;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              MaxLength = 7
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Text = '    .  '
              OnChange = InvoiceLineItemChanged
              OnClick = InvoiceLineItemClicked
            end
          end
          object productNumberEdit: TLabeledEdit
            Left = 1
            Top = 15
            Width = 121
            Height = 22
            BevelInner = bvNone
            BevelOuter = bvRaised
            Color = 13421823
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
            MaxLength = 20
            ParentFont = False
            TabOrder = 0
            OnChange = productNumberEditChange
            OnClick = InvoiceLineItemClicked
            OnExit = productNumberEditExit
          end
          object CycleNumComboBox: TComboBox
            Left = 210
            Top = 54
            Width = 70
            Height = 19
            BevelInner = bvLowered
            Style = csOwnerDrawFixed
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 5
            OnClick = InvoiceLineItemClicked
          end
          object CycleYearComboBox: TComboBox
            Left = 281
            Top = 54
            Width = 69
            Height = 19
            BevelInner = bvLowered
            Style = csOwnerDrawFixed
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 6
            OnChange = CycleYearComboBoxChange
            OnClick = InvoiceLineItemClicked
          end
          object orgCombo: TComboBox
            Left = 1
            Top = 54
            Width = 208
            Height = 19
            BevelInner = bvLowered
            Style = csOwnerDrawFixed
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 4
            OnChange = orgComboChange
            OnClick = InvoiceLineItemClicked
          end
          object qtySoldEdit: TLabeledEdit
            Left = 335
            Top = 15
            Width = 55
            Height = 22
            Color = 13421823
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
            Font.Style = [fsBold]
            MaxLength = 3
            ParentFont = False
            TabOrder = 2
            OnChange = InvoiceLineItemChanged
            OnClick = InvoiceLineItemClicked
          end
          object qtyFreeEdit: TLabeledEdit
            Left = 393
            Top = 15
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
            Font.Style = [fsBold]
            MaxLength = 3
            ParentFont = False
            TabOrder = 3
            OnClick = InvoiceLineItemClicked
          end
          object productNameEdit: TLabeledEdit
            Left = 123
            Top = 15
            Width = 211
            Height = 22
            Color = 13421823
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
            Font.Style = [fsBold]
            MaxLength = 40
            ParentFont = False
            TabOrder = 1
            OnClick = InvoiceLineItemClicked
          end
          object descriptionEdit: TLabeledEdit
            Left = 1
            Top = 90
            Width = 237
            Height = 22
            EditLabel.Width = 56
            EditLabel.Height = 14
            EditLabel.Caption = 'COMMENT'
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
            Font.Style = [fsBold]
            MaxLength = 40
            ParentFont = False
            TabOrder = 7
            OnClick = InvoiceLineItemClicked
          end
          object db_prodn1: TLabeledEdit
            Left = 1
            Top = 130
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
            Font.Style = [fsBold]
            MaxLength = 40
            ParentFont = False
            TabOrder = 8
            OnClick = InvoiceLineItemClicked
          end
          object db_prodn2: TLabeledEdit
            Left = 103
            Top = 130
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
            Font.Style = [fsBold]
            MaxLength = 40
            ParentFont = False
            TabOrder = 9
            OnClick = InvoiceLineItemClicked
          end
          object db_prodn3: TLabeledEdit
            Left = 1
            Top = 170
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
            Font.Style = [fsBold]
            MaxLength = 40
            ParentFont = False
            TabOrder = 10
            OnClick = InvoiceLineItemClicked
          end
          object db_prodn4: TLabeledEdit
            Left = 103
            Top = 170
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
            Font.Style = [fsBold]
            MaxLength = 40
            ParentFont = False
            TabOrder = 11
            OnClick = InvoiceLineItemClicked
          end
        end
      end
    end
  end
  object LINE_ITEM_SIDE_PANEL: TPanel
    Left = 0
    Top = 0
    Width = 35
    Height = 198
    Align = alLeft
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    OnClick = InvoiceLineItemClicked
    object saleBtn: TSpeedButton
      Left = 1
      Top = 41
      Width = 30
      Height = 30
      Hint = 'Invoice Line Item|Click for Options such as Discounts'
      Flat = True
      Glyph.Data = {
        FE0A0000424DFE0A00000000000036000000280000001E0000001E0000000100
        180000000000C80A0000C40E0000C40E00000000000000000000F9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFDBE1EEC8D0E4C8D1E7CFD5
        E7F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFFF9FFFFF9FFFFD9E9FF4C66B7274BBE2C51CD2E47AC8C95CB
        F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFD2DF
        FFE8F2FFF9FFFFF9FFFFC1DDFD2F51B81441D21D4BE73152D85D70BAF9FFFFF9
        FFFFF9FFFFF2F9FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF7296D83C5BB36A84D7
        C1D9FAC8E5FE8FAEE7254CAF2657DD1549E0224FDD395ABEB4D0FED5F0FFBED6
        FB6F85C3606FB8C6CEFAF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFE8F5FF7BA0E11B4BB02F5DDA2A50CF445CCC3F
        5DBB375DB52857C0154ECB1953E1184DDE2149CA2B4BB56E8CD93C5CB92F51C0
        3153C13D5BAED0E9FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFCCD7F93459AE3166DC1B54D52555DC3050DE2D55D52455
        C71856C5155FD30B55D50E4ED31A4DCE345BD82D53C2254FC92250DA204ED42A
        54B56485B6F9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFEFF8FF577EC53168D51A53D1275FDE1D5AD4205BD82869DE2871E0
        2773E62472E8256FE1276ADA1951C9245BCB2158D5194ED72554D7365ABB7991
        BFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFAEDAFB2960C13062E21E58D5176BD1206CE03078ED236BDB1B63D616
        5FD21967D12774DC337CEF175BC01A5ACA2057D82D56D14F69C4D8E1FFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        BFE5FF3A70C91B5BE0135FE1176AE62671F11C5EE21D5ADB2360DB2060D4175E
        D11360D60F5FD93D89F9175BD2225DD22A56BE92B1EFDBEDFEF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFC5E1FA81B1E923
        5FC12067DF1E6DE81F6EF21C65E9195BDC336EE24276DD4A7FE03B76DC1D63D7
        105EDF115DE42B74F81958D22C61C95681CDC7E6FFDBF2FFF9FFFFF9FFFFF9FF
        FFF9FFFF0000F9FFFFF9FFFFF9FFFFBBD4EB6389C94E7FD33B71CE296BD12072
        DA1A73DE1D6CE5226CE4286AD65085DD98BEF7A1C4FC6F9CDF3272CF1E6CE011
        60F41B69F22067DF2160C7356EC63568B15A81B896B0CFF9FFFFF9FFFFF9FFFF
        0000F9FFFFF9FFFFF9FFFF98BDE5326CCF286DDF2C6EE12B6ED91F72D41A72DA
        2372DD206CCF2F6EBE9DC9F9DDF5FFE5F7FBC9E6FE5F98DD2172D60659E01F6E
        ED226DDD1E65D01D62D22868DA2A5EC25376B4F9FFFFF9FFFFF9FFFF0000F9FF
        FFF9FFFFF9FFFF7DB2E52477E71170EC1C6BE72A70E32570E1206EE81864DD31
        7AE02361A6C6EEFFEFFEFCF1F8F1E1F7FE6095DD2575E51664DF2371E21E6AD4
        1A67D61864E40F57E3215CD94C71C4F2FBFFF9FFFFF9FFFF0000F9FFFFF9FFFF
        F9FFFF8DC3F1297BDB1F7DE52778E23175E7276AE81A62EE1E6BF71A64DC1150
        A690BAE9E1F4FFEEF7FEB8D1FF4A81E01163E82366E02C71E5246DD81E6BDA1B
        69E4165EE1255ACF5C7FCBF2FBFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFCC
        E5F87CA6DE5691D14884CB3C7CDC2770E81565EC196BF32676F2155CC21A50A0
        6A8ED07B9AD8547ED42668D51770F12A67ED2B6DED2167DA2B75DD296FD32765
        C04E7BC69EB8E6F9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFA5D5FB3274C3287BEC1D76ED0C5DD82072E53282EA1D65C90A48AC14
        4EB52766D32B76E61A70E22168F02069EB2671E6296FD0619CE1B8E3FFD1ECFF
        F9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        B2E8FF3984D3257FF31B74EA1F63DE024EBB1F76D42C87E2257FE2287CEB2F7D
        F22E76ED1F64D91A73EF186EE72576E63175CDA3D3F6D7F2FBF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF2FDFF8CBDE93C
        89DF0E71E81981F72D83EF1D75DD0054B3035BB7186FD51367D80758C70655C0
        1D69D51474F11E7AEF2376DC407FD17A9DD7F2FBFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFE1F1FE90BCE5458EDD2587
        F30F7DF11984EE1E7CE92A7FE8206ED60E51C30A56CF1069D91C7CE11F7FE212
        77EE197BEA267CDD4080D18CB0E7B0BDDCF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFD1DDE6A7CBED7FBAF8307FD53593F4
        137EE12580E53D89F43780F22777F3217AF81477E81D85E72288DD1479DC2584
        E52A7ED64D8ED8ABD4FFB0C1DDF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFBBD6EC9FCBF299D1FA6BACE36CB2EE75
        BAF45196E83A8DF2167CEC1689F9147EE4378CDB75B8EF5FADEF4189CD76B8F4
        91C5F794B7DAE2F5FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFBFD2E298B9D6A7C6DFE4FBFFDCF9FE86C3
        EF429DE91690E80B8DE62088D96DA8E2D1E8FFCCF3FFACD2F296B9DFA8C4E2E0
        F6FCF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFB3E1F16EB7EC
        3198D82C9CDE5BB0EC93BBE4F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFE0F2FA9CC3E07ABADD67
        AFD28AC2E1BED8F1F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFF0000F9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FF
        FFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9
        FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFF
        0000}
      ParentShowHint = False
      PopupMenu = PopMenu
      ShowHint = True
      OnClick = saleBtnClick
    end
    object tProductOnHandImage: TImage
      Left = 3
      Top = 77
      Width = 25
      Height = 25
      AutoSize = True
      Picture.Data = {
        07544269746D6170A2070000424DA20700000000000036000000280000001900
        00001900000001001800000000006C0700002700000027000000000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB6FEFF
        9AE6FF84D0F85AB8EC52B0E43CB6F23EBAF444BAFC44BAFE5AAEFA60B4FF58A2
        C472BCDEA2DCF8B6F2FFD2F8FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFAEF6FF9AE0F278C4EC6AB6DE4CAADE52B0E43AB6F032AEE834A8
        EC38AEF250A6F24EA2F078C0E26CB4D676B2CC8CC6E2C4EAFAD8FFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFC6F8FF78DEFF54BAE234A2E036A4E232AA
        EE34ACEE20AAEE1CA6EA229CEC249EEC489CFA4EA2FF50B6F446ACEA4EA4D854
        ACE086C4E8A2DEFFD4F4FFFFFFFFFFFFFF00FFFFFFFFFFFFC0F2FFACDEEC58BE
        E640A6CE309EDC3AAAE630A8EA2AA2E616A0E426B0F432AAFA249CEC489AF84C
        A0FE389EDE42AAE85AB0E656ACE06CAACE7EBADEBEE0F4DCFEFFFFFFFF00FFFF
        FFFFFFFF98E2FF74BEE2329EE02E9ADA3E9CEC44A2F2429CE64CA6F036A2DE40
        ACE84CB2F248AEEE60AAF44A92DE2E9AF8309CFA429EF03E9CEC5CA0DC6AAEEA
        9ECAF0B2DEFFFFFFFF00FFFFFFD8ECFC86D0F660AAD02892D42E98DA3A9AEA3A
        98E85EBAFF76D0FF44AEEC2A96D2389EDE58BEFC84CCFF56A0EC329EFC309CFA
        3C98EA3692E45298D25EA2DE8EBAE09CCAEEFFFFFF00FFFFFFA6DCFA58B6EC3C
        9AD0268ADE2C90E45090EC5290EC9ECCFFAEDEFF70B6E65A9ECE5AAAD276C6EE
        A4E6FF82C2F2288CFF2C90FF3C94F8348AF04488D44A8ED876A6D888BAEAFFFF
        FF00FFFFFF9AD0EE44A2D83490C6268ADC2A8EE25290EE5E9CF890BEFF9AC8FF
        70B6E684CAFA82D2FC74C4EC94D4FF80C2F22488FC2488FC328AEE3088EC488C
        D84C90DC6C9ECE72A4D4FFFFFF00FFFFFF64C4F6408AF6347EEA387AFC3C7CFF
        3C90E64296EA68CAF466C6F074C6F478CAF888BEF880B8F09CC2F6AED6FF40A0
        EC2E8EDA3E84F23C82F04A7CFF3E70FA306EE868A4FFFFFFFF00FFFFFF62C0F2
        3A82F02C76E22A6CF02A6CEE2E80D6388CE23898C43292BE3C90BC4092C0548C
        C4548CC4729ACC86AEE058B8FF2E8EDA2E74E23076E44074FC3C6EF83270EA5C
        9AFFFFFFFF00FFFFFF64B6DC4082DE4080DE4E82F45488FC78A8F494C4FFA8CE
        F8A0C6F0A8BEECA8BEEEA6BAEEA4B6ECA6C2EAB2CEF686C6FF4C8CC83472CC3C
        7AD43274E63072E42C7CE44A9AFFFFFFFF00FFFFFF6CBEE44284E03E7EDA4478
        EA467AEC6A9AE688B8FFA6CCF6A0C6F0AAC0F0ACC2F2AABCF2A0B4E898B2DC98
        B2DC86C6FF4E90CC3C7AD44884DE3272E42E6EE03686EE4C9CFFFFFFFF00FFFF
        FF72C4D84294DA4296DA4A9AF254A6FE8CC8FFACEAFFCEE6FFCCE4FFDCDEFFE2
        E4FFD0E6FFCCE2FFAEE8FFACE6FFAED6FF7CA4D4488ACC5092D42686DA2484D8
        329EEC3AA8F6FFFFFF00FFFFFF80D0E64C9EE24294DA4494EC4E9EF67AB8F08E
        CCFFAEC6EAAAC4E6B8BAE8B8BAE8A8BEECAAC0F092CEE894CEE8C0E8FF9AC2F2
        5496D85294D83494E83696E83CA8F838A4F2FFFFFF00FFFFFF8ED6E444B0E23C
        A8DA28B8F43CCCFF5AE4FF64EEFF96F0FF94F0FFAAE2FFA6DEFF92E0FF92E2FF
        76F2FF78F4FFA2DCFFA4DEFF5ABCF24EB0E62AB0EA22A8E234B6EA30B2E6FFFF
        FF00FFFFFF9EE6F24EBAEC3AA4D81CAAE82ABAF63CC6E638C2E25CB6CE62BCD4
        7EB6E27CB6E268B6E066B6E046C2D246C2D080B8E8AEE8FF7ADEFF68CAFF36BC
        F61EA6E032B4E838BAEEFFFFFF00FFFFFFD4E8F878CAF660B4E01EBCE828C6F4
        1CD2E614CCDE3ACCE238CCE052BCEE50BCEC48BCEA48BEEC34CCDA36CCDC56BA
        F266CAFF56D8FF4ED0FF30C8F02AC2EA44BEDE42BEDCFFFFFF00FFFFFFE4F8FF
        8CE0FF64B6E416B4E22CCAF628DEF21CD2E63CD0E43ED2E65CC8F85EC8FA56CA
        FA56CAF83ED4E43CD4E260C4FC5EC2F846CAFC4ACEFE2AC2EA1AB2DA48C2E266
        E2FFFFFFFF00FFFFFFFFFFFFD2ECFFACC6EE54BADE5CC0E64ADAEA50E0EE56DA
        F258DAF468D0FF6AD0FF6AD2FF6AD2FF60DCEE5EDCEE50CCFF4ECAFF4ED2FC4E
        D2FC4CC6E040BCD47CD0DEA0F4FFFFFFFF00FFFFFFFFFFFFD4EEFFCCE6FF6ED4
        FA56BCE040D0DE58E8F85EE0F85CDEF668D0FF66CCFF66CEFF68D0FF62E0F264
        E2F45ED8FF64DEFF58DCFF44C6F04AC4DE5CD6F098ECFAFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFBCE8FF9EC8E080CCD490DAE292E4FA92E4FA8CDAFF8C
        DAFF88E0FF8AE2FF86F0FC88F2FC78E6FF72E0FF72CEE660BCD68CC8D2AEEAF2
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFC4EEFFBEE8FF98E2EA88
        D2DA86D8EE8ADCF28AD8FF8EDCFF8AE2FF8AE0FF82ECF680EAF464D2F856C4EC
        6AC4DE7CD6F0B2EEF8BCF8FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFD4F6F6BEE0E096CCDC96CCDC7EC4F67EC4F46CC8F06AC8EE
        62D4D462D4D274C8DE78CEE4ACDEE8C4F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00}
      Transparent = True
      Visible = False
      OnClick = InvoiceLineItemClicked
    end
  end
  object OrderProductNumPanel: TPanel
    Left = 0
    Top = 0
    Width = 33
    Height = 33
    BevelOuter = bvNone
    Caption = '01'
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = InvoiceLineItemClicked
  end
  object PopMenu: TPopupMenu
    Images = IMG_StorageForm.Avobase_25x25_Images
    Left = 482
    Top = 38
    object AddProductToInvoice1: TMenuItem
      Caption = 'Select Product For This Line Item'
      ImageIndex = 31
      OnClick = AddProductToInvoice1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object DiscountLineItemPrice1: TMenuItem
      Caption = 'Discount Line Item Price'
      ImageIndex = 4
      OnClick = DiscountLineItemPrice1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object DeleteThisItem1: TMenuItem
      Caption = 'Delete Line Item'
      ImageIndex = 17
      OnClick = DeleteThisItem1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Cancel1: TMenuItem
      Caption = 'None'
      ImageIndex = 23
    end
  end
end
