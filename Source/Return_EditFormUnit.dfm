inherited ReturnEditForm: tReturnEditForm
  Left = 339
  Top = 251
  Caption = 'OrderEditForm'
  ClientHeight = 559
  ClientWidth = 649
  Color = clWhite
  ExplicitWidth = 651
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 649
    Height = 559
    BorderWidth = 0
    ExplicitWidth = 649
    ExplicitHeight = 559
    inherited BASEFORM_BACK_PANEL: TPanel
      Left = 0
      Top = 0
      Width = 649
      Height = 559
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 649
      ExplicitHeight = 559
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 649
        Height = 37
        Color = 5060012
        ExplicitWidth = 649
        ExplicitHeight = 37
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Align = alNone
        end
        object PRIOR_ORDER_LABEL: TLabel [1]
          Left = 6
          Top = 19
          Width = 190
          Height = 18
          Caption = 'PRIOR_ORDER_LABEL'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        inherited BASE_LABEL_SEP_PANEL: TPanel
          Height = 37
          ExplicitHeight = 37
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 91
        Width = 649
        Height = 447
        Caption = ''
        ExplicitTop = 91
        ExplicitWidth = 649
        ExplicitHeight = 447
        object ORDER_NOTEBOOK: TNotebook
          Left = 1
          Top = 41
          Width = 647
          Height = 276
          Align = alClient
          Color = clWhite
          PageIndex = 1
          ParentColor = False
          TabOrder = 0
          object TPage
            Left = 0
            Top = 0
            Caption = 'CUST_PAGE'
            object CUST_BACK_PANEL: TPanel
              Left = 0
              Top = 0
              Width = 647
              Height = 276
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              object CustSoldToPhone: TLabel
                Left = 37
                Top = 108
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
              object CustSoldToCityStateZip: TLabel
                Left = 37
                Top = 93
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
              object CustSoldToAddress: TLabel
                Left = 37
                Top = 78
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
              object CustSoldToName: TLabel
                Tag = 1
                Left = 35
                Top = 60
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
              object OrdPurchLabel: TLabel
                Left = 16
                Top = 35
                Width = 177
                Height = 18
                Caption = 'Return Created For:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Verdana'
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
              end
              object PREF_TOP_BACK_PANEL: TPanel
                Left = 0
                Top = 0
                Width = 647
                Height = 29
                Align = alTop
                BevelOuter = bvNone
                BorderWidth = 2
                Color = clWhite
                ParentBackground = False
                TabOrder = 0
                object PREF_HEADER_BACK_PANEL: TPanel
                  Left = 2
                  Top = 2
                  Width = 643
                  Height = 25
                  Align = alClient
                  BevelOuter = bvNone
                  Color = 16444898
                  ParentBackground = False
                  TabOrder = 0
                  object PREF_HEADER_LABEL: TLabel
                    Left = 28
                    Top = 5
                    Width = 203
                    Height = 14
                    Caption = 'Customer - Return Information'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Verdana'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Image1: TImage
                    Left = 0
                    Top = 0
                    Width = 25
                    Height = 25
                    Picture.Data = {
                      07544269746D6170A2070000424DA20700000000000036000000280000001900
                      00001900000001001800000000006C070000130B0000130B0000000000000000
                      0000FFFEFFF4F4F5D0D1D1CFCDCFCECCCECFD0D1D3D4D5D3D7D7DCDADBDFDEE1
                      E1DEE6C3C2C7CBC9CECBC9CAE0DEE3E3E1E0D9DBDBD8D8D9D6D4D5D4D2D3CBC9
                      CBC8C6C8D2D2D3F9FBFBFFFEFE00FFFEFFD8CBCBB9A19EB69993C3A69EC9B0AA
                      CDBAB4D2C3C2DECFB9E5D2EAE2E6EC685CD65C5BDC6D68D9E4EBE0EACDE1E5CF
                      CFD7C9C6CCC2B9C6B3ABCBAAA4C19D99AA8D8CDBC9CAFFFFFF00FFFFFFDBCBCB
                      B7A19DB1958FBCA099C3ABA5C6B4AFCCBEBDDACCB8DFCCDEDCDFE2766DD66968
                      DF7C79D9DBE2D5E6CDDBDCC8C8C9BCB9BFB5ADC1AFA8C1A39DBA9995A08786E5
                      DADBFEFFFF00FFFEFFE5D8D7B7A39FAB938DB99D96BFA7A1C4B2ACC9BBB9D8CA
                      B5D7C7CFD6D7D78A84D97E7BEA9494E3D7DDCEEBD3D8E0CDCECDC0BDBEB5ADB7
                      A79FBA9F98B3948F9B8584F3ECEDFFFFFF00FFFEFFE8E0DFB9A8A4AA928CB79D
                      96BEA7A1C4B1ACC9BBB9D5C6B4D3C3C3D2D2CF9A97D28984EDA2A7E0D1D6C4E9
                      D3D4E1CDCFDACFCCCAC3BBB6A9A0B8A099AA8F8A9B8A88FFFBFBFFFFFF00FFFE
                      FFF8F3F1B5A6A1AB958FB59B94BDA6A0C2AFAACABAB8D4C3B7D3C4BCD1CDCAA8
                      A8CA988EF2ADB3DAD5D9C7E6D1CEDECBCCD7CCC9D8D3CAD2C7BEB6A19AA38C87
                      AA9D9BFFFFFEFEFFFF00FFFDFFF9F6F4B6AAA5B39F98B69F97BEA6A1C3B0ABC8
                      B8B5D1BDB9D3C4B8D0C7C6AEB0C09F93F3B5BED6D2D4C5E0CCC7DFCED0D5CBC8
                      CECAC2D5CDC3E3D1C9AC9993B6AEAAFFFFFFFFFDFF00FFFDFFFFFFFFD8CDC8B1
                      9E97BAA39BBEA7A1C4B1ACC7B6B2D2BABED7C8B9D1C4C5BCBEC1A191F2BFC8D5
                      D4D3C7E3CFCADFCED0D7CECAD2CFC6DBD4CBE6D7CFB9AAA3F1EBE8FFFEFFFFFE
                      FF00FFFEFFFEFDFFFEFBF7DBC8C1B7A098BEA69FC7B3ADC5B5B0D0B6C2D7C6B7
                      CCBCC1C1C5BE9581E7BCC5CCD0CFC4E7D0CEDECCCEDCD3CFE2E0D6DCD5CBCDBE
                      B5D1C5BEFFFFFFFFFEFFFFFDFF00FEFEFFFEFEFFFFFDFFFFFFFFF9F7F8E0DCDE
                      C8C0C1BEB6B9C5BF9FCDC8BDE2E0EBDADAF1B6B8D5F3EFFDE4DDE2E3DCD1D5D1
                      C9C6C3BAC6C2BDDBDBD9FCFDFDFFFEFFFFFEFEFFFDFFFFFEFF00FCFFFFFFFEFF
                      FFFDFFFFFEFFFFFDFEFFFEFFFFFFFFFFFFFFFAF8F5C5C9C8CBD8E8C1D6F3AFC5
                      E8D3E3FBD6DEE9D0D3D4EEECE8FFFDFAFFFFFFFEFDFEFFFEFFFFFEFFFFFEFFFF
                      FDFFFFFFFF00FDFFFFFFFEFFFFFFFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFF
                      FFBDCEDD98BCDA79ABD57DB1DE80ACD1ACC9E2D7EBF8FFFEFEFFFEFFFFFEFFFF
                      FEFFFFFEFFFEFDFEFFFEFFFFFDFFFFFEFF00FFFFFFFFFFFFFFFEFFFFFEFFFFFE
                      FFFFFEFFFFFEFFFFFFFFC5D2E681A1BE8EC5ED7BC3F374C1F28BCCF388B8DA81
                      A7C5FFFFFEFFFEFFFFFEFFFFFEFFFEFDFEFFFEFFFFFEFFFFFEFFFFFEFF00FFFF
                      FFFFFFFFFFFFFFFFFDFFFFFEFFFFFEFFFFFEFFFDFBFA9CBCE0A4D1F781C1EE71
                      C0F173C5F678C0EF8AC4ED92C4EBECEFECFEFDFEFFFEFFFFFEFFFFFEFFFFFEFF
                      FFFEFFFFFEFFFFFEFF00FFFFFFFFFFFFFFFFFFFDFEFFFDFEFFFFFDFFFFFEFFEF
                      F1EE99C9F192C5EE85C2EC82C4F27DC1EF86C5F08CC5ED93C9F0CEDCDCFFFEFF
                      FFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFDFFFEFFFE00FFFFFFFFFFFFFFFFFFFD
                      FEFFFCFEFFFEFEFFFEFFFFD6DAD690CCF28FC5E997C9F0A0CEF79ECAF2A2D0F7
                      9DCCF09ACEF2B8C9CCFAFCFEFFFEFFFFFEFFFFFEFFFFFDFFFEFEFEFBFEFEFFFE
                      FF00FFFFFFFEFFFFFFFEFFFCFFFFFFFDFEFFFDFFF8FFFF8185808FD5F69AD2F3
                      A6D0F2AFCEF2B7D1F6B5D4F6B2DCFCA9DBFC657778BBC5C8FFFFFFFFFEFFFFFE
                      FFFFFDFFFEFFFEF9FFFDFFFEFF00FFFBFFFFFCFFFBFFFEF9FFF8FFFDFFFDFEFE
                      D8E9F4314869ABCBE8B7D8F4ABCEECB8DBFBB9DEFCBADEFFB8DDFF8FB2CE3F68
                      9E405C7AECF5F9FFFEFFFFFEFFFBFEFFFBFDFFFFFCFFFEFFFE00FFFDFEFFFDFE
                      FEFEFFFEFFFBFEFDFFFCFFFFAAC0D13354757399B6BADEF9C4E4FCBDDBF2C5E4
                      F97999B62146672A5174255A8E426785D3DCE1FEFEFFFFFEFFFDFEFFFCFDFFFF
                      FDFFFEFFFF00FFFFFDFDFEFFFFFDFFFFFEFDFFFDFFFAFEFF90ACC03462864C76
                      9DBEE5FFC9EAFBBDD9EC506D81274B662F5A8034638F2C73A53F6F8ED7E9F0FF
                      FDFFFFFEFFFFFDFFFFFDFFFCFFFFFFFEFE00FAFFFAFBFFFEFFFDFFFFFDFFFFFE
                      FEF8FCFF98B7CC3A6D90346A9DAFE0FF94BDDC3A5E772F567028577928618F31
                      70A93D90BC4C829EEAFBFFFFFEFFFFFEFFFFFEFFFEFEFFFAFFFEFFFFFF00FAFF
                      F9FAFFFEFEFDFFFEFDFFFFFEFFFBFDFFCDE7F3487592407DB73C74A9174B7826
                      5A822B618B246190266CA43680BF458FB280B1C8FEFFFFFEFDFFFFFEFFFFFCFF
                      FDFEFFFCFEFEFFFFFF00FEFEFCFBFEFEFAFDFFFEFEFFFEFDFFFFFEFFF3FFFFB0
                      CADE164E7E1B52832560931A598D1E6196256B9F3F86B9458DC26195ACD8F3FA
                      FFFDFEFFFEFFFFFEFFFEFDFFFEFDFEFFFFFEFEFFFF00FFFEFFFFFDFFFCFEFFF9
                      FEFEFDFEFDFFFEFFFFFEFFF6F9FF4B7089325E7E2E669327699F2B71A74185B3
                      4A88AA5D98B4CCE4F0FBFFFFFFFEFFFFFEFFFFFEFFFFFEFFFEFDFFFFFEFEFFFF
                      FF00FFFEFCFFFEFEFFFEFFFFFDFFFFFDFFFFFEFFFFFEFFFFFEFEE7F2F6A5B5BE
                      95ADC196B7D19CBED89FBFD3B6D0DCE5FCFEFFFEFFFEFEFFFFFEFFFFFEFFFFFE
                      FFFFFEFFFFFEFFFFFDFFFFFFFE00}
                    Stretch = True
                    Transparent = True
                  end
                end
              end
            end
          end
          object TPage
            Left = 0
            Top = 0
            Caption = 'MESSAGE_PAGE'
            object MESSAGE_BACK_PANEL: TPanel
              Left = 0
              Top = 25
              Width = 647
              Height = 251
              Align = alClient
              Caption = 'MESSAGE_BACK_PANEL'
              Color = clPurple
              ParentBackground = False
              TabOrder = 0
              ExplicitLeft = -3
              ExplicitTop = 31
            end
            object Panel2: TPanel
              Left = 0
              Top = 0
              Width = 647
              Height = 25
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Panel2'
              TabOrder = 1
              object Panel5: TPanel
                Left = 0
                Top = 0
                Width = 647
                Height = 25
                Align = alClient
                BevelOuter = bvNone
                Color = 16444898
                ParentBackground = False
                TabOrder = 0
                object Label1: TLabel
                  Left = 28
                  Top = 5
                  Width = 162
                  Height = 14
                  Caption = 'Invoice Special Message'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Verdana'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object Image2: TImage
                  Left = 0
                  Top = 0
                  Width = 25
                  Height = 25
                  Picture.Data = {
                    07544269746D6170A2070000424DA20700000000000036000000280000001900
                    00001900000001001800000000006C0700002700000027000000000000000000
                    0000FAFEFDFAFEFCFDFDFDFEFCFDFBFDFDFAFEFEFCFEFEFBFDFEFDFCFEFDFCFE
                    FCFDFEFEFDFEFDFDFDFEFCFDFDFDFEFDFDFEFEFCFEFEFCFEFEFCFEFEFCFDFEFD
                    FEFEFDFEFEFCFEFEFDFEFEFEFE29F1FEFBF2FDFAFCFCFCFEFAFDF7FDFEF4FEFF
                    F8FDFFF7FCFEFCFAFEFAFBFEF7FCFEFCFBFDFCFCFCFEFAFCFBFCFDF9FCFDFCFB
                    FEFEFAFEFEFAFEFCFBFDF9FCFDF9FAFDFCFAFEFDFCFEFEFEFE29FAFDFEFDF9FC
                    FFF9FEFFF9FEFEFAFEFDFBFEFEFBFEFEFBFEFAFDFCF3FEFCF0FFF8F4FEF4F9FE
                    F4FCFFF6F3FFF7EEFFF8F4FFF9FBFEF9FCFEF8F5FEF7EEFFF7EFFEF9F5FDF8FC
                    FDFCFEFEFE29ECF3F3E6DDDFEFE3E6F0ECECF4F2F1F3F5F2F2F7F3F6F6F4F1F3
                    F5ECEFEFE1E9E3DAE3D8EFE3DBEDEEE7E9F2EDEBF5F4F0F6F4F7F6F5F5F4F3EF
                    F3F2E1ECE9DBE2DEEDECE8FDFDFBFEFEFE29D8ECDFC2B7ADB8AEA3B7BAABCAC3
                    B5C4C8B6C0CCB7D4C7BBD1BEC8D0B7C0C5AEAFB5A6A1DAA0A3C8B1B1C8BABECD
                    C1C7D2C1C6D8BFC8D6BBC6CDB9C3C3B2B9BFA9ACDCBFC0FDF8F7FEFEFE29FAE8
                    D4E49B8DDEA191CEA793D79C8ACA9D89BA9D86D49784D49E80E2A07CEAAC80DE
                    AB78FB8F64EAB485D9A980D4A17AD6A178D89C77DA9D7BD9A17FDFA982EDAF83
                    E3A677FCF7E9FEFEFE29EFEED1D0A18AEEDAC2F3FBE3FAF5E1F3F5E1E0F5E0F4
                    EFE1EEF2EEFBF4EDF7FAE9D9DCC2F4A99AF9FDEAF2F7EBF2F4EBF2F3E6F3EEE7
                    F4F0ECF3F3EEF8F8EEF9F4E3D0B69FFAF4EDFEFEFE29EFF0D6D5A190EED9C9ED
                    FDEFFAFDF5F7FEF7DEFEF9F6FAFBECFDFDFDFAF8F4FDF0CDDCC5EFA498F1FEED
                    ECFDF6F3FDF8F4FEF6F9FEFBF8FCFDF2FBFAF6FDF7F5F5E7C5B39EFAF7EFFEFE
                    FE29EEE9DCDB9F8EEDD5CBEEF9F5F8F9F9F5FCFDE2FDFDF8F8FEF6FCFDFDF8F8
                    F5FCF1DCDAC4F5A791FBFDF1F7FBF7FCFDF8FDFEF7FDFDFAFEFCFDFDFBFCFBFB
                    F7F7F2E3CFB199FAF6EEFEFEFE29E7E2E7E1A67CEDD8C9F6EFF6E4ECE7EFEDEC
                    F2F2ECF2EEF2EFEEEDEDEAEEF0F7F4F3D8CAF2B584F8F4F7ECE9EEE7EDE7EEF0
                    F0EDF3EFF1EFF0EFE9EEE9EFF1F0F2E5D7B297FBF5EBFEFEFE29EAE6EADFA47B
                    EDD8C9F4EBF4D5DDD7DEDBDBDEDED9DDD7DFDDDADAE0DADFECF4F1F1D7C9EFB3
                    82FAF7F9E3E0E5D3D9D2D9DAD9D7DEDADED9D9DFD6DDDFE6E7EEF2E5D6B196FB
                    F5EBFEFEFE29E6E2E6E2A77DEED9CAEEE4EDD4DCD6DEDCDBDEDED8DED9E0E1DE
                    DEDFD9DEE9F1EDF3D8CAF1B482F5F2F5E1DEE3D8DED7DDDEDDD8DFDBE2DDDDE1
                    D8DFDEE4E6EEF1E4D6B196FBF5EBFEFEFE29E9E4E9E3A87EEFDACBF5EBF4DDE5
                    DFE1E0DFE1E1DCE4DFE5E6E4E3E7E1E6EDF5F2F3D7C9EFB381F9F5F8E6E3E8DF
                    E4DEE2E2E2DEE4E1E5E1E2E7DEE5E5ECEDF1F5E8D6B196FBF5EBFEFEFE29E5E1
                    E6E1A77DEBD6C6F4EAF3D9E2DCE0DEDDDFDFDADFDAE1DFDCDCE3DDE1ECF4F1F2
                    D7C8F2B584FAF7F9E6E4E8D9DFD8DDDDDCD7DEDAE1DBDCE2D9DFE1E7E9F2F4E7
                    D5B195FBF5ECFEFEFE29E8E4E8E1A67CEDD8C9F3E8F2D4DDD7DDDADADCDCD7DB
                    D6DEDCD9D9DFD9DEE5EDE9F3D7C9F0B381F7F3F5E0DEE3D7DDD7D9D9D8D4DBD7
                    DDD8D9E1D8DEDCE3E4F0F2E4D7B297FBF5ECFEFEFE29E7E2E7E0A57BEEDACBF3
                    E8F2DAE2DCE6E3E3E7E7E1E7E1E9E7E3E3E3DCE1EAF3F0F1D6C8F0B382F9F6F8
                    E3E0E5DDE3DCE4E4E3E0E7E3E7E3E4E5DDE4E0E6E8F1F4E6D6B196FBF5ECFEFE
                    FE29EAE2E0DBA883ECD8C9F5EEF1DDE3DCE1E0E0DEE1DDDDDEE4DCE1E0E3E0E3
                    EFF3EEF0D7C9E7B189F9F7F6E2E4E5DAE1DCE0E0E0DBE2E0E0DFE1E1DDE3E3E8
                    E8F3F3E5D6B298FBF6EDFEFEFE29FAE7D2C3A692E7D7C6F2ECE0E0DBD4D8DAD6
                    CDD6D5CAD8D8C6DBD7D6DAD2F9F1E4E9D7C8C6A799F9F8EEDADFDAD2DBD7D7D8
                    D5CCD6D6C7D8DACDDBDBE5E4DDFAF0E1D0AE98FAF4EDFEFEFE29FDF1D9C7AB93
                    E6D3BEFFF8E5FEFAEBFCF9EBF8F6EBF6F5EBF6F8EDFEFBEDFEF8E6E9D4BECFA7
                    92FFF5E4FEFBF0FBFAEEF4F9E9EDF7E9ECF8EFF1FAF0F9FBECF9EED7C7B293FA
                    F7EDFEFEFE29FEFBE5E4D2BBC4AC96C9B49FD4C2AED7C5B1DBC8B5DBC6B4DAC3
                    B5D6BCAAD3B39BD5B096D3AD95D2AD99D3B7A7DBC1AEE2C7ADE4C8B3E3C4B4DF
                    BEB0D8B7A5D3AF97D9BEA0FCFAF0FEFEFE29FFFBEEFEFDF0FCF6E9F2ECDFEDE5
                    D6EADFCFE6DCCCE3DACAE9DCD2EFE5D9F5EEDEFEFAE9FEFBEBFBF1E2F3E4DAEB
                    E0D2E7DCC6E8D8C6E9D9CCEDDDD3F3E5D9F6F1E2F8F9E8FCFCF6FEFEFE29FCFE
                    FCFDFEFCFDFEFCFEFEFBFEFEFBFFFEF9FFFEF8FEFEF8FEFEFCFDFEFBFCFEF9FB
                    FFF9FBFFF9FCFEFAFCFEFBFBFEF9FAFFF5FDFFF7FDFFF8FDFFFAF8FFFBEEFFFA
                    E6FFF9F6FEFCFEFEFE29F7FEFFF8FEFFF9FEFFFBFEFFFDFEFFFDFEFEFEFEFEFE
                    FEFEFCFEFEFAFEFEF7FEFFF4FEFFF3FEFFF4FFFFF5FEFEF7FDFEF9FDFEFAFDFE
                    FBFEFEFAFEFFF7FEFFF2FDFFEEFDFFF9FDFEFEFEFE29FBFFFDFBFEFDFBFEFDFB
                    FEFEFAFEFEFAFEFEFAFEFEFBFEFEFBFEFDFCFEFEFCFDFEFCFDFEFAFDFEF8FEFE
                    F4FFFDF7FCFDFEF9FFFDFAFFFCFBFEFCFCFEFDFCFEFEFBFEFFFAFEFEFCFEFEFE
                    FE29FFFFFAFFFFFAFEFFFAFEFFFBFCFFFCFAFFFDF8FFFEF9FFFEFEFFFAFFFEFC
                    FFFDFDFFFCFEFFFCFEFEFEFDF9FFFBF9FDFBFDFCFFF9FDFFF4FFFEF3FFFCF8FF
                    FCFDFEFDFFFCFEFEFDFEFEFEFE29}
                  Stretch = True
                  Transparent = True
                end
              end
            end
          end
          object TPage
            Left = 0
            Top = 0
            Caption = 'LINEITEMS_PAGE'
            object TOP_SEP_PANEL: TPanel
              Left = 0
              Top = 0
              Width = 647
              Height = 1
              Align = alTop
              BevelOuter = bvNone
              Color = clBlack
              TabOrder = 0
            end
            object INVOICE_LINEITEMS_BACK_PANEL: TPanel
              Left = 0
              Top = 1
              Width = 647
              Height = 275
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              ParentBackground = False
              TabOrder = 1
              object LINE_ITEM_DOCK: TScrollBox
                Left = 0
                Top = 29
                Width = 647
                Height = 246
                VertScrollBar.Tracking = True
                Align = alClient
                BevelInner = bvNone
                BevelOuter = bvNone
                BorderStyle = bsNone
                Color = clWhite
                ParentColor = False
                TabOrder = 0
              end
              object Panel4: TPanel
                Left = 0
                Top = 0
                Width = 647
                Height = 29
                Align = alTop
                BevelOuter = bvNone
                BorderWidth = 2
                Color = clWhite
                ParentBackground = False
                TabOrder = 1
                object Panel10: TPanel
                  Left = 2
                  Top = 2
                  Width = 643
                  Height = 25
                  Align = alClient
                  BevelOuter = bvNone
                  Color = 16444898
                  ParentBackground = False
                  TabOrder = 0
                  object Label2: TLabel
                    Left = 28
                    Top = 5
                    Width = 171
                    Height = 14
                    Caption = 'Invoice Return Line Items'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Verdana'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Image3: TImage
                    Left = 0
                    Top = 0
                    Width = 25
                    Height = 25
                    Picture.Data = {
                      07544269746D6170A2070000424DA20700000000000036000000280000001900
                      00001900000001001800000000006C070000130B0000130B0000000000000000
                      0000FFFDFFFEFEFEFFFEFFFFFEFFFFFEFFFEFDFEFFFEFFFFFEFFFEFDFEFFFDFF
                      FFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFE
                      FFFFFEFFFFFEFFFFFDFFFFFEFF00FEFAFEFFFEFFFFFEFFFFFEFFFFFEFFFEFDFE
                      FEFDFEFFFFFFFFFFFFFFFFFFFFFFFFFEFDFEFFFEFFFFFEFFFFFEFFFFFEFFFFFE
                      FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFDFF00F8F8FEFFFEFF
                      FFFDFFFFFEFFFFFEFFFEFDFEFFFFFFE1E1E3B0B4B7BCBEC1E3E3E4FFFFFFFFFE
                      FFFFFEFFFFFEFFFEFDFEFFFEFFFFFEFFFEFDFEFFFEFFFFFEFFFEFEFFFFFDFFFF
                      FEFFFEFDFF00F6FDFDFFFDFFFFFEFFFFFEFFFFFDFFFFFEFFE6E5E6585A5B4F4E
                      50706F6DA7A5A3FFFFFFFFFEFFFFFEFFFEFDFEFFFEFFFFFEFFFFFFFFFFFFFFFF
                      FDFFFFFEFFFFFDFEFEFEFFFEFDFFFFFDFF00F9FEFEFFFDFFFFFEFFFFFFFFFFFF
                      FFFDFDFDB5B7BB5E5E62948D86E3DBD399938EFFFFFFFEFDFFFFFEFFFFFEFFFD
                      FDFEFDFCFDCBCBCEE4E2E4FFFFFFFEFCFEFFFEFFFFFDFFFDFDFFFDFEFF00FFFD
                      FFFEFEFFF6F4F5C4C1C3B2ADB3F0F2F9BABED046516673839B98A7BD8E9CAEFF
                      FFFFFDFEFFFEFDFFFFFEFFF7F7F87F84893132386A696DDFDAE0FFFFFFFEFDFE
                      FEFEFEFFFDFFFFFDFE00FFFEFFF9F9F98480835C58618C90A093A4B9A0BAD154
                      79A74D86CC4982C66C9CD3C1E4F6D3EBF8F4FBFFFEFFFFDADAD81F292F919AA3
                      B1B3BAB3AFB5FFFFFFFEFDFEFEFDFEFDFDFEFEFEFE00FFFEFFDADADB5C5F6770
                      7A8A829AB54D769D4B86B7488EC83D86D33E84D03C7BBF5086C46693C39ABFDF
                      B2D0EBC3DDEE3C505C626F778C9099CBC7CFFFFFFFFFFDFFFDFDFDFBFFFCFEFF
                      FE00FFFEFFFBFBFBA8B2B93F59705C87AD68A9DC4F9FDD398ECF4989C73D79B7
                      3671B22A67AA1F5FA31A5DA32364AF508ED093B8CF96ADBBC0C9D2FAF8FBFEFD
                      FEFEFDFFFEFDFEFDFFFDFEFFFE00FEFDFEFFFFFFE9ECF2AFCCE886C1F756A1F0
                      4890E74689DF4899E9549DED5793E54E87D6306EB815549A134D941F54981256
                      8E6396C0D5EAFCFDFDFFFFFDFEFEFEFAFCFDFDFCFEFFFEFEFE00FFFEFEFFFEFE
                      FDFEFFD3F1FD84C2F7337FDA2E74D24E94EC45A5F13890DB3984D04891DC4E9D
                      E25AABEE549FE14186C92C77B23C74A3C3E0EEFDFEFEFFFDFEFEFEF9FCFFFDFC
                      FEFFFEFEFE00FFFEFFFFFEFFEFF4FC799DCF3474C7307ADB3A84E74A90E95AA4
                      E94988CD3367AE2C5FA71B559C1B5AA03370B6538AD070B8F18DCAF5B0D6F3F5
                      FCFEFFFEFEFFFEFDFDFFFCFBFFFFFEFFFF00FFFDFFFEFFFFC5DDF06091D14182
                      DF3D85EF3984E74E9AEE5EAFEA5EA6E35F9EDD5C9CDB4993D13B8DCB408FCF3A
                      83C5246EAA4488B49DD1EDEEFBFEFEFDFEFEFDFEFEFEFEFAFEFEFEFFFF00FFFD
                      FFFBFFFFA6CDE65892DD4083EB3C82F03C87E64D9DE777C8F6A4EBFBA1E0FD7F
                      C0ED4D99D25DB3EA5EB2EC74C0F781CBF381CAF08FD0EBD0F5FAF5FEFFFFFCFE
                      FEFDFEFBFEFFFEFFFE00FEFDFEE7F9FF85B9E4488DE04389F74487F4428BE25B
                      AAE76CAFDD659BC86E9BC36C9FC53774A868ADE25197CB4B8CC33F86BC4798C4
                      7AC7E3BAEDF7F1FFFEFFFDFFFEFDFEFBFFFCFDFFFE00FDFCFFD3EFF96EAEE04B
                      9AEF4188F84183EC4890DD63B8E968C1E96EBEE769B1DB4E98C255AAD45AB8E1
                      51AFD8449AC6337DB22479A56BC4DEA1DFF0EFFFFFFFFDFEFEFDFEFBFDFDFDFE
                      FE00FDFEFFC3E4F1579ED64095F03B84F33D7DE15EA7E97FD1F87EC7EC7FBEE9
                      75ACD98AC5EE79BCE687D3F77ECAF27DC2EF7EC2F167BDEB6FCCEA8ACBDFEFFE
                      FFFFFEFFFFFDFFFBFEFEFEFFFE00FDFDFEB2D4F03C86D03388EF3D83F3417FD9
                      6BB6EA87DFF976B7DC6DA8D472ACDA609ECB3575A75598CD4D92C94084BD306D
                      AE115F965AB7DF83C8E7DBF0FEFFFFFFFEFDFFFFFDFCFFFEFE00F5F9FE8CB5EE
                      3B84DA2F7FEB3779E94983E271BCF984DFFF8ADBFF8EDEFF8EDEFF87DAFF75CA
                      F476CCF66BC4F464BBEE74BDEE5EB7E164CBE87BCFE6B6E2EEFFFFFFFFFDFFFF
                      FDFEFEFDFE00ECF7FC70A5D4529AD660A9F46CA7F66EA6EC67AFE252A8CC5BA6
                      C557A1C1509ABA509BBD4693B94897BE5BABD5529FC86AA5C671B8D37FD4E67D
                      C5CFAFD9DEFFFFFFFFFDFEFFFEFFFFFDFF00FFFCFEFAFCFFF7FFFFEFF7FFF5F3
                      FFF5F3FFF1F8FFE5F7FFDDF3FFD6EDFDD0E8F9CDE5F7CCE2F3C0DDF29DBAD6D4
                      EEFFEFF9FFF1FFFFF0FFFFAEC4C7CFD7DAFFFFFFFEFEFFFFFEFFFFFEFF00FFFD
                      FFFFFEFEFFFEFEFFFEFDFFFEFDFFFFFEFFFEFFFFFEFFFFFDFFFFFDFEFFFCFEFF
                      FEFFFFFFFFFFFEFFBEBBC2F8F4FAFFFFFFFFFFFFFFFFFFF8F5F6C2BBBBF6F2F3
                      FFFFFFFFFEFEFEFDFE00FCFCFEFDFDFEFEFDFDFDFEFAFDFEFBFDFDFDFDFDFEFD
                      FCFEFDFDFCFDFEFBFDFEFBFDFEFBFEFDFEFFFFFFDBDBD79A9B98DADDDBD1D4D2
                      C9CBCAC9CDCC9FA5A2B9BEBCD7DCDA8B8F8EE1E2E200F1FCFFF4FDFFF5FEFFF1
                      FFFEEEFFFFEEFEFFF3FEFFF8FDFFF8FEFDF7FFFDF7FFFDF9FDFDFFFDFEFFFEFF
                      F6FBF8AAB2ADE8F1EFE6E7E7E2E3E3E1E2E2DCE1DFD5E1DFD5DDDD747677E3E4
                      E400FEFDFDFEFDFCFEFDFCFDFEFCF7FFFCF8FFFBFDFEFBFEFDFCFCFCFEFBFCFE
                      FBFCFEFEFDFEFFFDFFFFFEFFFEFEFEFBFCFCFDFDFFFEFDFEFFFEFFFFFEFFFFFE
                      FFFDFDFEFDFDFEF8F9F9FEFDFE00}
                    Stretch = True
                    Transparent = True
                  end
                end
              end
            end
          end
          object TPage
            Left = 0
            Top = 0
            Caption = 'FEE_PAGE'
            object FEE_BACK_PANEL: TPanel
              Left = 0
              Top = 0
              Width = 647
              Height = 276
              Align = alClient
              BevelOuter = bvNone
              Caption = 'FEE_BACK_PANEL'
              TabOrder = 0
              object FEE_DOCK: TScrollBox
                Left = 38
                Top = 29
                Width = 609
                Height = 247
                Align = alClient
                BevelInner = bvNone
                BevelOuter = bvNone
                BorderStyle = bsNone
                Color = clWhite
                ParentColor = False
                TabOrder = 0
              end
              object FeeToolBar: TToolBar
                Left = 0
                Top = 29
                Width = 38
                Height = 247
                Align = alLeft
                AutoSize = True
                ButtonHeight = 50
                ButtonWidth = 38
                Caption = 'LineItemToolBar'
                Color = clYellow
                EdgeInner = esNone
                EdgeOuter = esNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Images = IMG_StorageForm.Avobase_ToolBar_Img
                ParentColor = False
                ParentFont = False
                ShowCaptions = True
                TabOrder = 1
                Transparent = True
                Visible = False
                OnCustomDraw = LineItemToolBarCustomDraw
                object AddBlankFeeLineBtn: TToolButton
                  Left = 0
                  Top = 0
                  Hint = 'Add a blank Invoice Line'
                  Caption = 'Blank'
                  ImageIndex = 33
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = AddBlankFeeLineBtnClick
                end
                object AddFeeLineBtn: TToolButton
                  Left = 0
                  Top = 50
                  Hint = 'Find a Product and Add to Invoice'
                  Caption = 'Add'
                  ImageIndex = 57
                  Wrap = True
                  OnClick = AddFeeLineBtnClick
                end
                object DeleteFeeLineBtn: TToolButton
                  Left = 0
                  Top = 100
                  Hint = 'Delete Selected Invoice Line'
                  Caption = 'Delete'
                  ImageIndex = 9
                  OnClick = DeleteFeeLineBtnClick
                end
              end
              object Panel7: TPanel
                Left = 0
                Top = 0
                Width = 647
                Height = 29
                Align = alTop
                BevelOuter = bvNone
                BorderWidth = 2
                Color = clWhite
                ParentBackground = False
                TabOrder = 2
                object Panel8: TPanel
                  Left = 2
                  Top = 2
                  Width = 643
                  Height = 25
                  Align = alClient
                  BevelOuter = bvNone
                  Color = 16444898
                  ParentBackground = False
                  TabOrder = 0
                  object Label4: TLabel
                    Left = 28
                    Top = 5
                    Width = 132
                    Height = 14
                    Caption = 'Invoice Return Fees'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Verdana'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Image5: TImage
                    Left = 0
                    Top = 0
                    Width = 25
                    Height = 25
                    Picture.Data = {
                      07544269746D6170A2070000424DA20700000000000036000000280000001900
                      00001900000001001800000000006C070000130B0000130B0000000000000000
                      0000FFFFFEFFFFFDFFFFFDFFFFFEFFFEFEFEFFFEFFFFFEFFFFFDFEFEFDFFFFFD
                      FEFEFEFEFEFEFEFEFEFFFFFEFEFEFDFFFFFEFEFEFDFDFDFCFDFDFDFDFDFDFEFE
                      FDFFFFFEFEFEFDFFFFFEFEFEFE00FFFFFEFFFFFEFFFFFDFFFFFDFFFFFDFFFEFD
                      FFFFFDFFFFFFFFFFFFFEFEFDFEFEFDFAFAFAFEFEFDFFFFFFFAFAF9E5E5E5D7D7
                      D7CFCFCFD2D2D2D0D0D0D2D2D2E7E7E7FBFBFAFFFFFEFFFFFD00FFFFFEFFFFFE
                      FFFFFDFFFFFDFFFFFDFFFEFEFFFFFFEEEDEFE3E3E3FFFFFFFFFFFEFFFFFEFFFF
                      FFE8E8E7BABABABABABABBBBBBB7B7B7A9A9A9A0A0A09292928C8C8CB3B3B3EE
                      EEEDFEFEFD00FFFFFEFFFFFDFFFFFEFFFFFDFFFFFDFDFDFDD4D3D6A9A8ABAEAE
                      AFB2B2B1F1F1F1FFFFFFF9F9F9C3C3C3E4E4E4D3D3D3C1C1C1B7B7B7ABABAB8F
                      8F8F8B8B8B8383837D7D7DA1A1A1F6F6F600FFFFFEFFFFFEFFFFFDFFFFFEFFFE
                      FDFCFCFCDAD7D7EEECECF8F8F8E6E6E6B6B6B6969696969696D9D9D9CCCCCCBF
                      BFBFC2C2C2C9C9C9D1D1D1D6D6D6D6D6D6B3B3B3818181828282DADADA00FFFF
                      FEFFFEFEFFFFFDFFFFFEFEFEFDF8F7F7B5B3AFFFFEFBEFEEEDEDEDEDFCFCFCFF
                      FFFFEAEAEAC1C1C1B9B9B9C7C7C7C8C8C8C0C0C0B0B0B0A2A2A29E9E9EC5C5C5
                      DCDCDCA1A1A1DBDBDB00FFFEFDFFFFFDFFFFFEFEFEFDFFFFFFD8D6D1C3C1BCFD
                      FCF9EBEAE9EAEAEAEAEAEAE5E5E5DDDDDDB2B2B2E3E3E3EAEAEAD2D2D2C0C0C0
                      B9B9B9ACACAC9C9C9C7A7A7A7A7A7AD2D2D2DDDDDD00FFFDFEFEFFFDFFFFFEFF
                      FFFFEFEDEAB0ADA5FFFEF4F7F6EEECEBEAEFEFEFE8E8E8E8E8E8DDDDDDE7E7E7
                      CDCDCDD2D2D2CDCDCDC8C8C8C7C7C7CBCBCBCECECEB5B5B59292928A8A8ADBDB
                      DB00FFFDFEFFFFFDFEFEFDFFFFFFADAAA6E5E3DCFEFEF5F5F4E9E8E8E6F0F0F0
                      E7E7E7ECECECE5E5E5BDBDBDD1D1D1CFCFCFDFDFDFCECECEC2C2C2B3B3B3ACAC
                      ACAFAFAFDFDFDFAEAEAEDBDBDB00FBFEFDFFFFFDFFFFFFD8CFBFE1D7B8EEE8CA
                      FFFFF6F6F2F5F5F4F5F1F1F1E4E4E4EBEBEBDADADAA6A6A6EAEAEAECECECE0E0
                      E0B9B9B9A7A7A79999998C8C8C828282848484D2D2D2DCDCDC00FFFFFDFFFFFF
                      F7F4EFC5BAA2F3E7C6EDE7CAFFFFF6EEEDEEE6E6E7EBEBEBEBEBEBF3F3F3E1E1
                      E1E1E1E1E8E8E8DCDCDCDFDFDFD8D8D8DFDFDFE2E2E2D1D1D1A8A8A88F8F8F89
                      8989DADADA00FFFFFEFEFEFCD1CBBBEBE2C2E6DBBAFAF5DEFDFDF4EFF1EEF2F3
                      F3EDEDEDE7E7E7EAEAEADDDDDDCCCCCCD4D4D4C4C4C4C2C2C2CDCDCDDADADAE0
                      E0E0F7F7F7FFFFFFE0E0E09B9B9BDADADA00FFFFFEEDECE3D1CCA7EFE5BDE8DB
                      BBFFFDEAF9FAF1EAEDE9EDEEEDE6E6E6E9E9E9F3F3F3D8D8D8D3D3D3AEAEAEB8
                      B8B8C2C2C2CFCFCFDADADAE5E5E5ECECECFBFBFBF8F8F8E8E8E8DADADA00FDFD
                      FCC2C0A8ECE6B8FDF5C7F1E2C5FFFEF3F7F8F3E0E8E1E8EAE9E8E8E8EEEEEEF3
                      F3F3D4D4D4CDCDCDB6B6B6B5B5B5C9C9C9CFCFCFDFDFDFE5E5E5F3F3F3F2F2F2
                      ECECECDADADAE3E3E300E0DAD7D3CDAFF3EEB7F9EDBCF6E4CDFFFFFFF8F8FAEA
                      F3EEEEF1EFE8E8E8EAEAEAE3E3E3E8E8E8C1C1C1C8C8C8CBCBCBC2C2C2D0D0D0
                      E0E0E0E2E2E2FFFFFFCBCBCBB4B4B4D5D5D5FCFCFC00D5C8C7FBF2D2F6F1B5F4
                      EBB8FAEDDEFDF9FFE5E1EDE0EAE9E9EBEAEAEAEAF4F4F4F5F5F5E9E9E9EDEDED
                      BABABAC6C6C6C1C1C1BFBFBFC0C0C0BEBEBEA3A3A3BDBDBDC8C8C8F7F7F5FFFF
                      FE00FEFEFDD5CBB3FEFBC6E2D7AAFBF4E6FCF5F7EBE8EDF1F9F4EAEBEFE7E6EC
                      EBECEEDEE1DFE6E9E7F2F6F5EDF1F1F0F3F5CECED1CECFD0AAACAEC2C2C2DADA
                      DAFAFAFAFFFFFFFFFFFEFEFEFD00FEFEFDFFFFFFFBF9EBC8C4AADED7B7E6DEB7
                      E5DCACEEE9B8F1F0D5FAFAE8F8FAF5EEEFF3EDEEF7E6EAF2DDE7EAE2EEEEEEEC
                      F5F5F8FFCDD3DCFEFFFFFFFFFFFFFFFEFEFEFDFEFEFDFFFFFE00FFFFFEFFFFFF
                      FFFFFBB7AE94DFCDA0F5F2B7F1E195EBCA79D7BC67CCB467DCC68BF5E2B9FFF8
                      E1FFFEF3FBF5F0FCEEECFAF1E3EDE8E5E8EBF0FDFEFDFEFEFDFEFEFEFFFFFEFF
                      FFFEFEFEFD00FFFFFDFFFFFFF6F4EEC8BB9FF1D9A6FFFFC3EBC169FDD37BFCD3
                      9AFCC383DAA24AD0A43CD3AF46D3B058DEBC79EACE9AFFF2C9FAEFD5FBF7F3FE
                      FEFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFE00FEFFFDFFFFFEFAF8F3E6DCC6CCB9
                      93D3B47EDFBF7BDCB568F1C965F4D26FF1BB5FE5AE5AE8AE5FE1A557DEA253DF
                      A252C99250BF9B6FEBE7DFFFFFFEFEFEFDFFFFFEFFFFFEFFFFFEFFFFFE00FEFF
                      FDFDFEFEFFFFFDFFFFFFFFFFFFFFFFFFF9EFD3D9CDB0CFBC9DD7C294D8C77ED4
                      BE5ED7B652E0AE5DE8A66FEFA37FD8A45DCFAF82F9F5EDFFFFFEFFFFFEFFFFFE
                      FFFFFEFFFFFEFFFFFE00FEFFFDFFFFFCFEFEFDFFFFFDFFFFFEFFFEFDFFFFFFFF
                      FFFFFFFFFFF7F5F8F3F1EAE8E1CCE0D6B3E5CF9DDFC183D9BA76D1AB7BDBCAB1
                      FFFFFDFEFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFE00FDFFFCFDFFFDFDFFFEFE
                      FFFDFFFEFDFFFFFEFFFEFEFEFFFEFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFDF8
                      F8F4EAF2EFE2F2EBE2F8F7F3FFFFFEFFFEFDFFFFFEFFFFFEFFFFFEFFFFFEFFFF
                      FE00F8FFFEFAFFFEFBFFFFFEFFFDFFFFFDFFFFFEFFFFFEFFFFFEFFFFFDFFFFFE
                      FFFFFDFFFEFDFEFEFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFEFEFDFFFFFDFFFF
                      FEFFFFFEFFFFFEFFFFFEFFFFFE00}
                    Stretch = True
                    Transparent = True
                  end
                end
              end
            end
          end
        end
        object BOTTOM_TOTAL_PANEL: TPanel
          Left = 1
          Top = 317
          Width = 647
          Height = 129
          Align = alBottom
          BevelOuter = bvNone
          BorderWidth = 1
          Color = clBlack
          ParentBackground = False
          TabOrder = 1
          object OptionTotalPanel: TPanel
            Left = 1
            Top = 1
            Width = 645
            Height = 127
            Align = alClient
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            object InvoiceTotalsPanel: TPanel
              Left = 388
              Top = 1
              Width = 256
              Height = 125
              Align = alRight
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              OnClick = InvoiceTotalsPanelClick
              object SubTotalLabel: TLabel
                Left = 0
                Top = 0
                Width = 194
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'RETURN LINE ITEM SUBTOTAL:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object OrderProcLabel: TLabel
                Left = 49
                Top = 14
                Width = 145
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'RETURN ORDER FEES:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object SalesTaxLabel: TLabel
                Left = 49
                Top = 46
                Width = 145
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'RETURN SALES TAX:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object AmountDueLabel: TLabel
                Left = 48
                Top = 106
                Width = 145
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'REFUND AMOUNT'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Amount_SubTotal: TLabel
                Left = 195
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
                Left = 195
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
                Left = 195
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
                Left = 21
                Top = 62
                Width = 173
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'RETURN INVOICE TOTAL:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Amount_Total: TLabel
                Left = 195
                Top = 62
                Width = 60
                Height = 16
                Alignment = taRightJustify
                AutoSize = False
                Caption = '$    0.00'
                Color = 7405307
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clMaroon
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                Transparent = False
              end
              object Amount_Due: TLabel
                Left = 194
                Top = 106
                Width = 60
                Height = 16
                Alignment = taRightJustify
                AutoSize = False
                Caption = '$    0.00'
                Color = 7405307
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                Transparent = False
              end
              object ShippingLabel: TLabel
                Left = 49
                Top = 30
                Width = 145
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'RETURN SHIPPING:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Amount_Shipping: TLabel
                Left = 195
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
              object Label3: TLabel
                Left = 20
                Top = 85
                Width = 173
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'PRIOR VOIDED PAYMENTS:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object amount_void: TLabel
                Left = 194
                Top = 84
                Width = 60
                Height = 16
                Alignment = taRightJustify
                AutoSize = False
                Caption = '$    0.00'
                Color = 7405307
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clMaroon
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                Transparent = False
              end
              object Panel9: TPanel
                Left = 195
                Top = 59
                Width = 60
                Height = 2
                BevelInner = bvRaised
                BevelOuter = bvNone
                Color = clBlack
                TabOrder = 0
              end
              object Panel3: TPanel
                Left = 195
                Top = 102
                Width = 60
                Height = 2
                BevelInner = bvRaised
                BevelOuter = bvNone
                Color = clBlack
                TabOrder = 1
              end
            end
            object Panel17: TPanel
              Left = 385
              Top = 1
              Width = 3
              Height = 125
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
            end
            object GroupBox1: TGroupBox
              Left = 4
              Top = 1
              Width = 177
              Height = 69
              Caption = 'Previous Set Order Options'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              object ShowDiscount: TCheckBox
                Left = 11
                Top = 17
                Width = 154
                Height = 17
                Caption = 'Discount Shown On Invoice'
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = ShowDiscountClick
              end
              object WaveTaxCheckBox: TCheckBox
                Left = 11
                Top = 32
                Width = 124
                Height = 17
                Caption = 'Invoice Tax Waved'
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                OnClick = WaveTaxCheckBoxClick
              end
              object WaveShippingBox: TCheckBox
                Left = 11
                Top = 47
                Width = 95
                Height = 17
                Caption = 'Shipping Waved'
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
                OnClick = WaveShippingBoxClick
              end
            end
          end
        end
        object GroupBox2: TGroupBox
          Left = 1
          Top = 1
          Width = 647
          Height = 40
          Align = alTop
          Caption = 'Invoice Refund Options'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentColor = False
          ParentFont = False
          TabOrder = 2
          object db_refundshipping: TCheckBox
            Left = 15
            Top = 16
            Width = 229
            Height = 17
            Caption = 'Refund Shipping Costs'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = db_refundshippingClick
          end
          object returnAllLineItemsCheck: TCheckBox
            Left = 257
            Top = 17
            Width = 145
            Height = 17
            Caption = 'Return ALL Line Items'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 1
            OnClick = returnAllLineItemsCheckClick
          end
          object returnAllFeeItemsCheck: TCheckBox
            Left = 413
            Top = 17
            Width = 148
            Height = 17
            Caption = 'Return All Order Fees'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = returnAllFeeItemsCheckClick
          end
        end
      end
      inherited ToolBar: TToolBar
        Top = 37
        Width = 649
        ExplicitTop = 37
        ExplicitWidth = 649
      end
      inherited StatusBar: TStatusBar
        Top = 538
        Width = 649
        ExplicitTop = 538
        ExplicitWidth = 649
      end
    end
  end
end
