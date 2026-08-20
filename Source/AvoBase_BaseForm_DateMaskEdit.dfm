object AvoDateEdit: TAvoDateEdit
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'AvoDateEdit'
  ClientHeight = 194
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object back_panel: TPanel
    Left = 0
    Top = 0
    Width = 93
    Height = 33
    BevelOuter = bvNone
    TabOrder = 0
    object labelDate: TLabel
      Left = 0
      Top = 0
      Width = 50
      Height = 13
      Caption = 'Start Date'
    end
    object sDateEdit: TMaskEdit
      Left = 0
      Top = 13
      Width = 82
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
    end
    object sDatePicker: TDateTimePicker
      Left = 81
      Top = 13
      Width = 12
      Height = 21
      Date = 40205.558589409720000000
      Time = 40205.558589409720000000
      TabOrder = 1
    end
  end
  object DateTimePicker1: TDateTimePicker
    Left = 55
    Top = 71
    Width = 96
    Height = 19
    Date = 40904.351171550920000000
    Time = 40904.351171550920000000
    MinDate = 40179.000000000000000000
    TabOrder = 1
  end
end
