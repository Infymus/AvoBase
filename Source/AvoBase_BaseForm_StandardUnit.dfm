object Avobase_BaseForm_Standard: TAvobase_BaseForm_Standard
  Left = 231
  Top = 175
  Caption = 'Avobase_BaseForm_Standard'
  ClientHeight = 462
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object BASE_TOP_CAPTION_PANEL: TPanel
    Left = 0
    Top = 0
    Width = 300
    Height = 23
    Align = alTop
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    object BASE_FORM_LABEL: TLabel
      Left = 9
      Top = 1
      Width = 175
      Height = 21
      Align = alLeft
      Caption = 'BASE_FORM_LABEL'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      ExplicitHeight = 18
    end
    object BASE_TOP_SEP_PANEL: TPanel
      Left = 1
      Top = 1
      Width = 8
      Height = 21
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 441
    Width = 300
    Height = 21
    Panels = <
      item
        Width = 150
      end>
  end
end
