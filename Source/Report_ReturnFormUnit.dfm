inherited Report_Return: tReport_Return
  Caption = 'Report_InvoiceForm'
  ExplicitWidth = 903
  ExplicitHeight = 1122
  PixelsPerInch = 96
  TextHeight = 13
  inherited QReport: TQuickRep
    AlignWithMargins = True
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      127.000000000000000000
      2794.000000000000000000
      127.000000000000000000
      2159.000000000000000000
      127.000000000000000000
      127.000000000000000000
      0.000000000000000000)
    inherited Band_Header: TQRBand
      Height = 73
      Size.Values = (
        193.145833333333300000
        1905.000000000000000000)
      ExplicitHeight = 73
      inherited ReportNameLabel: TQRLabel
        Left = 74
        Top = 3
        Width = 360
        Height = 32
        Size.Values = (
          84.666666666666670000
          195.791666666666700000
          7.937500000000000000
          952.500000000000000000)
        Font.Name = 'Verdana'
        FontSize = 16
        ExplicitLeft = 74
        ExplicitTop = 3
        ExplicitWidth = 360
        ExplicitHeight = 32
      end
      inherited SalesCycleLabel: TQRLabel
        Left = 585
        Top = 41
        Width = 135
        Size.Values = (
          39.687500000000000000
          1547.812500000000000000
          108.479166666666700000
          357.187500000000000000)
        Caption = 'Sales Cycle 00/0000'
        Font.Name = 'Verdana'
        FontSize = 8
        ExplicitLeft = 585
        ExplicitTop = 41
        ExplicitWidth = 135
      end
      inherited ReportLabel: TQRLabel
        Left = 74
        Top = 35
        Width = 99
        Size.Values = (
          52.916666666666670000
          195.791666666666700000
          92.604166666666670000
          261.937500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        Font.Name = 'Verdana'
        Font.Style = []
        FontSize = 12
        ExplicitLeft = 74
        ExplicitTop = 35
        ExplicitWidth = 99
      end
      inherited InvoiceDateLabel: TQRLabel
        Left = 74
        Top = 55
        Width = 59
        Size.Values = (
          47.625000000000000000
          195.791666666666700000
          145.520833333333300000
          156.104166666666700000)
        AlignToBand = False
        Font.Name = 'Verdana'
        FontSize = 8
        ExplicitLeft = 74
        ExplicitTop = 55
        ExplicitWidth = 59
      end
      object db_priororder: TQRLabel
        Left = 633
        Top = 22
        Width = 87
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666670000
          1674.812500000000000000
          58.208333333333330000
          230.187500000000000000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'PriorOrdLabel'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_image: TQRImage
        Left = 1
        Top = 1
        Width = 68
        Height = 68
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          179.916666666666700000
          2.645833333333333000
          2.645833333333333000
          179.916666666666700000)
        Picture.Data = {
          07544269746D61705E0E0000424D5E0E00000000000036040000280000003200
          0000320000000100080000000000280A0000130B0000130B0000000100000001
          0000000000000101010002020200030303000404040005050500060606000707
          070008080800090909000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F
          0F00101010001111110012121200131313001414140015151500161616001717
          170018181800191919001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F
          1F00202020002121210022222200232323002424240025252500262626002727
          270028282800292929002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F
          2F00303030003131310032323200333333003434340035353500363636003737
          370038383800393939003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F
          3F00404040004141410042424200434343004444440045454500464646004747
          470048484800494949004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F
          4F00505050005151510052525200535353005454540055555500565656005757
          570058585800595959005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F
          5F00606060006161610062626200636363006464640065656500666666006767
          670068686800696969006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F
          6F00707070007171710072727200737373007474740075757500767676007777
          770078787800797979007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F
          7F00808080008181810082828200838383008484840085858500868686008787
          870088888800898989008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F
          8F00909090009191910092929200939393009494940095959500969696009797
          970098989800999999009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F
          9F00A0A0A000A1A1A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7
          A700A8A8A800A9A9A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAF
          AF00B0B0B000B1B1B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7
          B700B8B8B800B9B9B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBF
          BF00C0C0C000C1C1C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7
          C700C8C8C800C9C9C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCF
          CF00D0D0D000D1D1D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7
          D700D8D8D800D9D9D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDF
          DF00E0E0E000E1E1E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7
          E700E8E8E800E9E9E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEF
          EF00F0F0F000F1F1F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7
          F700F8F8F800F9F9F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2DBAB8BABEEFFFBFFFF
          FFFFFFFFFFFFFFFF0000FBFEFFFEFEFBFEFCFEFEFEFEFEFEFCFAFEFEFDFDFFFE
          FDFEFDFDFDFDFDDFB08B764F5A8E5E71F7FEFEFEF9FFFEFFFDFEFFFF0000FEFE
          FBFDFEFCFEF8FEFEFCFBFFFEFCFCFEFEFAFAFDFEFEFCF9E6C29774676D799EBD
          561D3E3676FEF9FEFEFFFAFEFEFEFFFF0000FBFEFFFEFAF5FEFFFAFEFEFEFBFA
          FBFCFDFEFFFEFFEAC29A76706D767B6B4728A1BF68253C2F62F9FFF8FFF1FFFF
          F7FEFFFF0000FEFEFDFEFEFEFEFBFFFEFDFDFFFEFDFAFEEBC2917273776F7874
          67513B2E2C2FB2B6AFA06A242045FEFFF8FFFFFDFFFAFFFF0000FEFFFCF8F9FA
          FCFFFDFDFEFEFEF1CBAC75796F5F616C5A35312F2C2931486981BEC7978C864B
          344062FEFFF9F9FEFBFFFFFF0000FDFEFFFFFEFEFEFEFEFEE2AD7C67738561A6
          B46B2514202B33436492B6C0AE9864744A567F69492C3E5CFEFFFFFFFFFBFFFF
          0000FFFCFFFDFDF7CFB38B77676E8080613F349DBD784140566DA8ACA792735C
          54546C626A8B9891713B2C3BFEFBF2FFFFFCFFFF0000FFFFF8BE89766C747775
          6A5747434A513FA9CDA6A0AFA49570604F5161758082907D88989D896A674133
          41FEFFFEF8FFFFFF0000FFF25F789F724B332E32373D52728B96A9B6A98F6A66
          4C615D6876828B92999DA4A998B7C08B6F60553D2540FEFFFAFFFFFF0000FCE6
          6B69BE7338202852809DB4B2834A668A705E556A6B828A90969A9A9A9B9CAEB0
          9CB3BB886C5E825347393797FFFFFBFE0000FAFCD9AAD87D7A989A9CACB89D61
          29114598796F78898D93999C9FA09F9E9FA0B4B39EADB38B6C62746A56343B41
          96F9FFFF0000FDDFCCAAD6A79A8C7C838E835628253F49BF9D929A9E9D96999A
          9C9E9FA2A5A8AEACA0A9B1906E666E685149334874B2FFFF0000F3CFA17B7573
          6B737EA29B592725261850C6A494989BA1A1A9A8A6A5A7A8A9AAA8A8A4A8B197
          6A6164755841433D3551F3FE0000FCE97F605F7D779EA793612C1E30332260C2
          B3AFAEAFA7A7A5A3A2A2A6A8A9A8A9A9ADAAB19B665C6D606155723B3852DBF6
          0000FCE6707A97B09FAEAD622622291D1C2558939EAFB6BFA6A99797989DA3A8
          A8A6ABA9B1A9B2A26A6171765555637182C2E3F80000FBE187A1A7A9B4B46132
          18252F24212A2B42537187AC9FB1A3A2A2A5AAACAAA6A9A7B2A7B2A9726C6475
          6554625A80D0FFFF0000FCD4A6AAACB1A750232424252523201F202427252B47
          7396A69DA1B1BAB8AFA7A3B3B1B1ACAC736A726261556A68756FDDFE0000FDCA
          9BBCC58D572723232425242321202123231F1E24323E5DB0D1B7A6B3B7ACB1B8
          B0B3B1B1756C706262576B656C62C5FD0000FED4A49E88502F19212322242322
          22222422212323211C1820377AB7C5C4C5BEB2B1A3A09B9C6D73746665576861
          6961A8FC0000F9C7AB8D451E2928212222232323232225222023292A29271E19
          205AACC3AFA8A0A39999908D5F6873686957635D6F7097FC0000F8AB9DA86B27
          1A27242222212122222123222020202021232F2724213579AAA5A5A2969C9F9E
          5E5162616C5D675F727792FE0000F8B6959C9E75331C25242422212120212022
          2524211F20201E272621212C63AEC1B08D8798AD6E54525568627065706E8BFE
          0000F7C097809AAF744029272622202020212326282826232424251F2B352016
          2F4CA3AD9C8D93AC77635C545F5C736C71667CFE0000F6A3928F93AD9A812D2A
          2723211F1F202B2722202021222125211E2025242326569BC2BDAAAC7361725D
          5850707176686EFE0000FC9AA1939BAAAEB690411D2926202622234735202D19
          3824232526241F1E22272A40C3B3B5B572636B645751617574676EFE0000FE9C
          A09298A1A3ABA99846142A351C1C5C977B5E57312F18271D1C2029282421203E
          67BAB4BC7E656E675A5259676F6E6BFE0000FE93988F969C9EA8ADB4964E1C23
          2F225EC8B9AFAE9579582F252226241E1F2623203678C5B98768716A625F5B5A
          606766FE0000FC8C9290999D9CA9A4AAC4A5481E282759D3B7ABADAFA59E8B5B
          2F24282621202A18342DA4C48471736D6B6F6859545962FC0000FE9197949D9D
          99A6A9B6B1B6AB5D1B2257C6A69FA1A8B1BFC6AC875E361E212F2222242449C2
          977A786D69706F645A5B5FFC0000FC939D9BA2A19BA5ABA7A8BBC39E623D67B9
          A6B3BFB2C2D4B4C9D1B37B46271F1E291D242378BF7F827264646A6B6A6A5EFC
          0000F794A09DA4A39DA6A295B0BFABB2AF80A5BA9CADC5A4C5D8B3B5B7BFC9B2
          68202324261B2F319993867B6A5F626C6E6A5EFD0000F698A49FA3A29BA19EB1
          AAA6B9B6ACB4BAAB92B4E0B8E4F4A4B5BBB4BBC4B3922E2E1E27292E39B18784
          76646068675D5EFD0000FE9E8D8381807D959096A0A8AEB0B0AEB1A99BB7D8DE
          DCC3A9ACB1B5B5B3AFAB94491E2A291935758F8282656A5F736E65FD0000FB95
          8C90918C899EA4A6AAADAFAFAFAEB7AD9296A0A1A89BA5A29E9C9DA2A8AEC2A6
          6D331B26393F998E7C656961676C64FC0000FD92868C8C7F778DAAAAABAAABAB
          ACADB2AC9189837E908FB8B3ABA5A6ADB6BCBAB8A16F33171C3583947A696C6F
          5F6B64FB0000FC8A7C888C8C92AFA7A8A9ABACADAEAFACAE9C9B96909F9DABA9
          A6A3A0A0A1A19FA0B1B480351F364D94846F6A80656C66FC0000FA86767E8188
          95B1ACAFB1B3B3B1AFADAFB09FA2A39CA39992929393918E8B8A949AA0A5A083
          48163199986F60836F6D69FE0000FA8D8586808790A0AEAFAFAEABA59F9C9F9C
          888C918F988F90908F8F909294958E938F909FA27C4A51A0A2736178706D6CFE
          0000F4969FA39DA9AFB3A19F9D9A96918E8C898A7A7E807F8E8B888888888A8D
          9092958E92A1A59D9AA38A979B8481716E6A6BFE0000FBA8B2AC9798928A9390
          8D8A89898A8D879187898279898887898C8F8F8E8B8A8C84848E938C8A8EAF87
          8F99A5736B6A6AFD0000FABF8E8D98918A8F9588878F939690818C88868B908C
          7E728685837F7B79797A7C80858C9195979898918D8D908D81777DFE0000FAFB
          E8AA8389918A7B909089928C8AA0948C817D7A746960595C63707E8889889191
          90929293949596929090918C807673FE0000FDF8FBFCE6AC8D91A08A95927579
          8A7B6F6D6C717A8287898D84797A858F939296948F8B888585858586888F969A
          9D9D8FFD0000F4FDFEFEFDFCDBB07D96877E958770839191909091929394928C
          8887898A8A888B8C8D8F94999EA19F988E85848C9BA6D3FE0000FDFEFDFAFCFE
          FEFBBD9390958698A789929393908D8989898B8D8E8B87878A8E8F8F8F909190
          9191AABED8F0FAFCFBFBFEFE0000F9FFFFFFFBFFFEFEFEF9C2969687778A8385
          888A8B8F979C878B8E8C8A8F9DA8A9B1BFD2E4F4FDFDFCFEFEFEFEFCFCFCFEFE
          0000FFFCF8FEFEFEFEFEFFFDFDE7AB939E9E9F9E9B948C878788BCC9DAE8F1F9
          FEFEFDFEFEFEFDFDFCFBFFFFFFFFFFFFFFFFFCFB0000FCFFFFFEFEFEFEFEFFFE
          FEFBFCFCF9FCF8F9FBFBFBFAFCFCFBFBFCFDFDFEFDFBFDFDFDFEFEFFFFFEFEFE
          FEFEFEFEFEFCFEF80000}
        Stretch = True
      end
    end
    inherited Band_Title: TQRBand
      Top = 122
      Height = 56
      Size.Values = (
        148.166666666666700000
        1905.000000000000000000)
      ExplicitTop = 122
      ExplicitHeight = 56
      object QRLabel2: TQRLabel
        Left = 3
        Top = 1
        Width = 79
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          2.645833333333333000
          209.020833333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'RETURN TO:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_custname: TQRLabel
        Left = 90
        Top = 1
        Width = 79
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          238.125000000000000000
          2.645833333333333000
          209.020833333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'db_custname'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_custaddr: TQRLabel
        Left = 90
        Top = 19
        Width = 72
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          238.125000000000000000
          50.270833333333330000
          190.500000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'db_custaddr'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_custcitystatezip: TQRLabel
        Left = 90
        Top = 37
        Width = 114
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          238.125000000000000000
          97.895833333333330000
          301.625000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'db_custcitystatezip'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
    end
    inherited Band_ColumnHeader: TQRBand
      Top = 179
      Height = 17
      Color = clMedGray
      Size.Values = (
        44.979166666666670000
        1905.000000000000000000)
      ExplicitTop = 179
      ExplicitHeight = 17
      object QRLabel7: TQRLabel
        Left = 2
        Top = 1
        Width = 75
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          2.645833333333333000
          198.437500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'ITEM'
        Color = clActiveBorder
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 80
        Top = 1
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          2.645833333333333000
          95.250000000000000000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'RQTY'
        Color = clActiveBorder
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel8: TQRLabel
        Left = 120
        Top = 1
        Width = 412
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          317.500000000000000000
          2.645833333333333000
          1090.083333333333000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'PRODUCT DESCRIPTION'
        Color = clActiveBorder
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel10: TQRLabel
        Left = 535
        Top = 1
        Width = 91
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1415.520833333333000000
          2.645833333333333000
          240.770833333333300000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'COST'
        Color = clActiveBorder
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel11: TQRLabel
        Left = 630
        Top = 1
        Width = 87
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1666.875000000000000000
          2.645833333333333000
          230.187500000000000000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'TOTAL'
        Color = clActiveBorder
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
    end
    inherited Band_Detail: TQRBand
      Top = 197
      Height = 19
      BeforePrint = Band_DetailBeforePrint
      Size.Values = (
        50.270833333333330000
        1905.000000000000000000)
      ExplicitTop = 197
      ExplicitHeight = 19
      object db_name: TQRLabel
        Left = 120
        Top = 1
        Width = 337
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          317.500000000000000000
          2.645833333333333000
          891.645833333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'db_name'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_cost: TQRLabel
        Left = 573
        Top = 1
        Width = 53
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1516.062500000000000000
          2.645833333333333000
          140.229166666666700000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'db_cost'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_totalcost: TQRLabel
        Left = 630
        Top = 1
        Width = 87
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1666.875000000000000000
          2.645833333333333000
          230.187500000000000000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'db_totalcost'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_num: TQRLabel
        Left = 0
        Top = 1
        Width = 77
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          2.645833333333333000
          203.729166666666700000)
        Alignment = taLeftJustify
        AlignToBand = True
        AutoSize = False
        AutoStretch = False
        Caption = 'db_num'
        Color = clWhite
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_qty: TQRLabel
        Left = 80
        Top = 1
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          2.645833333333333000
          95.250000000000000000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'db_qty'
        Color = clWhite
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_disclabel: TQRLabel
        Left = 458
        Top = 1
        Width = 115
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1211.791666666667000000
          2.645833333333333000
          304.270833333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'db_disclabel'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
    end
    inherited Band_Summary: TQRBand
      Top = 216
      Height = 113
      Size.Values = (
        298.979166666666700000
        1905.000000000000000000)
      ExplicitTop = 216
      ExplicitHeight = 113
      object QRShape2: TQRShape
        Left = 1
        Top = 2
        Width = 719
        Height = 107
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          283.104166666666700000
          2.645833333333333000
          5.291666666666667000
          1902.354166666667000000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object mop_label: TQRLabel
        Left = 489
        Top = 86
        Width = 143
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1293.812500000000000000
          227.541666666666700000
          378.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'TOTAL REFUNDED:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_amountrefund: TQRLabel
        Left = 633
        Top = 86
        Width = 82
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1674.812500000000000000
          227.541666666666700000
          216.958333333333300000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '0.00'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRShape8: TQRShape
        Left = 632
        Top = 83
        Width = 83
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.645833333333333000
          1672.166666666667000000
          219.604166666666700000
          219.604166666666700000)
        Brush.Color = clBlack
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel15: TQRLabel
        Left = 489
        Top = 65
        Width = 143
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1293.812500000000000000
          171.979166666666700000
          378.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'TAX RETURNED:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_salestax: TQRLabel
        Left = 633
        Top = 65
        Width = 82
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1674.812500000000000000
          171.979166666666700000
          216.958333333333300000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '0.00'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel14: TQRLabel
        Left = 489
        Top = 47
        Width = 143
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1293.812500000000000000
          124.354166666666700000
          378.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'SHIPPING RETURNED:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_shipping: TQRLabel
        Left = 633
        Top = 47
        Width = 82
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1674.812500000000000000
          124.354166666666700000
          216.958333333333300000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '0.00'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel13: TQRLabel
        Left = 489
        Top = 29
        Width = 143
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1293.812500000000000000
          76.729166666666670000
          378.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'FEES RETURNED:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_fees: TQRLabel
        Left = 633
        Top = 29
        Width = 82
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1674.812500000000000000
          76.729166666666670000
          216.958333333333300000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '0.00'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRShape1: TQRShape
        Left = 633
        Top = 26
        Width = 83
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.645833333333333000
          1674.812500000000000000
          68.791666666666670000
          219.604166666666700000)
        Brush.Color = clBlack
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object db_subtotal: TQRLabel
        Left = 633
        Top = 7
        Width = 82
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1674.812500000000000000
          18.520833333333330000
          216.958333333333300000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '0.00'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel12: TQRLabel
        Left = 489
        Top = 7
        Width = 143
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1293.812500000000000000
          18.520833333333330000
          378.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'SUBTOTAL:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
    end
    inherited Band_Header_Child1: TQRChildBand
      Top = 121
      Font.Name = 'Verdana'
      ParentFont = False
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 121
    end
    inherited Band_Title_Child1: TQRChildBand
      Top = 178
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 178
    end
    inherited Band_ColumnHeader_Child1: TQRChildBand
      Top = 196
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 196
    end
    inherited BAND_Footer: TQRBand
      Top = 453
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 453
    end
    inherited ChildBand2: TQRChildBand
      Top = 454
      Height = 15
      Size.Values = (
        39.687500000000000000
        1905.000000000000000000)
      ExplicitTop = 454
      ExplicitHeight = 15
      inherited VersionString: TQRLabel
        Top = 1
        Size.Values = (
          34.395833333333330000
          47.625000000000000000
          2.645833333333333000
          148.166666666666700000)
        FontSize = 7
        ExplicitTop = 1
      end
      inherited AvoBaseRegLabel: TQRLabel
        Top = 1
        Size.Values = (
          34.395833333333330000
          1349.375000000000000000
          2.645833333333333000
          555.625000000000000000)
        FontSize = 7
        ExplicitTop = 1
      end
      inherited QRImage1: TQRImage
        Top = 1
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          0.000000000000000000
          2.645833333333333000
          42.333333333333330000)
        ExplicitTop = 1
        ExplicitWidth = 16
        ExplicitHeight = 16
      end
    end
    object Band_Summary_Child1: TQRChildBand
      Left = 48
      Top = 329
      Width = 720
      Height = 124
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        328.083333333333300000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Band_Summary
      PrintOrder = cboAfterParent
      object db_imsg: TQRLabel
        Left = 8
        Top = 6
        Width = 480
        Height = 114
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          301.625000000000000000
          21.166666666666670000
          15.875000000000000000
          1270.000000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'db_imsg'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 8
      end
      object invHead: TQRLabel
        Left = 494
        Top = 3
        Width = 226
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          47.625000000000000000
          1307.041666666667000000
          7.937500000000000000
          597.958333333333300000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = False
        AutoStretch = False
        Caption = 'InvoiceLineHeader'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic, fsUnderline]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 11
      end
      object invLine1: TQRLabel
        Left = 673
        Top = 24
        Width = 47
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          55.562500000000000000
          1780.645833333333000000
          63.500000000000000000
          124.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'invLine1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 9
      end
      object invLine2: TQRLabel
        Left = 673
        Top = 40
        Width = 47
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1780.645833333333000000
          105.833333333333300000
          124.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'invLine2'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 9
      end
      object invLine3: TQRLabel
        Left = 673
        Top = 56
        Width = 47
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1780.645833333333000000
          148.166666666666700000
          124.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'invLine3'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 9
      end
      object invLine4: TQRLabel
        Left = 673
        Top = 73
        Width = 47
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1780.645833333333000000
          193.145833333333300000
          124.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'invLine3'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 9
      end
      object invLine5: TQRLabel
        Left = 673
        Top = 90
        Width = 47
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1780.645833333333000000
          238.125000000000000000
          124.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'invLine5'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 9
      end
      object invLine6: TQRLabel
        Left = 673
        Top = 105
        Width = 47
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1780.645833333333000000
          277.812500000000000000
          124.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'invLine6'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 9
      end
    end
  end
end
