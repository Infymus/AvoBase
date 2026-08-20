inherited CustomerEditForm: TCustomerEditForm
  Left = 336
  Top = 4
  Caption = ''
  ClientHeight = 411
  ClientWidth = 583
  OnShow = FormShow
  ExplicitWidth = 591
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 583
    Height = 411
    ExplicitWidth = 583
    ExplicitHeight = 411
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 581
      Height = 409
      Caption = ''
      ExplicitWidth = 581
      ExplicitHeight = 409
      object Label1: TLabel [0]
        Left = 408
        Top = 39
        Width = 48
        Height = 13
        Caption = 'Birth Date'
      end
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 581
        ExplicitWidth = 581
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 575
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 581
        Height = 314
        Caption = ''
        ExplicitWidth = 581
        ExplicitHeight = 314
        object Label2: TLabel
          Left = 442
          Top = 30
          Width = 40
          Height = 13
          Caption = 'Birthday'
        end
        object db_active: TCheckBox
          Left = 9
          Top = 5
          Width = 112
          Height = 17
          Caption = 'Customer Is Active'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object db_fname: TLabeledEdit
          Left = 10
          Top = 45
          Width = 120
          Height = 21
          EditLabel.Width = 21
          EditLabel.Height = 13
          EditLabel.Caption = 'First'
          MaxLength = 30
          TabOrder = 1
        end
        object db_mname: TLabeledEdit
          Left = 136
          Top = 45
          Width = 120
          Height = 21
          EditLabel.Width = 30
          EditLabel.Height = 13
          EditLabel.Caption = 'Middle'
          MaxLength = 30
          TabOrder = 2
        end
        object db_lname: TLabeledEdit
          Left = 262
          Top = 45
          Width = 174
          Height = 21
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Last'
          MaxLength = 30
          TabOrder = 3
        end
        object db_addr1: TLabeledEdit
          Left = 10
          Top = 87
          Width = 426
          Height = 21
          EditLabel.Width = 48
          EditLabel.Height = 13
          EditLabel.Caption = 'Address 1'
          MaxLength = 100
          TabOrder = 5
        end
        object db_addr2: TLabeledEdit
          Left = 10
          Top = 126
          Width = 426
          Height = 21
          EditLabel.Width = 48
          EditLabel.Height = 13
          EditLabel.Caption = 'Address 2'
          MaxLength = 100
          TabOrder = 6
        end
        object db_city: TLabeledEdit
          Left = 10
          Top = 165
          Width = 246
          Height = 21
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'City'
          MaxLength = 50
          TabOrder = 7
        end
        object db_state: TLabeledEdit
          Left = 262
          Top = 165
          Width = 165
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'State'
          MaxLength = 50
          TabOrder = 8
        end
        object db_zip: TLabeledEdit
          Left = 433
          Top = 165
          Width = 132
          Height = 21
          EditLabel.Width = 14
          EditLabel.Height = 13
          EditLabel.Caption = 'Zip'
          MaxLength = 30
          TabOrder = 9
        end
        object db_phoneh: TLabeledEdit
          Left = 9
          Top = 206
          Width = 148
          Height = 21
          EditLabel.Width = 60
          EditLabel.Height = 13
          EditLabel.Caption = 'Home Phone'
          MaxLength = 30
          TabOrder = 10
        end
        object db_phonec: TLabeledEdit
          Left = 163
          Top = 206
          Width = 148
          Height = 21
          EditLabel.Width = 50
          EditLabel.Height = 13
          EditLabel.Caption = 'Cell Phone'
          MaxLength = 30
          TabOrder = 11
        end
        object db_phonew: TLabeledEdit
          Left = 317
          Top = 206
          Width = 148
          Height = 21
          EditLabel.Width = 58
          EditLabel.Height = 13
          EditLabel.Caption = 'Work Phone'
          MaxLength = 30
          TabOrder = 12
        end
        object db_taxexempt: TCheckBox
          Left = 196
          Top = 286
          Width = 138
          Height = 17
          Caption = 'Customer is Tax Exempt'
          TabOrder = 15
        end
        object db_email: TLabeledEdit
          Left = 10
          Top = 244
          Width = 455
          Height = 21
          EditLabel.Width = 66
          EditLabel.Height = 13
          EditLabel.Caption = 'Email Address'
          MaxLength = 60
          TabOrder = 13
        end
        object db_TAXEXID: TLabeledEdit
          Left = 10
          Top = 284
          Width = 174
          Height = 21
          EditLabel.Width = 71
          EditLabel.Height = 13
          EditLabel.Caption = 'Tax Exempt ID'
          MaxLength = 30
          TabOrder = 14
        end
        object bDayEdit: TDateTimePicker
          Left = 442
          Top = 45
          Width = 96
          Height = 19
          Date = 40904.351171550920000000
          Time = 40904.351171550920000000
          TabOrder = 4
        end
      end
      inherited ToolBar: TToolBar
        Width = 581
        ExplicitWidth = 581
      end
      inherited StatusBar: TStatusBar
        Top = 388
        Width = 581
        ExplicitTop = 388
        ExplicitWidth = 581
      end
    end
  end
end
