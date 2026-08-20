inherited Product_ViewForm: TProduct_ViewForm
  Left = 1262
  Top = 21
  Caption = 'Product_ViewForm'
  ClientHeight = 556
  ClientWidth = 597
  ExplicitWidth = 605
  ExplicitHeight = 587
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 597
    Height = 556
    ExplicitWidth = 597
    ExplicitHeight = 556
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 595
      Height = 554
      ExplicitWidth = 595
      ExplicitHeight = 554
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 595
        ExplicitWidth = 595
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 589
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 595
        Height = 459
        Caption = ''
        ExplicitWidth = 595
        ExplicitHeight = 459
        object Label5: TLabel
          Left = 6
          Top = 32
          Width = 66
          Height = 13
          Caption = 'Cycle Number'
        end
        object campYearLabel: TLabel
          Left = 82
          Top = 32
          Width = 51
          Height = 13
          Caption = 'Cycle Year'
        end
        object Label1: TLabel
          Left = 157
          Top = 32
          Width = 61
          Height = 13
          Caption = 'Organization'
        end
        object Label2: TLabel
          Left = 6
          Top = 73
          Width = 77
          Height = 13
          Caption = 'Product Number'
        end
        object amountLabel: TLabel
          Left = 186
          Top = 72
          Width = 52
          Height = 13
          Caption = 'Retail Cost'
        end
        object Label3: TLabel
          Left = 276
          Top = 72
          Width = 87
          Height = 13
          Caption = 'Quantity On Hand'
        end
        object Label6: TLabel
          Left = 96
          Top = 72
          Width = 47
          Height = 13
          Caption = 'Your Cost'
        end
        object db_isactive: TCheckBox
          Left = 6
          Top = 6
          Width = 106
          Height = 17
          Caption = 'Product Is Active'
          Enabled = False
          TabOrder = 0
        end
        object CycleNumComboBox: TComboBox
          Left = 6
          Top = 51
          Width = 68
          Height = 19
          Style = csOwnerDrawVariable
          Enabled = False
          ItemHeight = 13
          TabOrder = 1
        end
        object CycleYearComboBox: TComboBox
          Left = 82
          Top = 50
          Width = 67
          Height = 19
          Style = csOwnerDrawFixed
          Enabled = False
          ItemHeight = 13
          TabOrder = 2
        end
        object orgCombo: TComboBox
          Left = 157
          Top = 50
          Width = 206
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Enabled = False
          ItemHeight = 13
          TabOrder = 3
        end
        object db_num: TMaskEdit
          Left = 6
          Top = 89
          Width = 83
          Height = 21
          Hint = 'Enter your FIVE or SIX digit Product Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 4
        end
        object db_amount: TMaskEdit
          Tag = 4
          Left = 185
          Top = 89
          Width = 84
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          Color = 14933503
          EditMask = '#####.##;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 8
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 6
          Text = '     .  '
        end
        object db_qty: TMaskEdit
          Left = 276
          Top = 88
          Width = 49
          Height = 21
          EditMask = '!99999;1;_'
          MaxLength = 5
          ReadOnly = True
          TabOrder = 7
          Text = '     '
        end
        object db_name: TLabeledEdit
          Left = 6
          Top = 128
          Width = 445
          Height = 21
          EditLabel.Width = 67
          EditLabel.Height = 13
          EditLabel.Caption = 'Product Name'
          ReadOnly = True
          TabOrder = 8
        end
        object db_descr: TLabeledEdit
          Left = 6
          Top = 167
          Width = 445
          Height = 21
          EditLabel.Width = 121
          EditLabel.Height = 13
          EditLabel.Caption = 'Sale, Special or Comment'
          ReadOnly = True
          TabOrder = 9
        end
        object db_PRODN1: TLabeledEdit
          Left = 6
          Top = 207
          Width = 140
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'PRODN1'
          MaxLength = 40
          ReadOnly = True
          TabOrder = 10
        end
        object db_PRODN2: TLabeledEdit
          Left = 152
          Top = 207
          Width = 140
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'PRODN2'
          MaxLength = 40
          ReadOnly = True
          TabOrder = 11
        end
        object db_PRODN3: TLabeledEdit
          Left = 298
          Top = 207
          Width = 140
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'PRODN3'
          MaxLength = 40
          ReadOnly = True
          TabOrder = 12
        end
        object db_PRODN4: TLabeledEdit
          Left = 444
          Top = 207
          Width = 140
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'PRODN4'
          MaxLength = 40
          ReadOnly = True
          TabOrder = 13
        end
        object DB_DOCK_PANEL: TPanel
          Left = 1
          Top = 240
          Width = 593
          Height = 218
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'DB_DOCK_PANEL'
          TabOrder = 14
          object db_top_panel: TPanel
            Left = 0
            Top = 0
            Width = 593
            Height = 58
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label4: TLabel
              Left = 9
              Top = 9
              Width = 143
              Height = 16
              Caption = 'Product Order History'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object db_nav_panel: TPanel
              Left = 441
              Top = 0
              Width = 152
              Height = 58
              Align = alRight
              BevelOuter = bvNone
              Caption = 'db_nav_panel'
              TabOrder = 0
            end
          end
        end
        object db_ycost: TMaskEdit
          Tag = 4
          Left = 95
          Top = 89
          Width = 84
          Height = 21
          Hint = 'What Cost you are charging your Customer'
          Color = 14933503
          EditMask = '#####.##;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          MaxLength = 8
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 5
          Text = '     .  '
        end
      end
      inherited ToolBar: TToolBar
        Width = 595
        ExplicitWidth = 595
      end
      inherited StatusBar: TStatusBar
        Top = 533
        Width = 595
        ExplicitTop = 533
        ExplicitWidth = 595
      end
    end
  end
end
