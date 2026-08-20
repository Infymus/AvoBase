object ControlForm_Order: TControlForm_Order
  Left = 336
  Top = 22
  Caption = 'ControlForm_Order'
  ClientHeight = 175
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object orderSplitter: TSplitter
    Left = 163
    Top = 0
    Width = 8
    Height = 175
    Beveled = True
    Color = 16773593
    ParentColor = False
    ExplicitHeight = 149
  end
  object MAIN_DOCK_PANEL: TScrollBox
    Left = 171
    Top = 0
    Width = 165
    Height = 175
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BevelKind = bkFlat
    BorderStyle = bsNone
    TabOrder = 0
  end
  object SideBarPanelBackDrop: TPanel
    Left = 0
    Top = 0
    Width = 163
    Height = 175
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = 'No Open Orders'
    Color = clCream
    TabOrder = 1
    object SideBarPanel: TScrollBox
      Left = 3
      Top = 3
      Width = 157
      Height = 169
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clWhite
      ParentColor = False
      TabOrder = 0
    end
  end
  object fSave: TSaveDialog
    Filter = 'PDF|pdf'
    Left = 30
    Top = 114
  end
end
