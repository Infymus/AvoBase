inherited Pref_Taxes_SetDefaultRoundingForm: TPref_Taxes_SetDefaultRoundingForm
  Caption = 'Pref_Taxes_SetDefaultRoundingForm'
  ClientHeight = 361
  ClientWidth = 491
  ExplicitWidth = 499
  ExplicitHeight = 392
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 491
    Height = 361
    ExplicitWidth = 491
    ExplicitHeight = 361
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 489
      Height = 359
      ExplicitWidth = 489
      ExplicitHeight = 359
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 489
        ExplicitWidth = 489
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 483
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 56
        Width = 489
        Height = 282
        Caption = ''
        ExplicitTop = 56
        ExplicitWidth = 489
        ExplicitHeight = 282
        object InvoiceLineSettings: TLabel
          Left = 29
          Top = 169
          Width = 442
          Height = 40
          AutoSize = False
          Caption = 
            'Round Nearest - the closest whole number is returned without reg' +
            'ard it for being less than or greater than the value passed to R' +
            'ound().'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label1: TLabel
          Left = 29
          Top = 111
          Width = 442
          Height = 40
          AutoSize = False
          Caption = 
            'Round Down - produces the nearest whole number that is less than' +
            ' or equal to value passed as parameter, for 5.7, the return valu' +
            'e is 5.00 and for -1.3, this value is -2.00.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label2: TLabel
          Left = 29
          Top = 66
          Width = 442
          Height = 28
          AutoSize = False
          Caption = 
            'Round Up - the nearest whole number that is greater than equal t' +
            'o the parameter is returned, namely 6.00 and -1.00 respectively.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label3: TLabel
          Left = 29
          Top = 215
          Width = 442
          Height = 40
          AutoSize = False
          Caption = 
            'Round Truncate - simply return the value of the parameter passed' +
            ' with the fractional portion removed.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label4: TLabel
          Left = 6
          Top = 12
          Width = 179
          Height = 13
          Caption = 'Default Tax Rounding Type:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label5: TLabel
          Left = 6
          Top = 42
          Width = 107
          Height = 13
          Caption = 'Rounding Types:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          WordWrap = True
        end
        object db_rounding: TComboBox
          Left = 190
          Top = 10
          Width = 141
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Round Up'
          Items.Strings = (
            'Round Up'
            'Round Down'
            'Round Nearest'
            'Round Truncate')
        end
      end
      inherited ToolBar: TToolBar
        Width = 489
        Height = 36
        ButtonHeight = 36
        ExplicitWidth = 489
        ExplicitHeight = 36
      end
      inherited StatusBar: TStatusBar
        Top = 338
        Width = 489
        ExplicitTop = 338
        ExplicitWidth = 489
      end
    end
  end
end
