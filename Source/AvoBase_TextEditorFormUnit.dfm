object AvoBaseTextEditor: TAvoBaseTextEditor
  Left = 315
  Top = 99
  BorderStyle = bsNone
  Caption = 'AvoBaseTextEditor'
  ClientHeight = 295
  ClientWidth = 341
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object back_panel: TPanel
    Left = 0
    Top = 36
    Width = 341
    Height = 259
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 255
    ExplicitHeight = 156
    object DBMemo: TRichEdit
      Left = 1
      Top = 1
      Width = 339
      Height = 239
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        '')
      ParentFont = False
      PlainText = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantTabs = True
      OnChange = DBMemoChange
    end
    object StatBar: TStatusBar
      Left = 1
      Top = 240
      Width = 339
      Height = 18
      Color = clCream
      Panels = <
        item
          Text = 'ROW 0000'
          Width = 55
        end
        item
          Text = 'COL 0000'
          Width = 55
        end
        item
          Text = 'LINES: 00000'
          Width = 70
        end
        item
          Text = 'SIZE: 000000 BYTES'
          Width = 105
        end>
      ExplicitTop = 137
      ExplicitWidth = 253
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 341
    Height = 36
    ParentCustomHint = False
    AutoSize = True
    ButtonHeight = 36
    ButtonWidth = 76
    Caption = 'ToolBar1'
    Color = clWhite
    DisabledImages = IMG_StorageForm.Disabl_img_25x25
    DoubleBuffered = False
    EdgeInner = esNone
    EdgeOuter = esNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GradientEndColor = clWhite
    Images = IMG_StorageForm.Avobase_25x25_Images
    ParentColor = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = False
    TabOrder = 1
    Transparent = False
    ExplicitWidth = 255
    object ClearButton: TToolButton
      Left = 0
      Top = 0
      Caption = 'Clear Text'
      ImageIndex = 20
      OnClick = ClearButtonClick
    end
    object LoadButton: TToolButton
      Left = 76
      Top = 0
      Caption = 'Load From File'
      ImageIndex = 26
      OnClick = LoadButtonClick
    end
    object SaveButton: TToolButton
      Left = 152
      Top = 0
      Caption = 'Save To File'
      ImageIndex = 36
      OnClick = SaveButtonClick
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'html'
    Filter = 'Text Files|*.txt'
    Left = 28
    Top = 109
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'html'
    Filter = 'Text Files|*.txt'
    Left = 199
    Top = 58
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 138
    Top = 55
  end
  object HTMLMenu: TPopupMenu
    Left = 84
    Top = 64
    object Cut1: TMenuItem
      Caption = 'Cut'
      OnClick = Cut1Click
    end
    object Copy1: TMenuItem
      Caption = 'Copy'
      OnClick = Copy1Click
    end
    object Paste1: TMenuItem
      Caption = 'Paste'
      OnClick = Paste1Click
    end
  end
  object ColorDialog: TColorDialog
    Left = 21
    Top = 65
  end
  object FindDialog: TFindDialog
    Left = 84
    Top = 108
  end
  object FindReplace: TReplaceDialog
    Left = 138
    Top = 117
  end
end
