inherited Customer_ViewForm: TCustomer_ViewForm
  Left = 363
  Caption = 'Customer_ViewForm'
  ClientHeight = 574
  ClientWidth = 747
  ExplicitWidth = 749
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 747
    Height = 574
    ExplicitWidth = 747
    ExplicitHeight = 574
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 745
      Height = 572
      ExplicitWidth = 745
      ExplicitHeight = 572
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 745
        ExplicitWidth = 745
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 739
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 745
        Height = 477
        Caption = ''
        ExplicitWidth = 745
        ExplicitHeight = 477
        object activeLabel: TLabel
          Left = 9
          Top = 5
          Width = 141
          Height = 13
          Caption = 'Customer Is ActiInactive'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object taxeLabel: TLabel
          Left = 174
          Top = 5
          Width = 56
          Height = 13
          Caption = 'taxeLabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object VIEWGRID_DOCK_PANEL: TPanel
          Left = 1
          Top = 224
          Width = 743
          Height = 252
          Align = alBottom
          Caption = 'VIEWGRID_DOCK_PANEL'
          Color = clActiveCaption
          ParentBackground = False
          TabOrder = 0
        end
        object BASE_NAVBAR_PANEL: TPanel
          Left = 1
          Top = 168
          Width = 743
          Height = 56
          Align = alBottom
          BevelOuter = bvNone
          Color = clWhite
          Ctl3D = True
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 1
          object BASE_NAVBAR_DOCK_PANEL: TPanel
            Left = 591
            Top = 0
            Width = 152
            Height = 56
            Align = alRight
            BevelOuter = bvNone
            Caption = 'BASE_NAVBAR_DOCK_PANEL'
            Color = clWhite
            Ctl3D = False
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
          end
        end
        object addresGroupBox: TGroupBox
          Left = 9
          Top = 22
          Width = 382
          Height = 138
          Caption = 'Address'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentColor = False
          ParentFont = False
          TabOrder = 2
          object stateLabel: TLabel
            Left = 73
            Top = 87
            Width = 34
            Height = 13
            Caption = 'State:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object addr1Label: TLabel
            Left = 49
            Top = 17
            Width = 59
            Height = 13
            Caption = 'Address 1:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object zipLabel: TLabel
            Left = 16
            Top = 110
            Width = 92
            Height = 13
            Caption = 'Zip/Postal Code:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object addr2Label: TLabel
            Left = 49
            Top = 40
            Width = 59
            Height = 13
            Caption = 'Address 2:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cityLabel: TLabel
            Left = 82
            Top = 64
            Width = 25
            Height = 13
            Caption = 'City:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object addr1Edit: TEdit
            Left = 111
            Top = 15
            Width = 262
            Height = 21
            ReadOnly = True
            TabOrder = 0
            Text = 'addr1Edit'
          end
          object cityEdit: TEdit
            Left = 111
            Top = 61
            Width = 211
            Height = 21
            ReadOnly = True
            TabOrder = 1
            Text = 'cityEdit'
          end
          object zipEdit: TEdit
            Left = 111
            Top = 107
            Width = 121
            Height = 21
            ReadOnly = True
            TabOrder = 2
            Text = 'zipEdit'
          end
          object stateEdit: TEdit
            Left = 111
            Top = 84
            Width = 121
            Height = 21
            ReadOnly = True
            TabOrder = 3
            Text = 'stateEdit'
          end
          object addr2Edit: TEdit
            Left = 111
            Top = 38
            Width = 262
            Height = 21
            ReadOnly = True
            TabOrder = 4
            Text = 'addr2Edit'
          end
        end
        object infoGroupBox: TGroupBox
          Left = 394
          Top = 22
          Width = 339
          Height = 138
          Caption = 'Information'
          TabOrder = 3
          object phonehLabel: TLabel
            Left = 15
            Top = 17
            Width = 74
            Height = 13
            Caption = 'Home Phone:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object phonewLabel: TLabel
            Left = 17
            Top = 64
            Width = 71
            Height = 13
            Caption = 'Work Phone:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object phonecLabel: TLabel
            Left = 27
            Top = 40
            Width = 61
            Height = 13
            Caption = 'Cell Phone:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bdayLabel: TLabel
            Left = 29
            Top = 87
            Width = 60
            Height = 13
            Caption = 'Birth Date:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object emailLabel: TLabel
            Left = 56
            Top = 110
            Width = 33
            Height = 13
            Caption = 'Email:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object phonehEdit: TEdit
            Left = 92
            Top = 14
            Width = 121
            Height = 21
            ReadOnly = True
            TabOrder = 0
            Text = 'phonehEdit'
          end
          object phonecEdit: TEdit
            Left = 92
            Top = 37
            Width = 121
            Height = 21
            ReadOnly = True
            TabOrder = 1
            Text = 'phonecEdit'
          end
          object phonewEdit: TEdit
            Left = 92
            Top = 61
            Width = 121
            Height = 21
            ReadOnly = True
            TabOrder = 2
            Text = 'phonewEdit'
          end
          object bdayEdit: TEdit
            Left = 92
            Top = 84
            Width = 121
            Height = 21
            ReadOnly = True
            TabOrder = 3
            Text = 'bdayEdit'
          end
          object emailEdit: TEdit
            Left = 92
            Top = 107
            Width = 185
            Height = 21
            ReadOnly = True
            TabOrder = 4
            Text = 'emailEdit'
          end
        end
      end
      inherited ToolBar: TToolBar
        Width = 745
        ExplicitWidth = 745
      end
      inherited StatusBar: TStatusBar
        Top = 551
        Width = 745
        ExplicitTop = 551
        ExplicitWidth = 745
      end
    end
  end
end
