object AvoBase_CodeTextEditor: TAvoBase_CodeTextEditor
  Left = 0
  Top = 0
  Align = alLeft
  Caption = 'AvoBase_CodeTextEditor'
  ClientHeight = 630
  ClientWidth = 714
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MenuToolBar: TToolBar
    Left = 148
    Top = 0
    Width = 54
    Height = 630
    Align = alLeft
    AutoSize = True
    ButtonHeight = 50
    ButtonWidth = 54
    Caption = 'MenuToolBar'
    Color = clWhite
    EdgeInner = esNone
    EdgeOuter = esNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GradientEndColor = clWhite
    HotTrackColor = clWhite
    Images = IMG_StorageForm.Avobase_ToolBar_Img
    ParentColor = False
    ParentFont = False
    ShowCaptions = True
    TabOrder = 0
    Transparent = True
    ExplicitHeight = 612
    object ClearButton: TToolButton
      Left = 0
      Top = 0
      Caption = 'Clear'
      ImageIndex = 16
      Wrap = True
    end
    object LoadButton: TToolButton
      Left = 0
      Top = 50
      Caption = 'Load'
      ImageIndex = 44
      Wrap = True
    end
    object saveButton: TToolButton
      Left = 0
      Top = 100
      Caption = 'Save'
      ImageIndex = 2
      Wrap = True
    end
    object addCodeButton: TToolButton
      Left = 0
      Top = 150
      Caption = 'Add Code'
      ImageIndex = 51
      OnClick = addCodeButtonClick
    end
  end
  object BACK_PANEL: TPanel
    Left = 202
    Top = 0
    Width = 512
    Height = 630
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    ParentBackground = False
    TabOrder = 1
    ExplicitHeight = 612
    object DBMemo: TMemo
      Left = 1
      Top = 1
      Width = 510
      Height = 610
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 16250871
      Lines.Strings = (
        'DBMemo')
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = -50
    end
    object StatBar: TStatusBar
      Left = 1
      Top = 611
      Width = 510
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
      ExplicitTop = 610
    end
  end
  object CodeBoxBackPanel: TPanel
    Left = 0
    Top = 0
    Width = 148
    Height = 630
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 4
    Caption = 'CodeBoxBackPanel'
    TabOrder = 2
    ExplicitHeight = 612
    object CodeBox: TListBox
      Left = 4
      Top = 4
      Width = 140
      Height = 622
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 16
      TabOrder = 0
      OnDblClick = CodeBoxDblClick
      ExplicitHeight = 604
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'html'
    Filter = 'Text Files|*.txt'
    Left = 322
    Top = 313
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'html'
    Filter = 'Text Files|*.txt'
    Left = 322
    Top = 265
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 321
    Top = 214
  end
  object HTMLMenu: TPopupMenu
    Left = 213
    Top = 151
    object Cut1: TMenuItem
      Caption = 'Cut'
    end
    object Copy1: TMenuItem
      Caption = 'Copy'
    end
    object Paste1: TMenuItem
      Caption = 'Paste'
    end
  end
  object ColorDialog: TColorDialog
    Left = 321
    Top = 167
  end
  object FindDialog: TFindDialog
    Left = 213
    Top = 204
  end
  object FindReplace: TReplaceDialog
    Left = 213
    Top = 258
  end
end
