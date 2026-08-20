inherited Preference_OrgEditForm: TPreference_OrgEditForm
  Left = 335
  Top = 19
  Caption = 'Preference_OrgEditForm'
  ClientHeight = 587
  ClientWidth = 472
  ExplicitWidth = 474
  ExplicitHeight = 589
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 472
    Height = 587
    ExplicitWidth = 472
    ExplicitHeight = 577
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 470
      Height = 585
      ExplicitWidth = 470
      ExplicitHeight = 575
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 470
        ExplicitWidth = 470
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 470
        Height = 490
        Caption = ''
        ExplicitWidth = 470
        ExplicitHeight = 480
        object Label2: TLabel
          Left = 334
          Top = 28
          Width = 103
          Height = 13
          Caption = 'Sales Cycles Per Year'
        end
        object db_active: TCheckBox
          Left = 9
          Top = 5
          Width = 124
          Height = 17
          Caption = 'Organization Is Active'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object db_name: TLabeledEdit
          Left = 10
          Top = 45
          Width = 318
          Height = 21
          EditLabel.Width = 91
          EditLabel.Height = 13
          EditLabel.Caption = 'Organization Name'
          MaxLength = 50
          TabOrder = 1
        end
        object db_desc: TLabeledEdit
          Left = 10
          Top = 84
          Width = 316
          Height = 21
          EditLabel.Width = 117
          EditLabel.Height = 13
          EditLabel.Caption = 'Organization Description'
          MaxLength = 200
          TabOrder = 3
        end
        object db_acc: TLabeledEdit
          Left = 334
          Top = 84
          Width = 121
          Height = 21
          EditLabel.Width = 79
          EditLabel.Height = 13
          EditLabel.Caption = 'Account Number'
          MaxLength = 50
          TabOrder = 4
        end
        object db_iheadd: TLabeledEdit
          Left = 10
          Top = 123
          Width = 436
          Height = 21
          EditLabel.Width = 113
          EditLabel.Height = 13
          EditLabel.Caption = 'Invoice Header Caption'
          MaxLength = 50
          TabOrder = 5
        end
        object db_cycles: TComboBox
          Left = 334
          Top = 45
          Width = 121
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
          Text = '11'
          Items.Strings = (
            '1'
            '10'
            '11'
            '12'
            '13'
            '14'
            '15'
            '16'
            '17'
            '18'
            '19'
            '2'
            '20'
            '21'
            '22'
            '23'
            '24'
            '25'
            '26'
            '27'
            '28'
            '29'
            '3'
            '30'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9')
        end
        object InvMsgNoteBook: TTabbedNotebook
          Left = 1
          Top = 191
          Width = 468
          Height = 298
          Align = alBottom
          PageIndex = 2
          TabFont.Charset = DEFAULT_CHARSET
          TabFont.Color = clBtnText
          TabFont.Height = -11
          TabFont.Name = 'Tahoma'
          TabFont.Style = []
          TabOrder = 6
          ExplicitTop = 213
          object TTabPage
            Left = 4
            Top = 24
            Caption = 'Invoice Message'
            ExplicitHeight = 295
            object INVOICE_MSG_DOCK_PANEL: TPanel
              Left = 0
              Top = 0
              Width = 460
              Height = 270
              Align = alClient
              BevelOuter = bvNone
              Caption = 'INVOICE_MSG_DOCK_PANEL'
              TabOrder = 0
              ExplicitHeight = 295
            end
          end
          object TTabPage
            Left = 4
            Top = 24
            Caption = 'Invoice Cancellation  Message'
            ExplicitHeight = 295
            object INVOICE_CANCEL_MSG_DOCK_PANEL: TPanel
              Left = 0
              Top = 0
              Width = 460
              Height = 270
              Align = alClient
              Caption = 'INVOICE_CANCEL_MSG_DOCK_PANEL'
              TabOrder = 0
              ExplicitHeight = 295
            end
          end
          object TTabPage
            Left = 4
            Top = 24
            Caption = 'Org Product Defined Fields'
            ExplicitHeight = 295
            object prod_dock: TPanel
              Left = 0
              Top = 0
              Width = 460
              Height = 270
              Align = alClient
              TabOrder = 0
              ExplicitHeight = 295
              object InvoiceLineSettings: TLabel
                Left = 4
                Top = 9
                Width = 442
                Height = 40
                AutoSize = False
                Caption = 
                  'User defined Product Fields allow you to create your own Product' +
                  ' fields associated with your Organization. These fields can rece' +
                  'ive input data on Invoice Line Items and then print out on your ' +
                  'Invoice.'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Verdana'
                Font.Style = []
                ParentFont = False
                WordWrap = True
              end
              object Label5: TLabel
                Left = 5
                Top = 55
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
              object Label1: TLabel
                Left = 39
                Top = 82
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
              object Label3: TLabel
                Left = 40
                Top = 109
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
              object Label4: TLabel
                Left = 39
                Top = 136
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
              object Label6: TLabel
                Left = 39
                Top = 163
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
              object db_PRODN1: TMaskEdit
                Left = 130
                Top = 79
                Width = 255
                Height = 21
                MaxLength = 40
                TabOrder = 0
                Text = 'db_PRODN1'
              end
              object db_PRODN2: TMaskEdit
                Left = 130
                Top = 106
                Width = 255
                Height = 21
                MaxLength = 40
                TabOrder = 1
                Text = 'db_PRODN2'
              end
              object db_PRODN3: TMaskEdit
                Left = 130
                Top = 133
                Width = 255
                Height = 21
                MaxLength = 40
                TabOrder = 2
                Text = 'db_PRODN3'
              end
              object db_PRODN4: TMaskEdit
                Left = 130
                Top = 160
                Width = 255
                Height = 21
                MaxLength = 40
                TabOrder = 3
                Text = 'db_PRODN4'
              end
            end
          end
        end
        object db_CNAME: TLabeledEdit
          Left = 10
          Top = 162
          Width = 436
          Height = 21
          EditLabel.Width = 328
          EditLabel.Height = 13
          EditLabel.Caption = 
            'Invoice Printed "Sales Cycle" (Example: "Sales Cycle" or "Campai' +
            'gn")'
          MaxLength = 50
          TabOrder = 7
        end
      end
      inherited ToolBar: TToolBar
        Width = 470
        ExplicitWidth = 470
      end
      inherited StatusBar: TStatusBar
        Top = 564
        Width = 470
        ExplicitTop = 554
        ExplicitWidth = 470
      end
    end
  end
end
