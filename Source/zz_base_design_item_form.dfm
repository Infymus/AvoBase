object Form2: TForm2
  Left = 316
  Top = 30
  Caption = 'Form2'
  ClientHeight = 690
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 240
    Top = 36
    Width = 145
    Height = 91
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Query1: TQuery
    Left = 333
    Top = 489
  end
  object DataSource1: TDataSource
    Left = 156
    Top = 291
  end
end
