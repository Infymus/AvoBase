inherited Pref_InvoiceSettingsForm: TPref_InvoiceSettingsForm
  Caption = 'Pref_InvoiceSettingsForm'
  ClientHeight = 706
  ClientWidth = 551
  OnCreate = FormCreate
  ExplicitWidth = 551
  ExplicitHeight = 706
  PixelsPerInch = 96
  TextHeight = 13
  inherited pref_full_back_panel: TPanel
    Width = 551
    Height = 706
    ExplicitWidth = 551
    ExplicitHeight = 642
    inherited PREF_BACK_PANEL: TPanel
      Width = 551
      Height = 677
      ExplicitWidth = 551
      ExplicitHeight = 613
      inherited PADDING_PANEL: TPanel
        Width = 551
        Height = 677
        ExplicitWidth = 551
        ExplicitHeight = 613
        inherited Pref_Scroll_Box: TScrollBox
          Width = 535
          Height = 661
          ExplicitWidth = 535
          ExplicitHeight = 661
          object GroupBox1: TGroupBox
            Left = 0
            Top = 0
            Width = 535
            Height = 252
            Align = alTop
            Caption = 'Invoice  Representative Options'
            TabOrder = 0
            object Label2: TLabel
              Left = 86
              Top = 93
              Width = 98
              Height = 13
              Caption = 'Invoice Line # 1:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label3: TLabel
              Left = 86
              Top = 121
              Width = 98
              Height = 13
              Caption = 'Invoice Line # 2:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label8: TLabel
              Left = 86
              Top = 146
              Width = 98
              Height = 13
              Caption = 'Invoice Line # 3:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label6: TLabel
              Left = 86
              Top = 171
              Width = 98
              Height = 13
              Caption = 'Invoice Line # 4:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label7: TLabel
              Left = 86
              Top = 195
              Width = 98
              Height = 13
              Caption = 'Invoice Line # 5:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label1: TLabel
              Left = 38
              Top = 65
              Width = 145
              Height = 13
              Caption = 'Invoice Top Bolded Text:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 86
              Top = 221
              Width = 98
              Height = 13
              Caption = 'Invoice Line # 6:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object InvoiceLineSettings: TLabel
              Left = 38
              Top = 24
              Width = 442
              Height = 28
              AutoSize = False
              Caption = 
                'Invoice Lines are printed at the bottom of your Invoice. You can' +
                ' determine what is printed by selecting items below.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object db_inv1: TComboBox
              Left = 187
              Top = 90
              Width = 253
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
              TabOrder = 1
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
            object db_inv2: TComboBox
              Left = 187
              Top = 116
              Width = 253
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
              TabOrder = 2
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
            object db_inv3: TComboBox
              Left = 187
              Top = 143
              Width = 253
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
              TabOrder = 3
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
            object db_inv4: TComboBox
              Left = 187
              Top = 168
              Width = 253
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
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
            object db_inv5: TComboBox
              Left = 187
              Top = 193
              Width = 253
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
              TabOrder = 5
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
            object db_inv6: TComboBox
              Left = 187
              Top = 218
              Width = 253
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
              TabOrder = 6
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
            object db_invtop: TMaskEdit
              Left = 189
              Top = 63
              Width = 313
              Height = 21
              MaxLength = 32
              TabOrder = 0
              Text = 'db_invtop'
            end
          end
          object GroupBox3: TGroupBox
            Left = 0
            Top = 364
            Width = 535
            Height = 140
            Align = alTop
            Caption = 'General Invoice Options'
            TabOrder = 2
            object Label5: TLabel
              Left = 18
              Top = 24
              Width = 108
              Height = 13
              Caption = 'Starting Order Number:'
            end
            object Label11: TLabel
              Left = 7
              Top = 96
              Width = 134
              Height = 13
              Caption = 'Line Item Display Type:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object db_ORGONINVLAB: TCheckBox
              Left = 18
              Top = 50
              Width = 260
              Height = 17
              Caption = 'Show Organization Name next to Invoice Number'
              TabOrder = 0
            end
            object db_sonum: TEdit
              Left = 132
              Top = 21
              Width = 52
              Height = 21
              MaxLength = 5
              TabOrder = 1
              OnKeyPress = db_sonumKeyPress
            end
            object db_INVSHOW_DISC: TCheckBox
              Left = 18
              Top = 71
              Width = 343
              Height = 17
              Caption = 
                'Show Discounts on Printed Invoices (can be overridden on Invoice' +
                ')'
              TabOrder = 2
            end
            object db_lineitemtype: TComboBox
              Left = 7
              Top = 113
              Width = 294
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
              TabOrder = 3
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
          end
          object GroupBox2: TGroupBox
            Left = 0
            Top = 252
            Width = 535
            Height = 112
            Align = alTop
            Caption = 'Line Item Product Lookup'
            TabOrder = 1
            object Label9: TLabel
              Left = 7
              Top = 68
              Width = 151
              Height = 13
              Caption = 'Line Item Product Lookup:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label10: TLabel
              Left = 13
              Top = 22
              Width = 469
              Height = 41
              AutoSize = False
              Caption = 
                'When entering Product Numbers into Invoice Line Items - you can ' +
                'tell AvoBase to match and use existing Products from your Produc' +
                't database. You can determine here how you want AvoBase to find ' +
                'Products.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object db_CPRODTYPE: TComboBox
              Left = 7
              Top = 84
              Width = 253
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
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
          end
          object db_INVCPH: TRadioGroup
            Left = 0
            Top = 504
            Width = 535
            Height = 105
            Align = alTop
            Caption = 'Customer Invoice Phone Number Display (Appears on Invoice)'
            ItemIndex = 0
            Items.Strings = (
              'None'
              'Home Phone'
              'Cell Phone'
              'Work Phone'
              'All Phones')
            TabOrder = 3
            WordWrap = True
            ExplicitTop = 457
          end
        end
      end
    end
    inherited PREF_TOP_BACK_PANEL: TPanel
      Width = 551
      ExplicitWidth = 551
      inherited PREF_HEADER_BACK_PANEL: TPanel
        Width = 547
        ExplicitWidth = 547
        inherited PREF_HEADER_LABEL: TLabel
          Width = 178
          Caption = 'Invoice and Order Settings'
          ExplicitWidth = 178
        end
        inherited pref_image: TImage
          Picture.Data = {
            07544269746D6170FE0A0000424DFE0A00000000000036000000280000001E00
            00001E0000000100180000000000C80A00002700000027000000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFCFCFCFBFBFBFCFCFCFDFDFD
            FDFDFDFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDE8E8E8D9D9D9DBDBDBE2E2E2E9E9E9EF
            EFEFF0F0F0F3F3F3F7F7F7FBFBFBF9F9F9FCFCFCFEFEFEFEFEFEFEFEFEFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFF6F6F6D7D7D7DBDBDBD8D8D8D6D6D6D3D3D3D3D3D3D0D0
            D0D4D4D4D5D5D5DADADADCDCDCE2E2E2E0E0E0E8E8E8EFEFEFF6F6F6F3F3F3FA
            FAFAFCFCFCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFF5F5F5D5D5D5DADADAD8D8D8DEDEDEDEDEDED7D7D7DDDDDDDFDFDF
            DFDFDFDDDDDDDBDBDBDCDCDCD4D4D4D4D4D4CFCFCFCDCDCDD2D2D2D1D1D1E0E0
            E0F9F9F9FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFF3F3F3D9D9D9D2D2D2D4D4D4D9D9D9D5D5D5B8B8B8D5D5D5DCDCDCDADADAC7
            C7C7D6D6D6DFDFDFDEDEDEDADADADFDFDFDADADADFDFDFDCDCDCDBDBDBF3F3F3
            FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEEEEEE
            D8D8D8C8C8C8D1D1D1D6D6D6D5D5D5B3B3B3DADADADEDEDED4D4D4B5B5B5CDCD
            CDD5D5D5D9D9D9BABABACECECEDADADAE0E0E0D8D8D8DDDDDDF5F5F5FFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEBEBEBD7D7D7CA
            CACAD3D3D3D5D5D5CBCBCBB5B5B5D3D3D3D8D8D8D1D1D1B1B1B1CECECED5D5D5
            D2D2D2B4B4B4CDCDCDD6D6D6D5D5D5D0D0D0DFDFDFF7F7F7FFFFFFFFFFFFFFFF
            FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFDFDFDE5E5E5D6D6D6C7C7C7D1D1
            D1D3D3D3C7C7C7B9B9B9D6D6D6D8D8D8CDCDCDB5B5B5D3D3D3D6D6D6CECECEB4
            B4B4CDCDCDD3D3D3D0D0D0D1D1D1E3E3E3F9F9F9FFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFDFDFDE1E1E1D4D4D4CECECED8D8D8D6D6D6
            C5C5C5B8B8B8CECECED1D1D1CBCBCBBABABAD4D4D4D9D9D9D2D2D2B3B3B3D0D0
            D0D1D1D1CACACAD1D1D1E5E5E5FCFCFCFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
            FFFFFFFFFFFFFFFFFFFFFCFCFCDDDDDDD7D7D7CACACAD4D4D4D4D4D4BFBFBFBE
            BEBED6D6D6D1D1D1C4C4C4BABABAD1D1D1D4D4D4CACACAB2B2B2D0D0D0D2D2D2
            D1D1D1D4D4D4E5E5E5FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFCFCFCD8D8D8D5D5D5CBCBCBD3D3D3D4D4D4BCBCBCC5C5C5D7D7
            D7D3D3D3C5C5C5BDBDBDD0D0D0D5D5D5C7C7C7B8B8B8D6D6D6D5D5D5CCCCCCD6
            D6D6E7E7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
            FFFFFAFAFAD5D5D5D2D2D2CDCDCDD2D2D2D0D0D0B6B6B6CDCDCDD6D6D6DADADA
            BABABAC5C5C5D2D2D2D2D2D2BFBFBFBABABAD4D4D4D8D8D8CECECEDEDEDEECEC
            ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFF5F5
            F5D4D4D4D1D1D1CCCCCCD5D5D5CFCFCFB3B3B3CCCCCCD6D6D6D4D4D4B8B8B8CB
            CBCBD6D6D6D4D4D4C0C0C0C0C0C0D6D6D6D6D6D6C9C9C9DCDCDCF0F0F0FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFF2F2F2D7D7D7
            CFCFCFCDCDCDD3D3D3CDCDCDB5B5B5CCCCCCD4D4D4D3D3D3B8B8B8CACACAD7D7
            D7D6D6D6B9B9B9C6C6C6D6D6D6D1D1D1CACACAE0E0E0F5F5F5FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFEFEFEFD8D8D8CECECED5
            D5D5D9D9D9CDCDCDB6B6B6CECECED4D4D4CCCCCCB1B1B1CCCCCCD7D7D7D4D4D4
            B8B8B8CDCDCDD4D4D4D4D4D4C8C8C8DDDDDDF8F8F8FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFEAEAEAD7D7D7C8C8C8CFCFCFD6D6
            D6C8C8C8B7B7B7D2D2D2D6D6D6CACACAB2B2B2D0D0D0D6D6D6D4D4D4B3B3B3CC
            CCCCD5D5D5D5D5D5CECECEE1E1E1F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFE5E5E5D5D5D5CACACAD6D6D6D7D7D7C3C3C3
            B9B9B9D6D6D6D7D7D7CBCBCBB6B6B6D2D2D2D6D6D6D3D3D3B2B2B2D0D0D0D5D5
            D5D0D0D0D1D1D1E5E5E5FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
            FFFFFFFFFFFFFFFEFEFEE0E0E0D6D6D6CCCCCCD6D6D6D5D5D5C0C0C0BDBDBDD7
            D7D7DADADACDCDCDB9B9B9D9D9D9D7D7D7CBCBCBB4B4B4D0D0D0D2D2D2D1D1D1
            D4D4D4E6E6E6FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFCFCFCDADADAD5D5D5CFCFCFDADADAD7D7D7BEBEBEC2C2C2D9D9D9D9D9
            D9C8C8C8BBBBBBD7D7D7DADADACDCDCDB6B6B6D5D5D5D8D8D8CECECED7D7D7E9
            E9E9FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFB
            FBFBD5D5D5D4D4D4CFCFCFDADADAD8D8D8BFBFBFC5C5C5D8D8D8D9D9D9C6C6C6
            BDBDBDDBDBDBDBDBDBC9C9C9B9B9B9DADADAD9D9D9D0D0D0D9D9D9EBEBEBFEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFAFAFAD4D4
            D4D4D4D4CCCCCCD9D9D9D3D3D3BBBBBBCCCCCCDCDCDCDADADABDBDBDC2C2C2D7
            D7D7D6D6D6C5C5C5C0C0C0DCDCDCDCDCDCD0D0D0DDDDDDECECECFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF6F6F6D1D1D1D0D0D0
            D1D1D1DADADAD3D3D3B7B7B7CFCFCFDADADAD4D4D4B8B8B8C9C9C9D7D7D7D4D4
            D4C2C2C2C2C2C2D8D8D8D6D6D6CDCDCDDDDDDDF0F0F0FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF3F3F3D2D2D2CDCDCDD1D1D1D5
            D5D5D0D0D0B4B4B4D1D1D1D9D9D9D4D4D4B5B5B5CECECED8D8D8D4D4D4BDBDBD
            C9C9C9D8D8D8D2D2D2CDCDCDDEDEDEF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF0000FFFFFFFFFFFFFFFFFFEFEFEFD6D6D6CECECED4D4D4D6D6D6CCCC
            CCB3B3B3CECECECFCFCFCFCFCFB3B3B3D0D0D0DADADAD7D7D7B5B5B5C9C9C9D4
            D4D4D1D1D1CDCDCDE0E0E0FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFEEEEEEDADADACDCDCDD2D2D2D5D5D5C6C6C6B8B8B8
            D3D3D3D0D0D0CCCCCCB4B4B4CFCFCFD3D3D3D0D0D0B1B1B1D0D0D0D6D6D6D3D3
            D3CECECEDEDEDEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
            FFFFFFFFFFFFFFF0F0F0DDDDDDDDDDDDD8D8D8DCDCDCD3D3D3CBCBCBDBDBDBD9
            D9D9CBCBCBB7B7B7D0D0D0CECECECACACAB1B1B1CDCDCDD5D5D5D1D1D1D0D0D0
            E2E2E2FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFF7F7F7E5E5E5E4E4E4E6E6E6DEDEDEDCDCDCE0E0E0DCDCDCDDDDDDDBDB
            DBDFDFDFE0E0E0DADADAD5D5D5C9C9C9D6D6D6DADADAD8D8D8D4D4D4E0E0E0FE
            FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFEFEFEFDFDFDFBFBFBF9F9F9F3F3F3ECECECEEEEEEECECECE8E8E8
            E3E3E3E3E3E3E1E1E1E2E2E2E1E1E1DBDBDBDBDBDBE1E1E1E6E6E6FEFEFEFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFBFBFBFAFAFAFA
            FAFAF8F8F8F7F7F7F1F1F1EEEEEEE9E9E9E7E7E7F0F0F0FEFEFEFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000}
        end
      end
    end
  end
end
