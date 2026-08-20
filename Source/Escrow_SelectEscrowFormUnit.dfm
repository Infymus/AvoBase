inherited Escrow_SelectEscrow: TEscrow_SelectEscrow
  Caption = 'Escrow_SelectEscrow'
  ClientHeight = 393
  ClientWidth = 589
  OnDestroy = FormDestroy
  ExplicitWidth = 591
  ExplicitHeight = 395
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 589
    Height = 393
    ExplicitWidth = 589
    ExplicitHeight = 393
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 587
      Height = 391
      ExplicitWidth = 587
      ExplicitHeight = 391
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 587
        ExplicitWidth = 587
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 20
        Width = 587
        Height = 236
        Align = alTop
        Caption = ''
        ExplicitTop = 20
        ExplicitWidth = 587
        ExplicitHeight = 236
        object finalImage: TImage
          Left = 39
          Top = 107
          Width = 50
          Height = 50
          AutoSize = True
          Picture.Data = {
            0A544A504547496D61676578040000FFD8FFE000104A46494600010101004800
            480000FFFE00134372656174656420776974682047494D50FFDB004300050304
            0404030504040405050506070C08070707070F0B0B090C110F1212110F111113
            161C1713141A1511111821181A1D1D1F1F1F13172224221E241C1E1F1EFFDB00
            43010505050706070E08080E1E1411141E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E
            1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E
            1E1EFFC00011080032003203012200021101031101FFC4001C00000202030101
            00000000000000000000000506070304080102FFC4003F100002010301020907
            080B000000000000020304000105120622071113142123425262153132335192
            C1164153617172A2B1242563738191A3B2C2D1F0FFC4001A0100020301010000
            00000000000000000004050003060102FFC40029110001030302050305000000
            00000000000200010304051211220614213132132342515291D1F0FFDA000C03
            010002110311003F00ECBA28A2A28926D2E45D15B16221A29391AF8DB71E3D36
            B5A93C88EB30EB9CF79F78CF557BC21EBE7B8ED1A7CC7E97DA349243E62A28E8
            12D5E1AC65DEA642A838CBC47F49CD1C1EDB132CFA040F7456BADB8D98745E9B
            30976B7CFAB77DDAADF6A331B60025E4FD23E2310A489939E93A7CB99A4FEE96
            DD67EE8D2209248DF388B14CDE112DB22BAEDB790B8ADEAEFEF7FAA2A030EEBE
            689EACBD58FE545685AE951F77F7E101CA41F456AB73F76DEF6C745BBC7E948B
            487F0F6D68CACEE5145D2B8A3F55B55E91635EF836F26CA1E4C83E63FF001AC3
            94CE438EB26BD6EFBC23AA87A8BC55175CB15E62A30CB4D355B99B73B2C686B5
            8A5B11ABA349547F3B22463E28F2EBD6AEF016AA453384AC1ADE4A04CA3678C4
            47E35F1CF656D3A1ADD231A12D667D60EA0A4934F2485949F24C6288436B28A6
            D34BC1E463B1AD95334AFD31040EBFCEB1ECEDF1772E4B190653CFBCD66AED77
            47E254AD33E6227B551703165B1FB9BF184BFBB76A4D064670D42A9DCDE0ABE8
            83407E11F8D75C711E8AE2EEA63100F9AABAF1F407B5F55158A1DC79A2774BD5
            8F7BD9F6514C9908A69B6A71433766A4F9465AE20D01B7A16A8E671104D5CA96
            3C583E25EAA7F9451232D362C95F54F76B0E3A5B927AE2A095CE0847C43AAABA
            F7729CDCB6F55E295F1016557E524C88733F536C7C1637BFCD3577A9A453DA29
            A03E5A24E3E22FB26421FD31F4A976D66692E328ABCB316CF08B7FEEED69F07D
            B32DCBE7A345B4A73C7735E81DF05F6B7BB343044536D1EE8C3368F724DC248E
            2FE50B5B0E4331F1B73A01645F1A65B3618D7726A86590C83D9D921D3F8477AB
            A12FC18EC319D98FD9E8CF65BB4CB915FF003A7F8AC1E1B143A71B8B8912DFB2
            5586B441C3A6E3A19A565766F88AAEE1ECA67F9A27F4601EAC777579BA3CD455
            AB45356B3D3A039E91619CB5B631D98B03B71798ADC754BF087D51B392DCFBBD
            14514071036D157DB7C9D559874AA4ED0AAD2140EB7B18362EEFB6BAB3656143
            87848C30E2478E375DB8ECA5D82D7FE5451445919BD25CB93EF4D68A28A78962
            28A28A8A2FFFD9}
        end
        object OrdPurchLabel: TLabel
          Left = 9
          Top = 4
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
          Left = 28
          Top = 29
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
        object CustSoldToCityStateZip: TLabel
          Left = 30
          Top = 62
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
          Left = 30
          Top = 77
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
        object CustSoldToAddress: TLabel
          Left = 30
          Top = 47
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
        object db_amount: TLabel
          Left = 339
          Top = 6
          Width = 145
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'REFUND AMOUNT:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object db_refundlabel: TLabel
          Left = 490
          Top = 6
          Width = 60
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = '$    0.00'
          Color = 7405307
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object escrowLabel: TLabel
          Left = 100
          Top = 107
          Width = 480
          Height = 123
          AutoSize = False
          Caption = 
            'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do' +
            ' eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ' +
            'enim ad minim veniam, quis nostrud exercitation ullamco laboris ' +
            'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor i' +
            'n reprehenderit in voluptate velit esse cillum dolore eu fugiat ' +
            'nulla pariatur. Excepteur sint occaecat cupidatat non proident, ' +
            'sunt in culpa qui officia deserunt mollit anim id est laborum.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
      end
      inherited ToolBar: TToolBar
        Top = 318
        Width = 587
        Height = 52
        Align = alBottom
        ButtonHeight = 36
        ExplicitTop = 318
        ExplicitWidth = 587
        ExplicitHeight = 52
      end
      inherited StatusBar: TStatusBar
        Top = 370
        Width = 587
        ExplicitTop = 370
        ExplicitWidth = 587
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 256
        Width = 587
        Height = 62
        Align = alClient
        Caption = 'Select Refund Payment Type'
        TabOrder = 4
        object Label1: TLabel
          Left = 9
          Top = 14
          Width = 80
          Height = 14
          Caption = 'PAYMENT TYPE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object mopvalueLabel: TLabel
          Left = 169
          Top = 14
          Width = 116
          Height = 14
          Caption = 'FILLED IN AT RUNTIME'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object paymentTypeCombo: TComboBox
          Left = 9
          Top = 30
          Width = 154
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
          TabOrder = 0
          OnChange = paymentTypeComboChange
        end
        object db_mopvalue: TEdit
          Left = 169
          Top = 30
          Width = 90
          Height = 21
          TabOrder = 1
          Visible = False
        end
      end
    end
  end
end
