inherited Pref_RepresentativeForm: TPref_RepresentativeForm
  Caption = 'Pref_RepresentativeForm'
  ClientHeight = 703
  ClientWidth = 563
  OnCreate = FormCreate
  ExplicitWidth = 563
  ExplicitHeight = 703
  PixelsPerInch = 96
  TextHeight = 13
  inherited pref_full_back_panel: TPanel
    Width = 563
    Height = 703
    ExplicitWidth = 563
    ExplicitHeight = 703
    inherited PREF_BACK_PANEL: TPanel
      Width = 563
      Height = 674
      ExplicitWidth = 563
      ExplicitHeight = 674
      inherited PADDING_PANEL: TPanel
        Width = 563
        Height = 674
        ExplicitWidth = 563
        ExplicitHeight = 674
        inherited Pref_Scroll_Box: TScrollBox
          Width = 547
          Height = 658
          ExplicitWidth = 547
          ExplicitHeight = 658
          object RepSettingsGroupBox: TGroupBox
            Left = 0
            Top = 0
            Width = 547
            Height = 290
            Align = alTop
            TabOrder = 0
            ExplicitTop = -2
            object Label1: TLabel
              Left = 29
              Top = 38
              Width = 92
              Height = 13
              Caption = 'Company Name:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label2: TLabel
              Left = 60
              Top = 65
              Width = 61
              Height = 13
              Caption = 'Address 1:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label3: TLabel
              Left = 60
              Top = 92
              Width = 61
              Height = 13
              Caption = 'Address 2:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 95
              Top = 119
              Width = 26
              Height = 13
              Caption = 'City:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label5: TLabel
              Left = 86
              Top = 146
              Width = 35
              Height = 13
              Caption = 'State:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label6: TLabel
              Left = 24
              Top = 173
              Width = 97
              Height = 13
              Caption = 'Zip/Postal Code:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label7: TLabel
              Left = 80
              Top = 200
              Width = 41
              Height = 13
              Caption = 'Phone:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label8: TLabel
              Left = 55
              Top = 227
              Width = 66
              Height = 13
              Caption = 'Cell Phone:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label9: TLabel
              Left = 100
              Top = 254
              Width = 21
              Height = 13
              Caption = 'Fax'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label10: TLabel
              Left = 54
              Top = 12
              Width = 67
              Height = 13
              Caption = 'Your Name:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object db_rcomp: TEdit
              Left = 125
              Top = 35
              Width = 352
              Height = 21
              MaxLength = 120
              TabOrder = 1
              Text = 'db_rcomp'
            end
            object db_raddr1: TEdit
              Left = 125
              Top = 62
              Width = 280
              Height = 21
              MaxLength = 100
              TabOrder = 2
              Text = 'db_raddr1'
            end
            object db_raddr2: TEdit
              Left = 125
              Top = 89
              Width = 280
              Height = 21
              MaxLength = 100
              TabOrder = 3
              Text = 'db_raddr2'
            end
            object db_rcity: TEdit
              Left = 125
              Top = 116
              Width = 208
              Height = 21
              MaxLength = 40
              TabOrder = 4
              Text = 'db_rcity'
            end
            object db_rstate: TEdit
              Left = 125
              Top = 143
              Width = 121
              Height = 21
              MaxLength = 40
              TabOrder = 5
              Text = 'db_rstate'
            end
            object db_rzip: TEdit
              Left = 125
              Top = 170
              Width = 88
              Height = 21
              MaxLength = 30
              TabOrder = 6
              Text = 'db_rzip'
            end
            object db_rcell: TEdit
              Left = 125
              Top = 224
              Width = 121
              Height = 21
              MaxLength = 30
              TabOrder = 8
              Text = 'db_rcell'
            end
            object db_rphone: TEdit
              Left = 125
              Top = 197
              Width = 121
              Height = 21
              MaxLength = 30
              TabOrder = 7
              Text = 'db_rphone'
            end
            object db_rfax: TEdit
              Left = 125
              Top = 251
              Width = 121
              Height = 21
              MaxLength = 30
              TabOrder = 9
              Text = 'db_rfax'
            end
            object db_repname: TEdit
              Left = 125
              Top = 8
              Width = 352
              Height = 21
              MaxLength = 120
              TabOrder = 0
              Text = 'db_repname'
            end
          end
        end
      end
    end
    inherited PREF_TOP_BACK_PANEL: TPanel
      Width = 563
      ExplicitWidth = 563
      inherited PREF_HEADER_BACK_PANEL: TPanel
        Width = 559
        ExplicitWidth = 559
        inherited PREF_HEADER_LABEL: TLabel
          Width = 198
          Caption = 'Sales Representative Settings'
          ExplicitWidth = 198
        end
        inherited pref_image: TImage
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
        end
      end
    end
  end
end
