inherited Pref_TaxesMasterSetDefaultForm: TPref_TaxesMasterSetDefaultForm
  Caption = 'Pref_TaxesMasterSetDefaultForm'
  ClientHeight = 299
  ClientWidth = 355
  ExplicitWidth = 357
  ExplicitHeight = 301
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 355
    Height = 299
    ExplicitWidth = 355
    ExplicitHeight = 299
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 353
      Height = 297
      ExplicitWidth = 353
      ExplicitHeight = 297
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 353
        ExplicitWidth = 353
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 20
        Width = 353
        Height = 202
        Caption = ''
        ExplicitTop = 20
        ExplicitWidth = 353
        ExplicitHeight = 202
        object default_label: TLabel
          Left = 12
          Top = 6
          Width = 326
          Height = 55
          AutoSize = False
          Caption = 
            'Sed ut perspiciatis unde omnis iste natus error sit voluptatem a' +
            'ccusantium doloremque laudantium, totam rem aperiam, eaque ipsa ' +
            'quae ab illo inventore veritatis et quasi architecto beatae vita' +
            'e dicta sunt explicabo. '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object GroupBox1: TGroupBox
          Left = 12
          Top = 60
          Width = 326
          Height = 127
          Caption = 'Default Tax Class'
          TabOrder = 0
          object db_none: TCheckBox
            Left = 21
            Top = 18
            Width = 200
            Height = 17
            Caption = 'None'
            TabOrder = 0
            OnClick = db_noneClick
          end
          object db_ship: TCheckBox
            Left = 21
            Top = 39
            Width = 200
            Height = 17
            Caption = 'Default Shipping Tax Class'
            TabOrder = 1
            OnClick = db_shipClick
          end
          object db_prod: TCheckBox
            Left = 21
            Top = 59
            Width = 200
            Height = 18
            Caption = 'Default Product Tax Class'
            TabOrder = 2
            OnClick = db_prodClick
          end
          object db_fee: TCheckBox
            Left = 21
            Top = 79
            Width = 200
            Height = 17
            Caption = 'Default Fee Tax Class'
            TabOrder = 3
            OnClick = db_feeClick
          end
          object db_ord: TCheckBox
            Left = 21
            Top = 99
            Width = 200
            Height = 17
            Caption = 'Default Order Tax Class'
            TabOrder = 4
            OnClick = db_ordClick
          end
        end
      end
      inherited ToolBar: TToolBar
        Top = 222
        Width = 353
        Align = alBottom
        ExplicitTop = 222
        ExplicitWidth = 353
      end
      inherited StatusBar: TStatusBar
        Top = 276
        Width = 353
        ExplicitTop = 276
        ExplicitWidth = 353
      end
    end
  end
end
