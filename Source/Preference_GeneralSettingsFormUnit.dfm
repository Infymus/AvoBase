inherited Pref_GeneralSettingsForm: TPref_GeneralSettingsForm
  Caption = 'Pref_GeneralSettingsForm'
  ClientHeight = 605
  ClientWidth = 563
  OnCreate = FormCreate
  ExplicitWidth = 563
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 13
  inherited pref_full_back_panel: TPanel
    Width = 563
    Height = 605
    ExplicitWidth = 563
    ExplicitHeight = 605
    inherited PREF_BACK_PANEL: TPanel
      Width = 563
      Height = 576
      ExplicitWidth = 563
      ExplicitHeight = 576
      inherited PADDING_PANEL: TPanel
        Width = 563
        Height = 576
        ExplicitWidth = 563
        ExplicitHeight = 576
        inherited Pref_Scroll_Box: TScrollBox
          Width = 547
          Height = 560
          ExplicitWidth = 547
          ExplicitHeight = 560
          object GroupBox2: TGroupBox
            Left = 0
            Top = 75
            Width = 547
            Height = 120
            Align = alTop
            Caption = 'General Settings'
            TabOrder = 0
            object Label1: TLabel
              Left = 377
              Top = 102
              Width = 163
              Height = 12
              Caption = 'NOTE: Requires restart of AvoBase'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Verdana'
              Font.Style = [fsItalic]
              ParentFont = False
              WordWrap = True
            end
            object db_editshowbuttons: TCheckBox
              Left = 18
              Top = 21
              Width = 262
              Height = 17
              Caption = 'Show Load/Save buttons on AvoBase Edit Forms'
              TabOrder = 0
            end
            object db_cup: TCheckBox
              Left = 18
              Top = 44
              Width = 190
              Height = 17
              Caption = 'Allow AvoBase to check for updates'
              TabOrder = 1
            end
            object db_DBGRIDCOL: TCheckBox
              Left = 18
              Top = 67
              Width = 295
              Height = 17
              Caption = 'GRIDS - Color every other line in all display Database Grids'
              TabOrder = 2
            end
            object db_newordcurcycle: TCheckBox
              Left = 18
              Top = 90
              Width = 262
              Height = 17
              Caption = 'New Order Sales Cycle use CURRENT Sales Cycle'
              TabOrder = 3
            end
          end
          object GroupBox1: TGroupBox
            Left = 0
            Top = 0
            Width = 547
            Height = 75
            Align = alTop
            Caption = 'Currency'
            TabOrder = 1
            object InvoiceLineSettings: TLabel
              Left = 18
              Top = 20
              Width = 241
              Height = 13
              Caption = 'Select the Region you will be selling from:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object db_region: TComboBox
              Left = 18
              Top = 46
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
          object GroupBox3: TGroupBox
            Left = 0
            Top = 195
            Width = 547
            Height = 135
            Align = alTop
            Caption = 'Order Tab - Order List Columns'
            TabOrder = 2
            ExplicitTop = 172
            object Label2: TLabel
              Left = 18
              Top = 20
              Width = 472
              Height = 26
              AutoSize = False
              Caption = 
                'This allows you to select which columns you want to appear on th' +
                'e Order Tab - Order List display. Columns are created in order o' +
                'f options below. '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Verdana'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object Label3: TLabel
              Left = 15
              Top = 54
              Width = 49
              Height = 13
              Caption = 'Option 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 154
              Top = 54
              Width = 49
              Height = 13
              Caption = 'Option 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label5: TLabel
              Left = 293
              Top = 54
              Width = 49
              Height = 13
              Caption = 'Option 3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label6: TLabel
              Left = 15
              Top = 93
              Width = 49
              Height = 13
              Caption = 'Option 4'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label7: TLabel
              Left = 154
              Top = 93
              Width = 49
              Height = 13
              Caption = 'Option 5'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label8: TLabel
              Left = 377
              Top = 120
              Width = 163
              Height = 12
              Caption = 'NOTE: Requires restart of AvoBase'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Verdana'
              Font.Style = [fsItalic]
              ParentFont = False
              WordWrap = True
            end
            object db_olist1: TComboBox
              Left = 15
              Top = 68
              Width = 133
              Height = 19
              BevelInner = bvLowered
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 13
              ItemIndex = 2
              ParentFont = False
              TabOrder = 0
              Text = 'TOTAL INVOICE AMT'
              Items.Strings = (
                'LINE ITEM COUNT'
                'BACK ORDER COUNT'
                'TOTAL INVOICE AMT'
                'TOTAL MOP AMT'
                'TOTAL LEFT DUE')
            end
            object db_olist2: TComboBox
              Left = 154
              Top = 68
              Width = 133
              Height = 19
              BevelInner = bvLowered
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 13
              ItemIndex = 2
              ParentFont = False
              TabOrder = 1
              Text = 'TOTAL INVOICE AMT'
              Items.Strings = (
                'LINE ITEM COUNT'
                'BACK ORDER COUNT'
                'TOTAL INVOICE AMT'
                'TOTAL MOP AMT'
                'TOTAL LEFT DUE')
            end
            object db_olist3: TComboBox
              Left = 293
              Top = 68
              Width = 133
              Height = 19
              BevelInner = bvLowered
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 13
              ItemIndex = 2
              ParentFont = False
              TabOrder = 2
              Text = 'TOTAL INVOICE AMT'
              Items.Strings = (
                'LINE ITEM COUNT'
                'BACK ORDER COUNT'
                'TOTAL INVOICE AMT'
                'TOTAL MOP AMT'
                'TOTAL LEFT DUE')
            end
            object db_olist4: TComboBox
              Left = 15
              Top = 107
              Width = 133
              Height = 19
              BevelInner = bvLowered
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 13
              ItemIndex = 2
              ParentFont = False
              TabOrder = 3
              Text = 'TOTAL INVOICE AMT'
              Items.Strings = (
                'LINE ITEM COUNT'
                'BACK ORDER COUNT'
                'TOTAL INVOICE AMT'
                'TOTAL MOP AMT'
                'TOTAL LEFT DUE')
            end
            object db_olist5: TComboBox
              Left = 154
              Top = 107
              Width = 133
              Height = 19
              BevelInner = bvLowered
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 13
              ItemIndex = 2
              ParentFont = False
              TabOrder = 4
              Text = 'TOTAL INVOICE AMT'
              Items.Strings = (
                'LINE ITEM COUNT'
                'BACK ORDER COUNT'
                'TOTAL INVOICE AMT'
                'TOTAL MOP AMT'
                'TOTAL LEFT DUE')
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
          Width = 171
          Caption = 'General AvoBase Settings'
          ExplicitWidth = 171
        end
        inherited pref_image: TImage
          Picture.Data = {
            07544269746D6170A2070000424DA20700000000000036000000280000001900
            00001900000001001800000000006C070000C40E0000C40E0000000000000000
            0000FEFFFEFEFEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFEFEFEFEFEFEFEFEFEFE
            FDFEFEFBFEFEFBFEFEFEFEFEFEFEFEFEFDFDFEFEFEFDFDFDFEFEFEFEFEFEFEFE
            FEFFFFFFFEFEFEFDFDFDFEFEFE00FFFEFAFEFEFCFAFDFDF6FEFBF6FCF6FDFEFE
            FDFDFDFDFDFDFDFDFDFDFDFDFEFEFDFEFFFEFFFFFEFFFFFEFEFEFEFDFDFDFDFD
            FDFDFDFDFEFEFEFEFEFEFDFDFDFDFDFDFDFDFDFEFEFEFEFEFE00FEFBFFFDFDFD
            FDFEFAFDFDFAFDFBFBFDFCFCFDFDFDFDFDFEFEFDFDFEFDFDFBFDFDF2F4F7ECEE
            F3EEF1F5F9F9FCFEFEFEFEFEFEFEFEFEFDFDFDFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFE00FBFDFAFCFEFCFEFEFCFFFCFCFEFBFCFDFDFDFEFEFEFEFEF7FCFD
            FAFFFEFCDAE7FB6077C04F6DCC4F66BB9EA5D3FFFFFFFFFDFEFFFEFDFEFEFDFD
            FDFEFEFEFDFDFDFEFEFEFEFEFEFEFEFEFE00FAFFF9FCFDFDFDFDFCFDFDFDFCFD
            FDFEFDFDF9FBFFDEEAFFFBFDFDFFFFFCB8D5F91D42B81544DD284DDB576BB9FC
            FFFFF1FEF7EEF8FFFFFFFFFFFFFDFDFDFEFEFEFEFEFEFDFEFEFEFEFEFE00F8FB
            FEFEFEFDFEFEFEFEFDFEFEFEFDDBE9F94F76C74260BFA1BAEEBFDDFA7E9EDE1E
            49B71C50E01B4CE03052BEAFCCFBCCE7FD8CA4DB5063B1B2BCF0F6FAFEFEFEFD
            FEFEFEFEFEFEFEFEFE00F7FAFEFEFEFDFEFEFEFFFFFEE2EEFF557ECD194CC026
            54D9314ECF3150BE2A54B51E55C41352D5134EDD1C48CD2748B94F6FCA274BBD
            284EC9284BA9BAD5EFFFFFFEFEFEFEFDFDFDFEFEFE00FAFEFBFEFDFDFEFEFEFF
            FFFEDEE9FE345CB22A63DC1D55D72655DB2555D7235ED21F66D51A68DF1860DC
            1F5BD42553CF2453C71E50D61E4FDA2A53BA6D89B6FFFFFFFEFEFDFEFEFEFDFD
            FD00FBFFF8FEFDFEFEFEFEFEFEFEFDFEFE8CBAEA2259C8275BDB1963D01D66DB
            2F76EA226CDB1B65D91B68D52773DB2C70E41656BF1C56D32654D73D5BBEC8D3
            F1FFFFFEFEFEFEFEFEFEFCFCFC00FBFDEEFDFDFFFDFDFDFEFDFDFFFFFDB5DEFC
            2861CA155AE11466E22571F01D5EE11D5BDA205FD7175DD01460D51463DC357E
            EE1958CF2051C086A6E9E1F0FEFFFFFCFEFDFDFDFEFEFDFDFD00FEFDF7FEFDFE
            F4FCFDE5F1FBC0DCF871A4E31B5BC61E6BE41F6EF01C65E91B5CDB3C74E14E81
            E0467DDE2165D6105EDF1662EB2267E7235CCA4A78C9C2E2FBDAEEFAF7FBFCFE
            FEFDFDFDFD00FEFCFAFFFFFEDDEAF5648DCD3D73D1316BD0266ED41B73D91D6F
            E0206CDE2F6FD07BA9EBBBD9FF9BBEEE4480D21D6CDE0F5FF21E6AE91F62CE2B
            69C8295FB45179B6B9CDE2FDFFFFFEFEFE00FDFCFDFFFFFEC9DEF13D7FDC196C
            E6236BE5286FDC1F71DD1C6BDC2874D83370B4D0F2FFF1FEF8EAFDFF6DA1DF20
            71DC0F60E1216FE01C67D31862DA1A5EE0285BC59AB3DBFCFFFFFEFDFD00FBFB
            FCFFFFFDC7E1F63786E11678E82273E52D71E62067E91B67F11F69DF1D5AA6C4
            E5FDF9FFFFDFEFFF5C8EE11365E62368DF276FDD1D6AD61967E5125AE32A5BCD
            9EB7E2FCFFFFFEFEFD00F6FDEFFFFEFFE7F4FC88B1E44E8CD1417FCB3678E11C
            68EA1768F22575F31357BA3765AD85A3DB6B8ED82B6AD3166EF12C68EC2569E2
            2771DC266DD4215FBE5A83CBC5D6F2FBFCFEFEFDFD00FCFDEFFDFCFFFEFDFDFF
            FFFFFFFFFF9ED1F9266FC9227BF00F61DC1B6DE03182E8165DC20947AE205FCC
            2B76E61A6EE12068EF226DE9246CD3609BE0C4ECFFE1F5FFF6FCFEFCFDFDFEFE
            FE00FEFDF7FCFDFDFEFEFEFEFDFDFCFFFD9ED7F72A7DDB1A79F12470E80855C2
            156DC9237FDB247DE72476E9236DE11E64D81774EF1D73E72971D093C1ECE4F7
            FDFFFFFDFEFEFDFEFEFEFDFDFD00FBFDFDFCFCFBFEFDFEFFFEFDE8F9FF81B3E3
            2D81E0107BF31F84F21F7CE71165C90E5FC20E5BCC085CCD0D64CC1D74DD1376
            F11E79E5347BD2779CDAD2DDEFFFFFFFFEFEFDFEFEFEFDFDFD00F9FCFDFEFEFD
            FDFDFDFFFFFFD7E2EB9AC3EB579EEB2381E61280E81B7AE43886F32D76E91E6C
            E91471E71A82E71A81DD1177E2207DDF357DD09FC9FAAFBDDAFFFFFFFEFEFDFD
            FDFEFEFEFE00F9FCFEFBFDFDFDFDFDFEFEFEF6FEFEB3D1EB98CAF57BBBEE60A9
            E96CB4F24B91E82F86F11581F4127FEB2E87DB6CB4EE4B9BE3519ADD85C0F88F
            B4DBE3F4FEFCFEFEFEFEFDFDFDFDFEFEFE00F5F8FCF9FCFDFDFDFDFDFEFEFFFC
            FCF0FEFEB6CBDD9FBED9DBF1F8E6FEFF83C2EE3498E70D8EE61789DB68A5E0DA
            EEFFCCF0FDA6C7E9A5C0DFE0F5FBF1FBFCFAFDFBFDFDFDFEFEFEFEFEFE00F7FC
            FEFAFDFEFCFEFDFEFDFDFDFEFEFFFEFEFFFFFFF9FFFFFEFFFEFFFFFDBAE3F266
            AFE2369CD557AEE598BFE6F8F9FFFFFFFDFFFFFFFFFFFFF7FEFCFBFEF8FEFDFE
            FEFEFEFDFDFDFEFEFE00F7FCFEFAFDFEFDFEFDFDFDFDFDFDFDFDFDFEFEFEFDFE
            FDFDFEFDFDFDFEFDEFF7FBCADFEDB9DAEAC0DEECDEEBF7FFFEFEFDFDFDFEFEFE
            FEFEFDFEFDFDFBFCFAFDFDFDFEFEFEFEFEFEFEFEFE00F8FDFEFDFEFEFFFFFCFD
            FDFDFDFDFDFEFEFDFEFEFEFEFEFEFEFEFEFEFDFEFFFEFEFFFFFFFFFFFFFFFFFF
            FFFFFEFDFDFDFEFEFEFDFDFEFEFEFEFEFDFDFDFEFEFDFDFDFEFEFEFEFEFDFEFE
            FE00F9FEFEFDFFFDFEFEFBFEFEFDFDFEFEFBFDFEFCFDFEFDFEFDFAFEFBF9FEFD
            F8FCFDFEFDFDFDFEFEFDFDFDFDFDFDFEFEFEFDFDFEFEFEFDFEFEFCFDFDFDFEFE
            FDFEFEFBFDFDFDFEFEFEFEFEFE00}
        end
      end
    end
  end
end
