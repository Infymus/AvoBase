inherited Pref_ProductSettingsForm: TPref_ProductSettingsForm
  Caption = 'Pref_ProductSettingsForm'
  ClientHeight = 398
  ClientWidth = 524
  OnCreate = FormCreate
  ExplicitWidth = 524
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 13
  inherited pref_full_back_panel: TPanel
    Width = 524
    Height = 398
    ExplicitWidth = 605
    ExplicitHeight = 401
    inherited PREF_BACK_PANEL: TPanel
      Width = 524
      Height = 369
      ExplicitWidth = 605
      ExplicitHeight = 372
      inherited PADDING_PANEL: TPanel
        Width = 524
        Height = 369
        ExplicitWidth = 605
        ExplicitHeight = 372
        inherited Pref_Scroll_Box: TScrollBox
          Width = 508
          Height = 353
          ExplicitWidth = 589
          ExplicitHeight = 356
          object GroupBox1: TGroupBox
            Left = 0
            Top = 0
            Width = 508
            Height = 256
            Align = alTop
            Caption = 'User Defined Product Fields'
            TabOrder = 0
            object Label1: TLabel
              Left = 21
              Top = 112
              Width = 88
              Height = 13
              Caption = 'Custom Field 1:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label2: TLabel
              Left = 22
              Top = 139
              Width = 88
              Height = 13
              Caption = 'Custom Field 2:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label3: TLabel
              Left = 21
              Top = 166
              Width = 88
              Height = 13
              Caption = 'Custom Field 3:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 21
              Top = 193
              Width = 88
              Height = 13
              Caption = 'Custom Field 4:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object InvoiceLineSettings: TLabel
              Left = 21
              Top = 21
              Width = 442
              Height = 58
              AutoSize = False
              Caption = 
                'User Defined Product Fields allow you to create your own Product' +
                ' fields that can receive input data and print on your invoice.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object Label5: TLabel
              Left = 57
              Top = 226
              Width = 328
              Height = 24
              AutoSize = False
              Caption = 'Examples: "Size/OZ" - "Color" - "Sale/Special".'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -9
              Font.Name = 'Verdana'
              Font.Style = [fsBold, fsItalic]
              ParentFont = False
              WordWrap = True
            end
            object Label6: TLabel
              Left = 21
              Top = 59
              Width = 59
              Height = 13
              Caption = 'Organization'
            end
            object db_PRODN1: TMaskEdit
              Left = 112
              Top = 109
              Width = 255
              Height = 21
              MaxLength = 40
              TabOrder = 0
              Text = 'db_PRODN1'
            end
            object db_PRODN2: TMaskEdit
              Left = 112
              Top = 136
              Width = 255
              Height = 21
              MaxLength = 40
              TabOrder = 1
              Text = 'db_PRODN2'
            end
            object db_PRODN3: TMaskEdit
              Left = 112
              Top = 163
              Width = 255
              Height = 21
              MaxLength = 40
              TabOrder = 2
              Text = 'db_PRODN3'
            end
            object db_PRODN4: TMaskEdit
              Left = 112
              Top = 190
              Width = 255
              Height = 21
              MaxLength = 40
              TabOrder = 3
              Text = 'db_PRODN4'
            end
            object orgCombo: TComboBox
              Left = 21
              Top = 77
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
              TabOrder = 4
              OnChange = orgComboChange
              OnEnter = orgComboEnter
            end
          end
        end
      end
    end
    inherited PREF_TOP_BACK_PANEL: TPanel
      Width = 524
      ExplicitWidth = 605
      inherited PREF_HEADER_BACK_PANEL: TPanel
        Width = 520
        ExplicitWidth = 601
        inherited PREF_HEADER_LABEL: TLabel
          Width = 109
          Caption = 'Product Settings'
          ExplicitWidth = 109
        end
        inherited pref_image: TImage
          Picture.Data = {
            07544269746D6170A2070000424DA20700000000000036000000280000001900
            00001900000001001800000000006C070000130B0000130B0000000000000000
            0000FFFEFEFFFFFFFFFFFFFBFAFAFCF8F9FDFAFAFEFBFBFEFCFDFFFEFEFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFEFEFEFDFDFDFDFDFDFFFFFFFFFFFFFEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFB69897B77C7AD5928F
            DDA29AE2B1AAE5CDC8E3D6CEDFD6CEDFD9D2F7F4F3FFFFFFF9F8F8E3E6E5D1D7
            D6E2E1E2F2EFF0F4F2F3FFFFFFFEFEFEFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
            F9F2EFBB9486B77962C27E5BB27749AA7341B96841B26B419C6D3F92704DE6D6
            CCFFFFFFA8A5A59FAAA5B7C6BDBDC1BCC3BCBBCFC9C9FFFFFFFEFEFFFFFFFFFF
            FFFFFFFFFF00FFFEFEFFFFFFF1EAE2F6E9D6FBDCBFF9DEB9F3DFB2F3DCACF8D4
            ACF6CDA4F0CDA2EBCEAFF8EEE4FFFFFF746C68CFCEC5D5E0CFD4D7C6E4DDD2CE
            C6BFF8F8F4FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFDFE6E0DCE2D7FDFD
            FBFFFFFDFEFBF6FEFBF6FFF8F5FEF8F4FFFBF5FDF8F4FDFBFAFFFFFF8C766BC1
            A793D3C2ADD8C1AEE0C4B4D9C2B3FEF7F0FFFFFFFEFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFEFF3ECE6E3D5F9E1D5FEDCD4FFDCDBF9E0E0E8EAE7FBF8F0FEF8F2FE
            FBF6FEFDFDFFFFFF886759A8765FA06C5A9B6351A36D5AA67E6DE0D4C9FFFFFF
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFF5E4DBC59579D28C66E59164EC9C6CEB
            A673E9B27AF6BC85F9C998F7D6B2FCF1E4FFF8EF79584AB4816ED09689D99D8E
            D19886A67C69B9A696FFFFFFFEFFFFFFFFFFFFFFFF00FFFFFFFFFFFFF4D9CFA4
            5539B64721C54619C34919BE4F1AC6551CD05921CE6130BF7150EAD2C1E8E0D4
            A08B77FDD6C0FFE3D6FEE1D4FFE5D3EBCFBBDCD1BEFFFFFFFFFFFFFFFFFFFFFF
            FF00FFFEFEFFFFFFEED5CEA14A3ABB3927C83626C43829BE3B2BC33E29C63B26
            C4412EA94D40E1C6C2BFB7ADAC957BF4D2B3EAD9CAE3CFBEF4DBC5E4CCB5D3C8
            B7FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFEECCEC3B04C40C63A2BC13E23
            B74120BD4420C3431BCF4622D23E23B74F3EE3C9BBBF9A8DA45842A66946B05B
            49AB5C3EB96E43B06240AF7F71FFFFFFFFFEFEFEFFFFFFFFFF00FFFFFFFFFFFE
            EECBC2B74C41CE3B2CCA3F23C74120CE4320CD421CD84422D93D23BB4F3CE2C9
            BCB080729F3E27AD5833C24B33BA4D27C35F2DB7542CA05F4BFFFFFFFEFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFDEEC7BEBB4D3FD43D2BD43F26D43F23E03F25D93D
            23DE4229DC3C27B84D39E1C7B49E6655AF3C24C65A34D74D2BCC4F24D5602ECB
            592FA4583DFAE7DAFFFFFFFEFFFFFFFFFF00FEFFFFFFFEFCEBC7BAB8503FD040
            2CD34126D44225D84524D34325D54626D24328B5533DDFC2AB985A45C0472CCF
            5931CA4721BF4C21C95F32CB5A39A44E35EED2C6FFFFFFFFFEFEFFFFFF00FFFF
            FFFFFEFBE9CABAB2523ECD4824CF4923CE4923CD4B22CE4B22CE4B22CC4A23A5
            4F37DCC3A88C5239D25D41CC4921CC4B23C94B23CB5028CC4B24C06755D1AA9F
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFEFBE8C7B6B2513CCD4A21CE4B23CE4B22CF
            4A23CF4B23CE4A23CD4A22A44E33D3B79A8C4F37E47960CC441ACF4B23CF4A22
            CF4B23C94015EB9B8BC4998BFFFFFFFFFFFFFFFFFF00FFFFFFFFFDFAEEC3B3BF
            523ACA4523CF4B22CE4A23CE4A23CF4B23CF4B23CA4720B8553ACDAB919B5845
            CF5541BA431ED04B23CF4B23CE4A22CA512EB2573CB18569FFFFFFFFFFFFFFFF
            FF00FEFFFFFFFCFAF2C2B2CA533DD04827C84720D04B23D04B22CF4A22CC4923
            D04C2BCC5F45D59D86A85946C84D3BCC471ECB4A22D04A22CE4920C35B41D16F
            4CA47756FFFFFCFFFFFFFFFEFE00FFFFFFFFFCFAF1C4B4BF5940C64326C34625
            C54722BF4621CA4A25C94628CE4834C04F3DD7846FBD664EC34D31C63D1CBF4E
            23C94B22D04922CF4928D9684CB07865F9F7F5FFFFFFFEFFFF00FEFFFFFFFCFA
            F0BFB2B5543FBE452BC3452AB44026B0462AB64B2AB64729B74731B74E3CCB68
            52D1694EBE4324DC5331B75229B64D23C1481FC04724C25D41B87E68F2E7E0FF
            FFFFFFFFFF00FFFFFFFFFAF8F6CFC4EAA896EE9E8AF2A792F1AF9DEFB6A1F0BC
            9BECB898E7B397F3B49DC4735DA14127B65532B75F38AB5E3CA55631A7512C9D
            47269D5637AE7E66D6C7BDFFFFFFFFFEFE00FFFFFFFCFCFAEFEBDEF4EBD9FBEF
            DCFCE9D7FDEADBFEEFE0FFF7E6FBFDEAFDFFF0FFFCF0D1AC9CD6A58FDABC9DEE
            E4C1FFDBC5FED0BDFBCEB8EFC5AEDDB9A5D4B9A8F2E9E1FFFFFFFFFFFF00FEFE
            FEFFFFFFF4F8F4E5EEE1E9F1E3E9F0E5F5FAF4FFFFFFFFFFFFFFFFFFFFFFFFFF
            FEFEEEE1DCE2D4CCD4DBCDC7E2CEE5DED9E9DCD9E6DAD5E5DBD3E1D8D3DBD5D0
            EEEAE9FFFFFFFFFFFF00FFFFFFFFFFFFF0E9EAD8CDCBD1C8C4D3CBC6DDD6D2E3
            D8D5EDDADCEFDEE0EADEE0EEE5E6FBF9F9FBFAFAF9FBFAF7FBFBFBFCFCFBFCFC
            FBFBFCFBFBFCFDFEFEFDFDFEFDFEFEFFFFFFFFFFFF00FFFFFFFFFFFFF6F2F2EF
            E9E9EDE9E9EEE9E9EEE9E8F2ECECEAD7D3EDD2CDE8CFCBF0E2DFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFF
            FF00FFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFCFEFDFC
            FEFCFCFEFDFDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF00}
        end
      end
    end
  end
end
