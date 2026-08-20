inherited Pref_EmailSettingsForm: TPref_EmailSettingsForm
  Caption = 'Pref_EmailSettingsForm'
  ClientHeight = 495
  ClientWidth = 558
  OnCreate = FormCreate
  ExplicitWidth = 558
  ExplicitHeight = 495
  PixelsPerInch = 96
  TextHeight = 13
  inherited pref_full_back_panel: TPanel
    Width = 558
    Height = 495
    ExplicitWidth = 558
    ExplicitHeight = 495
    inherited PREF_BACK_PANEL: TPanel
      Width = 558
      Height = 466
      ExplicitWidth = 558
      ExplicitHeight = 466
      inherited PADDING_PANEL: TPanel
        Width = 558
        Height = 466
        ExplicitWidth = 558
        ExplicitHeight = 466
        inherited Pref_Scroll_Box: TScrollBox
          Width = 542
          Height = 450
          ExplicitWidth = 542
          ExplicitHeight = 450
          object BASE_NAVBAR_PANEL: TPanel
            Left = 0
            Top = 0
            Width = 542
            Height = 56
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            Ctl3D = True
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
          end
          object NoteBook: TNotebook
            Left = 0
            Top = 56
            Width = 542
            Height = 394
            Align = alClient
            TabOrder = 1
            object TPage
              Left = 0
              Top = 0
              Caption = 'MAIN'
              ExplicitWidth = 0
              ExplicitHeight = 0
              object MAIN_DOCK_PANEL: TPanel
                Left = 0
                Top = 0
                Width = 542
                Height = 394
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object SettingsGroupBox: TGroupBox
                  Left = 0
                  Top = 0
                  Width = 542
                  Height = 394
                  Align = alClient
                  Caption = 'Email Settings'
                  TabOrder = 0
                  object Label1: TLabel
                    Left = 59
                    Top = 25
                    Width = 84
                    Height = 13
                    Caption = 'Email Address:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label2: TLabel
                    Left = 47
                    Top = 106
                    Width = 96
                    Height = 13
                    Caption = 'POP User Name:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label3: TLabel
                    Left = 77
                    Top = 79
                    Width = 66
                    Height = 13
                    Caption = 'SMTP Port:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label4: TLabel
                    Left = 26
                    Top = 160
                    Width = 115
                    Height = 13
                    Caption = 'Email Address From:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label5: TLabel
                    Left = 72
                    Top = 52
                    Width = 71
                    Height = 13
                    Caption = 'POP Server:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label6: TLabel
                    Left = 55
                    Top = 133
                    Width = 88
                    Height = 13
                    Caption = 'POP Password:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label8: TLabel
                    Left = 78
                    Top = 187
                    Width = 63
                    Height = 13
                    Caption = 'Auth Type:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object db_remail: TEdit
                    Left = 147
                    Top = 22
                    Width = 196
                    Height = 21
                    TabOrder = 0
                    Text = 'db_remail'
                  end
                  object db_smtpuser: TEdit
                    Left = 147
                    Top = 103
                    Width = 196
                    Height = 21
                    TabOrder = 2
                    Text = 'db_smtpuser'
                  end
                  object db_smtps: TEdit
                    Left = 147
                    Top = 49
                    Width = 196
                    Height = 21
                    TabOrder = 1
                    Text = 'db_smtps'
                  end
                  object db_smtppw: TEdit
                    Left = 147
                    Top = 130
                    Width = 196
                    Height = 21
                    PasswordChar = '*'
                    TabOrder = 3
                    Text = 'db_smtppw'
                  end
                  object db_smtpf: TEdit
                    Left = 147
                    Top = 157
                    Width = 196
                    Height = 21
                    TabOrder = 4
                    Text = 'db_smtpf'
                  end
                  object db_smtport: TMaskEdit
                    Left = 147
                    Top = 76
                    Width = 43
                    Height = 21
                    EditMask = '!99999;1;_'
                    MaxLength = 5
                    TabOrder = 5
                    Text = '     '
                  end
                  object db_smtpauthtype: TComboBox
                    Left = 147
                    Top = 184
                    Width = 196
                    Height = 22
                    BevelInner = bvLowered
                    Style = csOwnerDrawFixed
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ItemHeight = 16
                    ItemIndex = 0
                    ParentFont = False
                    TabOrder = 6
                    Text = 'Default'
                    Items.Strings = (
                      'Default'
                      'SASL'
                      'None')
                  end
                  object showPWText: TCheckBox
                    Left = 349
                    Top = 134
                    Width = 123
                    Height = 17
                    Caption = 'Show Password Text'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -9
                    Font.Name = 'Verdana'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 7
                    OnClick = showPWTextClick
                  end
                end
              end
            end
            object TPage
              Left = 0
              Top = 0
              Caption = 'ORDER'
              ExplicitWidth = 0
              ExplicitHeight = 0
              object GroupBox1: TGroupBox
                Left = 0
                Top = 0
                Width = 542
                Height = 394
                Align = alClient
                Caption = 'Order Email Body'
                TabOrder = 0
                object ORDER_DOCK_PANEL: TPanel
                  Left = 2
                  Top = 15
                  Width = 538
                  Height = 377
                  Align = alClient
                  BevelOuter = bvNone
                  Caption = 'ORDER_DOCK_PANEL'
                  TabOrder = 0
                end
              end
            end
            object TPage
              Left = 0
              Top = 0
              Caption = 'RETURN'
              ExplicitWidth = 0
              ExplicitHeight = 0
              object GroupBox2: TGroupBox
                Left = 0
                Top = 0
                Width = 542
                Height = 394
                Align = alClient
                Caption = 'Return Email Body'
                TabOrder = 0
                object RETURN_DOCK_PANEL: TPanel
                  Left = 2
                  Top = 15
                  Width = 538
                  Height = 377
                  Align = alClient
                  BevelOuter = bvNone
                  Caption = 'RETURN_DOCK_PANEL'
                  TabOrder = 0
                end
              end
            end
          end
        end
      end
    end
    inherited PREF_TOP_BACK_PANEL: TPanel
      Width = 558
      ExplicitWidth = 558
      inherited PREF_HEADER_BACK_PANEL: TPanel
        Width = 554
        ExplicitWidth = 554
        inherited PREF_HEADER_LABEL: TLabel
          Width = 204
          Caption = 'Email and POP Server Settings'
          ExplicitWidth = 204
        end
        inherited pref_image: TImage
          Picture.Data = {
            07544269746D6170A2070000424DA20700000000000036000000280000001900
            00001900000001001800000000006C0700002700000027000000000000000000
            0000FDFEFDFDFEFDFDFEFEFEFDFEFEFDFEFDFDFEFDFDFDFDFDFDFEFDFEFEFDFE
            FEFDFEFEFDFEFDFEFDFDFEFDFDFEFDFDFEFDFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFE00FAFFFAFBFEFBFDFEFEFEFCFFFEFCFFFEFCFE
            FDFDFEFCFDFDFDFCFEFDFCFFFDFBFEFDFCFEFDFEFDFCFEFCFCFEFBFDFEFCFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE00FCFFFAFCFEFB
            FDFEFEFEFDFFFEFCFFFEFDFEFFFEFDFDFEFDF9FEFEF8FEFEFAFEFEFBFEFFFDFD
            FEFFFDFEFFFDFEFEFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFE00FCFFFCFCFEFCFCFEFEFDFEFFFEFEFEFEFDFDFFFCFAFDFDF8F6FD
            FAF6FDFCF8FEFDFAFEFEFCFDFEFDFCFFFDFCFFFDFDFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE00FEFFFCFCFEFDFCFEFEFCFEFEFDFD
            FDFEFCFAFDF8F4EEE6DFF0E6E1FCF7F3FDFCF9FCFCFCFAFDFDF7FDFEF4FDFEF7
            FDFEFDFDFDFEFEFEFDFDFDFDFDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE00FEFE
            FCFEFEFDFCFEFEFBFEFEFCFDFDFEFCF8EDE5DEB09F96A88A84BCA39EE2D3CEF5
            F0ECF9FAF7F2FDFBEEFEFCF1FCFCFCFCFCFBFBFBFCFCFCFDFDFDFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFE00FEFEFEFEFEFEFAFEFEF9FEFEFBFEFBFEFBF5DED6CDD9
            C8BDECD4CDCBACA6A58A83A6938BC4BAB2EAE8DFF5FAF0F9FDF8FCFCFCFCFCFC
            FCFCFCFCFCFCFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE00FEFEFEFEFEFEFAFEFEF8
            FEFDF9FCF9FCF8F1D7C9BDECE1D3FDF3E8FCF0E6F2E4D9D7C4B8B1998CA08475
            BEA494DECEC5EDEDEDFAFAFAFBFBFBFCFCFCFCFCFCFCFCFCFCFCFCFDFDFDFEFE
            FE00FEFEFDFEFEFDFBFEFEF9FEFEF9FDFAF3F0EACEC1B6F7EDDFFAF1E6FAEEE3
            FEEEE2FEEDE0FAEADCECD7C8CEA898A28377988984C3B6B2EAE0DDFBF5F3FCFB
            F9FAFBFAF9FCFCFCFDFDFCFDFD00FEFEFCFEFEFDFDFEFEFCFDFEFAFCFCE8E7E3
            D4C9C1FAF3E9F5F5ECF7F0E7FCEEE5FCEDE4F6EAE0F4E9DEF5EADEF2E2D2E3BF
            AABD917FA67D6FBC9F93DCCFC7EFEFEAEFFAF6F8FCFCF9FBFB00FEFBFEFCFCFE
            F6FEFEF8FEFDFDFDFBE3DBD7DDD4CCF6FAEEE2FAEBEAF6E8F7F4E7FBEFE3F9EB
            E0FAEBDFFAE7DBFBE7D5FAE8D0F9E5D0EBD2C1C5A3969F7F759B857DC0B2AAE5
            DCD9FBF5F400FEF7FFF7FBFEEDFEFDF5FEFBFDF7F4E6CCC9EBE3DCF0FAEFF5F6
            EDFAF7ECF1E9DCDCD6C7EEE8D7F7F1DFF6ECDAF8EAD6F8EAD4F2E2CBF0E2CCF2
            E2CFEFDCCADCBCADBA8B7E9C807ACEBCBA00FEF6FFF8FBFEF1FDFAFBFEF5FCEF
            E7EAC7C1F7F3EDE9FEF7E5FDF1F1FCEFF6ECE0EDD2C7E4B8ACE4BCAEF2D1C0F4
            E3CFF1ECD6FAE9D4FDE3CFF9DFCBFADBC7FADDC7F2DCC4A19085CEC1BC00FCF6
            FBF9F6F6F7EEE5E4CDBED8B3A4EAC8BEFAF9F4EBFCF9FCFAF6FEF8F2F3E6DEF9
            EBE1FDEFE1F7E0D2F4CABBE9B5A7E5BBABEECEBCF1DBC5F3E7CEF4E4CAF7DEC5
            E5CBB2AFA396ECEAE300FCFAF6EFE1D9C39585AE725BA7745DE8D5C6FCFBF7F5
            FBFDF9F9F9FAF0F0EFCFCFE1B8B5E1BFB8ECD3C6F5E5D4FAEEDCF5DECCEBC8B6
            E4BAA8F4D5C2FBE3CEF6E5CDC3BCA2BBBCB0F9FBF800F5F7EADDB9A8DA8771BB
            5F42CA9375F7ECD9FCFBF8FAF6FDF1F9FCF2FAFBF1F6F5F7F6F1F3E7DFE9CCC2
            E6BEB3E1B8ABEACAB9F3DECBFAE9D4F7EBD5F6E8D4F9E3D2C4A393E3D7D2FEFD
            FC00EDEFDADFBBA3DF9278B15739E1B192FDF8E3FCF9F6F3E8EEEBEEEEF9F9F9
            FEFBFCFEF9F8FEFAF6FCFCF2F2F8EAEBEBDCE8D4C3D6C1ABE1CEBAFBEAD8FBE7
            D1F2E1CBB89E92F5EBE9FEF9FA00EBDFC6E3CFB4E1C5A8A9876BBC967EF0D8C6
            F0DCD2AA9088B8AFA1F2EDE4FAF9F6F7FAFBF7FCFDF8FEF9F5FEF4F7F8F2FCF0
            ECF2EDDBD9D0C8E0CEC9F5E7CBE8DCB6BAABA0FAF5F6FEFEFE00DFD3C1EADBC7
            FBEDD5EACFB5C59F84BD947CC29783BC8F7EAD776AD0AEA5F3EEEAEAFBFAE7FD
            FDF3FDFCFEFBF8FCFAF5FAF8F1F0E8EB9A8FB38775A4BA96A6D1A697D6BBB1FD
            FAF9FEFEFE00DEDAD1DFD8CDFEF6E6FEF4DEF8DCC0E8BB9CDFAB8CF1B799E197
            80B57867D3B0A6F7F2EFF2FAF9F8FCFBFDFCF9F1FCF5EAFAF2E8E6F58893CE60
            70BC9F8AB3C59999E4D4CBFCFDFBFEFEFE00F1F2F1D0CECAF2EFE5FDF3E2FDDD
            C2FACBAAF9BE97F6AF86F7A880E19474B7715DDEAFA5FAE8E2FDF6EDFBFEF2EB
            FDF2E9FBF2E3E0E67B98BC6C9FCDB3BACDB8A097E2EBE3F5FDFCFEFEFE00F7F9
            FBEDEEEDD5D2CDE2D8CBF2D5BEF3C4A4F9B993F8AB81FCA274F59F79D28A6EC6
            917FEAC8BBD7C4B5D4CBBADFD6CBF4E2DEF9E0D6B6BEBC9DC1BFC5C5B2C5B097
            E9F6F1F6FDFEFEFEFE00F8F9FAF8F9F9F4F5F2E4DED6DDC9BAE1B7A0F0B293F5
            A986F59E79DF9574C0967CD9CBB9FDFCF0FBF7EDF4E9DEEFD5D4F0C0C3EDBDAC
            DAC1AED0C6B2CFB694E2C5AAF8F3F5FBFAFEFEFEFE00FDFDFAFAFAF8F8F9F8FB
            FBF7FEF8F0E8CCBDDFA590E39E85DAA088E0B8A6EBDDD2F7F6F2F6FAF9FAFAFB
            FBFAF9FAF9FAF8F7F6F8F8EAF2EBE4E8D7D5E7D3BEF8F3DEF7F6F9FBFBFEFEFE
            FE00FFFEF9FDFDFAF7FAF8FAFBF9FEFBF6EAD7CDE0AC9DEDC7B5F0E7D8FDF9F0
            FEF6F8FEF4FCFEF7FEF8F9FEF1FCFEEBFDFEE4FDF6E4FFF4F3F9FCFDF3FFFDF9
            F3F4FEF0E9F9FAF7FCFEFEFEFE00}
        end
      end
    end
  end
end
