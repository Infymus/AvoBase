inherited OrgSelectOrgAndCycleForm: TOrgSelectOrgAndCycleForm
  Caption = 'OrgSelectOrgAndCycleForm'
  ClientHeight = 207
  ClientWidth = 384
  OnShow = FormShow
  ExplicitWidth = 386
  ExplicitHeight = 209
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 384
    Height = 207
    ExplicitWidth = 384
    ExplicitHeight = 207
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 382
      Height = 205
      ExplicitWidth = 382
      ExplicitHeight = 205
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 382
        ExplicitWidth = 382
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 20
        Width = 382
        Height = 110
        Caption = ''
        ExplicitTop = 20
        ExplicitWidth = 382
        ExplicitHeight = 110
        object CycleNumLabel: TLabel
          Left = 304
          Top = 39
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
        object campYearLabel: TLabel
          Left = 224
          Top = 40
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
        object orgLabel: TLabel
          Left = 6
          Top = 40
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
        object info_label: TLabel
          Left = 6
          Top = 6
          Width = 368
          Height = 40
          AutoSize = False
          Caption = 'FILLED_IN_BY_FORM_CREATE'
          WordWrap = True
        end
        object Label1: TLabel
          Left = 6
          Top = 85
          Width = 314
          Height = 13
          Caption = 'Note: Only Organizations and Sales Cycles created will be shown.'
        end
        object CycleNumComboBox: TComboBox
          Left = 304
          Top = 56
          Width = 70
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
        end
        object CycleYearComboBox: TComboBox
          Left = 224
          Top = 56
          Width = 69
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
          OnChange = CycleYearComboBoxChange
        end
        object orgCombo: TComboBox
          Left = 6
          Top = 56
          Width = 208
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
          OnChange = orgComboChange
        end
      end
      inherited ToolBar: TToolBar
        Top = 130
        Width = 382
        Align = alBottom
        ExplicitTop = 130
        ExplicitWidth = 382
      end
      inherited StatusBar: TStatusBar
        Top = 184
        Width = 382
        ExplicitTop = 184
        ExplicitWidth = 382
      end
    end
  end
end
