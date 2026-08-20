object Form1: TForm1
  Left = 300
  Top = 86
  Caption = 'Form1'
  ClientHeight = 590
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar3: TToolBar
    Left = 0
    Top = 0
    Width = 719
    Height = 50
    AutoSize = True
    ButtonHeight = 50
    ButtonWidth = 56
    Caption = 'ToolBar3'
    DisabledImages = IMG_StorageForm.Disable_Img
    Images = IMG_StorageForm.Avobase_ToolBar_Img
    ShowCaptions = True
    TabOrder = 0
    object DbFirstButton: TToolButton
      Left = 0
      Top = 0
      Hint = 'First'
      Caption = 'First'
      ImageIndex = 50
    end
    object DbPriorButton: TToolButton
      Left = 56
      Top = 0
      Hint = 'Prior'
      Caption = 'Prior'
      ImageIndex = 52
    end
    object dbNextButton: TToolButton
      Left = 112
      Top = 0
      Hint = 'Next'
      Caption = 'Next'
      ImageIndex = 51
    end
    object dbLastButton: TToolButton
      Left = 168
      Top = 0
      Hint = 'Last'
      Caption = 'Last Thing'
      ImageIndex = 49
    end
  end
  object DBGrid1: TDBGrid
    Left = 215
    Top = 63
    Width = 475
    Height = 250
    Color = clWhite
    FixedColor = clOlive
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        Title.Caption = 'WonkaWonka'
        Title.Color = clGray
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end>
  end
  object navActionList: TActionList
    Left = 63
    Top = 87
  end
  object PopupMenu1: TPopupMenu
    Left = 252
    Top = 219
    object HiThere1: TMenuItem
      Caption = 'Hi There'
    end
  end
end
