object Avobase_BaseForm_List: TAvobase_BaseForm_List
  Left = 300
  Top = 12
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Avobase_BaseForm_List'
  ClientHeight = 415
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object border_panel: TPanel
    Left = 0
    Top = 0
    Width = 665
    Height = 415
    Align = alClient
    BevelOuter = bvNone
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 586
    ExplicitHeight = 369
    object BASE_TOP_CAPTION_PANEL: TPanel
      Left = 0
      Top = 0
      Width = 665
      Height = 20
      Align = alTop
      Color = clGray
      ParentBackground = False
      TabOrder = 0
      ExplicitWidth = 586
      object BASE_FORM_LABEL: TLabel
        Left = 9
        Top = 1
        Width = 655
        Height = 18
        Align = alClient
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
        ExplicitWidth = 175
      end
      object BASE_TOP_SEP_PANEL: TPanel
        Left = 1
        Top = 1
        Width = 8
        Height = 18
        Align = alLeft
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
      end
    end
    object StatusBar: TStatusBar
      Left = 0
      Top = 394
      Width = 665
      Height = 21
      Panels = <
        item
          Width = 150
        end>
      ExplicitTop = 348
      ExplicitWidth = 586
    end
    object BASE_NAVBAR_PANEL: TPanel
      Left = 0
      Top = 20
      Width = 665
      Height = 56
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      ExplicitWidth = 586
      object BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 513
        Top = 0
        Width = 152
        Height = 56
        Align = alRight
        BevelOuter = bvNone
        Caption = 'BASE_NAVBAR_DOCK_PANEL'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        ExplicitLeft = 434
      end
    end
    object BASE_LIST_DOCK_PANEL: TPanel
      Left = 0
      Top = 76
      Width = 665
      Height = 318
      Align = alClient
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      Caption = 'BASE_LIST_DOCK_PANEL'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      ExplicitWidth = 586
      ExplicitHeight = 272
    end
  end
end
