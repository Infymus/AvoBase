object Report_InterfaceForm: TReport_InterfaceForm
  Left = 0
  Top = 0
  Caption = 'Report_InterfaceForm'
  ClientHeight = 1314
  ClientWidth = 759
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object BASEFORM_DOCK: TPanel
    Left = 0
    Top = 0
    Width = 759
    Height = 1314
    Align = alClient
    BevelOuter = bvNone
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object BASEFORM_BACK_PANEL: TPanel
      Left = 0
      Top = 0
      Width = 759
      Height = 1314
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object BASE_DOCK_PANEL: TPanel
        Left = 0
        Top = 0
        Width = 759
        Height = 1314
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        BorderWidth = 1
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object MENU_PANEL: TPanel
          Left = 1
          Top = 21
          Width = 753
          Height = 48
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object BASE_NAVBAR_DOCK_PANEL: TPanel
            Left = 601
            Top = 0
            Width = 152
            Height = 48
            Align = alRight
            BevelOuter = bvNone
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
          end
        end
        object BAND_CustomerList: TPanel
          Left = 1
          Top = 69
          Width = 753
          Height = 146
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object CUST_BOT_SEP_PANEL: TPanel
            Left = 2
            Top = 140
            Width = 749
            Height = 4
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 0
          end
          object CustListOpt: TRadioGroup
            Left = 2
            Top = 2
            Width = 749
            Height = 138
            Align = alClient
            Caption = 'Customer List Options'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              
                'Option 1 - Name, Address, Phone, Cell Phone, Work Phone, Orders,' +
                ' Cancels, Returns'
              'Option 2 - Name, Address, Phone, Cell Phone'
              'Option 3 - Name, Phone, Cell Phone, Orders, Cancels, Returns'
              'Option 4 - Name, Phone, Orders, Cancels, Returns'
              'Option 5 - Name, Phone, Cell, Birth Day')
            ParentFont = False
            TabOrder = 1
          end
        end
        object BASE_FORM_TOP_PANEL: TPanel
          Left = 1
          Top = 1
          Width = 753
          Height = 20
          Align = alTop
          BevelOuter = bvNone
          Color = clGray
          ParentBackground = False
          TabOrder = 2
          object REPORT_CAPTION: TLabel
            Left = 6
            Top = 0
            Width = 156
            Height = 18
            Caption = 'REPORT_CAPTION'
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
          object BASE_LABEL_SEP_PANEL: TPanel
            Left = 0
            Top = 0
            Width = 6
            Height = 20
            Align = alLeft
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
          end
        end
        object BAND_SelectOrgAndCycle: TPanel
          Left = 1
          Top = 215
          Width = 753
          Height = 161
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object Panel2: TPanel
            Left = 2
            Top = 155
            Width = 749
            Height = 4
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 0
          end
          object GroupBox1: TGroupBox
            Left = 2
            Top = 2
            Width = 749
            Height = 153
            Align = alClient
            Caption = 'Sales Organization Options'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            object info_label: TLabel
              Left = 11
              Top = 18
              Width = 421
              Height = 36
              AutoSize = False
              Caption = 'FILLED_IN_BY_FORM_CREATE'
              WordWrap = True
            end
            object Label1: TLabel
              Left = 11
              Top = 130
              Width = 314
              Height = 13
              Caption = 'Note: Only Organizations and Sales Cycles created will be shown.'
            end
            object GroupBox_SalesOrgs: TGroupBox
              Left = 11
              Top = 60
              Width = 229
              Height = 64
              Caption = 'Sales Organization'
              TabOrder = 0
              object orgLabel: TLabel
                Left = 11
                Top = 16
                Width = 80
                Height = 14
                Caption = 'ORGANIZATION'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object SelectOrgCycle_Org: TComboBox
                Left = 11
                Top = 33
                Width = 208
                Height = 19
                Style = csOwnerDrawFixed
                ItemHeight = 13
                TabOrder = 0
                OnChange = SelectOrgCycle_OrgChange
              end
            end
            object GroupBox_StartSalesCycle: TGroupBox
              Left = 246
              Top = 60
              Width = 174
              Height = 64
              Caption = 'Starting Sales Cycle'
              TabOrder = 1
              OnClick = GroupBox_StartSalesCycleClick
              object campYearLabel: TLabel
                Left = 11
                Top = 16
                Width = 67
                Height = 14
                Caption = 'CYCLE YEAR'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object CycleNumLabel: TLabel
                Left = 97
                Top = 16
                Width = 63
                Height = 14
                Caption = 'CYCLE NUM'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object SelectOrgCycle_CycleStartNum: TComboBox
                Left = 97
                Top = 33
                Width = 69
                Height = 19
                Style = csOwnerDrawFixed
                ItemHeight = 13
                TabOrder = 0
              end
              object SelectOrgCycle_CycleStartYear: TComboBox
                Left = 11
                Top = 33
                Width = 70
                Height = 19
                Style = csOwnerDrawFixed
                ItemHeight = 13
                TabOrder = 1
                OnChange = SelectOrgCycle_CycleStartYearChange
              end
            end
            object GroupBox_EndSalesCycle: TGroupBox
              Left = 426
              Top = 60
              Width = 174
              Height = 64
              Caption = 'Ending Sales Cycle'
              TabOrder = 2
              object Label8: TLabel
                Left = 11
                Top = 16
                Width = 67
                Height = 14
                Caption = 'CYCLE YEAR'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label9: TLabel
                Left = 97
                Top = 16
                Width = 63
                Height = 14
                Caption = 'CYCLE NUM'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object SelectOrgCycle_CycleEndNum: TComboBox
                Left = 97
                Top = 33
                Width = 69
                Height = 19
                Style = csOwnerDrawFixed
                ItemHeight = 13
                TabOrder = 0
              end
              object SelectOrgCycle_CycleEndYear: TComboBox
                Left = 11
                Top = 33
                Width = 70
                Height = 19
                Style = csOwnerDrawFixed
                ItemHeight = 13
                TabOrder = 1
                OnChange = SelectOrgCycle_CycleEndYearChange
              end
            end
          end
        end
        object BAND_No_Options: TPanel
          Left = 1
          Top = 482
          Width = 753
          Height = 48
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 4
          object noOptionsGroupBox: TGroupBox
            Left = 2
            Top = 2
            Width = 749
            Height = 44
            Align = alClient
            Caption = 'No Report Options'
            TabOrder = 0
            object Label2: TLabel
              Left = 13
              Top = 18
              Width = 405
              Height = 14
              Caption = 
                'Note: This  report does not have any options. Press View or Prin' +
                't.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
        object CUST_SINGLE_PANEL: TPanel
          Left = 1
          Top = 376
          Width = 753
          Height = 106
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 5
          object custGroupBox: TGroupBox
            Left = 2
            Top = 2
            Width = 749
            Height = 102
            Align = alClient
            Caption = 'Customer to be Printed'
            TabOrder = 0
            object CustSoldToName: TLabel
              Tag = 1
              Left = 12
              Top = 22
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
            object CustSoldToAddress: TLabel
              Left = 14
              Top = 40
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
            object CustSoldToCityStateZip: TLabel
              Left = 14
              Top = 55
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
              Left = 14
              Top = 70
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
          end
        end
        object BAND_SelectCustomer: TPanel
          Left = 1
          Top = 530
          Width = 753
          Height = 38
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 6
          object SelectCustGroupBox: TGroupBox
            Left = 2
            Top = 2
            Width = 749
            Height = 34
            Align = alClient
            Caption = 'Select Customer'
            TabOrder = 0
            object CUST_LIST_DOCK_PANEL: TPanel
              Left = 2
              Top = 15
              Width = 745
              Height = 17
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
            end
          end
        end
        object BAND_PRODUCTRETURNLIST: TPanel
          Left = 1
          Top = 568
          Width = 753
          Height = 117
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 7
          object ProductReturnListGroupBox: TGroupBox
            Left = 2
            Top = 2
            Width = 749
            Height = 113
            Align = alClient
            Caption = 'Product Return Options'
            TabOrder = 0
            object Label3: TLabel
              Left = 18
              Top = 20
              Width = 186
              Height = 13
              Caption = 'Select the Product Return Types:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              WordWrap = True
            end
            object db_pr_restocked: TCheckBox
              Left = 39
              Top = 87
              Width = 369
              Height = 17
              Caption = 'Restocked - Product has been added/returned to Product Inventory'
              TabOrder = 0
            end
            object db_pr_returned: TCheckBox
              Left = 39
              Top = 64
              Width = 369
              Height = 17
              Caption = 'Returned to OEM - Product has been returned to OEM'
              TabOrder = 1
            end
            object db_pr_pend: TCheckBox
              Left = 39
              Top = 41
              Width = 369
              Height = 17
              Caption = 'Pending - Product is waiting to be processed'
              Checked = True
              State = cbChecked
              TabOrder = 2
            end
          end
        end
        object BAND_PRODUCTLIST_OPTIONS: TPanel
          Left = 1
          Top = 685
          Width = 753
          Height = 120
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 8
          object sortProdListGroup: TRadioGroup
            Left = 2
            Top = 2
            Width = 749
            Height = 116
            Align = alClient
            Caption = 'Sort Product List Report By'
            ItemIndex = 1
            Items.Strings = (
              'Cycle'
              'Number'
              'Name'
              'QTY On Hand'
              'Amount')
            TabOrder = 0
            WordWrap = True
          end
        end
        object BAND_ODRER_LABELS: TPanel
          Left = 1
          Top = 805
          Width = 753
          Height = 234
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          Color = clWhite
          TabOrder = 9
          object GroupBox2: TGroupBox
            Left = 2
            Top = 2
            Width = 749
            Height = 230
            Align = alClient
            Caption = 'Order Label Options'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object Label7: TLabel
              Left = 17
              Top = 49
              Width = 103
              Height = 14
              Caption = 'Printer Label Type:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 59
              Top = 74
              Width = 61
              Height = 14
              Caption = 'Skip Rows:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label5: TLabel
              Left = 45
              Top = 101
              Width = 75
              Height = 14
              Caption = 'Label Row #1:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label6: TLabel
              Left = 45
              Top = 127
              Width = 75
              Height = 14
              Caption = 'Label Row #2:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label10: TLabel
              Left = 45
              Top = 154
              Width = 75
              Height = 14
              Caption = 'Label Row #3:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label11: TLabel
              Left = 45
              Top = 179
              Width = 75
              Height = 14
              Caption = 'Label Row #4:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label12: TLabel
              Left = 45
              Top = 204
              Width = 75
              Height = 14
              Caption = 'Label Row #5:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label13: TLabel
              Left = 36
              Top = 22
              Width = 85
              Height = 14
              Caption = 'Labels To Print:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object printLabelTypeCombo: TComboBox
              Left = 123
              Top = 46
              Width = 151
              Height = 19
              Style = csOwnerDrawFixed
              ItemHeight = 13
              ItemIndex = 0
              TabOrder = 0
              Text = '5160 (1" x 2.63")'
              Items.Strings = (
                '5160 (1" x 2.63")'
                '5161 (1" x 4")'
                '18160 (1" x 2/58")')
            end
            object SkipRows: TComboBox
              Left = 123
              Top = 71
              Width = 58
              Height = 19
              Style = csOwnerDrawFixed
              ItemHeight = 13
              ItemIndex = 0
              TabOrder = 1
              Text = '0'
              Items.Strings = (
                '0'
                '1'
                '2'
                '3'
                '4'
                '5'
                '6'
                '7'
                '8'
                '9')
            end
            object db_inv1: TComboBox
              Left = 123
              Top = 98
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
              OnChange = db_inv5Change
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
              Left = 123
              Top = 124
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
              OnChange = db_inv5Change
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
              Left = 123
              Top = 151
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
              OnChange = db_inv5Change
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
              Left = 123
              Top = 176
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
              OnChange = db_inv5Change
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
              Left = 123
              Top = 201
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
              OnChange = db_inv5Change
              Items.Strings = (
                'BLANK'
                'REPRESENTATIVE NAME'
                'ADDRESS LINE 1'
                'ADDRESS LINE 2'
                'EMAIL ADDRESS'
                'CITY, STATE/PROVICE, ZIP/POSTAL CODE'
                'PHONE')
            end
            object db_sonum: TEdit
              Left = 123
              Top = 19
              Width = 52
              Height = 21
              MaxLength = 5
              TabOrder = 7
              Text = '1'
              OnKeyPress = db_sonumKeyPress
            end
            object GroupBox3: TGroupBox
              Left = 418
              Top = 45
              Width = 258
              Height = 142
              Caption = 'Preview'
              TabOrder = 8
              object label_prev1: TLabel
                Left = 18
                Top = 23
                Width = 55
                Height = 13
                Caption = 'label_prev1'
              end
              object label_prev2: TLabel
                Left = 30
                Top = 42
                Width = 55
                Height = 13
                Caption = 'label_prev2'
              end
              object label_prev3: TLabel
                Left = 33
                Top = 60
                Width = 55
                Height = 13
                Caption = 'label_prev3'
              end
              object label_prev4: TLabel
                Left = 33
                Top = 81
                Width = 55
                Height = 13
                Caption = 'label_prev4'
              end
              object label_prev5: TLabel
                Left = 33
                Top = 102
                Width = 55
                Height = 13
                Caption = 'label_prev5'
              end
            end
          end
        end
        object BAND_UNREG: TPanel
          Left = 1
          Top = 1129
          Width = 753
          Height = 183
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 10
          object UnRegGroupBox: TGroupBox
            Left = 2
            Top = 2
            Width = 749
            Height = 179
            Align = alClient
            TabOrder = 0
            object UnRegLabel: TLabel
              Left = 75
              Top = 24
              Width = 405
              Height = 14
              Caption = 
                'Note: This  report does not have any options. Press View or Prin' +
                't.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object RegisterButton: TSpeedButton
              Left = 11
              Top = 19
              Width = 51
              Height = 50
              Caption = 'Register'
              Flat = True
              Glyph.Data = {
                FE0A0000424DFE0A00000000000036000000280000001E0000001E0000000100
                180000000000C80A0000130B0000130B00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFFFFFFFFFF
                FFFFFFFFFFFFFFFEFDFDF2F1F1FFFEFDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4FFFEFFFFFFFFFFFFFFFFFFFFFFFF
                ECEDF495A8B67B92A29EA2BAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFFFFFFFEFEFEFFFFFFA2ACB693
                AFBB8FB2C0869EAF949CB5DBDBE1FFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDA9BAC097B5BDB0D8E271A1
                AD82B4C175A9B97F909AC5D0D6F8FBFCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFA1BFC382B1B3B2E2E7B6E4ED84B6C25C9BA6
                5DABB486ACBB7294A293ABB6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFEFEFEFFFFFFB7C5CB7FB2B3A7E5E6B6E9EFBADDE8D1F4F889BDCA58A0A968
                9FB376A7B983A6B78499A7DFE4EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                D8CFDB8EA9AFA0D9DBADEBEFB3DFE7DBF0FEE5F3FFD9F7FF94C5D35998AD669F
                B56694A97C9CAF798C9CC4CBD5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEE6EAED94A8B0AC
                D3DABAECF2ADDDE5D1F0FDE6F6FFDFE8FAD5E7F9D2EDFC91CDE566A0B74C8198
                6897AD779DB06D8998A0B1BAF2F5F7FEFEFEFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECECEC9DACAEA5D5DCBDE7EFB3D4
                DFD1ECFADAF3FEDCF6FFD2EDFDC9E6F5C2DFEEAEE0F89CD2E96CA6BC4D8BA35E
                9AAF6A9EAF6A919D8DA1AAE6E9EDFEFEFEFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFCDCDCDADC4C5A1E2E8B3DAE4D9E8F8EAF5FF
                DEF6FFC3F1FBB0E8F3AEE4EFAFDDEAA9D1E8A1D0E795D1E86CB4CB3D8B9F468C
                9F679DAD6F8F9A9EABB3F5F5F8FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFCDCDCDD5EEF09EE7EEC3E6F3E8ECFCF3F4FFD2EDFBB4
                F0F8A4EFF79BE2EB9EDAE4B0D1E99BC6DD8BC8DF71BFD663BACE4698AA488696
                7094A2798792DCDEE8FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FEFEFEFFFFFFABABABDAE1E6C7E1EFD4F2FED5F9FFCBF3FBC4EEF6BCE8F1B7E0
                EEAFD9EBA7CFE59FD0D993C8D484C0D377BAD66AB3D363AACC4D8FAE508AA552
                8499A3D1E3FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFB6
                B6B6888888CBD0D4E5F1FAFFFFFFE5F7FED6F4FCD0F1F9C6E9F4BCE2F1B5DBEE
                ACD1E899CCD98CC3D47BBCD16AB5CF60AECB61ADCA61A1BC5C8EA45F8596D0E7
                F2FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5C5C5858585C6C6
                C6D2D2D2FFFFFFFEFEFEFFFFFFE4F3F8D2EAF4CAE7F3BFDFF3B5D8F0ACCFEA92
                CADD85C1D673B9D060B2CB58ACC753A1B95A96AA678E9EB1C6D4FFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFEFEFED7D7D78F8F8FC8C8C8C5C5C5E4E5E5
                E6E8EBFFFFFFEEF3F3FFFFFFD4E9F1C6E3EFB9DCEEADD4EDA2CBE78AC6DF7CBF
                D669B5CE59ADC752A7BD549EB0518795ABC7D2FCFDFEFEFEFEFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFEDEDED9A9A9AB8B8B8B8B8B8EAEAEAD6D6D6FFFFFFFF
                FFFFE3ECEAD5E6E8CEE6EBC0E1EBAFD8EAA1D1E894C8E183C3DF71B7D368B4CD
                56A7BD54A2B44B8C998BB7BEFAFEFFFEFEFEFFFFFFFFFFFF0000FFFFFFFFFFFF
                FEFEFEEDEDED9E9E9EC4C4C4BABABAFBFBFBEAEAEAFFFFFFFFFFFFFFFFFFFFFF
                FFE4F2F1C4DDE0BADCE3AEDAE89AD1E38DC9DD7ABEDC74BAD761A8C25DA2B655
                93A382B1BCD9F6FBFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFF4F4F4A2
                A2A2BFBFBFB4B4B4EAEAEACECECEFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
                F8FBFBC0DDE3A4CBD499CBD98AC1D273B9D668ACC66CA9C055899B79A1B0E4F6
                FEFFFFFFFEFEFEFFFFFFFFFFFFFFFFFF0000FFFFFFFEFEFEBDBDBDC0C0C0C6C6
                C6E6E6E6CACACAFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9
                FCFDD2E5EAA3C8D292BDC86CB7D068A9C16798AE7898AAEFF3F8FFFFFEFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFEFEFEAFAFAFF1F1F1C3C3C3C2C2C2
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
                FFD7E8EEA7C4CC60ABC1619FB46D97ACCDDFF0FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFE5E5E5E9E9E9CDCDCDDFDFDFEAEAEAFEFEFEFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCDC9CAA2A1A2CACBCBFFFFFF
                F0F7FAD2E9EFCDDFE5E2EEF4FFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFCBCBCBF7F7F7BCBCBCB1B1B1FAFAFAFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFECECEC9E9E9E9D9D9DA2A2A2F2F2F2FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFC1C1C1FFFFFFAFAFAF9C9C9CF3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFEFEFEE7E7E78E8E8EA3A3A3B2B2B2B3B3B3F4F4F4FFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFF0F0F0FCFCFCB0B0B0BDBDBDC6C6C6FFFFFFFFFFFFFFFFFFFEFEFEFFFFFFE9
                E9E9939393B6B6B6BCBCBCB8B8B8F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFEFEFE
                F3F3F3BCBCBCDADADAA5A5A5BFBFBFF3F3F3F6F6F6F7F7F7CBCBCB959595B1B1
                B1DFDFDFBABABAEEEEEEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFE6E6E6F4
                F4F4B1B1B1D3D3D3A3A3A38888888D8D8D838383898989C3C3C3C3C3C3BCBCBC
                F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFCDCD
                CDAEAEAED0D0D0D3D3D3CCCCCCC9C9C9DDDDDDD8D8D8BDBDBDEEEEEEFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFEFEFEFFFFFFDFDFDF
                BDBDBDCBCBCBD8D8D8D4D4D4CACACAC3C3C3ECECECFEFEFEFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF6F6F6C3
                C3C3B8B8B8CECECEFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000}
              Layout = blGlyphTop
              OnClick = RegisterButtonClick
            end
            object UnRegWeb: TLabel
              Left = 75
              Top = 50
              Width = 542
              Height = 110
              AutoSize = False
              Caption = 
                'We appreciate that you have taken the time to download, install ' +
                'and use AvoBase.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
          end
        end
        object BAND_ORDER_TYPE_OPTIONS: TPanel
          Left = 1
          Top = 1039
          Width = 753
          Height = 90
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 11
          object GroupBox4: TGroupBox
            Left = 2
            Top = 2
            Width = 749
            Height = 86
            Align = alClient
            Caption = 'Order Options'
            TabOrder = 0
            object db_orderoptions_open: TCheckBox
              Left = 17
              Top = 21
              Width = 97
              Height = 17
              Caption = 'Open Orders'
              TabOrder = 0
            end
            object db_orderoptions_closed: TCheckBox
              Left = 17
              Top = 39
              Width = 97
              Height = 17
              Caption = 'Closed Orders'
              TabOrder = 1
            end
            object db_orderoptions_cancelled: TCheckBox
              Left = 17
              Top = 57
              Width = 97
              Height = 17
              Caption = 'Cancelled Orders'
              TabOrder = 2
            end
          end
        end
      end
    end
  end
  object fSave: TSaveDialog
    Filter = 'PDF|pdf'
    Left = 681
    Top = 24
  end
end
