inherited Pref_RegistrationForm: TPref_RegistrationForm
  Left = 346
  Top = 2
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'AvoBase'
  ClientHeight = 374
  ClientWidth = 434
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 440
  ExplicitHeight = 402
  PixelsPerInch = 96
  TextHeight = 13
  inherited pref_full_back_panel: TPanel
    Width = 434
    Height = 374
    ExplicitWidth = 435
    ExplicitHeight = 363
    inherited PREF_BACK_PANEL: TPanel
      Width = 434
      Height = 345
      ExplicitWidth = 435
      ExplicitHeight = 334
      inherited PADDING_PANEL: TPanel
        Width = 599
        Height = 589
        Align = alNone
        ExplicitWidth = 599
        ExplicitHeight = 589
        inherited Pref_Scroll_Box: TScrollBox
          Top = 64
          Width = 583
          Height = 517
          ExplicitTop = 64
          ExplicitWidth = 583
          ExplicitHeight = 517
          object AvoRegisterLabel: TLabel
            Left = 15
            Top = 25
            Width = 389
            Height = 86
            AutoSize = False
            Caption = 'TEXT REGISTRATION FILLIN'
            Color = clAqua
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clPurple
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object RegAvoWeb: TLabel
            Left = 16
            Top = 6
            Width = 388
            Height = 13
            Caption = 'Re-Register AvoBase Today To Continue With Full Features!'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RegBox: TGroupBox
            Left = 15
            Top = 117
            Width = 389
            Height = 139
            Caption = 'AvoBase Registration Settings'
            TabOrder = 0
            object RepName: TLabel
              Left = 95
              Top = 23
              Width = 61
              Height = 13
              Caption = 'RepName'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
            object Label20: TLabel
              Left = 21
              Top = 22
              Width = 68
              Height = 13
              Alignment = taRightJustify
              Caption = 'REP NAME:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label2: TLabel
              Left = 26
              Top = 46
              Width = 63
              Height = 13
              Alignment = taRightJustify
              Caption = 'ADDRESS:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Addr1: TLabel
              Left = 95
              Top = 45
              Width = 39
              Height = 13
              Caption = 'Addr1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
            object Addr2: TLabel
              Left = 95
              Top = 59
              Width = 39
              Height = 13
              Caption = 'Addr2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
            object City: TLabel
              Left = 95
              Top = 78
              Width = 25
              Height = 13
              Caption = 'City'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 55
              Top = 79
              Width = 34
              Height = 13
              Alignment = taRightJustify
              Caption = 'CITY:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label5: TLabel
              Left = 44
              Top = 96
              Width = 45
              Height = 13
              Alignment = taRightJustify
              Caption = 'STATE:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object State: TLabel
              Left = 95
              Top = 96
              Width = 34
              Height = 13
              Caption = 'State'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
            object Label6: TLabel
              Left = 22
              Top = 114
              Width = 67
              Height = 13
              Alignment = taRightJustify
              Caption = 'ZIP/POST:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Zip: TLabel
              Left = 95
              Top = 114
              Width = 20
              Height = 13
              Caption = 'Zip'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
          end
        end
        object MENU_DOCK_PANEL: TPanel
          Left = 8
          Top = 8
          Width = 583
          Height = 56
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
    end
    inherited PREF_TOP_BACK_PANEL: TPanel
      Width = 434
      ExplicitWidth = 435
      inherited PREF_HEADER_BACK_PANEL: TPanel
        Width = 430
        ExplicitWidth = 431
        inherited PREF_HEADER_LABEL: TLabel
          Width = 141
          Caption = 'AvoBase Registration'
          ExplicitWidth = 141
        end
        inherited pref_image: TImage
          Picture.Data = {
            07544269746D6170A2070000424DA20700000000000036000000280000001900
            00001900000001001800000000006C0700002700000027000000000000000000
            0000FDFEFCFDFDFDFCFCFCFDFDFDFDFCFDFEFEFEFEFEFDFEFEFDFEFEFDFEFEFD
            FEFEFEFDFDFDFDFDFEF3F2F4DEDEE0F4F3F5FDFDFDFDFDFDFDFDFDFDFDFDFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFE29FBFCF7FDFEFCFAFAFAFBFAFCFCFAFCFAFAFA
            FDFDFBFDFEFBFDFEFBFEFFFCFEFEFEFDFDFEEFEEF2B6B3BAB7B3BBBAB8BDF4F4
            F4FDFDFDFDFDFDFDFDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE29FEFEFBFDFDFB
            FBFBFBF6F5F7F6F5F8FCFCFCFCFDFBFCFDF9FDFEFBFEFFFCFEFEFEF9F9FAC2C2
            C5BEBCC2C6C3CA9A989DE4E4E4FDFDFDFEFEFEFDFDFDFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFE29FCFCF8FCFDFBF3F3F4C2C0C5ADACB0D9D9DBFAFAFAFBFCF8FDFE
            FBFEFFFCFEFEFEF2F2F3DAD9DDCFCCD3AFADB598969BE1E1E1FCFCFCFCFCFCFD
            FDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE29FCFDFBFBFBFBE7E6E9C1C0C5ACAA
            B0939295EBEBECFCFCFBFEFFFCFEFEFCFDFEFDF2F1F3E4E3E7C7C4CBA8A6AEA3
            A2A7E4E4E4FCFCFCFCFCFCFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE29FCFC
            FBF9F9F9DAD9DDC0BEC5B6B3BB8E8C91BCBCBDFAFAF9FDFEFBFEFEFDFEFEFCF1
            F1F2E7E6EACDCBD29D9AA3A7A5AAE2E2E2FCFCFCFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFE29FBFBFBFAF9FAE3E1E6DAD7DEAAA6AFACAAB0979699E4
            E4E4FEFEFBFEFEFCFEFEFDF1F0F1E6E5E9C8C6CD8D8B93B1AFB5E1E1E1FCFCFC
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE29FBFBFBFCFBFCF1EEF3E2
            DFE8C7C4CD9D9AA19D9B9FB6B5B6F8F9F5FCFDFBFDFDFDF1EFF1E1DFE4C3C0C7
            838189ADABB1E4E4E4FCFCFCFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FE29FBF9FBFCFBFDF9F6FAEAE7EFE6E2EA9A979F9E9CA29B999DDEDEDCFCFCFB
            FDFDFDF0EFF1E5E3E8C0BDC47E7A83ACABB0E6E7E6FCFDFCFDFEFDFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFE29FEFBFFFEFDFEFEFCFEF5F4F5E8E8EAC3C1C6
            817E889D99A4B0AFB2F2F0F3FBFAFCEFEDF1E0DDE4B7B3BC75717BA8A8ACE1E6
            E2FCFEFCFCFEFCFDFDFCFFFEFEFFFEFEFFFEFEFEFEFEFEFEFE29FDFBFEFEFDFE
            FDFCFEFDFDFDECEBEDE3E1E6918D978A86918F8D92D6D5D9FBFAFDF0EEF3D9D7
            DFB3AFBA726E79A4A4AAE0E4E2FAFDFBFBFDFCFDFDFDFFFEFEFFFEFEFFFEFEFE
            FEFEFEFEFE29FCFBFEFEFDFEFDFDFDFCFDFBF7F7F7E4E3E7C3C0C8736F7A9392
            99A4A3AAF0EFF4E7E5EBD4D2DDB0ADB96A67749C9BA3E5E9E9FBFDFDFBFCFDFE
            FDFEFFFEFEFFFEFEFFFEFEFEFEFEFEFEFE29FEFDFEFCFCFDFDFEFDFDFEFCFBFB
            FBEAE9ECDCDAE18F8C9676767E82828BACABB5A5A4AFC0BECBA9A7B66E6C7B94
            939ECCCDD1F9FAFCFCFCFEFDFCFDFFFEFEFFFEFEFFFEFEFEFEFEFEFEFE29FEFE
            FEFEFEFEFEFEFDFEFEFCFDFDFCF6F5F6DAD8DEC3C0CA6B6C768D8D997776839E
            9DAAB3B1C1BAB8C9C0BDCB8C8B997D7E86C7C7CEE7E7EBFCFBFCFFFEFEFFFEFE
            FFFEFDFEFEFDFEFEFE29FEFEFEFEFEFEFEFEFCFEFEFBFCFCFAF9F9FAD6D5DACB
            C9D2B1B1BEBFBFCD8E8D9C8A899976748669687A8987998F8D9E7D7D88878790
            B7B6BDF8F7F9FFFEFEFFFEFEFFFEFCFEFEFDFEFEFE29FEFEFDFEFEFDFEFFFCFD
            FEFAFCFDF9FBFBFADBDADECDCBD3CACAD89696A68787987574877372866F6E82
            7D7C91757487777582706F7A96959DF7F6F9FFFEFEFFFEFEFFFEFCFEFEFDFEFE
            FE29FEFEFEFEFEFCFEFEFCFEFEFBFCFCFAF1F1F2C2C0C7B9B6C1A8A7B69A9AAA
            8181926F6F8272738772728863637A6E6F846E70806E707DA8A8B1F6F5F8FFFE
            FEFFFDFEFFFDFDFEFEFDFEFEFE29FEFEFEFEFEFEFEFEFEFDFDFDFCFBFDE6E3EA
            A9A4B4A19BAEA6A5B490919F888A9A7A7D9075798E7A8096626980636D84717F
            936A7383A1A5AFF7F7FBFFFDFFFFFDFFFFFCFFFEFDFEFEFEFE29FEFEFEFEFEFE
            FEFEFEFDFDFDFBFAFBEDEAF0ACA7B6A8A3B5AAA9BD9394A88A8DA181859B8186
            9E8E95AE7F85A0656E89757F99676D829DA0ACF6F4FAFFFDFFFFFEFFFFFEFFFE
            FEFEFEFEFE29FEFEFEFEFEFEFEFEFEFDFEFDFBFBFCF8F6FBC5C2CC9996A69294
            AC8588A18C90AA898DA87C819D7C839F79809D7A80A0888EAD7A7C969F9FAEF8
            F6FAFFFDFFFFFEFEFFFEFEFEFEFEFEFEFE29FEFEFFFEFEFEFEFEFEFDFEFDFBFC
            FBFCFBFDEFEDF39D9AA88A8DA8878BA7898EAA7B809C989EB7AAB0CA7B819D85
            89A8777A997A7A93AFADBDFAF7FDFFFDFEFFFEFEFEFEFEFEFEFEFEFEFE29FEFE
            FFFEFEFEFEFEFEFEFFFCFDFDFBFDFDFDFBF9FCCECDD582879F9399B2797F9865
            69827B7F97787C93777A9174778F9A9CB4D6D5E1F0EEF4FEFBFEFFFEFEFFFEFD
            FEFEFEFEFEFEFEFEFE29FEFDFFFEFDFEFEFEFEFDFEFCFCFDFAFDFDFCFAFAFBF2
            F2F79EA3B58085987F839576798B7E80909395A29697A4A1A2B0D5D7E3F5F5FC
            FCFAFCFEFDFDFFFEFCFEFEFDFDFEFEFDFEFEFEFEFE29FEFCFFFEFDFEFEFEFEFD
            FEFCFDFDFAFCFDFAFDFDFDFBFBFDE6EBF3D2D8E2E0E4EBB8BAC3D3D4DBF5F5F8
            F9F8FBFBFCFDF8FBFCFAFBFBFBFAF8FEFDFAFFFFFBFEFEFDFCFEFEFDFEFEFEFE
            FE29FEFCFFFEFDFEFEFEFEFDFEFBFDFEF9FCFDF9FCFCFBFBFBFDF4F9FDF6FBFE
            F3F5FAF7F8FCFAFBFCFCFBFCFEFDFCFCFDFCFAFEFBFBFDF8FEFEF7FEFDF7FFFF
            FBFEFEFDFCFEFEFDFEFEFEFEFE29}
        end
      end
    end
  end
  object OpenDLG: TOpenDialog
    DefaultExt = 'abk'
    Filter = 'AvoBase Key Files|*.abk'
    Options = [ofHideReadOnly, ofOldStyleDialog, ofEnableSizing]
    Left = 317
    Top = 252
  end
end
